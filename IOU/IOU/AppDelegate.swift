//
//  AppDelegate.swift
//  IOU
//
//  Created by Cheese Onhead on 1/7/18.
//  Copyright © 2018 okAyStudios. All rights reserved.
//

import UIKit
import GoogleSignIn
import GoogleAPIClientForREST
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = Credentials.Google.clientID
        GIDSignIn.sharedInstance().scopes = [kGTLRAuthScopeDriveFile]
        
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().signInSilently()
        
        return true
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
}

extension AppDelegate: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard let window = window else { return }
        
        guard error == nil else {
            switch(error.getGIDSignInError()) {
            case .hasNoAuthInKeychain:
                UIViewTransitioner.transitionRootViewController(with: window, to: UIStoryboard(name: "SignIn", bundle: nil).instantiateInitialViewController())
            default:
                return
            }
            return
        }
        
        print("Has logged in: \(user.profile.name)")
        
        DriveManager.sharedInstance.initialize(authorizer: user)
        UIViewTransitioner.transitionRootViewController(with: window, to: UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController())
    }
}
