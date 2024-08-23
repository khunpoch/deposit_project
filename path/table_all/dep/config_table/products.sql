begin

INSERT INTO dep.products (product_type, product_id, product_type_name, product_id_name, interest_rate) VALUES ('001', 1, 'เดบิต', 'A', 0.00);
INSERT INTO dep.products (product_type, product_id, product_type_name, product_id_name, interest_rate) VALUES ('001', 2, 'เดบิต', 'AAA', 0.50);
INSERT INTO dep.products (product_type, product_id, product_type_name, product_id_name, interest_rate) VALUES ('001', 3, 'เดบิต', 'AAAA', 1.50);
INSERT INTO dep.products (product_type, product_id, product_type_name, product_id_name, interest_rate) VALUES ('002', 1, 'ออม', 'B', 1.25);
INSERT INTO dep.products (product_type, product_id, product_type_name, product_id_name, interest_rate) VALUES ('002', 2, 'ออม', 'BB', 1.10);
INSERT INTO dep.products (product_type, product_id, product_type_name, product_id_name, interest_rate) VALUES ('002', 3, 'ออม', 'BBB', 2.00);
INSERT INTO dep.products (product_type, product_id, product_type_name, product_id_name, interest_rate) VALUES ('003', 1, 'ประจำ', 'C', 5.25);
INSERT INTO dep.products (product_type, product_id, product_type_name, product_id_name, interest_rate) VALUES ('003', 2, 'ประจำ', 'CC', 4.00);
INSERT INTO dep.products (product_type, product_id, product_type_name, product_id_name, interest_rate) VALUES ('003', 3, 'ประจำ', 'CCC', 7.00);

commit ;
end ;