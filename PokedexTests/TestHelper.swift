//
//  TestHelper.swift
//  PokedexTests
//
//  Created by João Pedro C. D'Agnoluzzo on 28/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

class TestHelper {
    
    
    static func pokeTypesResult() -> Data {
        let data = """
            {
              "count": 3,
              "next": "https://pokeapi.co/api/v2/type?offset=20&limit=1",
              "previous": null,
              "results": [
                {
                  "name": "normal",
                  "url": "https://pokeapi.co/api/v2/type/1/"
                },
                {
                  "name": "fighting",
                  "url": "https://pokeapi.co/api/v2/type/2/"
                },
                {
                  "name": "flying",
                  "url": "https://pokeapi.co/api/v2/type/3/"
                }
              ]
            }
        """.data(using: .utf8)
        
        return data!
    }
}
