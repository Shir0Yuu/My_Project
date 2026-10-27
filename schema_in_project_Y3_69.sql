[schema.sql](https://github.com/user-attachments/files/34007383/schema.sql)
-- กำหนดชื่อ database ที่เอาไว้เก็บข้อมูล
CREATE DATABASE IF NOT EXISTS warehouse_db;
USE warehouse_db;

-- ลบตารางเก่าทิ้ง เรียงลำดับลบตารางลูกที่มี Foreign Key ก่อน เพื่อไม่ให้ติด Error
DROP TABLE IF EXISTS delivery_logs;
DROP TABLE IF EXISTS shipment_items;
DROP TABLE IF EXISTS shipments;
DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS drivers;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS warehouses;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS customers;

-- -----------------------------------------------------------------------------
-- 1. ตาราง CUSTOMERS (ข้อมูลลูกค้า)
-- -----------------------------------------------------------------------------
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT, -- รหัสลูกค้า (Primary Key: รันเลขอัตโนมัติ)
    name VARCHAR(255) NOT NULL,                  -- ชื่อ-นามสกุล หรือชื่อบริษัท (ห้ามเป็นค่าว่าง)
    email VARCHAR(100),                          -- อีเมลติดต่อ
    phone VARCHAR(20),                           -- เบอร์โทรศัพท์
    address TEXT,                                -- ที่อยู่จัดส่ง
    customer_type VARCHAR(50) DEFAULT 'Individual' -- ประเภทลูกค้า (เช่น Individual=บุคคลธรรมดา, Corporate=นิติบุคคล)
);

-- -----------------------------------------------------------------------------
-- 2. ตาราง SUPPLIERS (ข้อมูลผู้จัดจำหน่าย/ซัพพลายเออร์)
-- -----------------------------------------------------------------------------
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT, -- รหัสผู้จัดจำหน่าย (Primary Key)
    company_name VARCHAR(255) NOT NULL,          -- ชื่อบริษัทผู้จัดจำหน่าย
    contact_name VARCHAR(100),                   -- ชื่อผู้ประสานงาน
    phone VARCHAR(20),                           -- เบอร์โทรศัพท์ติดต่อ
    email VARCHAR(100),                          -- อีเมลติดต่อ
    address TEXT                                 -- ที่อยู่บริษัท
);

-- -----------------------------------------------------------------------------
-- 3. ตาราง WAREHOUSES (ข้อมูลคลังสินค้า)
-- -----------------------------------------------------------------------------
CREATE TABLE warehouses (
    warehouse_id INT PRIMARY KEY AUTO_INCREMENT, -- รหัสคลังสินค้า (Primary Key)
    name VARCHAR(255) NOT NULL,                  -- ชื่อคลังสินค้า
    location VARCHAR(255),                       -- จังหวัด/ที่ตั้งของคลังสินค้า
    capacity_sqm INT,                            -- ความจุพื้นที่ทั้งหมด (ตารางเมตร)
    current_usage INT,                           -- พื้นที่ที่ใช้งานอยู่ปัจจุบัน (ตารางเมตร)
    status VARCHAR(50) DEFAULT 'Active'          -- สถานะคลัง (Active=เปิดใช้งาน, Inactive=ปิดปรับปรุง)
);

-- -----------------------------------------------------------------------------
-- 4. ตาราง PRODUCTS (ข้อมูลรายการสินค้า)
-- -----------------------------------------------------------------------------
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,   -- รหัสสินค้าในระบบ (Primary Key)
    supplier_id INT,                             -- รหัสผู้จัดจำหน่าย (Foreign Key)
    sku VARCHAR(50) UNIQUE NOT NULL,             -- รหัส SKU เฉพาะของสินค้า (ห้ามซ้ำ)
    product_name VARCHAR(255) NOT NULL,          -- ชื่อสินค้า
    unit VARCHAR(50) DEFAULT 'ชิ้น',               -- หน่วยนับสินค้า (เช่น ชิ้น, กล่อง, แพ็ค)
    unit_price DECIMAL(10,2) NOT NULL,           -- ราคาสินค้าต่อหน่วย (ทศนิยม 2 ตำแหน่ง)
    weight_kg DECIMAL(8,2),                      -- น้ำหนักต่อชิ้น (กิโลกรัม)
    reorder_level INT DEFAULT 10,                -- จุดเตือนสั่งซื้อเพิ่ม (เมื่อสต็อกต่ำกว่าค่านึ้)
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON DELETE SET NULL -- เชื่อมโยงกับตาราง suppliers
);

