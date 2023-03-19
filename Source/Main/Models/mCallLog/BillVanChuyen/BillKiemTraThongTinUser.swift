//
//  BillKiemTraThongTinUser.swift
//  fptshop
//
//  Created by Apple on 9/18/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//{
//    "Is_Shop": 0,
//    "OrganizationHierachyCode": "00757",
//    "OrganizationHierachyCodeSend": "00757",
//    "OrganizationHierachyName": "Nhóm Call Log"
//}
import Foundation
import SwiftyJSON

class BillKiemTraThongTinUser: Jsonable {
    required init(json: JSON) {
        Is_Shop = json["Is_Shop"].int ?? 0;
        OrganizationHierachyCode = json["OrganizationHierachyCode"].string ?? "";
        OrganizationHierachyCodeSend = json["OrganizationHierachyCodeSend"].string ?? "";
        OrganizationHierachyName = json["OrganizationHierachyName"].string ?? "";
    }
    
    var Is_Shop: Int?
    var OrganizationHierachyCode: String?
    var OrganizationHierachyCodeSend: String?
    var OrganizationHierachyName: String?
}
