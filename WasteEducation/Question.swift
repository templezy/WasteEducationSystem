//
//  Question.swift
//  WasteEducation
//
//  Created by ZhouYue on 5/01/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import UIKit

class Question {
    
    // MARK: Properties
    
    var question_text: String
    var question_type: String
    var img_url: String
    var video_url: String
    var question_desc: String
    var first_desc: String
    var second_desc: String
    var third_desc: String
    var fourth_desc: String
    var choice: String
    var score: Int
    var total_times: Int
    
    // MARK: Initialization
    
    init?(question_text: String, question_type: String, img_url: String, video_url: String, question_desc: String, first_desc: String, second_desc: String, third_desc: String, fourth_desc: String, choice: String, score: Int, total_times: Int){
        
        // Initialize properties
        
        self.question_text = question_text
        self.question_type = question_type
        self.img_url = img_url
        self.video_url = video_url
        self.question_desc = question_desc
        self.first_desc = first_desc
        self.second_desc = second_desc
        self.third_desc = third_desc
        self.fourth_desc = fourth_desc
        self.choice = choice
        self.score = score
        self.total_times = total_times
        
    }
    
    init(){
        self.question_text = ""
        self.question_type = ""
        self.img_url = ""
        self.video_url = ""
        self.question_desc = ""
        self.first_desc = ""
        self.second_desc = ""
        self.third_desc = ""
        self.fourth_desc = ""
        self.choice = ""
        self.score = 0
        self.total_times = 0
    }
    
    
    
}