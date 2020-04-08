//
//  UIColor+Extensions.swift
//  Summit
//
//  Created by Reagan Wood on 3/17/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

extension UIColor {
    // MARK: DARK MODE COLORS
    @nonobjc private static var darkModeBackground = UIColor(red: 18.0 / 255.0, green: 18.0 / 255.0, blue: 18.0 / 255.0, alpha: 1.0)
    @nonobjc private static var darkModeObjectBlack = UIColor(red: 30.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1.0)
    @nonobjc private static var darkModeTextColor = UIColor.white.withAlphaComponent(0.87)
    @nonobjc private static var darkModePurple = UIColor(red: 187.0 / 255.0, green: 134.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0)
    @nonobjc private static var darkModeSecondaryBackground = UIColor(red: 54.0 / 255.0, green: 54.0 / 255.0, blue: 54.0 / 255.0, alpha: 1.0)
    @nonobjc private static var darkModeBlue = UIColor(red: 132.0 / 255.0, green: 201.0 / 255.0, blue: 251.0 / 255.0, alpha: 1.0)
    @nonobjc private static var darkModeGreen = UIColor(red: 3.0 / 255.0, green: 218.0 / 255.0, blue: 197.0 / 255.0, alpha: 1.0)
    
    // MARK: Light Mode Colors
    @nonobjc private static var lightModeObjectBackground = UIColor(red: 238.0 / 255.0, green: 235.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0)
    @nonobjc private static var lightModePurple = UIColor(red: 98.0 / 255.0, green: 0.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
    @nonobjc private static var lightModeSecondaryBackground = UIColor(red: 224.0 / 255.0, green: 224.0 / 255.0, blue: 224.0 / 255.0, alpha: 1.0)
    @nonobjc private static var lightModeBlue = UIColor(red: 1.0 / 255.0, green: 87.0 / 255.0, blue: 155.0 / 255.0, alpha: 1.0)
    @nonobjc private static var lightModeGreen = UIColor(red: 46.0 / 255.0, green: 125.0 / 255.0, blue: 50.0 / 255.0, alpha: 1.0)
    
    // MARK: Public Colors
    @nonobjc static var textColor: UIColor {
        get {
            return UIColor(light: .black, dark: .darkModeTextColor)
        }
    }
    
    @nonobjc static var summitPurple: UIColor {
        get {
            return UIColor(light: .lightModePurple, dark: .darkModePurple)
        }
    }
    
    @nonobjc static var summitGreen: UIColor {
        get {
            return UIColor(light: .lightModeGreen, dark: .darkModeGreen)
        }
    }
    
    @nonobjc static var summitObjeckBackground: UIColor {
        get {
            return UIColor(light: .lightModeObjectBackground, dark: .darkModeObjectBlack)
        }
    }
    
    @nonobjc static var summitBackground: UIColor {
        get {
            return UIColor(light: .white, dark: .darkModeBackground)
        }
    }
    
    @nonobjc static var summitSecondaryObjectBackground: UIColor {
        get {
            return UIColor(light: .lightModeSecondaryBackground, dark: .darkModeSecondaryBackground)
        }
    }
    
    @nonobjc static var summitBlue: UIColor {
        get {
            return UIColor(light: .lightModeBlue, dark: .darkModeBlue)
        }
    }
    
    /// Creates a color object that generates its color data dynamically using the specified colors. For early SDKs creates light color.
       /// - Parameters:
       ///   - light: The color for light mode.
       ///   - dark: The color for dark mode.
       convenience init(light: UIColor, dark: UIColor) {
           if #available(iOS 13.0, *) {
               self.init { traitCollection in
                   if traitCollection.userInterfaceStyle == .dark {
                       return dark
                   }
                   return light
               }
           }
           else {
               self.init(cgColor: light.cgColor)
           }
       }
}
