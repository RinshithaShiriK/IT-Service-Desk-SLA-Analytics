CREATE DATABASE IT_Service_Desk_Analytics;

use IT_Service_Desk_Analytics;


RENAME TABLE
it_service_desk_sla_cleaned_no_missing_12000
TO service_desk_tickets;

SELECT
    COUNT(*) AS Total_Tickets,
    SUM(CASE
        WHEN SLA_Status = 'Met' THEN 1
        ELSE 0
    END) AS SLA_Met,
    SUM(CASE
        WHEN SLA_Status = 'Breached' THEN 1
        ELSE 0
    END) AS SLA_Breached,
    ROUND(
        100.0 * SUM(CASE
            WHEN SLA_Status = 'Met' THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS SLA_Compliance_Rate,
    ROUND(
        AVG(Response_Time_Hours), 2
    ) AS Avg_Response_Hours,
    ROUND(
        AVG(Resolution_Time_Hours), 2
    ) AS Avg_Resolution_Hours
FROM service_desk_tickets;

SELECT
    Priority,
    COUNT(*) AS Total_Tickets,
    SUM(CASE
        WHEN SLA_Status = 'Breached' THEN 1
        ELSE 0
    END) AS SLA_Breaches,
    ROUND(
        100.0 * SUM(CASE
            WHEN SLA_Status = 'Breached' THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS Breach_Rate,
    ROUND(AVG(Resolution_Time_Hours), 2) AS Avg_Resolution_Hours
FROM service_desk_tickets
GROUP BY Priority
ORDER BY Breach_Rate DESC;

SELECT
    Category,
    COUNT(*) AS Total_Tickets,
    SUM(CASE
        WHEN SLA_Status = 'Breached' THEN 1
        ELSE 0
    END) AS SLA_Breaches,
    ROUND(
        100.0 * SUM(CASE
            WHEN SLA_Status = 'Breached' THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS Breach_Rate,
    ROUND(AVG(Resolution_Time_Hours), 2) AS Avg_Resolution_Hours
FROM service_desk_tickets
GROUP BY Category
ORDER BY Breach_Rate DESC;

SELECT
    Category,
    ROUND(AVG(Response_Time_Hours), 2) AS Avg_Response_Hours,
    ROUND(AVG(Resolution_Time_Hours), 2) AS Avg_Resolution_Hours,
    ROUND(AVG(SLA_Target_Hours), 2) AS Avg_SLA_Target_Hours
FROM service_desk_tickets
GROUP BY Category
ORDER BY Avg_Resolution_Hours DESC;

SELECT
    Assigned_Team,
    COUNT(*) AS Total_Tickets,
    ROUND(AVG(Response_Time_Hours), 2) AS Avg_Response_Hours,
    ROUND(AVG(Resolution_Time_Hours), 2) AS Avg_Resolution_Hours,
    SUM(CASE
        WHEN SLA_Status = 'Breached' THEN 1
        ELSE 0
    END) AS SLA_Breaches,
    ROUND(
        100.0 * SUM(CASE
            WHEN SLA_Status = 'Breached' THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS Breach_Rate
FROM service_desk_tickets
GROUP BY Assigned_Team
ORDER BY Breach_Rate DESC;

SELECT
    Created_Month,
    COUNT(*) AS Total_Tickets,
    SUM(CASE
        WHEN SLA_Status = 'Breached' THEN 1
        ELSE 0
    END) AS SLA_Breaches,
    ROUND(
        100.0 * SUM(CASE
            WHEN SLA_Status = 'Breached' THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS Breach_Rate,
    ROUND(AVG(Resolution_Time_Hours), 2) AS Avg_Resolution_Hours
FROM service_desk_tickets
GROUP BY Created_Month
ORDER BY Created_Month;

SELECT
    Category,
    Sub_Category,
    COUNT(*) AS Ticket_Count,
    ROUND(AVG(Resolution_Time_Hours), 2) AS Avg_Resolution_Hours,
    SUM(CASE
        WHEN SLA_Status = 'Breached' THEN 1
        ELSE 0
    END) AS SLA_Breaches,
    ROUND(
        100.0 * SUM(CASE
            WHEN SLA_Status = 'Breached' THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS Breach_Rate
FROM service_desk_tickets
GROUP BY Category, Sub_Category
HAVING COUNT(*) >= 50
ORDER BY SLA_Breaches DESC
LIMIT 10;