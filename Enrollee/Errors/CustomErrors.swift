//
//  CustomErrors.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 19.03.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import Foundation
import ObjectMapper

extension NSError {
    func getDescription() -> String {
        guard let customDescription = userInfo["description"] as? String else {
            return localizedDescription
        }
        return customDescription
    }
}

class ObjectMappingError: NSError {
    init() {
        super.init(domain: "Enrollee", code: 1000, userInfo: ["description": "Object Mapping Error"])
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
}
