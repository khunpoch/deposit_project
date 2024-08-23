CREATE OR REPLACE PROCEDURE run_etl_dep IS
    CURSOR source_cursor IS
        SELECT *
        FROM raw_data.temp_batch_source
        WHERE load_flag = 'N';
        
    v_emp_record  source_cursor%ROWTYPE;
    
    -- Variables
    v_card_id           NUMBER(13);
    v_back_id_card      VARCHAR2(12);
    v_date_of_lssue     DATE;
    v_date_of_expiry    DATE;
    v_prefix            INTEGER;
    v_first_name_th     VARCHAR2(255);
    v_last_name_th      VARCHAR2(255);
    v_first_name_eng    VARCHAR2(255);
    v_last_name_eng     VARCHAR2(255);
    v_birth_of_day      DATE;
    v_phone_number      NUMBER(15);
    v_email             VARCHAR2(255);
    v_address_id        VARCHAR2(255);
    v_street            VARCHAR2(255);
    v_sub_district      VARCHAR2(255);
    v_district          VARCHAR2(255);
    v_province          VARCHAR2(255);
    v_country           VARCHAR2(255);
    v_postal_code       VARCHAR2(255);
    v_Deposit_account   NUMBER;
    v_branch_id         INTEGER;
    v_product_id        INTEGER;
    v_product_type      INTEGER;
    v_interest_rate     NUMBER;
    v_address_primary   INTEGER;
    
    -- Local variables
    l_id_card           INTEGER;
    l_address_primary   INTEGER;

BEGIN
    -- Open the cursor and fetch each row
    OPEN source_cursor;
    LOOP
        FETCH source_cursor INTO v_emp_record;
        EXIT WHEN source_cursor%NOTFOUND;
        
        -- Start transform
        -- Check card id 
        SELECT COUNT(1)
        INTO l_id_card
        FROM dep.card_id c
        WHERE c.card_id = v_emp_record.card_id;
        
        IF l_id_card = 0 THEN
            -- New Card ID processing
            v_card_id := v_emp_record.card_id;
            v_back_id_card := v_emp_record.back_id_card;
            v_date_of_lssue := v_emp_record.date_of_lssue;
            v_date_of_expiry := v_emp_record.date_of_expiry;
            v_address_primary := 1;
			
            -- Transformations prefix
            IF v_emp_record.prefixs = 'นาย' THEN
                v_prefix := 1;
            ELSIF v_emp_record.prefixs = 'นาง' THEN
                v_prefix := 2;
            ELSIF v_emp_record.prefixs = 'นางสาว' THEN
                v_prefix := 3;
            ELSE
                v_prefix := NULL; 
            END IF;
        
            v_first_name_th := v_emp_record.first_name_th;
            v_last_name_th := v_emp_record.last_name_th;
            v_first_name_eng := v_emp_record.first_name_eng;
            v_last_name_eng := v_emp_record.last_name_eng;
            v_birth_of_day := v_emp_record.birth_of_day;
            v_phone_number := REPLACE(v_emp_record.phone_number, '-', '');
            v_email := v_emp_record.email;
            v_address_id := v_emp_record.address_id;
            v_street := v_emp_record.street;
            v_sub_district := v_emp_record.sub_district;
            v_district := v_emp_record.district;
            v_province := v_emp_record.province;
            v_country := v_emp_record.country;
            v_postal_code := v_emp_record.postal_code;
            v_Deposit_account := v_emp_record.Deposit_account;

            -- Transform branch_id
            SELECT NVL(b.branch_id, 9999)
            INTO v_branch_id
            FROM dep.branches b
            WHERE b.branch_name = v_emp_record.branch_name;

            -- Transform product_id
            SELECT p.product_type, p.product_id, p.interest_rate
            INTO v_product_type, v_product_id, v_interest_rate
            FROM dep.products p
            WHERE p.product_type = v_emp_record.product_type
            AND p.product_id = v_emp_record.product_id;
			

            INSERT INTO dep.card_id (
                card_id, 
                back_card_id, 
                date_of_issue, 
                date_of_expiry, 
                mod_user, 
                mod_date)
            VALUES (
                v_card_id, 
                v_back_id_card, 
                v_date_of_lssue, 
                v_date_of_expiry, 
                v_emp_record.load_user, 
                v_emp_record.load_date);


            INSERT INTO dep.card_detail (
                card_id, 
                address_primary, 
                prefixs, 
                first_name_th, 
                last_name_th,
                first_name_eng, 
                last_name_eng, 
                birth_of_day, 
                phone_number, 
                email,
                address_id, 
                street, 
                sub_district, 
                district, 
                province, 
                country,
                postal_code, 
                mod_user, 
                mod_date)
            VALUES (
                v_card_id,
                v_address_primary, 
                v_prefix, 
                v_first_name_th,
                v_last_name_th,
                v_first_name_eng, 
                v_last_name_eng, 
                v_birth_of_day, 
                v_phone_number,
                v_email,
                v_address_id, 
                v_street, 
                v_sub_district,
                v_district,
                v_province,
                v_country,
                v_postal_code,
                v_emp_record.load_user,
                v_emp_record.load_date);
        END IF;
        
        -- If l_id_card = 1, only insert into dep.Deposit_account
        IF l_id_card = 1 OR l_id_card = 0 THEN
            -- Insert into dep.Deposit_account
            INSERT INTO dep.Deposit_account (
                card_id, 
                Deposit_account_id, 
                branch_id,
                product_type, 
                product_id, 
                interest_rate, 
                mod_user,
                mod_date)
            VALUES (
                v_card_id,
                v_Deposit_account,
                v_branch_id, 
                v_product_type, 
                v_product_id, 
                v_interest_rate,
                v_emp_record.load_user, 
                v_emp_record.load_date);
        END IF;

        UPDATE raw_data.temp_batch_source se
        SET se.load_flag = 'Y'
        WHERE se.card_id = v_card_id
        AND se.Deposit_account_id = v_Deposit_account
		;
        
    END LOOP;


    CLOSE source_cursor;


    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred during the ETL process: ' || SQLERRM);
        RAISE;
END run_etl_dep;
/