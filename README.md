# CoreDataIncrementTestProject
Text project with CoreData, tableView &amp; button

## Objective-C iOS application

Single page with CoreData, tableView and button.

## TableView 
TableView frame is upper 2 / 3 of screen. It has 10 cells with Integers from CoreData.

## Button
Button frame is lower 1 / 2 of screen with alpha = 0,5. Button is under tableView, but not its subview. 

Button lays on the same hierarhy level as TableView.

## Task
If button is tapped in zone under tableView, tableView should receive the tap (scroll), not button.

If button is tapped not in zone under tableView, button should receive the tap and do its action.

Button action is to increment all Integers in CoreData and reload tableView.

## Author

* **Alex Kuzyaev** - [AlexKuzyaev](https://github.com/AlexKuzyaev)
