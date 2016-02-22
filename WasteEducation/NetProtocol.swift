//
//  NetProtocol.swift
//  WasteEducation
//
//  Created by ZhouYue on 12/01/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import Foundation

protocol NetProtocol{
    
    // MARK: Data fetching
    
    func dataFetching()
    
    func getDataFromServer(compleionHandler: ((AnyObject!) -> Void)?)
    
    func resultHandler(jsonResult: AnyObject!)
    
    func getTokenFromServer()
}