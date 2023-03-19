//
//  SimCustomer.swift
//  fptshop
//
//  Created by Apple on 4/16/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"custId": "30013930037",
//"custType": "VIE",
//"name": "Trần Thị Kim Phương",
//"address": "P.05 Q.10 TPHCM",
//"birthDate": "1976-10-24T00:00:00+07:00",
//"sex": "F",
//"district": "10",
//"precinct": "05",
//"province": "T008"

import UIKit
import SwiftyJSON

class SimCustomer: NSObject {

    let custId: String
    let custType: String
    let name: String
    let address: String
    let birthDate: String
    let sex: String
    let district: String
    let precinct: String
    let province: String
    
    init(custId: String, custType: String, name: String, address: String, birthDate: String, sex: String, district: String, precinct: String, province: String) {
        self.custId = custId
        self.custType = custType
        self.name = name
        self.address = address
        self.birthDate = birthDate
        self.sex = sex
        self.district = district
        self.precinct = precinct
        self.province = province
    }
    
    class func parseObjfromArray(array:[JSON])->[SimCustomer]{
        var list:[SimCustomer] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> SimCustomer{
        var custId = data["custId"].string
        var custType = data["custType"].string
        var name = data["name"].string
        var address = data["address"].string
        var birthDate = data["birthDate"].string
        var sex = data["sex"].string
        var district = data["district"].string
        var precinct = data["precinct"].string
        var province = data["province"].string
        
        custId = custId == nil ? "" : custId
        custType = custType == nil ? "" : custType
        name = name == nil ? "" : name
        address = address == nil ? "" : address
        birthDate = birthDate == nil ? "" : birthDate
        sex = sex == nil ? "" : sex
        district = district == nil ? "" : district
        precinct = precinct == nil ? "" : precinct
        province = province == nil ? "" : province
        
        return SimCustomer(custId: custId!, custType: custType!, name: name!, address: address!, birthDate: birthDate!, sex: sex!, district: district!, precinct: precinct!, province: province!)
    }
}


