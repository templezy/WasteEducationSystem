//
//  MenuControlView.swift
//  WasteEducation
//
//  Created by ZhouYue on 8/01/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import UIKit

class MenuControlView: UIView{
    
    // MARK: Properties
    
    var resumeButton: UIButton = UIButton()
    var restartButton: UIButton = UIButton()
    var backMainButton: UIButton = UIButton()
    var closeButton: UIButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Set the tag for current view
        
        self.tag = 100
        
        //Bind the event to close and resume buttons
        
        self.closeButton.addTarget(self, action: "dismissMenuView:", forControlEvents: UIControlEvents.TouchUpInside)
        self.resumeButton.addTarget(self, action: "resumeToGameView:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        //Blur effect
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        blurEffectView.tag = 101
        
        //Add fade in animation
        
        blurEffectView.alpha = 0
        UIView.animateWithDuration(0.35, animations: {blurEffectView.alpha = 1.0})
        self.addSubview(blurEffectView)
        
        self.alpha  = 0
        UIView.animateWithDuration(0.35, animations: {self.alpha = 1.0})
        
        
        self.addCustomView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    
    // MARK: Custom view initial
    
    func addCustomView(){
        
        //Get current screen size
        
        let windowWidth = UIScreen.mainScreen().bounds.width
        let windowHeight = UIScreen.mainScreen().bounds.height
        
        let paddingLR: CGFloat = 15.0
        let buttonHeight: CGFloat = 60
        let paddingTB: CGFloat = 25.0
        
        //Set the attributes for the resume button
        
        resumeButton.frame = CGRectMake(paddingLR, 0.4 * windowHeight, windowWidth - 2 * paddingLR, buttonHeight)
        resumeButton.layer.cornerRadius = 5
        resumeButton.setTitle("Resume", forState: .Normal)
        resumeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        resumeButton.titleLabel!.font = UIFont(name: "Arial Rounded MT Bold", size: 17)
        resumeButton.backgroundColor = UIColor(red: 77.0/255.0, green: 210.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        resumeButton.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchDown)
        resumeButton.addTarget(self, action: "buttonCancel:", forControlEvents: UIControlEvents.TouchDragExit)
        self.addSubview(resumeButton)
        
        //Set the attributes for the restartButton
        
        restartButton.frame = CGRectMake(paddingLR, 0.4 * windowHeight + buttonHeight + paddingTB, windowWidth - 2 * paddingLR, buttonHeight)
        restartButton.layer.cornerRadius = 5
        restartButton.setTitle("Restart", forState: .Normal)
        restartButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        restartButton.titleLabel!.font = UIFont(name: "Arial Rounded MT Bold", size: 17)
        restartButton.backgroundColor = UIColor(red: 77.0/255.0, green: 210.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        restartButton.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchDown)
        restartButton.addTarget(self, action: "buttonCancel:", forControlEvents: UIControlEvents.TouchDragExit)
        self.addSubview(restartButton)
        
        //Set the attributes for the backMainButton
        
        backMainButton.frame = CGRectMake(paddingLR, 0.4 * windowHeight + 2 * (buttonHeight + paddingTB), windowWidth - 2 * paddingLR, buttonHeight)
        backMainButton.layer.cornerRadius = 5
        backMainButton.setTitle("Main Menu", forState: .Normal)
        backMainButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backMainButton.titleLabel!.font = UIFont(name: "Arial Rounded MT Bold", size: 17)
        backMainButton.backgroundColor = UIColor(red: 77.0/255.0, green: 210.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        backMainButton.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchDown)
        backMainButton.addTarget(self, action: "buttonCancel:", forControlEvents: UIControlEvents.TouchDragExit)
        
        self.addSubview(backMainButton)
        
        
        closeButton.frame = CGRectMake(10, 10, 20, 20)
        let closeImage = UIImage(named: "close") as UIImage?
        closeButton.setImage(closeImage, forState: .Normal)
        self.addSubview(closeButton)
        
    }
    
    
    // MARK: Button pressed effect
    
    //Event when the button tapped
    
    func buttonPressed(sender: UIButton!){
        let pressedButton: UIButton = sender
        UIButton.animateWithDuration(0.3, animations: {
            pressedButton.backgroundColor = UIColor(red: 0.0/255.0, green: 172.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        })
    }
    
    //Event when the button move out
    
    func buttonCancel(sender: UIButton!){
        let cancelButton: UIButton = sender
        UIButton.animateWithDuration(0.3, animations: {
            cancelButton.backgroundColor = UIColor(red: 77.0/255.0, green: 210.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        })
    }
    
    // MARK: Event handler
    
    func dismissMenuView(sender: UIButton!){
        
        //Dismiss blur view and menu view
        
        if let menuViewWithTag = self.viewWithTag(100){
            menuViewWithTag.alpha = 1
            UIView.animateWithDuration(0.35, animations: {menuViewWithTag.alpha = 0.0})
            menuViewWithTag.removeFromSuperview()
        }
        if let blurViewWithTag = self.viewWithTag(101){
            blurViewWithTag.alpha = 1
            UIView.animateWithDuration(0.35, animations: {blurViewWithTag.alpha = 0.0})
            blurViewWithTag.removeFromSuperview()
        }
    }
    
    
    func resumeToGameView(sender: UIButton!){
        
        //Dismiss blur view and menu view
        
        if let menuViewWithTag = self.viewWithTag(100){
            menuViewWithTag.alpha = 1
            UIView.animateWithDuration(0.35, animations: {menuViewWithTag.alpha = 0.0})
            menuViewWithTag.removeFromSuperview()
        }
        if let blurViewWithTag = self.viewWithTag(101){
            blurViewWithTag.alpha = 1
            UIView.animateWithDuration(0.35, animations: {blurViewWithTag.alpha = 0.0})
            blurViewWithTag.removeFromSuperview()
        }
        
    }
    
}

