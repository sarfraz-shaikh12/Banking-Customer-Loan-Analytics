## BQ1: Customer & Card Adoption Analysis

### 1. Business Objective

The objective of this analysis is to understand the customer demographics and evaluate bank card adoption across different customer segments and counties.

The analysis focuses on:
- Customer distribution by gender.
- Customer distribution by age group.
- Overall card adoption rate.
- Distribution of different card types.
- Gender-wise card adoption.
- County-wise card adoption.

---

### 2. Customer Distribution by Gender

**SQL Query**

```sql
SELECT gender, COUNT(*) AS total_customers
FROM customers
GROUP BY gender;
```

**Query Output**

| Gender | Total Customers | Percentage |
|---|---:|---:|
| Male | 542 | 52.42% |
| Female | 492 | 47.58% |
| Total | 1,034 | 100% |

**Key Findings**
- Male customers represent 52.42% of the total customer base.
- Female customers represent 47.58%.
- The customer distribution is relatively balanced across genders.

**Business Insight**

The bank has a relatively balanced gender-wise customer base. Marketing and financial product strategies can consider the needs of both customer groups.

---

### 3. Customer Distribution by Age Group

**SQL Query**

```sql
SELECT
CASE
    WHEN 2026 - birth_year BETWEEN 18 AND 25 THEN '18-25'
    WHEN 2026 - birth_year BETWEEN 26 AND 35 THEN '26-35'
    WHEN 2026 - birth_year BETWEEN 36 AND 45 THEN '36-45'
    WHEN 2026 - birth_year BETWEEN 46 AND 55 THEN '46-55'
    ELSE '56+'
END AS age_group,
COUNT(*) AS total_customers
FROM customers
GROUP BY age_group
ORDER BY age_group;
```

**Query Output**

| Age Group | Customers | Percentage |
|---|---:|---:|
| 18–25 | 83 | 8.03% |
| 26–35 | 263 | 25.44% |
| 36–45 | 345 | 33.37% |
| 46–55 | 260 | 25.15% |
| 56+ | 83 | 8.03% |
| Total | 1,034 | 100% |

**Key Findings**
- The 36–45 age group has the highest number of customers (345).
- Customers aged 26–45 represent approximately 58.80% of the customer base.
- The 18–25 and 56+ age groups have the lowest representation.

**Business Insight**

The bank's customer base is primarily concentrated in the 26–45 age group. The bank can explore suitable savings, loan and other financial product offerings for this segment.

*Note: Age is approximate and calculated using 2026 as the reference year.*

---

### 4. Overall Card Adoption

**SQL Query – Customers with Cards**

```sql
SELECT COUNT(DISTINCT ah.customer_id) AS customers_with_card
FROM account_holders ah
JOIN cards c ON ah.holder_id = c.holder_id;
```

**SQL Query – Card Adoption Percentage**

```sql
SELECT ROUND(232 * 100.0 / COUNT(*), 2) AS adoption_percentage
FROM customers;
```

**Query Output**

| Metric | Value |
|---|---:|
| Total Customers | 1,034 |
| Customers with Card | 232 |
| Customers without Card | 802 |
| Card Adoption Rate | 22.44% |
| Customers without Card | 77.56% |

**Key Findings**
- Only 22.44% of customers have a bank card.
- 77.56% of customers do not have a bank card.
- Overall card adoption is relatively low.

**Business Insight**

The bank has an opportunity to increase card adoption among its existing customers. It can explore promoting suitable card offerings to eligible customers who currently do not have a card.

---

### 5. Card Type Distribution

**SQL Query**

```sql
SELECT card_type, COUNT(*) AS total_cards
FROM cards
GROUP BY card_type
ORDER BY total_cards DESC;
```

**Query Output**

| Card Type | Total Cards | Percentage |
|---|---:|---:|
| Classic | 177 | 76.29% |
| Youth | 29 | 12.50% |
| Gold | 26 | 11.21% |
| Total | 232 | 100% |

**Key Findings**
- Classic cards account for 76.29% of all issued cards.
- Youth cards account for 12.50%.
- Gold cards account for 11.21%.

**Business Insight**

The bank's card portfolio is primarily concentrated in Classic cards. The bank can explore opportunities to increase adoption of Youth and Gold card categories.

*Note: This analysis represents issued cards, not actual card activation or usage.*

---

### 6. Gender-wise Card Adoption

**SQL Query – Customers with Cards by Gender**

```sql
SELECT c.gender, COUNT(*) AS total_cards
FROM customers c
JOIN account_holders ah ON c.customer_id = ah.customer_id
JOIN cards ca ON ah.holder_id = ca.holder_id
GROUP BY c.gender;
```

**Query Output**

| Gender | Total Customers | Customers with Card | Adoption Rate |
|---|---:|---:|---:|
| Female | 492 | 117 | 23.78% |
| Male | 542 | 115 | 21.22% |

**Key Findings**
- Female card adoption rate is 23.78%.
- Male card adoption rate is 21.22%.
- Female card adoption is approximately 2.56 percentage points higher than male card adoption.

**Business Insight**

Female customers have a slightly higher card adoption rate than male customers. The bank can explore opportunities to improve card adoption among male customers while continuing to serve both groups.

---

### 7. County-wise Card Adoption

**SQL Query**

```sql
SELECT co.county,
COUNT(DISTINCT c.customer_id) AS total_customers,
COUNT(DISTINCT ca.holder_id) AS card_holders,
ROUND(COUNT(DISTINCT ca.holder_id) * 100.0 /
COUNT(DISTINCT c.customer_id), 2) AS adoption_rate
FROM counties co
JOIN customers c ON co.county_id = c.county_id
LEFT JOIN account_holders ah ON c.customer_id = ah.customer_id
LEFT JOIN cards ca ON ah.holder_id = ca.holder_id
GROUP BY co.county
ORDER BY adoption_rate DESC;
```

**Query Output**

| County | Customers | Card Holders | Adoption Rate |
|---|---:|---:|---:|
| Kisii | 26 | 8 | 30.77% |
| Bungoma | 30 | 9 | 30.00% |
| Kisumu | 62 | 18 | 29.03% |
| Kilifi | 53 | 15 | 28.30% |
| Embu | 39 | 10 | 25.64% |
| Kiambu | 126 | 30 | 23.81% |
| Meru | 49 | 11 | 22.45% |
| Mombasa | 77 | 17 | 22.08% |
| Uasin Gishu | 50 | 11 | 22.00% |
| Nairobi | 226 | 47 | 20.80% |
| Nakuru | 103 | 21 | 20.39% |
| Kajiado | 51 | 10 | 19.61% |
| Nyeri | 46 | 9 | 19.57% |
| Kakamega | 44 | 8 | 18.18% |
| Machakos | 52 | 8 | 15.38% |

