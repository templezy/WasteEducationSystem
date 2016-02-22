//
//  BrainStormViewController.swift
//  UOAWE
//
//  Created by ZhouYue on 25/01/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import UIKit

class BrainStormViewController: UIViewController, NetProtocol {
    
    // MARK: Properties
    
    var wordArea: UILabel!
    var choiceAlpha: UIButton!
    var choiceBeta: UIButton!
    
    var questionData: Array<KeepInMindQuestion> = Array<KeepInMindQuestion>()
    var currentSentenceArray = [String]()
    
    var currentQuestion = 0
    var clickTag = true
    
    var userScore = 0
   
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        dataFetching()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: Initialization for the user interface
    
    func initUI(){
        
        let screenSize = UIScreen.mainScreen().bounds
        wordArea = UILabel(frame: CGRect(x: 0, y: screenSize.height/3, width: screenSize.width, height: screenSize.height/5))
        wordArea.backgroundColor = UIColor(red: 56.0/255.0, green: 155.0/255.0, blue: 178.0/255.0, alpha: 1.0)
        
        choiceAlpha = UIButton(frame: CGRect(x: 0, y: screenSize.height/3 + screenSize.height/5, width: screenSize.width/2, height: screenSize.height/7))
        choiceAlpha.backgroundColor = UIColor(red: 173.0/255.0, green: 17.0/255.0, blue: 87.0/255.0, alpha: 1.0)
        
        choiceBeta = UIButton(frame: CGRect(x: screenSize.width/2, y: screenSize.height/3 + screenSize.height/5, width: screenSize.width/2, height: screenSize.height/7))
        choiceBeta.backgroundColor = UIColor(red: 178.0/255.0, green: 161.0/255.0, blue: 9.0/255.0, alpha: 1.0)
        
        
        wordArea.font = UIFont(name: Theme.globalFont, size: 17)
        wordArea.textAlignment = .Center
        wordArea.textColor = UIColor.whiteColor()
        wordArea.text = "0"
        
        choiceAlpha.titleLabel?.font = UIFont(name: Theme.globalFont, size: 25)
        choiceBeta.titleLabel?.font = UIFont(name: Theme.globalFont, size: 25)
        
        choiceAlpha.enabled = false
        choiceBeta.enabled = false
        choiceAlpha.alpha = 0
        choiceBeta.alpha = 0
        
        
        choiceAlpha.addTarget(self, action: "buttonClick:", forControlEvents: .TouchUpInside)
        choiceBeta.addTarget(self, action: "buttonClick:", forControlEvents: .TouchUpInside)
        
        
        self.view.addSubview(wordArea)
        self.view.addSubview(choiceAlpha)
        self.view.addSubview(choiceBeta)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Show the description of the question
    
    func showWords(){
        
        UILabel.animateWithDuration(0.5, animations: {
            
            self.wordArea.alpha = 1
        })
        
        let seconds = 4.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            // here code perfomed with delay
            UILabel.animateWithDuration(0.3, animations: {
                self.wordArea.alpha = 0
                self.wordArea.text = "How many words realted to waste recycling?"
            })
            UILabel.animateWithDuration(0.3, animations: {
                self.wordArea.alpha = 1
            })
            self.choiceAlpha.enabled = true
            self.choiceBeta.enabled = true
            UIButton.animateWithDuration(0.3, animations: {
                self.choiceAlpha.alpha = 1
                self.choiceBeta.alpha = 1
                if random() % 2 == 0 {
                    self.choiceAlpha.setTitle(self.questionData[self.currentQuestion].question_choice_alpha, forState: UIControlState.Normal)
                    self.choiceBeta.setTitle(self.questionData[self.currentQuestion].question_choice_beta, forState: UIControlState.Normal)
                }else{
                    self.choiceBeta.setTitle(self.questionData[self.currentQuestion].question_choice_alpha, forState: UIControlState.Normal)
                    self.choiceAlpha.setTitle(self.questionData[self.currentQuestion].question_choice_beta, forState: UIControlState.Normal)
                }
            })
        })
        
