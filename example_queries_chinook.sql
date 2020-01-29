-- What are the names of the IT staff?
select EmployeeId, LastName, FirstName, Title 
from Employee 
where Title = "IT Staff";

-- using select * to get all columns, and also getting the IT Manager:
select * from Employee where Title = "IT Staff" or Title = "IT Manager";
-- the IN() keyword to make a set:
select * from Employee where Title in("IT Staff", "IT Manager");
-- IN() can also be used for complex subqueries. see, for example: https://www.sqlservertutorial.net/sql-server-basics/sql-server-subquery/
-- wildcard string comparison:
select * from Employee where Title like "IT%";
-- The lower() and upper() functions are often useful for these kind of queries too.

-- sorting customers by their country. within country, sort by last name:
select Country, LastName, FirstName 
from Customer 
order by Country, LastName;
-- sorting can also be descending, and you can also sort dates:
select InvoiceId, InvoiceDate, Total from Invoice 
order by InvoiceDate desc;

-- comparators in WHERE clauses, like > >= < <=
-- invoices whose total is more than $10:
select InvoiceId, InvoiceDate, Total from Invoice 
where Total > 10.00;
-- using between:
select InvoiceId, InvoiceDate, Total 
from Invoice 
where Total between 5.0 and 10.0;
-- comparisons also work with dates. invoices before Jan 1 2009:
select * where InvoiceDate > '2009-01-01';
-- all invoices from 2009:
select * where InvoiceDate between '2009-01-01' and '2009-12-31';

-- checking for nulls. Which employee reports to no one?
select * from Employee where ReportsTo is null;
-- customers with the Company column filled:
select * from Customer where Company is not null;

-- functions.
-- What are the invoices whose total rounds to $9?
select * from Invoice where round(Total) = 9;
-- functions also work in the SELECT clause.
select Total, round(Total) from Invoice where round(Total) = 9;
-- min, max, and avg for all invoice totals:
select min(Total), max(Total), avg(Total) from Invoice;
-- combining strings using the concatenate operator || . Also, you can name a column whatever you want:
select FirstName || ' ' || LastName as FullName from Customer;

-- joins.
-- Who is Frank Harris's customer support rep?
-- note that the Customer and Employee tables are aliased as C and E.
-- note also that we need to use these aliases in the SELECT and WHERE clauses to avoid errors.
select C.FirstName || ' ' || C.LastName as CustomerName, E.FirstName || ' ' || E.LastName as SupportRepName 
from Customer as C join Employee as E on C.SupportRepId = E.EmployeeId 
where C.LastName = 'Harris';

-- grouping results (aggregation).
-- How many customers do we have in each country?
select Country, count(Country) 
from Customer
group by Country 
order by count(Country) desc;
-- What cities do our US customers live in, and how many in each one?
select City, count(City) 
from Customer 
where Country = 'USA' 
group by City 
order by count(City) desc, City asc;