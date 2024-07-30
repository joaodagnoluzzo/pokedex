//
//  EmptyTypeSpec.swift
//  PokedexUITests
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 18/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import XCTest
import Quick
import Nimble

class EmptyTypeSpec: QuickSpec {
    
    override class func spec() {
        
        var app: XCUIApplication!
        
        beforeEach {
            app = XCUIApplication()
            app.launch()
        }
        
        afterEach {
            app.terminate()
            app = nil
        }
        
        describe("Access empty pokemon type") {
            context("when selecting a pokemon type") {
                it("should present an error and return to type selection") {
                    let _ = app.cells.element.waitForExistence(timeout: 1)
                    app.swipeUp()
                    
                    let _ = app.cells.element.waitForExistence(timeout: 1)
                    app.cells.containing(.staticText, identifier: "Stellar").element.tap()
                    
                    let alert = app.alerts["Oops"]
                    let _ = alert.waitForExistence(timeout: 1)
                    alert.buttons["Ok"].tap()
                    
                    let _ = app.images.element(boundBy: 0).waitForExistence(timeout: 1)
                    let title = app.navigationBars["Pokémon Types"].identifier
                    
                    expect(title).to(equal("Pokémon Types"))
                }
            }
        }
        
    }
}
