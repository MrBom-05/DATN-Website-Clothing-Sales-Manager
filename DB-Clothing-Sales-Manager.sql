CREATE DATABASE DB_Clothing_Sales_Manager
GO
USE DB_Clothing_Sales_Manager
GO

CREATE TABLE categories
(
    id   INT IDENTITY (1, 1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL
)

CREATE TABLE colors
(
    id         INT IDENTITY (1, 1) PRIMARY KEY,
    name       NVARCHAR(50) NOT NULL,
    code_color VARCHAR(10)  NOT NULL
)

CREATE TABLE products
(
    id          UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    name        NVARCHAR(MAX) NOT NULL,
    create_date DATETIME                     DEFAULT GETDATE(),
    id_category INT           NOT NULL,
    id_color    INT           NOT NULL,
)

CREATE TABLE product_images
(
    id         UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    id_product UNIQUEIDENTIFIER NOT NULL,
    url        NVARCHAR(MAX)    NOT NULL
)

CREATE TABLE sizes
(
    id   INT IDENTITY (1, 1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL
)

CREATE TABLE product_details
(
    id           UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    code_product VARCHAR(20),
    id_product   UNIQUEIDENTIFIER,
    id_size      INT,
    input_price  DECIMAL(20, 0)               DEFAULT 0,
    output_price DECIMAL(20, 0)               DEFAULT 0,
    quantity     INT,
    describe     NVARCHAR(MAX),
    status       int
)

CREATE TABLE accounts
(
    id           UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    code_account VARCHAR(20),
    full_name    NVARCHAR(100),
    email        NVARCHAR(50),
    number_phone NVARCHAR(15),
    password     NVARCHAR(50),
    role         INT,
    address      NVARCHAR(100),
    ward         NVARCHAR(80),
    distric      NVARCHAR(80),
    provice      NVARCHAR(80),
)

CREATE TABLE carts
(
    id         UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    id_account UNIQUEIDENTIFIER
)

CREATE TABLE cart_details
(
    id         UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    id_cart    UNIQUEIDENTIFIER,
    id_product UNIQUEIDENTIFIER,
    price      DECIMAL(20, 0)               DEFAULT 0,
    quantity   INT
)

CREATE TABLE promotions
(
    id              UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    code            VARCHAR(10),
    decrease_number INT,
    start_date      DATE,
    end_date        DATE,
    status          INT
)

CREATE TABLE promotion_details
(
    id           UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    id_promotion UNIQUEIDENTIFIER,
    id_product   UNIQUEIDENTIFIER,
)


CREATE TABLE vouchers
(
    id              UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    coupon_code     INT,
    coupon_point    INT,
    expiration_date DATE,
)

CREATE TABLE bills
(
    id                 UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    code               VARCHAR(50),
    -- Ngày tạo hoá đơn
    create_date        DATETIME                     DEFAULT GETDATE(),
    -- Ngày thanh toán
    payment_date       DATETIME,
    -- Ngày vận chuyển
    delyvery_date      DATETIME,
    -- Ngày nhận hàng
    expected_date      DATETIME,
    -- id người mua
    id_account         UNIQUEIDENTIFIER,
    -- id người duyệt
    id_account_browser UNIQUEIDENTIFIER,

    id_promotion       UNIQUEIDENTIFIER,
    id_voucher         UNIQUEIDENTIFIER,
    pecipient_name     NVARCHAR(100),
    email              NVARCHAR(50),
    number_phone       NVARCHAR(15),
    payment_method     INT,
    address            NVARCHAR(100),
    ward               NVARCHAR(80),
    distric            NVARCHAR(80),
    provice            NVARCHAR(80),
    status             INT
)

CREATE TABLE bill_details
(
    id         UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    id_bill    UNIQUEIDENTIFIER,
    id_product UNIQUEIDENTIFIER,
    price      DECIMAL(20, 0)               DEFAULT 0,
    quantity   INT
)

-- category - product
ALTER TABLE products
    ADD FOREIGN KEY (id_category) REFERENCES categories (id)
-- colols - products
ALTER TABLE products
    ADD FOREIGN KEY (id_color) REFERENCES colors (id)
-- product - product_images
ALTER TABLE product_images
    ADD FOREIGN KEY (id_product) REFERENCES products (id)
-- sizes - product_details
ALTER TABLE product_details
    ADD FOREIGN KEY (id_size) REFERENCES sizes (id)
-- product - product_details
ALTER TABLE product_details
    ADD FOREIGN KEY (id_product) REFERENCES products (id)


-- accounts - carts
ALTER TABLE carts
    ADD FOREIGN KEY (id_account) REFERENCES accounts (id)
-- carts - cart_details
ALTER TABLE cart_details
    ADD FOREIGN KEY (id_cart) REFERENCES carts (id)
-- product_details - cart_details
ALTER TABLE cart_details
    ADD FOREIGN KEY (id_product) REFERENCES product_details (id)
-- promotions - promotion_details
ALTER TABLE promotion_details
    ADD FOREIGN KEY (id_promotion) REFERENCES promotions (id)
-- product_details - promotion_details
ALTER TABLE promotion_details
    ADD FOREIGN KEY (id_product) REFERENCES product_details (id)

-- accounts - bills
ALTER TABLE bills
    ADD FOREIGN KEY (id_account) REFERENCES accounts (id)
-- accounts - bills
ALTER TABLE bills
    ADD FOREIGN KEY (id_account_browser) REFERENCES accounts (id)
-- promotions - bills
ALTER TABLE bills
    ADD FOREIGN KEY (id_promotion) REFERENCES promotions (id)
-- vouchers - bills
ALTER TABLE bills
    ADD FOREIGN KEY (id_voucher) REFERENCES vouchers (id)

-- bills - bill_details
ALTER TABLE bill_details
    ADD FOREIGN KEY (id_bill) REFERENCES promotions (id)
-- product_details - bill_details
ALTER TABLE bill_details
    ADD FOREIGN KEY (id_product) REFERENCES product_details (id)



