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
        
//        self.navigationController?.navigationBar.barStyle = .Black
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 153.0/255, blue: 76.0/255, alpha: 1)
//        self.navigationController?.navigationBar.tintColor = Theme.navbarItemColor
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Theme.navbarItemColor, NSFontAttributeName:UIFont(name: GlobalConstants.globalFont, size: 20)!]
        
        let requestURL = NSURL(string: Net.feedbackAddress)
        let request = NSURLRequest(URL: requestURL!)
        surveyPageView.loadRequest(request)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if(Debug.debug_mode){
            surveyPageView.reload()
        }
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