**Key Findings**
- Kisii has the highest card adoption rate at 30.77%.
- Bungoma has the second-highest rate at 30.00%.
- Machakos has the lowest adoption rate at 15.38%.
- Nairobi has the highest number of cardholders (47), but its adoption rate is 20.80%.

**Business Insight**

Kisii and Bungoma show comparatively strong card adoption. Machakos represents an opportunity for improving card adoption. Nairobi also offers potential due to its relatively large customer base.

---

### 8. Overall BQ1 Conclusion

The analysis shows that the bank has 1,034 customers, with a relatively balanced gender distribution. Most customers belong to the 26–45 age group.

Overall card adoption stands at 22.44%, indicating that a large proportion of existing customers do not have a bank card. Classic cards dominate the existing card portfolio.

Female customers have a slightly higher card adoption rate than male customers. At the county level, Kisii has the highest adoption rate, while Machakos has the lowest.

**Overall Business Recommendation**

The bank should explore opportunities to increase card adoption among eligible existing customers, particularly in counties with lower adoption rates. It can also evaluate product offerings for different age and customer segments.

*Analysis Limitation: Card issuance does not confirm card activation or actual usage. Therefore, this analysis measures card adoption based on available card records.*



# BQ2: Loan Portfolio Analysis

## 1. Business Objective

The objective of this analysis is to evaluate the bank's loan portfolio, understand loan distribution across different statuses and durations, and identify county-wise lending patterns.

The analysis focuses on:
- Loan distribution by status.
- Overall loan amount analysis.
- Loan distribution by duration.
- Average scheduled monthly payment.
- County-wise loan distribution.
- County-wise loan amount analysis.

---

## 2. Loan Distribution by Status

**SQL Query**

```sql
SELECT status, COUNT(*) AS total_loans
FROM loans
GROUP BY status;
```

**Query Output**

| Loan Status | Total Loans | Percentage |
|---|---:|---:|
| Current | 176 | 59.46% |
| Repaid | 74 | 25.00% |
| In arrears | 27 | 9.12% |
| Defaulted | 19 | 6.42% |
| Total | 296 | 100% |

**Key Findings**
- Current loans account for 59.46% of the portfolio.
- Repaid loans represent 25% of total loans.
- 27 loans (9.12%) are in arrears.
- 19 loans (6.42%) are defaulted.
- In arrears and defaulted loans together represent 15.54% of the portfolio.

**Business Insight**

Approximately 15.54% of loans are either in arrears or defaulted. This indicates a potential credit-risk area that the bank should monitor carefully.

---

## 3. Loan Amount Analysis

**SQL Query**

```sql
SELECT
COUNT(*) AS total_loans,
SUM(amount_kes) AS total_loan_amount,
AVG(amount_kes) AS avg_loan_amount,
MIN(amount_kes) AS min_loan,
MAX(amount_kes) AS max_loan
FROM loans;
```

**Query Output**

| Metric | Value |
|---|---:|
| Total Loans | 296 |
| Total Loan Amount | KES 123,935,000 |
| Average Loan Amount | KES 418,699.32 |
| Minimum Loan | KES 48,000 |
| Maximum Loan | KES 3,372,000 |

**Key Findings**
- The bank has 296 loan records.
- Total loan amount is KES 123.94 million.
- Average loan amount is KES 418,699.32.
- Loan amounts range from KES 48,000 to KES 3,372,000.

**Business Insight**

The loan portfolio contains considerable variation in loan amounts, indicating different borrowing requirements among customers.

---

## 4. Loan Distribution by Duration

**SQL Query**

```sql
SELECT duration_months, COUNT(*) AS total_loans
FROM loans
GROUP BY duration_months
ORDER BY duration_months;
```

**Query Output**

| Loan Duration | Total Loans | Percentage |
|---|---:|---:|
| 12 Months | 103 | 34.80% |
| 24 Months | 124 | 41.89% |
| 36 Months | 46 | 15.54% |
| 48 Months | 12 | 4.05% |
| 60 Months | 11 | 3.72% |
| Total | 296 | 100% |

**Key Findings**
- 24-month loans are the most common, accounting for 41.89%.
- 12-month loans represent 34.80%.
- 12-month and 24-month loans together account for 76.69% of total loans.
- Longer-duration loans of 48 and 60 months are comparatively less common.

**Business Insight**

The bank's loan portfolio is primarily concentrated in short-to-medium duration loans. The 12-month and 24-month repayment plans are the most common among customers.

---

## 5. Average Monthly Loan Payment

**SQL Query**

```sql
SELECT AVG(monthly_payment_kes) AS avg_monthly_payment
FROM loans;
```

**Query Output**

| Metric | Value |
|---|---:|
| Average Monthly Payment | KES 21,897.51 |

**Key Findings**
- The average scheduled monthly payment is approximately KES 21,898 per loan.

**Business Insight**

The average scheduled monthly payment provides an overview of the typical repayment commitment associated with the bank's loan portfolio.

*Note: This represents scheduled monthly payments, not actual payments received from customers.*

---

## 6. County-wise Loan Distribution

**SQL Query**

```sql
SELECT co.county, COUNT(*) AS total_loans
FROM loans l
JOIN accounts a ON l.account_id = a.account_id
JOIN counties co ON a.county_id = co.county_id
GROUP BY co.county
ORDER BY total_loans DESC;
```

**Query Output**

| County | Total Loans | Percentage |
|---|---:|---:|
| Nairobi | 62 | 20.95% |
| Kiambu | 43 | 14.53% |
| Nakuru | 23 | 7.77% |
| Mombasa | 23 | 7.77% |
| Machakos | 20 | 6.76% |
| Kisumu | 18 | 6.08% |
| Kakamega | 18 | 6.08% |
| Kilifi | 14 | 4.73% |
| Uasin Gishu | 13 | 4.39% |
| Embu | 13 | 4.39% |
| Kajiado | 12 | 4.05% |
| Nyeri | 11 | 3.72% |
| Meru | 11 | 3.72% |
| Kisii | 8 | 2.70% |
| Bungoma | 7 | 2.36% |
| Total | 296 | 100% |

**Key Findings**
- Nairobi has the highest number of loans (62).
- Kiambu ranks second with 43 loans.
- Bungoma has the lowest number of loans (7).
- Nairobi and Kiambu together account for approximately 35.47% of total loans.

**Business Insight**

Loan distribution is concentrated in Nairobi and Kiambu. The bank can explore lending opportunities in counties with lower loan volumes while considering local demand and credit risk.