        self.wordArea.text = questionData[currentQuestion].question_content
        
    }
    
    // MARK: Update the question
    
    func updateQuestion(){
        
        UILabel.animateWithDuration(0.3, animations: {
            self.wordArea.text = ""
        })
        self.choiceAlpha.enabled = false
        self.choiceBeta.enabled = false
        UIButton.animateWithDuration(0.3, animations: {
            self.choiceAlpha.alpha = 0
            self.choiceBeta.alpha = 0
            self.choiceAlpha.setTitle("", forState: UIControlState.Normal)
            self.choiceBeta.setTitle("", forState: UIControlState.Normal)
        })
        if(currentQuestion == questionData.count-1){
            self.wordArea.text = "You have finished the quiz!"
            clickTag = false
        }
        if(questionData.count > 0 && currentQuestion < questionData.count && clickTag){
            clickTag = false
            showWords()
        }
    }
    
    // MARK: Handle the event for the two buttons
    
    func buttonClick(sender: UIButton){
        self.clickTag = true
        if sender.titleLabel?.text == questionData[currentQuestion].question_choice_alpha {
            userScore += questionData[currentQuestion].question_score
            scoreLabel.text = String(userScore)
        }
        currentQuestion++
        updateQuestion()
    }
    
    
    // MARK: Fetching data from the server
    
    
    func dataFetching() {
        getDataFromServer(self.resultHandler)
    }
    
    func getTokenFromServer() {
        
    }
    
    
    func getDataFromServer(compleionHandler: ((AnyObject!) -> Void)?) {
        
        let semaphore = dispatch_semaphore_create(0)
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: Net.keepInMindQuizAddress)!){
            
            (data, response, error) in print(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
            
            if (data != nil){
                let test = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                let jsonData:NSData = test.dataUsingEncoding(NSUTF8StringEncoding)!
                
                do {
                    let json: AnyObject? = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
                    compleionHandler?(json)
                    
                    //Solve the problem that first question could not be loaded
                    dispatch_async(dispatch_get_main_queue()) {
                        self.updateQuestion()
                    }
                    
                    if(Debug.debug_mode){
                        print("####"+String(self.questionData.count))
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
        if let list = jsonResult as? NSArray {
            for (var i = 0; i < list.count; i++) {
                if let item = list[i] as? NSDictionary {
                    
                    let question_temp: KeepInMindQuestion = KeepInMindQuestion()
                    
                    question_temp.question_text = item["question_text"] as! String
                    question_temp.question_content = item["question_content"] as! String
                    question_temp.question_choice_alpha = item["question_choice"] as! String
                    question_temp.question_score = item["question_score"] as! Int
                    question_temp.question_total_times = item["question_total_times"] as! Int
                    
                    if random()%2==0 {
                        // Issue: if choice equal zero
                        question_temp.question_choice_beta = String(Int(question_temp.question_choice_alpha)!-1)
                    }else{
                        question_temp.question_choice_beta = String(Int(question_temp.question_choice_alpha)!+1)
                    }
                    
                    questionData.append(question_temp)
                }
            }
        }
    }
    
    
    // MARK: Handle the tap event
    
    @IBAction func tapEventHandler(sender: AnyObject) {
        
        let menuControlView = MenuControlView()
        
        menuControlView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        
        menuControlView.backMainButton.addTarget(self, action: "returnToMain:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(menuControlView)
    }
    
    //Set the event handler for the returnToMain button
    
    func returnToMain(sender: UIButton!){
        //Dismiss blur view and menu view
        
        if let menuViewWithTag = self.view.viewWithTag(100){
            menuViewWithTag.alpha = 1
            UIView.animateWithDuration(0.35, animations: {menuViewWithTag.alpha = 0.0})
            menuViewWithTag.removeFromSuperview()
        }
        if let blurViewWithTag = self.view.viewWithTag(101){
            blurViewWithTag.alpha = 1
            UIView.animateWithDuration(0.35, animations: {blurViewWithTag.alpha = 0.0})
            blurViewWithTag.removeFromSuperview()
        }
        
        let mainView = self.storyboard?.instantiateViewControllerWithIdentifier("MainController") as! UITabBarController
        mainView.selectedIndex = 1
        self.presentViewController(mainView, animated: true, completion: nil)
        
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
