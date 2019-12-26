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
                completion(.success(self.formatTypes(list: data.results)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func formatTypes(list: [PokeTypeUrl]) -> [PokeTypeUrl]{
        var listWithFormattedPokeTypes = [PokeTypeUrl]()
        for pokeType in list {
            let newType = PokeTypeUrl(name: pokeType.name.capitalizeFirstLetter(), url: pokeType.url)
            listWithFormattedPokeTypes.append(newType)
        }
        return listWithFormattedPokeTypes
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
    
    private func formatPokemonList(list: [PokeUrl]) -> [PokeUrl]{
        var listWithFormattedNames = [PokeUrl]()
        for pokemon in list {
            let newPokemon = PokeUrl(name: pokemon.name.capitalizeWordWithDashSeparator(), url: pokemon.url)
            listWithFormattedNames.append(newPokemon)
        }
        return listWithFormattedNames
    }

    private func parseTypeDetailsIntoPokemonList(data: PokeTypeDetail) -> [PokeUrl]{
        var listOfPokeUrls = [PokeUrl]()
        for pokePreview in data.pokemon {
            listOfPokeUrls.append(pokePreview.pokemon)
        }
        listOfPokeUrls = self.formatPokemonList(list: listOfPokeUrls)
        return listOfPokeUrls
    }
    
    func retrievePokemonDetails(pokemonUrl: String, completion: @escaping (Result<Pokemon, Error>) -> Void){
        
        self.apiManager.fetchPokemonDetails(url: pokemonUrl) { (results) in
            switch results {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func formatPokemonHeight(height: Int) -> String {
        let heightValue:Double = Double(height) * 0.1
        return String(format: "%.1f m", heightValue)
    }
    
    func formatPokemonWeight(weight: Int) -> String {
        let weightValue:Double = Double(weight) * 0.1
        return String(format: "%.1f Kg", weightValue)
    }
    
    func formatAbilities(abilities: [Abilities]) -> String {
        var formattedText = ""
        for item in abilities {
            let formattedAbilityName = item.ability.name.capitalizeWordWithDashSeparator()
            formattedText += "\(formattedAbilityName)\n"
        }
        return formattedText
    }
}
