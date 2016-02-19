//
//  SecureRESTViewController.swift
//  UOAWE
//
//  Created by ZhouYue on 19/02/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import UIKit

class SecureRESTViewController: UIViewController, NetProtocol{
    
    
    var userToken: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataFetching()
        
        print(userToken)
        
        dataFetching2()
        
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
    
    
    
    func dataFetching2() {
       getDataFromServer2(self.resultHandler2)
    }
    
    
    func getDataFromServer2(compleionHandler: ((AnyObject!) -> Void)?) {
        
        let semaphore = dispatch_semaphore_create(0)
        let request = NSMutableURLRequest(URL: NSURL(string: Net.trueFalseQuizAddress)!)
        request.HTTPMethod = "GET"
        request.setValue("Token " + userToken, forHTTPHeaderField: "Authorization")
        
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            
            (data, response, error) in print(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
            
            if (data != nil){
                let test = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                let jsonData: NSData = test.dataUsingEncoding(NSUTF8StringEncoding)!
                
                do {
                    let json: AnyObject? = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
                    compleionHandler?(json)
                    
                    //Solve the problem that first question could not be loaded
                    dispatch_async(dispatch_get_main_queue()) {
//                        self.updateQuestion()
                    }
                    
                    if(Debug.debug_mode){
//                        print("####"+String(self.questionData.count))
                    }
                    
                    //Enable the data could assign to the global variable
                    
                    dispatch_semaphore_signal(semaphore)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            
            
        }
        
        task.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)
    }
    
    
    func resultHandler2(jsonResult: AnyObject!) {
        if let list = jsonResult as? NSArray {
            for (var i = 0; i < list.count; i++) {
                if let item = list[i] as? NSDictionary {
                    
                    let question_temp: TrueFalseQuestion = TrueFalseQuestion()
                    
                    question_temp.question_text = item["question_text"] as! String
                    question_temp.question_desc = item["question_desc"] as! String
                    question_temp.question_reason = item["question_reason"] as! String
                    question_temp.question_choice = item["question_choice"] as! String
                    question_temp.question_score = item["question_score"] as! Int
                    question_temp.question_total_times = item["question_total_times"] as! Int
                    
                }
            }
        }
    }
    
    
    func dataFetching() {
       getDataFromServer(self.resultHandler)
    }
    
    func getDataFromServer(compleionHandler: ((AnyObject!) -> Void)?) {
        
        let semaphore = dispatch_semaphore_create(0)
        let request = NSMutableURLRequest(URL: NSURL(string: "http://0.0.0.0:8000/api-token-auth/")!)
        request.HTTPMethod = "POST"
        let postString = "username=zhouyue&password=199271zy"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            
            (data, response, error) in print(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
            
            if (data != nil){
                let test = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                let jsonData: NSData = test.dataUsingEncoding(NSUTF8StringEncoding)!
                
                do {
                    let json: AnyObject? = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
                    compleionHandler?(json)
                    
                    //Solve the problem that first question could not be loaded
                    dispatch_async(dispatch_get_main_queue()) {
//                        self.updateQuestion()
                        
                        let testData1 = json as? NSDictionary
                        
                        let testData2 = testData1!["token"] as! String
                        
                        
                        self.self.userToken = testData2
                        
                        self.dataFetching2()
                        
                    }
                    
                    //Enable the data could assign to the global variable
                    
                    dispatch_semaphore_signal(semaphore)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            
            
        }
        
        task.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)
    }
    
    func resultHandler(jsonResult: AnyObject!) {
        
        let testData1 = jsonResult as? NSDictionary
        
        let testData2 = testData1!["token"] as! String
        
        
        userToken = testData2
        
        print(userToken)
        
        
//        
//        if let list = jsonResult as? NSArray {
//            for (var i = 0; i < list.count; i++) {
//                if let item = list[i] as? NSDictionary {
//                    
//                    let testdata = item["token"] as! String
//                    
//                    userToken = testdata
//                    
//                    print(testdata)
//                }
//            }
//        }
    }

}
