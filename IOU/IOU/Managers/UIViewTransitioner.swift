//
//  UIViewTransitioner.swift
//  IOU
//
//  Created by Cheese Onhead on 1/13/18.
//  Copyright © 2018 okAyStudios. All rights reserved.
//

import UIKit

class UIViewTransitioner {
    static func transitionRootViewController(with window: UIWindow, to viewController: UIViewController) {
        viewController.view.frame = window.frame
        viewController.view.layoutIfNeeded()
        DispatchQueue.main.async {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = viewController
            }, completion: nil)
        }
    }
}