-- -----------------------------------------------------------------------------
-- 5. ตาราง INVENTORY (จัดเก็บปริมาณสินค้าในแต่ละคลัง)
-- -----------------------------------------------------------------------------
CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT, -- รหัสรายการสต็อก (Primary Key)
    warehouse_id INT,                            -- รหัสคลังสินค้า (Foreign Key)
    product_id INT,                              -- รหัสสินค้า (Foreign Key)
    quantity INT DEFAULT 0,                      -- จำนวนสินค้าที่มีอยู่ในคลังนี้
    last_updated DATETIME,                       -- วันและเวลาที่มีการอัปเดตสต็อกล่าสุด
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- -----------------------------------------------------------------------------
-- 6. ตาราง DRIVERS (ข้อมูลพนักงานขับรถส่งของ)
-- -----------------------------------------------------------------------------
CREATE TABLE drivers (
    driver_id INT PRIMARY KEY AUTO_INCREMENT,    -- รหัสพนักงานขับรถ (Primary Key)
    full_name VARCHAR(255) NOT NULL,             -- ชื่อ-นามสกุล พนักงาน
    phone VARCHAR(20),                           -- เบอร์โทรศัพท์มือถือ
    license_number VARCHAR(50) UNIQUE,           -- เลขที่ใบอนุญาตขับขี่ (ห้ามซ้ำ)
    status VARCHAR(50) DEFAULT 'Available'       -- สถานะ (Available=พร้อมงาน, In_Transit=อยู่ระหว่างส่ง, Off_Duty=พักงาน)
);

-- -----------------------------------------------------------------------------
-- 7. ตาราง VEHICLES (ข้อมูลรถขนส่ง)
-- -----------------------------------------------------------------------------
CREATE TABLE vehicles (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,   -- รหัสรถขนส่ง (Primary Key)
    license_plate VARCHAR(20) UNIQUE NOT NULL,   -- ทะเบียนรถ (ห้ามซ้ำ)
    vehicle_type VARCHAR(50),                    -- ประเภทรถ (เช่น รถ 4 ล้อ, 6 ล้อ, 10 ล้อ)
    capacity_kg INT,                             -- พิกัดน้ำหนักบรรทุกสูงสุด (กิโลกรัม)
    status VARCHAR(50) DEFAULT 'Available'       -- สถานะรถ (Available=ว่าง, In_Transit=ใช้งานอยู่, Maintenance=ซ่อมบำรุง)
);

-- -----------------------------------------------------------------------------
-- 8. ตาราง SHIPMENTS (ข้อมูลใบสั่งจัดส่งสินค้า - ตารางหลัก)
-- -----------------------------------------------------------------------------
CREATE TABLE shipments (
    shipment_id INT PRIMARY KEY AUTO_INCREMENT,  -- รหัสการจัดส่ง (Primary Key)
    customer_id INT,                             -- รหัสผู้รับสินค้า (Foreign Key)
    warehouse_id INT,                            -- รหัสคลังสินค้าที่เบิกออก (Foreign Key)
    driver_id INT,                               -- รหัสคนขับรถที่รับผิดชอบ (Foreign Key)
    vehicle_id INT,                              -- รหัสรถที่ใช้ขนส่ง (Foreign Key)
    shipment_date DATE,                          -- วันที่เปิดเอกสารจัดส่ง
    dispatch_time DATETIME,                      -- วัน-เวลาที่รถออกจากคลัง
    estimated_delivery DATETIME,                 -- วัน-เวลาที่คาดว่าจะถึงปลายทาง
    actual_delivery DATETIME,                    -- วัน-เวลาที่สินค้าถึงจริง (NULL หากยังส่งไม่เสร็จ)
    status VARCHAR(50) DEFAULT 'Pending',        -- สถานะ (Pending, In_Transit, Delivered, Cancelled)
    total_weight DECIMAL(10,2),                  -- น้ำหนักรวมของสินค้ารอบนี้ (กิโลกรัม)
    notes TEXT,                                  -- หมายเหตุเพิ่มเติม
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

-- -----------------------------------------------------------------------------
-- 9. ตาราง SHIPMENT_ITEMS (รายการสินค้าในแต่ละใบจัดส่ง)
-- -----------------------------------------------------------------------------
CREATE TABLE shipment_items (
    shipment_item_id INT PRIMARY KEY AUTO_INCREMENT, -- รหัสรายการสินค้าในใบส่ง (Primary Key)
    shipment_id INT,                                -- รหัสใบจัดส่ง (Foreign Key)
    product_id INT,                                 -- รหัสสินค้าที่จัดส่ง (Foreign Key)
    quantity INT NOT NULL,                          -- จำนวนสินค้าที่ส่ง
    unit_price_snapshot DECIMAL(10,2) NOT NULL,     -- ราคาสินค้า ณ วันที่ส่ง (บันทึกไว้ป้องกันราคาเปลี่ยนภายหลัง)
    FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- -----------------------------------------------------------------------------
-- 10. DELIVERY_LOGS (ประวัติสถานะการเดินทางของสินค้า)
-- -----------------------------------------------------------------------------
CREATE TABLE delivery_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,       -- รหัสประวัติการเดินทาง (Primary Key)
    shipment_id INT,                             -- รหัสใบจัดส่ง (Foreign Key)
    status VARCHAR(50),                          -- สถานะ ณ จุดเช็คอิน (เช่น Pending, In_Transit, Delivered)
    location VARCHAR(255),                       -- พิกัด/อำเภอ ที่รถผ่านขณะอัปเดต
    logged_at DATETIME,                          -- วัน-เวลาที่ทำการเช็คอิน
    notes TEXT,                                  -- หมายเหตุการเช็คอิน
    FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id) ON DELETE CASCADE
);
