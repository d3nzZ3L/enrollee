//
//  Course.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 18.05.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Course: Object, Mappable {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var departmentId = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["title"]
        departmentId <- map["department_id"]
    }
}
