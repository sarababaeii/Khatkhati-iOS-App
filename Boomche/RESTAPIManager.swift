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
    
    var accessToken: String?
    var refreshToken: String?
    
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
            self.setToken(data: data)
            code = self.checkResponse(response: response as? HTTPURLResponse, error: error)
        }
        task.resume()
        
        while true {
            if code != 0 { //task.state == .completed
                action(response: code)
                return
            }
        }
    }
    
    func setToken(data: Data?) {
        guard let data = data, let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return
        }
        print(responseJSON as Any)
        if let token = responseJSON["access_token"] as? String {
            accessToken = token
        }
        if let token = responseJSON["refresh_token"] as? String {
            refreshToken = token
        }
    }
    
    func checkResponse(response: HTTPURLResponse?, error: Error?) -> Int{
        if error == nil, let response = response {
            return response.statusCode
        }
        print("Error0 \(error.debugDescription)")
        return 1
    }
    
    func action(response: Int) {
        if response == 200 {
            UIApplication.topViewController()?.showNextPage(identifier: "HomeViewController")
            SocketIOManager.sharedInstance.establishConnection()
            //TODO: set me
        } else if response == 401{
            UIApplication.topViewController()?.showNextPage(identifier: "SignUpViewController")
        } else {
            print("Error1 \(response)")
        }
    }
    
    func login(email: String, password: String) {
        postRequest(request: createLoginRequest(email: email, password: password))
    }
    
    func signUp(username: String, email: String, password: String) {
        postRequest(request: createSignUpRequest(username:username, email: email, password: password))
    }
}

//Optional(["expires_in": 31536000, "token_type": Bearer, "access_token": eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiMTc2MjAxZjk1OWRiMjk2YTQ2ODE5Y2ExZjdjMDk4MDZkZTUzZDY0ODQ2YTgxYjU5ZjZmNjEzZDcyMmQzYmRlYTgxNjhkMTk4ODZmMWNmZTQiLCJpYXQiOjE1OTE2MzE2NzAsIm5iZiI6MTU5MTYzMTY3MCwiZXhwIjoxNjIzMTY3NjcwLCJzdWIiOiIxMyIsInNjb3BlcyI6WyIqIl19.wfRC02Ue5Panmxqkq1lEq7kaixvBaJxkEI_qOFVO0op546ZA-Z2Rewg4QrQP5mHNFcwWIs6xDb3xbRr1UG27iBQ5aaCfuTEIIs-AYXDeXDwejRXCOV4LetxhvEIPFh3G4n-mo-RFfG-s1QumBaC7Di4nZLVqLcy3-WWonucCdyce6Bs92gjVqtL23_TUDfyQg8S5ZIoXNtEuzZQIIsMED7pfEUEzbcUUuNFiOOdbT_G5gP_L10vt65-cS1fxt3XWg3Xs_6dgA6QvU00YRBu-y6xm4YAYQnZvzdxHUR_5YMD8Lq2Fp40cDZJD0AEFHyL4KYCYzRpBI_ZTsDctqaYT2sbWRgGs5cbYGaEjfT83HG3M_oNSz3Hu2CiC1M253MrMNuuK7iLH8b4GWiHMFvy1Sb0EiMuj_cBpNyK1kbQNYCmBbWpx7CMmT9sdCG90GKpACiJbkEZzZY-Xpev-smJZTJCNKNpGLpIm0d18NCgx0pTbm380nM2EWE5PZ6YknIjrirAsIA9bLvn-nG_eS---63N3p13wPA3XegRlfIxxgQQ9dRVrXKGFlWkZEN57HUnA8GBR16afLKau7xavQtUpDCWPXRPo6_JaDVJ2lbgk6smIsR50eOQ9aZ37th2w5nnn7qoJsASAvL3Cx6bbNV_esWKS9RzLk9GaMmry9khRi4k, "refresh_token": def50200a023305d528ed88e66eb7cd88cd3bd1bf0ac41d9c115fb9c4226a8bf994a7ce3e1484d7a195135bb28d48e1a2847558eee6cdcdc8dc56ed2a14d14b3fdc189c12f9119e8b169cc904508f3e6f4a613a6cd55381e58e7e052e298eb8b5d0d2a08f0908af675946bdf1056aba11b693c666cbf3d117f94035f5346b34f617fea546b9a4945a47511d45a54515d475c39b4853d91b1d6cda9cc713d052e5133f3547e093df9d872095af56b4fb3c3334ec6eef3f1889944721cc41d7af6d83f23909a642c4f887f621d59f5846b4adcfe076218d74ba26acd8a3c5169b43787b19fa14224e34b4d513e5ed9327224e5b5f1eadcc520c987469050cf93e6f7e1db1d0b132702dc3425d4d98e96f32f35b381f15c40b25807909961d62ba55709634c6e8eec4352449980ff7bffe28a9e21940b30d603c3bb98a49924551e6bcf98a8acbdb155b720570549eec7cab11de846865dd6b9213cfa67529cee9b7a94f6bbcb])
