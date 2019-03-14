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
    
    @IBOutlet weak var loadDataButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressLabel: UILabel!
    
    private var animator: UIViewControllerTransitioningDelegate?
    
    private let headquartersLocation: LocationCoordinate = LocationCoordinate(latitude: 53.339428, longitude: -6.257664)
    private var customers: [Customer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressLabel.text = ""
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        loadDataButton.addTarget(self, action: #selector(getCustomersFromFile), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc fileprivate func getCustomersFromFile() {
        let dataProvider = GuestDataProvider(fileName: "customers")
        dataProvider.getData(resultQueue: .main, completionHandler: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .loading:
                self.progressLabel.text = "Loading ..."
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            case .success(let customers):
                self.progressLabel.text = nil
                self.activityIndicator.stopAnimating()
                self.customers = customers
                self.loadDataButton.removeTarget(self, action: #selector(self.getCustomersFromFile), for: .touchUpInside)
                self.loadDataButton.addTarget(self, action: #selector(self.showGuestList), for: .touchUpInside)
                self.loadDataButton.setTitle("Show Guests", for: .normal)
            case .failure(let cause):
                self.activityIndicator.stopAnimating()
                self.progressLabel.text = cause?.description ?? ""
            }
        })
    }
    
    @objc func showGuestList() {
        guard let customers = self.customers else {
            return
        }
        let guests = VicinityCalculator(
            sourceCoordinate: self.headquartersLocation,
            customers: customers,
            distanceCalculator: HaversineDistanceCalculator())
            .computeGuestList(within: 100.0)
        animator = DraggableTransitionDelegate()
        let resultsVC = ResultsViewController(guests: guests)
        resultsVC.transitioningDelegate = animator
        resultsVC.modalPresentationStyle = .custom
        present(resultsVC, animated: true, completion: nil)
    }
}
