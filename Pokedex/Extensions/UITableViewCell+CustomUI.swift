//
//  UITableViewCell+CustomUI.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 26/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    func configureWithPokeballColors() {
        self.textLabel?.textColor = UIColor(hex: "#222224")
        self.backgroundColor = UIColor(hex: "#f0f0f0")
    }
    
    func configureWithPokemonFont() {
        self.textLabel?.font = UIFont(name: "PokemonGB", size: 17)
    }
}
