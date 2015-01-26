//
//  ImageContentViewController.swift
//  SwiftyContainerViewController
//
//  Created by user on 12/30/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit

class ImageContentViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        self.imageView.image = UIImage(named: "holidays")

        //child will layout using the bounds of their super view. This increases the reusability of the child view controller;
        self.imageView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.widthConstraint.constant = self.preferredContentSize.width
        self.heightConstraint.constant = self.preferredContentSize.height
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /* called when a view controller will gain or lose a parent view controller */
    override func willMoveToParentViewController(parent: UIViewController?) {

    }

    /* called when a view controller has moved to its new parent view controller */
    override func didMoveToParentViewController(parent: UIViewController?) {
        
    }
}
