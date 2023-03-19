//
//  BankFFriend.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class BankFFriend: NSObject {
    
    var ID: String
    var BankName: String
    var TenChiNhanh: [BranchBankFFriend]
    var Tu: String
    var Den: String
    
    init(ID: String, BankName: String,TenChiNhanh: [BranchBankFFriend],Tu: String, Den: String){
        self.ID = ID
        self.BankName = BankName
        self.TenChiNhanh = TenChiNhanh
        self.Tu = Tu
        self.Den = Den
    }
    class func parseObjfromArray(array:[JSON])->[BankFFriend]{
        var list:[BankFFriend] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> BankFFriend{
        
        var id = data["ID"].string
        var bankName = data["BankName"].string
        var tenChiNhanh = data["TenChiNhanh"].array
        var tu = data["Tu"].string
        var den = data["Den"].string
        
        id = id == nil ? "" : id
        bankName = bankName == nil ? "" : bankName
        tenChiNhanh = tenChiNhanh == nil ? [] : tenChiNhanh
        tu = tu == nil ? "" : tu
        den = den == nil ? "" : den
        
        let chiNhanhArr = BranchBankFFriend.parseObjfromArray(array: tenChiNhanh!)
        
        return BankFFriend(ID: id!, BankName: bankName!, TenChiNhanh: chiNhanhArr,Tu: tu!, Den: den!)
    }
    
}

