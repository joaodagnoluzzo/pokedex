//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 26/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

class PokemonViewModel {
    
    private var apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func retrievePokemonList(typeUrl: String, completion: @escaping (Result<[PokeUrl], Error>) -> Void) {
        
        self.apiManager.fetchPokemonsForType(url: typeUrl) { result in
            switch result {
            case .success(let data):
                completion(.success(self.parseTypeDetailsIntoPokemonList(details: data)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func parseTypeDetailsIntoPokemonList(details: PokemonDetailsModel) -> [PokeUrl] {
        return details.pokemon.map { preview in
            preview.pokemon
        }.map { pokeUrl in
            PokeUrl(name: pokeUrl.name.toTitleCase(), url: pokeUrl.url)
        }
    }
    
}
