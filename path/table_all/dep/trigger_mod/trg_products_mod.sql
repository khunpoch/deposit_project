
CREATE OR REPLACE TRIGGER trg_products_mod
BEFORE INSERT OR UPDATE ON dep.products
FOR EACH ROW
BEGIN
    :NEW.mod_user := USER;  
    :NEW.mod_date := SYSDATE;  
END;








