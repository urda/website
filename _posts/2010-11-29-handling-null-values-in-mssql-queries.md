---
title: Handling NULL Values in MSSQL Queries
author: Peter Urda
layout: post
redirect_from: /2010/11/handling-null-values-in-mssql-queries/
categories:
  - Mercer Daily Reports
tags:
  - Co-Op
  - MSSQL
  - SQL
---
When working with a given set of data in a Microsoft SQL server, you may have rows that contain one more **NULL** values for a given column. This may or may not impact your queries against the database, so it is important to understand how the database handles these values and how your queries should be designed around this consideration.

Let&#8217;s take a simple example table. This table contains a *Product ID*, *Product Name*, and *Product Price*. The table is also populated with a few values. 

<pre class="brush: plain; title: ProductTable; notranslate" title="ProductTable">PID  |PName       |PPrice |
-----|------------|-------|
 001 | Orange Mug | 9.99  |
 002 | Blue Mug   | 10.99 |
 003 | White Mug  | 8.99  |
 004 | NULL       | 7.99  |
</pre>

For one reason or another the name on the fourth entry is **NULL**. If you were asked to write up a simple query to check for this condition, you may use something like this:

<pre class="brush: sql; title: ; notranslate" title="">SELECT PID, PName, PPrice
FROM ProductTable
WHERE PName = NULL
</pre>

While this is correct from a syntax point of view, this query may very well return zero rows after it has finished running. This condition can be caused by the settings you used to connect to the database. This all depends on the setting of **ANSI_NULL**. A more appropriate method would be to use a script like this:

<pre class="brush: sql; title: ; notranslate" title="">SELECT PID, PName, PPrice
FROM ProductTable
WHERE PName IS NULL
</pre>

Since the *IS NULL* will be respected always and return rows back to you. 

What if you need to replace the null value with another value when running some type of calculation query? Simply use the **ISNULL** approach. This will check for a **NULL** condition and perform the appropriate step. Take a look at this for example:

<pre class="brush: sql; title: ; notranslate" title="">ISNULL(ColumnName, NewValueIfNull)
</pre>

So you can simply replace a chunk of data, or handle a null value differently in the middle of a query. Null values can be useful in a given application, but it is important to understand how queries will behave when encountering a null value when running a query.