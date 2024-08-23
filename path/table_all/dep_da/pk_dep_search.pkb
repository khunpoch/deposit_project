CREATE OR REPLACE PACKAGE BODY dep_da.pk_dep_search AS

    PROCEDURE search_card_details (
    p_card_id         IN NUMBER,
    p_first_name_th   IN VARCHAR2,
    p_last_name_th    IN VARCHAR2,
    p_first_name_eng  IN VARCHAR2,
    p_last_name_eng   IN VARCHAR2,
    p_phone_number    IN NUMBER,
    p_result_cur      OUT SYS_REFCURSOR
) IS
BEGIN
    OPEN p_result_cur FOR
    SELECT card_id,
           back_card_id,
           date_of_issue,
           date_of_expiry,
           prefix,
           first_name_th,
           last_name_th,
           first_name_eng,
           last_name_eng,
           birth_of_day,
           email,
           phone_number,
           address_id,
           street,
           sub_district,
           district,
           province,
           country,
           postal_code
    FROM dep.card_detail
    WHERE (p_card_id IS NULL OR card_id = p_card_id)
      AND (p_first_name_th IS NULL OR first_name_th LIKE '%' || p_first_name_th || '%')
      AND (p_last_name_th IS NULL OR last_name_th LIKE '%' || p_last_name_th || '%')
      AND (p_first_name_eng IS NULL OR first_name_eng LIKE '%' || p_first_name_eng || '%')
      AND (p_last_name_eng IS NULL OR last_name_eng LIKE '%' || p_last_name_eng || '%')
      AND (p_phone_number IS NULL OR phone_number = p_phone_number)
	  ;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'No data found for the provided card_id: ' || p_card_id);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'An unexpected error occurred: ' || SQLERRM);
END search_card_details ;


PROCEDURE get_prefix_list(
    p_prefix_cur OUT SYS_REFCURSOR
) IS
BEGIN
    -- Open a cursor for the drop-down list data
    OPEN p_prefix_cur FOR
    SELECT prefix_id, prefix_name
    FROM dep.prefixs
    ORDER BY prefix_name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'An error occurred while fetching prefix data: ' || SQLERRM);
		
END get_prefix_list;

END pk_dep_search ;
/
