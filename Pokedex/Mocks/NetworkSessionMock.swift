//
//  NetworkSessionMock.swift
//  PokedexTests
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 09/01/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

final class NetworkSessionMock : NetworkSession {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func loadData(requestUrl: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        return completionHandler(data, response, error)
    }
}
