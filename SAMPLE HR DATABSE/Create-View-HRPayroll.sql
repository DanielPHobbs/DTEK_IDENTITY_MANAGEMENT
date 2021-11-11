use [DTEKUK-HR]
go

CREATE VIEW hrpayroll
AS
SELECT 
      first_name,
      last_name,
      email,
      phone_number,
	  e.job_id,
	  j.job_title,
      hire_date,
      salary
     
    FROM
        dbo.employees e
            INNER JOIN
        jobs j ON j.job_id= e.job_id


  --DROP VIEW hrpayroll