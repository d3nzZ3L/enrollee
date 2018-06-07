//
//  TokenService.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 19.03.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import Foundation

class TokenService {
    static let shared = TokenService()
    private let tokenKey = "token"
    private let defaults = UserDefaults.standard
    
    var token: String? {
        get {
            return defaults.string(forKey: tokenKey)
        } set {
            defaults.set(newValue, forKey: tokenKey)
            defaults.synchronize()
        }
    }
    
    private init() { }
}
