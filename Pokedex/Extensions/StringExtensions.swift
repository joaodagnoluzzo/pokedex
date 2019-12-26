//
//  StringExtensions.swift
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
    
    mutating func fistLetterToUpperCase() {
        self = self.capitalizeFirstLetter()
    }
    
    func capitalizeWordWithDashSeparator() -> String {
        var result = ""
        let strArray = self.split(separator: "-")
        for i in 0..<strArray.count {
            let str = String(strArray[i])
            result += str.capitalizeFirstLetter()
            if(i < (strArray.count-1)){
                result += " "
            }
        }
        return result
    }
}
