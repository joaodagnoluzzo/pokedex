//
//  URLSessionExtensions.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 09/01/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

extension URLSession: NetworkSession{
    
    func loadData(requestUrl: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: requestUrl) { (data, response, error) in
            completionHandler(data, response, error)
        }
        task.resume()
    }
    
}
