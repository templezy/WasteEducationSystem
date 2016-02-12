//
//  FPIntroViewController.swift
//  UOAWE
//
//  Created by ZhouYue on 12/02/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import UIKit

class FPIntroViewController: UIViewController {
    
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.borderWidth = 1
        startButton.layer.borderColor = UIColor.whiteColor().CGColor
        startButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        startButton.addTarget(self, action: "stateChanged:", forControlEvents: .TouchUpInside)
        startButton.addTarget(self, action: "touchIt:", forControlEvents: .TouchDown)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stateChanged(sender: UIButton!){
        UIButton.animateWithDuration(0.5, animations: {
            sender.layer.backgroundColor = UIColor.blackColor().CGColor
            sender.layer.borderColor = UIColor.blackColor().CGColor
        })
        
        let mainView = self.storyboard?.instantiateViewControllerWithIdentifier("MainController") as! UITabBarController
        mainView.selectedIndex = 0
        self.presentViewController(mainView, animated: true, completion: nil)
        
    }
    
    func touchIt(sender: UIButton!){
        UIButton.animateWithDuration(0.5, animations: {
            sender.layer.backgroundColor = UIColor.blackColor().CGColor
            sender.layer.borderColor = UIColor.blackColor().CGColor
            sender.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
