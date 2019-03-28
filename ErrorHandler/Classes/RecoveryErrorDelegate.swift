//
//  RecoveryErrorDelegate.swift
//  Errorz
//
//  Created by Richard Blanchard on 3/28/19.
//  Copyright © 2019 Richard Blanchard. All rights reserved.
//

import Foundation
import UIKit

// Looseley based off of https://nshipster.com/swift-foundation-error-protocols/
public protocol RecoveryErrorDelegate: class {
    associatedtype RecoverableError: RecoveryError
    
    func attemptRecovery(from recoverableError: RecoverableError) -> Bool
}

extension RecoveryErrorDelegate where Self: UIViewController {
    public func handleError<T: RecoveryError>(recoverableError: T) {
        let error = DelegatingRecoverableError(recoveringFrom: recoverableError, with: self)
        
        let index = RecoverableError.allCases.compactMap { $0 as? T }.firstIndex(where: { $0 == recoverableError }) ?? 0
        
        
        _ = error.attemptRecovery(optionIndex: index)
        
    
    }
    
    public func showAlert<T: RecoveryError>(from recoveryError: T) {
        let alertController = UIAlertController(recoveryError, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
}
