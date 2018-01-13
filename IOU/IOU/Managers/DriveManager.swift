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
