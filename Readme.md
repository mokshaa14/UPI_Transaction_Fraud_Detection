# UPI Transaction Fraud Detection Dashboard
## Business Question
1. What is our overall fraud rate?
2. Is fraud increasing or decreasing over time?
3. Which locations are generating the most fraud?
4. Which transaction types are most vulnerable to fraud?
5. What fraud indicators are most common among fraudulent transactions?
6. Which banks or merchant categories experience the highest fraud?
7. Which accounts should be investigated immediately?
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
