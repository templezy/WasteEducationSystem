//
//  YesNoViewController.swift
//  UOAWE
//
//  Created by ZhouYue on 11/01/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import UIKit
import AVFoundation

class YesNoViewController: UIViewController, NetProtocol {
    
    // MARK: Properties
    
    var yesButton: UIButton!
    var noButton: UIButton!
    var questionDescription: UILabel!
    
    var questionData: Array<TrueFalseQuestion> = Array<TrueFalseQuestion>()
    
    var currentQuestion = 0
    var buttonTag = false
    var userScore = 0
    
    var userToken = ""
    
    var audioPlayer: AVAudioPlayer!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var menuControlButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        initUI()
        
        getTokenFromServer()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Initial User Interface
    func initUI(){
        
        let screenSize = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let buttonHeight: CGFloat = 100
        let cPadding: CGFloat = 20
        
        yesButton = UIButton(frame: CGRect(x: 0, y: screenHeight - buttonHeight , width: screenWidth/2, height: buttonHeight))
        noButton = UIButton(frame: CGRect(x: screenWidth/2, y: screenHeight - buttonHeight, width: screenWidth/2, height: buttonHeight))
        questionDescription = UILabel(frame: CGRect(x: cPadding, y: 0, width: screenWidth - (2 * cPadding), height: screenHeight - buttonHeight))
        
        yesButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        noButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        yesButton.backgroundColor = UIColor(red: 41.0/255.0, green: 163.0/255.0, blue: 41.0/255.0, alpha: 0.8)
        noButton.backgroundColor = UIColor(red: 212.0/255.0, green: 73.0/255.0, blue: 81.0/255.0, alpha: 1)
        questionDescription.textAlignment = .Center
        questionDescription.lineBreakMode = NSLineBreakMode.ByWordWrapping
        questionDescription.numberOfLines = 0
        questionDescription.text = ""
        
        yesButton.setTitle("TRUE", forState: .Normal)
        noButton.setTitle("FALSE", forState: .Normal)
        yesButton.titleLabel?.font = UIFont(name: Theme.globalFont, size: 17)
        noButton.titleLabel?.font = UIFont(name: Theme.globalFont, size: 17)
        questionDescription.font = UIFont(name: Theme.globalFont, size: 25)
        
        
        yesButton.tag = 89757
        noButton.tag = 89758
        
        yesButton.addTarget(self, action: "buttonEvent:", forControlEvents: .TouchUpInside)
        noButton.addTarget(self, action: "buttonEvent:", forControlEvents: .TouchUpInside)
        
        yesButton.addTarget(self, action: "tapEffect:", forControlEvents: .TouchDown)
        noButton.addTarget(self, action: "tapEffect:", forControlEvents: .TouchDown)
        
        
        yesButton.addTarget(self, action: "dragExitEffect:", forControlEvents: .TouchDragExit)
        noButton.addTarget(self, action: "dragExitEffect:", forControlEvents: .TouchDragExit)
        
        
        self.view.addSubview(yesButton)
        self.view.addSubview(noButton)
        self.view.addSubview(questionDescription)
        
    }
    
    // Update the realted elements when question changed
    
    func updateQuestion(){
        if(currentQuestion < questionData.count){
            UILabel.animateWithDuration(0.3, animations: {
                self.questionDescription.alpha = 0
            })
            
            self.questionDescription.text = questionData[currentQuestion].question_desc
            
            UILabel.animateWithDuration(0.3, animations: {
                self.questionDescription.alpha = 1
            })
            scoreLabel.text = String(userScore)
            
            buttonTag = false
        }
        UIButton.animateWithDuration(0.3, animations: {
            self.yesButton.backgroundColor = UIColor(red: 41.0/255.0, green: 163.0/255.0, blue: 41.0/255.0, alpha: 0.8)
            self.noButton.backgroundColor = UIColor(red: 212.0/255.0, green: 73.0/255.0, blue: 81.0/255.0, alpha: 1)
        })
    }
    
    // The effect when button clicked
    
    func tapEffect(sender: UIButton!){
        if(sender.tag == 89757){
            UIButton.animateWithDuration(0.3, animations: {
                self.yesButton.backgroundColor = UIColor(red: 26.0/255.0, green: 102.0/255.0, blue: 26.0/255.0, alpha: 0.8)
            })
        }else if(sender.tag == 89758){
            UIButton.animateWithDuration(0.3, animations: {
                self.noButton.backgroundColor = UIColor(red: 153.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.8)
            })
        }
    }
    
    
    // The effect when finger drag out of area
    
