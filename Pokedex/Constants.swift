//
//  Constants.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 27/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

struct Constants {
    
    struct API {
        static let baseUrl = "https://pokeapi.co/api/v2"
        
        struct Endpoints {
            static let type = "/type"
        }
    }
    
    struct UI {

        struct Colors {
            static let color1 = "#f0f0f0"
            static let color2 = "#222224"
            static let red = "#EF0000"
            static let white = "#EFEFEF"
            static let black = "#212123"
        }

        struct Font {
            static let bodyFont = ""
            static let titleFont = ""
        }
    }
}
