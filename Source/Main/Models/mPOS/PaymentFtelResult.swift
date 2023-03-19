//
//  PaymentFtelResult.swift
//  mPOS
//
//  Created by sumi on 12/5/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class PaymentFtelResult: NSObject {
    
    var ReturnCode: Int
    var Description: String
    var MaGDFRT: String
    var BillCode:String
    
    var u_vocher:String
    var u_Vchname:String
    var Tu_ngay:String
    var Den_Ngay:String
    
    init(ReturnCode: Int, Description: String, MaGDFRT: String, BillCode:String, u_vocher:String, u_Vchname:String, Tu_ngay:String, Den_Ngay:String){
        
        self.ReturnCode = ReturnCode
        self.Description = Description
        self.MaGDFRT = MaGDFRT
        self.BillCode = BillCode
        self.u_vocher = u_vocher
        self.u_Vchname = u_Vchname
        self.Tu_ngay = Tu_ngay
        self.Den_Ngay = Den_Ngay
    }
    class func parseObjfromArray(array:[JSON])->[PaymentFtelResult]{
        var list:[PaymentFtelResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> PaymentFtelResult{
        var ReturnCode = data["ReturnCode"].int
        var Description = data["Description"].string
        var MaGDFRT = data["MaGDFRT"].string
        var BillCode = data["BillCode"].string
        var u_vocher = data["u_vocher"].string
        var u_Vchname = data["u_Vchname"].string
        var Tu_ngay = data["Tu_ngay"].string
        var Den_Ngay = data["Den_Ngay"].string
        
        ReturnCode = ReturnCode == nil ? 0 : ReturnCode
        Description = Description == nil ? "" : Description
        MaGDFRT = MaGDFRT == nil ? "" : MaGDFRT
        BillCode = BillCode == nil ? "" : BillCode
        u_vocher = u_vocher == nil ? "" : u_vocher
        u_Vchname = u_Vchname == nil ? "" : u_Vchname
        Tu_ngay = Tu_ngay == nil ? "" : Tu_ngay
        Den_Ngay = Den_Ngay == nil ? "" : Den_Ngay
        
        return PaymentFtelResult(ReturnCode: ReturnCode!, Description: Description!, MaGDFRT: MaGDFRT!, BillCode:BillCode!, u_vocher:u_vocher!, u_Vchname:u_Vchname!, Tu_ngay:Tu_ngay!, Den_Ngay:Den_Ngay!)
        
    }
    
}

