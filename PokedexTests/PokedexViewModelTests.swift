//
//  PokedexViewModelTests.swift
//  PokedexTests
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 09/01/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import XCTest
@testable import Pokedex

class PokedexViewModelTests: XCTestCase {

    var sut: PokedexViewModel!
    var apiManager: APIManagerMock!
    
    override func setUp() {
        super.setUp()
        apiManager = APIManagerMock()
    }

    override func tearDown() {
        apiManager = nil
        sut = nil
        super.tearDown()
    }

    func testPokeTypeListEmpty() {
        var data: [PokeTypeUrl]?
        var error: Error?
        let promise = expectation(description: "List of Poke Types is empty")
        self.apiManager.pokeType = PokeType(count: 0, results: [])
        
        sut = PokedexViewModel(apiManager: apiManager)
        sut.retrievePokeTypes{ (results) in
            switch results {
            case .success(let list):
                data = list
            case .failure(let responseError):
                error = responseError
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 4.0)
        
        XCTAssertNil(error)
        XCTAssertNotNil(data)
        XCTAssertEqual(data?.count, 0, "Poke types list should be empty")
    }
    
    func testPokeTypeDetailListEmpty() {
        
        var data:[PokeUrl]?
        var error: Error?
        
        let promise = expectation(description: "Pokemon list is empty for Fire type")
        self.apiManager.pokeTypeDetail = PokeTypeDetail(name: "Fire", pokemon: [])
        
        sut = PokedexViewModel(apiManager: apiManager)
        sut.retrievePokemonList(typeUrl: "", completion: {(results) in
            switch results {
            case .success(let pokeList):
                data = pokeList
            case .failure(let responseError):
                error = responseError
            }
            promise.fulfill()
        })
        wait(for: [promise], timeout: 4.0)
        
        XCTAssertNil(error)
        XCTAssertNotNil(data)
        XCTAssertEqual(data?.count, 0, "Pokemon list should be empty for Fire type")
    }
    
    func testEmptyPokemonDetails(){
        
        var data: Pokemon?
        var error: Error?
        
        let promise = expectation(description: "No pokémon is retrieved")
        self.apiManager.pokemon = Pokemon()
        
        sut = PokedexViewModel(apiManager: apiManager)
        sut.retrievePokemonDetails(pokemonUrl: "", completion: { (results) in
            switch results {
            case .success(let pokemon):
                data = pokemon
            case .failure(let responseError):
                error = responseError
            }
            promise.fulfill()
        })
        
        wait(for: [promise], timeout: 4.0)
        XCTAssertNil(error)
        XCTAssertNotNil(data)
        XCTAssertEqual(data?.name, "", "Pokémon detail should not contain a name")
    }

}
