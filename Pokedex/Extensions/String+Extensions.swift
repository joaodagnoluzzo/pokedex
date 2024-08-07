//
//  String+Extensions.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 26/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

extension String {
    
    func capitalizeFirstLetter() -> String {
        return prefix(1).capitalized + self.dropFirst()
    }
    
    func toTitleCase() -> String {
        return self.split(separator: "-").map { substring in
            String(substring).capitalizeFirstLetter()
        }.joined(separator: " ")
    }
}
