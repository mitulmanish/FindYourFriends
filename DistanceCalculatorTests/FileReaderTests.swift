//
//  DistanceCalculatorTests.swift
//  DistanceCalculatorTests
//
//  Created by Mitul Manish on 12/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import XCTest
@testable import DistanceCalculator

class FileReaderTests: XCTestCase {
    private var fileReader: FileReader!
    
    override func setUp() {
        fileReader = try! FileReader(filePath: givenValidFilePath())
    }

    override func tearDown() {
        fileReader.close()
    }
}

// MARK: - Success
extension FileReaderTests {
    
    func test_fileReader_handles_valid_text_file_correctly() throws {
        fileReader = try FileReader(filePath: givenValidFilePath())
        
        var numberofRuns = 0
        while let data = try fileReader.dataOnNextLine(), data.isEmpty == false {
            numberofRuns += 1
        }
        
        XCTAssertEqual(numberofRuns, 32)
    }
    
    func test_FileReader_handles_empty_text_file_correctly() throws {
        fileReader = try FileReader(filePath: givenValidEmptyCustomersFilePath())
        
        while let data = try fileReader.dataOnNextLine() {
            XCTAssertTrue(data.isEmpty)
        }
    }
    
    func test_fileReader_handles_valid_text_file_with_empty_lines_correctly() throws {
        fileReader = try FileReader(filePath: givenValidCustomersWithBlankLinesFilePath())
        
        XCTAssertNoThrow(try fileReader.dataOnNextLine())
    }
    
    func test_fileReader_handles_valid_text_file_with_random_characters_on_new_line_correctly() throws {
        fileReader = try FileReader(filePath: givenValidCustomersWithRandomCharctersOnNewLineFilePath())
        
        XCTAssertNoThrow(try fileReader.dataOnNextLine())
    }
}

// MARK: - Failure
extension FileReaderTests {
    func test_FileReader_throws_error_when_initialized_with_invalid_file_path() {
        XCTAssertThrowsError(try FileReader(filePath: "/Users/someone/Library/Developer/Xcode/invalid.txt")) { error in
            XCTAssertEqual(error as! FileReadError, FileReadError.cannotCreateFileHandler)
        }
    }
    
    func test_FileReader_throws_error_when_initialized_with_invalid_encoding() {
        XCTAssertThrowsError(try FileReader(filePath: givenValidFilePath(), deleimiter: "🍎", encoding: .ascii)) { error in
            XCTAssertEqual(error as! FileReadError, FileReadError.encodingError(resource: "🍎"))
        }
    }
    
    func test_FileReader_dataOnNextLine_throws_error_when_fileHandler_is_closed() throws {
        fileReader = try FileReader(filePath: givenValidFilePath())
        fileReader.close()
        
        XCTAssertThrowsError(try fileReader.dataOnNextLine()) { error in
            XCTAssertEqual(error as! FileReadError, FileReadError.fileHandlerNotAvailable)
        }
    }
}

// MARK: - Helper
extension FileReaderTests {
    func printData(for filepath: String) {
        if let reader = try? FileReader(filePath: filepath) {
            defer {
                reader.close()
            }
            var dataCollection = [Data]()
            
            while let lineData = try? reader.dataOnNextLine(), let data = lineData {
                dataCollection.append(data)
            }
            for data in dataCollection {
                print(String(data: data, encoding: .utf8) ?? "")
            }
        }
    }
    
    func givenValidFilePath() -> String {
        return Bundle(for: DummyToGetBundle.self).path(forResource: "customers", ofType: "txt")!
    }
    
    func givenValidEmptyCustomersFilePath() -> String {
        return Bundle(for: DummyToGetBundle.self).path(forResource: "emptyCustomers", ofType: "txt")!
    }
    
    func givenValidCustomersWithBlankLinesFilePath() -> String {
        return Bundle(for: DummyToGetBundle.self).path(forResource: "customersWithBlankLines", ofType: "txt")!
    }
    
    func givenValidCustomersWithRandomCharctersOnNewLineFilePath() -> String {
        return Bundle(for: DummyToGetBundle.self).path(forResource: "customersWithIllegalCharacters", ofType: "txt")!
    }
}
