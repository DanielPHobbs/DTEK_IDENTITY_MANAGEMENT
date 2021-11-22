
USE [DTEKUK-HR]
GO

/****** Object:  View [dbo].[hrpayroll]    Script Date: 22/11/2021 20:03:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*DROP VIEW hrpayroll*/
ALTER VIEW [dbo].[hrpayroll]
AS
SELECT        e.employee_id, 
e.first_name, 
e.last_name,
e.email, 
e.phone_number,
j.job_title,
dbo.departments.department_name,
dbo.locations.street_address, 
dbo.locations.postal_code, 
dbo.locations.city, 
dbo.locations.state_province, 
dbo.countries.country_name, 
dbo.regions.region_name, 
e.first_name + ' ' + e.last_name AS employee,
m.first_name +' ' + m.last_name AS manager

FROM            dbo.employees AS e INNER JOIN
                         dbo.jobs AS j ON j.job_id = e.job_id INNER JOIN
                         dbo.departments ON e.department_id = dbo.departments.department_id INNER JOIN
                         dbo.locations ON dbo.departments.location_id = dbo.locations.location_id INNER JOIN
                         dbo.countries ON dbo.locations.country_id = dbo.countries.country_id INNER JOIN
                         dbo.regions ON dbo.countries.region_id = dbo.regions.region_id
						 
									INNER JOIN
							employees m ON m.employee_id = e.manager_id
GO
GO

  --DROP VIEW hrpayroll