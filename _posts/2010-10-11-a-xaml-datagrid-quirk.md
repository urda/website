---
title: A XAML DataGrid Quirk
author: Peter Urda
layout: post
redirect_from: /2010/10/a-xaml-datagrid-quirk/
categories:
  - Mercer Daily Reports
tags:
  - Co-Op
  - XAML
---
Everyone knows how amazing XAML is to create flexible and beautiful GUI's for various applications. XAML provides a wonderful interface to building a simple grid of data (much like an Excel spreadsheet) with the DataGrid namespace. I was working on a DataGrid object in one of my projects today, and chose to re-work the XAML into a better form for easier reading and code re-use. I however stumbled into a strange characteristic of the Datagrid, and I wanted to share with you that issue and the fix I came up with.

So here is the XAML I came up with to display a simple grid in my application:

```xml
<DataGrid x:Name="SomeDataGrid" ItemsSource="{Binding}"
                DataContext="{Binding}" AutoGenerateColumns="False"
                CanUserAddRows="False" CanUserDeleteRows="False"
                HeadersVisibility="Column"
                AlternatingRowBackground="LightGray" >
    <data:DataGrid.Columns>
		<data:DataGridCheckBoxColumn
            Header="Include?"
            Width="55"
            CanUserResize="False"
            Binding="{Binding Path=IsIncluded, Mode=TwoWay}" />
        <data:DataGridTextColumn
            Header="ID"
            MinWidth="22"
            Width="SizeToCells"
            Binding="{Binding Path=SystemNumber, Mode=OneWay}" />
        <data:DataGridTextColumn
            Header="Question Text"
            MinWidth="85"
            Width="SizeToCells"
            Binding="{Binding Path=Text, Mode=OneWay}" />
    </data:DataGrid.Columns>
</data:DataGrid>
```

The issue that arose was centered around the checkbox column. The new checkbox column required the user to first make a row active (by clicking on it) to then have to click a second time to enable or disable the desired checkbox. Obviously this is not the desired action, since a user expects to be able to just check a box **without** having to select the row first.

So how do we correct the issue. Well instead of just using a plain *DataGridCheckBoxColumn* we will declare a template column instead. We can then define within this template the actions and styling of this column. Below is my updated XAML section for the first column:

```xml
<!-- XAML Omitted -->

<data:DataGridTemplateColumn
	Header="Include?"
	Width="55"
	CanUserResize="False">
	<data:DataGridTemplateColumn.CellTemplate>
		<DataTemplate>
			<Grid>
				<CheckBox
					IsChecked="{Binding Path=IsIncluded, Mode=TwoWay}"
					ClickMode="Press"
					HorizontalAlignment="Center"
					VerticalAlignment="Center" />
			</Grid>
		</DataTemplate>
	</data:DataGridTemplateColumn.CellTemplate>
</data:DataGridTemplateColumn>

<!-- XAML Omitted -->
```

The *ClickMode="Press"* will allow the box to be checked when the mouse is hovered over it and a click event is caught. This allows for our desired action, while still keeping clean and organized XAML!

Hopefully this may come in handy if you are pulling your hair out over DataGrid columns. I know I'll end up referring back to this note sometime in the future.
