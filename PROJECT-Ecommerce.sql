select * from custom_ratios
select * from data_large


SELECT * FROM custom_ratios
UNION ALL
SELECT * FROM data_large;

SELECT 
    c.[Customer ID],
    c.[Customer Name],
    c.[Product Category] AS category_custom,
    d.[Product Category] AS category_data,
    c.[Total Purchase Amount] AS purchase_custom,
    d.[Total Purchase Amount] AS purchase_data,
    c.[Returns] AS returns_custom,
    d.[Returns] AS returns_data
FROM custom_ratios c
INNER JOIN data_large d
    ON c.[Customer ID] = d.[Customer ID];



SELECT 
    c.[Product Category],
    SUM(CASE WHEN d.[Returns] = 'Yes' THEN 1 ELSE 0 END) * 100.0 
        / NULLIF(COUNT(c.[Customer ID]), 0) AS return_rate
FROM custom_ratios c
LEFT JOIN data_large d 
    ON c.[Customer ID] = d.[Customer ID]
GROUP BY c.[Product Category]
ORDER BY return_rate DESC;


SELECT 
    c.[Customer Age],
    SUM(CASE WHEN d.[Returns] = 'Yes' THEN 1 ELSE 0 END) * 100.0 
        / NULLIF(COUNT(c.[Customer ID]), 0) AS return_rate
FROM custom_ratios c
LEFT JOIN data_large d 
    ON c.[Customer ID] = d.[Customer ID]
GROUP BY c.[Customer Age]
ORDER BY return_rate DESC;


SELECT 
    c.[Payment Method],
    SUM(CASE WHEN d.[Returns] = 'Yes' THEN 1 ELSE 0 END) * 100.0 
        / NULLIF(COUNT(c.[Customer ID]), 0) AS return_rate
FROM custom_ratios c
LEFT JOIN data_large d 
    ON c.[Customer ID] = d.[Customer ID]
GROUP BY c.[Payment Method]
ORDER BY return_rate DESC;


SELECT TOP 10
    c.[Product Category],
    SUM(CASE WHEN d.[Returns] = 'Yes' THEN 1 ELSE 0 END) * 100.0 
        / NULLIF(COUNT(c.[Customer ID]), 0) AS product_return_rate,
    COUNT(c.[Customer ID]) AS total_orders
FROM custom_ratios c
LEFT JOIN data_large d 
    ON c.[Customer ID] = d.[Customer ID]
GROUP BY c.[Product Category]
HAVING COUNT(c.[Customer ID]) > 50
ORDER BY product_return_rate DESC, total_orders DESC;

