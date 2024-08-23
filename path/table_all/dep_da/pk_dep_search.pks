CREATE OR REPLACE PACKAGE dep_da.pk_dep_search AS
   
      PROCEDURE search_card_details (
    p_card_id         IN NUMBER,
    p_first_name_th   IN VARCHAR2,
    p_last_name_th    IN VARCHAR2,
    p_first_name_eng  IN VARCHAR2,
    p_last_name_eng   IN VARCHAR2,
    p_phone_number    IN NUMBER,
    p_result_cur      OUT SYS_REFCURSOR
) ;


PROCEDURE get_prefix_list(
    p_prefix_cur OUT SYS_REFCURSOR
) ;
	
END pk_dep_search ;
/
