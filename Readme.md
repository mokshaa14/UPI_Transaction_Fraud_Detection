# UPI Transaction Fraud Detection Dashboard
## Business Question
## Fraud Detection
1. Which transaction types have the highest fraud rates?
2. Are frauds concentrated during specific hours?
3. Which users make unusually large transactions?
4. What percentage of transactions are fraudulent?
5. Are there balance inconsistencies associated with fraud?
## Risk Monitoring
6. Which accounts should be flagged for investigation?
7. What is the trend of fraud over time?
8. Which transaction amounts are most risky?
9. Which transaction types trigger most fraud losses?
10. How effective is system flagging compared to actual fraud?
## Tools Used
- SQL (MY SQL)
- Power BI (dashboard and visualisation)
## Dataset
Source: Kaggle - Online Payments Fraud Detection Dataset
Link: https://www.kaggle.com/datasets/rupakroy/online-payments-fraud-detection-dataset
Size: 6.3 million transaction records
Key columns: step, type, amount, nameOrig, nameDest, isFraud
## What I Built
1. SQL queries to identify anomalous transactions by user
behaviour baseline
2. Fraud rate segmentation by transaction type and time of day
3. Power BI dashboard with:
- Overall fraud rate KPI card
- Fraud trend by week
- Transaction type breakdown
- Drill-through on flagged accounts
## Key Finding
[Write your actual finding here]
Example: "Peer-to-peer transfers above INR 50,000 between
11 PM and 3 AM accounted for 34% of all flagged transactions
despite being only 6% of total volume."
## How to Run
1. Download dataset from Kaggle link above
2. Load CSV into MYSQL
3. Run queries from upi_fraud.sql
4. Open fraud_dashboard.pbix in Power BI Desktop
## Files in This Repo
upi_fraud.sql - All SQL queries
fraud_dashboard.pbix - Power BI dashboard file
dashboard.png - Dashboard preview
README.md - This file
