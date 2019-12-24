//
//  APIManager.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 24/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation


final class APIManager {
    
    private let apiBaseUrl = "https://pokeapi.co/api/v2"
    
    func fetchPokeTypes(completion: @escaping (Result<PokeType, Error>)-> Void) {
              
        let requestHttp = "\(apiBaseUrl)/type/"
        guard let requestURL = URL(string: requestHttp) else { return }
        
        let task = URLSession.shared.dataTask(with: requestURL, completionHandler: { (data, response, error) -> Void in
          
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                completion(.success(self.decodePokeType(data: data)))
            }
        })
        task.resume()
    }
    
    private func decodePokeType(data: Data) -> PokeType{
        var pokeTypes = PokeType()
        do {
            let result = try JSONDecoder().decode(PokeType.self, from: data)
            pokeTypes = result
        } catch {
            print("JSON Decoding Error: \(error)")
        }
        return pokeTypes
    }
    
    func fetchPokemonsForType(url: String, completion: @escaping (Result<PokeTypeDetail, Error>)-> Void){
        
        guard let requestUrl = URL(string:url) else { return }
        
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                completion(.success(self.decodePokeTypeDetails(data: data)))
            }
        })
        task.resume()
    }
    
    private func decodePokeTypeDetails(data: Data) -> PokeTypeDetail {
        var pokeTypeDetails = PokeTypeDetail()
        do {
            let result = try JSONDecoder().decode(PokeTypeDetail.self, from: data)
            pokeTypeDetails = result
        } catch {
            print("JSON Decoding Error: \(error)")
        }
        return pokeTypeDetails
    }
   
    
}
