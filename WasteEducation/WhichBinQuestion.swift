//
//  WhichBinQuestion.swift
//  WasteEducation
//
//  Created by ZhouYue on 22/01/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import Foundation

class WhichBinQuestion{
    
    // MARK: Properties
    
    var question_text: String
    var question_image: String
    var question_waste_name: String
    var question_choice: String
    var question_score: Int
    var question_total_times: Int
    
    // MARK: Initialization
    
    init?(question_text: String, question_image: String, question_waste_name: String, question_choice: String, question_score: Int, question_total_times: Int){
        
        self.question_text = question_text
        self.question_image = question_image
        self.question_waste_name = question_waste_name
        self.question_choice = question_choice
        self.question_score = question_score
        self.question_total_times = question_total_times
    }
    
    
    init(){
        self.question_text = ""
        self.question_image = ""
        self.question_waste_name = ""
        self.question_choice = ""
        self.question_score = 0
        self.question_total_times = 0
    }
    
}