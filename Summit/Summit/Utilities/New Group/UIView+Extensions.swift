//
//  UIView+Extensions.swift
//  Summit
//
//  Created by Reagan Wood on 3/15/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

extension UIView {
    public func addAllSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
    
    func snapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    func roundCorners(by amount: CGFloat) {
        layer.cornerRadius = amount
    }
}
