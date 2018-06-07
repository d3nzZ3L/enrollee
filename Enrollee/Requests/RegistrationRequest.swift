//
//  RegistrationRequest.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 19.03.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import Foundation
import Alamofire

class RegistrationRequest: Request {
    var parameters: Parameters?
    var headers: HTTPHeaders?
    
    func path() -> String {
        return baseURL() + "/api/registration/"
    }
    
    func method() -> HTTPMethod {
        return .post
    }
}
