//
//  UIStoryboard+Instantiate.swift
//  IOU
//
//  Created by Cheese Onhead on 1/13/18.
//  Copyright © 2018 okAyStudios. All rights reserved.
//

import Foundation

extension UIStoryboard {
    static func instantiateInitialVC(name: String) -> UIViewController {
        guard let vc = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController() else {
            fatalError("Failed to instantiate view controller in storyboard: \(name)")
        }
        
        return vc
    }
}
