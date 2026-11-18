----------------------------------------------------------------- 1: County-wise Card Adoption Opportunity ------------------------------------------------

SELECT
    county,
    COUNT(*) AS total_customers,
    SUM(CASE
        WHEN card_count = 0 THEN 1
        ELSE 0
    END) AS customers_without_card,
    ROUND(
        SUM(CASE WHEN card_count = 0 THEN 1 ELSE 0 END)
        / COUNT(*) * 100, 2
    ) AS opportunity_percentage
FROM (
    SELECT
        c.customer_id,
        co.county,
        COUNT(DISTINCT ca.card_id) AS card_count
    FROM customers c
    JOIN counties co
        ON c.county_id = co.county_id
    LEFT JOIN account_holders ah
        ON c.customer_id = ah.customer_id
    LEFT JOIN cards ca
        ON ah.holder_id = ca.holder_id
    GROUP BY
        c.customer_id,
        co.county
) AS customer_cards
GROUP BY county
ORDER BY opportunity_percentage DESC;


---------------------------------------------------- 2 – Digital Transaction Opportunity ----------------------------------------------------------------

SELECT
    co.county,
    COUNT(t.transaction_id) AS total_transactions,
    SUM(CASE
        WHEN t.channel = 'M-Pesa' THEN 1
        ELSE 0
    END) AS mpesa_transactions,
    ROUND(
        SUM(CASE WHEN t.channel = 'M-Pesa' THEN 1 ELSE 0 END)
        / COUNT(t.transaction_id) * 100, 2
    ) AS mpesa_percentage
FROM accounts a
JOIN counties co
    ON a.county_id = co.county_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY co.county
ORDER BY mpesa_percentage DESC;



----------------------------------------------------------- 3 – Customers Without Loans ------------------------------------------------
SELECT
    county,
    COUNT(*) AS total_customers,
    SUM(CASE
        WHEN loan_count = 0 THEN 1
        ELSE 0
    END) AS customers_without_loan,
    ROUND(
        SUM(CASE WHEN loan_count = 0 THEN 1 ELSE 0 END)
        / COUNT(*) * 100, 2
    ) AS opportunity_percentage
FROM (
    SELECT
        c.customer_id,
        co.county,
        COUNT(DISTINCT l.loan_id) AS loan_count
    FROM customers c
    JOIN counties co
        ON c.county_id = co.county_id
    LEFT JOIN account_holders ah
        ON c.customer_id = ah.customer_id
    LEFT JOIN loans l
        ON ah.account_id = l.account_id
    GROUP BY
        c.customer_id,
        co.county
) AS customer_loans
GROUP BY county
ORDER BY opportunity_percentage DESC;




---------------------------------------------------- 4: Customer Engagement Opportunities ------------------------------------------------
SELECT
    customer_segment,
    COUNT(*) AS total_customers
FROM (
    SELECT
        ah.customer_id,
        CASE
            WHEN COUNT(t.transaction_id) <= 95
                THEN 'Low Activity'
            WHEN COUNT(t.transaction_id) <= 129
                THEN 'Medium Activity'
            ELSE 'High Activity'
        END AS customer_segment
    FROM account_holders ah
    JOIN transactions t
        ON ah.account_id = t.account_id
    GROUP BY ah.customer_id
) AS customer_data
GROUP BY customer_segment
ORDER BY total_customers DESC;



------------------------------------------------------------------------ 5 – Cardless Customers by Activity Segment ------------------------------------------------

SELECT
    activity_segment,
    COUNT(*) AS total_customers,
    SUM(CASE
        WHEN card_count = 0 THEN 1
        ELSE 0
    END) AS customers_without_card
FROM (
    SELECT
        customer_data.customer_id,
        customer_data.activity_segment,
        COUNT(DISTINCT ca.card_id) AS card_count
    FROM (
        SELECT
            ah.customer_id,
            CASE
                WHEN COUNT(t.transaction_id) <= 95
                    THEN 'Low Activity'
                WHEN COUNT(t.transaction_id) <= 129
                    THEN 'Medium Activity'
                ELSE 'High Activity'
            END AS activity_segment
        FROM account_holders ah
        JOIN transactions t
            ON ah.account_id = t.account_id
        GROUP BY ah.customer_id
    ) AS customer_data
    LEFT JOIN account_holders ah
        ON customer_data.customer_id = ah.customer_id
    LEFT JOIN cards ca
        ON ah.holder_id = ca.holder_id
    GROUP BY
        customer_data.customer_id,
        customer_data.activity_segment
) AS customer_segments
GROUP BY activity_segment;






-------------------------------------------------- 6: High Transaction Value Customers Without Cards ------------------------------------------------------

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE
        WHEN card_count = 0 THEN 1
        ELSE 0
    END) AS customers_without_card
FROM (
    SELECT
        customer_id,
        card_count,
        NTILE(3) OVER (
            ORDER BY total_transaction_value
        ) AS value_group
    FROM (
        SELECT
            td.customer_id,
            td.total_transaction_value,
            COALESCE(cd.card_count, 0) AS card_count
        FROM (
            SELECT
                ah.customer_id,
                SUM(t.amount_kes) AS total_transaction_value
            FROM account_holders ah
            JOIN transactions t
                ON ah.account_id = t.account_id
            GROUP BY ah.customer_id
        ) AS td
        LEFT JOIN (
            SELECT
                ah.customer_id,
                COUNT(DISTINCT ca.card_id) AS card_count
            FROM account_holders ah
            LEFT JOIN cards ca
                ON ah.holder_id = ca.holder_id
            GROUP BY ah.customer_id
        ) AS cd
            ON td.customer_id = cd.customer_id
    ) AS customer_data
) AS value_segments
WHERE value_group = 3;



-------------------------------------------------------------------- 7 – High Frequency Customers Without Cards ------------------------------------------------------
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE
        WHEN card_count = 0 THEN 1
        ELSE 0
    END) AS customers_without_card
FROM (
    SELECT
        customer_id,
        card_count,
        NTILE(3) OVER (
            ORDER BY total_transactions
        ) AS frequency_group
    FROM (
        SELECT
            td.customer_id,
            td.total_transactions,
            COALESCE(cd.card_count, 0) AS card_count
        FROM (
            SELECT
                ah.customer_id,
                COUNT(t.transaction_id) AS total_transactions
            FROM account_holders ah
            JOIN transactions t
                ON ah.account_id = t.account_id
            GROUP BY ah.customer_id
        ) AS td
        LEFT JOIN (
            SELECT
                ah.customer_id,
                COUNT(DISTINCT ca.card_id) AS card_count
            FROM account_holders ah
            LEFT JOIN cards ca
                ON ah.holder_id = ca.holder_id
            GROUP BY ah.customer_id
        ) AS cd
            ON td.customer_id = cd.customer_id
    ) AS customer_data
) AS frequency_segments
WHERE frequency_group = 3;




