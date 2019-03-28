//
//  UIAlertController+Extension.swift
//  Errorz
//
//  Created by Richard Blanchard on 3/28/19.
//  Copyright © 2019 Richard Blanchard. All rights reserved.
//

import Foundation
import UIKit

public extension UIAlertController {
    convenience init<Error>(_ error: Error, preferredStyle: UIAlertController.Style) where Error: RecoveryError {
        let title = error.errorDescription
        let message = [ error.failureReason, error.recoverySuggestion]
            .filter { $0 != "" }
            .compactMap { $0 }.joined(separator: "\n\n")
        
        self.init(title: title, message: message,preferredStyle: .alert)
    }
}
