# Fullstack Assessment — NestJS Backend

## Setup

```bash
npm install
npm run start:dev
```

Seed the database (after first boot creates schema):

```bash
# local (no SSL)
psql -U assessment_user -d fullstack_assessment < scripts/dummy-data.sql

# cloud / prod (SSL)
PGSSLMODE=require psql -h <host> -U <user> -d fullstack_assessment < scripts/dummy-data.sql
```

All endpoints require the `x-api-key` header (value from `API_KEY` in `.env`).

---

## Environment Variables

| variable | description |
|---|---|
| `POSTGRES_HOST` | DB host |
| `POSTGRES_PORT` | DB port (default 5432) |
| `POSTGRES_USER` | DB username |
| `POSTGRES_PASSWORD` | DB password |
| `POSTGRES_DATABASE` | DB name |
| `PORT` | API port (default 3000) |
| `MODE` | `DEV` = local (no SSL, schema auto-sync); anything else = prod (SSL enabled) |
| `API_KEY` | Required header value for all requests |
| `ALLOWED_ORIGINS` | Comma-separated CORS origins e.g. `http://localhost:5173` |

---

## Database Schema

### Design Decisions

- **Products link to `brand_categories`, not directly to brands or categories.**  
  A single FK (`brandCategoryId`) enforces that every product has both a valid brand and a valid category. Brand/category filters in the listing query both resolve through this join.

- **Price, stock, and productCode live on `product_colors`, not `products`.**  
  Each variant (color) has its own price, stock, and code (e.g. `P001-BLK`). The listing page queries `product_colors` directly — one card per variant.

- **One order = one product-color variant.**  
  Each order has exactly one `order_items` row with only `productColorId` — product is resolved via `product_colors.productId`, no redundant FK on `order_items`.

- **FCFS stock control via DB-level locking.**  
  `PATCH /order/:id/complete` uses `SELECT FOR UPDATE` (via `createQueryBuilder` to avoid the Postgres outer-join restriction), locks the `product_colors` row, checks stock ≥ 1, then decrements. Concurrent requests queue at the DB.

---

### Tables

#### `categories`
| column | type | notes |
|---|---|---|
| id | uuid PK | |
| name | varchar(255) | unique |
| description | text | nullable |

#### `brands`
| column | type | notes |
|---|---|---|
| id | uuid PK | |
| name | varchar(255) | |
| description | text | nullable |
| logoUrl | varchar(255) | nullable |

#### `brand_categories` *(junction)*
| column | type | notes |
|---|---|---|
| id | uuid PK | |
| brandId | uuid FK → brands | CASCADE delete |
| categoryId | uuid FK → categories | CASCADE delete |
| | | unique composite `(brandId, categoryId)` |

#### `colors`
| column | type | notes |
|---|---|---|
| id | uuid PK | |
| name | varchar(100) | indexed |
| colorCode | varchar(7) | e.g. `#4A90E2` |

#### `products`
| column | type | notes |
|---|---|---|
| id | uuid PK | |
| name | varchar(255) | indexed |
| description | text | nullable |
| imageUrl | varchar(255) | nullable |
| brandCategoryId | uuid FK → brand_categories | RESTRICT delete, indexed |

Products link to `brand_categories` (not directly to brands/categories), so every product is guaranteed to have both a valid brand and category.

#### `product_colors` *(one row per product × color variant)*
| column | type | notes |
|---|---|---|
| id | uuid PK | |
| productCode | varchar(20) | unique e.g. `P001-BLK` |
| productId | uuid FK → products | CASCADE delete |
| colorId | uuid FK → colors | RESTRICT delete |
| price | decimal(10,2) | variant price |
| stock | integer | decremented on order complete |
| | | unique composite `(productId, colorId)` |

#### `orders`
| column | type | notes |
|---|---|---|
| id | uuid PK | |
| orderNumber | varchar(50) | unique e.g. `ORD-1234-AB12` |
| clientId | varchar(36) | composite index with `createdAt` |
| status | enum | `pending` \| `completed`, indexed |
| totalAmount | decimal(10,2) | price snapshot at order time |
| totalItems | integer | always 1 |
| createdAt | timestamp | used for FCFS ordering |

#### `order_items`
| column | type | notes |
|---|---|---|
| id | uuid PK | |
| orderId | uuid FK → orders | CASCADE delete, indexed |
| productColorId | uuid FK → product_colors | RESTRICT delete, indexed, nullable |

---

### Entity Relationship

```
categories ←── brand_categories ──→ brands
                       │
                    products
                       │
          product_colors (productCode, price, stock)
               ↑              ↑
           colorId        productId
           (colors)

orders ──── order_items ──→ product_colors
```

---

## API

All responses wrapped:
```json
{ "success": true, "data": { ... }, "timestamp": "..." }
```

### Products

| method | path | description |
|---|---|---|
| GET | `/products` | list product-color variants, paginated |
| GET | `/products/filters/categories` | all categories |
| GET | `/products/filters/brands` | brands, optionally `?categoryId=` |
| GET | `/products/filters/colors` | all colors |

**`GET /products` query params**

| param | type | description |
|---|---|---|
| `name` | string | partial match (case-insensitive) |
| `categoryId` | uuid | filter by category |
| `brandId` | uuid | filter by brand |
| `color` | uuid | filter by colorId |
| `limit` | number | default 10, max 100 |
| `offset` | number | default 0 |

**Response item:**
```json
{
  "productColorId": "uuid",
  "productId": "uuid",
  "productCode": "P0001-001",
  "name": "iPhone 15 Pro (Black)",
  "price": 999.99,
  "imageUrl": "https://...",
  "stock": 30,
  "brandId": "uuid",
  "brandName": "Apple",
  "categoryId": "uuid",
  "categoryName": "Smartphones"
}
```

### Orders

| method | path | header | description |
|---|---|---|---|
| POST | `/order` | — | place order |
| GET | `/order` | `x-client-id: <uuid>` | list client's orders, paginated |
| PATCH | `/order/:id/complete` | — | complete order, decrement stock |

**`POST /order` body:**
```json
{ "productColorId": "uuid", "clientId": "uuid" }
```

**`GET /order` query params:** `limit`, `offset`

**`GET /order` response item:**
```json
{
  "id": "uuid",
  "orderId": "ORD-1234-AB12",
  "productId": "uuid",
  "productName": "iPhone 15 Pro",
  "productColor": "Black",
  "currentStock": 29,
  "status": "pending",
  "createdAt": "2026-06-28T..."
}
```

---

## Auth

Every request requires:
```
x-api-key: <API_KEY value>
```

---

## Seed Data Client IDs

```
clientId A: aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa  (5 sample orders)
clientId B: bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb  (5 sample orders)
```
