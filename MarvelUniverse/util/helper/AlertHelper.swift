//
//  AlertHelper.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 24/10/21.
//

import UIKit

struct AlertHelper {
    
    /// Displays an Alert on given ViewController
    /// - Parameters:
    ///   - viewController: ViewController presenting the alert
    ///   - title: Alert title
    ///   - message: Info message
    ///   - actionTitle: Name of the action
    static func showBasicAlert(on viewController: UIViewController, with title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alert.addAction(action)
        DispatchQueue.main.async {
            viewController.present(alert, animated: true)
        }
    }
    
}
