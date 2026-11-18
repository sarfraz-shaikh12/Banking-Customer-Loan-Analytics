## Project Overview

The **Banking Customer & Loan Analytics** project focuses on analyzing banking customers, account activities, transaction behaviour, card adoption, and loan portfolio performance.

The project uses banking datasets containing customer information, account details, account holders, transactions, loans, cards, and regional information. These datasets will be explored, cleaned, validated, and analyzed using Python, MySQL, and Power BI.

The main purpose of this project is to understand customer financial behaviour, evaluate banking product usage, identify loan portfolio risks, and discover potential opportunities for customer segmentation and cross-selling.

Through data analysis and visualization, the project aims to generate meaningful business insights that can help the bank make better data-driven decisions regarding customer engagement, product adoption, regional strategies, and loan management.

## Business Problem Statement

The bank wants to gain a better understanding of its customers, their banking activities, transaction behaviour, and loan repayment patterns.

Currently, the bank needs insights into customer segments, card adoption, transaction trends, regional performance, and loan portfolio risks to identify areas that require improvement and potential business opportunities.

Without proper analysis of this information, it may be difficult for the bank to identify suitable customer segments, improve banking product adoption, understand loan-related risks, and develop effective cross-selling strategies.

Therefore, the bank aims to use data analytics to evaluate customer behaviour, assess banking product usage, analyze loan performance, and identify opportunities for better customer engagement and data-driven business decisions.

## Project Objectives

The key objectives of this project are:

1. **Customer Behaviour Analysis:** Understand customer demographics, account ownership, and financial transaction behaviour.

2. **Transaction Analysis:** Analyze transaction frequency, transaction amounts, payment channels, and credit/debit trends.

3. **Card Adoption Analysis:** Evaluate existing card adoption patterns and identify potential customer segments for increasing card usage.

4. **Loan Portfolio Analysis:** Examine loan distribution, repayment status, loan characteristics, and potential risk patterns.

5. **Regional Analysis:** Compare customer activity, banking product adoption, and transaction behaviour across different counties.

6. **Customer Segmentation:** Group customers based on transaction behaviour and banking product usage to identify meaningful customer segments.

7. **Business Opportunities:** Identify potential opportunities for product promotions, customer engagement, and cross-selling using data-driven insights.

## Tools & Technologies

The following tools and technologies will be used throughout the project:

| Tool / Technology | Purpose |
|---|---|
| Python | Data understanding, cleaning, and exploratory data analysis |
| Pandas | Data manipulation and analysis |
| NumPy | Numerical operations |
| Matplotlib | Data visualization |
| Seaborn | Statistical data visualization |
| MySQL | Database creation, data validation, and SQL analysis |
| Power BI | Data modeling, interactive dashboards, and business insights |
| Excel | Initial data inspection and supporting data validation |
| GitHub | Project version control and portfolio presentation |
| Jupyter Notebook | Writing and executing Python analysis |

## Dataset Overview

This project uses seven CSV datasets containing information about banking customers, accounts, account holders, transactions, loans, cards, and counties.

The datasets provide an opportunity to analyze customer behaviour, banking activities, transaction patterns, card adoption, loan portfolio performance, and regional characteristics.

### Dataset Summary

| Dataset | Records | Columns |
|---|---:|---:|
| bank-customers | 1,034 | 5 |
| bank-accounts | 900 | 5 |
| bank-account-holders | 1,034 | 4 |
| bank-transactions | 102,880 | 8 |
| bank-loans | 296 | 7 |
| bank-cards | 232 | 4 |
| bank-counties | 15 | 7 |
| **Total** | **106,391** | **40** |

### Dataset Details

- **Customers:** Customer demographics and county information.
- **Accounts:** Account types, opening dates, and statement preferences.
- **Account Holders:** Relationships between customers and bank accounts.
- **Transactions:** Transaction dates, types, channels, purposes, amounts, and balances.
- **Loans:** Loan amounts, durations, monthly payments, and loan statuses.
- **Cards:** Card types, issue dates, and associated account holders.
- **Counties:** Regional information, population, average monthly income, unemployment, and urbanization.

**Note:** The datasets contain synthetic banking data based on a Kenyan banking context. Monetary values are represented in Kenyan Shillings (KES).

## Project Scope

The scope of this project includes the following areas:

1. **Customer Analysis:** Explore customer demographics, account ownership, and regional distribution.
2. **Account Analysis:** Examine account types, account opening patterns, and statement preferences.
3. **Transaction Analysis:** Analyze transaction frequency, amounts, channels, purposes, and credit/debit trends.
4. **Card Analysis:** Evaluate card distribution, card types, and card adoption across customer segments.
5. **Loan Analysis:** Study loan amounts, durations, monthly payment amounts, loan statuses, and potential risk patterns.
6. **Regional Analysis:** Compare banking activities and customer distribution across counties.
7. **Customer Segmentation:** Identify customer groups based on their transaction behaviour and banking product usage.
8. **Business Recommendations:** Develop data-driven recommendations for customer engagement, product adoption, and cross-selling opportunities.

### Project Limitations

- The datasets do not contain customer income or credit scores.
- Actual loan repayment history and EMI payment records are unavailable.
- Card activation status and card-wise transaction records are unavailable.
- Marketing campaign costs, responses, and redemption data are not provided.
- Transaction records are linked to bank accounts rather than directly to individual customers, limiting individual-level attribution for joint accounts.
- The loan dataset contains only 296 records, which may limit the reliability of some segment-level conclusions.

The project will focus on insights supported by the available data and will avoid making unsupported assumptions.