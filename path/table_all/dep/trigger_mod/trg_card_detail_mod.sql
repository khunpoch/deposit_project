CREATE OR REPLACE TRIGGER trg_card_detail_mod
BEFORE INSERT OR UPDATE ON dep.card_detail
FOR EACH ROW
BEGIN
    :NEW.mod_user := USER;  
    :NEW.mod_date := SYSDATE;  
END;
/