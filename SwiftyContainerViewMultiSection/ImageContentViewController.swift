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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        imageView.image = UIImage(named: "holidays")

        //child will layout using the bounds of their super view. This increases the reusability of the child view controller;
        imageView.autoresizingMask =  [.flexibleWidth, .flexibleHeight]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /* called when a view controller will gain or lose a parent view controller */
    override func willMove(toParentViewController parent: UIViewController?) {

    }

    /* called when a view controller has moved to its new parent view controller */
    override func didMove(toParentViewController parent: UIViewController?) {
        
    }
}
