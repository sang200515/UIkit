//
//  GetCRMPaymentHistoryVoucherResult.swift
//  mPOS
//
//  Created by sumi on 1/2/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetCRMPaymentHistoryVoucherResult: NSObject {
    
    var VC_Code: String
    var VC_Name: String
    var GiaTri_VC: Int
    
    init(VC_Code: String, VC_Name: String, GiaTri_VC: Int){
        self.VC_Code = VC_Code
        self.VC_Name = VC_Name
        self.GiaTri_VC = GiaTri_VC
    }
    
    class func parseObjfromArray(array:[JSON])->[GetCRMPaymentHistoryVoucherResult]{
        var list:[GetCRMPaymentHistoryVoucherResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item ))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> GetCRMPaymentHistoryVoucherResult{
        var VC_Code  = data["VC_Code"].string
        var VC_Name = data["VC_Name"].string
        var GiaTri_VC = data["GiaTri_VC"].int
        
        VC_Code = VC_Code == nil ? "" : VC_Code
        VC_Name = VC_Name == nil ? "" : VC_Name
        GiaTri_VC = GiaTri_VC == nil ? 0 : GiaTri_VC
        
        return GetCRMPaymentHistoryVoucherResult(VC_Code:VC_Code!
            , VC_Name:VC_Name!
            , GiaTri_VC:GiaTri_VC!)
    }
}

