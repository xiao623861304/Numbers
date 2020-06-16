Simple introduction:(Numbers Project)

Notes: Please use real devices to test the project as much as possible.

Support :

1. iPad: Horizontal and vertical screen mode is supported. 

   iPhone: Only support for vertical screen mode.

2. Operating system: iOS 11.0+

3. Support for any screen size 

Architecture design : 

MVVM

Functional feature : 

Unique features for iPad or iPhone:

	iPad: 1. The list and details screen should be displayed side by side, each taking 50% of the available screen width. 
      	      2. "selected" state should be visible when clicking the item of MainListTableView

	iPhone: 1. The DetailView will be displayed separately by clicking the item of MainListTableView
                2. Using the "UIPageControl" + "ScrollView" to implement the scrollable function of detail view page. 
		3. When returning from the details page to the main list page, the selected cell appears in the middle of the screen. (For example Detail page show number"7", when back to the main list page, number "7" of item cell should be displayed in the middle of the screen.)


Same features for iPad and iPhone:

	1. Display an error alert when there is no network connection.
	2. Download data automatically when the network is available.
