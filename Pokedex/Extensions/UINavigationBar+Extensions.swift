//
//  UINavigationBar+Extensions.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 28/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    static func customizeNavigationBar() {
        
        let appearence = UINavigationBarAppearance.customAppearence()
        appearance().standardAppearance = appearence
        appearance().scrollEdgeAppearance = appearence
        appearance().tintColor = UIColor(hex: Constants.UI.Colors.white)
    }
    
    
}
