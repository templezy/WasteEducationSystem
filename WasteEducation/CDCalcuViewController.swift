//
//  CDCalcuViewController.swift
//  UOAWE
//
//  Created by ZhouYue on 27/01/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import UIKit

class CDCalcuViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var calcuView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let requestURL = NSURL(string: Net.cdcalcuAddress)
        let request = NSURLRequest(URL: requestURL!)
        calcuView.loadRequest(request)
        
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
