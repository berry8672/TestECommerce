//
//  UITextField+Extension.swift
//  ECommerce
//
//  Created by Berlin Raj on 05/02/22.
//

import Foundation
import UIKit

extension UITextField {
    var isEmpty: Bool {
        return self.text?.isEmpty ?? true
    }
}
