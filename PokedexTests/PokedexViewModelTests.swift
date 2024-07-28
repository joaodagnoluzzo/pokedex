//
//  PokedexViewModelTests.swift
//  PokedexTests
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 09/01/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import XCTest
@testable import Pokedex

//class PokedexViewModelTests: XCTestCase {
//
//    var sut: PokedexViewModel!
//    var apiManager: APIManagerMock!
//    
//    override func setUp() {
//        super.setUp()
//        apiManager = APIManagerMock()
//    }
//
//    override func tearDown() {
//        apiManager = nil
//        sut = nil
//        super.tearDown()
//    }
//
//    func testPokeTypeListEmpty() {
//        var data: [PokeTypeUrl]?
//        var error: Error?
//        let promise = expectation(description: "List of Poke Types is empty")
//        self.apiManager.pokeType = PokeTypeModel(count: 0, results: [])
//        
//        sut = PokedexViewModel(apiManager: apiManager)
//        sut.retrievePokeTypes{ (results) in
//            switch results {
//            case .success(let list):
//                data = list
//            case .failure(let responseError):
//                error = responseError
//            }
//            promise.fulfill()
//        }
//        wait(for: [promise], timeout: 4.0)
//        
//        XCTAssertNil(error)
//        XCTAssertNotNil(data)
//        XCTAssertEqual(data?.count, 0, "Poke types list should be empty")
//    }
//    
//    func testPokeTypeListWithResults() {
//        var data: [PokeTypeUrl]?
//        var error: Error?
//        let promise = expectation(description: "List of Poke Types contain 3 results")
//        let fireType = PokeTypeUrl(name: "Fire", url: "https://pokeapi.co/fire")
//        let waterType = PokeTypeUrl(name: "Water", url: "https://pokeapi.co/water")
//        let eletrictType = PokeTypeUrl(name: "Eletric", url: "https://pokeapi.co/eletric")
//        
//        self.apiManager.pokeType = PokeTypeModel(count: 3, results: [fireType, waterType, eletrictType])
//        
//        sut = PokedexViewModel(apiManager: apiManager)
//        sut.retrievePokeTypes(completion: { (results) in
//            switch results {
//            case .success(let typesList):
//                data = typesList
//            case .failure(let responseError):
//                error = responseError
//            }
//            promise.fulfill()
//        })
//        wait(for: [promise], timeout: 4.0)
//        
//        XCTAssertNil(error)
//        XCTAssertNotNil(data)
//        XCTAssertEqual(data?.count, 3, "Poke Type list should have 3 items")
//    }
//    
//    func testPokeTypeListWithError(){
//        var data: [PokeTypeUrl]?
//        var error: Error?
//        let promise = expectation(description: "Error handled without exception")
//        
//        sut = PokedexViewModel(apiManager: apiManager)
//        sut.retrievePokeTypes(completion: { (results) in
//            switch results {
//            case .success(let typesList):
//                data = typesList
//            case .failure(let responseError):
//                error = responseError
//            }
//            promise.fulfill()
//        })
//        wait(for: [promise], timeout: 4.0)
//        
//        XCTAssertNil(data)
//        XCTAssertNotNil(error)
//    }
//    
//    func testPokeTypeDetailListEmpty() {
//        var data:[PokeUrl]?
//        var error: Error?
//        
//        let promise = expectation(description: "Pokémon list is empty for Fire type")
//        self.apiManager.pokeTypeDetail = PokemonDetailsModel(name: "Fire", pokemon: [])
//        
//        sut = PokedexViewModel(apiManager: apiManager)
//        sut.retrievePokemonList(typeUrl: "", completion: {(results) in
//            switch results {
//            case .success(let pokeList):
//                data = pokeList
//            case .failure(let responseError):
//                error = responseError
//            }
//            promise.fulfill()
//        })
//        wait(for: [promise], timeout: 4.0)
//        
//        XCTAssertNil(error)
//        XCTAssertNotNil(data)
//        XCTAssertEqual(data?.count, 0, "Pokemon list should be empty for Fire type")
//    }
//    
//    func testPokeTypeDetailListWithResults(){
//        var data: [PokeUrl]?
//        var error: Error?
//        
//        let promise = expectation(description: "Pokémon list cotains 2 results for Fire type")
//        let pokePreviewCharmander = PokemonPreview(pokemon: PokeUrl(name: "Charmander", url: "https://pokeapi.co/charmander"))
//        let pokePreviewCharizard = PokemonPreview(pokemon: PokeUrl(name: "Charizard", url: "https://pokeapi.co/charizard"))
//        
//        self.apiManager.pokeTypeDetail = PokemonDetailsModel(name: "Fire", pokemon: [pokePreviewCharmander, pokePreviewCharizard])
//        sut = PokedexViewModel(apiManager: apiManager)
//        sut.retrievePokemonList(typeUrl: "", completion: { (results) in
//            switch results {
//            case .success(let pokeList):
//                data = pokeList
//            case .failure(let responseError):
//                error = responseError
//            }
//            promise.fulfill()
//        })
//        wait(for: [promise], timeout: 4.0)
//        
//        XCTAssertNil(error)
//        XCTAssertNotNil(data)
//        XCTAssertEqual(data?.count, 2, "Pokémon list should contain 2 pokémons for Fire type")
//    }
//    
//    func testEmptyPokemonDetails(){
//        var data: PokemonModel?
//        var error: Error?
//        
//        let promise = expectation(description: "No pokémon is retrieved")
//        self.apiManager.pokemon = PokemonModel()
//        
//        sut = PokedexViewModel(apiManager: apiManager)
//        sut.retrievePokemonDetails(pokemonUrl: "", completion: { (results) in
//            switch results {
//            case .success(let pokemon):
//                data = pokemon
//            case .failure(let responseError):
//                error = responseError
//            }
//            promise.fulfill()
//        })
//        
//        wait(for: [promise], timeout: 4.0)
//        XCTAssertNil(error)
//        XCTAssertNotNil(data)
//        XCTAssertEqual(data?.name, "", "Pokémon detail should not contain a name")
//    }
//
//    
//    func testFormatPokemonHeight() {
//        var formattedHeight: String = ""
//        
//        sut = PokedexViewModel()
//        formattedHeight = sut.formatPokemonHeight(height: 20)
//        
//        XCTAssertEqual(formattedHeight, "2.0 m")
//    }
//    
//    func testFormatPokemonHeightThreeDigits(){
//        var formattedHeight: String = ""
//        
//        sut = PokedexViewModel()
//        formattedHeight = sut.formatPokemonHeight(height: 300)
//        
//        XCTAssertEqual(formattedHeight, "30.0 m")
//    }
//    
//    func testFormatPokemonHeightNotNegative(){
//        var formattedHeight: String = ""
//        
//        sut = PokedexViewModel()
//        formattedHeight = sut.formatPokemonHeight(height: -20)
//        
//        XCTAssertNotEqual(formattedHeight, "-2.0 m", "Height cannot be negative")
//    }
//    
//    func testFormatPokemonWeight(){
//        var formattedWeight: String = ""
//        
//        sut = PokedexViewModel()
//        formattedWeight = sut.formatPokemonWeight(weight: 100)
//        
//        XCTAssertEqual(formattedWeight, "10.0 Kg")
//    }
//    
//    func testFormatPokemonWeightSixDigits(){
//        var formattedWeight: String = ""
//        
//        sut = PokedexViewModel()
//        formattedWeight = sut.formatPokemonWeight(weight: 280215)
//        
//        XCTAssertEqual(formattedWeight, "28021.5 Kg")
//    }
//    
//    func testFormatPokemonWeightNotNegative(){
//        var formattedWeight: String = ""
//        
//        sut = PokedexViewModel()
//        formattedWeight = sut.formatPokemonWeight(weight: -229)
//        
//        XCTAssertNotEqual(formattedWeight, "-22.9 Kg", "Weight cannot be negative")
//    }
//    
//}
