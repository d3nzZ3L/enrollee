//
//  RequestProtocol.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 19.03.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import Foundation
import Alamofire

var baseURLString = "http://127.0.0.1:8000"

protocol Request {
    func baseURL () -> String
    func path () -> String
    func method () -> HTTPMethod
    mutating func setAuthorizationToken(token: String?)
    var parameters: Parameters? { get set }
    var headers: HTTPHeaders? { get set }
}

extension Request {
    func baseURL () -> String {
        return baseURLString
    }
    
    mutating func setAuthorizationToken(token: String?) {
        guard let token = token else {
            return
        }
        if (headers == nil) {
            headers = [:]
        }
        headers?["Authorization"] = "Token " + token
    }
    
    func checkConnection() {
        let networkReachablity = Alamofire.NetworkReachabilityManager(host: baseURL())
        if !(networkReachablity?.isReachableOnWWAN)! {
            baseURLString = "http://192.168.1.25:8000"
            print("BASE URL WAS CHANGED")
        } else {
            baseURLString = "http://127.0.0.1:8000"
        }
    }
}
