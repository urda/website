---
title: 'Extracting Information From XML With C#'
author: Peter Urda
layout: post
redirect_from: /2010/08/extracting-information-from-xml-with-csharp/
categories:
  - How To
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
  - XML
---
XML is a wonderful way to store information that needs to be read in by a machine or piece of software. It is simple to follow, and you can use it to store and transmit your custom data structures and information across an internet connection or in between bits of software on a local machine. C# has methods built in that can read and write XML files. So today I have put together a little program that will extract a few objects from an XML file in C# for you to see.

Say we want to store simple C# objects that describe a person. A person in our case has a first name, last name, age, and gender. So we can structure our XML file as shown below.

**2People.xml:**

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
</People>
```

This XML is easy to follow, and it would be very simple for a person to just extract the information by hand in this case. But what if we had 100 Person Objects? 1,000? 1,000,000,000? It would be much easier if we could write some software to do the extraction of this information for us. If you were to write such software, it could very well look a lot like the following:

```csharp
using System;
using System.Collections.Generic;
using System.Xml;

namespace UsingXML
{
    // We establish a generic Person Class, and define necessary methods
    class PersonObject
    {
        public string fname { get; set; }
        public string lname { get; set; }
        public int age { get; set; }
        public char gender { get; set; }

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
        static void Main(string[] args)
        {
            // Prompt the user for file path, provide the current local
            // directory if the user wants to use a relative path.
            Console.Write("Current Local Path: ");
            Console.WriteLine(Environment.CurrentDirectory);
            Console.Write("Path to file? > ");
            string UserPath = Console.ReadLine();

            // Declare a new XML Document
            XmlDocument XmlDoc = new XmlDocument();

            // Try to open the XML file
            try
            {
                Console.WriteLine("\nNow Loading: {0}\n", UserPath);
                XmlDoc.Load(UserPath);
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

            // Declare the xpath for finding objects inside the XML file
            XmlNodeList XmlDocNodes = XmlDoc.SelectNodes("/People/Person");

            // Define a new List, to store the objects we pull out of the XML
            List<PersonObject> PersonList = new List<PersonObject>();

            // Loop through the nodes, extracting Person information.
            // We can then define a person object and add it to the list.
            foreach (XmlNode node in XmlDocNodes)
            {
                int TempAge = int.Parse(node["Age"].InnerText);
                char TempGender = node["Gender"].InnerText[0];

                PersonObject obj = new PersonObject(node["FirstName"].InnerText,
                                                    node["LastName"].InnerText,
                                                    TempAge,
                                                    TempGender);
                PersonList.Add(obj);
            }

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

In a nutshell this program follows a specific routine:

  * Declare a *PersonObject* class
  * Prompt user for a path, attempt to open the file or handle any exceptions.
  * Declare a C# list for storing the *PersonObjects*
  * Read in each node that matches from the XML document
  * Extract the key-value pairs and load them into the appropriate variables for each *PersonObject*
  * Display the results to the user, and exit

When we run the program, using the XML from above, we will see this output:

<img src="http://www.peter-urda.com/wp/wp-content/uploads/2010/08/runningApplication.png" alt="PersonObjects Program Output" title="PersonObjects Program Output" width="677" height="342" class="aligncenter size-full wp-image-437" />

C# has plenty more methods for reading and handling XML files and XML based information. This is just a very basic example, but it does help a lot if you are just starting to learn C# programming and XML and handling. If you are looking for some further reading, you may want to <a href="http://msdn.microsoft.com/en-us/library/system.xml.xmldocument.aspx" class="external external_icon" target="_blank">read up on the XmlDocument Class over at MSDN</a>.
