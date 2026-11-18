# Banking Customer & Loan Analytics

**An end-to-end banking analytics project using Python, MySQL, SQL, and Power BI to analyze customer behaviour, card adoption, loan portfolio performance, transaction patterns, and regional banking opportunities.**

---

## Project Overview

This project analyzes banking customer, account, transaction, loan, card, and regional economic data to uncover actionable business insights.

The objective is to understand customer engagement, evaluate loan portfolio health, identify transaction trends, measure card adoption, and highlight opportunities for improving banking services.

The project follows an end-to-end data analytics workflow, starting with data understanding and cleaning in Python, followed by database management and SQL analysis in MySQL, and finally interactive dashboard development in Power BI.

## Business Objectives

- Analyze customer demographics and distribution.
- Evaluate bank card adoption across customer segments.
- Assess loan portfolio performance and identify loans at risk.
- Understand transaction behaviour across different channels.
- Compare credit and debit transaction patterns.
- Identify regional banking trends and opportunities.
- Develop data-driven business recommendations.

## Tools & Technologies

| Tool | Purpose |
|---|---|
| Python | Data understanding, cleaning, and EDA |
| Pandas & NumPy | Data manipulation and analysis |
| Matplotlib & Seaborn | Exploratory data visualization |
| MySQL | Database management |
| SQL | Business analysis and querying |
| Power BI | Interactive dashboards and reporting |
| DAX | Measures and calculated analysis |
| Excel | Data dictionary and documentation |
| Git & GitHub | Version control and project hosting |

## Dataset Overview

The project contains 7 datasets covering customers, accounts, account holders, transactions, loans, cards, and counties.

| Dataset | Records | Columns |
|---|---:|---:|
| Customers | 1,034 | 5 |
| Accounts | 900 | 5 |
| Account Holders | 1,034 | 4 |
| Transactions | 102,880 | 8 |
| Loans | 296 | 7 |
| Cards | 232 | 4 |
| Counties | 15 | 7 |
| **Total** | **106,391** | **40** |

The datasets were organized into raw and cleaned folders and imported into a MySQL database named `banking_analytics`.

## Project Workflow

1. **Data Understanding:** Explored datasets, dimensions, data types, and data quality.
2. **Data Cleaning:** Identified and handled data quality issues using Python.
3. **Exploratory Data Analysis:** Analyzed distributions, patterns, and relationships.
4. **Database Management:** Imported datasets into MySQL and established primary and foreign key relationships.
5. **SQL Analysis:** Answered business questions using SQL queries and aggregations.
6. **Power BI Development:** Built interactive dashboards using DAX measures, calculated columns, and relationships.
7. **Business Reporting:** Summarized findings and developed actionable recommendations.

## Business Questions

The analysis addresses seven key business questions:

1. **Customer & Card Adoption Analysis**
   - How are customers distributed by gender, age group, and county?
   - What is the overall bank card adoption rate?
   - Which customer segments have lower card adoption?

2. **Loan Portfolio Analysis**
   - What is the total loan portfolio value?
   - How are loans distributed by status and duration?
   - What proportion of loans are in arrears or defaulted?

3. **Transaction Behaviour Analysis**
   - Which transaction channels are most frequently used?
   - How does transaction activity change over time?
   - Which channels contribute the highest transaction value?

4. **Credit & Debit Analysis**
   - What is the distribution of credit and debit transactions?
   - How do their transaction counts and values compare?
   - How does the net credit-debit difference vary over time?

5. **Regional Analysis**
   - Which counties contribute the most to banking activity?
   - How does regional economic information relate to banking metrics?
   - Where are opportunities for regional expansion?

6. **Customer Segmentation**
   - How can customers be segmented by transaction frequency and value?
   - Which segments contain high-value and highly active customers?

7. **Marketing Opportunities**
   - Which counties have the highest proportion of cardless customers?
   - Which active customers do not have bank cards?
   - Where can the bank explore potential cross-selling opportunities?

## Key Insights & Findings

### 1. Customer & Card Adoption

- Total customers: **1,034**
- Customers with bank cards: **232**
- Customers without bank cards: **802**
- Overall card adoption: **22.44%**
- Cardless customer share: **77.56%**

### 2. Loan Portfolio

- Total loans: **296**
- Total loan portfolio: **KES 123.94 million**
- Current loans: **176 (59.46%)**
- Repaid loans: **74 (25.00%)**
- Loans in arrears: **27 (9.12%)**
- Defaulted loans: **19 (6.42%)**
- Loans at risk: **46 (15.54%)**

### 3. Transaction Behaviour

