//
//  LearningCenterViewController.swift
//  WasteEducation
//
//  Created by ZhouYue on 20/01/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import UIKit

class LearningCenterViewController: UIViewController {
   
    // MARK: Properties
    
    @IBOutlet weak var learningCenterView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestURL = NSURL(string: Net.lcenterAddress)
        let request = NSURLRequest(URL: requestURL!)
        learningCenterView.loadRequest(request)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        if(Debug.debug_mode){
            learningCenterView.reload()
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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
