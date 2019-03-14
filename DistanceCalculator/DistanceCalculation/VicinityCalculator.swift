//
//  VicinityCalculator.swift
//  DistanceCalculator
//
//  Created by Mitul Manish on 13/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import Foundation

struct VicinityCalculator {
    let sourceCoordinate: LocationCoordinate
    let customers: [Customer]
    let distanceCalculator: DistanceComputation
    
    func computeGuestList(within radiusInKm: Double) -> [Guest] {
        return customers.map { customer -> Guest in
            let distanceInMeters = distanceCalculator.computeDistance(
                sourceLatitude: customer.latitude,
                sourceLongitude: customer.longitude,
                destinationLatitude: sourceCoordinate.latitude,
                destinationLongitude: sourceCoordinate.longitude
            )
            let distanceinKm = Measurement(
                value: distanceInMeters,
                unit: UnitLength.meters
                ).converted(to: UnitLength.kilometers).value
            return Guest(
                userID: customer.userID,
                userName: customer.name,
                distanceFromSourceInKm: distanceinKm
            )
            }.filter { guest in
                guest.distanceFromSourceInKm <= radiusInKm
            }.sorted { $0.userID < $1.userID }
    }
}
