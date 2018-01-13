//
//  Error+GIDSignIn.swift
//  IOU
//
//  Created by Cheese Onhead on 1/13/18.
//  Copyright © 2018 okAyStudios. All rights reserved.
//

import Foundation

enum GIDSignInError {
    case unknown
    case keychain
    case noSignInHandlersInstalled
    case hasNoAuthInKeychain
    case canceled
    case notConnected
}

extension Error {
    func getGIDSignInError() -> GIDSignInError {
        let errorCode = (self as NSError).code
        
        switch (errorCode) {
        case -2:
            return .keychain
        case -3:
            return .noSignInHandlersInstalled
        case -4:
            return .hasNoAuthInKeychain
        case -5:
            return .canceled
        case -1009:
            return .notConnected
        default:
            return .unknown
        }
    }
}
