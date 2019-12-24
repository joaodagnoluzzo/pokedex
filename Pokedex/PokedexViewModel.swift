//
//  PokedexViewModel.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 23/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation


final class PokedexViewModel {

    let apiManager = APIManager()
    
    func retrievePokeTypes(completion: @escaping (Result<[PokeTypeUrl], Error>) -> Void){
        
        self.apiManager.fetchPokeTypes { results in
            switch results{
            case .success(let data):
                completion(.success(data.results))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func retrievePokemonList(typeUrl: String, completion: @escaping (Result<[PokeUrl], Error>) -> Void){
        
        self.apiManager.fetchPokemonsForType(url: typeUrl) { (results) in
            switch results {
            case .success(let data):
                completion(.success(self.parseTypeDetailsIntoPokemonList(data: data)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func parseTypeDetailsIntoPokemonList(data: PokeTypeDetail) -> [PokeUrl]{
        
        var listOfPokeUrls = [PokeUrl]()
        
        for pokePreview in data.pokemon {
            listOfPokeUrls.append(pokePreview.pokemon)
        }
        
        return listOfPokeUrls
    }
}
