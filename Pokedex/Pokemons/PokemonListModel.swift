//
//  PokemonListModel.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 23/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

struct PokemonListModel: Decodable {
    let name: String
    let pokemon: [PokemonPreview]
}

extension PokemonListModel {
    init(){
        name = ""
        pokemon = []
    }
}

struct PokemonPreview: Decodable {
    let pokemon: PokeUrl
}

struct PokeUrl: Decodable {
    let name: String
    let url: String
}