---

## 7. County-wise Loan Amount Analysis

**SQL Query**

```sql
SELECT co.county, SUM(l.amount_kes) AS total_loan_amount
FROM loans l
JOIN accounts a ON l.account_id = a.account_id
JOIN counties co ON a.county_id = co.county_id
GROUP BY co.county
ORDER BY total_loan_amount DESC;
```

**Query Output**

| County | Total Loan Amount |
|---|---:|
| Nairobi | KES 37,783,000 |
| Kiambu | KES 21,279,000 |
| Nakuru | KES 9,474,000 |
| Mombasa | KES 7,399,000 |
| Machakos | KES 6,473,000 |
| Kakamega | KES 5,771,000 |
| Kisumu | KES 5,688,000 |
| Kajiado | KES 5,183,000 |
| Uasin Gishu | KES 4,965,000 |
| Embu | KES 4,839,000 |
| Nyeri | KES 4,270,000 |
| Kilifi | KES 3,785,000 |
| Meru | KES 2,802,000 |
| Kisii | KES 2,535,000 |
| Bungoma | KES 1,689,000 |

**Key Findings**
- Nairobi has the highest total loan amount at KES 37.78 million.
- Kiambu ranks second with KES 21.28 million.
- Bungoma has the lowest total loan amount at KES 1.69 million.
- Nairobi and Kiambu together account for approximately 47.66% of the total loan portfolio.

**Business Insight**

Nairobi and Kiambu dominate the loan portfolio in terms of total loan value. The bank can explore opportunities in counties with lower loan volumes while evaluating local demand and credit risk.

---

## 8. Overall BQ2 Conclusion

The analysis shows that the bank has a total of 296 loans, with a combined loan amount of KES 123.94 million.

Most loans are currently active, accounting for 59.46% of the portfolio, while 15.54% are either in arrears or defaulted. The most common loan duration is 24 months, followed by 12 months.

The average scheduled monthly payment is KES 21,897.51. At the regional level, Nairobi and Kiambu account for a significant share of the loan portfolio in both loan count and total loan amount.

**Overall Business Recommendations**
- Monitor loans in arrears and defaulted status to manage potential credit risk.
- Evaluate lending patterns across different loan durations.
- Explore lending opportunities in counties with lower loan volumes.
- Monitor regional loan concentration to maintain a balanced portfolio.

**Analysis Limitations**
- The dataset does not contain individual repayment transaction history.
- Scheduled monthly payments do not confirm actual payments received.
- Loan status is used as the available indicator of portfolio condition.
- County-wise loan analysis uses the county associated with the loan's account.




# BQ3 – Transaction Behaviour Analysis

## Business Objective

To analyse overall transaction activity, understand customer transaction channel preferences, identify monthly transaction trends, and find accounts with the highest transaction values.

---

## 1. Total Transaction Overview

**Objective:** Identify the total number and total monetary value of transactions recorded in the banking system.

**SQL Query:**

```sql
SELECT COUNT(*) AS total_transactions,
SUM(amount_kes) AS total_amount
FROM transactions;
```

**Results:**

| Metric | Value |
|---|---:|
| Total Transactions | 102,880 |
| Total Transaction Value | KES 4,951,516,414 |

**Key Findings:**
- A total of 102,880 transactions were recorded.
- The combined transaction value was approximately KES 4.95 billion.

**Business Insight:**

The dataset shows substantial transaction activity. Analysing transaction channels and monthly trends can help the bank better understand transaction behaviour.

---

## 2. Transaction Distribution by Channel

**Objective:** Identify the most frequently used transaction channels and compare their total transaction values.

**SQL Query:**

```sql
SELECT channel, COUNT(*) AS total_transactions,
SUM(amount_kes) AS total_amount
FROM transactions
GROUP BY channel
ORDER BY total_transactions DESC;
```

**Results:**

| Channel | Transactions | Total Amount (KES) |
|---|---:|---:|
| M-Pesa | 40,292 | 2,219,887,290 |
| ATM cash withdrawal | 15,930 | 773,290,500 |
| Standing order | 15,598 | 132,935,019 |
| Bank transfer | 15,424 | 1,216,222,864 |
| Branch | 7,668 | 563,910,051 |
| Card POS | 4,274 | 13,683,530 |
| Interest | 3,694 | 31,587,160 |

**Key Findings:**
- M-Pesa recorded the highest transaction volume with 40,292 transactions.
- M-Pesa also had the highest total transaction value of KES 2.22 billion.
- Bank transfer recorded the second-highest transaction value of KES 1.22 billion.
- Card POS had the lowest transaction volume and total transaction value.

**Business Insight:**

M-Pesa is the most frequently used transaction channel in the dataset. Bank transfers also contribute significant transaction value. The bank can study these channels to understand customer preferences and improve its digital transaction services.

**Data Limitation:** Card POS transactions are not directly linked to card records, so card usage cannot be measured accurately using this dataset.

---

## 3. Monthly Transaction Volume Analysis

**Objective:** Analyse monthly transaction activity and identify changes in transaction volume over time.

**SQL Query:**

```sql
SELECT
    YEAR(txn_date) AS year,
    MONTH(txn_date) AS month,
    COUNT(*) AS total_transactions
FROM transactions
GROUP BY year, month
ORDER BY year, month;
```

**Analysis Period:** January 2021 – December 2024 (48 months).

**Key Findings:**
- January 2021 recorded 149 transactions.
- December 2022 recorded 2,504 transactions.
- December 2023 recorded 3,194 transactions.
- September 2024 recorded the highest monthly transaction volume of 3,538 transactions.
- Overall, monthly transaction volume showed an increasing trend during the analysis period.

**Business Insight:**

The increasing transaction volume indicates growing transaction activity in the dataset. The bank can monitor monthly transaction patterns to understand changes in customer usage and plan its banking services accordingly.

---

## 4. Monthly Transaction Value Analysis

**Objective:** Analyse monthly transaction values to understand how the monetary volume of transactions changes over time.

**SQL Query:**

```sql
SELECT
    YEAR(txn_date) AS year,
    MONTH(txn_date) AS month,
    SUM(amount_kes) AS total_amount
FROM transactions
GROUP BY year, month
ORDER BY year, month;
```

**Key Findings:**
- January 2021 recorded a transaction value of KES 10.85 million.
- December 2022 recorded KES 128.42 million.
- December 2023 recorded KES 160.55 million.
- December 2024 recorded the highest monthly transaction value of approximately KES 164.18 million.
- September 2024 also recorded a high transaction value of approximately KES 160.32 million.

**Business Insight:**

