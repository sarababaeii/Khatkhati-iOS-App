//
//  LoginViewController.swift
//  Boomche
//
//  Created by Sara Babaei on 4/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
   
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var startButton: CustomButton!
    
    @IBAction func textFieldSelected(_ sender: Any) {
        (sender as! UITextField).layer.backgroundColor = Colors.yellow.componentColor?.lightBackground.cgColor
    }
    
    
    //MARK: UI Handling
    func setEmailTextFieldAttributes() {
        emailTextField.setLeftIcon(icon: UIImage(named: "Email")!, padding: 24)
        emailTextField.layer.cornerRadius = 29
        
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = Colors.gray.componentColor?.border?.cgColor
    }
    
    func setPasswordTextFieldAttributes() {
        passwordTextField.setLeftIcon(icon: UIImage(named: "Lock")!, padding: 24)
        passwordTextField.layer.cornerRadius = 29
        
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = Colors.gray.componentColor?.border?.cgColor
    }
    
    func setStartButtonAttributes() {
        startButton.setCornerRadius(radius: 25)
        startButton.setBackgroundColor(color: Colors.yellow.componentColor!)
        startButton.setShadowColor(color: Colors.yellow.componentColor!)
    }
    
    func configure() {
        setEmailTextFieldAttributes()
        setPasswordTextFieldAttributes()
        setStartButtonAttributes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        configure()
    }
}

//TODO: Show selected
