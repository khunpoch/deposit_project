CREATE OR REPLACE TRIGGER trg_branches_mod
BEFORE INSERT OR UPDATE ON dep.branches
FOR EACH ROW
BEGIN
    :NEW.mod_user := USER;  
    :NEW.mod_date := SYSDATE;  
END;

