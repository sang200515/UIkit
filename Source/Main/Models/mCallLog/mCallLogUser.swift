//
//  mCallLogUser.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 04/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class mCallLogUser: Jsonable {
    
    required init(json: JSON){
        Username = json["UserName"].string ?? "";
        AvatarImageLink = json["AvatarImageLink"].string ?? "";
        CashAccount = json["CashAccount"].string ?? "";
        CompanyCode = json["CompanyCode"].string ?? "";
        CompanyCodeB1 = json["CompanyCodeB1"].string ?? "";
        CompanyName = json["CompanyName"].string ?? "";
        EmployeeName = json["EmployeeName"].string ?? "";
        Id = json["ID"].int ?? 0;
        JobTitle = json["JobTitle"].string ?? "";
        LoginTime = json["LoginTime"].int ?? 0;
        ShopCode = json["ShopCode"].string ?? "";
        ShopName = json["ShopName"].string ?? "";
        Token = json["Token"].string ?? "";
    }
    
    var Username: String?;
    var Password: String?;
    var AvatarImageLink: String?;
    var CashAccount: String?;
    var CompanyCode: String?;
    var CompanyCodeB1: String?;
    var CompanyName: String?;
    var EmployeeName: String?;
    var Id: Int?;
    var JobTitle: String?;
    var LoginTime: Int?;
    var ShopCode: String?;
    var ShopName: String?;
    var Token: String?;
}
