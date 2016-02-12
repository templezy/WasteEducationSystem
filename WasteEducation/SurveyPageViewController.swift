//
//  SurveyPageViewController.swift
//  UOAWE
//
//  Created by ZhouYue on 27/01/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import UIKit

class SurveyPageViewController: UIViewController {

    @IBOutlet weak var surveyPageView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestURL = NSURL(string: Net.feedbackAddress)
        let request = NSURLRequest(URL: requestURL!)
        surveyPageView.loadRequest(request)
        
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
