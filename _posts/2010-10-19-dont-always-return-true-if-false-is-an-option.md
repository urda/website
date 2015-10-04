---
title: Don't Always 'return true' if False is an Option!
author: Peter Urda
layout: post
redirect_from: /2010/10/dont-always-return-true-if-false-is-an-option/
categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
  - Oracle
---

I was working on one of Mercer's internal applications today. I ran across an off the wall query from our QA team. They wanted to know what was the best way to confirm the information going into an Oracle database was actually written to the database. I told them it was simple **SELECT FROM ...** query, but when I went to run the statement myself, I did not get the results I expected. Two major things were wrong in the codebase: one commits were not actually being made to the Oracle database. Two, a boolean method was configured to always **'return true'** making it look like the commits actually occurred.

To visually understand what was going on, I'll create a simple mockup method for you in C#:

<pre class="brush: csharp; title: ; notranslate" title="">class OracleDbHandler
{
    // Gadgets and Gizmo's Aplenty Here

    public static boolean CommitToDatabase(params p)
    {
        // Prepare data for INSERT
        string DataString = // ...
        // Build Connection String
        string ConnectionString = //...

        // Setup Connection
        var connection = new OracleConnection(ConnectionString);

        try
        {
            connection.Open();

            OracleCommand(DataString, connection);
        }
        finally
        {
            connection.Close();
        }

        return true;
    }

    // Whozits and Whatzits Galore Down Here
}
</pre>

You see the horrible issue with this? The main program for starters has a logic flow that handles a true return for a good commit, and a false return for a failed commit. Since this method will always 'return true' the program will always imagine that the commit occurred. In reality it did not! Sure we setup the Oracle command, but we never executed it! Our problems in a nutshell are:

  * A boolean method is always returning one, and only one, state
  * We build a connection, open it, never make any oracle commands, and just close it

So let's make corrections to this so the code is actually commited properly to the database:

<pre class="brush: csharp; title: ; notranslate" title="">class OracleDbHandler
{
    // Gadgets and Gizmo's Aplenty Here

    public static boolean CommitToDatabase(params p)
    {
        // Prepare data for INSERT
        string DataString = // ...
        // Build Connection String
        string ConnectionString = //...

        // Setup Connection
        var connection = new OracleConnection(ConnectionString);

        try
        {
            connection.Open();

            var OracleDataCommandCommit = OracleCommand(DataString, connection);

            using (var t = new TransactionScope())
            {
                var CommitRows = OracleDataCommandCommit.ExecuteNonQuery();
                if (CommitRows == 0)
                {
                    return false;
                }

                t.Complete();
            }
        }
        catch
        {
            return false;
        }
        finally
        {
            connection.Close();
        }

        return true;
    }

    // Whozits and Whatzits Galore Down Here
}
</pre>

We only made a few changes to our code to make it much more robust:

  * Had a generic catch statement that returns false on an error.
  * Actually write the code to make commits to the database.
  * Surround the database action section with a using block to control the transaction.
      * If the commit fails (0 rows added) then we fail the entire operation and return false.
      * If it works we complete the transaction and return true.

So now we have code the will actually write to the database, instead of just returning true! This situation is also the perfect example of why it is important to code for a true and a false situation in your methods. Especially if your main program is expecting either cases!
