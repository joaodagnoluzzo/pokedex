//
//  PokedexViewModel.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 23/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation


final class PokedexViewModel {
    
    
    
    func fetchTypes(){
            
    //        let apiUrl = "https://pokeapi.co/api/v2/pokemon/16/"
    //        let apiUrl = "https://pokeapi.co/api/v2/type/1/"
            let apiUrl = "https://pokeapi.co/api/v2/type/"
            let requestURL = URL(string: apiUrl)!
            
            let task = URLSession.shared.dataTask(with: requestURL, completionHandler: { (data, response, error) -> Void in
                
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        if let data = data {
                            do {
                                
                                let result = try JSONDecoder().decode(PokeType.self, from: data)
                                print(result)
                                print("Http response status: 200 Success")
                            } catch {
                                print("JSON Error: \(error)")
                            }
                        }
                    case 400:
                        print("Http response status: 404 Bad Request")
                    default:
                        print("Http Response status: \(httpResponse.statusCode) Error")
                        if let error = error {
                            print("Error: \(error)")
                        }
                    }
                }
            })
            task.resume()
        }
}
