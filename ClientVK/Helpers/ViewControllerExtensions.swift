//
//  ViewControllerExtensions.swift
//  ClientVK
//
//  Created by Denis Molkov on 21.02.2021.
//

import UIKit

extension UIViewController {
    func customAllert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
