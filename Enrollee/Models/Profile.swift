//
//  Profile.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 18.05.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import Foundation
import RealmSwift

class Profile: Object {
    @objc dynamic var firstname = ""
    @objc dynamic var lastname = ""
    @objc dynamic var phone = ""
    @objc dynamic var email = ""
    @objc dynamic var password = ""
    @objc dynamic var school: School?
    let exams = List<Exam>()
    @objc dynamic var department: Department?
    @objc dynamic var course: Course?
    
    override class func primaryKey() -> String? {
        return "email"
    }
    
    func getFullname() -> String {
        return firstname + " " + lastname
    }
}
