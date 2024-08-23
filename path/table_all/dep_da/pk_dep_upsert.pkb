CREATE OR REPLACE PACKAGE BODY pk_dep_upsert AS


PROCEDURE process_save(p_profile_save IN ut_card_detail_type_table) IS
BEGIN
    -- Loop through the collection and process each card detail
    FOR i IN 1..p_profile_save.COUNT LOOP
        -- Call the update_card_detail procedure using the values from the current object
		
		if p_profile_save(i).control_screen='card_details' then 
		
		
		if p_profile_save(i).dml_type='U' then
		
        update_card_detail(
            p_card_id         => p_profile_save(i).card_id,
            p_address_primary => p_profile_save(i).address_primary,
            p_prefixs         => p_profile_save(i).prefixs,
            p_first_name_th   => p_profile_save(i).first_name_th,
            p_last_name_th    => p_profile_save(i).last_name_th,
            p_first_name_eng  => p_profile_save(i).first_name_eng,
            p_last_name_eng   => p_profile_save(i).last_name_eng,
            p_birth_of_day    => p_profile_save(i).birth_of_day,
            p_phone_number    => p_profile_save(i).phone_number,
            p_email           => p_profile_save(i).email,
            p_address_id      => p_profile_save(i).address_id,
            p_street          => p_profile_save(i).street,
            p_sub_district    => p_profile_save(i).sub_district,
            p_district        => p_profile_save(i).district,
            p_province        => p_profile_save(i).province,
            p_country         => p_profile_save(i).country,
            p_postal_code     => p_profile_save(i).postal_code,
            p_mod_user        => p_profile_save(i).mod_user,
            p_mod_date        => p_profile_save(i).mod_date
        );
		
		
		end if ;
		
		
		end if ;
		
    END LOOP;

    -- Optional: Output a message when the loop is complete
    DBMS_OUTPUT.PUT_LINE('Processing complete for all card details.');
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'An unexpected error occurred: ' || SQLERRM);
END process_save
;


-- procedure for upsert_card_detail

PROCEDURE upsert_card_detail(
    p_card_id         IN NUMBER,
    p_address_primary IN INTEGER,
    p_prefixs         IN INTEGER,
    p_first_name_th   IN VARCHAR2,
    p_last_name_th    IN VARCHAR2,
    p_first_name_eng  IN VARCHAR2,
    p_last_name_eng   IN VARCHAR2,
    p_birth_of_day    IN DATE,
    p_phone_number    IN NUMBER,
    p_email           IN VARCHAR2,
    p_address_id      IN VARCHAR2,
    p_street          IN VARCHAR2,
    p_sub_district    IN VARCHAR2,
    p_district        IN VARCHAR2,
    p_province        IN VARCHAR2,
    p_country         IN VARCHAR2,
    p_postal_code     IN VARCHAR2,
    p_mod_user        IN VARCHAR2,
    p_mod_date        IN DATE
) IS
BEGIN

   UPDATE dep.card_detail
    SET 
        prefixs = p_prefixs,
        first_name_th = p_first_name_th,
        last_name_th = p_last_name_th,
        first_name_eng = p_first_name_eng,
        last_name_eng = p_last_name_eng,
        birth_of_day = p_birth_of_day,
        phone_number = p_phone_number,
        email = p_email,
        address_id = p_address_id,
        street = p_street,
        sub_district = p_sub_district,
        district = p_district,
        province = p_province,
        country = p_country,
        postal_code = p_postal_code,
        mod_user = p_mod_user,
        mod_date = p_mod_date
    WHERE card_id = p_card_id
	and address_primary = p_address_primary
	;


    EXCEPTION
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20003, 'An unexpected error occurred: ' || SQLERRM);
END upsert_card_detail;

	
	
END pk_dep_upsert;
/