//
//  ConstraintProtocol.swift
//  HomeMonitor
//
//  Created by Seth Porter on 12/3/16.
//  Copyright © 2016 sbporter. All rights reserved.
//

import Foundation

public protocol ConstraintProtocol {
    func configureSubviews()
    func configureConstraints()
    
    func setupViews()
}

public extension ConstraintProtocol {
    func setupViews() {
        configureSubviews()
        configureConstraints()
    }
}
