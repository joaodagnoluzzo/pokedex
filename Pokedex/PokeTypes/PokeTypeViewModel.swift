//
//  PokeTypesViewModel.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 26/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation


class PokeTypeViewModel {

    private var apiManager: APIManagerProtocol
    private var pokeTypeList: [PokeTypeUrl] = []
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func retrievePokeTypes(completion: @escaping (Error?) -> ()) {
        self.apiManager.fetchPokeTypes { [weak self] result in
            switch result {
            case .success(let data):
                self?.pokeTypeList = self?.formatTypes(list: data.results) ?? []
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    private func formatTypes(list: [PokeTypeUrl]) -> [PokeTypeUrl]{
        return list.map { pokeType in
            return PokeTypeUrl(name: pokeType.name.capitalizeFirstLetter(), url: pokeType.url)
        }
    }
    
    func pokeTypeAt(index: Int) -> PokeTypeUrl {
        return self.pokeTypeList[index]
    }
    
    func pokeTypeCount() -> Int {
        return self.pokeTypeList.count
    }
    
}
