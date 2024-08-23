CREATE OR REPLACE PACKAGE dep_da.pk_dep_read AS

     PROCEDURE card_id(p_cursor OUT SYS_REFCURSOR,
			          p_card_id	in number)
	) ;
	
	 PROCEDURE card_detail(p_cursor OUT SYS_REFCURSOR,
			              p_card_id	in number)
	) ;
	
	  PROCEDURE Deposit_account(p_cursor OUT SYS_REFCURSOR,
			              p_card_id	in number)
	) ;
	
END pk_dep_read;
/
