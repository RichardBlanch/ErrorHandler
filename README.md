# ErrorHandler

[![CI Status](https://img.shields.io/travis/RichardBlanch/ErrorHandler.svg?style=flat)](https://travis-ci.org/RichardBlanch/ErrorHandler)
[![Version](https://img.shields.io/cocoapods/v/ErrorHandler.svg?style=flat)](https://cocoapods.org/pods/ErrorHandler)
[![License](https://img.shields.io/cocoapods/l/ErrorHandler.svg?style=flat)](https://cocoapods.org/pods/ErrorHandler)
[![Platform](https://img.shields.io/cocoapods/p/ErrorHandler.svg?style=flat)](https://cocoapods.org/pods/ErrorHandler)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ErrorHandler is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RBErrorHandler'
```

## How To Use

1. Create a new Error Type and conform to RecoveryError.

```Swift
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
```

2. Conform a ViewController to RecoveryErrorDelegate

```Swift
    extension ViewController: RecoveryErrorDelegate {
    typealias RecoverableError = NetworkingError

    func attemptRecovery(from recoverableError: NetworkingError) -> Bool {
    switch recoverableError {
    case .badURL: // Fetch new url (here is where we try and recover)
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
            self.showAlert(from: recoveryError)
        }
    }
    case .noData, .genericError: (just show an alert from this error.)
    showAlert(from: recoverableError)
    }

    return true
    }
}
```





## Author

RichardBlanch, rblanchard@grio.com

## License

ErrorHandler is available under the MIT license. See the LICENSE file for more info.