Monthly transaction value showed an overall increasing trend. This indicates that the monetary value of transaction activity also increased during the analysis period. The bank can monitor high-value transaction periods to understand customer transaction patterns.

---

## 5. Average Transaction Amount Analysis

**Objective:** Calculate the average, minimum, and maximum transaction amounts to understand transaction value distribution.

**SQL Query:**

```sql
SELECT
    AVG(amount_kes) AS avg_amount,
    MIN(amount_kes) AS min_amount,
    MAX(amount_kes) AS max_amount
FROM transactions;
```

**Results:**

| Metric | Value |
|---|---:|
| Average Transaction Amount | KES 48,129.05 |
| Minimum Transaction Amount | KES 57 |
| Maximum Transaction Amount | KES 3,372,000 |

**Key Findings:**
- The average transaction amount was approximately KES 48,129.
- The minimum transaction amount was KES 57.
- The maximum transaction amount was KES 3.37 million.
- Transaction amounts showed a wide variation.

**Business Insight:**

The significant variation in transaction amounts indicates different transaction value patterns. The bank can monitor high-value transactions and study customer transaction behaviour.

---

## 6. Top 10 Accounts by Transaction Value

**Objective:** Identify the top 10 accounts with the highest total transaction value and compare their transaction frequency.

**SQL Query:**

```sql
SELECT account_id,
COUNT(*) AS total_transactions,
SUM(amount_kes) AS total_amount
FROM transactions
GROUP BY account_id
ORDER BY total_amount DESC
LIMIT 10;
```

**Results:**

| Account ID | Transactions | Total Amount (KES) |
|---:|---:|---:|
| 2104 | 153 | 32,697,882 |
| 2393 | 106 | 30,761,400 |
| 2733 | 156 | 27,911,995 |
| 2868 | 180 | 24,554,050 |
| 2326 | 125 | 24,148,443 |
| 2690 | 147 | 23,622,870 |
| 2435 | 220 | 22,167,040 |
| 2490 | 103 | 22,069,965 |
| 2884 | 127 | 21,552,256 |
| 2165 | 145 | 20,506,907 |

**Key Findings:**
- Account 2104 recorded the highest total transaction value of KES 32.70 million.
- Account 2393 ranked second with KES 30.76 million.
- Account 2435 recorded the highest transaction count among these accounts, with 220 transactions.
- Account 2490 recorded the lowest transaction count among these 10 accounts, with 103 transactions.

**Business Insight:**

High transaction value and high transaction frequency are not necessarily associated with the same account. The bank can analyse these accounts separately to understand high-value activity and frequent account usage.

**Data Limitation:** Transactions are linked to account IDs rather than individual customer IDs. Therefore, this analysis is performed at the account level and does not identify individual customer transaction behaviour.

---

## Overall Business Insights – BQ3

1. A total of 102,880 transactions were recorded, with a combined value of approximately KES 4.95 billion.
2. M-Pesa was the most frequently used transaction channel and also recorded the highest total transaction value.
3. Monthly transaction volume increased overall from January 2021 to December 2024.
4. December 2024 recorded the highest monthly transaction value of approximately KES 164.18 million.
5. The average transaction amount was approximately KES 48,129.
6. Account 2104 recorded the highest total transaction value among the top 10 accounts.
7. Transaction frequency and transaction value should be analysed separately because an account with more transactions does not necessarily have the highest total transaction value.

**Conclusion:**

The transaction behaviour analysis highlights the importance of M-Pesa, increasing transaction activity, and differences in account-level transaction patterns. These findings can help the bank understand transaction channel preferences, monitor transaction trends, and identify accounts with significant transaction activity.

**Important Note:** Total transaction value represents gross transaction volume, not bank revenue or profit. The dataset contains synthetic data, so these findings should not be interpreted as actual banking performance.



# BQ4 – Credit & Debit Transaction Analysis

## Business Objective

To compare CREDIT and DEBIT transactions based on transaction count, total transaction value, average transaction amount, monthly trends, and net transaction flow.

---

## 1. Credit vs Debit Transaction Count

**Objective:** Identify the total number of CREDIT and DEBIT transactions and compare their contribution to overall transaction activity.

**SQL Query:**

```sql
SELECT txn_type, COUNT(*) AS total_transactions
FROM transactions
GROUP BY txn_type;
```

**Results:**

| Transaction Type | Total Transactions | Percentage |
|---|---:|---:|
| CREDIT | 42,515 | 41.32% |
| DEBIT | 60,365 | 58.68% |
| **Total** | **102,880** | **100%** |

**Key Findings:**
- DEBIT transactions recorded 60,365 transactions.
- CREDIT transactions recorded 42,515 transactions.
- DEBIT transactions were 17,850 higher than CREDIT transactions.
- DEBIT transactions contributed 58.68% of total transaction volume.

**Business Insight:**

DEBIT transactions occur more frequently than CREDIT transactions in the dataset. The bank can monitor both transaction types separately to understand customer transaction patterns.

---

## 2. Credit vs Debit Transaction Value

**Objective:** Compare the total monetary value of CREDIT and DEBIT transactions.

**SQL Query:**

```sql
SELECT txn_type, SUM(amount_kes) AS total_amount
FROM transactions
GROUP BY txn_type;
```

**Results:**

| Transaction Type | Total Amount (KES) | Percentage |
|---|---:|---:|
| CREDIT | 2,819,470,406 | 56.95% |
| DEBIT | 2,132,046,008 | 43.05% |
| **Total** | **4,951,516,414** | **100%** |

**Key Findings:**
- CREDIT transactions recorded approximately KES 2.82 billion.
- DEBIT transactions recorded approximately KES 2.13 billion.
- CREDIT transaction value was KES 687.42 million higher than DEBIT transaction value.
- CREDIT transactions contributed 56.95% of the total transaction value.

**Business Insight:**

Although DEBIT transactions occur more frequently, CREDIT transactions contribute a higher total monetary value. This indicates that transaction frequency and transaction value follow different patterns.

---

## 3. Average Credit vs Debit Transaction Amount

**Objective:** Calculate and compare the average amount of CREDIT and DEBIT transactions.

**SQL Query:**

```sql
SELECT txn_type, AVG(amount_kes) AS avg_amount
FROM transactions
GROUP BY txn_type;
```

**Results:**

| Transaction Type | Average Amount (KES) |
|---|---:|
| CREDIT | 66,317.07 |
| DEBIT | 35,319.24 |

**Key Findings:**
- Average CREDIT transaction amount was approximately KES 66,317.
- Average DEBIT transaction amount was approximately KES 35,319.
- The average CREDIT transaction amount was approximately 1.88 times the average DEBIT transaction amount.

