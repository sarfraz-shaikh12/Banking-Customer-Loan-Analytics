
## 1. Overview

This report summarizes the data quality assessment performed on the Banking Customer & Loan Analytics datasets.

The assessment focused on:
- Missing values
- Duplicate records
- Data types and consistency
- Potential outliers
- Transaction balance validation
- Categorical value validation
- Date validation
- Referential integrity
- Cross-dataset consistency and business logic validation

A total of 7 datasets containing 106,391 records and 40 columns were assessed.

## 2. Dataset Summary

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

## 3. Duplicate Analysis

Duplicate analysis was performed to identify:
- Completely duplicated rows.
- Duplicate primary key values.

No full-row or primary-key duplicates were identified during the initial checks.

## 4. Missing Value Analysis

Missing values were identified only in the `purpose` column of the Transactions dataset.

| Column | Missing Values | Missing Percentage |
|---|---:|---:|
| purpose | 67,264 | 65.38% |

### Channel-wise Missing Value Analysis

| Channel | Total Transactions | Missing Purpose | Missing % |
|---|---:|---:|---:|
| ATM cash withdrawal | 15,930 | 15,930 | 100% |
| Card POS | 4,274 | 4,274 | 100% |
| M-Pesa | 40,292 | 40,292 | 100% |
| Branch | 7,668 | 6,768 | 88.26% |
| Bank transfer | 15,424 | 0 | 0% |
| Interest | 3,694 | 0 | 0% |
| Standing order | 15,598 | 0 | 0% |

### Decision

The missing values were retained because the missingness is structured by transaction channel. The exact reason for missing purpose values has not been confirmed.

No missing values were identified in the other six datasets.

## 5. Outlier Analysis

The Interquartile Range (IQR) method was used to identify potential numerical outliers.

### 5.1 Transactions Dataset

| Column | Outlier Count | Percentage |
|---|---:|---:|
| amount_kes | 4,086 | 3.97% |
| balance_kes | 7,323 | 7.12% |

**Investigation and Decision:**

- High `amount_kes` values were investigated by transaction channel, type and purpose.
- Several high-value transactions were associated with loan disbursements.
- These values were retained because statistical outliers are not necessarily data errors.
- High `balance_kes` values were investigated through account-level transaction balance reconciliation.
- All 101,980 available balance movements across 900 accounts matched the expected credit/debit calculations.
- Zero balance mismatches were identified.

Therefore, no capping or deletion was performed on these values.

### 5.2 Loans Dataset

| Column | Outlier Count | Percentage |
|---|---:|---:|
| amount_kes | 14 | 4.73% |
| monthly_payment_kes | 15 | 5.07% |

**Investigation and Decision:**

- High loan amounts and monthly payments were inspected along with loan duration and status.
- Outliers appeared across multiple loan statuses, including Current, Repaid, In arrears and Defaulted.
- No confirmed incorrect values were identified through the available checks.

Therefore, all identified loan outliers were retained.

## 6. Data Cleaning Decisions

| Data Quality Issue | Action Taken |
|---|---|
| Missing transaction purpose | Retained |
| Full-row duplicates | None identified |
| Primary-key duplicates | None identified |
| Transaction amount outliers | Retained |
| Transaction balance outliers | Retained after reconciliation |
| Loan amount outliers | Retained |
| Monthly payment outliers | Retained |
| nvalid dates | None identified
| Referential integrity issues | None identified
| Categorical inconsistencies |	None identified in observed values
| Cross-dataset date inconsistencies |	None identified
| Invalid account relationships |	None identified

No unnecessary deletion, imputation or outlier capping was performed.

## 7. Limitations

- Missing transaction purposes cannot be reliably reconstructed from the available data.
- Balance reconciliation confirms internal mathematical consistency, not independent real-world accuracy.
- Loan repayment history is unavailable; actual repayment timeliness cannot be assessed.
- High-value transactions and loans require business context before being classified as errors.
- The datasets are synthetic and should not be interpreted as actual bank performance.

## 8. Conclusion

The data quality assessment identified structured missing values in transaction purposes and potential numerical outliers in transaction and loan datasets.

Further investigation confirmed that transaction balance movements were internally consistent across all 900 accounts, with zero mismatches across 101,980 checked movements.

Categorical values, date fields, and cross-dataset relationships were also validated. No duplicate records, invalid references, or tested business-rule inconsistencies were identified.

All identified outliers were retained because no confirmed data errors were established. Missing transaction purposes were also retained because their exact reasons could not be established.

The datasets are ready to proceed to the data cleaning and exploratory data analysis stages.


## 9. Data Cleaning Summary

### 9.1 Cleaning Operations

The following cleaning operations were performed:

- Converted date columns from object to datetime format.
- Retained missing values in the Transactions dataset's purpose column.
- No duplicate records were found; therefore, no duplicate removal was required.
- Primary keys were validated, and no corrections were required.
- Numerical data types were already appropriate.
- No categorical value corrections were required.
- Identified outliers were retained because they were not confirmed as invalid records.

### 9.2 Cleaned Dataset Summary

All seven cleaned datasets were successfully saved in the data/cleaned/ directory.

| Dataset | Rows | Columns |
|---|---:|---:|
| Customers | 1,034 | 5 |
| Accounts | 900 | 5 |
| Account_Holders | 1,034 | 4 |
| Transactions | 102,880 | 8 |
| Loans | 296 | 7 |
| Cards | 232 | 4 |
| Counties | 15 | 7 |
| **Total** | **106,391** | **40** |

### 9.3 Data Integrity Verification

- All seven cleaned datasets were successfully reloaded.
- Original and cleaned dataset shapes were identical.
- Original and cleaned records matched after accounting for date datatype conversion.
- No unintended data modifications were detected.

### 9.4 Conclusion

The data cleaning process was completed successfully. The cleaned datasets are stored separately from the raw datasets and are ready for Exploratory Data Analysis (EDA).