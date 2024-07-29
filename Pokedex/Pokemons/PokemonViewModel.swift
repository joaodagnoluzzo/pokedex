//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 26/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

class PokemonViewModel {
    
    private var pokeType: PokeTypeUrl
    private var apiManager: APIManagerProtocol
    private var pokemonList: [PokeUrl] = []
    
    init(apiManager: APIManagerProtocol = APIManager(), type: PokeTypeUrl) {
        self.apiManager = apiManager
        pokeType = type
    }
    
    func retrievePokemonList(completion: @escaping (Error?) -> ()) {
        self.apiManager.fetchPokemonsForType(url: pokeType.url) { [weak self] result in
            switch result {
            case .success(let data):
                self?.pokemonList = self?.parseTypeDetailsIntoPokemonList(details: data) ?? []
                completion(nil)
            case .failure(let error):
                self?.pokemonList = []
                completion(error)
            }
        }
    }
    
    private func parseTypeDetailsIntoPokemonList(details: PokemonListModel) -> [PokeUrl] {
        return details.pokemon.map { preview in
            preview.pokemon
        }.map { pokeUrl in
            PokeUrl(name: pokeUrl.name.toTitleCase(), url: pokeUrl.url)
        }
    }
    
    func getTitle() -> String {
        return pokeType.name
    }
    
    func pokemonAt(index: Int) -> PokeUrl {
        return self.pokemonList[index]
    }
    
    func pokemonCount() -> Int {
        return self.pokemonList.count
    }
}
