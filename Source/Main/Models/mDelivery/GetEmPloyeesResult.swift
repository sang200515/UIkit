//
//  GetEmPloyeesResult.swift
//  NewmDelivery
//
//  Created by sumi on 3/25/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetEmPloyeesResult: NSObject {
    
    var AvatarImageLink : String
    var CashAccount: String
    var CompanyCode : String
    var CompanyCodeB1: String
    var CompanyName : String
    var EmployeeName: String
    var ID : String
    var JobTitle: String
    var LoginTime: String
    var ShopCode: String
    var ShopName : String
    var UserName: String
    
    init(GetEmPloyeesResult: JSON)
    {
        AvatarImageLink = GetEmPloyeesResult["AvatarImageLink"].stringValue;
        CashAccount = GetEmPloyeesResult["CashAccount"].stringValue;
        CompanyCode = GetEmPloyeesResult["CompanyCode"].stringValue;
        CompanyCodeB1 = GetEmPloyeesResult["CompanyCodeB1"].stringValue;
        CompanyName = GetEmPloyeesResult["CompanyName"].stringValue;
        EmployeeName = GetEmPloyeesResult["EmployeeName"].stringValue;
        ID = GetEmPloyeesResult["ID"].stringValue;
        JobTitle = GetEmPloyeesResult["JobTitle"].stringValue;
        LoginTime = GetEmPloyeesResult["LoginTime"].stringValue;
        ShopCode = GetEmPloyeesResult["ShopCode"].stringValue;
        ShopName = GetEmPloyeesResult["ShopName"].stringValue;
        UserName = GetEmPloyeesResult["UserName"].stringValue;
        
        
    }
    
    
}

