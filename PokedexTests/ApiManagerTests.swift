//
//  ApiManagerTests.swift
//  ApiManagerTests
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 23/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Quick
import Nimble

@testable import Pokedex

class ApiManagerTests: QuickSpec {
    
    override class  func spec() {
        
        var sut: APIManager!
        var networkSession: NetworkSessionMock!
        
        beforeEach {
            networkSession = NetworkSessionMock()
            sut = APIManager(session: networkSession)
        }
        
        afterEach {
            networkSession = nil
            sut = nil
        }
        
        describe("requesting") {
            context("when fetching a list of pokemon types") {
                beforeEach {
                    networkSession.data = "{\"count\":0, \"results\":[]}".data(using: .utf8)
                    networkSession.error = nil
                }
                
                it("should return an empty list") {
                    var pokeType: PokeTypeModel?
                    var error: Error?
                    
                    waitUntil(timeout: .seconds(3)) { (done) in
                        sut.fetchPokeTypes { (result) in
                            switch result {
                            case .success(let pokeTypeResponse):
                                pokeType = pokeTypeResponse
                            case .failure(let responseError):
                                error = responseError
                            }
                            done()
                        }
                    }
                    
                    expect(error).to(beNil())
                    expect(pokeType).toNot(beNil())
                    expect(pokeType?.count).to(equal(0))
                }
            }
        }
    }
}
