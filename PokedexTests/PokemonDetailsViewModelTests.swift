//
//  PokemonDetailsViewModelTests.swift
//  PokedexTests
//
//  Created by João Pedro C. D'Agnoluzzo on 28/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Quick
import Nimble

@testable import Pokedex

class PokemonDetailsViewModelTests: QuickSpec {
    
    override class func spec() {
        
        var apiManager: APIManagerMock!
        var viewModel: PokemonDetailsViewModel!
        var pokeUrl: PokeUrl!
        
        beforeEach {
            pokeUrl = PokeUrl(name: "Squirtle", url: "squirtle.com")
            apiManager = APIManagerMock()
            viewModel = PokemonDetailsViewModel(apiManager: apiManager, pokeUrl: pokeUrl)
        }
        
        afterEach {
            pokeUrl = nil
            apiManager = nil
            viewModel = nil
        }
        
        describe("viewModel initialization") {
            context("when initializing the viewModel") {
                it("should set the pokeUrl as received in the init method") {
                    let expectedName = "Squirtle"
                    expect(viewModel).toNot(beNil())
                    expect(viewModel.getPokemonName()).to(equal(expectedName))
                }
            }
        }
        
        describe("fetching pokemon") {
            context("when fetching pokemon details and receive error") {
                it("should raise an error and set empty data") {
                    
                    var error: Error?
                    
                    waitUntil { done in
                        viewModel.retrievePokemonDetails { responseError in
                            error = responseError
                            done()
                        }
                    }
                    
                    expect(error).toNot(beNil())
                    expect(viewModel.getImageUrl()).to(beEmpty())
                }
            }
            
            context("when fetching pokemon details and receive data") {
                it("should fill pokemon details") {
                    
                    apiManager.pokemon = PokemonModel(abilities: [Abilities(ability: Ability(name: "Water Canon", url: "ability.com"), is_hidden: false, slot: 1)], name: "Blastoise", weight: 210, sprites: Sprites(frontDefault: "blastoise.png.com"), height: 182)
                    
                    var error: Error?
                    
                    waitUntil { done in
                        viewModel.retrievePokemonDetails { responseError in
                            error = responseError
                            done()
                        }
                    }
                    
                    expect(error).to(beNil())
                    expect(viewModel.getImageUrl()).toNot(beEmpty())
                    expect(viewModel.getFormattedWeight()).toNot(beEmpty())
                }
                
                it("should provide formatted data for height") {
                    let expectedHeight = "Height 1.8 m"
                    
                    apiManager.pokemon = PokemonModel(abilities: [Abilities(ability: Ability(name: "Water Canon", url: "ability.com"), is_hidden: false, slot: 1)], name: "Blastoise", weight: 210, sprites: Sprites(frontDefault: "blastoise.png.com"), height: 18)
                    
                    waitUntil { done in
                        viewModel.retrievePokemonDetails { _ in
                            done()
                        }
                    }
                    
                    expect(viewModel.getFormattedHeight()).to(equal(expectedHeight))
                }
                
                it("should provide formatted data for weight") {
                    let expectedWeight = "Weight 21.0 Kg"
                    
                    apiManager.pokemon = PokemonModel(abilities: [Abilities(ability: Ability(name: "Water Canon", url: "ability.com"), is_hidden: false, slot: 1)], name: "Blastoise", weight: 210, sprites: Sprites(frontDefault: "blastoise.png.com"), height: 18)
                    
                    waitUntil { done in
                        viewModel.retrievePokemonDetails { _ in
                            done()
                        }
                    }
                    
                    expect(viewModel.getFormattedWeight()).to(equal(expectedWeight))
                }
                
                it("should provide formatted data for abilities") {
                    let expectedAbilities = "Water Canon\nWater Tornado\n"
                    
                    apiManager.pokemon = PokemonModel(abilities: [Abilities(ability: Ability(name: "Water Canon", url: "ability.com"), is_hidden: false, slot: 1), Abilities(ability: Ability(name: "Water Tornado", url: "ability2.com"), is_hidden: false, slot: 2)], name: "Blastoise", weight: 210, sprites: Sprites(frontDefault: "blastoise.png.com"), height: 18)
                    
                    waitUntil { done in
                        viewModel.retrievePokemonDetails { _ in
                            done()
                        }
                    }
                    
                    expect(viewModel.getFormattedAbilities()).to(equal(expectedAbilities))
                }
            }
        }
        
        describe("fetching pokemon image") {
            context("when fetching pokemon image data and url is invalid") {
                it("should not provide image") {
                    
                    var image: UIImage?
                    
                    waitUntil { done in
                        viewModel.retrievePokemonImage(imageUrl: "asdas") { responseImage in
                            image = responseImage
                            done()
                        }
                    }
                    
                    expect(image).to(beNil())
                }
            }
        }
    }
}
