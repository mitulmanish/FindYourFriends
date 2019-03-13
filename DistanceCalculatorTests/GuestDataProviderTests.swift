//
//  GuestDataProviderTests.swift
//  DistanceCalculatorTests
//
//  Created by Mitul Manish on 13/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import XCTest
@testable import DistanceCalculator

class GuestDataProviderTests: XCTestCase {

    func test_correct_number_of_customers_returned_in_case_of_success() {
        let myExpectation = expectation(description: "total customers to be 32")
        let guestDataProvider = GuestDataProvider(fileName: "customers", fileType: "txt", bundle: Bundle(for: DummyToGetBundle.self))
        guestDataProvider.getData(dataProcessingQueue: .main, resultQueue: .main) { result in
            switch result {
            case .loading, .failure:
                break
            case .success(let customers):
                XCTAssertEqual(customers.count, 32)
                myExpectation.fulfill()
            }
        }
        wait(for: [myExpectation], timeout: 1.0)
    }

    func test_no_customers_are_returned_in_case_of_empty_file() {
        let myExpectation = expectation(description: "customers list to be empty")
        let guestDataProvider = GuestDataProvider(fileName: "emptyCustomers", fileType: "txt", bundle: Bundle(for: DummyToGetBundle.self))
        guestDataProvider.getData(dataProcessingQueue: .main, resultQueue: .main) { result in
            switch result {
            case .loading, .failure:
                break
            case .success(let customers):
                XCTAssertTrue(customers.isEmpty)
                myExpectation.fulfill()
            }
        }
        wait(for: [myExpectation], timeout: 1.0)
    }

    func test_text_file_with_empty_lines_returns_correct_number_of_customers() {
        let myExpectation = expectation(description: "no of customers to be six")
        let guestDataProvider = GuestDataProvider(fileName: "customersWithBlankLines", fileType: "txt", bundle: Bundle(for: DummyToGetBundle.self))
        guestDataProvider.getData(dataProcessingQueue: .main, resultQueue: .main) { result in
            switch result {
            case .loading, .failure:
                break
            case .success(let customers):
                XCTAssertEqual(customers.count, 6)
                myExpectation.fulfill()
            }
        }
        wait(for: [myExpectation], timeout: 1.0)
    }
    
    func test_text_file_with_illegal_characters_returns_correct_number_of_customers() {
        let myExpectation = expectation(description: "no of customers to be six")
        let guestDataProvider = GuestDataProvider(fileName: "customersWithIllegalCharacters", fileType: "txt", bundle: Bundle(for: DummyToGetBundle.self))
        guestDataProvider.getData(dataProcessingQueue: .main, resultQueue: .main) { result in
            switch result {
            case .loading, .failure:
                break
            case .success(let customers):
                XCTAssertEqual(customers.count, 6)
                myExpectation.fulfill()
            }
        }
        wait(for: [myExpectation], timeout: 1.0)
    }
    
    func test_text_file_with_JSON_with_missing_keys_returns_correct_number_of_customers() {
        let myExpectation = expectation(description: "no of customers to be 28")
        let guestDataProvider = GuestDataProvider(fileName: "customerDataWithMissingKeys", fileType: "txt", bundle: Bundle(for: DummyToGetBundle.self))
        guestDataProvider.getData(dataProcessingQueue: .main, resultQueue: .main) { result in
            switch result {
            case .loading, .failure:
                break
            case .success(let customers):
                XCTAssertEqual(customers.count, 28)
                myExpectation.fulfill()
            }
        }
        wait(for: [myExpectation], timeout: 1.0)
    }
    
    func test_returns_failure_when_wrong_file_name_is_provided() {
        let myExpectation = expectation(description: "return failure state")
        let guestDataProvider = GuestDataProvider(fileName: "wrong-file-name", fileType: "txt", bundle: Bundle(for: DummyToGetBundle.self))
        guestDataProvider.getData(dataProcessingQueue: .main, resultQueue: .main) { result in
            switch result {
            case .loading:
                break
            case .success:
                break
            case .failure(let cause):
                XCTAssertEqual(cause, FileReadError.cannotCreateFileHandler)
                myExpectation.fulfill()
            }
        }
        wait(for: [myExpectation], timeout: 1.0)
    }
}