**Business Insight:**

CREDIT transactions have a higher average monetary value despite having a lower transaction count. The bank can analyse these differences to better understand transaction behaviour.

---

## 4. Monthly Credit vs Debit Transaction Count

**Objective:** Compare monthly CREDIT and DEBIT transaction volumes and identify changes over time.

**SQL Query:**

```sql
SELECT
    YEAR(txn_date) AS year,
    MONTH(txn_date) AS month,
    txn_type,
    COUNT(*) AS total_transactions
FROM transactions
GROUP BY year, month, txn_type
ORDER BY year, month, txn_type;
```

**Analysis Period:** January 2021 – December 2024 (48 months).

**Key Findings:**
- DEBIT transactions were generally higher than CREDIT transactions.
- January 2021 recorded 94 CREDIT and 55 DEBIT transactions.
- From April 2021 onward, DEBIT transactions were higher in every month.
- September 2024 recorded the highest monthly CREDIT transaction count of 1,426.
- September 2024 also recorded the highest monthly DEBIT transaction count of 2,112.
- December 2024 recorded 1,409 CREDIT and 1,937 DEBIT transactions.

**Business Insight:**

DEBIT transactions generally occur more frequently than CREDIT transactions. Monitoring monthly transaction counts can help the bank understand changes in customer spending and account activity.

---

## 5. Monthly Credit vs Debit Transaction Value

**Objective:** Compare monthly CREDIT and DEBIT transaction values to understand their monetary trends over time.

**SQL Query:**

```sql
SELECT
    YEAR(txn_date) AS year,
    MONTH(txn_date) AS month,
    txn_type,
    SUM(amount_kes) AS total_amount
FROM transactions
GROUP BY year, month, txn_type
ORDER BY year, month, txn_type;
```

**Key Findings:**
- CREDIT transaction value was higher than DEBIT transaction value in all 48 months.
- January 2021 recorded KES 8.42 million in CREDIT and KES 2.44 million in DEBIT transactions.
- December 2023 recorded CREDIT transaction value of KES 89.77 million.
- December 2024 recorded the highest CREDIT transaction value of approximately KES 90.77 million.
- December 2024 DEBIT transaction value was approximately KES 73.41 million.

**Business Insight:**

CREDIT transactions consistently contributed a higher monetary value than DEBIT transactions throughout the analysis period. This highlights the difference between transaction frequency and transaction value.

---

## 6. Monthly Net Credit-Debit Flow

**Objective:** Calculate the monthly difference between total CREDIT and DEBIT transaction values.

**SQL Query:**

```sql
SELECT
    YEAR(txn_date) AS year,
    MONTH(txn_date) AS month,
    SUM(CASE WHEN txn_type = 'CREDIT' THEN amount_kes ELSE 0 END) AS credit_amount,
    SUM(CASE WHEN txn_type = 'DEBIT' THEN amount_kes ELSE 0 END) AS debit_amount,
    SUM(CASE WHEN txn_type = 'CREDIT' THEN amount_kes ELSE -amount_kes END) AS net_flow
FROM transactions
GROUP BY year, month
ORDER BY year, month;
```

**Net Flow Formula:**

Net Flow = Credit Amount − Debit Amount

**Key Findings:**
- All 48 months recorded a positive net transaction flow.
- CREDIT transaction value was higher than DEBIT transaction value in every month.
- February 2023 recorded the highest monthly net flow of approximately KES 24.68 million.
- May 2023 and September 2024 recorded comparatively lower net flows.
- December 2024 recorded a positive net flow of approximately KES 17.36 million.

**Business Insight:**

The positive net flow across all months indicates that the total value of CREDIT transactions consistently exceeded the total value of DEBIT transactions. The bank can monitor this difference to understand monthly transaction patterns.

**Important Note:** Net transaction flow represents the difference between recorded CREDIT and DEBIT transaction values. It should not be interpreted as bank profit, actual cash flow, or liquidity.

---

## Overall Business Insights – BQ4

1. DEBIT transactions accounted for 58.68% of total transaction volume, while CREDIT transactions accounted for 41.32%.
2. CREDIT transactions contributed 56.95% of total transaction value.
3. Average CREDIT transaction amount was approximately KES 66,317, compared to KES 35,319 for DEBIT.
4. DEBIT transactions were generally more frequent than CREDIT transactions throughout the analysis period.
5. CREDIT transaction value was higher than DEBIT transaction value in all 48 months.
6. February 2023 recorded the highest monthly net transaction flow of approximately KES 24.68 million.
7. Transaction count and transaction value show different patterns and should be analysed separately.

**Conclusion:**

The Credit and Debit Transaction Analysis highlights important differences between transaction frequency and monetary value. DEBIT transactions occur more frequently, while CREDIT transactions contribute a higher total and average transaction value. These insights can help the bank understand transaction behaviour and monitor monthly transaction patterns.

**Important Note:** CREDIT and DEBIT labels represent the transaction types recorded in the dataset. Net transaction flow is not equivalent to bank profit or liquidity. The dataset contains synthetic data, so the findings should not be interpreted as actual banking performance.







## BQ5: Regional Analysis

### 1. Objective

To analyse regional banking performance across different counties by examining customer distribution, account distribution, transaction activity, loan distribution, and county-level economic indicators.

### 2. SQL Analysis Performed

**Query 1: County-wise Customer Distribution**

- Identified the total number of customers in each county.
- Nairobi had the highest customer base with 226 customers.
- Kisii had the lowest customer base with 26 customers.

**Query 2: County-wise Account Distribution**

- Analysed the number of bank accounts across different counties.
- Nairobi had the highest number of accounts with 200.
- Kisii and Bungoma had the lowest number with 26 accounts each.

**Query 3: County-wise Transaction Analysis**

- Compared transaction count and total transaction value across counties.
- Nairobi recorded the highest transaction activity with 23,481 transactions worth KES 1,471,061,173.
- Kiambu ranked second with 12,954 transactions worth KES 755,422,172.
- Kisii recorded the lowest transaction count and transaction value.

**Query 4: County-wise Loan Analysis**

- Analysed the number and total value of loans across counties.
- Nairobi had the highest loan distribution with 62 loans worth KES 37,783,000.
- Kiambu ranked second with 43 loans worth KES 21,279,000.
- Bungoma had the lowest loan distribution with 7 loans worth KES 1,689,000.
- Nairobi and Kiambu together contributed approximately 47.66% of the total loan portfolio value.

**Query 5: County-wise Economic Overview**

