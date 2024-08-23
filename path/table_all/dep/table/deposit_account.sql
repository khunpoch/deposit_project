CREATE TABLE dep.Deposit_account (
    card_id NUMBER(13),
    Deposit_account_id VARCHAR2(12),
    branch_id INTEGER,
    product_type INTEGER,
    product_id INTEGER,
    interest_rate NUMBER,
    mod_user VARCHAR2(100),
    mod_date DATE,
    PRIMARY KEY (card_id, Deposit_account_id),
    FOREIGN KEY (card_id) REFERENCES some_other_table(card_id),
    FOREIGN KEY (branch_id) REFERENCES some_other_table(branch_id),
    FOREIGN KEY (product_type) REFERENCES some_other_table(product_type),
    FOREIGN KEY (product_id) REFERENCES some_other_table(product_id)
);

CREATE INDEX idx_card_id ON dep.Deposit_account(card_id);
CREATE INDEX idx_deposit_account_id ON dep.Deposit_account(Deposit_account_id);
CREATE INDEX idx_branch_id ON dep.Deposit_account(branch_id);
CREATE INDEX idx_product_type ON dep.Deposit_account(product_type);
CREATE INDEX idx_product_id ON dep.Deposit_account(product_id);
CREATE INDEX idx_branch_product ON dep.Deposit_account(branch_id, product_type, product_id);






