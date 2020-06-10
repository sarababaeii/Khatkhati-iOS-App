//
//  SignUpViewController.swift
//  Boomche
//
//  Created by Sara Babaei on 4/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
   
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func signUp(_ sender: Any) {
        nameTextField.resignFirstResponder()
        if let name = nameTextField.fetchInput() {
            RestAPIManagr.sharedInstance.signUp(username: name, email: emailTextField.text!, password: passwordTextField.text!)
        } else {
            UIApplication.topViewController()?.showToast(message: "All Fields Must Be Fill")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
    }
    
    func setTexts() {
        emailTextField.text = LoginViewController.email
        passwordTextField.text = LoginViewController.password
    }
    
    func configure() {
        setTexts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setGradientSizes()
    }
}
