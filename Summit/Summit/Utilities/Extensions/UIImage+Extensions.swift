//
//  UIImage+Extensions.swift
//  Summit
//
//  Created by Reagan Wood on 4/9/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

extension UIImage {
    func recolor(to color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)

        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: cgImage!)

        color.setFill()
        context.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        newImage.accessibilityIdentifier = accessibilityIdentifier
        
        return newImage
    }
}
