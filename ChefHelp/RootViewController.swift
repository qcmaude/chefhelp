//
//  RootViewController.swift
//  PageBased
//
//  Created by Maude on 10/20/14.
//  Copyright (c) 2014 Maude. All rights reserved.
//

import UIKit

class RootViewController: UIPageViewController, UIPageViewControllerDelegate, NanogestGestureDelegate, NanogestErrorDelegate {
    var pageViewController: UIPageViewController?
    var ngest: Nanogest

    required init(coder aDecoder: NSCoder) {
        self.ngest = Nanogest()
        super.init(coder: aDecoder)
        self.ngest.gestureDelegate = self
        self.ngest.errorDelegate = self
        self.ngest.start()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Configure the page view controller and add it as a child view controller.
        self.pageViewController = UIPageViewController(transitionStyle: .PageCurl, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController!.delegate = self
        
        let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        let viewControllers: NSArray = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: {done in })
        
        self.pageViewController!.dataSource = self.modelController
        
        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)
        
        // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
//        var pageViewRect = self.view.bounds
//        pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0)
//        self.pageViewController!.view.frame = pageViewRect
        self.pageViewController!.didMoveToParentViewController(self)
        
        print(self.ngest.description)
        print(self.ngest.debugDescription)

        //        print("Nanogest should be initialized")
        //        print(self.ngest.description)
        
        // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
        self.view.gestureRecognizers = self.pageViewController!.gestureRecognizers
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var modelController: ModelController {
        // Return the model controller object, creating it if necessary.
        // In more complex implementations, the model controller may be passed to the view controller.
        if _modelController == nil {
            _modelController = ModelController()
            }
            return _modelController!
    }
    
    var _modelController: ModelController? = nil
    
    func onGesture(gesture: NanogestKind, timestamp: NSTimeInterval) {

        println("Detected a gesture:");
        
        switch (gesture.value) {
            case NANOGEST_SWIPE_LEFT.value:
                println("Left");
                flipPageNext()
                break;
            case NANOGEST_SWIPE_RIGHT.value:
                println("Right");
                flipPagePrev()
                break;
            case NANOGEST_SWIPE_UP.value:
                println("Up");
                break;
            case NANOGEST_SWIPE_DOWN.value:
                println("Down");
                break;
            case NANOGEST_HELLO.value:
                println("Hello");
                break;
            default:
                // Ignore other gestures.
                break;
        }
    }
    
    
    func flipPageNext() {
        //current page
        print(self.viewControllers.endIndex)
        let currentViewController = self.pageViewController!.viewControllers[0] as UIViewController
        let nextViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerAfterViewController: currentViewController)
        if(nextViewController == nil) {
            return;
        }
        let viewControllers = [nextViewController!]
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })
    }
    
    func flipPagePrev() {
        //current page
        print(self.viewControllers.endIndex)
        let currentViewController = self.pageViewController!.viewControllers[0] as UIViewController
        let nextViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerBeforeViewController: currentViewController)
        if(nextViewController == nil) {
            return;
        }
        let viewControllers = [nextViewController!]
        self.pageViewController!.setViewControllers(viewControllers, direction: .Reverse, animated: true, completion: {done in })
    }
    
    // MARK: - UIPageViewController delegate methods
    
    func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        if (orientation == .Portrait) || (orientation == .PortraitUpsideDown) {
            // In portrait orientation: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
            let currentViewController = self.pageViewController!.viewControllers[0] as UIViewController
            let viewControllers: NSArray = [currentViewController]
            self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })
            
            self.pageViewController!.doubleSided = false
            return .Min
        }
        
        // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
        let currentViewController = self.pageViewController!.viewControllers[0] as DataViewController
        var viewControllers: NSArray
        
        let indexOfCurrentViewController = self.modelController.indexOfViewController(currentViewController)
        if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
            let nextViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerAfterViewController: currentViewController)
            viewControllers = [currentViewController, nextViewController!]
        } else {
            let previousViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerBeforeViewController: currentViewController)
            viewControllers = [previousViewController!, currentViewController]
        }
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })
        
        return .Mid
    }
    
    func onError(code: NanogestError, codeName: String!, message: String!) {
        //do nothing
    }
    
    
}

