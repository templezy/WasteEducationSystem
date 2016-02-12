//
//  SurveyViewController.swift
//  WasteEducation
//
//  Created by ZhouYue on 3/01/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import UIKit
import AVFoundation

class SurveyViewController: UIViewController {
    
    
    // MARK: Properties
    
    var tableData: Array<String> = Array <String>()
    
    var surveyData: Array<Question> = Array <Question>()
    var userAnswer: Array<String> = Array <String>()
    var userScore: Int = 0
    
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    
    @IBOutlet weak var aLabel: UILabel!
    @IBOutlet weak var bLabel: UILabel!
    @IBOutlet weak var cLabel: UILabel!
    
    @IBOutlet weak var questionDescirption: UITextView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var audioPlayer: AVAudioPlayer!
    var buttonTag = false
    var currentQuestion = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        initialUI()
        
        fetchData()
        
        updateButton()
        
        // Do any additional setup after loading the view.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }

//    override func viewDidAppear(animated: Bool) {
//        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initialUI(){
        self.scoreLabel.text = String(0);
        self.view.tag = 99
    }
    
    // MARK: Button Event
    
    func updateButton(){
        
        if(surveyData.count > 0){
            
            //Update the description for each option
            
            aButton.setTitle(surveyData[currentQuestion].first_desc, forState: .Normal)
            bButton.setTitle(surveyData[currentQuestion].second_desc, forState: .Normal)
            cButton.setTitle(surveyData[currentQuestion].third_desc, forState: .Normal)
            
            questionDescirption.text = surveyData[currentQuestion].question_desc
            
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
    
    func updateScore(){
        
        if(userAnswer[currentQuestion] == surveyData[currentQuestion].choice){
            userScore += surveyData[currentQuestion].score
            playSound(GameSound.correctAudio)
        }else{
            playSound(GameSound.incorrectAudio)
        }
        self.scoreLabel.text = String(userScore)
        
        
    }
    
    //Check the button status
    
    func buttonEventCheck(){
        if(currentQuestion + 1 < surveyData.count && !buttonTag){
            currentQuestion++
            updateButton()
        }else if(currentQuestion + 1 == surveyData.count){
            let alertController = UIAlertController(title: "Your Score", message: String(userScore), preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    //Event handler for four options
    
    @IBAction func aButtonEvent(sender: UIButton) {
        if(userAnswer.count < surveyData.count){
            userAnswer.append("A")
            updateScore()
        }
        buttonEventCheck()
    }
    
    
    @IBAction func bButtonEvent(sender: UIButton) {
        if(userAnswer.count < surveyData.count){
            userAnswer.append("B")
            updateScore()
        }
        buttonEventCheck()
    }
    
    
    @IBAction func cButtonEvent(sender: UIButton) {
        if(userAnswer.count < surveyData.count){
            userAnswer.append("C")
            updateScore()
        }
        buttonEventCheck()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    // MARK: Fetch data from Server
    
    func getDataFromServer(compleionHandler: ((AnyObject!) -> Void)?){
        
        //For the local test
        let url = NSURL(string: Net.multipleChoiceAddress)
        
        let semaphore = dispatch_semaphore_create(0)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){
            
            (data, response, error) in print(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
            
            if (data != nil){
                let test = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                let jsonData:NSData = test.dataUsingEncoding(NSUTF8StringEncoding)!
                
                do {
                    let json: AnyObject? = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
                    compleionHandler?(json)
                    
                    //Solve the problem that first question could not be loaded
                    dispatch_async(dispatch_get_main_queue()) {
                        self.updateButton()
                    }
                    
                    if(Debug.debug_mode){
                        print("####"+String(self.surveyData.count))
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
    
    //Fetch the data from the server
    
    func fetchData(){
        getDataFromServer(self.resultHandler)
    }
    
    //Action after finish the data fetching
    
    func resultHandler(jsonResult: AnyObject!){
        if let list = jsonResult as? NSArray {
            for (var i = 0; i < list.count; i++) {
                if let item = list[i] as? NSDictionary {
                    
                    let question_temp: Question = Question()
                    
                    question_temp.question_text = item["question_text"] as! String
                    question_temp.question_type = item["question_type"] as! String
                    question_temp.img_url = item["img_url"] as! String
                    question_temp.video_url = item["video_url"] as! String
                    question_temp.question_desc = item["question_desc"] as! String
                    question_temp.first_desc = item["first_desc"] as! String
                    question_temp.second_desc = item["second_desc"] as! String
                    question_temp.third_desc = item["third_desc"] as! String
                    question_temp.fourth_desc = item["fourth_desc"] as! String
                    question_temp.choice = item["choice"] as! String
                    question_temp.score = item["score"] as! Int
                    question_temp.total_times = item["total_times"] as! Int
                    
                    surveyData.append(question_temp)
                }
            }
        }
    }
    
    
    // MARK: Tap Recognizer Event
    
    @IBAction func showControlMenu(sender: UITapGestureRecognizer) {
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
    
}
