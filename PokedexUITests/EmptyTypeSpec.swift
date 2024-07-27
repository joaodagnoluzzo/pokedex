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
                it("should present an error") {
                    let _ = app.cells.element.waitForExistence(timeout: 1)
                    app.cells.containing(.staticText, identifier: "Shadow").element.tap()
                    let alert = app!.alerts["Oops"]
                    alert.waitForExistence(timeout: 1)
                    alert.buttons["OK"].tap()
                    let _ = app.images.element(boundBy: 0).waitForExistence(timeout: 1)
                    let count = app!.tables.element(boundBy: 0).cells.count
                    expect(count).to(equal(0))
                }
            }
        }
        
    }
}
