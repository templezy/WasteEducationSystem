//
//  TrueFalseQuestion.swift
//  WasteEducation
//
//  Created by ZhouYue on 12/01/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import Foundation

class TrueFalseQuestion{
    
    // MARK: Properties
    
    var question_text: String
    var question_desc: String
    var question_reason: String
    var question_choice: String
    var question_score: Int
    var question_total_times: Int
    
    //MARK: Initialization
    
    init?(question_text: String, question_desc: String, question_reason: String, question_choice: String, question_score: Int, question_total_times: Int){
        
        // Initialize properties
        
        self.question_text = question_text
        self.question_desc = question_desc
        self.question_reason = question_reason
        self.question_choice = question_choice
        self.question_score = question_score
        self.question_total_times = question_total_times
        
    }
    
    
    init(){
        self.question_text = ""
        self.question_desc = ""
        self.question_reason = ""
        self.question_choice = ""
        self.question_score = 0
        self.question_total_times = 0
    }
    
}