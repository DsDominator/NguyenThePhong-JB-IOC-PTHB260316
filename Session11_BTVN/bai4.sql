CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    balance NUMERIC(12,2) 
);

CREATE TABLE transactions (
    trans_id SERIAL PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id) ,
    amount NUMERIC(12,2) ,
    trans_type VARCHAR(20) ,
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO accounts (customer_name, balance)
VALUES
('Nguyen Van A', 1000.00),
('Tran Thi B', 500.00),
('Le Van C', 200.00);

CREATE OR REPLACE PROCEDURE withdraw_money(
    p_account_id INT,
    p_amount NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_balance NUMERIC;
BEGIN
    BEGIN
        SELECT balance INTO v_balance
        FROM accounts
        WHERE account_id = p_account_id
        FOR UPDATE;

        IF v_balance IS NULL THEN
            RAISE EXCEPTION 'Account not found';
        END IF;

        IF v_balance < p_amount THEN
            RAISE EXCEPTION 'Insufficient balance';
        END IF;

        UPDATE accounts
        SET balance = balance - p_amount
        WHERE account_id = p_account_id;

        INSERT INTO transactions (account_id, amount, trans_type)
        VALUES (p_account_id, p_amount, 'WITHDRAW');

        COMMIT;

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE NOTICE 'Transaction failed: %', SQLERRM;
    END;
END;
$$;

CALL withdraw_money(1, 100);