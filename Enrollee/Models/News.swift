//
//  News.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 19.03.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class News: Object, Mappable {
    @objc dynamic var title = ""
    @objc dynamic var desc = ""
    @objc dynamic var link = ""
    @objc dynamic var imgUrl = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        desc <- map["description"]
        link <- map["link"]
        imgUrl <- map["img_url"]
    }
}
