select *
from upi;

-- Fraud rate kpi
SELECT
COUNT(*) AS total_transactions,
SUM(isFraud) AS fraud_transactions,
ROUND(100.0 * SUM(isFraud)/COUNT(*),2) AS fraud_rate_percent
FROM upi;

-- fraud by transaction type 
SELECT
type,
COUNT(*) AS total_transactions,
SUM(isFraud) AS fraud_count,
ROUND(
100.0 * SUM(isFraud)/COUNT(*),2
) AS fraud_rate
FROM upi
GROUP BY type
ORDER BY fraud_rate DESC;

-- Transactions above 3 standard deviations (to find anomalies)
WITH user_stats AS
(
SELECT
nameOrig,
AVG(amount) avg_amt,
STDDEV(amount) std_amt
FROM upi
GROUP BY nameOrig
)

SELECT
t.nameOrig,
t.amount,
u.avg_amt,
u.std_amt
FROM upi t
JOIN user_stats u
ON t.nameOrig=u.nameOrig
WHERE t.amount >
(u.avg_amt + 3*u.std_amt);

CREATE VIEW flagged_accounts AS
WITH user_stats AS
(
    SELECT
        nameOrig,
        AVG(amount) AS avg_amt,
        STDDEV(amount) AS std_amt
    FROM upi
    GROUP BY nameOrig
)
SELECT
    t.step,
    t.type,
    t.amount,
    t.nameOrig,
    t.oldbalanceOrg,
    t.newbalanceOrig,
    t.nameDest,
    t.oldbalanceDest,
    t.newbalanceDest,
    t.isFraud,
    t.isFlaggedFraud,
    u.avg_amt,
    u.std_amt
FROM upi t
JOIN user_stats u
    ON t.nameOrig = u.nameOrig
WHERE t.amount > (u.avg_amt + 3*u.std_amt);
select * from flagged_accounts;

-- Hour Wise fraud analysis
SELECT
MOD(step,24) AS hour_of_day,
COUNT(*) total_txn,
SUM(isFraud) fraud_count
FROM upi
GROUP BY MOD(step,24)
ORDER BY hour_of_day;

-- Weekly fraud analysis
SELECT
CASE
WHEN MOD(FLOOR(step/24),7)=0 THEN 'Monday'
WHEN MOD(FLOOR(step/24),7)=1 THEN 'Tuesday'
WHEN MOD(FLOOR(step/24),7)=2 THEN 'Wednesday'
WHEN MOD(FLOOR(step/24),7)=3 THEN 'Thursday'
WHEN MOD(FLOOR(step/24),7)=4 THEN 'Friday'
WHEN MOD(FLOOR(step/24),7)=5 THEN 'Saturday'
ELSE 'Sunday'
END AS day_name,
COUNT(*) total_txn,
SUM(isFraud) fraud_count
FROM upi
GROUP BY day_name;

-- fraud lose transaction type
SELECT
type,
SUM(amount) fraud_amount
FROM upi 
WHERE isFraud=1
GROUP BY type
ORDER BY fraud_amount DESC;

-- top fraudlent accounts 
SELECT
nameOrig,
COUNT(*) fraud_count,
SUM(amount) fraud_amount
FROM upi 
WHERE isFraud=1
GROUP BY nameOrig
ORDER BY fraud_amount DESC
LIMIT 20;

-- system flagged accuacy
SELECT
isFlaggedFraud,
COUNT(*) total_txn,
SUM(isFraud) actual_fraud
FROM upi 
GROUP BY isFlaggedFraud;

-- balance mismatch analysis 
SELECT
isFraud,
COUNT(*) total_txn,
SUM(
CASE
WHEN ABS((oldbalanceOrg - amount) - newbalanceOrig) > 1
THEN 1
ELSE 0
END
) balance_mismatch
FROM upi
GROUP BY isFraud;

-- transaction amount risk analysis
SELECT
CASE
WHEN amount < 1000 THEN 'Below 1K'
WHEN amount < 10000 THEN '1K-10K'
WHEN amount < 50000 THEN '10K-50K'
WHEN amount < 100000 THEN '50K-100K'
ELSE 'Above 100K'
END AS amount_bucket,

COUNT(*) total_txn,
SUM(isFraud) fraud_count,

ROUND(
100.0 * SUM(isFraud)/COUNT(*),2
) fraud_rate

FROM upi 

GROUP BY amount_bucket

ORDER BY fraud_rate DESC;

