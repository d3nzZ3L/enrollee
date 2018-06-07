//
//  AuthenticationService.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 19.03.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import Foundation
import Alamofire

class AuthenticationService {
    static let shared = AuthenticationService()
    
    private init() { }
    
    func registration(email: String, password: String, completion: @escaping(_ error: NSError?) -> Void) {
        let request = RegistrationRequest()
        request.parameters = ["email" : email, "password" : password]
        Alamofire.request(request.path(), method: request.method(), parameters: request.parameters).validate().responseJSON { (response) in
            guard response.error == nil else {
                completion(response.error! as NSError)
                return
            }
            completion(nil)
        }
    }
    
    func authorize(email: String, password: String, completion: @escaping(_ error: NSError?) -> Void) {
        let request = AuthenticationRequest()
        request.parameters = ["email" : email, "password" : password]
        Alamofire.request(request.path(), method: request.method(), parameters: request.parameters, headers: request.headers).validate().responseJSON { (response) in
            guard response.error == nil else {
                completion(response.error! as NSError)
                return
            }
            guard let result = response.result.value as? [String : String] else {
                completion(ObjectMappingError())
                return
            }
            if let token = result["token"] {
                TokenService.shared.token = token
            }
            completion(nil)
        }
    }
}
