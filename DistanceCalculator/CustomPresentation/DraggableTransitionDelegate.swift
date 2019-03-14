//
//  DraggableTransitionDelegate.swift
//  DistanceCalculator
//
//  Created by Mitul Manish on 14/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit
import Popper

class DraggableTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DraggablePresentationController(presentedViewController: presented, presenting: source)
    }
}
