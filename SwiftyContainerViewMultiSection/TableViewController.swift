//
//  TableViewController.swift
//  SwiftyContainerViewController
//
//  Created by user on 12/30/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

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

        let window =  UIApplication.sharedApplication().delegate?.window??

        //self.tableView = UITableView(frame: CGRectMake(0, 0, 600, 600), style: UITableViewStyle.Plain)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        self.tableView.delegate = self
        self.tableView.dataSource  = self

        //child will layout using the bounds of their super view. This increases the reusability of the child view controller;
        self.tableView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.widthConstraint.constant = self.preferredContentSize.width
        self.heightConstraint.constant = self.preferredContentSize.height
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cellID")
        cell.textLabel?.text = "section:\(indexPath.section)  row:\(indexPath.row)"
        return cell
    }

    /* called when a view controller will gain or lose a parent view controller */
    override func willMoveToParentViewController(parent: UIViewController?) {

    }

    /* called when a view controller has moved to its new parent view controller */
    override func didMoveToParentViewController(parent: UIViewController?) {
        
    }

}
