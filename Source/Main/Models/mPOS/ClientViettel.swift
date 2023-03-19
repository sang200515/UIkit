//
//  ClientViettel.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ClientViettel: NSObject {
    
    var custId: String
    var custType: String
    var custName: String
    var custNationality: String
    var custIdNo: String
    var custBirthday: String
    var custAddress: String
    var custIssueDate: String
    var custIssuePlace: String
    
    
    init(custId: String, custType: String, custName: String, custNationality: String, custIdNo: String, custBirthday: String, custAddress: String, custIssueDate: String, custIssuePlace: String){
        self.custId = custId
        self.custType = custType
        self.custName = custName
        self.custNationality = custNationality
        self.custIdNo = custIdNo
        self.custBirthday = custBirthday
        self.custAddress = custAddress
        self.custIssueDate = custIssueDate
        self.custIssuePlace = custIssuePlace
    }
    class func parseObjfromArray(array:[JSON])->[ClientViettel]{
        var list:[ClientViettel] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ClientViettel{
        
        var custId = data["custId"].string
        var custType = data["custType"].string
        var custName = data["custName"].string
        var custNationality = data["custNationality"].string
        var custIdNo = data["custIdNo"].string
        
        var custBirthday = data["custBirthday"].string
        var custAddress = data["custAddress"].string
        var custIssueDate = data["custIssueDate"].string
        var custIssuePlace = data["custIssuePlace"].string
        
        custId = custId == nil ? "" : custId
        custType = custType == nil ? "" : custType
        custName = custName == nil ? "" : custName
        custNationality = custNationality == nil ? "" : custNationality
        custIdNo = custIdNo == nil ? "" : custIdNo
        custBirthday = custBirthday == nil ? "" : custBirthday
        custAddress = custAddress == nil ? "" : custAddress
        custIssueDate = custIssueDate == nil ? "" : custIssueDate
        custIssuePlace = custIssuePlace == nil ? "" : custIssuePlace
        
        return ClientViettel(custId: custId!, custType: custType!, custName: custName!, custNationality: custNationality!, custIdNo: custIdNo!, custBirthday: custBirthday!, custAddress: custAddress!, custIssueDate: custIssueDate!, custIssuePlace: custIssuePlace!)
    }
    
}

