//
//  UINavigationBarAppearence+Extensions.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 28/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit


extension UINavigationBarAppearance {
    
    static func customAppearence() -> UINavigationBarAppearance {
        let appearence = UINavigationBarAppearance()
        
        let titleTextAttributes = setupStrokeAttributes(
            font: UIFont.customTitleFont(size: Constants.PokeTypes.titleSize),
            strokeWidth: Constants.PokeTypes.fontStrokeWidth,
            insideColor: UIColor(hex: Constants.UI.Colors.white),
            strokeColor: UIColor(hex: Constants.UI.Colors.black)
        )
        
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = UIColor(hex: Constants.UI.Colors.red)
        appearence.titleTextAttributes = titleTextAttributes

        return appearence
    }
    
    private static func setupStrokeAttributes(font: UIFont, strokeWidth: Float, insideColor: UIColor, strokeColor: UIColor) -> [NSAttributedString.Key: Any]{
        return [
            .strokeColor : strokeColor,
            .foregroundColor : insideColor,
            .strokeWidth : -strokeWidth,
            .font : font
        ]
    }
}
