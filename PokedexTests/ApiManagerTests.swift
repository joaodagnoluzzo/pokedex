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
        
        var apiManager: APIManager!
        var networkSession: NetworkSessionMock!
        
        beforeEach {
            networkSession = NetworkSessionMock()
            apiManager = APIManager(session: networkSession)
        }
        
        afterEach {
            networkSession = nil
            apiManager = nil
        }
        
        describe("requesting") {
            context("when fetching poketypes and there's no results") {
                it("should return an empty list") {
                    networkSession.response = TestHelper.response200()
                    networkSession.data = "{\"count\":0, \"results\":[]}".data(using: .utf8)
                    networkSession.error = nil
                
                    
                    var pokeType: PokeTypeModel?
                    var error: NetworkError?
                    
                    waitUntil { (done) in
                        apiManager.fetchPokeTypes { (result) in
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
            
            context("when fetching poketypes and the result is an empty json") {
                it("should return error") {
                    
                    networkSession.response = TestHelper.response200()
                    networkSession.data = "{}".data(using: .utf8)
                    networkSession.error = nil
                
                    
                    var pokeType: PokeTypeModel?
                    var error: NetworkError?
                    
                    waitUntil { (done) in
                        apiManager.fetchPokeTypes { (result) in
                            switch result {
                            case .success(let pokeTypeResponse):
                                pokeType = pokeTypeResponse
                            case .failure(let responseError):
                                error = responseError
                            }
                            done()
                        }
                    }
                    
                    expect(error).toNot(beNil())
                    expect(pokeType).to(beNil())
                }
            }
            
            context("when fetching poketypes and an error occurs") {
                it("should return error") {
                    
                    networkSession.data = nil
                    networkSession.error = NetworkMockError()
                
                    
                    var pokeType: PokeTypeModel?
                    var error: NetworkError?
                    
                    waitUntil { (done) in
                        apiManager.fetchPokeTypes { (result) in
                            switch result {
                            case .success(let pokeTypeResponse):
                                pokeType = pokeTypeResponse
                            case .failure(let responseError):
                                error = responseError
                            }
                            done()
                        }
                    }
                    
                    expect(error).toNot(beNil())
                    expect(pokeType).to(beNil())
                }
            }
            
            context("when fetching poketypes and there's a list of results") {
                it("should return the a list of decoded PokeTypeModel") {
                
                    networkSession.response = TestHelper.response200()
                    networkSession.data = TestHelper.pokeTypesResult()
                    networkSession.error = nil
                
                    var pokeType: PokeTypeModel?
                    var error: NetworkError?
                    
                    waitUntil { (done) in
                        apiManager.fetchPokeTypes { (result) in
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
        
        context("when requesting pokemon for a type and there's no results") {
            it("should return an empty list") {
                networkSession.response = TestHelper.response200()
                networkSession.data = "{\"name\":\"fire\", \"pokemon\":[]}".data(using: .utf8)
                networkSession.error = nil
                
                var pokemonList: PokemonListModel?
                var error: NetworkError?
                
                waitUntil { done in
                    apiManager.fetchPokemonsForType(url: "eletricPokemon.com") { result in
                        switch result {
                        case .success(let data):
                            pokemonList = data
                        case .failure(let responseError):
                            error = responseError
                        }
                        done()
                    }
                }
                
                expect(error).to(beNil())
                expect(pokemonList).toNot(beNil())
                expect(pokemonList?.pokemon).to(beEmpty())
            }
        }
        
        context("when requesting pokemon for a type and there's no results") {
            it("should return error") {
                
                networkSession.data = "{}".data(using: .utf8)
                networkSession.error = nil
                
                var pokemonList: PokemonListModel?
                var error: NetworkError?
                
                waitUntil { done in
                    apiManager.fetchPokemonsForType(url: "eletricPokemon.com") { result in
                        switch result {
                        case .success(let data):
                            pokemonList = data
                        case .failure(let responseError):
                            error = responseError
                        }
                        done()
                    }
                }
                
                expect(error).toNot(beNil())
                expect(pokemonList).to(beNil())
            }
        }
        
        context("when requesting pokemon for a type and an error occurs") {
            it("should return error") {
                
                networkSession.data = nil
                networkSession.error = NetworkMockError()
                
                var pokemonList: PokemonListModel?
                var error: NetworkError?
                
                waitUntil { done in
                    apiManager.fetchPokemonsForType(url: "eletricPokemon.com") { result in
                        switch result {
                        case .success(let data):
                            pokemonList = data
                        case .failure(let responseError):
                            error = responseError
                        }
                        done()
                    }
                }
                
                expect(error).toNot(beNil())
                expect(pokemonList).to(beNil())
            }
        }
        
        context("when requesting pokemon for a type and url is invalid") {
            it("should return error") {
                
                var pokemonList: PokemonListModel?
                var error: NetworkError?
                
                waitUntil { done in
                    apiManager.fetchPokemonsForType(url: "eletricPokemon.com/ invalid url") { result in
                        switch result {
                        case .success(let data):
                            pokemonList = data
                        case .failure(let responseError):
                            error = responseError
                        }
                        done()
                    }
                }
                
                expect(error).toNot(beNil())
                expect(pokemonList).to(beNil())
            }
        }
        
        context("when requesting pokemon for a type") {
            it("should return a list of pokemons for that type") {
                
                networkSession.response = TestHelper.response200()
                networkSession.data = TestHelper.pokemonListResult()
                networkSession.error = nil
                
                var pokemonList: PokemonListModel?
                var error: NetworkError?
                
                waitUntil { done in
                    apiManager.fetchPokemonsForType(url: "waterPokemon.com") { result in
                        switch result {
                        case .success(let data):
                            pokemonList = data
                        case .failure(let responseError):
                            error = responseError
                        }
                        done()
                    }
                }
                
                expect(error).to(beNil())
                expect(pokemonList).toNot(beNil())
                expect(pokemonList?.pokemon.count).to(equal(4))
            }
        }
        
        context("when requesting pokemon details and there's no results") {
            it("should return error") {
                
                networkSession.data = "{}".data(using: .utf8)
                networkSession.error = nil
                
                var pokemon: PokemonDetailsModel?
                var error: NetworkError?
                
                waitUntil { done in
                    apiManager.fetchPokemonDetails(url: "firePokemon.com") { result in
                        switch result {
                        case .success(let data):
                            pokemon = data
                        case .failure(let responseError):
                            error = responseError
                        }
                        done()
                    }
                }
                
                expect(error).toNot(beNil())
                expect(pokemon).to(beNil())
            }
        }
        
        context("when requesting pokemon details and an error occurs") {
            it("should return error") {
                
                networkSession.data = nil
                networkSession.error = NetworkMockError()
                
                var pokemon: PokemonDetailsModel?
                var error: NetworkError?
                
                waitUntil { done in
                    apiManager.fetchPokemonDetails(url: "firePokemon.com") { result in
                        switch result {
                        case .success(let data):
                            pokemon = data
                        case .failure(let responseError):
                            error = responseError
                        }
                        done()
                    }
                }
                
                expect(error).toNot(beNil())
                expect(pokemon).to(beNil())
            }
        }
        
        context("when requesting pokemon details and the url is invalid") {
            it("should return error") {
                
                var pokemon: PokemonDetailsModel?
                var error: NetworkError?
                
                waitUntil { done in
                    apiManager.fetchPokemonDetails(url: "firePokemon.com/ invalid url") { result in
                        switch result {
                        case .success(let data):
                            pokemon = data
                        case .failure(let responseError):
                            error = responseError
                        }
                        done()
                    }
                }
                
                expect(error).toNot(beNil())
                expect(pokemon).to(beNil())
            }
        }
        
        context("when requesting pokemon details") {
            it("should return details for that pokemon") {
                networkSession.response = TestHelper.response200()
                networkSession.data = TestHelper.pokemonDetails()
                networkSession.error = nil
                
                let expectedName = "primeape"
                
                var pokemon: PokemonDetailsModel?
                var error: NetworkError?

                waitUntil { done in
                    apiManager.fetchPokemonDetails(url: "darkPokemon.com") { result in
                        switch result {
                        case .success(let data):
                            pokemon = data
                        case .failure(let responseError):
                            error = responseError
                        }
                        done()
                    }
                }

                expect(error).to(beNil())
                expect(pokemon).toNot(beNil())
                expect(pokemon?.name).to(equal(expectedName))
                expect(pokemon?.abilities.count).to(equal(3))
            }
        }
        
        context("when fetching image data") {
            it("should return data from the api") {
                
                networkSession.response = TestHelper.response200()
                networkSession.data = Data()
                networkSession.error = nil
                
                var data: Data?
                
                waitUntil { done in
                    apiManager.fetchData(from: "someurl.com") { result in
                        data = result
                        done()
                    }
                }
                
                expect(data).toNot(beNil())
            }
        }
        
        context("when fetching image data and there's an error") {
            it("should return a nil object") {
                
                networkSession.data = nil
                networkSession.error = NetworkMockError()
                
                var data: Data?
                
                waitUntil { done in
                    apiManager.fetchData(from: "someurl.com") { result in
                        data = result
                        done()
                    }
                }
                
                expect(data).to(beNil())
            }
        }
        
        context("when fetching image data and the url is invalid") {
            it("should return a nil object") {
                
                var data: Data?
                
                waitUntil { done in
                    apiManager.fetchData(from: "someurl.com/ invalid url") { result in
                        data = result
                        done()
                    }
                }
                
                expect(data).to(beNil())
            }
        }
    }
}
