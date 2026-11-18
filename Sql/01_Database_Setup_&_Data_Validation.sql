CREATE DATABASE banking_analytics;

USE banking_analytics;

-- import table and validat one by one
-- customers
# total record check 

SELECT COUNT(*) AS total_customers
FROM customers;

DESCRIBE customers;

SELECT *FROM customers LIMIT 5;
 
SELECT
    COUNT(*) AS total_rows,
    COUNT(customer_id) AS non_null_ids,
    COUNT(DISTINCT customer_id) AS unique_ids
FROM customers;
-- set primary key

ALTER TABLE customers
MODIFY customer_id INT NOT NULL,
ADD PRIMARY KEY (customer_id);

-- foreign key
ALTER TABLE customers
ADD CONSTRAINT fk_customers_counties
FOREIGN KEY (county_id)
REFERENCES counties(county_id);

DESCRIBE customers;
SHOW CREATE TABLE customers;

-- counties

SELECT COUNT(*) AS total_counties
FROM counties;

SELECT
    COUNT(*) AS total_rows,
    COUNT(county_id) AS non_null_ids,
    COUNT(DISTINCT county_id) AS unique_ids
FROM counties;

-- set primary key
ALTER TABLE counties
MODIFY county_id INT NOT NULL,
ADD PRIMARY KEY (county_id);

DESCRIBE counties;



-- accounts
SELECT COUNT(*) AS total_accounts
FROM accounts;

SELECT
    COUNT(*) AS total_rows,
    COUNT(account_id) AS non_null_ids,
    COUNT(DISTINCT account_id) AS unique_ids
FROM accounts;

-- set primary key

ALTER TABLE accounts
MODIFY account_id INT NOT NULL,
ADD PRIMARY KEY (account_id);

-- set foreign key 
ALTER TABLE accounts
ADD CONSTRAINT fk_accounts_counties
FOREIGN KEY (county_id)
REFERENCES counties(county_id);

DESCRIBE accounts;
SHOW CREATE TABLE accounts;



-- account_holders
SELECT COUNT(*) AS total_account_holders
FROM account_holders;

SELECT
    COUNT(*) AS total_rows,
    COUNT(holder_id) AS non_null_ids,
    COUNT(DISTINCT holder_id) AS unique_ids
FROM account_holders;

-- primary key 
ALTER TABLE account_holders
MODIFY holder_id INT NOT NULL,
ADD PRIMARY KEY (holder_id);

-- Customer Foreign Key
ALTER TABLE account_holders
ADD CONSTRAINT fk_holders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

-- Account Foreign Key
ALTER TABLE account_holders
ADD CONSTRAINT fk_holders_accounts
FOREIGN KEY (account_id)
REFERENCES accounts(account_id);

SHOW CREATE TABLE account_holders;


-- Transactions
SELECT COUNT(*) AS total_transactions
FROM transactions;

SELECT
    COUNT(*) AS total_rows,
    COUNT(transaction_id) AS non_null_ids,
    COUNT(DISTINCT transaction_id) AS unique_ids
FROM transactions;


-- primary key
ALTER TABLE transactions
MODIFY transaction_id INT NOT NULL,
ADD PRIMARY KEY (transaction_id);

-- Foreign key
ALTER TABLE transactions
ADD CONSTRAINT fk_transactions_accounts
FOREIGN KEY (account_id)
REFERENCES accounts(account_id);

SHOW CREATE TABLE transactions;


-- loan 
SELECT COUNT(*) AS total_loans
FROM loans;

DESCRIBE loans;
SELECT
    COUNT(*) AS total_rows,
    COUNT(loan_id) AS non_null_ids,
    COUNT(DISTINCT loan_id) AS unique_ids
FROM loans;

-- primary key
ALTER TABLE loans
MODIFY loan_id INT NOT NULL,
ADD PRIMARY KEY (loan_id);

-- foreign key
ALTER TABLE loans
ADD CONSTRAINT fk_loans_accounts
FOREIGN KEY (account_id)
REFERENCES accounts(account_id);

SHOW CREATE TABLE loans;



-- CARDS
SELECT  COUNT(*) total_card FROM cards;
DESCRIBE cards;

