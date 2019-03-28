//
//  ViewController.swift
//  SampleProject
//
//  Created by Richard Blanchard on 3/28/19.
//  Copyright © 2019 Richard Blanchard. All rights reserved.
//

import UIKit
import ErrorHandler

class ViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        do {
            try Networking.shared.fetchBadURL { [weak self] (result) in
                switch result {
                case .success(let stringValue):
                    self?.title = stringValue
                case .failure(let recoverableError):
                    self?.handleError(recoverableError: recoverableError)
                }
            }
        } catch {
            guard let error = error as? RecoverableError else { return }
            handleError(recoverableError: error)
        }
    }
    
    func updateTitle(from result: Result<String, NetworkingError>) {
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success(let stringValue):
                self?.title = stringValue
            case .failure(let recoverableError):
                self?.handleError(recoverableError: recoverableError)
            }
        }
    }
}

extension ViewController: RecoveryErrorDelegate {
    typealias RecoverableError = NetworkingError
    
    func attemptRecovery(from recoverableError: NetworkingError) -> Bool {
        switch recoverableError {
        case .badURL:
            do {
                // update title with new url in 5 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
                    guard let self = self else { return }

                    do {
                        try Networking.shared.fetchGoodURL({ (result) in
                            self.updateTitle(from: result)
                        })
                    } catch {
                         if let recoveryError = error as? RecoverableError {
                            DispatchQueue.main.async {
                                self.showAlert(from: recoveryError)
                            }
                        }
                    }
                }
            }
        case .noData, .genericError:
            showAlert(from: recoverableError)
        }
        
        return true
    }
}

