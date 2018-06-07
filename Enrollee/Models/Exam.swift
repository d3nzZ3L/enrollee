//
//  Exam.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 18.05.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Exam: Object, Mappable {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
    }
}