    func dragExitEffect(sender: UIButton!){
        if(sender.tag == 89757){
            UIButton.animateWithDuration(0.3, animations: {
                self.yesButton.backgroundColor = UIColor(red: 41.0/255.0, green: 163.0/255.0, blue: 41.0/255.0, alpha: 0.8)
            })
        }else if(sender.tag == 89758){
            UIButton.animateWithDuration(0.3, animations: {
                self.noButton.backgroundColor = UIColor(red: 212.0/255.0, green: 73.0/255.0, blue: 81.0/255.0, alpha: 1)
            })
        }
    }
    
    
    func playSound(resourceFile: NSURL){
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOfURL: resourceFile)
            audioPlayer.play()
        } catch {
            
        }
    }
    
    
    // Handling the click event
    
    func buttonEvent(sender: UIButton){
        buttonTag = true
        
        if(currentQuestion < questionData.count){
            if(sender.tag == 89757){
                if(questionData[currentQuestion].question_choice == "TRUE"){
                    userScore += questionData[currentQuestion].question_score
                    if Settings.soundEffect {
                        playSound(GameSound.correctAudio)
                    }
                }else{
                    if Settings.soundEffect {
                        playSound(GameSound.incorrectAudio)
                    }
                    let reasonController = UIAlertController(title: "Why you wrong?", message: questionData[currentQuestion].question_reason, preferredStyle: UIAlertControllerStyle.Alert)
                    reasonController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(reasonController, animated: true, completion: nil)
                }
            }else if(sender.tag == 89758){
                if(questionData[currentQuestion].question_choice == "FALSE"){
                    if Settings.soundEffect {
                        playSound(GameSound.correctAudio)
                    }
                    userScore += questionData[currentQuestion].question_score
                }else{
                    if Settings.soundEffect {
                        playSound(GameSound.incorrectAudio)
                    }
                    let reasonController = UIAlertController(title: "Why you wrong?", message: questionData[currentQuestion].question_reason, preferredStyle: UIAlertControllerStyle.Alert)
                    reasonController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(reasonController, animated: true, completion: nil)
                }
            }
        }
        currentQuestion++
        updateQuestion()
    }
    
    
    // MARK: Data exchange handling
    
    
    // Fetching the data
    
    func dataFetching() {
        getDataFromServer(self.resultHandler)
    }
    
    
    func getTokenFromServer() {
        let semaphore = dispatch_semaphore_create(0)
        let request = NSMutableURLRequest(URL: NSURL(string: Net.tokenAddress)!)
        request.HTTPMethod = "POST"
        let postString = "username="+Auth.username+"&password="+Auth.password
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        var response: NSURLResponse?
        
        do {
            
            var _ = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response) as NSData?
            
            if let httpResponse = response as? NSHTTPURLResponse {
//                print("error \(httpResponse.statusCode)")
            }
            
            
            if let httpResponse = response as? NSHTTPURLResponse {
                let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
                    
                    (data, response, error) in print(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
                    
//                    print("error \(httpResponse.statusCode)")
                    
                    if (data != nil){
                        let test = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                        let jsonData: NSData = test.dataUsingEncoding(NSUTF8StringEncoding)!
                        
                        do {
                            let json: AnyObject? = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
                            
                            //Solve the problem that first question could not be loaded
                            dispatch_async(dispatch_get_main_queue()) {
                                //                        self.updateQuestion()
                                
                                let tempToken = json as? NSDictionary
                                let token = tempToken!["token"] as! String
                                
                                self.self.userToken = token
                                self.dataFetching()
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
            }else {
                backToPrevious()
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
            
            backToPrevious()
        }
    }
    
    func backToPrevious(){
        let mainView = self.storyboard?.instantiateViewControllerWithIdentifier("MainController") as! UITabBarController
        
        mainView.selectedIndex = 1
        self.presentViewController(mainView, animated: true, completion: nil)
    }
    
    
    // Get and parse the data
    
    func getDataFromServer(compleionHandler: ((AnyObject!) -> Void)?) {
        
        let semaphore = dispatch_semaphore_create(0)
        let request = NSMutableURLRequest(URL: NSURL(string: Net.trueFalseQuizAddress)!)
        request.HTTPMethod = "GET"
        request.setValue("Token " + userToken, forHTTPHeaderField: "Authorization")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            
            (data, response, error) in
            
//            print(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
            
            if (data != nil){
                let test = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                let jsonData: NSData = test.dataUsingEncoding(NSUTF8StringEncoding)!
                
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
    
    // Parse the data and store it
    
    func resultHandler(jsonResult: AnyObject!) {
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
                    
                    questionData.append(question_temp)
                    
                }
            }
        }
    }
    
    
    // MARK: Tap Recognizer Event
    
    @IBAction func tapGestureHandler(sender: UITapGestureRecognizer) {
        let menuControlView = MenuControlView()
        
        menuControlView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        
        menuControlView.backMainButton.addTarget(self, action: "returnToMain:", forControlEvents: UIControlEvents.TouchUpInside)
        
        menuControlView.restartButton.addTarget(self, action: "restartGame:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(menuControlView)
    }
    
    
    func removeBlurView(){
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
    }
    
    
    
    //Set the event handler for the returnToMain button
    
    func returnToMain(sender: UIButton!){
        //Dismiss blur view and menu view
        
        removeBlurView()
        
        backToPrevious()
        
    }
    
    func restartGame(sender: UIButton!){
        self.userScore = 0
        self.questionDescription.text = ""
        self.scoreLabel.text = "0"
        
        initUI()
        
        getTokenFromServer()
        
        removeBlurView()
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
