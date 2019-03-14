//
//  Guest.swift
//  DistanceCalculator
//
//  Created by Mitul Manish on 14/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import Foundation

struct Guest {
    let userID: Int
    let userName: String
    let distanceFromSourceInKm: Double
    
    var distanceFromSourceDescription: String {
        let formattedDistance = String(format: "%.2f", distanceFromSourceInKm)
        return "\(formattedDistance) Km away"
    }
}
