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

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.delegate = self
        tableView.dataSource  = self

        //child will layout using the bounds of their super view. This increases the reusability of the child view controller;
        self.tableView.autoresizingMask =  [.flexibleWidth, .flexibleHeight]
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cellID")
        cell.textLabel?.text = "section:\(indexPath.section)  row:\(indexPath.row)"
        cell.textLabel?.layer.backgroundColor = UIColor(red: 1.0, green: 204/255, blue: 102/255, alpha: 1.0).cgColor
        cell.contentView.backgroundColor = .blue
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /* called when a view controller will gain or lose a parent view controller */
    override func willMove(toParentViewController parent: UIViewController?) {

    }

    /* called when a view controller has moved to its new parent view controller */
    override func didMove(toParentViewController parent: UIViewController?) {
        
    }

}
