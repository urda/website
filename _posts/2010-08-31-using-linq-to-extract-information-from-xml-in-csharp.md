---
title: 'Using LINQ to Extract Information from XML in C#'
layout: post
redirect_from: /2010/08/using-linq-to-extract-information-from-xml-in-csharp/

urda_uuid: 20100831

categories:
  - How To
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
  - LINQ
  - XML
---

[Yesterday I talked about]({% post_url 2010-08-30-extracting-information-from-xml-with-csharp %})
using C# to extract information from a simple XML file. Well today we can take
it one step further. Instead of using the regular XML library and commands, we
can use LINQ to build a query to extract the information we desire, and place it
into our object list.

In case you are not familiar with LINQ, here is a quick overview on it:

> Language Integrated Query (LINQ, pronounced "link") is a Microsoft .NET
> Framework component that adds native data querying capabilities to .NET
> languages.
>
> LINQ defines a set of method names (called standard query operators, or
> standard sequence operators), along with translation rules from so-called
> query expressions to expressions using these method names, lambda expressions
> and anonymous types. These can, for example, be used to project and filter
> data in arrays, enumerable classes, XML (XLINQ), relational database, and
> third party data sources. Other uses, which utilize query expressions as a
> general framework for readably composing arbitrary computations, include the
> construction of event handlers or monadic parsers.
>
> Source: [Language Integrated Query - Wikipedia](https://en.wikipedia.org/w/index.php?title=Language_Integrated_Query&oldid=382114822)

So if we modify the previous program to use a LINQ statement instead, we can use
logic and syntax that look a lot like a SQL statement. But instead of accessing
a SQL database, we are instead polling an array or chunk of data. In our case we
are using LINQ to run a query against a chunk of XML data.

So let's cut to the chase, here is the modified source code from the last post:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace UsingXML
{
    // We establish a generic Person Class, and define necessary methods
    class PersonObject
    {
        public string fname { get; set; }
        public string lname { get; set; }
        public int age { get; set; }
        public char gender { get; set; }

        public PersonObject()
        {
            this.fname = null;
            this.lname = null;
            this.age = 0;
            this.gender = '0';
        }
        public PersonObject(string f, string l, int a, char g)
        {
            this.fname = f;
            this.lname = l;
            this.age = a;
            this.gender = g;
        }
    }

    class ReadAndLoad
    {
        // Declare a public XDocument for use
        public static XDocument XDoc;

        static void Main(string[] args)
        {
            // Prompt the user for file path, provide the current local
            // directory if the user wants to use a relative path.
            Console.Write("Current Local Path: ");
            Console.WriteLine(Environment.CurrentDirectory);
            Console.Write("Path to file? > ");
            string UserPath = Console.ReadLine();

            // Try to open the XML file
            try
            {
                Console.WriteLine("\nNow Loading: {0}\n", UserPath);
                XDoc = XDocument.Load(@UserPath);
            }
            // Catch "File Not Found" errors
            catch (System.IO.FileNotFoundException)
            {
                Console.WriteLine("No file found!");
                Environment.Exit(1);
            }
            // Catch Argument Exceptions
            catch (System.ArgumentException)
            {
                Console.WriteLine("Invalid path detected!");
                Environment.Exit(1);
            }
            // Catach all other errors, and print them to console.
            catch (Exception err)
            {
                Console.WriteLine("An Exception has been caught:");
                Console.WriteLine(err);
                Environment.Exit(1);
            }

            // Define a new List, to store the objects we pull out of the XML
            List<PersonObject> PersonList = new List<PersonObject>();

            // Build a LINQ query, and run through the XML building
            // the PersonObjects
            var query = from xml in XDoc.Descendants("Person")
                        select new PersonObject
                        {
                            fname = (string)xml.Element("FirstName"),
                            lname = (string)xml.Element("LastName"),
                            age = (int)xml.Element("Age"),
                            gender = ((string)xml.Element("Gender") == "M" ?
                                'M' :
                                'F')
                        };
            PersonList = query.ToList();

            // How many PersonObjects did we find in the XML?
            int ListSize = PersonList.Count;

            // Handle statements for 0, 1, or many PersonObjects
            if (ListSize == 0)
            {
                Console.WriteLine("File contains no PersonObjects.\n");
                Environment.Exit(0);
            }
            else if (ListSize == 1)
                Console.WriteLine("Contains 1 PersonObject:\n");
            else
                Console.WriteLine("Contains {0} PersonObjects:\n", ListSize);

            // Loop through the list, and print all the PersonObjects to screen
            for (int i = 0; i < ListSize; i++)
            {
                Console.WriteLine(" PersonObject {0}", i);
                Console.WriteLine("------------------------------------------");
                Console.WriteLine(" First Name : {0}", PersonList[i].fname);
                Console.WriteLine(" Last Name  : {0}", PersonList[i].lname);
                Console.WriteLine(" Age ...... : {0}", PersonList[i].age);
                Console.WriteLine(" Gender ... : {0}", PersonList[i].gender);
                Console.Write("\n");
            }

            // ...and we are done!
            Environment.Exit(0);
        }
    }
}
```

But here is where the real magic is:

```csharp
// Build a LINQ query, and run through the XML building
// the PersonObjects
var query = from xml in XDoc.Descendants("Person")
    select new PersonObject
    {
        fname = (string)xml.Element("FirstName"),
        lname = (string)xml.Element("LastName"),
        age = (int)xml.Element("Age"),
        gender = ((string)xml.Element("Gender") == "M" ? 'M' : 'F')
    };
PersonList = query.ToList();
```

Looks a lot like SQL huh? Well what this statement is doing is grabbing all the
objects in the XML that are a "Person". It then uses an empty PersonObject and
defines each of the variables in the object. There is a logic statement inside
the query to set the char for the gender in each object (since you cannot cast a
string to a char in this instance) based on the string retrieved from the XML.

Now for comparison, let's look at the difference between the two sources:

```diff
--- ReadAndLoad.cs	2010-08-31 22:34:53.082425983 -0400
+++ ReadAndLoad02.cs	2010-08-31 22:34:50.682829175 -0400
@@ -1,6 +1,7 @@
 ﻿using System;
 using System.Collections.Generic;
-using System.Xml;
+using System.Linq;
+using System.Xml.Linq;

 namespace UsingXML
 {
@@ -12,6 +13,13 @@
         public int age { get; set; }
         public char gender { get; set; }

+        public PersonObject()
+        {
+            this.fname = null;
+            this.lname = null;
+            this.age = 0;
+            this.gender = '0';
+        }
         public PersonObject(string f, string l, int a, char g)
         {
             this.fname = f;
@@ -23,6 +31,9 @@

     class ReadAndLoad
     {
+        // Declare a public XDocument for use
+        public static XDocument XDoc;
+
         static void Main(string[] args)
         {
             // Prompt the user for file path, provide the current local
@@ -31,15 +42,12 @@
             Console.WriteLine(Environment.CurrentDirectory);
             Console.Write("Path to file? > ");
             string UserPath = Console.ReadLine();
-
-            // Declare a new XML Document
-            XmlDocument XmlDoc = new XmlDocument();
-
+
             // Try to open the XML file
             try
             {
                 Console.WriteLine("\nNow Loading: {0}\n", UserPath);
-                XmlDoc.Load(UserPath);
+                XDoc = XDocument.Load(@UserPath);
             }
             // Catch "File Not Found" errors
             catch (System.IO.FileNotFoundException)
@@ -61,26 +69,23 @@
                 Environment.Exit(1);
             }

-            // Declare the xpath for finding objects inside the XML file
-            XmlNodeList XmlDocNodes = XmlDoc.SelectNodes("/People/Person");
-
             // Define a new List, to store the objects we pull out of the XML
             List<PersonObject> PersonList = new List<PersonObject>();

-            // Loop through the nodes, extracting Person information.
-            // We can then define a person object and add it to the list.
-            foreach (XmlNode node in XmlDocNodes)
-            {
-                int TempAge = int.Parse(node["Age"].InnerText);
-                char TempGender = node["Gender"].InnerText[0];
-
-                PersonObject obj = new PersonObject(node["FirstName"].InnerText,
-                                                    node["LastName"].InnerText,
-                                                    TempAge,
-                                                    TempGender);
-                PersonList.Add(obj);
-            }
-
+            // Build a LINQ query, and run through the XML building
+            // the PersonObjects
+            var query = from xml in XDoc.Descendants("Person")
+                        select new PersonObject
+                        {
+                            fname = (string)xml.Element("FirstName"),
+                            lname = (string)xml.Element("LastName"),
+                            age = (int)xml.Element("Age"),
+                            gender = ((string)xml.Element("Gender") == "M" ?
+                                'M' :
+                                'F')
+                        };
+            PersonList = query.ToList();
+
             // How many PersonObjects did we find in the XML?
             int ListSize = PersonList.Count;
```

And just in case you were unsure about the gender logic part of the query, I ran
this dataset:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<People>
  <Person>
    <FirstName>Peter</FirstName>
    <LastName>Urda</LastName>
    <Age>21</Age>
    <Gender>M</Gender>
  </Person>
  <Person>
    <FirstName>Joe</FirstName>
    <LastName>White</LastName>
    <Age>30</Age>
    <Gender>M</Gender>
  </Person>
  <Person>
    <FirstName>Katie</FirstName>
    <LastName>Smith</LastName>
    <Age>25</Age>
    <Gender>F</Gender>
  </Person>
</People>
```

And got this result:

[![Program Output](/content/{{ page.urda_uuid }}/runningProgram.png)](/content/{{ page.urda_uuid }}/runningProgram.png)

Pretty sweet huh? So in review, we built a query to run against XML, and used
LINQ statements and methods to retrieve each portion of data that we wanted. All
of this was then shoved into a list at the end for storing. So hopefully this
gives you a quick intro to start messing around with LINQ if you are inclined to
do so.
