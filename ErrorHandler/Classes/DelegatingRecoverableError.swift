//
//  DelegatingRecoverableError.swift
//  Errorz
//
//  Created by Richard Blanchard on 3/28/19.
//  Copyright © 2019 Richard Blanchard. All rights reserved.
//

import Foundation

// Looseley based off of https://nshipster.com/swift-foundation-error-protocols/
struct DelegatingRecoverableError<ErrorDelegate, Error>: RecoverableError where ErrorDelegate: RecoveryErrorDelegate, Error: RecoveryError {
    private let error: Error
    private weak var delegate: ErrorDelegate? = nil
    
    init(recoveringFrom error: Error, with delegate: ErrorDelegate?) {
        self.error = error
        self.delegate = delegate
    }
    
    var recoveryOptions: [String] {
        return ErrorDelegate.RecoverableError.allCases.compactMap { "\($0)" }
    }
    
    func attemptRecovery(optionIndex recoveryOptionIndex: Int) -> Bool {
        let recoveryOptions = ErrorDelegate.RecoverableError.allCases
        let index = recoveryOptions.index(recoveryOptions.startIndex, offsetBy: recoveryOptionIndex)
        let option = ErrorDelegate.RecoverableError.allCases[index]

        return delegate?.attemptRecovery(from: option) ?? false
    }
}
