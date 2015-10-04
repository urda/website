---
title: Inking in Silverlight
author: Peter Urda
layout: post
redirect_from: /2010/09/inking-in-silverlight/
categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
  - Silverlight
  - XAML
---
Users with touch screens, stylus-enabled screens, or USB stylus pads appreciate the ability to write and markup documents and files. Plenty of modern applications today support inking natively (Example: OneNote 2010, one application I use in conjunction with my Lenovo tablet as a digital notebook on most days of the week) for a variety of purposes and actions. You may not know it already, but Silverlight has all the required libraries in place to utilizing inking on screen. So today I've put together a little Silverlight web app to demonstrate.

The first thing we need to do is define our XAML that will build the visual layout of our web application. In this case we will just call this our MainPage.xaml:

```xml
<UserControl x:Class="SilverlightInk.MainPage"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
>
    <Grid x:Name="MainLayout" Background="Gray">
        <Grid.RowDefinitions>
            <RowDefinition Height="*" />
            <RowDefinition Height="*" />
        </Grid.RowDefinitions>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="100" />
            <ColumnDefinition Width="*" />
        </Grid.ColumnDefinitions>

        <Grid x:Name="OptionPanel" Background="Transparent" Grid.Column="0" Grid.Row="0">
            <Grid.RowDefinitions>
                <RowDefinition Height="*" />
                <RowDefinition Height="*" />
            </Grid.RowDefinitions>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*" />
                <ColumnDefinition Width="*" />
            </Grid.ColumnDefinitions>

            <Button x:Name="InkButton" Content="Ink" Grid.Column="0" Grid.Row="0"
                Click="InkButtonClick"
            />
            <Button x:Name="EraseButton" Content="Eraser" Grid.Column="1"
                Grid.Row="0" Click="EraseButtonClick"
            />
        </Grid>

        <Border Background="White" CornerRadius="20" x:Name="BorderInk"
                Grid.Column="1" Grid.Row="0" Grid.RowSpan="2"
        >
            <InkPresenter x:Name="InkPad" Background="Transparent"
                            Cursor="Stylus"
                            MouseLeftButtonDown="InkPadMouseLeftButtonDown"
                            MouseLeftButtonUp="InkPadMouseLeftButtonUp"
                            MouseMove="InkPadMouseMove"
            />
        </Border>
    </Grid>
</UserControl>
```

The flow of our XAML document, in a nutshell, is as follows:

  * Define top-level grid 'MainLayout', make it a 2&#215;2, and set just the left column to a width of 100 (others will be auto)
  * Define a sub-grid in the top left cell, this will be used for storing our buttons
  * Define our buttons, create click actions
  * Place a border object in the right column
  * Place an InkPresenter object inside the border, with required action handlers (MouseLeftButtonDown/Up, MouseMove)

Once our XAML is squared away, we can write the actual code our event handlers will use. So we will go ahead and jump to MainPage.xaml.cs to create the logic behind the application. Let's go ahead and look at the source code for that.

```csharp
using System.Windows;
using System.Windows.Controls;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;

namespace SilverlightInk
{
    public partial class MainPage : UserControl
    {
        private Stroke _stroke = null;
        private bool _StylusUsed = false;
        private StylusPointCollection _EraserPoints;
        private InkMode _InkMode = InkMode.Draw;

        public enum InkMode { Draw, Erase }

        public MainPage()
        {
            InitializeComponent();
        }

        private void InkPadMouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            InkPad.CaptureMouse();

            if (e.StylusDevice.Inverted)
            {
                _InkMode = InkMode.Erase;
                InkPad.Cursor = Cursors.Eraser;
                if (e.StylusDevice.DeviceType == TabletDeviceType.Stylus)
                    _StylusUsed = true;
            }

            if (_InkMode == InkMode.Erase)
            {
                _EraserPoints = new StylusPointCollection();
                _EraserPoints = e.StylusDevice.GetStylusPoints(InkPad);
            }

            else if (_InkMode == InkMode.Draw)
            {
                _stroke = new Stroke();
                _stroke.DrawingAttributes.Color = Colors.Black;
                _stroke.StylusPoints.Add(e.StylusDevice.GetStylusPoints(InkPad));
                InkPad.Strokes.Add(_stroke);
            }
        }

        private void InkPadMouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            _stroke = null;
            _EraserPoints = null;
            if (_StylusUsed)
            {
                _InkMode = InkMode.Draw;
                _StylusUsed = false;
                InkPad.Cursor = Cursors.Stylus;
            }
            InkPad.ReleaseMouseCapture();
        }

        private void InkPadMouseMove(object sender, MouseEventArgs e)
        {
            if (_InkMode == InkMode.Draw && _stroke != null)
            {
                _stroke.StylusPoints.Add(e.StylusDevice.GetStylusPoints(InkPad));
		    }

            if (_InkMode == InkMode.Erase && _EraserPoints != null)
            {
                _EraserPoints.Add(e.StylusDevice.GetStylusPoints(InkPad));
                StrokeCollection hits = InkPad.Strokes.HitTest(_EraserPoints);
		        for (int i = 0; i < hits.Count; i++)
		        {
                    InkPad.Strokes.Remove(hits[i]);
		        }
		    }
        }

        private void EraseButtonClick(object sender, RoutedEventArgs e)
        {
            InkPad.Cursor = Cursors.Eraser;
            _InkMode = InkMode.Erase;
        }

        private void InkButtonClick(object sender, RoutedEventArgs e)
        {
            InkPad.Cursor = Cursors.Stylus;
            _InkMode = InkMode.Draw;
        }
    }
}
```

