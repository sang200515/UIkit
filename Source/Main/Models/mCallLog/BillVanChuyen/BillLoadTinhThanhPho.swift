//
//  BillLoadTinhThanhPho.swift
//  fptshop
//
//  Created by Apple on 5/6/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"ID": 1,
//"Name": "An Giang"

import Foundation
import SwiftyJSON

//class BillLoadTinhThanhPho: Jsonable {
//
//    required init(json: JSON) {
//        ID = json["ID"].int ?? 0;
//        Name = json["Name"].string ?? "";
//    }
//
//    var ID: Int?
//    var Name: String?
//
//}

class BillLoadTinhThanhPho: NSObject {
    
    var Name: String
    var ID: Int
    
    init(Name: String, ID: Int) {
        
        self.Name = Name
        self.ID = ID
    }
    
    class func parseObjfromArray(array:[JSON])->[BillLoadTinhThanhPho]{
        var list:[BillLoadTinhThanhPho] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> BillLoadTinhThanhPho{
        var Name = data["Name"].string
        var ID = data["ID"].int
        
        
        Name = Name == nil ? "" : Name
        ID = ID == nil ? 0 : ID
        
        return BillLoadTinhThanhPho(Name: Name!, ID: ID!)
    }
}
