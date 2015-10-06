---
title: 'IronPython and C#'
author: Peter Urda
layout: post
redirect_from: /2010/09/ironpython-and-csharp/
categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - IronPython
  - Visual Studio 2010
---
So the other day I wrote about <a href="http://www.peter-urda.com/2010/09/dynamic-types-in-csharp" target="_blank">dynamic types in C#</a>. I covered a few use cases from COM interaction to working with other languages. Well, today I have put together an example for you that will load a Python file into C#, through IronPython.

Before we can work with IronPython in C#, we need to setup our environment. Here is a quick overview of the steps we will take before we work with IronPython:

  1. Install the latest stable release of IronPython
  2. Create a new C# Console Application in Visual Studio 2010
  3. Add required references for IronPython
  4. ...then write the code!

The first step in working with IronPython in Visual Studio 2010 is to actually install IronPython. You'll need to visit <a href="http://ironpython.net/download/" class="external external_icon" target="_blank">IronPython.net</a> to grab the latest version of IronPython. Just install the latest **stable** release. For reference, I installed IronPython version 2.6.1 when I wrote this article. Just install all the recommended components. After that is done you can go ahead and startup Visual Studio.

After Visual Studio has started up, you'll need to start a new C# Console Application project. After you have created that we are going to need to add references (Right-Click on References in the Solution Explorer > "Add Reference...") to this project. Assuming you installed IronPython in the default directory you will find all the needed references in **"C:\Program Files\IronPython 2.6 for .NET 4.0"** on **32-bit systems** and **"C:\Program Files (x86)\IronPython 2.6 for .NET 4.0"** on **64-bit systems**. We will be adding the following references:

  * IronPython
  * IronPython.Modules
  * Microsoft.Dynamic
  * Microsoft.Scripting

Now we can actually get to the code creation! First we are going to make a new text file in the root of our project, and we will call it **PythonFunctions.py**. When that has been created you'll need to update the properties on that file, specifically set **Copy to Output Directory** to **Copy always**. Now we will fill out our Python file with some Python functions:

```python
def hello(name):
	print "Hello " + name + "! Welcome to IronPython!"
	return

def add(x, y):
	print "%i + %i = %i" % (x, y, (x + y))
	return

def multiply(x, y):
	print "%i * %i = %i" % (x, y, (x * y))
	return
```

This file is describing three basic functions in Python: A function that says "Hello {Name}! Welcome to IronPython!" and two math functions. All of these functions will print to our console in C# using the Python **print** command.

Now that we have our python prepared, we will rename the generic **Program.cs** file to **IronPythonMain.cs**. As always allow Visual Studio to update the references in the file when prompted. Our C# file will follow this workflow:

  * Create the IronPython Runtime
  * Enter a try/catch block to catch any exceptions (Unable to find the file, method called that does not exist at runtime, and so on)
  * Attempt to load the Python file
  * Run the Python Commands
  * Exit the Program

So here is the C# that will run our IronPython program...

```csharp
using IronPython.Hosting;
using IronPython.Runtime;
using Microsoft.Scripting.Hosting;
using System;

namespace IntroIronPython
{
    class IronPythonMain
    {
        static void Main(string[] args)
        {
            // Create a new ScriptRuntime for IronPython
            Console.WriteLine("Loading IronPython Runtime...");
            ScriptRuntime python = Python.CreateRuntime();

            try
            {
                // Attempt to load the python file
                Console.WriteLine("Loading Python File...");
                // Create a Dynamic Type for our Python File
                dynamic pyfile = python.UseFile("PythonFunctions.py");
                Console.WriteLine("Python File Loaded!");

                Console.WriteLine("Running Python Commands...\n");

                /**
                 * OK, now this is where the dynamic type comes in handy!
                 * We will use the dynamic type to execute our Python methods!
                 * Since the compiler cannot understand what the python methods
                 * are, the issue has to be dealt with at runtime. This is where
                 * we have to use a dynamic type.
                 */

                // Call the hello(name) function
                pyfile.hello("Urda");
                // Call the add(x, y) function
                pyfile.add(5, 17);
                // Call the multiply(x , y) function
                pyfile.multiply(5, 10);
            }
            catch (Exception err)
            {
                // Catch any errors on loading and quit.
                Console.WriteLine("Exception caught:\n " + err);
                Environment.Exit(1);
            }
            finally
            {
                Console.WriteLine("\n...Done!\n");
            }
        }
    }
}
```

When the program is run, we are greeted with this output:
<img src="http://www.peter-urda.com/wp/wp-content/uploads/2010/09/IntroIronPythonRunning.png" alt="Intro to IronPython Screenshot" title="Intro to IronPython Screenshot" width="677" height="342" class="aligncenter size-full wp-image-858" />

Again take note, that it is the **print** function from the Python file that is driving the console output in this application. All C# is doing is opening up the runtime, loading the Python file, and just calling the Python methods we defined.

Through the power of IronPython and C# dynamic types we are able to pull Python code and functions into C# for use. The dynamic type will figure out what it needs to be at runtime from the Python file. It will also locate and invoke the Python functions we call on it through the IronPython runtime. All of this can be conducted on Python code that you may already have, but have not transitioned it to the C# language. This entire project is a perfect example of using C# and Python together through the strange dynamic type in C#.
