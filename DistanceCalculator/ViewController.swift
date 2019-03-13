//
//  ViewController.swift
//  DistanceCalculator
//
//  Created by Mitul Manish on 12/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController {
    
    private let headquartersLocation: LocationCoordinate = LocationCoordinate(latitude: 53.339428, longitude: -6.257664)
    private var customers: [Customer]?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let dataProvider = GuestDataProvider(fileName: "customers")
        dataProvider.getData(resultQueue: .main, completionHandler: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .loading:
                break
            case .success(let customers):
                self.customers = customers
            case .failure(let cause):
                break
            }
        })
    }
}
