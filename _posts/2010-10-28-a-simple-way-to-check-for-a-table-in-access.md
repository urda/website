---
title: A Simple Way to Check for a Table in Access
author: Peter Urda
layout: post
redirect_from: /2010/10/a-simple-way-to-check-for-a-table-in-access/
categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
  - Programming
---
As I worked on another project today, I came across a simple dilemma. The project reads in a small Microsoft Access database (also known as a .mdb file) into memory. It then queries said database with a simple &#8216;**SELECT foo FROM bar&#8230;&#8217;** statement and pulls the results into the program. However, if you load an Access database that does not follow the expected schema, the program throws a nasty error and causes some logic interruption. I needed a simple way to check for a few table names before proceeding, so I whipped up a simple C# method.

It is a pretty simple C# method. It basically checks to see if the file path to the Access database is available. If it is available it checks the schema inside the database for the given table name. If found, the boolean variable will be set to true. If not, the method will return false.

See if you can follow along with comments in the code:

<pre class="brush: csharp; title: ; notranslate" title="">public bool DoesTableExist(string TableName)
{
    // Variables availbe to the method, but not defined here are:
    // SomeFilePath (string)

    // Variable to return that defines if the table exists or not.
    bool TableExists = false;

	// If the file path is empty, no way a table could exist!
    if (SomeFilePath.Equals(String.Empty))
    {
        return TableExists;
    }

    // Using the Access Db connection...
    using (OleDbConnection DbConnection
           = new OleDbConnection(GetConnString(SomeFilePath)))
    {
        // Try the database logic
        try
        {
            // Make the Database Connection
            DbConnection.Open();

            // Get the datatable information
            DataTable dt = DbConnection.GetSchema("Tables");

            // Loop throw the rows in the datatable
            foreach (DataRow row in dt.Rows)
            {
                // If we have a table name match, make our return true
                // and break the looop
                if (row.ItemArray[2].ToString() == TableName)
                {
                    TableExists = true;
                    break;
                }
            }
        }
        catch (Exception e)
        {
            // Handle your ERRORS!
        }
        finally
        {
            // Always remeber to close your database connections!
            DbConnection.Close();
        }
    }

    // Return the results!
    return TableExists;
}
</pre>

Feel free to integrate this into your project, this may come in handy with one of your future projects!