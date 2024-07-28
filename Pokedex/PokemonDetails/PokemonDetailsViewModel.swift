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
    var pokemonUrl: PokeUrl?
    var pokemon: PokemonModel = PokemonModel()
    
    
    init(apiManager: APIManagerProtocol = APIManager(), pokeUrl: PokeUrl) {
        self.apiManager = apiManager
        self.pokemonUrl = pokeUrl
    }
    
    func retrievePokemonDetails(pokemonUrl: String, completion: @escaping (Result<PokemonModel, Error>) -> Void){
        
        self.apiManager.fetchPokemonDetails(url: pokemonUrl) { (result) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func retrievePokemonDetailsV2(completion: @escaping (Error?) -> ()) {
        guard let pokemonUrl = pokemonUrl else {
            completion(PokemonModelError(info: Constants.Error.pokeUrlIsNil))
            return
        }
        
        self.apiManager.fetchPokemonDetails(url: pokemonUrl.url) { [weak self] result in
            switch result {
            case .success(let data):
                self?.pokemon = data
                completion(nil)
            case .failure(let error):
                self?.pokemon = PokemonModel()
                completion(error)
            }
        }
    }
    
    func retrievePokemonImage(imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        
        self.apiManager.fetchData(from: imageUrl) { data in
            guard let data = data else { return }
            
            completion(UIImage(data: data))
        }
    }
    
    func getFormattedWeight() -> String {
        return pokemon.weight.toFormattedHeight()
    }
    
    func getFormattedHeight() -> String {
        return pokemon.height.toFormattedHeight()
    }
    
    func getFormattedAbilities() -> String {
        return formatAbilities(pokemon.abilities)
    }
    
    func getImageUrl() -> String {
        return pokemon.sprites.frontDefault
    }
    
    private func formatAbilities(_ abilities: [Abilities]) -> String {
        var formattedText = ""
        for item in abilities {
            let formattedAbilityName = item.ability.name.toTitleCase()
            formattedText += "\(formattedAbilityName)\n"
        }
        return formattedText
    }
    
    func shareInfo() -> String {
        
//        var shareInfo = "*\(self.title ?? "")*\n"
//        shareInfo += "Weight: \(self.pokemonWeightLabel?.text ?? "")\n"
//        shareInfo += "Height: \(self.pokemonHeightLabel?.text ?? "")\n"
//        shareInfo += "Abilities:\n\(self.pokemonAbilitiesTextView?.text ?? "")"
        
        return ""
    }
}
