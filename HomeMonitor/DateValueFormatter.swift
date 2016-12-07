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
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = .short
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Date.init(timeIntervalSince1970: value))
    }
    
    static func stringForTimeInterval(value: Double) -> String {
        let staticDateFormatter = DateFormatter()
        staticDateFormatter.dateStyle = DateFormatter.Style.short
        staticDateFormatter.timeStyle = DateFormatter.Style.short
        return staticDateFormatter.string(from: Date.init(timeIntervalSince1970: value))
    }
    
    static func timeAgoSinceTimeInterval(value: Double) -> String {
        let date = NSDate(timeIntervalSince1970: value)
        
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            return "Last year"
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            return "Last month"
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            return "Last week"
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            return "Yesterday"
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            return "An hour ago"
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            return "A minute ago"
        } else {
            return "Just now"
        }
        
    }
}
