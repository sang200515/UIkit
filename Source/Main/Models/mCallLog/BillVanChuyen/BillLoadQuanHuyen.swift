//
//  BillLoadQuanHuyen.swift
//  fptshop
//
//  Created by Apple on 5/6/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"ID": 1,
//"IDCity": 1,
//"Name": "Thành phố Long Xuyên"

import Foundation
import SwiftyJSON

//class BillLoadQuanHuyen: Jsonable {
//
//    required init(json: JSON) {
//        ID = json["ID"].int ?? 0;
//        IDCity = json["IDCity"].int ?? 0;
//        Name = json["Name"].string ?? "";
//    }
//
//    var ID: Int?
//    var IDCity: Int?
//    var Name: String?
//}

class BillLoadQuanHuyen: NSObject {
    
    var Name: String
    var ID: Int
    var IDCity: Int
    
    init(Name: String, ID: Int, IDCity: Int) {
        
        self.Name = Name
        self.ID = ID
        self.IDCity = IDCity
    }
    
    class func parseObjfromArray(array:[JSON])->[BillLoadQuanHuyen]{
        var list:[BillLoadQuanHuyen] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> BillLoadQuanHuyen{
        var Name = data["Name"].string
        var ID = data["ID"].int
        var IDCity = data["IDCity"].int
        
        
        Name = Name == nil ? "" : Name
        ID = ID == nil ? 0 : ID
        IDCity = IDCity == nil ? 0 : IDCity
        
        return BillLoadQuanHuyen(Name: Name!, ID: ID!, IDCity: IDCity!)
    }
}
