//
//  FeedbackModel.swift
//  UOAWE
//
//  Created by ZhouYue on 4/02/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import Foundation

class Feedback{
    
    // MARK: Properties
    
    var feedback_text: String = ""
    var feedback_content: String = ""
    
    // MARK: Initialization
    
    init?(feedback_text: String, feedback_content: String){
        self.feedback_text = feedback_text
        self.feedback_content = feedback_content
    }
    
}