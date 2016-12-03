//
//  UIConstants.swift
//  HomeMonitor
//
//  Created by Seth Porter on 12/3/16.
//  Copyright © 2016 sbporter. All rights reserved.
//

import UIKit

struct Colors {
    static let trueBlack = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    static let trueWhite = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let darkGray = UIColor(red: 14.0/255.0, green: 16.0/255.0, blue: 29.0/255.0, alpha: 1.0)
    static let mediumGray = UIColor(red: 32.0/255.0, green: 34.0/255.0, blue: 45.0/255.0, alpha: 1.0)
    static let lightGray = UIColor(red: 84.0/255.0, green: 86.0/255.0, blue: 98.0/255.0, alpha: 1.0)

    static let aqua = UIColor(red: 31.0/255.0, green: 150.0/255.0, blue: 168.0/255.0, alpha: 1.0)
    static let magenta = UIColor(red: 228.0/255.0, green: 31.0/255.0, blue: 110.0/255.0, alpha: 1.0)
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
    }
}
