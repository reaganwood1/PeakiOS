//
//  UIButton+Extensions.swift
//  Summit
//
//  Created by Reagan Wood on 3/15/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

extension UIButton {
    public func addButtonShadow() {
        layer.shadowOffset = CGSize(width: 0.0, height: 10.0) // TODO: make into helper function
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.23).cgColor
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 1.0
    }
}
