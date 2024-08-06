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
    
    func fetchPokeTypes(completion: @escaping (Result<PokeTypeModel, NetworkError>)-> Void) {
        let requestHttp = Constants.API.baseUrl + Constants.API.Endpoints.type
        fetchAndDecodeData(from: requestHttp, completion: completion)
    }
    
    func fetchPokemonsForType(url: String, completion: @escaping (Result<PokemonListModel, NetworkError>)-> Void){
        fetchAndDecodeData(from: url, completion: completion)
    }
    
    func fetchPokemonDetails(url: String, completion: @escaping (Result<PokemonDetailsModel, NetworkError>) -> Void){
        fetchAndDecodeData(from: url, completion: completion)
    }
    
    func fetchData(from url: String, completion: @escaping (Data?) -> Void) {
        guard let urlRequest = URL(string: url) else {
            completion(nil)
            return
        }
        
        self.session.loadData(requestUrl: urlRequest) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  error == nil
            else {
                completion(nil)
                return
            }
            
            completion(data)
        }
    }
    
    private func fetchAndDecodeData<T:Decodable>(from url: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let requestUrl = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        self.session.loadData(requestUrl: requestUrl) { data, response, error in
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  error == nil
            else {
                completion(.failure(.fetchData(error?.localizedDescription ?? Constants.Error.noMessage)))
                return
            }
            
            completion(self.decodeData(data: data))
        }
    }
    
    private func decodeData<T:Decodable>(data: Data) -> Result<T, NetworkError> {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(.decodeData(error.localizedDescription))
        }
    }
}
