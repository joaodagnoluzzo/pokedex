//
//  PokemonModel.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 23/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

struct PokemonDetailsModel: Decodable {
    
    let abilities: [Abilities]
    let name: String
    let weight: Int
    let sprites: Sprites
    let height: Int
}

extension PokemonDetailsModel {
    init() {
        abilities = []
        name = ""
        weight = 0
        sprites = Sprites(frontDefault: "")
        height = 0
    }
}

struct Abilities: Decodable {
    let ability: Ability
    let is_hidden: Bool
    let slot: Int
}

struct Ability: Decodable {
    let name: String
    let url: String
}

struct Sprites: Decodable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
