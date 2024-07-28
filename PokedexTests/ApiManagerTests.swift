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
            context("when fetchint poketypes and there's no results") {
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
                    expect(pokeType?.results.count).to(equal(0))
                }
            }
            
            context("when fetching poketypes and there's a list of results") {
                beforeEach {
                    networkSession.data = TestHelper.pokeTypesResult()
                    networkSession.error = nil
                }
                
                it("should return the a list of decoded PokeTypeModel") {
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
                    expect(pokeType?.count).to(equal(3))
                    expect(pokeType?.results.count).to(equal(3))
                }
            }
        }
    }
}
