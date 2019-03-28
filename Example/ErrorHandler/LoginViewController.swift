//
//  LoginViewController.swift
//  SampleProject
//
//  Created by Richard Blanchard on 3/28/19.
//  Copyright © 2019 Richard Blanchard. All rights reserved.
//

import Foundation
import UIKit
import ErrorHandler

class LoginViewController: UIViewController {
    @IBOutlet private weak var loginTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        do {
            try validateEmail(login: loginTextfield.text, password: passwordTextfield.text)
            title = "Login Success!"
        } catch {
            guard let recoverableError = error as? LoginError else { return }
            handleError(recoverableError: recoverableError)
        }
    }
    
    private func validateEmail(login: String?, password: String?) throws {
        guard login?.contains(".com") ?? false else { throw LoginError.invalidEmail }
        guard (password?.count ?? 0 > 8)  else { throw LoginError.wrongPassword }
        
        return
    }
}

extension LoginViewController: RecoveryErrorDelegate {
    typealias RecoverableError = LoginError
    
    func attemptRecovery(from recoverableError: LoginError) -> Bool {
        switch recoverableError {
        default: showAlert(from: recoverableError)
        }
        
        return true
    }
}
