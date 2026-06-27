-- =====================================================
-- DUMMY DATA - SQL INSERT STATEMENTS
-- =====================================================
-- psql -U assessment_user -d fullstack_assessment < dummy-data.sql

-- =====================================================
-- 1. CATEGORIES (5)
-- =====================================================
INSERT INTO categories (id, name, description, "createdAt", "updatedAt") VALUES
('f47ac10b-58cc-4372-a567-0e02b2c3d479', 'Smartphones', 'Latest mobile phones and smartphones', NOW(), NOW()),
('f47ac10b-58cc-4372-a567-0e02b2c3d480', 'Tablets',     'Tablet devices and iPad alternatives',  NOW(), NOW()),
('f47ac10b-58cc-4372-a567-0e02b2c3d481', 'Laptops',     'Laptop computers and notebooks',        NOW(), NOW()),
('f47ac10b-58cc-4372-a567-0e02b2c3d482', 'Accessories', 'Phone cases, chargers, and accessories',NOW(), NOW()),
('f47ac10b-58cc-4372-a567-0e02b2c3d483', 'Wearables',   'Smartwatches and fitness trackers',     NOW(), NOW())
ON CONFLICT DO NOTHING;

-- =====================================================
-- 2. BRANDS (7) — no categoryId column; categories via junction table
-- =====================================================
INSERT INTO brands (id, name, description, "logoUrl", "createdAt", "updatedAt") VALUES
('a47ac10b-58cc-4372-a567-0e02b2c3d479', 'Apple',   'Premium mobile and tech products',  'https://www.google.com/s2/favicons?sz=128&domain=apple.com',   NOW(), NOW()),
('a47ac10b-58cc-4372-a567-0e02b2c3d480', 'Samsung', 'Electronics and mobile devices',     'https://www.google.com/s2/favicons?sz=128&domain=samsung.com', NOW(), NOW()),
('a47ac10b-58cc-4372-a567-0e02b2c3d481', 'Google',  'Pixel phones and services',          'https://www.google.com/s2/favicons?sz=128&domain=google.com',  NOW(), NOW()),
('a47ac10b-58cc-4372-a567-0e02b2c3d482', 'Xiaomi',  'Budget-friendly smartphones',        'https://www.google.com/s2/favicons?sz=128&domain=mi.com',      NOW(), NOW()),
('a47ac10b-58cc-4372-a567-0e02b2c3d483', 'OnePlus', 'High-performance affordable phones', 'https://www.google.com/s2/favicons?sz=128&domain=oneplus.com', NOW(), NOW()),
('a47ac10b-58cc-4372-a567-0e02b2c3d487', 'Dell',    'Dell computers',                     'https://www.google.com/s2/favicons?sz=128&domain=dell.com',    NOW(), NOW()),
('a47ac10b-58cc-4372-a567-0e02b2c3d488', 'HP',      'HP computers',                       'https://www.google.com/s2/favicons?sz=128&domain=hp.com',      NOW(), NOW())
ON CONFLICT DO NOTHING;

-- =====================================================
-- 2b. BRAND_CATEGORIES junction
-- =====================================================
INSERT INTO brand_categories ("brandId", "categoryId") VALUES
-- Apple: Smartphones + Tablets + Laptops
('a47ac10b-58cc-4372-a567-0e02b2c3d479', 'f47ac10b-58cc-4372-a567-0e02b2c3d479'),
('a47ac10b-58cc-4372-a567-0e02b2c3d479', 'f47ac10b-58cc-4372-a567-0e02b2c3d480'),
('a47ac10b-58cc-4372-a567-0e02b2c3d479', 'f47ac10b-58cc-4372-a567-0e02b2c3d481'),
-- Samsung: Smartphones + Tablets
('a47ac10b-58cc-4372-a567-0e02b2c3d480', 'f47ac10b-58cc-4372-a567-0e02b2c3d479'),
('a47ac10b-58cc-4372-a567-0e02b2c3d480', 'f47ac10b-58cc-4372-a567-0e02b2c3d480'),
-- Google: Smartphones
('a47ac10b-58cc-4372-a567-0e02b2c3d481', 'f47ac10b-58cc-4372-a567-0e02b2c3d479'),
-- Xiaomi: Smartphones
('a47ac10b-58cc-4372-a567-0e02b2c3d482', 'f47ac10b-58cc-4372-a567-0e02b2c3d479'),
-- OnePlus: Smartphones
('a47ac10b-58cc-4372-a567-0e02b2c3d483', 'f47ac10b-58cc-4372-a567-0e02b2c3d479'),
-- Dell: Laptops
('a47ac10b-58cc-4372-a567-0e02b2c3d487', 'f47ac10b-58cc-4372-a567-0e02b2c3d481'),
-- HP: Laptops
('a47ac10b-58cc-4372-a567-0e02b2c3d488', 'f47ac10b-58cc-4372-a567-0e02b2c3d481')
ON CONFLICT DO NOTHING;

