//
//  APIManagerMock.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 09/01/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

final class APIManagerMock : APIManagerProtocol{
    
    var pokeType: PokeTypeModel?
    var pokeTypeDetail: PokemonDetailsModel?
    var pokemon: PokemonModel?
    var error: Error = NSError(domain: "APIManagerMock",code: 0, userInfo: nil)
    
    func fetchPokeTypes(completion: @escaping (Result<PokeTypeModel, Error>) -> Void) {
    
        if let pokeType = pokeType {
            completion(.success(pokeType))
        } else {
            completion(.failure(error))
        }
    }
    
    func fetchPokemonsForType(url: String, completion: @escaping (Result<PokemonDetailsModel, Error>) -> Void) {
        
        if let pokeTypeDetail = pokeTypeDetail {
            completion(.success(pokeTypeDetail))
        } else {
            completion(.failure(error))
        }
    }
    
    func fetchPokemonDetails(url: String, completion: @escaping (Result<PokemonModel, Error>) -> Void) {
        if let pokemon = pokemon {
            completion(.success(pokemon))
        } else {
            completion(.failure(error))
        }
    }
    
}