- Total transactions: **102,880**
- Total transaction value: **KES 4.95 billion**
- Leading transaction channel: **M-Pesa**
- M-Pesa transactions: **40,292**
- Card POS transactions: **4,274**

### 4. Credit & Debit Analysis

- Credit transactions: **42,515 (41.32%)**
- Debit transactions: **60,365 (58.68%)**
- Total credit value: **KES 2.82 billion**
- Total debit value: **KES 2.13 billion**
- Difference between credit and debit values: **KES 687.42 million**

### 5. Regional Analysis

- Nairobi and Kiambu contribute approximately **47.66% of total loan portfolio value**.
- Together, they account for approximately **44.59% of total transaction value**.
- Nairobi leads several major banking activity metrics.

### 6. Customer Segmentation

Customers were segmented using transaction frequency and transaction value.

| Activity Segment | Customers |
|---|---:|
| Low Activity | 354 |
| Medium Activity | 338 |
| High Activity | 342 |
| **Total** | **1,034** |

### 7. Marketing Opportunities

- **802 customers (77.56%)** do not have bank cards.
- **266 high-value customers (77.33%)** do not have cards.
- **241 high-frequency customers (70.06%)** do not have cards.
- Machakos has the highest cardless customer proportion at **84.62%**.

These groups represent potential opportunities for targeted card adoption initiatives, subject to customer suitability and further validation.

## Power BI Dashboard

The Power BI report contains five analytical pages:

1. **Banking Overview** – Overall banking KPIs, loan status, transaction trends, and card adoption.
2. **Customer Analysis** – Customer demographics, card adoption, and customer activity segmentation.
3. **Transaction Analysis** – Transaction channels, transaction value, volume, and credit/debit patterns.
4. **Loan Portfolio Analysis** – Loan status, portfolio value, tenure, and county-level loan distribution.
5. **Regional Analysis** – County-wise banking activity and regional economic indicators.
6. **Business Insights** – Key findings and analytical insights.
7. **Business Recommendations** – Strategic actions based on the analysis.

## Business Recommendations

- Improve card adoption through targeted awareness and simplified application processes.
- Strengthen loan monitoring for accounts in arrears and default.
- Promote convenient digital payment options and increase awareness of card-based services.
- Explore banking expansion opportunities beyond highly concentrated regions.
- Develop customer-segment-specific financial products and engagement strategies.

## Project Limitations

- The dataset is synthetic and does not represent actual bank performance.
- Transaction records are linked to accounts rather than directly to individual customers. Joint-account activity may therefore be associated with multiple account holders.
- Card issuance does not confirm card activation or usage.
- Loan repayment history is unavailable, so actual repayment timeliness cannot be evaluated.
- County income figures represent regional averages, not individual customer income.
- Marketing campaign data is unavailable, so campaign effectiveness cannot be measured.

## Repository Structure

```text
Banking-Customer-Loan-Analytics/
│
├── Data/
│   ├── raw/
│   └── cleaned/
│
├── Documentation/
│   ├── 01_Project_Brief.md
│   ├── 02_Business_Questions.md
│   ├── 03_Data_Dictionary.xlsx
│   ├── 04_ER_Diagram.png
│   ├── 05_Data_Quality_Report.md
│   └── 06_SQL_Analysis_Documentation.md
│
├── python/
│   ├── 01_Data_Understanding_&_Quality_Assessment.ipynb
│   ├── 02_Data_Cleaning.ipynb
│   └── 03_Exploratory_Data_Analysis_(EDA).ipynb
│
├── Sql/
│   ├── 01_Database_Setup_&_Data_Validation.sql
│   ├── 02_Customer_&_Card_Adoption_Analysis.sql
│   ├── 03_Loan_Portfolio_Analysis.sql
│   ├── 04_Transaction_Behaviour_Analysis.sql
│   ├── 05_Credit_&_Debit_Analysis.sql
│   ├── 06_Regional_Analysis.sql
│   ├── 07_Customer_Segmentation.sql
│   └── 08_Marketing_Opportunities.sql
│
├── Power BI/
│   └── Banking_Customer_Loan_Analytics.pbix
│
├── Banking_Customer_Loan_Analytics.pdf
└── Banking_Customer_Loan_Analytics_Final_Report.docx
```

## Conclusion

This project demonstrates an end-to-end data analytics workflow, combining Python, SQL, and Power BI to transform raw banking data into meaningful business insights.

The analysis highlights opportunities in card adoption, loan risk management, digital transactions, customer segmentation, and regional banking growth.

**The ultimate goal is to support better business decisions through data-driven analysis.**
