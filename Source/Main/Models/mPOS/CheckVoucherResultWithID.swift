//
//  CheckVoucherResultWithID.swift
//  mPOS
//
//  Created by MinhDH on 11/12/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class CheckVoucherResultWithID: NSObject {
    var idVoucher: String
    var voucherprice : Int
    var u_VchName: String
    var u_AcVoch : String
    var createdate: String
    
    
    init(idVoucher:String ,voucherprice:Int,u_VchName:String,u_AcVoch:String,createdate:String) {
        self.idVoucher = idVoucher
        self.voucherprice = voucherprice
        self.u_VchName = u_VchName
        self.u_AcVoch = u_AcVoch
        self.createdate = createdate
        
    }
    class func parseObjfromArray(array:[JSON])->[CheckVoucherResultWithID]{
        var list:[CheckVoucherResultWithID] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> CheckVoucherResultWithID{
        var idVoucher = data["idVoucher"].string
        var voucherprice = data["voucherprice"].int
        var u_VchName = data["u_VchName"].string
        var u_AcVoch = data["u_AcVoch"].string
        var createdate = data["createdate"].string

        idVoucher = idVoucher == nil ? "" : idVoucher
        voucherprice = voucherprice == nil ? 0 : voucherprice
        u_VchName = u_VchName == nil ? "" : u_VchName
        u_AcVoch = u_AcVoch == nil ? "" : u_AcVoch
        createdate = createdate == nil ? "" : createdate
        
        return CheckVoucherResultWithID(idVoucher:idVoucher! ,voucherprice:voucherprice!,u_VchName:u_VchName!,u_AcVoch:u_AcVoch!,createdate:createdate!)
        
    }
    
}

