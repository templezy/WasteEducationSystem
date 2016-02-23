//
//  GameListCollectionViewController.swift
//  WasteEducation
//
//  Created by ZhouYue on 9/01/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import UIKit


private let reuseIdentifier = "Cell"

class GameListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    // MARK: Properties
    
    let gameTypes = ["option_question","yes_no","which_bin"]
    let gameTitle = ["RECYCLING QUIZ","TRUE or FALSE", "SORT YOUR WASTE"]
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var colView: UICollectionView!
    
    var colViewContainer: UIView!
    
    var gamePageTitle: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenSize = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        gamePageTitle = UITextView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight/8))
        gamePageTitle.text = "How much do you know about waste and recycling?"
        gamePageTitle.backgroundColor = UIColor(red: 113/255, green: 203/255, blue: 94/255, alpha: 1)
        gamePageTitle.textColor = UIColor.whiteColor()
        gamePageTitle.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        gamePageTitle.userInteractionEnabled = false
        gamePageTitle.textAlignment = .Center
        gamePageTitle.font = UIFont(name: Theme.globalFont, size: 17)
        colViewContainer = UIView(frame: CGRect(x: 0, y: screenHeight/6, width: screenWidth, height: screenHeight/7*8))
        
        self.view.addSubview(gamePageTitle)
        
        
        
        //Override the default layout
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0.5, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: screenWidth / 2 - 0.5, height: screenWidth / 2 - 1)
        layout.minimumInteritemSpacing = 0.5
        layout.minimumLineSpacing = 1
        colView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight*7/8), collectionViewLayout: layout)
        colView.dataSource = self
        colView.delegate = self
        colView.registerClass(SingleGameCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        colView.backgroundColor = UIColor.blackColor()
        
        colView.contentInset = UIEdgeInsets(top: screenHeight/8, left: 0, bottom: 0, right: 0)
        
        self.colViewContainer.addSubview(colView)
        
        self.view.addSubview(colViewContainer)
        
        self.collectionView = colView
        
        
        self.view.bringSubviewToFront(gamePageTitle)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.registerClass(SingleGameCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return gameTypes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! SingleGameCollectionViewCell
        // Configure the cell
        cell.textLabel.text = gameTitle[indexPath.item]
        cell.imageButton.setImage(UIImage(named: gameTypes[indexPath.item]), forState: .Normal)
        cell.imageButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        cell.imageButton.tag = indexPath.item
        return cell
    }
    
    // MARK: Event handler
    
    //Jump to the surveyview 
    
    func buttonPressed(sender: UIButton!){
        
        let pressedLocation = sender.tag
        if(pressedLocation == 0){
            let surveyView = self.storyboard?.instantiateViewControllerWithIdentifier("SurveyViewController") as! SurveyViewController
            self.presentViewController(surveyView, animated: true, completion: nil)
        }else if(pressedLocation == 1){
            let yesnoView = self.storyboard?.instantiateViewControllerWithIdentifier("YesNoGameController") as! YesNoViewController
            self.presentViewController(yesnoView, animated: true, completion: nil)
        }else if(pressedLocation == 2){
            let whichBinView = self.storyboard?.instantiateViewControllerWithIdentifier("WhichBinGameController") as! WhichBinViewController
            self.presentViewController(whichBinView, animated: true, completion: nil)
        }
        
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
