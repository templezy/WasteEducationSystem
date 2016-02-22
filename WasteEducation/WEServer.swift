//
//  WEServer.swift
//  UOAWE
//
//  Created by ZhouYue on 4/02/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import Foundation
import SystemConfiguration

class WEServer{
   
    
    /*!
    *      @constant HealthyStatusCode
    *      This tag indicates that user is under successful Internet connection environment and the server i
    *      running healthly.
    *
    *      @constant NotInNetEnvironment
    *      This tag indicates that the use is not under the Internet environment.
    *
    *      @constant ServerDown_maintain
    *      This tag indicates that the server is shut down or under a maintenance.
    *
    */
    
    enum ConnectionStatusCode: Int {
        case HealthyStatus = 100, NotInNetEnvironment, ServerDown_Maintain
    }
    
    static var serverStatus = false
    /*
     *      Check the availability of the Internet connection
     */
    static func isConnectedToNetwork() -> Int{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            print("1")
            return ConnectionStatusCode.NotInNetEnvironment.rawValue
        }
        if !self.statusFetching(){
            print("3")
            return ConnectionStatusCode.ServerDown_Maintain.rawValue
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        if (isReachable && !needsConnection){
            print("2")
        }else{
            return ConnectionStatusCode.ServerDown_Maintain.rawValue
        }
        return ConnectionStatusCode.HealthyStatus.rawValue
    }
    
    
    /*
     *      Check the availability of the server
     */
    
    
    private static func statusFetching() -> Bool{
        do {
            var response: NSURLResponse?
            let request = NSMutableURLRequest(URL: NSURL(string: Net.lcenterAddress)!)
            _ = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response) as NSData?
            if let httpResponse = response as? NSHTTPURLResponse {
                print("error \(httpResponse.statusCode)")
            }
        } catch let error as NSError{
            print(error.localizedDescription)
            return false
        }
        return true
    }
    
    
}