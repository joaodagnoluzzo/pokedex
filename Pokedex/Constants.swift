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
    
    struct PokeTypes {
        static let title = "Pokemon Types"
        static let titleSize: CGFloat = 25
        static let fontStrokeWidth: Float = 4
    }
    
    struct TableView {
        static let rowSize: CGFloat = 50
    }
    
    struct UI {

        struct Colors {
            static let black = "#222224"
            static let red = "#EF0000"
            static let white = "#EFEFEF"
        }

        struct Font {
            static let bodyFont = "Pokemon GB"
            static let titleFont = "Pokemon Solid"
        }
    }
    
    struct Error {
        static let title = "Oops"
        static let pokemonNotFound = "It seems we lost our pokémons! Check your Pokenet connection."
        static let emptyPokemonList = "Sounds like pokémon of this type are yet to be discovered!\nGotta catch 'em all!"
        static let pokemonEscaped = "Couldn't catch this {pokemon})"
        static let pokeTypesNotFound = "PokeTypes not found! Check your Pokenet connection."
        static let acceptLabel = "Ok"
        static let typeIsNil = "Type is nil"
    }
}
