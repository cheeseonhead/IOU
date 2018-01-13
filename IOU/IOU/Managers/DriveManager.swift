//
//  DriveManager.swift
//  IOU
//
//  Created by Cheese Onhead on 1/8/18.
//  Copyright © 2018 okAyStudios. All rights reserved.
//

import Foundation
import JavaScriptCore
import GoogleSignIn
import GoogleAPIClientForREST

class DriveManager {
    
    static let sharedInstance = DriveManager()
    
    private var context: JSContext?
    
    func initialize(authorizer: GIDGoogleUser) {
        
        context = JSContext()
        guard let context = context else { return }
        
        guard let test1Path = Bundle.main.path(forResource: "test1", ofType: "js"),
            let test2Path = Bundle.main.path(forResource: "test2", ofType: "js") else {
                print("Unable to read resource files.")
                return
        }
        
        do {
            let test2 = try String(contentsOfFile: test2Path, encoding: String.Encoding.utf8)
            _ = context.evaluateScript(test2)
            let common = try String(contentsOfFile: test1Path, encoding: String.Encoding.utf8)
            _ = context.evaluateScript(common)

            let test1Var = context.objectForKeyedSubscript("test")
            print(test1Var)
            let test2Function = context.objectForKeyedSubscript("test2")
            print(test2Function)
            print(test2Function?.call(withArguments: []))
        } catch (let error) {
            print("Error while processing script file: \(error)")
        }
    }
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
