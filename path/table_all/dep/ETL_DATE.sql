DECLARE
    CURSOR source_cursor IS
       select *
	   from raw_data.temp_batch_source
	   where load_flag='N' 
	   ;
   v_emp_record  source_cursor%ROWTYPE;
   
   --variables constant
v_card_id	number(13)	;
v_back_id_card	varchar2(12)	;
v_date_of_lssue	date	;
v_date_of_expiry	date	;
v_prefix	integer	;
v_first_name_th	varchar2(255)	;
v_last_name_th	varchar2(255)	;
v_first_name_eng	varchar2(255)	;
v_last_name_eng	varchar2(255)	;
v_birth_of_day	date	;
v_phone_number	NUMBER(15)	;
v_email	varchar2(255)	;
v_address_id	varchar2(255)	;
v_street	varchar2(255)	;
v_sub_district	varchar2(255)	;
v_district	varchar2(255)	;
v_province	varchar2(255)	;
v_country	varchar2(255)	;
v_postal_code	varchar2(255)	;
v_Deposit_account	number	;
v_branch_id	integer	;
v_product_id	integer	;
v_product_type	integer	;
v_interest_rate	number	;
v_load_flag	char(1)	;

v_address_primary integer	;

l_id_card integer ;
l_address_primary integer ;

   
  
BEGIN
    -- Open the cursor and fetch each row
    OPEN source_cursor;
    LOOP
        FETCH source_cursor INTO v_emp_record ;
        EXIT WHEN source_cursor%NOTFOUND;
        
        -- Transformation logic
		--check card id 
		select count(1)
		into l_id_card
		from dep.card_id c
		where c.card_id=v_emp_record.card_id
		;
		
		if l_id_card =0 THEN
		
		v_card_id:=v_emp_record.card_id ;
		v_back_id_card:=v_emp_record.back_id_card ;
		v_date_of_lssue:=v_emp_record.date_of_lssue ;
		v_date_of_expiry:=v_emp_record.date_of_expiry ;
		v_address_primary:=1;
		
		--Transformation prefix
		if v_emp_record.prefixs='นาย' THEN
		 v_prefix:=1 ;
		
		ELSIF v_emp_record.prefixs='นาง'	THEN
		v_prefix:=2;
		ELSIF v_emp_record.prefixs='นางสาว'	THEN
		v_prefix:=3;
		
		end if ;
		v_first_name_th:=v_emp_record.first_name_th		;
	    v_last_name_th:=v_emp_record.last_name_th	 ;
		v_first_name_eng:=v_emp_record.first_name_eng ;		
		v_last_name_eng	:=v_emp_record.last_name_eng;		
		v_birth_of_day:=v_emp_record.birth_of_day ;	
		v_phone_number:= REPLACE(v_emp_record.phone_number, '-', '');
		v_email:=v_emp_record.email ;
		v_address_id:=v_emp_record.address_id		;
	    v_street:=v_emp_record.street		;
	    v_sub_district:=v_emp_record.sub_district		;
	    v_district:=v_emp_record.district		;
	    v_province:=v_emp_record.province	;
		v_country:=v_emp_record.country		;
	    v_postal_code:=v_emp_record.postal_code	;		
		
		v_Deposit_account:=v_emp_record.Deposit_account;
		
		--Transformation branch_id
		select NVL(b.branch_id,9999)
		into v_branch_id
		from dep.branches b
		where b.branch_name=v_emp_record.branch_name ;
		--Transformation product_id
		
		select p.product_type,p.product_id,p.interest_rate
		into v_product_type,v_product_id,v_interest_rate
		from dep.products p
		where p.product_type=v_emp_record.product_type 
		and p.product_id=v_emp_record.product_id
		;

		ELSE
		
	    v_card_id:=v_emp_record.card_id ;
		v_back_id_card:=v_emp_record.back_id_card ;
		v_date_of_lssue:=v_emp_record.date_of_lssue ;
		v_date_of_expiry:=v_emp_record.date_of_expiry ;
		
		
		select count(1)
		into l_address_primary
		from dep.card_detail cd
		where cd.card_id=v_emp_record.card_id ;
		
		
		v_address_primary:=l_address_primary+1 ;

		
		
		--Transformation prefix
		if v_emp_record.prefixs='นาย' THEN
		 v_prefix:=1 ;
		
		ELSIF v_emp_record.prefixs='นาง'	THEN
		v_prefix:=2;
		ELSIF v_emp_record.prefixs='นางสาว'	THEN
		v_prefix:=3;
		
		end if ;
		v_first_name_th:=v_emp_record.first_name_th		;
	    v_last_name_th:=v_emp_record.last_name_th	 ;
		v_first_name_eng:=v_emp_record.first_name_eng ;		
		v_last_name_eng	:=v_emp_record.last_name_eng;		
		v_birth_of_day:=v_emp_record.birth_of_day ;	
		v_phone_number:= REPLACE(v_emp_record.phone_number, '-', '');
		v_email:=v_emp_record.email ;
		v_address_id:=v_emp_record.address_id		;
	    v_street:=v_emp_record.street		;
	    v_sub_district:=v_emp_record.sub_district		;
	    v_district:=v_emp_record.district		;
	    v_province:=v_emp_record.province	;
		v_country:=v_emp_record.country		;
	    v_postal_code:=v_emp_record.postal_code	;		
		
		v_Deposit_account:=v_emp_record.Deposit_account;
		
		--Transformation branch_id
		select NVL(b.branch_id,9999)
		into v_branch_id
		from dep.branches b
		where b.branch_name=v_emp_record.branch_name ;
		--Transformation product_id
		
		select p.product_type,p.product_id,p.interest_rate
		into v_product_type,v_product_id,v_interest_rate
		from dep.products p
		where p.product_type=v_emp_record.product_type 
		and p.product_id=v_emp_record.product_id
		;
		
		end if ;
		
	






        -- Load the transformed data into the target table
		--insert dep.card_id
        INSERT INTO dep.card_id (card_id, back_card_id, date_of_issue,date_of_expiry,mod_user,mod_date)
        VALUES (v_card_id,v_back_id_card, v_date_of_lssue, v_date_of_expiry,v_emp_record.load_user,v_emp_record.load_date);
		
		--insert dep.card_detail
        INSERT INTO dep.card_detail 
		(card_id,
		address_primary,
		prefixs,
		first_name_th,
		last_name_th,
		first_name_eng,
		last_name_eng,
		birth_of_day,
		phone_number,
		email,address_id,
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
		v_emp_record.load_date
		
		);
		
	    --insert dep.Deposit_account
        INSERT INTO dep.Deposit_account 
		(card_id,
	    Deposit_account_id,
	    branch_id,
	    product_type,
	    product_id,
		interest_rate,
		mod_user,
		mod_date
		)
        VALUES (
		v_card_id,
		v_Deposit_account,
	    v_branch_id,
		v_product_id,
		v_product_type,
		v_interest_rate,
		v_emp_record.load_user,
		v_emp_record.load_date

		);
		
		
		update raw_data.temp_batch_source se
		set se.load_flag='Y'
		where se.card_id=v_card_id
		and se.Deposit_account_id=v_Deposit_account
		;
		
		
		
    END LOOP;

    -- Close the cursor
    CLOSE source_cursor;

    COMMIT;
	
	EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
		
END;
/
