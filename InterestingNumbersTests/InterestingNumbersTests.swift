//
//  InterestingNumbersTests.swift
//  InterestingNumbersTests
//
//  Created by Данік on 30/06/2023.
//

import XCTest
@testable import InterestingNumbers

final class NumbersManagerTests: XCTestCase {
    
    var numbersManager: NumbersManager!
    var mockSession: MockURLSession!
    var mockDelegate: MockNumbersManagerDelegate!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        numbersManager = NumbersManager(session: mockSession)
        mockDelegate = MockNumbersManagerDelegate()
        numbersManager.delegate = mockDelegate
    }

    override func tearDown() {
        numbersManager = nil
        mockSession = nil
        super.tearDown()
    }

    // Test the fetchFacts(numbers:) function
    func testFetchFacts() {
        // Given
        let numbers = "42"
        let expectedFacts = ["42": "The number 42 is the Answer to the Ultimate Question of Life, the Universe, and Everything."]
        let jsonData = try! JSONEncoder().encode(expectedFacts)
        mockSession.data = jsonData
        mockSession.response = HTTPURLResponse(url: URL(string: "http://numbersapi.com/42")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        // When
        numbersManager.fetchFacts(numbers: numbers)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // check if the facts are not nil
            XCTAssertEqual(self.mockDelegate.myFacts, expectedFacts)
            // check if the error is nil
            XCTAssertNil(self.mockDelegate.myError)
        }
    }

    // Test the performRequest(with:) function
    func testPerformRequest() {
        // Given
        let urlString = "http://numbersapi.com/42"
        let expectedFacts = ["42": "The number 42 is the Answer to the Ultimate Question of Life, the Universe, and Everything."]
        let jsonData = try! JSONEncoder().encode(expectedFacts)
        mockSession.data = jsonData
        mockSession.response = HTTPURLResponse(url: URL(string: urlString)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        // When
        numbersManager.performRequest(with: urlString)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // check if the facts are not nil
            XCTAssertEqual(self.mockDelegate.myFacts, expectedFacts)
            // check if the error is nil
            XCTAssertNil(self.mockDelegate.myError)
        }
    }

    // Test the parseJSONToFacts(_:) function
    func testParseJSONToFacts() {
        // Create some test data
        let json = """
            {
                "42": "The number 42 is the Answer to the Ultimate Question of Life, the Universe, and Everything."
            }
            """
        let data = json.data(using: .utf8)!
        
        // Call the parseJSONToFacts function and check the result
        let facts = numbersManager.parseJSONToFacts(data)
        
        XCTAssertNotNil(facts)
        XCTAssertEqual(facts?["42"], "The number 42 is the Answer to the Ultimate Question of Life, the Universe, and Everything.")
    }

    // Test the parseFactsString(_:) function
    func testParseFactsString() {
        // Given
        let userInputNumber = "42"
        let factsString = "The number 42 is the Answer to the Ultimate Question of Life, the Universe, and Everything."
        
        // Call the parseFactsString function and check the result
        numbersManager.userInputNumber = "42"
        let facts = numbersManager.parseFactsString(factsString)
        
        XCTAssertEqual(facts, [userInputNumber : factsString])
    }
}

class MockNumbersManagerDelegate: NumbersManagerDelegate {
    var myFacts: [String: String]?
    var myError: Error?
    
    func didUpdateNumberFacts(_ manager: NumbersManager, facts: [String : String]) {
        myFacts = facts
    }
    
    func didFailWithError(error: Error) {
        myError = error
    }
}

class MockURLSession: URLSession {
    var cachedUrl: URL?
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.cachedUrl = url
        completionHandler(data, response, error)
        return URLSession.shared.dataTask(with: url)
    }
}
