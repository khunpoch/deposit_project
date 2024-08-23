CREATE OR REPLACE PACKAGE pk_dep_upsert AS

 --font-end call process_save 
 PROCEDURE process_save(p_profile_save IN ut_card_detail_type_table) ;
 
    -- Procedure for upserting card details
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
) ;





END pk_dep_upsert;
/