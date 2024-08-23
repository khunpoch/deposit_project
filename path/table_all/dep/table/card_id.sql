CREATE TABLE dep_card_id (
    card_id       NUMBER(13) PRIMARY KEY,
    back_card_id  VARCHAR2(12),
    date_of_issue DATE,
    date_of_expiry DATE,
    mod_user      VARCHAR2(255),
    mod_date      DATE
);

CREATE INDEX idx_card_id ON dep.card_id(card_id);
