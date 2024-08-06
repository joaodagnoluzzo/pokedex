//
//  NetworkError.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 29/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

enum NetworkError: Error {
    case invalidUrl
    case fetchData(String)
    case decodeData(String)
    case invalidaData
}