- Compared population, average monthly income, unemployment percentage, and urban population percentage.
- Nairobi had the highest average monthly income at KES 68,400.
- Bungoma had the lowest average monthly income at KES 23,600.
- Kilifi had the highest unemployment rate at 14.7%.
- Nyeri had the lowest unemployment rate at 7.4%.
- Nairobi and Mombasa both had 100% urban population.

### 3. Key Business Insights

1. Nairobi consistently leads in customer distribution, account distribution, transaction activity, and loan distribution.
2. Kiambu is another important banking market, ranking second in customer count, account count, transaction value, and loan value.
3. Counties with higher banking activity also show significant differences in economic indicators.
4. Counties with lower customer and account counts may provide opportunities to expand banking services.
5. Regional economic indicators can help the bank understand differences between markets and plan suitable banking strategies.

### 4. Business Recommendations

1. **Strengthen Major Markets:** Continue improving banking services in Nairobi and Kiambu because of their high customer and transaction activity.
2. **Explore Growth Opportunities:** Evaluate counties with lower customer and account distribution for potential customer acquisition.
3. **Regional Marketing:** Develop marketing strategies based on county-level economic conditions.
4. **Loan Market Analysis:** Monitor regional loan distribution and loan status before expanding lending activities.
5. **Improve Regional Coverage:** Explore opportunities to increase banking service accessibility in less-developed markets.

### 5. Important Considerations

- Customer county represents customer residence, whereas account county represents account location. These two dimensions were analysed separately.
- Transaction and loan analyses are based on account location.
- County-level average income is not individual customer income.
- Regional comparisons should consider population and economic indicators, not just total counts.
- The dataset is synthetic and does not represent actual bank performance.

### 6. Conclusion

The regional analysis shows that Nairobi and Kiambu are the strongest banking markets in this dataset based on customer distribution, account distribution, transaction activity, and loan portfolio value.

The analysis also highlights differences in economic conditions across counties, which can help identify potential areas for banking expansion, customer acquisition, and regional marketing strategies.



## BQ6: Customer Segmentation

### 1. Business Objective

The objective of this analysis is to segment banking customers based on their transaction behaviour.

Customers are analysed using three dimensions:

- **Transaction Frequency:** Number of transactions linked to each customer.
- **Total Transaction Value:** Total value of transactions linked to each customer.
- **Average Transaction Amount:** Average value per transaction.

The analysis uses frequency and total transaction value to create three levels: Low, Medium, and High. These dimensions are then combined to identify nine customer segments.

### 2. Customer-wise Transaction Frequency

**Objective:** Identify how many transactions are associated with each customer.

**SQL Logic:**
- Join `account_holders` with `transactions` using `account_id`.
- Count transactions for each customer.
- Group results by `customer_id`.

**Results:**

| Metric | Value |
|---|---:|
| Minimum Transactions | 18 |
| Maximum Transactions | 286 |
| Average Transactions | 114.72 |

**Insight:** Transaction frequency varies considerably across customers, with some customers having substantially more linked-account transactions than others.

### 3. Customer-wise Transaction Value

**Objective:** Calculate the total transaction value associated with each customer.

**SQL Logic:**
- Join `account_holders` with `transactions`.
- Calculate the sum of `amount_kes` for each customer.
- Group results by `customer_id`.

**Results:**

| Metric | Value (KES) |
|---|---:|
| Minimum Transaction Value | 540,169 |
| Maximum Transaction Value | 32,697,882 |
| Average Transaction Value | 5,542,904.56 |

**Insight:** Customer 10117 has the highest linked-account transaction value of KES 32.69 million. High transaction value can help identify customers for further relationship-management opportunities.

### 4. Customer-wise Average Transaction Amount

**Objective:** Calculate the average transaction amount associated with each customer.

**SQL Logic:**
- Calculate `AVG(amount_kes)` for each customer.
- Group results by `customer_id`.
- Sort the results in descending order.

**Top 5 Customers:**

| Customer ID | Average Amount (KES) |
|---|---:|
| 10457 | 290,201.89 |
| 10425 | 274,133.49 |
| 10568 | 214,271.50 |
| 10117 | 213,711.65 |
| 10222 | 205,192.49 |

**Insight:** Customer 10457 has the highest average transaction amount, while customer 10117 has the highest total transaction value. This demonstrates that average transaction amount and total transaction value measure different aspects of customer activity.

### 5. Transaction Frequency Segmentation

**Objective:** Divide customers into three groups based on transaction frequency.

**Methodology:**
- Used the `NTILE(3)` window function.
- Sorted customers by total transaction count.
- Assigned customers to Low, Medium, and High Frequency groups.

**Results:**

| Frequency Group | Customers | Minimum Transactions | Maximum Transactions |
|---|---:|---:|---:|
| Low Frequency | 345 | 18 | 95 |
| Medium Frequency | 345 | 95 | 129 |
| High Frequency | 344 | 129 | 286 |
| **Total** | **1,034** | | |

**Insight:** Customers are distributed almost equally across the three frequency groups. The High Frequency group contains customers with up to 286 linked-account transactions.

### 6. Transaction Value Segmentation

**Objective:** Divide customers into three groups based on total transaction value.

**Methodology:**
- Used `NTILE(3)` to divide customers into three groups.
- Sorted customers by total transaction value.
- Assigned Low, Medium, and High Value groups.

**Results:**

| Value Group | Customers | Minimum Value (KES) | Maximum Value (KES) |
|---|---:|---:|---:|
| Low Value | 345 | 540,169 | 3,276,049 |
| Medium Value | 345 | 3,280,009 | 6,005,121 |
| High Value | 344 | 6,005,987 | 32,697,882 |
| **Total** | **1,034** | | |

**Insight:** The High Value group contains customers with linked-account transaction values reaching KES 32.69 million. These customers may be explored for premium banking services and relationship management.

### 7. Combined Customer Segmentation

**Objective:** Combine transaction frequency and transaction value to identify nine customer segments.

**Methodology:**
- Calculated transaction frequency and total transaction value for each customer.
- Used `NTILE(3)` separately for both dimensions.
- Combined the two groups to create nine customer segments.
- Counted customers in each segment.

**Results:**

| Frequency Segment | Low Value | Medium Value | High Value | Total |
|---|---:|---:|---:|---:|
| Low Frequency | 189 | 92 | 64 | 345 |
| Medium Frequency | 90 | 124 | 131 | 345 |
| High Frequency | 66 | 129 | 149 | 344 |
| **Total** | **345** | **345** | **344** | **1,034** |

### 8. Key Business Insights

1. **Low Frequency + Low Value:** This is the largest segment, with 189 customers. These customers may be considered for engagement and banking-service awareness initiatives.

