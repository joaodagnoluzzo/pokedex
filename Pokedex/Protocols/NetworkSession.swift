//
//  NetworkSession.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 09/01/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

protocol NetworkSession {
    
    func loadData(requestUrl: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}