We have four variables used throughout the application:

  * **_stroke** - Variable to hold a complete ink stroke
  * **_StylusUsed** - A flag to determine if a stylus device was used, instead of a mouse.
  * **_EraserPoints** - A collection of points to compare against already inked strokes for erasing purposes
  * **_InkMode** - Contains constants to flip between ink and erasing modes. The initial setting is drawing when the application starts

Let's examine the major handlers closely. First we will take a look at our buttons for the application:

```csharp
private void EraseButtonClick(object sender, RoutedEventArgs e)
{
	InkPad.Cursor = Cursors.Eraser;
	_InkMode = InkMode.Erase;
}

private void InkButtonClick(object sender, RoutedEventArgs e)
{
	InkPad.Cursor = Cursors.Stylus;
	_InkMode = InkMode.Draw;
}
```

When the respective button is pressed it defines the drawing mode as inking or erasing and changes the cursor icon to reflect the status.

Now we need to look at what exactly happens when you press the left mouse button inside the InkPad.

```csharp
private void InkPadMouseLeftButtonDown(object sender, MouseButtonEventArgs e)
{
	InkPad.CaptureMouse();

	if (e.StylusDevice.Inverted)
	{
		_InkMode = InkMode.Erase;
		InkPad.Cursor = Cursors.Eraser;
		if (e.StylusDevice.DeviceType == TabletDeviceType.Stylus)
			_StylusUsed = true;
	}

	if (_InkMode == InkMode.Erase)
	{
		_EraserPoints = new StylusPointCollection();
		_EraserPoints = e.StylusDevice.GetStylusPoints(InkPad);
	}

	else if (_InkMode == InkMode.Draw)
	{
		_stroke = new Stroke();
		_stroke.DrawingAttributes.Color = Colors.Black;
		_stroke.StylusPoints.Add(e.StylusDevice.GetStylusPoints(InkPad));
		InkPad.Strokes.Add(_stroke);
	}
}
```

We first make sure to capture the input of the mouse. After we have done this we need to see if a stylus was used. The easiest way to do that is to see if it was inverted. An inverted stylus should act like an eraser (much like flipping to the other side of a pencil). A normal mouse input will never have an inverted value. However, if we detect that a stylus has been flipped, we can assume the user wants to erase a stroke or strokes from the screen. Once that statement has been evaluated to true we just flip the mode to erase, update the cursor, and flip a flag that lets the program know we used a stylus.

If we hadn't used a stylus, we simply check to see what mode we are in for inking based on the last button pressed by the user. If we are erasing we collect the points for use later in a variable. Otherwise, we create a new Stroke() object and add the ink on screen.

While the user is moving around on screen, we have another event handler that is running throughout mouse movement.

```csharp
private void InkPadMouseMove(object sender, MouseEventArgs e)
{
	if (_InkMode == InkMode.Draw && _stroke != null)
	{
		_stroke.StylusPoints.Add(e.StylusDevice.GetStylusPoints(InkPad));
	}

	if (_InkMode == InkMode.Erase && _EraserPoints != null)
	{
		_EraserPoints.Add(e.StylusDevice.GetStylusPoints(InkPad));
		StrokeCollection hits = InkPad.Strokes.HitTest(_EraserPoints);
		for (int i = 0; i < hits.Count; i++)
		{
			InkPad.Strokes.Remove(hits[i]);
		}
	}
}
```

The handler checks to see if we are drawing and that a stroke exists first. If that is the case we continue to pile on points that create a single line. If we are in erase mode, the handler detects if a given point intersects an already defined stroke. If that is the case, it will remove the entire stroke from the InkPad.

Now after the user has swiped their mouse or stylus around we need to conduct some final actions. These actions are triggered when the left mouse button is released.

```csharp
private void InkPadMouseLeftButtonUp(object sender, MouseButtonEventArgs e)
{
	_stroke = null;
	_EraserPoints = null;
	if (_StylusUsed)
	{
		_InkMode = InkMode.Draw;
		_StylusUsed = false;
                InkPad.Cursor = Cursors.Stylus;
	}
	InkPad.ReleaseMouseCapture();
}
```

We reset a few variables to prepare for the next stroke the user may make. We check to see if a stylus was used, and if that is the case we go ahead and reset the mode back to draw and disable the flag. We do this because we do not want the user to erase a stroke, and then expect the application to ink when the correct end of the stylus is applied again. This works because we check for the eraser end of the stylus when preparing to ink. We finally release capture of the mouse from the application.

Our final product will look like this:

<img src="http://www.peter-urda.com/wp/wp-content/uploads/2010/09/RunningApplication.png" alt="Silverlight Ink app running. A smilely face, the word &#039;Urda&#039;, and www.peter-urda.com inked on it" title="Silverlight Inking" width="597" height="496" class="aligncenter size-full wp-image-682" />

So there you have it! This project could obviously be extended to include a color picker, the ability to download a sketch, shapes, and just about anything else you would want to add to an inking application. If you are interested in learning about inking in silverlight, you may want to read up on <a href="http://msdn.microsoft.com/en-us/library/cc903958%28VS.95%29.aspx" class="external external_icon" target="_blank">InkPresenter</a>.
