//
//  GaugeView.swift
//  HomeMonitor
//
//  Created by Seth Porter on 12/5/16.
//  Copyright © 2016 sbporter. All rights reserved.
//

import UIKit

class GaugeView: UIView {
    let π: CGFloat = CGFloat(M_PI)
    
    var progressFillColor = Colors.orange {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var percentage: Float = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = .redraw
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tintColorDidChange() {
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Draw the empty gauge
        // Constants for rest of computation
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        let arcWidth: CGFloat = bounds.width * 0.25
        
        // Compute outline start and end angle
        let startAngle: CGFloat = 5 * π / 6
        let endAngle: CGFloat = π / 6
        
        // Draw path for empty wheel
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        path.lineWidth = arcWidth
        Colors.mediumGray.setStroke()
        path.stroke()
        
        
        // DRAW filled gauge path
        // Determine degrees difference between angles
        let angleDifference: CGFloat = 2 * π - startAngle + endAngle
        
        // Calculate the arc for a single percentage point
        let arcLengthPerPercentagePoint = angleDifference / CGFloat(100)
        
        // Determine angle of filled section
        let outlineEndAngle = arcLengthPerPercentagePoint * CGFloat(percentage) + startAngle
        
        // Draw the outer arc
        let outlinePath = UIBezierPath(arcCenter: center,
                                       radius: bounds.width/2,
                                       startAngle: startAngle,
                                       endAngle: outlineEndAngle,
                                       clockwise: true)
        
        // Draw the inner arc
        outlinePath.addArc(withCenter: center,
                           radius: bounds.width/2 - arcWidth,
                           startAngle: outlineEndAngle,
                           endAngle: startAngle,
                           clockwise: false)
        
        // Close the path and fill
        outlinePath.close()
        progressFillColor.setFill()
        outlinePath.lineWidth = 2.0
        outlinePath.fill()
    }
}
