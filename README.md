RestorePresentedIssue
=====================

I created this project to isolate an issue I am having with state restoration and a presented view controller.

I have root view controller that has a button that will present another view controller. Everything is done using storyboards.

If state is saved when user was in the modal view controller. Next time app is launched, it will first display snapshot (of modal view controller) later it will display (very shortly) root view controller and then it will display modal view controller.

If you can't see it, please, add a break point to [ViewController viewDidAppear] and you will see root view controller's view.

What I found is that ViewController.presented is set after [AppDelegate application:didFinishLaunchingWithOptions:]

My understanding was that any restorating was perform before [AppDelegate application:didFinishLaunchingWithOptions:]

I found this unanswered question in stackoverflow
http://stackoverflow.com/questions/21878076/rootview-controller-are-shown-shorty-when-state-restorating