2. **High Frequency + High Value:** This segment contains 149 customers. They may be potential candidates for premium banking services and relationship-management programmes.

3. **Low Frequency + High Value:** This segment contains 64 customers. Their high transaction value but lower frequency may provide an opportunity to explore additional banking-service engagement.

4. **High Frequency + Low Value:** This segment contains 66 customers. These customers have frequent linked-account activity but relatively lower total transaction value.

5. **Balanced Distribution:** The three frequency groups and three value groups contain nearly equal numbers of customers because of the `NTILE(3)` segmentation method.

### 9. Business Recommendations

- Explore premium banking and relationship-management opportunities for High Frequency + High Value customers.
- Consider engagement initiatives for Low Frequency + Low Value customers.
- Explore suitable additional services for Low Frequency + High Value customers.
- Analyse customer needs before recommending new banking products.
- Use transaction frequency and transaction value as separate dimensions when evaluating customer behaviour.

### 10. Limitations

- Transactions are linked to accounts rather than directly to individual customers.
- Joint account transactions may be associated with multiple account holders. Therefore, the analysis represents linked-account activity and should not be interpreted as perfectly attributable individual customer behaviour.
- Transaction value does not represent customer income, profit, or creditworthiness.
- High transaction activity alone does not establish a customer's ability to repay a loan.
- The segmentation is based only on transaction frequency and value, not on complete customer financial profiles.
- `NTILE(3)` creates approximately equal-sized groups; these are relative segments, not fixed banking risk or value categories.

### 11. Conclusion

Customer segmentation helped identify different patterns of linked-account transaction activity. By analysing transaction frequency and total transaction value separately and combining them, 1,034 customers were divided into nine segments.

The analysis can help the bank explore customer engagement, premium banking opportunities, and relationship-management strategies. Further customer-level information would be required before making individual product or credit decisions.


## BQ7: Marketing Opportunities

### 1. Business Objective

The objective of this analysis is to identify potential marketing and customer engagement opportunities using customer, card, loan, and transaction data.

The analysis focuses on:

- Identifying counties with low card adoption.
- Understanding M-Pesa transaction activity across counties.
- Identifying customers without loan records.
- Segmenting customers based on transaction activity.
- Finding card adoption opportunities within different customer segments.
- Identifying high-value and high-frequency customers without cards.

### 2. County-wise Card Adoption Opportunity

**Objective:** Identify counties with a higher percentage of customers who do not have a bank card.

**SQL Logic:**
- Joined customers, counties, account holders, and cards.
- Counted cards associated with each customer.
- Identified customers without cards.
- Calculated the percentage of customers without cards in each county.

**Results:**

| County | Total Customers | Customers Without Card | Opportunity % |
|---|---:|---:|---:|
| Machakos | 52 | 44 | 84.62% |
| Kakamega | 44 | 36 | 81.82% |
| Nyeri | 46 | 37 | 80.43% |
| Kajiado | 51 | 41 | 80.39% |
| Nakuru | 103 | 82 | 79.61% |
| Nairobi | 226 | 179 | 79.20% |
| Uasin Gishu | 50 | 39 | 78.00% |
| Mombasa | 77 | 60 | 77.92% |
| Meru | 49 | 38 | 77.55% |
| Kiambu | 126 | 96 | 76.19% |
| Embu | 39 | 29 | 74.36% |
| Kilifi | 53 | 38 | 71.70% |
| Kisumu | 62 | 44 | 70.97% |
| Bungoma | 30 | 21 | 70.00% |
| Kisii | 26 | 18 | 69.23% |

**Key Insights:**

- Machakos has the highest card adoption opportunity at 84.62%.
- Kakamega and Nyeri also have more than 80% customers without cards.
- Nairobi has the highest number of customers without cards (179).
- Kisii has the lowest percentage of customers without cards at 69.23%.

**Business Recommendation:** The bank can explore targeted card awareness and adoption campaigns in Machakos, Kakamega, Nyeri, and Nairobi.

### 3. County-wise M-Pesa Transaction Analysis

**Objective:** Understand the share of M-Pesa transactions across different counties.

**SQL Logic:**
- Joined accounts, counties, and transactions.
- Counted total transactions for each county.
- Counted M-Pesa transactions using conditional aggregation.
- Calculated the M-Pesa transaction percentage.

**Results:**

| County | Total Transactions | M-Pesa Transactions | M-Pesa % |
|---|---:|---:|---:|
| Meru | 4,623 | 1,992 | 43.09% |
| Mombasa | 8,022 | 3,417 | 42.60% |
| Kajiado | 4,144 | 1,757 | 42.40% |
| Kilifi | 5,382 | 2,181 | 40.52% |
| Uasin Gishu | 5,447 | 2,203 | 40.44% |
| Kisii | 2,974 | 1,176 | 39.54% |
| Nakuru | 8,605 | 3,397 | 39.48% |
| Kakamega | 5,190 | 2,016 | 38.84% |
| Nairobi | 23,481 | 9,054 | 38.56% |
| Kiambu | 12,954 | 4,980 | 38.44% |
| Kisumu | 4,965 | 1,905 | 38.37% |
| Embu | 3,880 | 1,488 | 38.35% |
| Machakos | 5,609 | 2,039 | 36.35% |
| Nyeri | 4,420 | 1,605 | 36.31% |
| Bungoma | 3,184 | 1,082 | 33.98% |

**Key Insights:**

- Meru has the highest M-Pesa transaction share at 43.09%.
- Bungoma has the lowest share at 33.98%.
- Nairobi has the highest M-Pesa transaction count, with 9,054 transactions.
- Machakos and Nyeri also have relatively lower M-Pesa transaction shares.

**Business Recommendation:** The bank can explore digital-service engagement opportunities in counties with lower M-Pesa transaction shares.

### 4. Customers Without Loan Records

**Objective:** Identify customers who do not have an existing loan record.

**SQL Logic:**
- Joined customers, counties, account holders, and loans.
- Counted loan records associated with each customer.
- Identified customers without loan records.
- Calculated the percentage for each county.

**Results:**

| County | Total Customers | Customers Without Loan | Opportunity % |
|---|---:|---:|---:|
| Meru | 49 | 37 | 75.51% |
| Nyeri | 46 | 34 | 73.91% |
| Nakuru | 103 | 75 | 72.82% |
| Kakamega | 44 | 31 | 70.45% |
| Uasin Gishu | 50 | 35 | 70.00% |
| Nairobi | 226 | 158 | 69.91% |
| Kilifi | 53 | 37 | 69.81% |
| Embu | 39 | 27 | 69.23% |
| Mombasa | 77 | 53 | 68.83% |
| Bungoma | 30 | 19 | 63.33% |
| Kiambu | 126 | 78 | 61.90% |
| Kajiado | 51 | 31 | 60.78% |
| Machakos | 52 | 31 | 59.62% |
| Kisumu | 62 | 36 | 58.06% |
| Kisii | 26 | 15 | 57.69% |

