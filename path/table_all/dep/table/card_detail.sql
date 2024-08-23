CREATE TABLE dep_card_detail (
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
    PRIMARY KEY (card_id, address_primary),
    FOREIGN KEY (card_id) REFERENCES dep_card_id(card_id)
);


CREATE INDEX idx_card_id ON dep.card_detail(card_id);
CREATE INDEX idx_card_id_address_primary ON dep.card_detail(card_id, address_primary);
