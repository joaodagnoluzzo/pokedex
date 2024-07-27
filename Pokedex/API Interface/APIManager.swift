//
//  APIManager.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 24/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation


final class APIManager: APIManagerProtocol {
    
    private let apiBaseUrl = "https://pokeapi.co/api/v2"
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchPokeTypes(completion: @escaping (Result<PokeTypeModel, Error>)-> Void) {
              
        let requestHttp = "\(apiBaseUrl)/type/"
        guard let requestURL = URL(string: requestHttp) else { return }
        
        self.session.loadData(requestUrl: requestURL, completionHandler: { (data, response, error) -> Void in
          
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                completion(.success(self.decodePokeType(data: data)))
            }
        })
    }
    
    private func decodePokeType(data: Data) -> PokeTypeModel{
        var pokeTypes = PokeTypeModel()
        do {
            let result = try JSONDecoder().decode(PokeTypeModel.self, from: data)
            pokeTypes = result
        } catch {
            print("JSON Decoding Error: \(error)")
        }
        return pokeTypes
    }
    
    func fetchPokemonsForType(url: String, completion: @escaping (Result<PokemonDetailsModel, Error>)-> Void){
        
        guard let requestUrl = URL(string:url) else { return }
        
        self.session.loadData(requestUrl: requestUrl, completionHandler: { (data, _, error) -> Void in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                completion(.success(self.decodePokeTypeDetails(data: data)))
            }
        })
    }
    
    private func decodePokeTypeDetails(data: Data) -> PokemonDetailsModel {
        var pokeTypeDetails = PokemonDetailsModel()
        do {
            let result = try JSONDecoder().decode(PokemonDetailsModel.self, from: data)
            pokeTypeDetails = result
        } catch {
            print("JSON Decoding Error: \(error)")
        }
        return pokeTypeDetails
    }
   
    func fetchPokemonDetails(url: String, completion: @escaping (Result<PokemonModel, Error>) -> Void){
        
        guard let requestUrl = URL(string: url) else { return }
        
        self.session.loadData(requestUrl: requestUrl, completionHandler: { (data, _, error) -> Void in
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                completion(.success(self.decodePokemonDetails(data: data)))
            }
        })
    }
    
    private func decodePokemonDetails(data: Data) -> PokemonModel {
        var pokemon = PokemonModel()
        do {
            let result = try JSONDecoder().decode(PokemonModel.self, from: data)
            pokemon = result
        } catch {
            print("JSON Decoding Error: \(error)")
        }
        return pokemon
    }
    
}
