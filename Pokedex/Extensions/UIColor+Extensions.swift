//
//  UIColor+Extensions.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 26/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit


extension UIColor {
    // Adapted from https://gist.github.com/arshad/de147c42d7b3063ef7bc
    convenience init(hex: String, alpha: Float) {
        var resultingHex = hex
        
        if (resultingHex.hasPrefix("#")) {
            resultingHex.remove(at: resultingHex.startIndex)
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: resultingHex).scanHexInt64(&rgbValue)
        
        self.init(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(alpha))
    }
    
    convenience init(hex: String){
        self.init(hex: hex, alpha: 1.0)
    }
}