SELECT
    COUNT(*) AS total_rows,
    COUNT(card_id) AS non_null_ids,
    COUNT(DISTINCT card_id) AS unique_ids
FROM cards;

-- primary key
ALTER TABLE cards
MODIFY card_id INT NOT NULL,
ADD PRIMARY KEY (card_id);

SELECT COUNT(*) AS orphan_holders
FROM cards c
LEFT JOIN account_holders ah
    ON c.holder_id = ah.holder_id
WHERE ah.holder_id IS NULL;

-- foreign key
ALTER TABLE cards
ADD CONSTRAINT fk_cards_account_holders
FOREIGN KEY (holder_id)
REFERENCES account_holders(holder_id);

SHOW CREATE TABLE cards;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------- validation ------------------------------------------------------------------------------------

SELECT 'customers' AS table_name, COUNT(*) AS total_records FROM customers
UNION ALL
SELECT 'counties', COUNT(*) FROM counties
UNION ALL
SELECT 'accounts', COUNT(*) FROM accounts
UNION ALL
SELECT 'account_holders', COUNT(*) FROM account_holders
UNION ALL
SELECT 'transactions', COUNT(*) FROM transactions
UNION ALL
SELECT 'loans', COUNT(*) FROM loans
UNION ALL
SELECT 'cards', COUNT(*) FROM cards;


------------------------------------------------------------------ primary key Validation ----------------------------------------------------------

SELECT
    COUNT(*) AS total_rows,
    COUNT(customer_id) AS non_null_ids,
    COUNT(DISTINCT customer_id) AS unique_ids
FROM customers;

SELECT
    COUNT(*) AS total_rows,
    COUNT(county_id) AS non_null_ids,
    COUNT(DISTINCT county_id) AS unique_ids
FROM counties;

SELECT
    COUNT(*) AS total_rows,
    COUNT(account_id) AS non_null_ids,
    COUNT(DISTINCT account_id) AS unique_ids
FROM accounts;

SELECT
    COUNT(*) AS total_rows,
    COUNT(holder_id) AS non_null_ids,
    COUNT(DISTINCT holder_id) AS unique_ids
FROM account_holders;

SELECT
    COUNT(*) AS total_rows,
    COUNT(transaction_id) AS non_null_ids,
    COUNT(DISTINCT transaction_id) AS unique_ids
FROM transactions;

SELECT
    COUNT(*) AS total_rows,
    COUNT(loan_id) AS non_null_ids,
    COUNT(DISTINCT loan_id) AS unique_ids
FROM loans;

SELECT
    COUNT(*) AS total_rows,
    COUNT(card_id) AS non_null_ids,
    COUNT(DISTINCT card_id) AS unique_ids
FROM cards;



----------------------------------------------------------------- foreign key Validation -----------------------------------------------------------------


SELECT COUNT(*) AS orphan_counties
FROM accounts a
LEFT JOIN counties c
    ON a.county_id = c.county_id
WHERE c.county_id IS NULL;

SELECT COUNT(*) AS orphan_counties
FROM customers c
LEFT JOIN counties co
    ON c.county_id = co.county_id
WHERE co.county_id IS NULL;

SELECT COUNT(*) AS orphan_customers
FROM account_holders ah
LEFT JOIN customers c
    ON ah.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT COUNT(*) AS orphan_accounts
FROM account_holders ah
LEFT JOIN accounts a
    ON ah.account_id = a.account_id
WHERE a.account_id IS NULL;

SELECT COUNT(*) AS orphan_accounts
FROM transactions t
LEFT JOIN accounts a
    ON t.account_id = a.account_id
WHERE a.account_id IS NULL;

SELECT COUNT(*) AS orphan_accounts
FROM loans l
LEFT JOIN accounts a
    ON l.account_id = a.account_id
WHERE a.account_id IS NULL;

SELECT COUNT(*) AS orphan_holders
FROM cards c
LEFT JOIN account_holders ah
    ON c.holder_id = ah.holder_id
WHERE ah.holder_id IS NULL;

---------------------------------------------------------------------- Missing Values Validation ----------------------------------------------------------------------------------

