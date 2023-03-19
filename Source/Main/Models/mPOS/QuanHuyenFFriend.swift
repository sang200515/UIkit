//
//  QuanHuyenFFriend.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/13/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class QuanHuyenFFriend: NSObject {
    
    var ID: Int
    var Name: String
    var CityID: Int
    
    
    init(ID: Int, Name: String,CityID: Int){
        self.ID = ID
        self.Name = Name
        self.CityID = CityID
    }
    class func parseObjfromArray(array:[JSON])->[QuanHuyenFFriend]{
        var list:[QuanHuyenFFriend] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> QuanHuyenFFriend{
        
        var id = data["ID"].int
        var name = data["Name"].string
        var cityID = data["CityID"].int
        
        id = id == nil ? 0 : id
        name = name == nil ? "" : name
        cityID = cityID == nil ? 0 : cityID
        
        return QuanHuyenFFriend(ID: id!, Name: name!,CityID: cityID!)
    }
    
}

