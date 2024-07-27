//
//  DetailsSpec.swift
//  PokedexUITests
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 18/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import XCTest
import Quick
import Nimble

class DetailsSpec: QuickSpec {

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
        
        describe("Access Pokemon details") {
            context("when selecting fire and then Charizard") {
                it("should present Charizard details") {
                    let _ = app.cells.element.waitForExistence(timeout: 1)
                    app.cells.containing(.staticText, identifier: "Fire").element.tap()
                    app.cells.containing(.staticText, identifier: "Charizard").element.tap()
                    let _ = app.images.element(boundBy: 0).waitForExistence(timeout: 2)
                    let title = app.navigationBars["Charizard"].identifier
                    expect(title).to(equal("Charizard"))
                }
            }
        }
        
    }

}
