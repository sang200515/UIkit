//
//  BranchVendorFFriend.swift
//  fptshop
//
//  Created by tan on 5/9/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class BranchCompanyFFriend: NSObject {
    var ID:Int
    var TenChiNhanh:String
    var VendorCode:Int
    
    
    init(  ID:Int
        , TenChiNhanh:String
        , VendorCode:Int){
        self.ID = ID
        self.TenChiNhanh = TenChiNhanh
        self.VendorCode = VendorCode
    }
    
    class func parseObjfromArray(array:[JSON])->[BranchCompanyFFriend]{
        var list:[BranchCompanyFFriend] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> BranchCompanyFFriend{
        
        var ID = data["ID"].int
        var TenChiNhanh = data["TenChiNhanh"].string
        var VendorCode = data["VendorCode"].int
        
        
        ID = ID == nil ? 0 : ID
        TenChiNhanh = TenChiNhanh == nil ? "" : TenChiNhanh
        VendorCode = VendorCode == nil ? 0 : VendorCode
        
        
        return BranchCompanyFFriend(ID: ID!,TenChiNhanh:TenChiNhanh!,VendorCode:VendorCode!)
    }
}
