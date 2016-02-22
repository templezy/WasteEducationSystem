//
//  Constants.swift
//  WasteEducation
//
//  Created by ZhouYue on 12/01/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import Foundation

// MARK: RESTful API
struct Net {
    static let serverAddress = "http://192.241.184.96:8081"
//    static let serverAddress = "http://10.201.7.29:8000"
    static let multipleChoiceAddress = Net.serverAddress + "/we/multiple_choice/"
    static let trueFalseQuizAddress = Net.serverAddress + "/we/true_false_question/"
    static let whichBinQuizAddress = Net.serverAddress + "/we/which_bin_question/"
    static let keepInMindQuizAddress = Net.serverAddress + "/we/keep_in_mind_question/"
    static let cdcalcuAddress = Net.serverAddress + "/we/cdcalcu/"
    static let lcenterAddress = Net.serverAddress + "/we/learningcenter/"
    static let feedbackAddress = Net.serverAddress + "/we/feedback/"
    static let tokenAddress = Net.serverAddress + "/api-token-auth/"
}

//MARK: Debug
struct Debug {
    static let debug_mode = false
}

//MARK: Theme properties
struct Theme {
    static let globalFont = "Arial Rounded MT Bold"
    static let navbarItemColor = UIColor(red: 0, green: 147/255, blue: 200/255, alpha: 1)
    static let cblindModeRed = UIColor.redColor()
    static let cblindModeYellow = UIColor.yellowColor()
    static let cblindModeGreen = UIColor.greenColor()
    static let cblindModeBlue = UIColor.blueColor()
    static let normalGreen = UIColor(red: 184/255, green: 220/255, blue: 173/255, alpha: 1)
    static let normalYellow = UIColor(red: 251/255, green: 184/255, blue: 186/255, alpha: 1)
    static let normalRed = UIColor(red: 245/255, green: 146/255, blue: 142/255, alpha: 1)
    static let normalBlue = UIColor(red: 111/255, green: 208/255, blue: 245/255, alpha: 1)
}

//MARK: Settings
struct Settings {
    static var blindMode = false
    static var soundEffect = true
}

//MARK: Sound
struct GameSound {
    static var correctAudio = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("true", ofType: "wav")!)
    static var incorrectAudio = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("false", ofType: "wav")!)
}

//MARK: Authen
struct Auth {
    static var username = "root"
    static var password = "rootroot"
}