//
//  ViewController.swift
//  SwiftyContainerViewMultiSection
//
//  Created by user on 1/3/15.
//  Copyright (c) 2015 someCompanyNameHere. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //these views are used to size the content views for specific location
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomLeftView: UIView!
    @IBOutlet weak var bottomRightView: UIView!

    //store a reference to the view controller in each location
    private var topViewController = UIViewController()
    private var bottomLeftViewController = UIViewController()
    private var bottomRightViewController = UIViewController()
    private var content = [UIViewController]()

    //timer for the rotation/animations
    private var timer = NSTimer()

    override func viewDidLoad() {
        super.viewDidLoad()

        //we'll set the parents color so we can see the parent as we run the app
        self.view.backgroundColor = UIColor.greenColor()

        /* create some view controllers to use in the example, this is to simulate the content provided by a client */
        let imageVC = ImageContentViewController(nibName: "ImageContentViewController", bundle: nil)
        let tableVC = TableViewController(nibName: "TableViewController", bundle: nil)
        let collectionVC = CollectionViewController(nibName: "CollectionViewController", bundle: nil)
        self.content = [imageVC,tableVC,collectionVC];

        //set the inital location of the view controllers
        self.displayTopContentViewController(collectionVC)
        self.displayBottomLeftContentViewController(tableVC)
        self.displayBottomRightContentViewController(imageVC)

        //create a timer to simulate changes by a client
        self.timer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "rotateChildViewsWithAnimation", userInfo: nil, repeats: true)

        //swap the location of child views in clockwise order w/o animation
