//
//  ProfileService.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 18.05.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import Foundation

class ProfileService {
    static let shared = ProfileService()
    var profile: Profile!
    
    private init() {
        self.profile = RealmFactory.getRealm().objects(Profile.self).first
    }
    
    func getObjectIfNecessary() {
        self.profile = RealmFactory.getRealm().objects(Profile.self).first
    }
    
    func saveCourse(_ course: Course) {
        let realm = RealmFactory.getRealm()
        do {
            try realm.write {
                profile.course = course
                realm.add(profile, update: true)
            }
        } catch let ex {
            print(ex)
        }
    }
    
    func saveProfile(profile: Profile) {
        let realm = RealmFactory.getRealm()
        do {
            try realm.write {
                realm.add(profile, update: true)
            }
        } catch let ex {
            print(ex)
        }
    }
    
    func saveSchool(_ school: School) {
        let realm = RealmFactory.getRealm()
        do {
            try realm.write {
                profile.school = school
                realm.add(profile, update: true)
            }
        } catch let ex {
            print(ex)
        }
    }
    
    func saveDepartment(_ department: Department) {
        let realm = RealmFactory.getRealm()
        do {
            try realm.write {
                profile.department = department
                realm.add(profile, update: true)
            }
        } catch let ex {
            print(ex)
        }
    }
    
    func saveExams(_ exams: [Exam]?) {
        let realm = RealmFactory.getRealm()
        do {
            try realm.write {
                if let exams = exams {
                    profile.exams.removeAll()
                    profile.exams.append(objectsIn: exams)
                }
                realm.add(profile, update: true)
            }
        } catch let ex {
            print(ex)
        }
    }
    
    func saveChanges(_ profile: Profile, firstname: String, lastname: String) {
        let realm = RealmFactory.getRealm()
        do {
            try realm.write {
                profile.firstname = firstname
                profile.lastname = lastname
                realm.add(profile, update: true)
            }
        } catch let ex {
            print(ex)
        }
    }
    
    func deleteExam(at index: Int) {
        let realm = RealmFactory.getRealm()
        do {
            try realm.write {
                profile.exams.remove(at: index)
                realm.add(profile, update: true)
            }
        } catch let ex {
            print(ex)
        }
    }
    
    func changePassOrEmail(email: String? = nil, pass: String? = nil) {
        let realm = RealmFactory.getRealm()
        do {
            try realm.write {
                if let email = email {
                    profile.email = email
                }
                if let pass = pass {
                    profile.password = pass
                }
                realm.add(profile, update: true)
            }
        } catch let ex {
            print(ex)
        }
    }
}
