//
//  NetworkingError.swift
//  SampleProject
//
//  Created by Richard Blanchard on 3/28/19.
//  Copyright © 2019 Richard Blanchard. All rights reserved.
//

import Foundation
import ErrorHandler

enum NetworkingError {
    case badURL
    case noData
    case genericError(Error?)
}

extension NetworkingError: CaseIterable {
    static var allCases: [NetworkingError] {
        return [.badURL, noData, .genericError(nil)]
    }
}

extension NetworkingError: RecoveryError {
    var errorDescription: String {
        switch self {
        case .badURL: return "Error!"
        case .noData: return "Error!"
        case .genericError: return "Error!"
        }
    }
    

    var failureReason: String {
        switch self {
        case .badURL: return "Could not construct URL"
        case .noData: return "Could not create data from response"
        case .genericError(let error): return error.failureReason
        }
    }
    
    var recoverySuggestion: String {
        switch self {
        case .badURL: return ""
        case .noData: return ""
        case .genericError(let error): return error.recoverySuggestion
        }
    }
    
    static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        switch (lhs, rhs) {
        case (.badURL, badURL): return true
        case (.noData, noData): return true
        case (.genericError(let errorOne), .genericError(let errorTwo)): return (errorOne as NSError?) == (errorTwo as NSError?)
        default: return false
        }
    }
    
    var description: String {
        switch self {
        case .badURL: return "Malformed URL"
        case .noData: return "noData"
        case .genericError: return "genericError"
        }
    }
}
