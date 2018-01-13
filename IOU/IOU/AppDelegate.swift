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
        guard error == nil else {
            return
        }
        
        print("Has logged in: \(user.profile.name)")
        
        DriveManager.sharedInstance.initialize(authorizer: user)
        
//        createFile()
//        listFiles()
    }
//
//    func createFile() {
//
//        let file = GTLRDrive_File()
//        file.name = "Testing"
//        file.mimeType = "application/vnd.google-apps.spreadsheet"
//
//
//        let query = GTLRDriveQuery_FilesCreate.query(withObject: file, uploadParameters: nil)
//        service.executeQuery(query, delegate: self, didFinish: #selector(displayCreateResultWithTicket(ticket:finishedWithObject:error:)))
//    }
//
//    @objc func displayCreateResultWithTicket(ticket: GTLRServiceTicket,
//                                       finishedWithObject result: GTLRDrive_File,
//                                       error: NSError?) {
//        guard error == nil else {
//            print("Error: \(error?.localizedDescription)")
//            return
//        }
//
//        print("File has been created: \(result.name)")
//    }
//
//    func listFiles() {
//        let query = GTLRDriveQuery_FilesList.query()
//        query.corpora = "user"
//        query.pageSize = 10
//        service.executeQuery(query,
//                             delegate: self,
//                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:))
//        )
//    }
//
//    // Process the response and display output
//    @objc func displayResultWithTicket(ticket: GTLRServiceTicket,
//                                 finishedWithObject result : GTLRDrive_FileList,
//                                 error : NSError?) {
//
//        if let error = error {
//            print("Error: \(error.localizedDescription)")
//            return
//        }
//
//        var text = "";
//        if let files = result.files, !files.isEmpty {
//            text += "Files:\n"
//            for file in files {
//                text += "\(file.name!) (\(file.identifier!))\n"
//            }
//        } else {
//            text += "No files found."
//        }
//
//        print(text)
//    }
//
//    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
//        guard error == nil else {
//            print("\(error.localizedDescription)")
//            return
//        }
//
//        print("Has disconnected: \(user.profile.name)")
//    }
}
