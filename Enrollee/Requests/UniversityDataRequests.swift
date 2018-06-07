//
//  UniversityDataRequests.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 18.05.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import Foundation
import Alamofire

class CourseRequest: Request {
    var parameters: Parameters?
    var headers: HTTPHeaders?
    
    func path() -> String {
        return baseURL() + "/api/courses"
    }
    
    func method() -> HTTPMethod {
        return .get
    }
    
   
    
}
class DepartmentRequest: Request {
    var parameters: Parameters?
    var headers: HTTPHeaders?
    
    func path() -> String {
        return baseURL() + "/api/departments"
    }
    
    func method() -> HTTPMethod {
        return .get
    }
}

class SchoolsRequest: Request {
    var parameters: Parameters?
    var headers: HTTPHeaders?
    
    func path() -> String {
        return baseURL() + "/api/schools"
    }
    
    func method() -> HTTPMethod {
        return .get
    }
}

class ExamsRequest: Request {
    var parameters: Parameters?
    var headers: HTTPHeaders?
    
    func path() -> String {
        return baseURL() + "/api/exams"
    }
    
    func method() -> HTTPMethod {
        return .get
    }
}
