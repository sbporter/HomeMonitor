//
//  TemperatureLiveButton.swift
//  HomeMonitor
//
//  Created by Seth Porter on 12/5/16.
//  Copyright © 2016 sbporter. All rights reserved.
//

import UIKit

class TemperatureCell: UICollectionViewCell {
    var gaugeView = GaugeView()
    var locationLabel = UILabel()
    var valueLabel = UILabel()
    
    var value: Float = 60.0 {
        didSet {
            valueLabel.text = String(format: "%.1f°", value)
            gaugeView.percentage = value
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
        
        value = 73.9
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension TemperatureCell: ConstraintProtocol {
    func configureSubviews() {
        gaugeView.percentage = 45.0
        gaugeView.translatesAutoresizingMaskIntoConstraints = false
        gaugeView.isUserInteractionEnabled = false
        gaugeView.backgroundColor = UIColor.clear
        addSubview(gaugeView)
        
        valueLabel.text = "60.0°"
        valueLabel.font = Fonts.mediumLight
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.textColor = Colors.trueWhite
        valueLabel.backgroundColor = UIColor.clear
        addSubview(valueLabel)
        
    }
    
    func configureConstraints() {
        gaugeView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsetsMake(10, 10, 10, 10))
        valueLabel.autoCenterInSuperview()
    }
}
