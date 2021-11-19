use [DTEKUK-HR]

SELECT 
    e.first_name + ' ' + e.last_name AS employee,
    m.first_name +' ' + m.last_name AS manager
FROM
    employees e
        INNER JOIN
    employees m ON m.employee_id = e.manager_id
ORDER BY manager;