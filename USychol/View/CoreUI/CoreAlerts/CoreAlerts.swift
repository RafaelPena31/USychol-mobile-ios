//
//  CoreAlerts.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 17/08/21.
//

import UIKit

class CoreAlerts {
    public func handleCreateFormAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Notice", message: "All fields that receive invalid data, when saved, will be replaced with the old data :)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        
        return alert
    }
    
    public func handleDefaultAlert(title: String, message: String, buttonText: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: nil))
        
        return alert
    }
    
    public func handleErrorAlert(title: String, message: String, buttonText: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .destructive, handler: nil))
        
        return alert
    }
}
