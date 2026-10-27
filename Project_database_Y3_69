[generate_data.py](https://github.com/user-attachments/files/34007337/generate_data.py)
# Import ไลบรารีมาตรฐานของ Python ที่ต้องใช้
import random  # ใช้สำหรับการสุ่มข้อมูล เช่น สุ่มตัวเลข สุ่มเลือกคำ
from datetime import datetime, timedelta  # ใช้สำหรับการจัดการวันและเวลา

# ล็อกค่า Seed ของการสุ่ม เพื่อให้รันกี่ครั้งก็ได้ผลลัพธ์ข้อมูลสุ่มชุดเดิมเสมอ
random.seed(42)

# กำหนดชื่อไฟล์ SQL ปลายทางที่จะสร้าง
sql_filename = "data.sql"

print("🚀 กำลังเริ่มสร้างข้อมูล Mock Data...")

# ------------------------------------------------------------------------------
# เตรียมชุดข้อมูลภาษาไทยสำหรับนำไปสุ่ม
# ------------------------------------------------------------------------------
first_names = ['สมชาย', 'วิภา', 'กิตติ', 'นภา', 'สุรศักดิ์', 'พรทิพย์', 'อนันต์', 'อารียา', 'ธนกฤต', 'วรรณภา', 'นพดล', 'ชลธิชา', 'ณัฐพงษ์', 'ปิยะนุช', 'ศุภชัย']
last_names = ['ใจดี', 'รักชาติ', 'มีสุข', 'เจริญผล', 'มั่นคง', 'สุขสวัสดิ์', 'วงษ์สุวรรณ', 'ทองแท้', 'งามขำ', 'ศรีสุข', 'เจริญทรัพย์', 'รัตนโชติ', 'สุวรรณรัตน์']
company_names = ['เทคโซลูชั่น', 'โลจิสติกส์ไทย', 'สยามเทรดดิ้ง', 'ซัพพลายเชน', 'กรุ๊ปเซอร์วิส', 'นวัตกรรมใหม่', 'โกลบอลการค้า', 'ไทยเจริญโลจิสติกส์']
districts = ['เมือง', 'บางพลี', 'ปากเกร็ด', 'คลองหลวง', 'บางบัวทอง', 'ศรีราชา', 'หาดใหญ่', 'เมืองพัทยา', 'กะทู้', 'ปลวกแดง']

# ฟังก์ชันสุ่มชื่อ-นามสกุล บุคคลธรรมดา
def get_random_name():
    return f"{random.choice(first_names)} {random.choice(last_names)}"

# ฟังก์ชันสุ่มชื่อบริษัท
def get_random_company():
    return f"บริษัท {random.choice(company_names)} จำกัด"

# เปิดไฟล์ data.sql เพื่อเริ่มเขียนคำสั่ง SQL (กำหนด encoding="utf-8" เพื่อรองรับภาษาไทย)
with open(sql_filename, "w", encoding="utf-8") as f:

    # ==========================================================================
    # 1. CUSTOMERS (ตารางข้อมูลลูกค้า: 30 รายการ)
    # ==========================================================================
    f.write("-- 1. CUSTOMERS\n")
    f.write("INSERT INTO customers (customer_id, name, email, phone, address, customer_type) VALUES\n")
    cust_rows = []
    types = ['Individual', 'Corporate']  # ประเภทลูกค้า: บุคคลธรรมดา หรือ นิติบุคคล
    for i in range(1, 31):
        # สุ่มว่าจะเป็นชื่อคนหรือชื่อบริษัท
        name = get_random_name() if i % 2 == 0 else get_random_company()
        email = f"customer{i}@example.com"
        phone = f"08{random.randint(10000000, 99999999)}"  # สุ่มเบอร์มือถือ 10 หลัก
        address = f"123/{i} อ.{random.choice(districts)} จ.กรุงเทพฯ 10100"
        c_type = random.choice(types)
        cust_rows.append(f"({i}, '{name}', '{email}', '{phone}', '{address}', '{c_type}')")
    f.write(",\n".join(cust_rows) + ";\n\n")

    # ==========================================================================
    # 2. SUPPLIERS (ตารางข้อมูลผู้จัดจำหน่าย/ซัพพลายเออร์: 20 รายการ)
    # ==========================================================================
    f.write("-- 2. SUPPLIERS\n")
    f.write("INSERT INTO suppliers (supplier_id, company_name, contact_name, phone, email, address) VALUES\n")
    supp_rows = []
    for i in range(1, 21):
        company = get_random_company()
        contact = get_random_name()  # ชื่อผู้ติดต่อ
        phone = f"02{random.randint(1000000, 9999999)}"  # เบอร์บ้าน/สำนักงาน 9 หลัก
        email = f"contact@supplier{i}.com"
        address = f"99/{i} ถนนสุขุมวิท อ.{random.choice(districts)}"
        supp_rows.append(f"({i}, '{company}', '{contact}', '{phone}', '{email}', '{address}')")
    f.write(",\n".join(supp_rows) + ";\n\n")

    # ==========================================================================
    # 3. WAREHOUSES (ตารางข้อมูลคลังสินค้า: 20 รายการ)
    # ==========================================================================
    f.write("-- 3. WAREHOUSES\n")
    f.write("INSERT INTO warehouses (warehouse_id, name, location, capacity_sqm, current_usage, status) VALUES\n")
    provinces = [
        'กรุงเทพฯ', 'สมุทรปราการ', 'นนทบุรี', 'ปทุมธานี', 'พระนครศรีอยุธยา',
        'ชลบุรี', 'ระยอง', 'ฉะเชิงเทรา', 'นครราชสีมา', 'ขอนแก่น',
        'เชียงใหม่', 'พิษณุโลก', 'นครสวรรค์', 'สุราษฎร์ธานี', 'สงขลา',
        'ภูเก็ต', 'อุดรธานี', 'อุบลราชธานี', 'ราชบุรี', 'สระบุรี'
    ]
    wh_rows = []
    for i in range(1, 21):
        prov = provinces[i-1]
        w_name = f"คลังสินค้าศูนย์กระจายสินค้า {prov}"
        cap = random.randint(8000, 30000)  # สุ่มความจุคลัง (ตร.ม.)
        usage = random.randint(2000, cap - 1000)  # สุ่มพื้นที่ที่ถูกใช้งานจริง
        wh_rows.append(f"({i}, '{w_name}', '{prov}', {cap}, {usage}, 'Active')")
    f.write(",\n".join(wh_rows) + ";\n\n")

    # ==========================================================================
    # 4. PRODUCTS (ตารางข้อมูลสินค้า: 50 รายการ)
    # ==========================================================================
    f.write("-- 4. PRODUCTS\n")
    f.write("INSERT INTO products (product_id, supplier_id, sku, product_name, unit, unit_price, weight_kg, reorder_level) VALUES\n")
    prod_rows = []
    prod_names = ['กล่องพลาสติกใส', 'กระดาษ A4', 'พัดลมไอเย็น', 'เก้าอี้สำนักงาน', 'หลอดไฟ LED', 'ชั้นวางของเหล็ก', 'โต๊ะทำงาน', 'กล่องกระดาษบรรจุภัณฑ์']
    for i in range(1, 51):
        sup_id = random.randint(1, 20)  # เชื่อม Foreign Key กับ supplier_id
        sku = f"SKU-{1000 + i}"  # รหัสสินค้าเฉพาะ
        p_name = f"{random.choice(prod_names)} รุ่น {chr(65 + (i % 26))}-{i}"
        unit = 'ชิ้น'
        price = round(random.uniform(50.0, 3500.0), 2)  # สุ่มราคาสินค้า 50-3,500 บาท
        weight = round(random.uniform(0.5, 25.0), 2)   # สุ่มน้ำหนักสินค้า (กก.)
        reorder = random.randint(10, 50)               # จุดเตือนสั่งซื้อเพิ่มเมื่อสต็อกต่ำกว่าค่านี้
        prod_rows.append(f"({i}, {sup_id}, '{sku}', '{p_name}', '{unit}', {price}, {weight}, {reorder})")
    f.write(",\n".join(prod_rows) + ";\n\n")

    # ==========================================================================
    # 5. INVENTORY (ตารางสต็อกสินค้าในแต่ละคลัง: 50 รายการ)
    # ==========================================================================
    f.write("-- 5. INVENTORY\n")
    f.write("INSERT INTO inventory (inventory_id, warehouse_id, product_id, quantity, last_updated) VALUES\n")
    inv_rows = []
    for inv_id in range(1, 51):
        w_id = random.randint(1, 20)  # สุ่มคลังสินค้า
        p_id = inv_id                 # รหัสสินค้า
        qty = random.randint(20, 500) # สุ่มจำนวนคงเหลือในคลัง
        updated = datetime.now() - timedelta(days=random.randint(1, 30))  # สุ่มวันที่อัปเดตย้อนหลัง 1-30 วัน
        inv_rows.append(f"({inv_id}, {w_id}, {p_id}, {qty}, '{updated.strftime('%Y-%m-%d %H:%M:%S')}')")
    f.write(",\n".join(inv_rows) + ";\n\n")

    # ==========================================================================
    # 6. DRIVERS (ตารางข้อมูลพนักงานขับรถ: 20 รายการ)
    # ==========================================================================
    f.write("-- 6. DRIVERS\n")
    f.write("INSERT INTO drivers (driver_id, full_name, phone, license_number, status) VALUES\n")
    driver_rows = []
    d_statuses = ['Available', 'In_Transit', 'Off_Duty']  # สถานะ: พร้อมงาน, กำลังส่ง, พักงาน
    for i in range(1, 21):
        name = get_random_name()
        phone = f"08{random.randint(10000000, 99999999)}"
        lic = f"DL-{random.randint(100000, 999999)}"  # เลขที่ใบขับขี่
        status = random.choice(d_statuses)
        driver_rows.append(f"({i}, '{name}', '{phone}', '{lic}', '{status}')")
    f.write(",\n".join(driver_rows) + ";\n\n")

    # ==========================================================================
    # 7. VEHICLES (ตารางข้อมูลยานพาหนะ/รถขนส่ง: 20 รายการ)
    # ==========================================================================
    f.write("-- 7. VEHICLES\n")
    f.write("INSERT INTO vehicles (vehicle_id, license_plate, vehicle_type, capacity_kg, status) VALUES\n")
    veh_rows = []
    v_types = ['4-Wheeler Truck', '6-Wheeler Truck', '10-Wheeler Truck', 'Cargo Van']  # ประเภทรถ
    v_statuses = ['Available', 'In_Transit', 'Maintenance']                           # สถานะรถ
    for i in range(1, 21):
        plate = f"{random.randint(1, 9)}กข-{random.randint(1000, 9999)}"              # สุ่มทะเบียนรถ
        v_type = random.choice(v_types)
        cap = random.choice([1500, 5000, 15000, 25000])                             # พิกัดน้ำหนักบรรทุก (กก.)
        status = random.choice(v_statuses)
        veh_rows.append(f"({i}, '{plate}', '{v_type}', {cap}, '{status}')")
    f.write(",\n".join(veh_rows) + ";\n\n")

    # ==========================================================================
    # 8. SHIPMENTS (ตารางหลักการจัดส่งสินค้า: 550 รายการ)
    # ==========================================================================
    f.write("-- 8. SHIPMENTS (>= 500 Records)\n")
    f.write("INSERT INTO shipments (shipment_id, customer_id, warehouse_id, driver_id, vehicle_id, shipment_date, dispatch_time, estimated_delivery, actual_delivery, status, total_weight, notes) VALUES\n")
    shipment_rows = []
    shipment_statuses = ['Delivered', 'Delivered', 'Delivered', 'In_Transit', 'Cancelled', 'Pending']  # เน้น Delivered เป็นหลัก
    start_date = datetime.now() - timedelta(days=180)  # ย้อนหลังไป 6 เดือน
    for i in range(1, 551):
        c_id = random.randint(1, 30)
        w_id = random.randint(1, 20)
        d_id = random.randint(1, 20)
        v_id = random.randint(1, 20)
        
        # คำนวณลำดับเวลา (การเปิดออเดอร์ -> เวลาปล่อยรถ -> เวลาคาดการณ์ -> เวลาส่งจริง)
        s_date = start_date + timedelta(days=random.randint(1, 170), hours=random.randint(0, 12))
        disp_time = s_date + timedelta(hours=random.randint(1, 3))        # ปล่อยรถหลังสั่ง 1-3 ชม.
        est_deliv = disp_time + timedelta(hours=random.randint(6, 48))    # คาดว่าถึงใน 6-48 ชม.
        
        status = random.choice(shipment_statuses)
        act_deliv = "NULL"
        # หากส่งสำเร็จ (Delivered) ให้คำนวณวันเวลาที่ส่งจริงด้วย
        if status == 'Delivered':
            delay_hours = random.choice([0, 0, 0, 1, 3, -2])  # สุ่มว่าส่งตรงเวลา หรือเลท หรือเร็วกว่ากำหนด
            act_deliv = f"'{ (est_deliv + timedelta(hours=delay_hours)).strftime('%Y-%m-%d %H:%M:%S') }'"
            
        weight = round(random.uniform(50.0, 3000.0), 2)
        notes = "จัดส่งปกติ" if status == 'Delivered' else "เลื่อนเวลาส่ง"
        disp_str = f"'{disp_time.strftime('%Y-%m-%d %H:%M:%S')}'"
        est_str = f"'{est_deliv.strftime('%Y-%m-%d %H:%M:%S')}'"
        shipment_rows.append(f"({i}, {c_id}, {w_id}, {d_id}, {v_id}, '{s_date.strftime('%Y-%m-%d')}', {disp_str}, {est_str}, {act_deliv}, '{status}', {weight}, '{notes}')")
    f.write(",\n".join(shipment_rows) + ";\n\n")

    # ==========================================================================
    # 9. SHIPMENT_ITEMS (ตารางหลักรายละเอียดสินค้าในแต่ละใบส่ง: 1,200 รายการ)
    # ==========================================================================
    f.write("-- 9. SHIPMENT_ITEMS\n")
    f.write("INSERT INTO shipment_items (shipment_item_id, shipment_id, product_id, quantity, unit_price_snapshot) VALUES\n")
    item_rows = []
    item_id = 1
    for s_id in range(1, 551):
        num_items = random.randint(1, 3)  # แต่ละการส่ง สุ่มว่าจะมีสินค้า 1-3 ชนิด
        selected_prods = random.sample(range(1, 51), num_items)
        for p_id in selected_prods:
            qty = random.randint(1, 20)
            price_snapshot = round(random.uniform(100.0, 2500.0), 2)  # บันทึกราคา ณ วันที่ส่ง
            item_rows.append(f"({item_id}, {s_id}, {p_id}, {qty}, {price_snapshot})")
            item_id += 1
    f.write(",\n".join(item_rows) + ";\n\n")

    # ==========================================================================
    # 10. DELIVERY_LOGS (ตารางหลักบันทึกประวัติสถานะการจัดส่ง: 1,000 รายการ)
    # ==========================================================================
    f.write("-- 10. DELIVERY_LOGS\n")
    f.write("INSERT INTO delivery_logs (log_id, shipment_id, status, location, logged_at, notes) VALUES\n")
    log_rows = []
    log_id = 1
    statuses_flow = ['Pending', 'In_Transit', 'Delivered']  # ขั้นตอนการขนส่ง
    for s_id in range(1, 501):
        base_time = datetime.now() - timedelta(days=random.randint(1, 100))
        # จำลอง Time Log ของแต่ละขั้นตอน โดยเพิ่มเวลาห่างกันทีละ 4 ชั่วโมง
        for step_idx, st in enumerate(statuses_flow):
            log_time = base_time + timedelta(hours=step_idx*4)
            loc = random.choice(districts)
            note = f"อัปเดตสถานะเป็น {st}"
            log_rows.append(f"({log_id}, {s_id}, '{st}', '{loc}', '{log_time.strftime('%Y-%m-%d %H:%M:%S')}', '{note}')")
            log_id += 1
    f.write(",\n".join(log_rows) + ";\n\n")

print(f"✅ สร้างไฟล์ {sql_filename} สำเร็จเรียบร้อยแล้ว!")
