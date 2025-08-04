SELECT
    member_id,
    drug_name,
    [2023], -- Pivoted column for 2023
    [2024]  -- Pivoted column for 2024
FROM
    (
        SELECT
            c.[member_id],
            ph.[drug_name],
            YEAR(ph.fill_date) AS Fill_Year, -- Extract just the year
            COUNT(*) AS DrugCount
        FROM
            [dbo].[Claims_Data] C
        INNER JOIN
            [dbo].[pharmacy_claims] ph ON c.member_id = ph.member_id
        WHERE
            YEAR(ph.fill_date) IN (2023, 2024) -- Filter for specific years
        GROUP BY
            c.[member_id],
            ph.[drug_name],
            YEAR(ph.fill_date)
    ) AS SourceData
PIVOT
    (
        SUM(DrugCount)
        FOR Fill_Year IN ([2023], [2024]) -- List the years you want as columns
    ) AS PivotTable
ORDER BY
     [2024] DESC;