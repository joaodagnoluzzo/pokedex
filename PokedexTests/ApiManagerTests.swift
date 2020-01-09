//
//  ApiManagerTests.swift
//  ApiManagerTests
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 23/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import XCTest
@testable import Pokedex

class ApiManagerTests: XCTestCase {

    var sut: APIManager!
    var networkSession: NetworkSessionMock!
    
    override func setUp() {
        super.setUp()
        networkSession = NetworkSessionMock()
    }

    override func tearDown() {
        networkSession = nil
        sut = nil
        super.tearDown()
    }

    func testApiCallEmptyTypeList() {
        
        self.networkSession.data = "{\"count\":0, \"results\":[]}".data(using: .utf8)!
        self.networkSession.error = nil
        
        let promise = expectation(description: "Result count is zero")
        var pokeType: PokeType?
        var error: Error?
        sut = APIManager(session: networkSession)

        sut.fetchPokeTypes { (results) in
            switch results{
            case .success(let pokeTypeResponse):
                pokeType = pokeTypeResponse
            case .failure(let responseError):
                error = responseError
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 3.0)
        
        XCTAssertNil(error)
        XCTAssertNotNil(pokeType)
        XCTAssertEqual(pokeType?.count, 0, "Zero results should be returned")
    }
    
}
