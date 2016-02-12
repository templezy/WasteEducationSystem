//
//  LearningCenterViewController.swift
//  WasteEducation
//
//  Created by ZhouYue on 20/01/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import UIKit

class LearningCenterViewController: UIViewController, UIWebViewDelegate {
   
    // MARK: Properties
    
    @IBOutlet weak var learningCenterView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        learningCenterView.delegate = self
        let requestURL = NSURL(string: Net.lcenterAddress)
        let request = NSURLRequest(URL: requestURL!)
        learningCenterView.loadRequest(request)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if navigationType == UIWebViewNavigationType.LinkClicked {
            if (request.URL!.host! == Net.lcenterAddress){
                return true
            } else {
                UIApplication.sharedApplication().openURL(request.URL!)
                return false
            }
        }
        return true
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
