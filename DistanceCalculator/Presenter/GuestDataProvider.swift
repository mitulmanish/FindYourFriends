//
//  GuestDataProvider.swift
//  DistanceCalculator
//
//  Created by Mitul Manish on 13/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//
import Foundation

enum GuestDataProviderResult {
    case loading
    case success(customers: [Customer])
    case failure(cause: FileReadError?)
}

struct GuestDataProvider {
    private let filePath: String
    
    init(fileName: String, fileType: String = "txt", bundle: Bundle = .main) {
        filePath = bundle.path(forResource: fileName, ofType: fileType) ?? ""
    }
    
    func getData(dataProcessingQueue: DispatchQueue = DispatchQueue.global(qos: .background),
                 resultQueue: DispatchQueue,
                 completionHandler: @escaping (GuestDataProviderResult) -> ()) {
        completionHandler(.loading)
        FileReader.getDataStream(filePath: filePath, dataProcessingQueue: dataProcessingQueue, resultQueue: resultQueue) { dataCollection, error in
            switch (dataCollection, error) {
            case (let dataList?, _):
                let guests = self.dataCollectionToGuestList(dataCollection: dataList)
                completionHandler(.success(customers: guests))
            case (_, let error?):
                completionHandler(.failure(cause: error))
            case (.none, .none):
                completionHandler(.failure(cause: .none))
            }
        }
    }
    
    private func dataCollectionToGuestList(dataCollection: [Data]) -> [Customer] {
        let dictionaries = dataCollection.compactMap { try? JSONSerialization.jsonObject(with: $0, options: []) as? [String: Any] }
        return dictionaries.compactMap { try? Customer(from: $0 ?? [:]) }
    }
}
