//
//  TinhThanhPhoFFriend.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/13/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class TinhThanhPhoFFriend: NSObject {
    
    var ID: Int
    var Name: String
    
    
    init(ID: Int, Name: String){
        self.ID = ID
        self.Name = Name
    }
    class func parseObjfromArray(array:[JSON])->[TinhThanhPhoFFriend]{
        var list:[TinhThanhPhoFFriend] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> TinhThanhPhoFFriend{
        
        var id = data["ID"].int
        var name = data["Name"].string
        
        id = id == nil ? 0 : id
        name = name == nil ? "" : name
        
        return TinhThanhPhoFFriend(ID: id!, Name: name!)
    }
    
}

