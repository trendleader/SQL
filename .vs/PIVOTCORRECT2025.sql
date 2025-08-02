
SELECT *
FROM (
    SELECT year(date_of_service) AS SvcYr, [Provider_Type], paid_amount
    FROM dbo.claims_data
) AS SourceTable
PIVOT (
    SUM(paid_amount)
    FOR [Provider_Type] IN (Facility, Physician)
) AS PivotTable;


