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

}
