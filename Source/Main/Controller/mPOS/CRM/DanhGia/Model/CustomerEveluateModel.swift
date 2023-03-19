//
//  CustomerEveluateModel.swift
//  QuickCode
//
//  Created by Sang Trương on 01/11/2022.
//

import Foundation
import ObjectMapper

class CustomerEveluateModel : Mappable {
    var fullName : String?
    var employeeCode : String?
    var employeeName : String?
    var email : String?
    var phone : String?
    var phongBan : String?
    var jobTitle : String?

    required init?(map: Map) {

    }

     func mapping(map: Map) {

        fullName <- map["fullName"]
        employeeCode <- map["EmployeeCode"]
        employeeName <- map["EmployeeName"]
        email <- map["Email"]
        phone <- map["Phone"]
        phongBan <- map["PhongBan"]
        jobTitle <- map["JobTitle"]
    }

}
