//
//  WhichBinViewController.swift
//  WasteEducation
//
//  Created by ZhouYue on 20/01/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import UIKit
import CoreMotion

class WhichBinViewController: UIViewController, NetProtocol {
    
    // MARK: Properties
    
    var leftArea: UILabel!
    var rightArea: UILabel!
    var wasteRed: UIColor!
    var wasteYellow: UIColor!
    var wasteGreen: UIColor!
    var wasteBlue: UIColor!
    var wasteImageView: UIImageView!
    var wasteItemDescrption: UILabel!
    
    var userScore = 0
    
    // Used for shake event
    
    var motionManager: CMMotionManager!
    var destX:CGFloat  = 0.0
    
    var questionData: Array<WhichBinQuestion> = Array<WhichBinQuestion>()
    
    var currentQuestion = 0
    
    // Record color for two sides
    
    var leftColor = ""
    var rightColor = ""
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataFetching()
        
        initUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Initialization of user interface
    
    func initUI(){
        
        motionManager = CMMotionManager()
        scoreLabel.text = "0"
        let screenSize = UIScreen.mainScreen().bounds
        leftArea = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width/2, height: screenSize.height))
        rightArea = UILabel(frame: CGRect(x: screenSize.width/2, y: 0, width: screenSize.width/2, height: screenSize.height))
        wasteImageView = UIImageView(frame: CGRect(x: screenSize.width/3, y: screenSize.height * 2/5, width: screenSize.width/3, height: screenSize.width/3))
        wasteItemDescrption = UILabel(frame: CGRect(x: screenSize.width/5, y: (screenSize.height*2/5)+screenSize.width/5 + 10, width: screenSize.width*3/5, height: screenSize.width/3))
        wasteItemDescrption.textAlignment = .Center
        wasteItemDescrption.font = UIFont(name: Theme.globalFont, size: 18)
        
        
        wasteRed = Theme.cblindModeRed
        wasteBlue = Theme.cblindModeBlue
        wasteGreen = Theme.cblindModeGreen
        wasteYellow = Theme.cblindModeYellow
        
        self.view.addSubview(leftArea)
        self.view.addSubview(rightArea)
        self.view.sendSubviewToBack(leftArea)
        self.view.sendSubviewToBack(rightArea)
        self.view.addSubview(wasteImageView)
        self.view.addSubview(wasteItemDescrption)

    }
    
    // MARK: Update the content and UI
    
    func updateQuestion(){
        if (currentQuestion < questionData.count){
            wasteImageView.image = UIImage(named: questionData[currentQuestion].question_image)
            wasteItemDescrption.text = questionData[currentQuestion].question_waste_name
            
            print(questionData[currentQuestion].question_image)
            
            // Random direction and compatible color generation.
            
            if(questionData[currentQuestion].question_choice == "RED")
            {
                let colorRdm = random() % 3
                var compatibleColor: UIColor!
                let randomDirection = random() % 2
                
                compatibleColor = wasteYellow
                
                if (colorRdm == 1)
                {
                    compatibleColor = wasteGreen
                    
                }else if (colorRdm == 2)
                {
                    compatibleColor = wasteBlue
                }
                if (randomDirection == 0){
                    leftArea.backgroundColor = wasteRed
                    rightArea.backgroundColor = compatibleColor
                    leftColor = "RED"
                    if(compatibleColor == wasteYellow){
                        rightColor = "YELLOW"
                    }else if (compatibleColor == wasteBlue){
                        rightColor = "BLUE"
                    }else if (compatibleColor == wasteGreen){
                        rightColor = "GREEN"
                    }
                }else{
                    rightArea.backgroundColor = wasteRed
                    leftArea.backgroundColor = compatibleColor
                    rightColor = "RED"
                    if(compatibleColor == wasteYellow){
                        leftColor = "YELLOW"
                    }else if (compatibleColor == wasteBlue){
                        leftColor = "BLUE"
                    }else if (compatibleColor == wasteGreen){
                        leftColor = "GREEN"
                    }
                }
            }else if(questionData[currentQuestion].question_choice == "YELLOW")
            {
                let colorRdm = random() % 3
                var compatibleColor: UIColor!
                let randomDirection = random() % 2
                
                compatibleColor = wasteRed
                
                if (colorRdm == 1)
                {
                    compatibleColor = wasteGreen
                }else if (colorRdm == 2)
                {
                    compatibleColor = wasteBlue
                }
                if (randomDirection == 0){
                    leftArea.backgroundColor = wasteYellow
                    rightArea.backgroundColor = compatibleColor
                    leftColor = "YELLOW"
                    if(compatibleColor == wasteRed){
                        rightColor = "RED"
                    }else if (compatibleColor == wasteBlue){
                        rightColor = "BLUE"
                    }else if (compatibleColor == wasteGreen){
                        rightColor = "GREEN"
                    }
                }else{
                    rightArea.backgroundColor = wasteYellow
                    leftArea.backgroundColor = compatibleColor
                    rightColor = "YELLOW"
                    if(compatibleColor == wasteRed){
                        leftColor = "RED"
                    }else if (compatibleColor == wasteBlue){
                        leftColor = "BLUE"
                    }else if (compatibleColor == wasteGreen){
                        leftColor = "GREEN"
                    }
                }
                
            }else if(questionData[currentQuestion].question_choice == "GREEN"){
                let colorRdm = random() % 3
                var compatibleColor: UIColor!
                let randomDirection = random() % 2
                
                compatibleColor = wasteYellow
                
                if (colorRdm == 1)
                {
                    compatibleColor = wasteRed
                }else if (colorRdm == 2)
                {
                    compatibleColor = wasteBlue
                }
                if (randomDirection == 0){
                    leftArea.backgroundColor = wasteGreen
                    rightArea.backgroundColor = compatibleColor
                    leftColor = "GREEN"
                    if(compatibleColor == wasteYellow){
                        rightColor = "YELLOW"
                    }else if (compatibleColor == wasteBlue){
                        rightColor = "BLUE"
                    }else if (compatibleColor == wasteRed){
                        rightColor = "RED"
                    }
                }else{
                    rightArea.backgroundColor = wasteGreen
                    leftArea.backgroundColor = compatibleColor
                    rightColor = "GREEN"
                    if(compatibleColor == wasteYellow){
                        leftColor = "YELLOW"
                    }else if (compatibleColor == wasteBlue){
                        leftColor = "BLUE"
                    }else if (compatibleColor == wasteRed){
                        leftColor = "RED"
                    }
                }
                
            }

        }
        
    }
    
    
    // MARK: Data fetching and processing
    
    func dataFetching() {
        getDataFromServer(self.resultHandler)
    }

    // Fetch data from the server
    
    func getDataFromServer(compleionHandler: ((AnyObject!) -> Void)?) {
        let semaphore = dispatch_semaphore_create(0)
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: Net.whichBinQuizAddress)!){
            
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
    
    
    // Handle the final result
    
    func resultHandler(jsonResult: AnyObject!) {
        if let list = jsonResult as? NSArray {
            for (var i = 0; i < list.count; i++) {
                if let item = list[i] as? NSDictionary {
                    
                    let question_temp: WhichBinQuestion = WhichBinQuestion()
                    
                    question_temp.question_text = item["question_text"] as! String
                    question_temp.question_image = item["question_image"] as! String
                    question_temp.question_waste_name = item["question_waste_name"] as! String
                    question_temp.question_choice = item["question_choice"] as! String
                    question_temp.question_score = item["question_score"] as! Int
                    question_temp.question_total_times = item["question_total_times"] as! Int
                    
                    questionData.append(question_temp)
                    
                }
            }
        }
    }
    
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    // MARK: Accelerometer sensor event detection event
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        if (motion == .MotionShake && motionManager.accelerometerAvailable == true) {
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler:{
                data, error in
                
                if data!.acceleration.x < 0 {
                    if(self.leftColor == self.questionData[self.currentQuestion].question_choice){
                        if(self.currentQuestion+1 < self.questionData.count){
                            self.userScore += self.questionData[self.currentQuestion].question_score
                            self.scoreLabel.text = String(self.userScore)
                            self.currentQuestion++
                        }
                        if(self.currentQuestion != self.questionData.count-1){
                            self.updateQuestion()
                        }
                    }
                }else if(data!.acceleration.x > 0){
                    if(self.rightColor == self.questionData[self.currentQuestion].question_choice){
                        if(self.currentQuestion+1 < self.questionData.count){
                            self.userScore += self.questionData[self.currentQuestion].question_score
                            self.scoreLabel.text = String(self.userScore)
                            self.currentQuestion++
                        }
                        if(self.currentQuestion != self.questionData.count-1){
                            self.updateQuestion()
                        }
                    }
                }
                    
                
            })
            
        }
    }
    
    // MARK: Tap Recognizer Eevent
    
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}