//
//  String_CalculatorUITests.swift
//  String CalculatorUITests
//
//  Created by Uday Gajera on 10/06/25.
//

import XCTest

final class String_CalculatorUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    @MainActor
    func testAppLaunchAndBasicElements() throws {
        let titleText = app.staticTexts["String Calculator"]
        XCTAssertTrue(titleText.exists, "Main title should be visible")
        
        let subtitleText = app.staticTexts["Add numbers with custom delimiters"]
        XCTAssertTrue(subtitleText.exists, "Subtitle should be visible")
        
        let inputField = app.textFields.firstMatch
        XCTAssertTrue(inputField.exists, "Input text field should be visible")
        
        let calculateButton = app.buttons["Calculate"]
        XCTAssertTrue(calculateButton.exists, "Calculate button should be visible")
    }
    
    @MainActor
    func testValidInputCalculation() throws {
        let inputField = app.textFields.firstMatch
        let calculateButton = app.buttons["Calculate"]
        
        inputField.tap()
        inputField.typeText("1,2,3")
        
        calculateButton.tap()
        
        let resultText = app.staticTexts["Result:"]
        XCTAssertTrue(resultText.waitForExistence(timeout: 2), "Result should appear after calculation")
        
        let resultValue = app.staticTexts["6"]
        XCTAssertTrue(resultValue.exists, "Result should be 6 for input '1,2,3'")
    }
    
    @MainActor
    func testCustomDelimiterCalculation() throws {
        let inputField = app.textFields.firstMatch
        let calculateButton = app.buttons["Calculate"]
        
        inputField.tap()
        inputField.typeText("//;\n1;2;3")
        
        calculateButton.tap()
        
        let resultText = app.staticTexts["Result:"]
        XCTAssertTrue(resultText.waitForExistence(timeout: 2), "Result should appear after calculation")
        
        let resultValue = app.staticTexts["6"]
        XCTAssertTrue(resultValue.exists, "Result should be 6 for custom delimiter input")
    }
    
    @MainActor
    func testNegativeNumbersError() throws {
        let inputField = app.textFields.firstMatch
        let calculateButton = app.buttons["Calculate"]
        
        inputField.tap()
        inputField.typeText("1,-2,3")
        
        calculateButton.tap()
        
        let errorMessage = app.staticTexts.containing(NSPredicate(format: "label CONTAINS 'negative numbers not allowed'")).firstMatch
        XCTAssertTrue(errorMessage.waitForExistence(timeout: 2), "Error message should appear for negative numbers")

    let negativeNumberMessage = app.staticTexts.containing(NSPredicate(format: "label CONTAINS '-2'")).firstMatch
    XCTAssertTrue(negativeNumberMessage.exists, "Error message should display the negative number -2")
    }
    
    @MainActor
    func testInvalidInputError() throws {
        let inputField = app.textFields.firstMatch
        let calculateButton = app.buttons["Calculate"]
        
        inputField.tap()
        inputField.typeText("1,a,3")
        
        calculateButton.tap()
        
        let errorMessage = app.staticTexts["invalid input"]
        XCTAssertTrue(errorMessage.waitForExistence(timeout: 2), "Error message should appear for invalid input")
    }
}
