//
//  SystemMainViewController.swift
//  WasteEducation
//
//  Created by ZhouYue on 14/01/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import UIKit

class SystemMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().barTintColor = UIColor.blackColor()
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        
        
        // Notification part
        
//        var notification = UILocalNotification()
//        notification.alertBody = "Todo Item Is Overdue" // text that will be displayed in the notification
//        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
//        var dateAsString = "03-02-2016 23:05"
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
//        var newDate = dateFormatter.dateFromString(dateAsString)
//        notification.fireDate = newDate // todo item due date (when notification will be fired)
//        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
//        notification.userInfo = ["UUID": "8975789", ] // assign a unique identifier to the notification so that we can retrieve it later
//        notification.category = "TODO_CATEGORY"
//        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        
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
