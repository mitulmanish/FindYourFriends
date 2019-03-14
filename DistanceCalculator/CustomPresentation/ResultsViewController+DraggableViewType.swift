//
//  ResultsViewController+DraggableViewType.swift
//  DistanceCalculator
//
//  Created by Mitul Manish on 14/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit
import Popper

extension ResultsViewController: DraggableViewType {
    
    var scrollView: UIScrollView {
        return tableView
    }
    
    func handleInteraction(enabled: Bool) {
        tableView.isUserInteractionEnabled = enabled
    }
    
    func dismissKeyboard() {}
}

