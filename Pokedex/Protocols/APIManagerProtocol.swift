//
//  APIManagerProtocol.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 09/01/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

protocol APIManagerProtocol {
    
    func fetchPokeTypes(completion: @escaping (Result<PokeType, Error>)-> Void)
    func fetchPokemonsForType(url: String, completion: @escaping (Result<PokeTypeDetail, Error>)-> Void)
    func fetchPokemonDetails(url: String, completion: @escaping (Result<Pokemon, Error>) -> Void)
}
