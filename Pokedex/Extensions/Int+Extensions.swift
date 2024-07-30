//
//  Int+Extensions.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 27/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

extension Int {
    
    private var conversionFactor: Double { 0.1 }
    
    func toFormattedWeight() -> String {
        return String(format: "%.1f Kg", Double(self) * conversionFactor)
    }
    
    func toFormattedHeight() -> String {
        return String(format: "%.1f m", Double(self) * conversionFactor)
    }
    
}
