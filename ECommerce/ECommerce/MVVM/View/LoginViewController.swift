//
//  LoginViewController.swift
//  ECommerce
//
//  Created by Berlin Raj on 05/02/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonLoginAction () {
        if self.textFieldUserName.isEmpty {
            showAlert("Please enter Username") { _ in
                self.textFieldUserName.becomeFirstResponder()
            }
        } else if self.textFieldPassword.isEmpty {
            showAlert("Please enter Password") { _ in
                self.textFieldPassword.becomeFirstResponder()
            }
        } else {
            LoginUser.login(userName: self.textFieldUserName.text!, password: textFieldPassword.text!) { user in
                LoginUser.currentUser = user
                (UIApplication.shared.delegate as? AppDelegate)?.checkAutoLogin()
            } failureBlock: { errorMessage in
                self.showAlert(errorMessage)
            }
        }
    }
}