-- =====================================================
-- 3. PRODUCTS (15) — totalStock = sum of color stocks
-- =====================================================
INSERT INTO products (id, name, description, "imageUrl", "basePrice", "totalStock", "brandId", "createdAt", "updatedAt") VALUES
('b47ac10b-58cc-4372-a567-0e02b2c3d479', 'iPhone 15 Pro',   'Latest iPhone with A17 Pro chip',        'https://placehold.co/300x400?text=iPhone+15+Pro',   999.99,  90,  'a47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d480', 'iPhone 15',       'Affordable flagship iPhone',             'https://placehold.co/300x400?text=iPhone+15',       799.99,  130, 'a47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d481', 'iPhone 14',       'Previous generation iPhone',             'https://placehold.co/300x400?text=iPhone+14',       699.99,  180, 'a47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d482', 'Galaxy S24 Ultra','Premium flagship Android phone',         'https://placehold.co/300x400?text=Galaxy+S24+Ultra',1299.99, 70,  'a47ac10b-58cc-4372-a567-0e02b2c3d480', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d483', 'Galaxy S24',      'Flagship Samsung phone',                 'https://placehold.co/300x400?text=Galaxy+S24',      999.99,  120, 'a47ac10b-58cc-4372-a567-0e02b2c3d480', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d484', 'Pixel 8 Pro',     'Premium Google phone with AI features',  'https://placehold.co/300x400?text=Pixel+8+Pro',     899.99,  53,  'a47ac10b-58cc-4372-a567-0e02b2c3d481', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d485', 'Pixel 8',         'Affordable Google Pixel phone',          'https://placehold.co/300x400?text=Pixel+8',         699.99,  110, 'a47ac10b-58cc-4372-a567-0e02b2c3d481', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d486', 'Xiaomi 14 Ultra', 'High-end Xiaomi with excellent camera',  'https://placehold.co/300x400?text=Xiaomi+14+Ultra', 649.99,  90,  'a47ac10b-58cc-4372-a567-0e02b2c3d482', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d487', 'Xiaomi 14',       'Mid-range Xiaomi smartphone',            'https://placehold.co/300x400?text=Xiaomi+14',       449.99,  160, 'a47ac10b-58cc-4372-a567-0e02b2c3d482', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d488', 'OnePlus 12',      'Fast and reliable OnePlus phone',        'https://placehold.co/300x400?text=OnePlus+12',      799.99,  130, 'a47ac10b-58cc-4372-a567-0e02b2c3d483', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d489', 'iPad Pro 12.9"',  'Premium Apple tablet with M2 chip',      'https://placehold.co/300x400?text=iPad+Pro',        1099.99, 70,  'a47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d490', 'iPad Air',        'Mid-range Apple tablet',                 'https://placehold.co/300x400?text=iPad+Air',        599.99,  100, 'a47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d491', 'Galaxy Tab S9',   'Premium Samsung tablet',                 'https://placehold.co/300x400?text=Galaxy+Tab+S9',   799.99,  37,  'a47ac10b-58cc-4372-a567-0e02b2c3d480', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d492', 'MacBook Pro 16"', 'Premium Apple laptop',                   'https://placehold.co/300x400?text=MacBook+Pro+16',  2499.99, 37,  'a47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d493', 'Dell XPS 15',     'High-performance Dell laptop',           'https://placehold.co/300x400?text=Dell+XPS+15',     1699.99, 60,  'a47ac10b-58cc-4372-a567-0e02b2c3d487', NOW(), NOW())
ON CONFLICT DO NOTHING;

-- =====================================================
-- 4. PRODUCT COLORS — every product has colors
--    totalStock per product = sum of color stocks
-- =====================================================
INSERT INTO product_colors (id, name, "colorCode", stock, price, "productId", "createdAt", "updatedAt") VALUES
-- iPhone 15 Pro (total=90)
('c47ac10b-58cc-4372-a567-0e02b2c3d479', 'Titanium Black',   '#1C1C1C', 30, 999.99,  'b47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d480', 'Titanium Silver',  '#C0C0C0', 25, 999.99,  'b47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d481', 'Titanium Gold',    '#FFD700', 20, 1049.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d482', 'Titanium Natural', '#D4AF37', 15, 999.99,  'b47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
-- iPhone 15 (total=130)
('c47ac10b-58cc-4372-a567-0e02b2c3d483', 'Black',  '#000000', 40, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d480', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d484', 'Blue',   '#4A90E2', 35, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d480', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d485', 'Pink',   '#FF69B4', 30, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d480', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d486', 'Yellow', '#FFD60A', 25, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d480', NOW(), NOW()),
-- iPhone 14 (total=180)
('c47ac10b-58cc-4372-a567-0e02b2c3d507', 'Midnight',  '#191970', 45, 699.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d481', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d508', 'Purple',    '#7B2FBE', 45, 699.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d481', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d509', 'Blue',      '#4A90E2', 45, 699.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d481', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d510', 'Starlight', '#E8E4D9', 45, 699.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d481', NOW(), NOW()),
-- Galaxy S24 Ultra (total=70)
('c47ac10b-58cc-4372-a567-0e02b2c3d487', 'Phantom Black',  '#1C1C1C', 25, 1299.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d482', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d488', 'Phantom Silver', '#E5E5E5', 20, 1299.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d482', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d489', 'Amber Gold',     '#D4A574', 15, 1299.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d482', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d490', 'Violet',         '#800080', 10, 1349.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d482', NOW(), NOW()),
-- Galaxy S24 (total=120)
('c47ac10b-58cc-4372-a567-0e02b2c3d511', 'Onyx Black',    '#0D0D0D', 30, 999.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d483', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d512', 'Marble Gray',   '#808080', 30, 999.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d483', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d513', 'Cobalt Violet', '#8A2BE2', 30, 999.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d483', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d514', 'Lime',          '#A8D400', 30, 999.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d483', NOW(), NOW()),
-- Pixel 8 Pro (total=53)
('c47ac10b-58cc-4372-a567-0e02b2c3d491', 'Obsidian',  '#1C1C1C', 20, 899.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d484', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d492', 'Porcelain', '#E8E8E8', 18, 899.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d484', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d493', 'Bay',       '#4A90E2', 15, 899.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d484', NOW(), NOW()),
-- Pixel 8 (total=110)
('c47ac10b-58cc-4372-a567-0e02b2c3d515', 'Obsidian', '#1C1C1C', 40, 699.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d485', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d516', 'Hazel',    '#7B6E47', 35, 699.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d485', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d517', 'Rose',     '#B76E79', 35, 699.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d485', NOW(), NOW()),
-- Xiaomi 14 Ultra (total=90)
('c47ac10b-58cc-4372-a567-0e02b2c3d494', 'Pearl White',    '#FDEEF4', 35, 649.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d486', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d495', 'Midnight Black', '#191970', 30, 649.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d486', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d496', 'Ocean Blue',     '#006994', 25, 649.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d486', NOW(), NOW()),
-- Xiaomi 14 (total=160)
('c47ac10b-58cc-4372-a567-0e02b2c3d518', 'Black',  '#000000', 40, 449.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d487', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d519', 'White',  '#FFFFFF', 40, 449.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d487', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d520', 'Green',  '#228B22', 40, 449.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d487', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d521', 'Silver', '#C0C0C0', 40, 449.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d487', NOW(), NOW()),
-- OnePlus 12 (total=130)
('c47ac10b-58cc-4372-a567-0e02b2c3d522', 'Silky Black',     '#1C1C1C', 45, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d488', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d523', 'Flowy Emerald',   '#50C878', 45, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d488', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d524', 'Glacial White',   '#F0F8FF', 40, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d488', NOW(), NOW()),
-- iPad Pro (total=70)
('c47ac10b-58cc-4372-a567-0e02b2c3d497', 'Space Gray', '#505050', 25, 1099.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d489', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d498', 'Silver',     '#C0C0C0', 20, 1099.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d489', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d499', 'Gold',       '#FFD700', 15, 1149.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d489', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d500', 'Rose Gold',  '#B76E79', 10, 1149.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d489', NOW(), NOW()),
-- iPad Air (total=100)
('c47ac10b-58cc-4372-a567-0e02b2c3d525', 'Blue',       '#4A90E2', 25, 599.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d490', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d526', 'Purple',     '#9B59B6', 25, 599.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d490', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d527', 'Starlight',  '#E8E4D9', 25, 599.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d490', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d528', 'Space Gray', '#505050', 25, 599.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d490', NOW(), NOW()),
-- Galaxy Tab S9 (total=37)
('c47ac10b-58cc-4372-a567-0e02b2c3d501', 'Graphite', '#383838', 15, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d491', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d502', 'Silver',   '#C0C0C0', 12, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d491', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d503', 'Cream',    '#FFF8DC', 10, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d491', NOW(), NOW()),
-- MacBook Pro (total=37)
('c47ac10b-58cc-4372-a567-0e02b2c3d504', 'Space Black', '#1C1C1C', 15, 2499.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d492', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d505', 'Silver',      '#C0C0C0', 12, 2499.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d492', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d506', 'Midnight',    '#191970', 10, 2499.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d492', NOW(), NOW()),
-- Dell XPS 15 (total=60)
('c47ac10b-58cc-4372-a567-0e02b2c3d529', 'Platinum Silver', '#A0A0A0', 30, 1699.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d493', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d530', 'Frost',          '#F0F0F0', 30, 1699.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d493', NOW(), NOW())
ON CONFLICT DO NOTHING;

-- =====================================================
-- 5. ORDERS (10 sample orders, 2 clientIds)
-- clientId A = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa' (5 orders)
-- clientId B = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb' (5 orders)
-- =====================================================
INSERT INTO orders (id, "orderNumber", "clientId", status, "totalAmount", "totalItems", "createdAt", "updatedAt", "deliveredAt") VALUES
('d47ac10b-58cc-4372-a567-0e02b2c3d479', 'MY000001', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'delivered', 999.99,  1, NOW() - INTERVAL '30 days', NOW() - INTERVAL '30 days', NOW() - INTERVAL '25 days'),
('d47ac10b-58cc-4372-a567-0e02b2c3d480', 'MY000002', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'delivered', 799.99,  1, NOW() - INTERVAL '20 days', NOW() - INTERVAL '20 days', NOW() - INTERVAL '15 days'),
('d47ac10b-58cc-4372-a567-0e02b2c3d481', 'MY000003', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'pending',   1299.99, 1, NOW() - INTERVAL '10 days', NOW() - INTERVAL '10 days', NULL),
('d47ac10b-58cc-4372-a567-0e02b2c3d482', 'MY000004', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'pending',   649.99,  1, NOW() - INTERVAL '5 days',  NOW() - INTERVAL '5 days',  NULL),
('d47ac10b-58cc-4372-a567-0e02b2c3d483', 'MY000005', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'pending',   2499.99, 1, NOW() - INTERVAL '2 days',  NOW() - INTERVAL '2 days',  NULL),
('d47ac10b-58cc-4372-a567-0e02b2c3d484', 'MY000006', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'delivered', 899.99,  1, NOW() - INTERVAL '25 days', NOW() - INTERVAL '25 days', NOW() - INTERVAL '20 days'),
('d47ac10b-58cc-4372-a567-0e02b2c3d485', 'MY000007', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'delivered', 1699.99, 1, NOW() - INTERVAL '18 days', NOW() - INTERVAL '18 days', NOW() - INTERVAL '12 days'),
('d47ac10b-58cc-4372-a567-0e02b2c3d486', 'MY000008', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'delivered', 799.99,  1, NOW() - INTERVAL '12 days', NOW() - INTERVAL '12 days', NOW() - INTERVAL '7 days'),
('d47ac10b-58cc-4372-a567-0e02b2c3d487', 'MY000009', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'pending',   449.99,  1, NOW() - INTERVAL '4 days',  NOW() - INTERVAL '4 days',  NULL),
('d47ac10b-58cc-4372-a567-0e02b2c3d488', 'MY000010', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'pending',   999.99,  1, NOW() - INTERVAL '1 day',   NOW() - INTERVAL '1 day',   NULL)
ON CONFLICT DO NOTHING;

-- =====================================================
-- 6. ORDER ITEMS — productColorId FK to product_colors
-- =====================================================
INSERT INTO order_items (id, "orderId", "productId", "productColorId") VALUES
('e47ac10b-58cc-4372-a567-0e02b2c3d479', 'd47ac10b-58cc-4372-a567-0e02b2c3d479', 'b47ac10b-58cc-4372-a567-0e02b2c3d479', 'c47ac10b-58cc-4372-a567-0e02b2c3d479'),  -- iPhone 15 Pro / Titanium Black
('e47ac10b-58cc-4372-a567-0e02b2c3d480', 'd47ac10b-58cc-4372-a567-0e02b2c3d480', 'b47ac10b-58cc-4372-a567-0e02b2c3d480', 'c47ac10b-58cc-4372-a567-0e02b2c3d484'),  -- iPhone 15 / Blue
('e47ac10b-58cc-4372-a567-0e02b2c3d481', 'd47ac10b-58cc-4372-a567-0e02b2c3d481', 'b47ac10b-58cc-4372-a567-0e02b2c3d482', 'c47ac10b-58cc-4372-a567-0e02b2c3d487'),  -- Galaxy S24 Ultra / Phantom Black
('e47ac10b-58cc-4372-a567-0e02b2c3d482', 'd47ac10b-58cc-4372-a567-0e02b2c3d482', 'b47ac10b-58cc-4372-a567-0e02b2c3d486', 'c47ac10b-58cc-4372-a567-0e02b2c3d494'),  -- Xiaomi 14 Ultra / Pearl White
('e47ac10b-58cc-4372-a567-0e02b2c3d483', 'd47ac10b-58cc-4372-a567-0e02b2c3d483', 'b47ac10b-58cc-4372-a567-0e02b2c3d492', 'c47ac10b-58cc-4372-a567-0e02b2c3d504'),  -- MacBook Pro / Space Black
('e47ac10b-58cc-4372-a567-0e02b2c3d484', 'd47ac10b-58cc-4372-a567-0e02b2c3d484', 'b47ac10b-58cc-4372-a567-0e02b2c3d484', 'c47ac10b-58cc-4372-a567-0e02b2c3d491'),  -- Pixel 8 Pro / Obsidian
('e47ac10b-58cc-4372-a567-0e02b2c3d485', 'd47ac10b-58cc-4372-a567-0e02b2c3d485', 'b47ac10b-58cc-4372-a567-0e02b2c3d493', 'c47ac10b-58cc-4372-a567-0e02b2c3d529'),  -- Dell XPS 15 / Platinum Silver
('e47ac10b-58cc-4372-a567-0e02b2c3d486', 'd47ac10b-58cc-4372-a567-0e02b2c3d486', 'b47ac10b-58cc-4372-a567-0e02b2c3d488', 'c47ac10b-58cc-4372-a567-0e02b2c3d522'),  -- OnePlus 12 / Silky Black
('e47ac10b-58cc-4372-a567-0e02b2c3d487', 'd47ac10b-58cc-4372-a567-0e02b2c3d487', 'b47ac10b-58cc-4372-a567-0e02b2c3d487', 'c47ac10b-58cc-4372-a567-0e02b2c3d518'),  -- Xiaomi 14 / Black
('e47ac10b-58cc-4372-a567-0e02b2c3d488', 'd47ac10b-58cc-4372-a567-0e02b2c3d488', 'b47ac10b-58cc-4372-a567-0e02b2c3d483', 'c47ac10b-58cc-4372-a567-0e02b2c3d511')   -- Galaxy S24 / Onyx Black
ON CONFLICT DO NOTHING;

-- =====================================================
-- VERIFICATION — row counts
-- =====================================================
SELECT
  (SELECT COUNT(*) FROM categories)     AS categories,   -- expect 5
  (SELECT COUNT(*) FROM brands)         AS brands,       -- expect 10
  (SELECT COUNT(*) FROM products)       AS products,     -- expect 15
  (SELECT COUNT(*) FROM product_colors) AS colors,       -- expect 54
  (SELECT COUNT(*) FROM orders)         AS orders,       -- expect 10
  (SELECT COUNT(*) FROM order_items)    AS order_items;  -- expect 10

-- =====================================================
-- QUICK REFERENCE — IDs for API testing
-- =====================================================
-- CATEGORIES
--   Smartphones : f47ac10b-58cc-4372-a567-0e02b2c3d479
--   Tablets     : f47ac10b-58cc-4372-a567-0e02b2c3d480
--   Laptops     : f47ac10b-58cc-4372-a567-0e02b2c3d481
--
-- BRANDS (Smartphones)
--   Apple       : a47ac10b-58cc-4372-a567-0e02b2c3d479
--   Samsung     : a47ac10b-58cc-4372-a567-0e02b2c3d480
--   Google      : a47ac10b-58cc-4372-a567-0e02b2c3d481
--   Xiaomi      : a47ac10b-58cc-4372-a567-0e02b2c3d482
--   OnePlus     : a47ac10b-58cc-4372-a567-0e02b2c3d483
-- BRANDS (Tablets)
--   iPad        : a47ac10b-58cc-4372-a567-0e02b2c3d484
--   Samsung Tab : a47ac10b-58cc-4372-a567-0e02b2c3d485
-- BRANDS (Laptops)
--   MacBook     : a47ac10b-58cc-4372-a567-0e02b2c3d486
--   Dell        : a47ac10b-58cc-4372-a567-0e02b2c3d487

-- =====================================================
-- TEST CASES
-- =====================================================

-- [1] Single brandId filter → 3 Apple (iPhone) products
-- GET /products?brandId=a47ac10b-58cc-4372-a567-0e02b2c3d479
-- expect: iPhone 15 Pro, iPhone 15, iPhone 14

-- [2] Multi-brandId across categories → Apple (Smartphones) + MacBook (Laptops)
-- GET /products?brandId=a47ac10b-58cc-4372-a567-0e02b2c3d479&brandId=a47ac10b-58cc-4372-a567-0e02b2c3d486
-- expect: 3 iPhones + MacBook Pro 16" (4 total)

-- [3] Multi-brandId same category → Apple + Samsung (both Smartphones)
-- GET /products?brandId=a47ac10b-58cc-4372-a567-0e02b2c3d479&brandId=a47ac10b-58cc-4372-a567-0e02b2c3d480
-- expect: 3 iPhones + Galaxy S24 Ultra + Galaxy S24 (5 total)

-- [4] Color filter returns ALL colors of matching products (EXISTS fix)
-- GET /products?color=black
-- expect: products that have any "black" variant returned WITH all their colors
-- e.g. iPhone 15 has Black+Blue+Pink+Yellow — all 4 returned, not just Black

-- [5] Name ILIKE → partial match
-- GET /products?name=14
-- expect: iPhone 14, Xiaomi 14 Ultra, Xiaomi 14 (3 products)

-- [6] categoryId filter via brand join
-- GET /products?categoryId=f47ac10b-58cc-4372-a567-0e02b2c3d479
-- expect: all 10 Smartphone products (Apple×3, Samsung×2, Google×2, Xiaomi×2, OnePlus×1)

-- [7] Combined: categoryId + multi-brandId
-- GET /products?categoryId=f47ac10b-58cc-4372-a567-0e02b2c3d479&brandId=a47ac10b-58cc-4372-a567-0e02b2c3d479&brandId=a47ac10b-58cc-4372-a567-0e02b2c3d480
-- expect: Apple + Samsung smartphones only (5 products)

-- [8] getBrands by category
-- GET /products/filters/brands?categoryId=f47ac10b-58cc-4372-a567-0e02b2c3d479
-- expect: Apple, Google, OnePlus, Samsung, Xiaomi (5 brands, alphabetical)

-- [9] getColorsUnique → distinct color names
-- GET /products/filters/colors
-- expect: one row per distinct color name (e.g. "Black" once even though many products have it)
