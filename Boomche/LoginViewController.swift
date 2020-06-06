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
}

//TODO: Show selected


//WE DID IT!
//HEEEEY Optional(<NSHTTPURLResponse: 0x280d28b40> { URL: http://boomche.ir/api/login } { Status Code: 422, Headers {
//    "Cache-Control" =     (
//        "private, must-revalidate"
//    );
//    Connection =     (
//        "keep-alive"
//    );
//    "Content-Type" =     (
//        "application/json"
//    );
//    Date =     (
//        "Thu, 04 Jun 2020 17:40:37 GMT"
//    );
//    Expires =     (
//        "-1"
//    );
//    Pragma =     (
//        "no-cache"
//    );
//    Server =     (
//        "nginx/1.14.0 (Ubuntu)"
//    );
//    "Transfer-Encoding" =     (
//        Identity
//    );
//    "X-Powered-By" =     (
//        "PHP/7.4.2"
//    );
//    "X-RateLimit-Limit" =     (
//        60
//    );
//    "X-RateLimit-Remaining" =     (
//        59
//    );
//} })


//response <NSHTTPURLResponse: 0x28327d120> { URL: http://boomche.ir/api/login } { Status Code: 200, Headers {
//    Connection =     (
//        "keep-alive"
//    );
//    "Content-Encoding" =     (
//        gzip
//    );
//    "Content-Type" =     (
//        "text/html; charset=UTF-8"
//    );
//    Date =     (
//        "Sat, 06 Jun 2020 13:19:21 GMT"
//    );
//    Server =     (
//        "nginx/1.14.0 (Ubuntu)"
//    );
//    "Transfer-Encoding" =     (
//        Identity
//    );
//    Vary =     (
//        "Accept-Encoding"
//    );
//    "X-Powered-By" =     (
//        "PHP/7.4.2"
//    );
//} }
