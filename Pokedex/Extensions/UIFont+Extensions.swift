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
        return UIFont.customFont(named: "PokemonGB", size: size)
    }
    
    static func customTitleFont(size: CGFloat) -> UIFont {
        return UIFont.customFont(named: "Pokemon Solid", size: size)
    }
    
    private static func customFont(named fontName: String, size: CGFloat) -> UIFont {
        if let customFont = UIFont(name: fontName, size: size) {
            return UIFontMetrics(forTextStyle: .title2).scaledFont(for: customFont)
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
    
}
