----- how things goes in the first half of the yrar?-------
   ---the current year---
select top 1 year(orderdate) recentyear
from Sales.SalesOrderHeader
order by orderdate desc
----sales performance for the first half---
----1- total sales from 1/2014 to 6/2014
select count(*) totalsales, sum(TotalDue) totalrevenue
from Sales.SalesOrderHeader
where orderdate between '2014-01-01' and '2014-06-30'
----compare sa;es to the same time last year
select count(*) totalsales2013, sum(TotalDue) totalrevenue2013
from Sales.SalesOrderHeader
where orderdate between '2013-01-01' and '2013-06-30'
---2-each month total sales and revenue
select month(orderdate) month, count(*) totalsales, sum(TotalDue) totalrevenue, avg(totaldue) avrageordervalue
from Sales.SalesOrderHeader
where orderdate between '2014-01-01' and '2014-06-30'
group by month(orderdate)
order by month 
----compare to the last year --
select month(orderdate) month, count(*) totalsales2013, sum(TotalDue) totalrevenue2013, avg(totaldue) avrageordervalue2013
from Sales.SalesOrderHeader
where orderdate between '2013-01-01' and '2013-06-30'
group by month(orderdate)
order by month
----- top10 most selled product --
select top 10 p.name product, p.productid, sum(sod.OrderQty) totalquntity, sum(sod.linetotal) totalrevenue
from production.Product p join sales.SalesOrderDetail sod
on sod.ProductID = p.ProductID
join Sales.SalesOrderHeader soh 
on sod.SalesOrderID = soh.SalesOrderID
where OrderDate between '2014-01-01' and '2014-06-30'
group by p.Name, p.ProductID
order by totalrevenue desc
---- regions saales distribution
select  st.TerritoryID, st.name territoryname, st.countryregioncode, st.[Group] region, count(*) totalsales, sum(soh.totaldue) totalrevenue, avg(soh.totaldue) avrageordervalue
from sales.SalesTerritory st 
join sales.salesorderheader soh
on soh.territoryid = st.territoryid
where OrderDate between '2014-01-01' and '2014-06-30'
group by  st.TerritoryID, st.name, st.[group], st.countryregioncode
order by totalrevenue desc


