//
//  InterestingNumbersUITests.swift
//  InterestingNumbersUITests
//
//  Created by Данік on 30/06/2023.
//

import XCTest

final class InterestingNumbersUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testUserNumber() {
        let userNumberButton = app.buttons["userNumberButton"]
        let textField = app.textFields["textField"]
        let displayFactButton = app.buttons["displayFactButton"]
        let closeButton = app.buttons["closeButton"]
        let numberLabel = app.textViews["numberLabel"]
        let factLabel = app.textViews["factLabel"]
        let cubesImage = app.images["cubesImage"]
        
        userNumberButton.tap()
        textField.tap()
        textField.typeText("42")
        cubesImage.tap()
        displayFactButton.tap()
        XCTAssertNotNil(factLabel)
        XCTAssertNotNil(numberLabel)
        
        closeButton.tap()
    }
    
    func testRandomNumber() {
        let randomNumberButton = app.buttons["randomNumberButton"]
        let displayFactButton = app.buttons["displayFactButton"]
        let closeButton = app.buttons["closeButton"]
        let numberLabel = app.textViews["numberLabel"]
        let factLabel = app.textViews["factLabel"]
        
        randomNumberButton.tap()
        displayFactButton.tap()
        XCTAssertNotNil(factLabel)
        XCTAssertNotNil(numberLabel)
        
        closeButton.tap()
    }
    
    func testNumbersInRange() {
        let fromTextField  = app.textFields["fromTextField"]
        let toTextField  = app.textFields["toTextField"]
        let numberInRangeButton = app.buttons["numberInRangeButton"]
        let displayFactButton = app.buttons["displayFactButton"]
        let closeButton = app.buttons["closeButton"]
        let numberLabel = app.textViews["numberLabel"]
        let factLabel = app.textViews["factLabel"]
        
        numberInRangeButton.tap()
        
        fromTextField.tap()
        fromTextField.typeText("1")
        toTextField.tap()
        toTextField.typeText("12")
        app.alerts.buttons["Submit"].tap()
        
        displayFactButton.tap()
        XCTAssertNotNil(factLabel)
        XCTAssertNotNil(numberLabel)
        
        closeButton.tap()
    }
    
    func testMultipleNumbersButton() {
        let multipleNumbersButton = app.buttons["multipleNumbersButton"]
        let textField = app.textFields["textField"]
        let displayFactButton = app.buttons["displayFactButton"]
        let closeButton = app.buttons["closeButton"]
        let numberLabel = app.textViews["numberLabel"]
        let factLabel = app.textViews["factLabel"]
        let cubesImage = app.images["cubesImage"]
        
        multipleNumbersButton.tap()
        app.alerts.buttons["Understand"].tap()
        textField.tap()
        textField.typeText("1,2,3,4,5,6,7,22,33,44,55,66,77,89,404")
        cubesImage.tap()
        
        
        displayFactButton.tap()
        let collectionView = app.collectionViews.element(boundBy: 0)
        collectionView.swipeUp(velocity: .fast)
        
        collectionView.swipeUp()
        
        collectionView.swipeUp()
        
        XCTAssertNotNil(factLabel)
        XCTAssertNotNil(numberLabel)
        
        closeButton.tap()
    }
    
    func testTextFieldEntry() {
        let textField = app.textFields["textField"]
        
        // Tap on the text field
        textField.tap()
        
        // Enter a number in the text field
        textField.typeText("42")
        
        // Assert that the text field contains the entered number
        XCTAssertEqual(textField.value as? String, "42")
    }
    
}
