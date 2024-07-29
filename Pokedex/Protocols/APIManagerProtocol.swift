//
//  APIManagerProtocol.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 09/01/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

protocol APIManagerProtocol {
    
    func fetchPokeTypes(completion: @escaping (Result<PokeTypeModel, Error>)-> Void)
    func fetchPokemonsForType(url: String, completion: @escaping (Result<PokemonListModel, Error>)-> Void)
    func fetchPokemonDetails(url: String, completion: @escaping (Result<PokemonDetailsModel, Error>) -> Void)
    func fetchData(from url: String, completion: @escaping (Data?) -> Void)
}
