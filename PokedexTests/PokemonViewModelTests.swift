//
//  PokemonViewModelTests.swift
//  PokedexTests
//
//  Created by João Pedro C. D'Agnoluzzo on 28/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Quick
import Nimble

@testable import Pokedex

class PokemonViewModelTests: QuickSpec {
    
    override class func spec() {
        
        var apiManager: APIManagerMock!
        var viewModel: PokemonViewModel!
        var pokeTypeUrl: PokeTypeUrl!
        
        beforeEach {
            pokeTypeUrl = PokeTypeUrl(name: "Fire", url: "fire.com")
            apiManager = APIManagerMock()
            viewModel = PokemonViewModel(apiManager: apiManager, type: pokeTypeUrl)
        }
        
        afterEach {
            apiManager = nil
            viewModel = nil
            pokeTypeUrl = nil
        }
        
        describe("initializing view model") {
            context("when creating object") {
                it("should initialize data as en empty list") {
                    expect(viewModel.pokemonCount()).to(equal(0))
                }
            }
        }
        
        describe("acessing data") {
            context("when viewModel is called asking for title") {
                it("should return the title") {
                    let expectedTitle = "Fire"
                    expect(viewModel.getTitle()).to(equal(expectedTitle))
                }
            }
        }
        
        describe("fetching types") {
            context("when api manager returns error") {
                it("should define type list as empty") {

                    var error: Error?

                    waitUntil { (done) in
                        viewModel.retrievePokemonList(completion: { responseError in
                            error = responseError
                            done()
                        })
                    }

                    expect(error).toNot(beNil())
                    expect(viewModel.pokemonCount()).to(equal(0))
                }
            }
            
            context("when api manager return a list of PokemonDetails") {
                it("should populate list of pokemonUrls") {
                
                    let expectedName = "Pidgey"
                    
                    apiManager.pokeTypeDetail = PokemonListModel(
                        name: "Fire",
                        pokemon: [
                            PokemonPreview(pokemon: PokeUrl(name: "Raichu", url: "raichu.com")),
                            PokemonPreview(pokemon: PokeUrl(name: "Pidgey", url: "pidgey.com"))
                        ]
                    )
                    
                    var error: Error?
                    
                    waitUntil { done in
                        viewModel.retrievePokemonList { responseError in
                            error = responseError
                            done()
                        }
                    }
                    
                    expect(error).to(beNil())
                    expect(viewModel.pokemonCount()).to(equal(2))
                    expect(viewModel.pokemonAt(index: 1).name).to(equal(expectedName))
                }
            }
        }
    }
    
}
