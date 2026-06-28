# Fullstack Assessment — NestJS Backend

## Setup

```bash
cp .env.example .env   # fill in DB credentials
npm install
npm run start:dev
```

Seed the database:
```bash
psql -U assessment_user -d fullstack_assessment < scripts/dummy-data.sql
```

All endpoints require the `x-api-key` header (value from `API_KEY` in `.env`).

---

## Database Schema

### Design decisions

- **Price and stock live on `product_colors`, not `products`.**  
  Each product variant (color) has its own price and stock count. There is no aggregate stock on the product level — the listing page queries `product_colors` directly, one card per variant.

- **One order = one product-color variant.**  
  `orders.totalItems` is always 1. `order_items` exists as a normalised join so the schema stays extensible, but currently each order has exactly one row in `order_items`.

- **FCFS ordering is enforced in the DB.**  
  `PATCH /order/:id/complete` acquires a `SELECT FOR UPDATE` lock on the `orders` row (without joins, to avoid the Postgres outer-join restriction), then separately locks the `product_colors` row before decrementing stock. Concurrent completions queue at the DB level.

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
| brandId | uuid FK → brands | CASCADE delete |
| categoryId | uuid FK → categories | RESTRICT delete |

#### `product_colors` *(variant rows — one per product × color)*
| column | type | notes |
|---|---|---|
| id | uuid PK | |
| productId | uuid FK → products | CASCADE delete |
| colorId | uuid FK → colors | RESTRICT delete |
| price | decimal(10,2) | variant price |
| stock | integer | decremented on order complete |

#### `orders`
| column | type | notes |
|---|---|---|
| id | uuid PK | |
| orderNumber | varchar(50) | unique, human-readable e.g. `ORD-1234-AB12` |
| clientId | varchar(36) | UUID string, indexed |
| status | enum | `pending` \| `completed` |
| totalAmount | decimal(10,2) | snapshot of price at order time |
| totalItems | integer | always 1 in current design |

#### `order_items`
| column | type | notes |
|---|---|---|
| id | uuid PK | |
| orderId | uuid FK → orders | CASCADE delete |
| productId | uuid FK → products | |
| productColorId | uuid FK → product_colors | RESTRICT delete, nullable |

---

### Entity relationship

```
categories ←──── brand_categories ────→ brands
                                           │
                                        products
                                           │
                              product_colors (price, stock)
                                     ↑         ↑
                              colorId       productId
                              (colors)
                                    
orders ──── order_items ──→ products
                    └──→ product_colors
```

---

## API

All responses are wrapped:
```json
{ "success": true, "data": { ... }, "timestamp": "..." }
```

### Products

| method | path | description |
|---|---|---|
| GET | `/products` | list product-color variants (paginated) |
| GET | `/products/filters/categories` | distinct categories |
| GET | `/products/filters/brands` | brands, optionally filtered by `?categoryId=` |
| GET | `/products/filters/colors` | distinct colors |

`GET /products` query params: `name`, `categoryId`, `brandId`, `color` (colorId), `limit` (default 10), `offset` (default 0).

Response item shape:
```json
{
  "productColorId": "uuid",
  "productId": "uuid",
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

| method | path | headers | description |
|---|---|---|---|
| POST | `/order` | `x-client-id` not needed (in body) | place order |
| GET | `/order` | `x-client-id: <uuid>` | list client's orders (paginated) |
| PATCH | `/order/:id/complete` | — | complete order, decrement stock |

`POST /order` body:
```json
{ "productColorId": "uuid", "clientId": "uuid" }
```

`GET /order` response item:
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
x-api-key: <value from API_KEY env var>
```

CORS allowed origins are set via `ALLOWED_ORIGINS` (comma-separated) in `.env`.

---

## Test client IDs (from seed data)

```
clientId A: aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa  (5 sample orders)
clientId B: bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb  (5 sample orders)
```