//        self.timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "rotateChildViewsWithoutAnimation", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //Basic steps in adding child view controllers
    //step 1 - add the child view controller to the container's list of view controllers
    //step 2 - add the child view controller's view to the containers view
    //step 3 - tell the child view controller that it will now have a parent

    /* API method to add a child view controller at a given location. The frame will be used as the location in the parent view controller as well as the preferred content size of the child view controller */
    func displayContentViewController(content:UIViewController, frame:CGRect){

        //first add the new content view controller as a child
        self.addChildViewController(content)

        //set the frame for the new view controller, parents always size children
        content.view.frame = frame
        content.preferredContentSize = frame.size

        //add the contents view to the parent view hierarcy
        self.view.addSubview(content.view)

        //notify child that it now has a parent view
        content.didMoveToParentViewController(self)
        
    }

    //API method to add a child view controller in the top screen location
    func displayTopContentViewController(content:UIViewController){

        //first add the new content view controller as a child, this calls withMoveToParentViewController automatically
        self.addChildViewController(content)

        //set the frame for the new view controller, parents always sizes children
        content.view.frame = self.topView.frame
        content.preferredContentSize = self.topView.frame.size

        //add the contents view to the parent view hierarcy
        self.view.addSubview(content.view)

        //store reference to detail view controller
        self.topViewController = content

        //notify child that it now has a parent view
        content.didMoveToParentViewController(self)

    }

    //API method to add a child view controller in the bottom left corner
    func displayBottomLeftContentViewController(content:UIViewController){

        //first add the new content view controller as a child
        self.addChildViewController(content)

        //set the frame for the new view controller, parents always size children
        content.view.frame = self.bottomLeftView.frame
        content.preferredContentSize = self.bottomLeftView.frame.size

        //add the contents view to the parent view hierarcy
        self.view.addSubview(content.view)

        //store reference to detail view controller
        self.bottomLeftViewController = content

        //notify child that it now has a parent view
        content.didMoveToParentViewController(self)

    }

    //API method to add a child view controller in the bottom right corner
    func displayBottomRightContentViewController(content:UIViewController){

        //first add the new content view controller as a child
        self.addChildViewController(content)

        //set the frame for the new view controller, parents always size children
        content.view.frame = self.bottomRightView.frame
        content.preferredContentSize = self.bottomRightView.frame.size

        //add the contents view to the parent view hierarcy
        self.view.addSubview(content.view)

        //store reference to detail view controller
        self.bottomRightViewController = content
        
        //notify child that it now has a parent view
        content.didMoveToParentViewController(self)
        
    }

    //Basic steps in removing child view controllers
    //step 1 - tell the child view controller it will no longer have a parent
    //step 2 - remove the child view from the containers view hierarchy
    //step 3 - tell the child view controller it no longer has a parent

    //API method to remove a child view controller from parent
    private func hideContentViewController(content:UIViewController){

        //notify view controller it will no longer have a parent
        content.willMoveToParentViewController(nil)

        //remove the view from the parents hierarchy
        content.view.removeFromSuperview()

        //remove the view controller from the parent's list of children
        content.removeFromParentViewController()
    }

    /* simple method move child view controllers location in counter-clockwise order around the screen */
    func rotateChildViewsWithoutAnimation(){
        /* store the current location of the controllers*/
        let top = self.topViewController
        let bottomLeft = self.bottomLeftViewController
        let bottomRight = self.bottomRightViewController

        //move the top view controller to the bottom left corner
        self.hideContentViewController(top)
        self.displayContentViewController(top, frame: self.bottomLeftView.frame)
        self.bottomLeftViewController = top;

        //move the bottom left view to the bottom right corner
        self.hideContentViewController(bottomLeft)
        self.displayContentViewController(bottomLeft, frame: self.bottomRightView.frame)
        self.bottomRightViewController = bottomLeft

        //move the bottom right view to the top spot
        self.hideContentViewController(bottomRight)
        self.displayContentViewController(bottomRight, frame: self.topView.frame)
        self.topViewController = bottomRight
    }


    /* This method initates the swapping of child view controllers from the top to bottom (left), and then from the top
        to the bottom (right) */
     func rotateChildViewsWithAnimation() {

        self.swapTopViewControllerToBottomLeftController(self.bottomLeftViewController, newViewController: self.topViewController, startFrame:self.topView.frame,endFrame:self.bottomLeftView.frame)

        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
            self.swapTopViewControllerToBottomRightController(self.bottomRightViewController, newViewController: self.topViewController, startFrame: self.topView.frame, endFrame: self.bottomRightView.frame)
        }
    }


    /* The next two methods are used to swap specifc view controllers from/to specifced locations. In order to use the animation, both view controllers need to have the same parent. This means that we cannot remove (hide) the view controllers until after the animation completes. We use specifc display methods for each location to handle the details after the move, such as the final location (top, left or right), setting the content size and notifying the parent 
        
        @note: We remove the view controllers as children and then add them back again using locaiton specific methods. This allows us to track a view controllers final location and to update the childs preferred content size in a sinle place when the move occurs. We could just have manipulate the views in the parents view hierarchy, and notify the child that their position (frame and size) has changed in order for the child to layout their subviews again
    
    */

    /* method to swap top and bottom left view controllers with animation */
    private func swapTopViewControllerToBottomLeftController(oldViewController:UIViewController, newViewController:UIViewController, startFrame:CGRect, endFrame:CGRect){

        /* in order to use the transitionFromViewController method, both view controllers must have the same parent */
        self.transitionFromViewController(oldViewController, toViewController: newViewController, duration: 0.75, options:UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in

            //new view will take the place of the old view
            newViewController.view.frame = endFrame
            oldViewController.view.frame = startFrame

            newViewController.preferredContentSize = self.bottomLeftView.frame.size
            oldViewController.preferredContentSize = self.topView.frame.size

            }) { (Bool) -> Void in

                /* remove view controllers from current locations and the parent view. We remove the old view controllers as they will be added again as children in the final step. */
                self.hideContentViewController(oldViewController)
                self.hideContentViewController(newViewController)

                /* add view controllers to new locations */
                self.displayTopContentViewController(oldViewController)
                self.displayBottomLeftContentViewController(newViewController)
        }
    }

    /* method to swap top and bottom right view controllers with animation */
    private func swapTopViewControllerToBottomRightController(oldViewController:UIViewController, newViewController:UIViewController, startFrame:CGRect, endFrame:CGRect){

        /* in order to use the transitionFromViewController method, both view controllers must have the same parent */
        self.transitionFromViewController(oldViewController, toViewController: newViewController, duration: 0.75, options:UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in

            //new view will take the place of the old view
            newViewController.view.frame = endFrame
            oldViewController.view.frame = startFrame

            }) { (Bool) -> Void in

                /* remove view controllers from current locations, and the parent view. This is not strictly necessary in this example as all view controllers are stored in the parent object, we could just manipulate the views */
                self.hideContentViewController(oldViewController)
                self.hideContentViewController(newViewController)

                /* add view controllers to new locations */
                self.displayTopContentViewController(oldViewController)
                self.displayBottomRightContentViewController(newViewController)
        }
    }



}

