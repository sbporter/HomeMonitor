//
//  NetworkManager.swift
//  HomeMonitor
//
//  Created by Seth Porter on 12/3/16.
//  Copyright © 2016 sbporter. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    static let sharedInstance = NetworkManager()
    
    static let baseURL: String = "https://api.devicehub.net/v2/project/"
    
    static let headers: HTTPHeaders = [
        "X-ApiKey": NetworkConstants.apiKey,
        "Content-Type": "application/json"
    ]

    static func getHistory(
        device: String,
        sensor: String,
        completionHandler: @escaping ([Double],[Double]) -> ()) {

        let stringURL: String = NetworkManager.baseURL +
            NetworkConstants.projectID +
            "/device/" + device +
            "/sensor/" + sensor + "/data?limit=1000"
        
        Alamofire.request(stringURL, method: HTTPMethod.get, parameters: nil, headers: NetworkManager.headers).responseJSON { responseData in
            if((responseData.result.value) != nil) {
                
                
                let sensorData = JSON(responseData.result.value!)
                
                var timestamps: [Double] = [Double]()
                var values: [Double]     = [Double]()

                if let history = sensorData.arrayObject as? [[String:AnyObject]] {
                    for i in 0..<history.count {
                        timestamps.append(history[i]["timestamp"] as! Double)
                        values.append(history[i]["value"] as! Double)
                    }
                    completionHandler(timestamps.reversed(),values.reversed())
                }
            }
        }
    }
}
