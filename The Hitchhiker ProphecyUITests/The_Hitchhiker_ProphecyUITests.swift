//
//  The_Hitchhiker_ProphecyUITests.swift
//  The Hitchhiker ProphecyUITests
//
//  Created by Omar Tarek on 3/25/21.
//  Copyright © 2021 SWVL. All rights reserved.
//

import XCTest

class The_Hitchhiker_ProphecyUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        
        app = nil
    }
    
    func testShowingLoadingIndicator() {
        let isLoadingIndicatorExists = app.activityIndicators["home_activityIndicator"].exists
        XCTAssertTrue(isLoadingIndicatorExists)
    }
    
    func testSelectedCharacterIsDispalyedInDetails() {
        
        sleep(5)
        let firstChild = app.collectionViews.children(matching:.any).element(boundBy: 0)
        if firstChild.exists {
             firstChild.tap()
        }
        
    }

}
