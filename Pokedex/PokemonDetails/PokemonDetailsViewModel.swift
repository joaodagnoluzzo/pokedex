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
    private var pokemonUrl: PokeUrl
    private var pokemon: PokemonDetailsModel = PokemonDetailsModel()
    
    
    init(apiManager: APIManagerProtocol = APIManager(), pokeUrl: PokeUrl) {
        self.apiManager = apiManager
        self.pokemonUrl = pokeUrl
    }
    
    func retrievePokemonDetails(completion: @escaping (Error?) -> ()) {
        self.apiManager.fetchPokemonDetails(url: pokemonUrl.url) { [weak self] result in
            switch result {
            case .success(let data):
                self?.pokemon = data
                completion(nil)
            case .failure(let error):
                self?.pokemon = PokemonDetailsModel()
                completion(error)
            }
        }
    }
    
    func retrievePokemonImage(imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        let defaultImage = UIImage(named: "defaultImage")
        if imageUrl.isEmpty {
            completion(defaultImage)
            return
        }
        
        self.apiManager.fetchData(from: imageUrl) { data in
            guard let data = data else {
                completion(defaultImage)
                return
            }
            completion(UIImage(data: data))
        }
    }
    
    func getPokemonName() -> String {
        return pokemonUrl.name
    }
    
    func getFormattedWeight() -> String {
        return pokemon.weight.toFormattedWeight()
    }
    
    func getFormattedHeight() -> String {
        return pokemon.height.toFormattedHeight()
    }
    
    func getFormattedAbilities() -> String {
        return formatAbilities(pokemon.abilities)
    }
    
    func getImageUrl() -> String {
        if let imageUrl = pokemon.sprites.frontDefault {
            return imageUrl
        } else {
            return String()
        }
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
        
        var shareInfo = "*\(getPokemonName())*\n"
        shareInfo += "Weight: \(getFormattedWeight())\n"
        shareInfo += "Height: \(getFormattedHeight())\n"
        shareInfo += "Abilities:\n\(getFormattedAbilities())"
        
        return ""
    }
}
