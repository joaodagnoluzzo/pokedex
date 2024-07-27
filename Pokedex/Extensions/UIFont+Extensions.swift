//
//  UIFont+Extensions.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 27/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func customBodyFont(size: CGFloat) -> UIFont {
        if let customFont = UIFont(name: "PokemonGB", size: size) {
            return UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
        } else {
            return UIFont()
        }
    }
    
    static func customTitleFont(size: CGFloat) -> UIFont {
        if let customFont = UIFont(name: "Pokemon Solid", size: size) {
            return UIFontMetrics(forTextStyle: .title2).scaledFont(for: customFont)
        } else {
            return UIFont()
        }
    }
    
}
