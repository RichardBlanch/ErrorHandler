//
//  LoginError.swift
//  SampleProject
//
//  Created by Richard Blanchard on 3/28/19.
//  Copyright © 2019 Richard Blanchard. All rights reserved.
//

import Foundation
import ErrorHandler

enum LoginError: RecoveryError {
    typealias RawValue = String
    
    case invalidEmail
    case wrongPassword
    
    var errorDescription: String {
        switch self {
        case .invalidEmail: return "Error!"
        case .wrongPassword: return "Error!"
        }
    }

    var description: String {
        switch self {
        case .invalidEmail: return "Invalid Email"
        case .wrongPassword: return "Wrong Password"
        }
    }
    
    var failureReason: String {
        switch self {
        case .invalidEmail:
            return "You entered an invalid email."
        case .wrongPassword:
            return "You entered less than 8 characters"
        }
    }
    
    var recoverySuggestion: String {
        switch self {
        case .invalidEmail: return "Please postfix with .com"
        case .wrongPassword: return "Please Enter At least 8 characters"
        }
    }
}
