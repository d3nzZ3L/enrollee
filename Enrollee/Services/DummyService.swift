//
//  DummyService.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 18.05.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import ObjectMapper

class DummyService {
    static let shared = DummyService()
    var schools: Results<School>!
    var exams: Results<Exam>!
    var departments: Results<Department>!
    var courses: Results<Course>!
    
    private init() {
        let realm = RealmFactory.getRealm()
        if realm.objects(Department.self).count == 0 {
            getDepartments()
            self.departments = realm.objects(Department.self)
        } else {
            self.departments = realm.objects(Department.self)
        }
        if realm.objects(Course.self).count == 0 {
            getCourses()
            self.courses = realm.objects(Course.self)
        } else {
            self.courses = realm.objects(Course.self)
        }
        if realm.objects(School.self).count == 0 {
            getSchools()
            self.schools = realm.objects(School.self)
        } else {
            self.schools = realm.objects(School.self)
        }
        if realm.objects(Exam.self).count == 0 {
            getExams()
            self.exams = realm.objects(Exam.self)
        } else {
            self.exams = realm.objects(Exam.self)
        }
    }
    
    func getDepartments() {
        let request = DepartmentRequest()
        request.checkConnection()
        Alamofire.request(request.path(), method: request.method()).validate().responseJSON { (response) in
            guard response.error == nil else {
                return
            }
            guard let json = response.result.value as? [[String:Any]] else {
                return
            }
            let departments = Mapper<Department>().mapArray(JSONArray: json)
            let realm = RealmFactory.getRealm()
            var departmentsToAdd = [Department]()
            var departmentsIds = [Int]()
            for newDepartment in departments {
                departmentsIds.append(newDepartment.id)
                guard let oldDepartment = self.department(byId: newDepartment.id) else {
                    departmentsToAdd.append(newDepartment)
                    continue
                }
                do {
                    try realm.write {
                        if oldDepartment.name != newDepartment.name {
                            oldDepartment.name = newDepartment.name
                        }
                        
                    }
                } catch let exception {
                    print(exception)
                }
            }
            do {
                try realm.write {
                    realm.add(departmentsToAdd)
                }
            } catch let exception {
                print(exception)
            }
        }
    }
    func getSchools() {
        let request = SchoolsRequest()
        request.checkConnection()
        Alamofire.request(request.path(), method: request.method()).validate().responseJSON { (response) in
            guard response.error == nil else {
                return
            }
            guard let json = response.result.value as? [[String:Any]] else {
                return
            }
            let schools = Mapper<School>().mapArray(JSONArray: json)
            let realm = RealmFactory.getRealm()
            var schoolsToAdd = [School]()
            var schoolsIds = [Int]()
            for newSchool in schools {
                schoolsIds.append(newSchool.id)
                guard let oldSchool = self.school(byId: newSchool.id) else {
                    schoolsToAdd.append(newSchool)
                    continue
                }
                do {
                    try realm.write {
                        if oldSchool.name != newSchool.name {
                            oldSchool.name = newSchool.name
                        }
                        
                    }
                } catch let exception {
                    print(exception)
                }
            }
            do {
                try realm.write {
                    realm.add(schoolsToAdd)
                }
            } catch let exception {
                print(exception)
            }
        }
    }
    func getCourses() {
        let request = CourseRequest()
        request.checkConnection()
        Alamofire.request(request.path(), method: request.method()).validate().responseJSON { (response) in
            guard response.error == nil else {
                return
            }
            guard let json = response.result.value as? [[String:Any]] else {
                return
            }
            let courses = Mapper<Course>().mapArray(JSONArray: json)
            let realm = RealmFactory.getRealm()
            var coursesToAdd = [Course]()
            var coursesIds = [Int]()
            for newCourse in courses {
                coursesIds.append(newCourse.id)
                guard let oldCourse = self.course(byId: newCourse.id) else {
                    coursesToAdd.append(newCourse)
                    continue
                }
                do {
                    try realm.write {
                        if oldCourse.name != newCourse.name {
                            oldCourse.name = newCourse.name
                        }
                        
                    }
                } catch let exception {
                    print(exception)
                }
            }
            do {
                try realm.write {
                    realm.add(coursesToAdd)
                }
            } catch let exception {
                print(exception)
            }
        }
    }
    
    func getExams() {
        let request = ExamsRequest()
        request.checkConnection()
        Alamofire.request(request.path(), method: request.method()).validate().responseJSON { (response) in
            guard response.error == nil else {
                return
            }
            guard let json = response.result.value as? [[String:Any]] else {
                return
            }
            let exams = Mapper<Exam>().mapArray(JSONArray: json)
            let realm = RealmFactory.getRealm()
            var examsToAdd = [Exam]()
            var examsIds = [Int]()
            for newExam in exams {
                examsIds.append(newExam.id)
                guard let oldExam = self.exam(byId: newExam.id) else {
                    examsToAdd.append(newExam)
                    continue
                }
                do {
                    try realm.write {
                        if oldExam.title != newExam.title {
                            oldExam.title = newExam.title
                        }
                        
                    }
                } catch let exception {
                    print(exception)
                }
            }
            do {
                try realm.write {
                    realm.add(examsToAdd)
                }
            } catch let exception {
                print(exception)
            }
        }
    }
    
    func department(byId: Int) -> Department? {
        let realm = RealmFactory.getRealm()
        return realm.objects(Department.self).first(where: { (department) -> Bool in
            return department.id == byId
        })
    }
    
    func course(byId: Int) -> Course? {
        let realm = RealmFactory.getRealm()
        return realm.objects(Course.self).first(where: { (course) -> Bool in
            return course.id == byId
        })
    }
    
    func school(byId: Int) -> School? {
        let realm = RealmFactory.getRealm()
        return realm.objects(School.self).first(where: { (school) -> Bool in
            return school.id == byId
        })
    }
    
    func exam(byId: Int) -> Exam? {
        let realm = RealmFactory.getRealm()
        return realm.objects(Exam.self).first(where: { (exam) -> Bool in
            return exam.id == byId
        })
    }
}
