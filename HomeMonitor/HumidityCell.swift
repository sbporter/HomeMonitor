//
//  HumidityCell.swift
//  HomeMonitor
//
//  Created by Seth Porter on 12/6/16.
//  Copyright © 2016 sbporter. All rights reserved.
//

import UIKit

class HumidityCell: UICollectionViewCell {
    var gaugeView = GaugeView()
    var lastUpdatedLabel = UILabel()
    var valueLabel = UILabel()
    
    var value: Float = 60.0 {
        didSet {
            valueLabel.text = String(format: "%.0f%%", value)
            gaugeView.percentage = value
        }
    }
    
    var lastUpdateString: String = "Loading..." {
        didSet {
            lastUpdatedLabel.text = lastUpdateString
        }
    }
    
    // Custom highlight tinting override
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                self.backgroundColor = Colors.lightGray
            }
            else {
                self.backgroundColor = Colors.darkGray
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Colors.darkGray
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension HumidityCell: ConstraintProtocol {
    func configureSubviews() {
        gaugeView.translatesAutoresizingMaskIntoConstraints = false
        gaugeView.isUserInteractionEnabled = false
        gaugeView.backgroundColor = UIColor.clear
        gaugeView.progressFillColor = Colors.blue
        addSubview(gaugeView)
        
        valueLabel.font = Fonts.mediumLight
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.textColor = Colors.trueWhite
        valueLabel.textAlignment = .center
        valueLabel.baselineAdjustment = .alignCenters
        valueLabel.backgroundColor = UIColor.clear
        addSubview(valueLabel)
        
        
        lastUpdatedLabel.font = Fonts.small
        lastUpdatedLabel.translatesAutoresizingMaskIntoConstraints = false
        lastUpdatedLabel.textColor = Colors.trueWhite
        lastUpdatedLabel.textAlignment = .center
        lastUpdatedLabel.backgroundColor = UIColor.clear
        addSubview(lastUpdatedLabel)
        
    }
    
    func configureConstraints() {
        gaugeView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsetsMake(10, 10, 10, 10))
        
        valueLabel.autoCenterInSuperview()
        valueLabel.autoMatch(.width, to: .width, of: self, withMultiplier: 0.35)
        valueLabel.autoMatch(.height, to: .height, of: self, withMultiplier: 0.35)
        
        lastUpdatedLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
        lastUpdatedLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 5)
        lastUpdatedLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 5)
    }
}
