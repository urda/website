---
title: 'Write to XML with C#'
author: Peter Urda
layout: post
redirect_from: /2010/09/write-to-xml-with-c-sharp/

urda_uuid: 20100903

categories:
  - How To
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
  - XML
---

So we can read XML in a variety of ways ([one example here]({% post_url 2010-08-30-extracting-information-from-xml-with-csharp %}),
[and another here]({% post_url 2010-08-31-using-linq-to-extract-information-from-xml-in-csharp %})).
So can we write it in C#? Of course we can! So lets jump right into shall we?

So here is the steps I take in this sample:

```csharp
using System;
using System.Xml;

namespace WriteXML01
{
    // Let's establish a generic Person Class, and define necessary methods
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

    class WriteXML01
    {
        static void Main(string[] args)
        {
            // Let's Build a few people
            PersonObject PeterUrda = new PersonObject("Peter", "Urda", 21, 'M');

            // Lets define an XML document
            XmlDocument XMLDoc = new XmlDocument();

            // Create an XML declaration
            XmlDeclaration XMLDec =
                XMLDoc.CreateXmlDeclaration("1.0", "utf-8", null);

            // Create the root of the XML file
            XmlElement RootNode = XMLDoc.CreateElement("People");
            // Make sure the declaration gets inserted before the XML root
            XMLDoc.InsertBefore(XMLDec, XMLDoc.DocumentElement);
            // Add the root
            XMLDoc.AppendChild(RootNode);

            // Make an object to store the elements in
            XmlElement PersonToXML = XMLDoc.CreateElement("Person");
            // And add that to the XML document
            XMLDoc.DocumentElement.PrependChild(PersonToXML);

            // Make the Elements
            XmlElement FNameNode = XMLDoc.CreateElement("FirstName");
            XmlElement LNameNode = XMLDoc.CreateElement("LastName");
            XmlElement AgeNode = XMLDoc.CreateElement("Age");
            XmlElement GenderNode = XMLDoc.CreateElement("Gender");

            // Load the info for the text information
            XmlText FNameText = XMLDoc.CreateTextNode(PeterUrda.fname);
            XmlText LNameText = XMLDoc.CreateTextNode(PeterUrda.lname);
            XmlText AgeText = XMLDoc.CreateTextNode(PeterUrda.age.ToString());
            XmlText GenderText =
                XMLDoc.CreateTextNode(PeterUrda.gender.ToString());

            // Add the elements into the object
            PersonToXML.AppendChild(FNameNode);
            PersonToXML.AppendChild(LNameNode);
            PersonToXML.AppendChild(AgeNode);
            PersonToXML.AppendChild(GenderNode);

            // Add the text into the elmemnts
            FNameNode.AppendChild(FNameText);
            LNameNode.AppendChild(LNameText);
            AgeNode.AppendChild(AgeText);
            GenderNode.AppendChild(GenderText);

            // Prompt the user where to save to, provide the current local
            // directory if the user wants to use a relative path.
            Console.Write("Current Local Path: \n");
            Console.WriteLine(Environment.CurrentDirectory);
            Console.Write("\nSAVE AS? "
                          + "[CAUTION: This does overwrite files!]\n"
                          + "(defaults to ..\\..\\Output.xml) > ");
            string UserPath = Console.ReadLine();

            // Nothing? Default to something.
            if (UserPath == "")
            {
                UserPath = "..\\..\\Output.xml";
            }

            // Try/Catch issues
            try
            {
                XMLDoc.Save(UserPath);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                Environment.Exit(1);
            }

            Environment.Exit(0);
        }
    }
}
```

First I make a generic person class to store my data in, and get it back out for
the XML later. This could resemble an object we could get from a data factory or
a SQL database. But it is an object nonetheless.

We then define the declaration of the document, it just states what version and
encoding we are using in this specific XML file. We then use some XmlDocument
methods to make sure that a root node (People in this case) is created and that
our declaration is stuck right before it.

Once that is all said and done, we create a parent node, PersonToXML in this
case, and add it after our root node with PrependChild.

We then use multiple lines of code create the Elements for our XML object, and
the text they will contain. We use even more XmlDocument methods to add these in
order to build our logical structure. Finally, we get a path from the user,
catch exceptions if needed, and write the XML file.

Here is the output we get when we run the program:

[![Program Output](/content/{{ page.urda_uuid }}/RunningProgram.png)](/content/{{ page.urda_uuid }}/RunningProgram.png)

The file overwrites Output.xml each time it is ran, and it produces the same
results every time (surprising, I know). So be careful!

Pretty simple huh? Just add some loops or database calls, and you can be using
XML for just about anything you can think of!
