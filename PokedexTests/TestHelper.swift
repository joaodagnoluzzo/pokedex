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
    
    static func pokemonListResult() -> Data {
        let data = """
            {
              "name": "fighting",
              "pokemon": [
                {
                  "pokemon": {
                    "name": "mankey",
                    "url": "https://pokeapi.co/api/v2/pokemon/56/"
                  },
                  "slot": 1
                },
                {
                  "pokemon": {
                    "name": "primeape",
                    "url": "https://pokeapi.co/api/v2/pokemon/57/"
                  },
                  "slot": 1
                },
                {
                  "pokemon": {
                    "name": "poliwrath",
                    "url": "https://pokeapi.co/api/v2/pokemon/62/"
                  },
                  "slot": 2
                },
                {
                  "pokemon": {
                    "name": "machop",
                    "url": "https://pokeapi.co/api/v2/pokemon/66/"
                  },
                  "slot": 1
                }
              ]
            }
        """.data(using: .utf8)
        
        return data!
    }
    
    static func pokemonDetails() -> Data {
        let data = """
            {
              "abilities": [
                {
                  "ability": {
                    "name": "vital-spirit",
                    "url": "https://pokeapi.co/api/v2/ability/72/"
                  },
                  "is_hidden": false,
                  "slot": 1
                },
                {
                  "ability": {
                    "name": "anger-point",
                    "url": "https://pokeapi.co/api/v2/ability/83/"
                  },
                  "is_hidden": false,
                  "slot": 2
                },
                {
                  "ability": {
                    "name": "defiant",
                    "url": "https://pokeapi.co/api/v2/ability/128/"
                  },
                  "is_hidden": true,
                  "slot": 3
                }
              ],
              "height": 10,
              "held_items": [],
              "id": 57,
              "is_default": true,
              "location_area_encounters": "https://pokeapi.co/api/v2/pokemon/57/encounters",
              "moves": [],
              "name": "primeape",
              "order": 96,
              "past_abilities": [],
              "past_types": [],
              "species": {
                "name": "primeape",
                "url": "https://pokeapi.co/api/v2/pokemon-species/57/"
              },
              "sprites": {
                "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/57.png",
                "back_female": null,
                "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/57.png",
                "back_shiny_female": null,
                "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/57.png"
              },
              "weight": 320
            }
            """.data(using: .utf8)
        
        return data!
    }
}
