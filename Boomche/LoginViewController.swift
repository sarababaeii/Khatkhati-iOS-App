//
//  LoginViewController.swift
//  Boomche
//
//  Created by Sara Babaei on 4/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit
import SwiftKeychainWrapper

class LoginViewController: UIViewController {
   
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var startButton: UIButton!
    
    static var email: String = ""
    static var password: String = ""
    
    @IBAction func signIn(_ sender: Any) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        if !setTexts() {
            return
        }
        RestAPIManagr.sharedInstance.login(email: LoginViewController.email, password: LoginViewController.password)
    }
    
    func setTexts() -> Bool {
        if let email = emailTextField.fetchInput(), let password = passwordTextField.fetchInput() {
            LoginViewController.email = email
            LoginViewController.password = password
            return true
        }
        UIApplication.topViewController()?.showToast(message: "All Fields Must Be Fill")
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setGradientSizes()
    }
}
//TODO: Show selected
