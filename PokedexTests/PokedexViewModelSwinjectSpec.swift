//
//  PokedexViewModelSwinjectSpec.swift
//  PokedexTests
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 13/01/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Quick
import Nimble
import Swinject

@testable import Pokedex

class PokedexViewModelSwinjectSpec: QuickSpec {
    
    override func spec() {
        
        
        let container = Container()
        
        var sut: PokedexViewModel!
        var apiManager: APIManagerMock!
        
        beforeEach {
            sut = PokedexViewModel()
            apiManager = APIManagerMock()
            
            
            container.register(Sprites.self) { _ in .init(frontDefault: "https://pokeapi/pikachu_sprite.png")}
            container.register(Pokemon.self) { resolver in
                let abilities = [Abilities(ability: Ability(name: "Ability 1", url: ""), is_hidden: false, slot: 1), Abilities(ability: Ability(name: "Ability 2", url: ""), is_hidden: false, slot: 2)]
                let sprites = resolver.resolve(Sprites.self)!
                
                return Pokemon(abilities: abilities, name: "Pikachu", weight: 40, sprites: sprites, height: 6)
            }
            
            container.register(PokeType.self) { _ in
                let types = [PokeTypeUrl(name: "Fire", url: ""), PokeTypeUrl(name: "Water", url: "")]
                return PokeType(count: types.count, results: types)
            }
            
            container.register(PokeTypeDetail.self) { _ in
                let pokePreviewCharmander = PokemonPreview(pokemon: PokeUrl(name: "Charmander", url: "https://pokeapi.co/charmander"))
                let pokePreviewCharizard = PokemonPreview(pokemon: PokeUrl(name: "Charizard", url: "https://pokeapi.co/charizard"))
                return PokeTypeDetail(name: "Fire", pokemon: [pokePreviewCharmander, pokePreviewCharizard])
            }
            
        }
        
        afterEach {
            sut = nil
            apiManager = nil
            container.removeAll()
        }
        
        describe("requesting"){
            context("a list of pokemon types"){
                it("should return all pokemon types"){
                    
                    apiManager.pokeType = container.resolve(PokeType.self)
                    
                    sut = PokedexViewModel(apiManager: apiManager)
                    
                    waitUntil { (done) in
                        sut.retrievePokeTypes { (results) in
                            switch results {
                            case .success(let typesArray):
                                expect(typesArray.count).to(equal(2))
                            case .failure(let responseError):
                                expect(responseError).to(beNil())
                            }
                            done()
                        }
                    }
                }
            }
            
            context("a list of pokemons for a given type") {
                it("should return all the pokemons of that type"){
                    
                    apiManager.pokeTypeDetail = container.resolve(PokeTypeDetail.self)
                    sut = PokedexViewModel(apiManager: apiManager)
                    
                    waitUntil { (done) in
                        sut.retrievePokemonList(typeUrl: "") { (results) in
                            switch results {
                            case .success(let pokemonList):
                                expect(pokemonList.count).to(equal(2))
                            case .failure(let responseError):
                                expect(responseError).to(beNil())
                            }
                            done()
                        }
                    }
                    
                }
            }
            
            context("details of a pokemon"){
                it("should return its name, weight, height, sprites and abilities"){
                    
                    apiManager.pokemon = container.resolve(Pokemon.self)
                    sut = PokedexViewModel(apiManager: apiManager)
                    
                    waitUntil { (done) in
                        sut.retrievePokemonDetails(pokemonUrl: "") { (results) in
                            switch results {
                            case .success(let pokemon):
                                expect(pokemon.name).to(equal("Pikachu"))
                                expect(pokemon.abilities.count).to(equal(2))
                                expect(pokemon.weight).to(equal(40))
                                expect(pokemon.sprites.frontDefault).notTo(beEmpty())
                                expect(pokemon.height).to(equal(6))
                            case .failure(let responseError):
                                expect(responseError).to(beNil())
                            }
                            done()
                        }
                    }
                }
            }
        }
        
        describe("formatting"){
            context("a pokemon height") {
                it("should return a formatted height"){
                    sut = PokedexViewModel()
                    var formatted: String
                    formatted = sut.formatPokemonHeight(height: container.resolve(Pokemon.self)!.height)
                    
                    expect(formatted).to(equal("0.6 m"))
                }
            }
            
            context("a pokemon weight") {
                it("should return a formatted weight") {
                    sut = PokedexViewModel()
                    var formatted: String
                    formatted = sut.formatPokemonWeight(weight: container.resolve(Pokemon.self)!.weight)
                    
                    expect(formatted).to(equal("4.0 Kg"))
                }
            }
        }
    }

}