SELECT
    COUNT(*) AS total_rows,
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(full_name IS NULL) AS missing_full_name,
    SUM(gender IS NULL) AS missing_gender,
    SUM(birth_year IS NULL) AS missing_birth_year,
    SUM(county_id IS NULL) AS missing_county_id
FROM customers;


SELECT
    COUNT(*) AS total_rows,
    SUM(county_id IS NULL) AS missing_county_id,
    SUM(county IS NULL) AS missing_county_name
FROM counties;


SELECT
    COUNT(*) AS total_rows,
    SUM(account_id IS NULL) AS missing_account_id,
    SUM(account_type IS NULL) AS missing_account_type,
    SUM(opened_date IS NULL) AS missing_opened_date,
    SUM(statement_frequency IS NULL) AS missing_statement_frequency,
    SUM(county_id IS NULL) AS missing_county_id
FROM accounts;



SELECT
    COUNT(*) AS total_rows,
    SUM(holder_id IS NULL) AS missing_holder_id,
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(account_id IS NULL) AS missing_account_id,
    SUM(holder_type IS NULL) AS missing_holder_type
FROM account_holders;



SELECT
    COUNT(*) AS total_rows,
    SUM(transaction_id IS NULL) AS missing_transaction_id,
    SUM(account_id IS NULL) AS missing_account_id,
    SUM(txn_date IS NULL) AS missing_txn_date,
    SUM(txn_type IS NULL) AS missing_txn_type,
    SUM(channel IS NULL) AS missing_channel,
    SUM(purpose IS NULL) AS missing_purpose,
    SUM(amount_kes IS NULL) AS missing_amount,
    SUM(balance_kes IS NULL) AS missing_balance
FROM transactions;

SELECT
    COUNT(*) AS total_rows,
    SUM(loan_id IS NULL) AS missing_loan_id,
    SUM(account_id IS NULL) AS missing_account_id,
    SUM(loan_date IS NULL) AS missing_loan_date,
    SUM(amount_kes IS NULL) AS missing_amount,
    SUM(duration_months IS NULL) AS missing_duration,
    SUM(monthly_payment_kes IS NULL) AS missing_monthly_payment,
    SUM(status IS NULL) AS missing_status
FROM loans;


SELECT
    COUNT(*) AS total_rows,
    SUM(card_id IS NULL) AS missing_card_id,
    SUM(holder_id IS NULL) AS missing_holder_id,
    SUM(card_type IS NULL) AS missing_card_type,
    SUM(issued_date IS NULL) AS missing_issued_date
FROM cards;


----------------------------------------------------------------- Data Type Validation ---------------------------------------------------------------------


DESCRIBE customers;
DESCRIBE counties;
DESCRIBE accounts;
DESCRIBE account_holders;
DESCRIBE transactions;
DESCRIBE loans;
DESCRIBE cards;

---------------------------------------------------------- Date format validation and change data type ------------------------------------------------------------------------------------
SELECT opened_date FROM accounts LIMIT 10;

SELECT
    COUNT(*) AS total_rows,
    SUM(STR_TO_DATE(opened_date, '%Y-%m-%d') IS NULL) AS invalid_dates
FROM accounts;

ALTER TABLE accounts MODIFY opened_date DATE;

DESCRIBE accounts;

----------------------------------------------------
SELECT
    COUNT(*) AS total_rows,
    SUM(STR_TO_DATE(txn_date, '%Y-%m-%d') IS NULL) AS invalid_dates
FROM transactions;

ALTER TABLE transactions
MODIFY txn_date DATE;

DESCRIBE transactions;

--------------------------------------------------
SELECT
    COUNT(*) AS total_rows,
    SUM(STR_TO_DATE(loan_date, '%Y-%m-%d') IS NULL) AS invalid_dates
FROM loans;

ALTER TABLE loans
MODIFY loan_date DATE;

DESCRIBE loans;

-------------------------------------------------------
SELECT
    COUNT(*) AS total_rows,
    SUM(STR_TO_DATE(issued_date, '%Y-%m-%d') IS NULL) AS invalid_dates
FROM cards;

ALTER TABLE cards
MODIFY issued_date DATE;

DESCRIBE cards;
























