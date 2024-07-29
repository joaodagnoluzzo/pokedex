//
//  PokeTypeViewModelTests.swift
//  PokedexTests
//
//  Created by João Pedro C. D'Agnoluzzo on 28/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Quick
import Nimble

@testable import Pokedex

class PokeTypeViewModelTests: QuickSpec {
    
    override class func spec() {
        
        var viewModel: PokeTypeViewModel!
        var apiManager: APIManagerMock!
        
        beforeEach {
            apiManager = APIManagerMock()
            viewModel = PokeTypeViewModel(apiManager: apiManager)
        }
        
        afterEach {
            apiManager = nil
            viewModel = nil
        }
        
        describe("initializing view model") {
            context("when creating object") {
                it("should initialize data as en empty list") {
                    expect(viewModel.pokeTypeCount()).to(equal(0))
                }
            }
        }
        
        describe("fetching types") {
            context("when api manager returns error") {
                it("should define type list as empty") {

                    var error: Error?

                    waitUntil { (done) in
                        viewModel.retrievePokeTypes(completion: { responseError in
                            error = responseError
                            done()
                        })
                    }

                    expect(error).toNot(beNil())
                    expect(viewModel.pokeTypeCount()).to(equal(0))
                }
            }
            
            context("when api manager return a list of pokeTypes") {
                it("should populate list of pokeTypes") {
                
                    let expectedName = "Pikachu"
                    
                    apiManager.pokeType = PokeTypeModel(count: 2, results: [PokeTypeUrl(name: "Pikachu", url: "pikachu.com"), PokeTypeUrl(name: "Charmeleon", url: "charmeleon.com")])
                    
                    var error: Error?
                    
                    waitUntil { done in
                        viewModel.retrievePokeTypes { responseError in
                            error = responseError
                            done()
                        }
                    }
                    
                    expect(error).to(beNil())
                    expect(viewModel.pokeTypeCount()).to(equal(2))
                    expect(viewModel.pokeTypeAt(index: 0).name).to(equal(expectedName))
                }
            }
        }
    }
}
