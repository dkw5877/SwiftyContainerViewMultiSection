//
//  CollectionViewController.swift
//  SwiftyContainerViewController
//
//  Created by user on 12/30/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!

    //create outlets to the constraints in IB as we will need to update these when the content size changes
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    private let cellID = "collectionCellID"

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        self.collectionView.registerNib(UINib(nibName: "CollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: cellID)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        //child will layout using the bounds of their super view. This increases the reusability of the child view controller;
        self.collectionView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.heightConstraint.constant = self.preferredContentSize.height
        self.widthConstraint.constant = self.preferredContentSize.width
//        println("viewWillAppear")
//        println("collection preferredContentSize \(preferredContentSize)")
//        println("collection frame \(self.view.frame)")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20;
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as CollectionViewCell
        cell.backgroundColor = UIColor.blueColor()
        cell.titleLabel.text = "\(indexPath.section),\(indexPath.row)"
        return cell;
    }

    /* called when a view controller will gain or lose a parent view controller */
    override func willMoveToParentViewController(parent: UIViewController?) {

    }

    /* called when a view controller has moved to its new parent view controller */
    override func didMoveToParentViewController(parent: UIViewController?) {

    }
}
