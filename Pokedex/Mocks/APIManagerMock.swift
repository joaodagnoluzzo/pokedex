//
//  APIManagerMock.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 09/01/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

final class APIManagerMock : APIManagerProtocol {
    
    var pokeType: PokeTypeModel?
    var pokeTypeDetail: PokemonListModel?
    var pokemon: PokemonDetailsModel?
    var imageData: Data?
    var error: NetworkError = .invalidaData
    
    func fetchPokeTypes(completion: @escaping (Result<PokeTypeModel, NetworkError>) -> Void) {
    
        if let pokeType = pokeType {
            completion(.success(pokeType))
        } else {
            completion(.failure(error))
        }
    }
    
    func fetchPokemonsForType(url: String, completion: @escaping (Result<PokemonListModel, NetworkError>) -> Void) {
        
        if let pokeTypeDetail = pokeTypeDetail {
            completion(.success(pokeTypeDetail))
        } else {
            completion(.failure(error))
        }
    }
    
    func fetchPokemonDetails(url: String, completion: @escaping (Result<PokemonDetailsModel, NetworkError>) -> Void) {
        if let pokemon = pokemon {
            completion(.success(pokemon))
        } else {
            completion(.failure(error))
        }
    }
    
    func fetchData(from url: String, completion: @escaping (Data?) -> Void) {
        if let imageData = imageData {
            completion(imageData)
        } else {
            completion(nil)
        }
    }
}
