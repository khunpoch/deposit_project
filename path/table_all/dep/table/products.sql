CREATE TABLE dep.products (
    product_type NUMBER(13),
    product_id VARCHAR2(12),
    product_type_name VARCHAR2(100),
    product_id_name VARCHAR2(100),
    mod_user VARCHAR2(100),
    mod_date DATE,
    PRIMARY KEY (product_type, product_id)
);