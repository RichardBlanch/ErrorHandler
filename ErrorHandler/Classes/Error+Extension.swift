//
//  Error+Extension.swift
//  Errorz
//
//  Created by Richard Blanchard on 3/28/19.
//  Copyright © 2019 Richard Blanchard. All rights reserved.
//

import Foundation

extension Optional where Wrapped: Error {
    public var failureReason: String {
        return value(for: NSLocalizedFailureReasonErrorKey)
    }
    
    public var recoverySuggestion: String {
        return value(for: NSLocalizedRecoverySuggestionErrorKey)
    }
    
    private func value(for key: String) -> String {
        let defaultString = ""
        guard let self = self else { return defaultString }

        return (self as NSError).userInfo[key] as? String ?? defaultString
    }
    
}
