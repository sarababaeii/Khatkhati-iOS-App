//
//  REST_API_Manager.swift
//  Boomche
//
//  Created by Sara Babaei on 6/5/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation

private struct API {
    private static let base = "http://boomche.ir/api/"
    private static let login = API.base + "login"
    private static let signUp = API.base + "register"
        
    static let loginhURL = URL(string: API.login)!
    static let signUpURL = URL(string: API.signUp)!
}

class RestAPIManagr {
    static let sharedInstance = RestAPIManagr()
    
    func createRequest(url: URL, params: [String: Any]) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = params.map{ "\($0)=\($1)" }
            .joined(separator: "&")
        request.httpBody = body.data(using: .utf8)

        return request
    }
    
    func createLoginRequest(email: String, password: String) -> URLRequest {
        let params = ["email": email, "password": password]
        return createRequest(url: API.loginhURL, params: params)
    }
    
    func createSignUpRequest(username: String, email: String, password: String) -> URLRequest {
        let params = ["name": username, "email": email, "password": password, "c_password": password]
        return createRequest(url: API.signUpURL, params: params)
    }
    
    func login(email: String, password: String) {
        
        let session = URLSession(configuration: .default)
        let request = createLoginRequest(email: email, password: password)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                // response needs processing
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    print("YUUUUUHUUUU")
                    print("response \(response)")
                    print("heeeey")
                    for kuft in data! {
                        print(kuft)
                    }
                   print("hoooy")
                   print("Error: \(String(describing: error))")
                } else {
                    print("errooooooooor1 \((response as? HTTPURLResponse)?.statusCode)")
                }
            } else {
                print("errooooooooor0 \(error.debugDescription)")
            }
        }
        task.resume()
    }
    
    func signUp(username: String, email: String, password: String) {
        
        let session = URLSession(configuration: .default)
        let request = createSignUpRequest(username:username, email: email, password: password)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                // response needs processing
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                   
                } else {
                    print("errooooooooor1 \((response as? HTTPURLResponse)?.statusCode)")
                }
            } else {
                print("errooooooooor0 \(error.debugDescription)")
            }
        }
        task.resume()
    }
}
