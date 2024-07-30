//
//  APIManager.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 24/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation


final class APIManager: APIManagerProtocol {
    
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchPokeTypes(completion: @escaping (Result<PokeTypeModel, Error>)-> Void) {
              
        let requestHttp = Constants.API.baseUrl + Constants.API.Endpoints.type
        guard let requestURL = URL(string: requestHttp) else {
            completion(.failure(APIError(info: Constants.Error.invalidUrl)))
            return
        }
        
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
    
    func fetchPokemonsForType(url: String, completion: @escaping (Result<PokemonListModel, Error>)-> Void){
        
        guard let requestUrl = URL(string:url) else {
            completion(.failure(APIError(info: Constants.Error.invalidUrl)))
            return
        }
        
        self.session.loadData(requestUrl: requestUrl, completionHandler: { (data, _, error) -> Void in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                completion(.success(self.decodePokeTypeDetails(data: data)))
            }
        })
    }
    
    private func decodePokeTypeDetails(data: Data) -> PokemonListModel {
        var pokeTypeDetails = PokemonListModel()
        do {
            let result = try JSONDecoder().decode(PokemonListModel.self, from: data)
            pokeTypeDetails = result
        } catch {
            print("JSON Decoding Error: \(error)")
        }
        return pokeTypeDetails
    }
   
    func fetchPokemonDetails(url: String, completion: @escaping (Result<PokemonDetailsModel, Error>) -> Void){
        
        guard let requestUrl = URL(string: url) else {
            completion(.failure(APIError(info: Constants.Error.invalidUrl)))
            return
        }
        
        self.session.loadData(requestUrl: requestUrl, completionHandler: { (data, _, error) -> Void in
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                completion(.success(self.decodePokemonDetails(data: data)))
            }
        })
    }
    
    private func decodePokemonDetails(data: Data) -> PokemonDetailsModel {
        var pokemon = PokemonDetailsModel()
        do {
            let result = try JSONDecoder().decode(PokemonDetailsModel.self, from: data)
            pokemon = result
        } catch {
            print("JSON Decoding Error: \(error)")
        }
        return pokemon
    }
    
    func fetchData(from url: String, completion: @escaping (Data?) -> Void) {
        guard let urlRequest = URL(string: url) else {
            completion(nil)
            return
        }
        
        self.session.loadData(requestUrl: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
}
