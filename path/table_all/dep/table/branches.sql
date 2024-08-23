CREATE TABLE dep.branches (
    branch_id NUMBER(13) PRIMARY KEY,
    branch_name VARCHAR2(255),
    mod_user VARCHAR2(100),
    mod_date DATE
);