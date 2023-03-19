//
//  Vendor.swift
//  CheckIn
//
//  Created by Apple on 1/21/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import SwiftyJSON

class Vendor: NSObject {
    let VendorCode: String
    let VendorName: String
    
    init(VendorCode: String, VendorName: String) {
        self.VendorCode = VendorCode
        self.VendorName = VendorName
    }
    
    class func parseObjfromArray(array:[JSON])->[Vendor]{
        var list:[Vendor] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> Vendor{
        var VendorCode = data["VendorCode"].string
        var VendorName = data["VendorName"].string
        
        VendorCode = VendorCode == nil ? "" : VendorCode
        VendorName = VendorName == nil ? "" : VendorName
        
        return Vendor(VendorCode: VendorCode!, VendorName: VendorName!)
    }
}


class VendorList: NSObject {
    let Code: String
    let mdata: [Vendor]
    let Detail: String

    init(Code: String, mdata: [Vendor], Detail: String) {
        self.Code = Code
        self.mdata = mdata
        self.Detail = Detail
    }

    class func getObjFromDictionary(data:JSON) -> VendorList{
        var Code = data["Code"].string
        var mdata = data["Data"].array
        var Detail = data["Detail"].string

        Code = Code == nil ? "" : Code
        mdata = mdata == nil ? [] : mdata
        Detail = Detail == nil ? "" : Detail
        
        let vendorArrayData = Vendor.parseObjfromArray(array: mdata ?? [])
        return VendorList(Code: Code!, mdata: vendorArrayData, Detail: Detail!)
    }
}




