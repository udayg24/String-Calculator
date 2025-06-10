//
//  String_CalculatorTests.swift
//  String CalculatorTests
//
//  Created by Uday Gajera on 10/06/25.
//

import XCTest
@testable import String_Calculator

final class String_CalculatorTests: XCTestCase {
    
    var sut: Calculator = Calculator()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEmptyStringReturnsZero() {
        XCTAssertEqual(try sut.add(""), 0)
    }
    
    func testSingleNumberReturnsNumberItself() {
        XCTAssertEqual(try sut.add("1"), 1)
    }
    
    func testTwoNumbersSeperatedByComma() {
        XCTAssertEqual(try sut.add("2,3"), 5)
    }
    
    func testNewLinesBetweenNumbers() {
        XCTAssertEqual(try sut.add("1\n2\n3"), 6)
    }
    
    func testNewLinesAndCommasBetweenNumbers() {
        XCTAssertEqual(try sut.add("1\n2,3"), 6)
    }
    
    func testNewLinesAndCommasAndSpacesBetweenNumbers() {
        XCTAssertEqual(try sut.add("1\n2, 3"), 6)
    }
    
    func testSimpleCustomDelimiter() {
        XCTAssertEqual(try sut.add("//;\n1;2"), 3)
    }
    
    func testCustomDelimiterWithMultipleNewLines() {
        XCTAssertEqual(try sut.add("//;\n1;2\n3;4"), 10)
    }
    
    func testCustomDelimiterWithMultipleNewLinesAndWhiteSpaces() {
        XCTAssertEqual(try sut.add("//;\n1;2\n 3; 4"), 10)
    }
    
    func testNegativeNumberThrowException() {
        XCTAssertThrowsError(try sut.add("4,-3,3")) { error in
            XCTAssertEqual(error as? CalculatorError, .negativeNumbers([-3]))
            XCTAssertEqual(error.localizedDescription, "negative numbers not allowed -3")
        }
    }
    
    func testMultipleNegativeNumbersThrowExpection() {
        XCTAssertThrowsError(try sut.add("-9,-3,1")) { error in
            XCTAssertEqual(error as? CalculatorError, .negativeNumbers([-9, -3]))
            XCTAssertEqual(error.localizedDescription, "negative numbers not allowed -9,-3")
        }
    }
    
    func testNegativeNumbersWithCustomDelimiter() {
        XCTAssertThrowsError(try sut.add("//;\n4;-2;7;-5")) { error in
            XCTAssertEqual(error as? CalculatorError, .negativeNumbers([-2, -5]))
            XCTAssertEqual(error.localizedDescription, "negative numbers not allowed -2,-5")
        }
    }
    
    func testNegativeNumbersWithCustomDelimiterAndWhiteSpaces() {
        XCTAssertThrowsError(try sut.add("//;\n4;-2;7; -5")) { error in
            XCTAssertEqual(error as? CalculatorError, .negativeNumbers([-2, -5]))
            XCTAssertEqual(error.localizedDescription, "negative numbers not allowed -2,-5")
        }
    }
    

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
