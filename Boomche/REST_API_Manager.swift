//
//  REST_API_Manager.swift
//  Boomche
//
//  Created by Sara Babaei on 6/5/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class RestAPIManagr {
    private struct API {
        private static let base = "http://boomche.ir/api/"
        private static let login = API.base + "login"
        private static let signUp = API.base + "register"
            
        static let loginhURL = URL(string: API.login)!
        static let signUpURL = URL(string: API.signUp)!
    }
    
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
    
    func postRequest(request: URLRequest) {
        let session = URLSession(configuration: .default)

        var code = 0
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data, let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(responseJSON)
            }
            code = self.checkResponse(data: data, response: response as? HTTPURLResponse, error: error)
        }
        task.resume()
        
        while true {
            if code != 0 { //task.state == .completed
                action(response: code)
                return
            }
        }
    }
    
    func action(response: Int) {
        if response == 200 {
            UIApplication.topViewController()?.showNextPage(identifier: "HomeViewController")
            //TODO: get token, set me, connect to socket
        } else if response == 401{
            UIApplication.topViewController()?.showNextPage(identifier: "SignUpViewController")
        } else {
            print("Error1 \(response)")
        }
    }
    
    func checkResponse(data: Data?, response: HTTPURLResponse?, error: Error?) -> Int{
        if error == nil, let response = response {
            return response.statusCode
        }
        print("Error0 \(error.debugDescription)")
        return 1
    }
    
    func login(email: String, password: String) {
        postRequest(request: createLoginRequest(email: email, password: password))
    }
    
    func signUp(username: String, email: String, password: String) {
        postRequest(request: createSignUpRequest(username:username, email: email, password: password))
    }
}
