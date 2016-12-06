//
//  DateValueFormatter.swift
//  HomeMonitor
//
//  Created by Seth Porter on 12/4/16.
//  Copyright © 2016 sbporter. All rights reserved.
//

import Foundation
import Charts

class DateValueFormatter: NSObject, IAxisValueFormatter {
    let dateFormatter = DateFormatter()
    
    override init() {
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.timeStyle = .short
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Date.init(timeIntervalSince1970: value))
    }
}
