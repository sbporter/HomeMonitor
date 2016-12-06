//
//  HomeModel.swift
//  HomeMonitor
//
//  Created by Seth Porter on 12/3/16.
//  Copyright © 2016 sbporter. All rights reserved.
//

import Foundation

struct Device {
    var deviceName: String
    var temperature: Sensor
    var humidity: Sensor
}

struct Sensor {
    var timeValues: [Double]
    var values: [Double]
    
    var currentValue: Double {
        get {
            if let value = values.last {
                return value
            }
            return 0
        }
    }
}

class HomeModel {
    static let sharedInstance = HomeModel()

    var delegates = MulticastDelegate<HomeModelDelegate>()
    
    var climate1: Device = Device(deviceName: "Climate 1",
                                 temperature: Sensor(timeValues: [0], values: [0]),
                                 humidity: Sensor(timeValues: [0], values: [0]))
    
    func loadHistoricalData() {
        NetworkManager.getHistory(device: NetworkConstants.climate1,
                                  sensor: NetworkConstants.temperature,
                                  completionHandler: { (times: [Double], values: [Double]) -> () in
            self.climate1.temperature = Sensor(timeValues: times, values: values)
            self.delegates.invoke { $0.climate1TempUpdate?() }
        })
        
        NetworkManager.getHistory(device: NetworkConstants.climate1,
                                  sensor: NetworkConstants.humidity,
                                  completionHandler: { (times: [Double], values: [Double]) -> () in
            self.climate1.humidity = Sensor(timeValues: times, values: values)
            self.delegates.invoke { $0.climate1HumidityUpdate?() }
        })
    }
}

@objc protocol HomeModelDelegate {
    @objc optional func climate1TempUpdate()
    @objc optional func climate1HumidityUpdate()
}
