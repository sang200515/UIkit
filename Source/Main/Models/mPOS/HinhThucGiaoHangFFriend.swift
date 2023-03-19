//
//  HinhThucGiaoHangFFriend.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class HinhThucGiaoHangFFriend: NSObject {
    
    var ID: Int
    var Name: String
    
    init(ID: Int, Name: String){
        self.ID = ID
        self.Name = Name
    }
    class func parseObjfromArray(array:[JSON])->[HinhThucGiaoHangFFriend]{
        var list:[HinhThucGiaoHangFFriend] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> HinhThucGiaoHangFFriend{
        
        var id = data["ID"].int
        var name = data["Name"].string
        
        id = id == nil ? -1 : id
        name = name == nil ? "" : name
        
        return HinhThucGiaoHangFFriend(ID: id!, Name: name!)
    }
    
}

