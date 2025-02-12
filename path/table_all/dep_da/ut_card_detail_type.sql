CREATE OR REPLACE TYPE ut_card_detail_type AS OBJECT(
	transection_id   number,
    dml_type	     char(1),
	control_screen	 VARCHAR2(100),
    card_id          NUMBER(13),
    address_primary  INTEGER,
    prefixs           INTEGER,
    first_name_th    VARCHAR2(255),
    last_name_th     VARCHAR2(255),
    first_name_eng   VARCHAR2(255),
    last_name_eng    VARCHAR2(255),
    birth_of_day     DATE,
    phone_number     NUMBER(15),
    email            VARCHAR2(255),
    address_id       VARCHAR2(255),
    street           VARCHAR2(255),
    sub_district     VARCHAR2(255),
    district         VARCHAR2(255),
    province         VARCHAR2(255),
    country          VARCHAR2(255),
    postal_code      VARCHAR2(255),
    mod_user         VARCHAR2(255),
    mod_date         DATE,
	Empty_column1    VARCHAR2(2000),
	Empty_column2    VARCHAR2(2000),
	Empty_column3    VARCHAR2(2000),
	Empty_column4    VARCHAR2(2000),
	Empty_column5    VARCHAR2(2000),
	Empty_column6    VARCHAR2(2000),
	Empty_column7    VARCHAR2(2000),
	Empty_column8    VARCHAR2(2000),
	Empty_column9    VARCHAR2(2000),
	Empty_column10    VARCHAR2(2000)

 );