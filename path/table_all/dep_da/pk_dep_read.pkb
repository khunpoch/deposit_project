CREATE OR REPLACE PACKAGE BODY dep_da.pk_dep_read AS
    -- Define the procedure that returns the card IDs
    PROCEDURE card_id(p_cursor OUT SYS_REFCURSOR,
			          p_card_id	in number)
	) IS
    BEGIN
        -- Open the cursor for a query
        OPEN p_cursor FOR
		
        SELECT *
        FROM dep.card_id cd
		where cd.card_id=p_card_id
		; 
		
    END card_id
	;
	
	


	  -- Define the procedure that returns the card_detail
    PROCEDURE card_detail(p_cursor OUT SYS_REFCURSOR,
			              p_card_id	in number)
	) IS
    BEGIN
        -- Open the cursor for a query
        OPEN p_cursor FOR
		
        SELECT ce.*,(select prefix_name from dep.prefixs p where p.prefix_id=ce.prefix) prefix_name
        FROM dep.card_detail ce
		where 1=1
		and ce.address_primary=(select MAX(co2.address_primary)
                                  from dep.card_detail co2
                                  where co2.card_id=ce.card_id )
		and ce.card_id=p_card_id						  
		; 

		
    END card_detail 
	;
	
	
	  -- Define the procedure that returns the Deposit_account
    PROCEDURE Deposit_account(p_cursor OUT SYS_REFCURSOR,
			              p_card_id	in number)
	) IS
    BEGIN
        -- Open the cursor for a query
        OPEN p_cursor FOR
		
        SELECT da.*
		,(select b.branch_name from dep.branches b where 1=1 and b.branch_id=da.branch_id) branch_name
		,(select p.product_type_name  from dep.products p where p.product_type=da.product_type and p.product_id=da.product_id ) product_type_name
		,(select p.product_id_name  from dep.products p where p.product_type=da.product_type and p.product_id=da.product_id ) product_id_name
        FROM dep.Deposit_account da
		where 1=1
		and ce.card_id=p_card_id						  
		; 
		
		
    END Deposit_account 
	;
	
	
	
	
	
	
END pk_dep_read;
/
