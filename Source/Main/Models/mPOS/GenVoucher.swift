//
//  GenVoucher.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 3/1/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class GenVoucher: NSObject {
    var GiaTriVC: Float
    var VC_Name: String
    var VC_code: String
    var is_used: Int
    var loai_VC: String
    
    var isSelect: Bool
    var isVerify: Bool
    
    init(GiaTriVC: Float, VC_Name: String, VC_code: String, is_used: Int, loai_VC: String,isSelect:Bool,isVerify:Bool) {
        self.GiaTriVC = GiaTriVC
        self.VC_Name = VC_Name
        self.VC_code = VC_code
        self.is_used = is_used
        self.loai_VC = loai_VC
        self.isSelect = isSelect
        self.isVerify = isVerify
    }
    class func parseObjfromArray(array:[JSON])->[GenVoucher]{
        var list:[GenVoucher] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> GenVoucher{
        
        var giaTriVC = data["GiaTriVC"].float
        var vc_Name = data["VC_Name"].string
        var vc_code = data["VC_code"].string
        var is_used = data["is_used"].int
        var loai_VC = data["loai_VC"].string
        
        giaTriVC = giaTriVC == nil ? 0 : giaTriVC
        vc_Name = vc_Name == nil ? "" : vc_Name
        vc_code = vc_code == nil ? "" : vc_code
        is_used = is_used == nil ? 0 : is_used
        loai_VC = loai_VC == nil ? "" : loai_VC
        
        return GenVoucher(GiaTriVC: giaTriVC!, VC_Name: vc_Name!, VC_code: vc_code!, is_used: is_used!, loai_VC: loai_VC!,isSelect:false,isVerify:false)
    }
}
