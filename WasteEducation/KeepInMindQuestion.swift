//
//  KeepInMindQuestion.swift
//  WasteEducation
//
//  Created by ZhouYue on 22/01/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import Foundation

class KeepInMindQuestion{
 
    // MARK: Properties
    
    var question_text: String
    var question_content: String
    var question_choice_alpha: String
    var question_choice_beta: String
    var question_score: Int
    var question_total_times: Int
    
    // MARK: Initialization
    
    init?(question_text: String, question_content: String, question_choice_alpha: String, question_choice_beta: String, question_score: Int, question_total_times: Int){
        
        self.question_text = question_text
        self.question_content = question_content
        self.question_choice_alpha = question_choice_alpha
        self.question_choice_beta = question_choice_beta
        self.question_score = question_score
        self.question_total_times = question_total_times
    }
    
    
    init(){
        self.question_text = ""
        self.question_content = ""
        self.question_choice_alpha = ""
        self.question_choice_beta = ""
        self.question_score = 0
        self.question_total_times = 0
    }
    
}