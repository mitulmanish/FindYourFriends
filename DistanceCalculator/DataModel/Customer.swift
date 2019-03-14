//
//  Customer.swift
//  DistanceCalculator
//
//  Created by Mitul Manish on 13/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

enum SerializationError: Error {
    case missing(key: String)
}

struct Customer {
    let name: String
    let userID: Int
    let latitude: Double
    let longitude: Double
    
    private enum Keys: String {
        case name
        case userID = "user_id"
        case latitude
        case longitude
    }
}

extension Customer {
    init(from dictionary: [String: Any]) throws {
        guard let name = dictionary[Keys.name.rawValue] as? String else {
            throw SerializationError.missing(key: Keys.name.rawValue)
        }
        guard let userID = dictionary[Keys.userID.rawValue] as? Int else {
            throw SerializationError.missing(key: Keys.userID.rawValue)
        }
        guard let latitudeAsString = dictionary[Keys.latitude.rawValue] as? String,
            let latitudeAsDouble = Double(latitudeAsString) else {
            throw SerializationError.missing(key: Keys.latitude.rawValue)
        }
        guard let longitudeAsString = dictionary[Keys.longitude.rawValue] as? String,
            let longitudeAsDouble = Double(longitudeAsString) else {
            throw SerializationError.missing(key: Keys.longitude.rawValue)
        }
        self.name = name
        self.userID = userID
        self.latitude = latitudeAsDouble
        self.longitude = longitudeAsDouble
    }
}
