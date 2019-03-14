//
//  HaversineDistanceCalculator.swift
//  DistanceCalculator
//
//  Created by Mitul Manish on 13/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//
import Foundation

extension Double {
    static let earthRadiusInMeters: Double = 6371000
}

struct HaversineDistanceCalculator: DistanceComputation {
    func computeDistance(sourceLatitude: Double, sourceLongitude: Double, destinationLatitude: Double, destinationLongitude: Double) -> Double {
        
        let latitudeSourceInRadian = degreeToRadian(angle: sourceLatitude)
        let longitudeSourceInRadian = degreeToRadian(angle: sourceLongitude)
        let latitudeDestinationInRadian = degreeToRadian(angle: destinationLatitude)
        let longitudeDestinationInRadian = degreeToRadian(angle: destinationLongitude)
        
        let haversin = { (angle: Double) -> Double in
            return (1 - cos(angle))/2
        }
        
        let ahaversin = { (angle: Double) -> Double in
            return 2*asin(sqrt(angle))
        }
        
        let distance = Double.earthRadiusInMeters * ahaversin(haversin(latitudeDestinationInRadian - latitudeSourceInRadian) + cos(latitudeSourceInRadian) * cos(latitudeDestinationInRadian) * haversin(longitudeDestinationInRadian - longitudeSourceInRadian))
        return distance
    }
}
