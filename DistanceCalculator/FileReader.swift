//
//  FileReader.swift
//  DistanceCalculatorTests
//
//  Created by Mitul Manish on 12/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import Foundation

enum FileReadError: Error, Equatable {
    case encodingError(resource: String)
    case cannotCreateFileHandler
    case fileHandlerNotAvailable
    case alreadyReachedEndOfFile
}

class FileReader {
    private let encoding: String.Encoding
    private var fileHandler: FileHandle?
    private let delimiterData: Data
    private var dataBuffer: Data
    private var hasReachedEndOfFile: Bool
    
    init(filePath: String, deleimiter: String = "\n", encoding: String.Encoding = .utf8) throws {
        guard let fileHandler = FileHandle(forReadingAtPath: filePath) else {
            throw FileReadError.cannotCreateFileHandler
        }
        
        guard let delimiterData = deleimiter.data(using: encoding) else {
            throw FileReadError.encodingError(resource: deleimiter)
        }
        
        self.encoding = encoding
        self.fileHandler = fileHandler
        self.delimiterData = delimiterData
        self.dataBuffer = Data()
        self.hasReachedEndOfFile = false
    }
    
    func dataOnNextLine() throws -> Data? {
        guard let fileHandler = self.fileHandler else {
            throw FileReadError.fileHandlerNotAvailable
        }
        
        guard hasReachedEndOfFile == false else {
            throw FileReadError.alreadyReachedEndOfFile
        }
        
        while hasReachedEndOfFile == false {
            if let delimiterRange = dataBuffer.range(of: delimiterData) {
                let currentLineData = dataBuffer.subdata(in: 0..<delimiterRange.lowerBound)
                dataBuffer.removeSubrange(0..<delimiterRange.upperBound)
                return currentLineData
            }
            
            let dataHolder = fileHandler.readDataToEndOfFile()
            if dataHolder.isEmpty == false {
                dataBuffer.append(dataHolder)
            } else {
                hasReachedEndOfFile = true
                if dataBuffer.isEmpty == false {
                    let lastLineData = dataBuffer
                    dataBuffer.count = 0
                    return lastLineData
                }
            }
        }
        return nil
    }
    
    func close() {
        fileHandler?.closeFile()
        fileHandler = nil
    }
    
    static func getDataStream(
        filePath: String,
        dataProcessingQueue: DispatchQueue = DispatchQueue.global(qos: .background),
        resultQueue: DispatchQueue,
        completion: @escaping (([Data]?, FileReadError?) -> ())
        ) {
        dataProcessingQueue.async {
            do {
                let fileReader = try FileReader(filePath: filePath)
                var dataCollection = [Data]()
                defer {
                    fileReader.close()
                }
                while let lineData = try? fileReader.dataOnNextLine(), let data = lineData {
                    dataCollection.append(data)
                }
                resultQueue.async {
                    completion(dataCollection, nil)
                }
            } catch let error {
                resultQueue.async {
                    completion(nil, error as? FileReadError)
                }
            }
        }
    }
}
