//
//  PokemonDetailsViewModel.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 26/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation
import UIKit

class PokemonDetailsViewModel {
    
    private var apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func retrievePokemonDetails(pokemonUrl: String, completion: @escaping (Result<PokemonModel, Error>) -> Void){
        
        self.apiManager.fetchPokemonDetails(url: pokemonUrl) { (results) in
            switch results {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func retrievePokemonImage(imageUrl: String, completion: @escaping (UIImage?) -> Void) {
    
        self.apiManager.fetchData(from: imageUrl) { data in
            guard let data = data else { return }
            
            completion(UIImage(data: data))
        }
    }
    
}
