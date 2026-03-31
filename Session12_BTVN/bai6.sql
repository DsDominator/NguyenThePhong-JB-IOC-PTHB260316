CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    account_name VARCHAR(50),
    balance NUMERIC
);

INSERT INTO accounts (account_name, balance)
VALUES 
('A', 1000),
('B', 500);

CREATE OR REPLACE PROCEDURE transfer_money(
    sender TEXT,
    receiver TEXT,
    amount NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    sender_balance NUMERIC;
BEGIN
    BEGIN
        SELECT balance INTO sender_balance
        FROM accounts
        WHERE account_name = sender
        FOR UPDATE;

        IF sender_balance >= amount THEN
            
            UPDATE accounts
            SET balance = balance - amount
            WHERE account_name = sender;

            UPDATE accounts
            SET balance = balance + amount
            WHERE account_name = receiver;

            RAISE NOTICE 'Transfer successful';
            
            COMMIT; 

        ELSE
            RAISE NOTICE 'Not enough balance';
            
            ROLLBACK; 
        END IF;
    END;
END;
$$;

CALL transfer_money('A', 'B', 300);
CALL transfer_money('A', 'B', 2000);

SELECT * FROM accounts;