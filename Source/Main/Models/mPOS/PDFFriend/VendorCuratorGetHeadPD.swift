//
//  VendorCuratorGetHeadPD.swift
//  fptshop
//
//  Created by tan on 1/11/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class VendorCuratorGetHeadPD: NSObject {
    var Head_PDCode:String
    var Head_PDName:String
    var Head_PDCodeName:String
    var Head_PDEmail:String
    var Head_PDPhone:String
    
    init(Head_PDCode:String
    , Head_PDName:String
    , Head_PDCodeName:String
    , Head_PDEmail:String
    , Head_PDPhone:String){
        self.Head_PDCode = Head_PDCode
        self.Head_PDName = Head_PDName
        self.Head_PDCodeName = Head_PDCodeName
        self.Head_PDEmail = Head_PDEmail
        self.Head_PDPhone = Head_PDPhone
    }
    
    class func parseObjfromArray(array:[JSON])->[VendorCuratorGetHeadPD]{
        var list:[VendorCuratorGetHeadPD] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> VendorCuratorGetHeadPD{
        
        var Head_PDCode = data["Head_PDCode"].string
        var Head_PDName = data["Head_PDName"].string
        var Head_PDCodeName = data["Head_PDCodeName"].string
        var Head_PDEmail = data["Head_PDEmail"].string
        var Head_PDPhone = data["Head_PDPhone"].string
 
        
        
        
        Head_PDCode = Head_PDCode == nil ? "" : Head_PDCode
        Head_PDName = Head_PDName == nil ? "" : Head_PDName
        Head_PDCodeName = Head_PDCodeName == nil ? "" : Head_PDCodeName
        Head_PDEmail = Head_PDEmail == nil ? "" : Head_PDEmail
        Head_PDPhone = Head_PDPhone == nil ? "" : Head_PDPhone
        
        
        return VendorCuratorGetHeadPD(Head_PDCode:Head_PDCode!
            , Head_PDName:Head_PDName!,Head_PDCodeName:Head_PDCodeName!,Head_PDEmail:Head_PDEmail!,Head_PDPhone:Head_PDPhone!)
    }
}
