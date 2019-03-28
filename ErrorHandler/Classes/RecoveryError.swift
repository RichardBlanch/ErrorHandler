//
//  RecoveryError.swift
//  Errorz
//
//  Created by Richard Blanchard on 3/28/19.
//  Copyright © 2019 Richard Blanchard. All rights reserved.
//

import Foundation
import UIKit

// Looseley based off of https://nshipster.com/swift-foundation-error-protocols/
public protocol RecoveryError: Error & CustomStringConvertible & CaseIterable & Equatable {
    var errorDescription: String { get }
    var failureReason: String { get }
    var recoverySuggestion: String { get }
}

