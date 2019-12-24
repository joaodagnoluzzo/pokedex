//
//  PokeType.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 23/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

struct PokeType: Decodable{
    let count: Int
    let results: [PokeTypeUrl]
}

extension PokeType {
    init() {
        count = 0
        results = []
    }
}

struct PokeTypeUrl: Decodable {
    let name: String
    let url: String
}


