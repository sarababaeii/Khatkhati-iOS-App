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
    
    @IBAction func signIn(_ sender: Any) {
        RestAPIManagr.sharedInstance.login(email: emailTextField.text!, password: passwordTextField.text!)
//        let myUrl = URL(string: "http://boomche.ir/api/login")
//        var request = URLRequest(url:myUrl!)
//
//        request.httpMethod = "POST"// Compose a query string
////        request.addValue("application/json", forHTTPHeaderField: "content-type")
////        request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//        let postString = ["email": emailTextField.text!, "password": passwordTextField.text!]
//
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
//        } catch let error {
//            print("Something went wrong... \(error.localizedDescription)")
//            return
//        }
//
//
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            if error != nil {
//                print("Could not successfully perform this request. Please try again later, error=\(String(describing: error))")
//                return
//            }
//
//            print("HEEEEY \((response as? HTTPURLResponse)?.statusCode)")
        //Let's convert response sent from a server side code to a NSDictionary object:
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
//
//                if let parseJSON = json {
//
//                    if parseJSON["errorMessageKey"] != nil {
//                         print("SHIT \(parseJSON["errorMessage"] as! String)")
//                        return
//                    }
//                    // Now we can access value of First Name by its key
//                    let accessToken = parseJSON["token"] as? String
//                    let userId = parseJSON["id"] as? String
////                    print("Access token: \(String(describing: accessToken!))")
//
////                    let saveAccesssToken: Bool = KeychainWrapper.standard.set(accessToken!, forKey: "accessToken")
//                    let saveUserId: Bool = KeychainWrapper.standard.set(userId!, forKey: "userId")
//
////                    print("The access token save result: \(saveAccesssToken)")
//                    print("The userId save result \(saveUserId)")
//
//                    if (accessToken?.isEmpty)! {
//                        // Display an Alert dialog with a friendly error message
//                        print("Could not successfully perform this request. Please try again later")
//                        return
//                    }
//
//                    DispatchQueue.main.async {
//                            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//                            let appDelegate = UIApplication.shared.delegate
//                            appDelegate?.window??.rootViewController = homePage
//                    }
//
//                } else {
//                    //Display an Alert dialog with a friendly error message
//                    print("Could not successfully perform this request. Please try again later")
//                }
//
//            } catch {
//                // Display an Alert dialog with a friendly error message
//                print("Could not successfully perform this request. Please try again later")
//                print(error)
//            }
//        }
//        task.resume()
        print("WE DID IT!")
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