**Key Insights:**

- Meru has the highest percentage of customers without loan records at 75.51%.
- Nyeri follows with 73.91%.
- Nairobi has the highest number of customers without loan records (158).
- Kisii has the lowest percentage at 57.69%.

**Business Recommendation:** The bank can explore loan-product awareness opportunities in Meru, Nyeri, Nakuru, and Nairobi.

### 5. Customer Activity Segmentation

**Objective:** Divide customers into Low Activity, Medium Activity, and High Activity groups based on transaction frequency.

**Methodology:**
- Counted transactions associated with each customer.
- Used CASE statements to create activity segments.
- Applied the following transaction frequency thresholds:
  - Low Activity: 95 transactions or fewer.
  - Medium Activity: 96–129 transactions.
  - High Activity: More than 129 transactions.

**Results:**

| Customer Segment | Total Customers | Percentage |
|---|---:|---:|
| Low Activity | 354 | 34.24% |
| Medium Activity | 338 | 32.69% |
| High Activity | 342 | 33.08% |
| **Total** | **1,034** | **100%** |

**Key Insights:**

- Low Activity contains the highest number of customers (354).
- Medium Activity contains 338 customers.
- High Activity contains 342 customers.
- Customer activity is distributed relatively evenly across the three groups.

**Business Recommendation:** The bank can explore customer engagement and service-awareness initiatives for Low Activity customers.

### 6. Card Adoption by Customer Activity Segment

**Objective:** Identify customers without cards across different activity segments.

**SQL Logic:**
- Created activity segments using transaction frequency.
- Counted cards associated with each customer.
- Identified customers without cards in each segment.

**Results:**

| Activity Segment | Total Customers | Customers Without Card | Without Card % |
|---|---:|---:|---:|
| Low Activity | 354 | 279 | 78.81% |
| Medium Activity | 338 | 284 | 84.02% |
| High Activity | 342 | 239 | 69.88% |
| **Total** | **1,034** | **802** | **77.56%** |

**Key Insights:**

- Medium Activity has the highest percentage of customers without cards at 84.02%.
- Low Activity follows with 78.81%.
- High Activity has the lowest percentage at 69.88%.
- Medium Activity has the highest absolute number of customers without cards (284).

**Business Recommendation:** The bank can prioritise Medium Activity customers for card awareness campaigns and explore engagement initiatives for Low Activity customers.

### 7. High Transaction Value Customers Without Cards

**Objective:** Identify customers in the High Value transaction segment who do not have bank cards.

**Methodology:**
- Calculated total transaction value for each customer.
- Used `NTILE(3)` to divide customers into three value groups.
- Selected the High Value group.
- Identified customers without cards.

**Results:**

| Metric | Customers |
|---|---:|
| High Value Customers | 344 |
| Customers Without Card | 266 |
| Without Card % | 77.33% |

**Key Insights:**

- The High Value segment contains 344 customers.
- 266 customers (77.33%) do not have cards.
- This segment represents a potential opportunity for targeted card-adoption campaigns.

**Business Recommendation:** The bank can explore targeted card awareness campaigns for high linked-account transaction value customers without cards.

### 8. High Frequency Customers Without Cards

**Objective:** Identify frequently transacting customers who do not have bank cards.

**Methodology:**
- Counted transactions associated with each customer.
- Used `NTILE(3)` to divide customers into three frequency groups.
- Selected the High Frequency group.
- Identified customers without cards.

**Results:**

| Metric | Customers |
|---|---:|
| High Frequency Customers | 344 |
| Customers Without Card | 241 |
| Without Card % | 70.06% |

**Key Insights:**

- The High Frequency segment contains 344 customers.
- 241 customers (70.06%) do not have cards.
- These customers have frequent linked-account transaction activity but no associated bank card.

**Business Recommendation:** The bank can explore card-adoption campaigns targeting frequently transacting customers without cards.

### 9. Overall Business Insights

1. **Card Adoption Opportunity:** All 15 counties have a substantial proportion of customers without cards. Machakos has the highest percentage at 84.62%.

2. **Digital Transaction Engagement:** M-Pesa transaction shares vary across counties, ranging from 33.98% in Bungoma to 43.09% in Meru.

3. **Loan Product Awareness:** Meru has the highest proportion of customers without loan records at 75.51%. These customers may be explored for suitable loan-product awareness initiatives.

4. **Customer Engagement:** Low Activity customers represent 354 customers, making this an important segment for engagement initiatives.

5. **Medium Activity Card Opportunity:** 284 out of 338 Medium Activity customers do not have cards, representing an 84.02% card adoption opportunity.

6. **High Value Card Opportunity:** 266 out of 344 High Value customers do not have cards.

7. **High Frequency Card Opportunity:** 241 out of 344 High Frequency customers do not have cards.

### 10. Overall Business Recommendations

- Prioritise card awareness campaigns in counties with higher proportions of customers without cards.
- Explore digital-service engagement initiatives in counties with lower M-Pesa transaction shares.
- Consider suitable loan-product awareness campaigns for customers without existing loan records, subject to credit and affordability assessment.
- Develop engagement initiatives for Low Activity customers.
- Explore card-adoption opportunities among Medium Activity, High Value, and High Frequency cardless customers.
- Use customer needs, affordability, and eligibility checks before recommending banking products.

### 11. Limitations

- Transactions are linked to accounts, not directly to individual customers. Joint account transactions may be associated with multiple account holders.
- M-Pesa transaction activity does not directly measure adoption of the bank's own mobile banking application.
- Customers without a loan record are not automatically eligible for a loan.
- Customers without a card are potential adoption candidates, not confirmed card applicants.
- Transaction value does not represent customer income, profitability, or creditworthiness.
- Card issuance records do not establish whether a card is currently active or used.
- The dataset does not contain campaign data, so marketing campaign effectiveness cannot be measured.
- Customer activity segments are based on transaction frequency thresholds and do not represent formal customer risk categories.
- The analysis is based on synthetic banking data and should not be interpreted as actual bank performance.

### 12. Conclusion

The marketing opportunities analysis identified potential areas for card adoption, digital-service engagement, loan-product awareness, and customer relationship management.

The results highlight counties and customer segments where the bank can explore targeted marketing initiatives. These findings can support marketing planning, but actual product recommendations should be based on customer needs, eligibility, and further assessment.


























