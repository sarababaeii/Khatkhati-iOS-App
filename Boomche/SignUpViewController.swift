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
   
    @IBOutlet weak var startButton: CustomButton!
    
    func setImageViewAttributes() {
        imageView.layer.cornerRadius = 68.5
    }
    
    func setNameTextFieldAttributes() {
        nameTextField.layer.borderWidth = 0
    }
    
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
        setImageViewAttributes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        configure()
    }
}

//TODO: blue line, functionality, border of textFields
