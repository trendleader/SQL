
SELECT *
FROM (
    SELECT year(date_of_service) AS SvcYr, Type_of_Service, paid_amount
    FROM dbo.claims_data
) AS SourceTable
PIVOT (
    SUM(paid_amount)
    FOR type_of_service IN ([Inpatient], [Outpatient], [Professional])
) AS PivotTable;


