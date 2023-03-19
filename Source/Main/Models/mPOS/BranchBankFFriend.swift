//
//  BranchBankFFriend.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class BranchBankFFriend: NSObject {
    
    var ID: String
    var TenChiNhanh: String
    
    init(ID: String, TenChiNhanh: String){
        self.ID = ID
        self.TenChiNhanh = TenChiNhanh
    }
    class func parseObjfromArray(array:[JSON])->[BranchBankFFriend]{
        var list:[BranchBankFFriend] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> BranchBankFFriend{
        
        var id = data["ID"].string
        var tenChiNhanh = data["TenChiNhanh"].string
        
        id = id == nil ? "" : id
        tenChiNhanh = tenChiNhanh == nil ? "" : tenChiNhanh
        
        
        return BranchBankFFriend(ID: id!, TenChiNhanh: tenChiNhanh!)
    }
    
}

