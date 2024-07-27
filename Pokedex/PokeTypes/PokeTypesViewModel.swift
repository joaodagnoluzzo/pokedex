//
//  PokeTypesViewModel.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 26/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation


class PokeTypesViewModel {

    private var apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func retrievePokeTypes(completion: @escaping (Result<[PokeTypeUrl], Error>) -> Void){
        
        self.apiManager.fetchPokeTypes { result in
            switch result {
            case .success(let data):
                completion(.success(self.formatTypes(list: data.results)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func formatTypes(list: [PokeTypeUrl]) -> [PokeTypeUrl]{
        return list.map { pokeType in
            return PokeTypeUrl(name: pokeType.name.capitalizeFirstLetter(), url: pokeType.url)
        }
    }
    
}
