//
//  UIViewController+Alert.swift
//  ECommerce
//
//  Created by Berlin Raj on 05/02/22.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert (title: String = "Alert", _ message: String, _ actions: [String] = ["Ok"], _ completion: ((Int)->Void)? = nil) {
        let alertVC = UIAlertController(title: "title", message: message, preferredStyle: UIAlertController.Style.alert)
        
        for (index, action) in actions.enumerated() {
            let alertAction = UIAlertAction(title: action, style: UIAlertAction.Style.default) { action in
                completion?(index)
            }
            alertVC.addAction(alertAction)
        }
        
        self.present(alertVC, animated: true, completion: nil)
    }
}
