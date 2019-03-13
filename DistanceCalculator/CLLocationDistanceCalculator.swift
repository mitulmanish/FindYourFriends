//
//  CLLocationDistanceCalculator.swift
//  DistanceCalculator
//
//  Created by Mitul Manish on 14/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import Foundation
import CoreLocation

struct CLLocationDistanceCalculator: DistanceComputation {
    func computeDistance(sourceLatitude: Double, sourceLongitude: Double, destinationLatitude: Double, destinationLongitude: Double) -> Double {
        guard let sourceLatitude = CLLocationDegrees(exactly: sourceLatitude),
            let sourceLongitude = CLLocationDegrees(exactly: sourceLongitude),
            let destinationLatitude = CLLocationDegrees(exactly: destinationLatitude),
            let destinationLongitude = CLLocationDegrees(exactly: destinationLongitude) else {
                return 0.0
        }
        let source = CLLocation(latitude: sourceLatitude, longitude: sourceLongitude)
        let destination = CLLocation(latitude: destinationLatitude, longitude: destinationLongitude)
        let distance = source.distance(from: destination)
        return distance
    }
}
