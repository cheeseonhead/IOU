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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var service = GTLRDriveService()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = Credentials.Google.clientID
        GIDSignIn.sharedInstance().scopes = [kGTLRAuthScopeDriveFile]
        
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else {
            print("\(error.localizedDescription)")
            return
        }
        
        print("Has logged in: \(user.profile.name)")
        
        
        service.authorizer = user.authentication.fetcherAuthorizer()
        
        createFile()
        listFiles()
    }
    
    func createFile() {
        
        let file = GTLRDrive_File()
        file.name = "Testing"
        file.mimeType = "application/vnd.google-apps.spreadsheet"
        
        
        let query = GTLRDriveQuery_FilesCreate.query(withObject: file, uploadParameters: nil)
        service.executeQuery(query, delegate: self, didFinish: #selector(displayCreateResultWithTicket(ticket:finishedWithObject:error:)))
    }
    
    @objc func displayCreateResultWithTicket(ticket: GTLRServiceTicket,
                                       finishedWithObject result: GTLRDrive_File,
                                       error: NSError?) {
        guard error == nil else {
            print("Error: \(error?.localizedDescription)")
            return
        }
        
        print("File has been created: \(result.name)")
    }
    
    func listFiles() {
        let query = GTLRDriveQuery_FilesList.query()
        query.corpora = "user"
        query.pageSize = 10
        service.executeQuery(query,
                             delegate: self,
                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:))
        )
    }
    
    // Process the response and display output
    @objc func displayResultWithTicket(ticket: GTLRServiceTicket,
                                 finishedWithObject result : GTLRDrive_FileList,
                                 error : NSError?) {
        
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        var text = "";
        if let files = result.files, !files.isEmpty {
            text += "Files:\n"
            for file in files {
                text += "\(file.name!) (\(file.identifier!))\n"
            }
        } else {
            text += "No files found."
        }
        
        print(text)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else {
            print("\(error.localizedDescription)")
            return
        }
        
        print("Has disconnected: \(user.profile.name)")
    }
}
