OPTIONS (SKIP=1)
LOAD DATA
INFILE 'latest_file.csv'
INTO TABLE temp_batch_source
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
(
  id_card ,
  back_id_card ,
  date_of_lssue DATE "MM/DD/YYYY",
  date_of_expiry DATE "MM/DD/YYYY",
  prefix ,
  first_name_th ,
  last_name_th ,
  first_name_eng ,
  last_name_eng ,
  birth_of_day DATE "MM/DD/YYYY",
  phone_number ,
  email ,
  address_id ,
  street ,
  sub_district ,
  district ,
  province ,
  country ,
  postal_code ,
  Deposit_account ,
  branch_id ,
  product_id ,
  product_type ,
  load_flag CONSTANT "N",
  load_user CONSTANT "source_control_1",
  load_date "NVL(:load_date, SYSDATE)"
)

