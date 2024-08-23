CREATE OR REPLACE TRIGGER trg_Deposit_account_mod
BEFORE INSERT OR UPDATE ON dep.Deposit_account
FOR EACH ROW
BEGIN
    :NEW.mod_user := USER;  
    :NEW.mod_date := SYSDATE;  
END;

