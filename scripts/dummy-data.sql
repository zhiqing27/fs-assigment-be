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
-- 2b. BRAND_CATEGORIES — admin-assigned brand↔category mappings
-- =====================================================
INSERT INTO brand_categories (id, "brandId", "categoryId", "createdAt") VALUES
('bc000001-0000-0000-0000-000000000000', 'a47ac10b-58cc-4372-a567-0e02b2c3d479', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', NOW()),  -- Apple → Smartphones
('bc000002-0000-0000-0000-000000000000', 'a47ac10b-58cc-4372-a567-0e02b2c3d479', 'f47ac10b-58cc-4372-a567-0e02b2c3d480', NOW()),  -- Apple → Tablets
('bc000003-0000-0000-0000-000000000000', 'a47ac10b-58cc-4372-a567-0e02b2c3d479', 'f47ac10b-58cc-4372-a567-0e02b2c3d481', NOW()),  -- Apple → Laptops
('bc000004-0000-0000-0000-000000000000', 'a47ac10b-58cc-4372-a567-0e02b2c3d480', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', NOW()),  -- Samsung → Smartphones
('bc000005-0000-0000-0000-000000000000', 'a47ac10b-58cc-4372-a567-0e02b2c3d480', 'f47ac10b-58cc-4372-a567-0e02b2c3d480', NOW()),  -- Samsung → Tablets
('bc000006-0000-0000-0000-000000000000', 'a47ac10b-58cc-4372-a567-0e02b2c3d481', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', NOW()),  -- Google → Smartphones
('bc000007-0000-0000-0000-000000000000', 'a47ac10b-58cc-4372-a567-0e02b2c3d482', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', NOW()),  -- Xiaomi → Smartphones
('bc000008-0000-0000-0000-000000000000', 'a47ac10b-58cc-4372-a567-0e02b2c3d483', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', NOW()),  -- OnePlus → Smartphones
('bc000009-0000-0000-0000-000000000000', 'a47ac10b-58cc-4372-a567-0e02b2c3d487', 'f47ac10b-58cc-4372-a567-0e02b2c3d481', NOW()),  -- Dell → Laptops
('bc000010-0000-0000-0000-000000000000', 'a47ac10b-58cc-4372-a567-0e02b2c3d488', 'f47ac10b-58cc-4372-a567-0e02b2c3d481', NOW())   -- HP → Laptops
ON CONFLICT DO NOTHING;

-- =====================================================
-- 3. PRODUCTS (15) — totalStock = sum of color stocks
-- =====================================================
-- categoryId: Smartphones=f47ac10b-...-479 Tablets=f47ac10b-...-480 Laptops=f47ac10b-...-481
INSERT INTO products (id, name, description, "imageUrl", "basePrice", "totalStock", "brandId", "categoryId", "createdAt", "updatedAt") VALUES
('b47ac10b-58cc-4372-a567-0e02b2c3d479', 'iPhone 15 Pro',   'Latest iPhone with A17 Pro chip',        'https://placehold.co/300x400?text=iPhone+15+Pro',   999.99,  90,  'a47ac10b-58cc-4372-a567-0e02b2c3d479', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d480', 'iPhone 15',       'Affordable flagship iPhone',             'https://placehold.co/300x400?text=iPhone+15',       799.99,  130, 'a47ac10b-58cc-4372-a567-0e02b2c3d479', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d481', 'iPhone 14',       'Previous generation iPhone',             'https://placehold.co/300x400?text=iPhone+14',       699.99,  180, 'a47ac10b-58cc-4372-a567-0e02b2c3d479', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d482', 'Galaxy S24 Ultra','Premium flagship Android phone',         'https://placehold.co/300x400?text=Galaxy+S24+Ultra',1299.99, 70,  'a47ac10b-58cc-4372-a567-0e02b2c3d480', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d483', 'Galaxy S24',      'Flagship Samsung phone',                 'https://placehold.co/300x400?text=Galaxy+S24',      999.99,  120, 'a47ac10b-58cc-4372-a567-0e02b2c3d480', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d484', 'Pixel 8 Pro',     'Premium Google phone with AI features',  'https://placehold.co/300x400?text=Pixel+8+Pro',     899.99,  53,  'a47ac10b-58cc-4372-a567-0e02b2c3d481', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d485', 'Pixel 8',         'Affordable Google Pixel phone',          'https://placehold.co/300x400?text=Pixel+8',         699.99,  110, 'a47ac10b-58cc-4372-a567-0e02b2c3d481', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d486', 'Xiaomi 14 Ultra', 'High-end Xiaomi with excellent camera',  'https://placehold.co/300x400?text=Xiaomi+14+Ultra', 649.99,  90,  'a47ac10b-58cc-4372-a567-0e02b2c3d482', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d487', 'Xiaomi 14',       'Mid-range Xiaomi smartphone',            'https://placehold.co/300x400?text=Xiaomi+14',       449.99,  160, 'a47ac10b-58cc-4372-a567-0e02b2c3d482', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d488', 'OnePlus 12',      'Fast and reliable OnePlus phone',        'https://placehold.co/300x400?text=OnePlus+12',      799.99,  130, 'a47ac10b-58cc-4372-a567-0e02b2c3d483', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d489', 'iPad Pro 12.9"',  'Premium Apple tablet with M2 chip',      'https://placehold.co/300x400?text=iPad+Pro',        1099.99, 70,  'a47ac10b-58cc-4372-a567-0e02b2c3d479', 'f47ac10b-58cc-4372-a567-0e02b2c3d480', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d490', 'iPad Air',        'Mid-range Apple tablet',                 'https://placehold.co/300x400?text=iPad+Air',        599.99,  100, 'a47ac10b-58cc-4372-a567-0e02b2c3d479', 'f47ac10b-58cc-4372-a567-0e02b2c3d480', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d491', 'Galaxy Tab S9',   'Premium Samsung tablet',                 'https://placehold.co/300x400?text=Galaxy+Tab+S9',   799.99,  37,  'a47ac10b-58cc-4372-a567-0e02b2c3d480', 'f47ac10b-58cc-4372-a567-0e02b2c3d480', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d492', 'MacBook Pro 16"', 'Premium Apple laptop',                   'https://placehold.co/300x400?text=MacBook+Pro+16',  2499.99, 37,  'a47ac10b-58cc-4372-a567-0e02b2c3d479', 'f47ac10b-58cc-4372-a567-0e02b2c3d481', NOW(), NOW()),
('b47ac10b-58cc-4372-a567-0e02b2c3d493', 'Dell XPS 15',     'High-performance Dell laptop',           'https://placehold.co/300x400?text=Dell+XPS+15',     1699.99, 60,  'a47ac10b-58cc-4372-a567-0e02b2c3d487', 'f47ac10b-58cc-4372-a567-0e02b2c3d481', NOW(), NOW())
ON CONFLICT DO NOTHING;

-- =====================================================
-- 4. COLORS (5)
-- =====================================================
INSERT INTO colors (id, name, "colorCode", "createdAt", "updatedAt") VALUES
('00000000-0000-0000-0000-000000000001', 'Black',  '#000000', NOW(), NOW()),
('00000000-0000-0000-0000-000000000002', 'White',  '#FFFFFF', NOW(), NOW()),
('00000000-0000-0000-0000-000000000003', 'Blue',   '#4A90E2', NOW(), NOW()),
('00000000-0000-0000-0000-000000000004', 'Silver', '#C0C0C0', NOW(), NOW()),
('00000000-0000-0000-0000-000000000005', 'Gold',   '#FFD700', NOW(), NOW())
ON CONFLICT DO NOTHING;

-- =====================================================
-- 5. PRODUCT COLORS — variant rows (colorId FK, stock, price)
--    totalStock per product = sum of color stocks
-- =====================================================
INSERT INTO product_colors (id, "colorId", stock, price, "productId", "createdAt", "updatedAt") VALUES
-- iPhone 15 Pro (total=90): Black, White, Gold, Silver
('c47ac10b-58cc-4372-a567-0e02b2c3d479', '00000000-0000-0000-0000-000000000001', 30, 999.99,  'b47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d480', '00000000-0000-0000-0000-000000000002', 25, 999.99,  'b47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d481', '00000000-0000-0000-0000-000000000005', 20, 1049.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d482', '00000000-0000-0000-0000-000000000004', 15, 999.99,  'b47ac10b-58cc-4372-a567-0e02b2c3d479', NOW(), NOW()),
-- iPhone 15 (total=130): Black, Blue, White, Gold
('c47ac10b-58cc-4372-a567-0e02b2c3d483', '00000000-0000-0000-0000-000000000001', 40, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d480', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d484', '00000000-0000-0000-0000-000000000003', 35, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d480', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d485', '00000000-0000-0000-0000-000000000002', 30, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d480', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d486', '00000000-0000-0000-0000-000000000005', 25, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d480', NOW(), NOW()),
-- iPhone 14 (total=180): Black, Blue, Silver, White
('c47ac10b-58cc-4372-a567-0e02b2c3d507', '00000000-0000-0000-0000-000000000001', 45, 699.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d481', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d508', '00000000-0000-0000-0000-000000000003', 45, 699.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d481', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d509', '00000000-0000-0000-0000-000000000004', 45, 699.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d481', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d510', '00000000-0000-0000-0000-000000000002', 45, 699.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d481', NOW(), NOW()),
-- Galaxy S24 Ultra (total=70): Black, Silver, Gold, Blue
('c47ac10b-58cc-4372-a567-0e02b2c3d487', '00000000-0000-0000-0000-000000000001', 25, 1299.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d482', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d488', '00000000-0000-0000-0000-000000000004', 20, 1299.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d482', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d489', '00000000-0000-0000-0000-000000000005', 15, 1299.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d482', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d490', '00000000-0000-0000-0000-000000000003', 10, 1349.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d482', NOW(), NOW()),
-- Galaxy S24 (total=120): Black, Silver, Blue, White
('c47ac10b-58cc-4372-a567-0e02b2c3d511', '00000000-0000-0000-0000-000000000001', 30, 999.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d483', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d512', '00000000-0000-0000-0000-000000000004', 30, 999.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d483', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d513', '00000000-0000-0000-0000-000000000003', 30, 999.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d483', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d514', '00000000-0000-0000-0000-000000000002', 30, 999.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d483', NOW(), NOW()),
-- Pixel 8 Pro (total=53): Black, White, Blue
('c47ac10b-58cc-4372-a567-0e02b2c3d491', '00000000-0000-0000-0000-000000000001', 20, 899.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d484', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d492', '00000000-0000-0000-0000-000000000002', 18, 899.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d484', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d493', '00000000-0000-0000-0000-000000000003', 15, 899.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d484', NOW(), NOW()),
-- Pixel 8 (total=110): Black, Silver, White
('c47ac10b-58cc-4372-a567-0e02b2c3d515', '00000000-0000-0000-0000-000000000001', 40, 699.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d485', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d516', '00000000-0000-0000-0000-000000000004', 35, 699.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d485', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d517', '00000000-0000-0000-0000-000000000002', 35, 699.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d485', NOW(), NOW()),
-- Xiaomi 14 Ultra (total=90): White, Black, Blue
('c47ac10b-58cc-4372-a567-0e02b2c3d494', '00000000-0000-0000-0000-000000000002', 35, 649.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d486', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d495', '00000000-0000-0000-0000-000000000001', 30, 649.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d486', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d496', '00000000-0000-0000-0000-000000000003', 25, 649.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d486', NOW(), NOW()),
-- Xiaomi 14 (total=160): Black, White, Blue, Silver
('c47ac10b-58cc-4372-a567-0e02b2c3d518', '00000000-0000-0000-0000-000000000001', 40, 449.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d487', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d519', '00000000-0000-0000-0000-000000000002', 40, 449.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d487', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d520', '00000000-0000-0000-0000-000000000003', 40, 449.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d487', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d521', '00000000-0000-0000-0000-000000000004', 40, 449.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d487', NOW(), NOW()),
-- OnePlus 12 (total=130): Black, Blue, White
('c47ac10b-58cc-4372-a567-0e02b2c3d522', '00000000-0000-0000-0000-000000000001', 45, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d488', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d523', '00000000-0000-0000-0000-000000000003', 45, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d488', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d524', '00000000-0000-0000-0000-000000000002', 40, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d488', NOW(), NOW()),
-- iPad Pro (total=70): Silver, Black, Gold, White
('c47ac10b-58cc-4372-a567-0e02b2c3d497', '00000000-0000-0000-0000-000000000004', 25, 1099.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d489', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d498', '00000000-0000-0000-0000-000000000001', 20, 1099.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d489', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d499', '00000000-0000-0000-0000-000000000005', 15, 1149.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d489', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d500', '00000000-0000-0000-0000-000000000002', 10, 1149.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d489', NOW(), NOW()),
-- iPad Air (total=100): Blue, White, Silver, Gold
('c47ac10b-58cc-4372-a567-0e02b2c3d525', '00000000-0000-0000-0000-000000000003', 25, 599.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d490', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d526', '00000000-0000-0000-0000-000000000002', 25, 599.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d490', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d527', '00000000-0000-0000-0000-000000000004', 25, 599.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d490', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d528', '00000000-0000-0000-0000-000000000005', 25, 599.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d490', NOW(), NOW()),
-- Galaxy Tab S9 (total=37): Black, Silver, White
('c47ac10b-58cc-4372-a567-0e02b2c3d501', '00000000-0000-0000-0000-000000000001', 15, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d491', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d502', '00000000-0000-0000-0000-000000000004', 12, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d491', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d503', '00000000-0000-0000-0000-000000000002', 10, 799.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d491', NOW(), NOW()),
-- MacBook Pro (total=37): Black, Silver, Gold
('c47ac10b-58cc-4372-a567-0e02b2c3d504', '00000000-0000-0000-0000-000000000001', 15, 2499.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d492', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d505', '00000000-0000-0000-0000-000000000004', 12, 2499.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d492', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d506', '00000000-0000-0000-0000-000000000005', 10, 2499.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d492', NOW(), NOW()),
-- Dell XPS 15 (total=60): Silver, Black
('c47ac10b-58cc-4372-a567-0e02b2c3d529', '00000000-0000-0000-0000-000000000004', 30, 1699.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d493', NOW(), NOW()),
('c47ac10b-58cc-4372-a567-0e02b2c3d530', '00000000-0000-0000-0000-000000000001', 30, 1699.99, 'b47ac10b-58cc-4372-a567-0e02b2c3d493', NOW(), NOW())
ON CONFLICT DO NOTHING;

-- =====================================================
-- 5. ORDERS (10 sample orders, 2 clientIds)
-- clientId A = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa' (5 orders)
-- clientId B = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb' (5 orders)
-- =====================================================
INSERT INTO orders (id, "orderNumber", "clientId", status, "totalAmount", "totalItems", "createdAt", "updatedAt") VALUES
('d47ac10b-58cc-4372-a567-0e02b2c3d479', 'MY000001', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'completed', 999.99,  1, NOW() - INTERVAL '30 days', NOW() - INTERVAL '30 days'),
('d47ac10b-58cc-4372-a567-0e02b2c3d480', 'MY000002', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'completed', 799.99,  1, NOW() - INTERVAL '20 days', NOW() - INTERVAL '20 days'),
('d47ac10b-58cc-4372-a567-0e02b2c3d481', 'MY000003', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'pending',   1299.99, 1, NOW() - INTERVAL '10 days', NOW() - INTERVAL '10 days'),
('d47ac10b-58cc-4372-a567-0e02b2c3d482', 'MY000004', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'pending',   649.99,  1, NOW() - INTERVAL '5 days',  NOW() - INTERVAL '5 days' ),
('d47ac10b-58cc-4372-a567-0e02b2c3d483', 'MY000005', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'pending',   2499.99, 1, NOW() - INTERVAL '2 days',  NOW() - INTERVAL '2 days' ),
('d47ac10b-58cc-4372-a567-0e02b2c3d484', 'MY000006', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'completed', 899.99,  1, NOW() - INTERVAL '25 days', NOW() - INTERVAL '25 days'),
('d47ac10b-58cc-4372-a567-0e02b2c3d485', 'MY000007', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'completed', 1699.99, 1, NOW() - INTERVAL '18 days', NOW() - INTERVAL '18 days'),
('d47ac10b-58cc-4372-a567-0e02b2c3d486', 'MY000008', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'completed', 799.99,  1, NOW() - INTERVAL '12 days', NOW() - INTERVAL '12 days'),
('d47ac10b-58cc-4372-a567-0e02b2c3d487', 'MY000009', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'pending',   449.99,  1, NOW() - INTERVAL '4 days',  NOW() - INTERVAL '4 days' ),
('d47ac10b-58cc-4372-a567-0e02b2c3d488', 'MY000010', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'pending',   999.99,  1, NOW() - INTERVAL '1 day',   NOW() - INTERVAL '1 day'  )
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
  (SELECT COUNT(*) FROM categories)     AS categories,    -- expect 5
  (SELECT COUNT(*) FROM brands)         AS brands,        -- expect 7
  (SELECT COUNT(*) FROM colors)         AS colors,        -- expect 5
  (SELECT COUNT(*) FROM products)       AS products,      -- expect 15
  (SELECT COUNT(*) FROM product_colors) AS product_colors,-- expect 52
  (SELECT COUNT(*) FROM orders)         AS orders,        -- expect 10
  (SELECT COUNT(*) FROM order_items)    AS order_items;   -- expect 10

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
