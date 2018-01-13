//
//  SignInViewController.swift
//  IOU
//
//  Created by Cheese Onhead on 1/13/18.
//  Copyright © 2018 okAyStudios. All rights reserved.
//

import Foundation

class SignInViewController: UIViewController {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        GIDSignIn.sharedInstance().uiDelegate = self
    }
}

extension SignInViewController: GIDSignInUIDelegate {
    
}
