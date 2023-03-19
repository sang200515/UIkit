//
//  CheckVoucherResult.swift
//  mPOS
//
//  Created by MinhDH on 11/12/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class CheckVoucherResult: NSObject {
    var voucherprice : Int
    var u_VchName: String
    var u_AcVoch : String
    var createdate: String
    var voucher:String

    init(voucherprice : Int, u_VchName: String, u_AcVoch : String, createdate: String,voucher:String){
        self.voucherprice = voucherprice
        self.u_VchName = u_VchName
        self.u_AcVoch  = u_AcVoch
        self.createdate = createdate
        self.voucher = voucher
    }
    class func parseObjfromArray(array:[JSON])->[CheckVoucherResult]{
        var list:[CheckVoucherResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item,voucher: ""))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON,voucher:String) -> CheckVoucherResult{
        var voucherprice = data["voucherprice"].int
        var u_VchName = data["u_VchName"].string
        var u_AcVoch = data["u_AcVoch"].string
        var createdate = data["createdate"].string
        
        voucherprice = voucherprice == nil ? 0 : voucherprice
        u_VchName = u_VchName == nil ? "" : u_VchName
        u_AcVoch = u_AcVoch == nil ? "" : u_AcVoch
        createdate = createdate == nil ? "" : createdate
        
        return CheckVoucherResult(voucherprice : voucherprice!, u_VchName: u_VchName!, u_AcVoch : u_AcVoch!, createdate: createdate!,voucher:voucher)
        
    }
    
}

