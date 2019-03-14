//
//  DistanceComputation.swift
//  DistanceCalculator
//
//  Created by Mitul Manish on 14/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import Foundation

protocol DistanceComputation {
    func computeDistance(sourceLatitude: Double, sourceLongitude: Double, destinationLatitude: Double, destinationLongitude: Double) -> Double
}

extension DistanceComputation {
    func degreeToRadian(angle: Double) -> Double {
        return (angle / 360) * 2 * .pi
    }
}
