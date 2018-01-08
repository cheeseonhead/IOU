//
//  FirstViewController.swift
//  IOU
//
//  Created by Cheese Onhead on 1/7/18.
//  Copyright © 2018 okAyStudios. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.style = .iconOnly
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        GIDSignIn.sharedInstance().signInSilently()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension FirstViewController: GIDSignInUIDelegate {
    
}
