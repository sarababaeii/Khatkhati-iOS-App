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
        RestAPIManagr.sharedInstance.signUp(username: "سارا", email: emailTextField.text!, password: passwordTextField.text!)
        
//        let myUrl = URL(string: "http://boomche.ir/api/register")
//        var request = URLRequest(url:myUrl!)
//
//        request.httpMethod = "POST"// Compose a query string
//
////        request.addValue("application/json", forHTTPHeaderField: "content-type")
////        request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//        let postString = ["name": nameTextField.text!, "email": emailTextField.text!, "password": passwordTextField.text!, "c_password": passwordTextField.text!]
//
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
//        } catch let error {
//            print("Something went wrong... \(error.localizedDescription)")
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            if error != nil {
//                print("Could not successfully perform this request. Please try again later, error=\(String(describing: error))")
//                return
//            }
//
//            print("HEEEEY \(response), \((response as? HTTPURLResponse)?.statusCode)")
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
