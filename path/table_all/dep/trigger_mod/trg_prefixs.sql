CREATE OR REPLACE TRIGGER trg_prefixs_mod
BEFORE INSERT OR UPDATE ON dep.prefixs
FOR EACH ROW
BEGIN
    :NEW.mod_user := USER;  
    :NEW.mod_date := SYSDATE;  
END;
/