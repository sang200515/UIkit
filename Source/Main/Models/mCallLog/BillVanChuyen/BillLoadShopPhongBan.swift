//
//  BillLoadShopPhongBan.swift
//  fptshop
//
//  Created by Apple on 5/6/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"Code": "0001",
//"FullName": "0001--FRT (HR su dung)",
//"Name": "FRT (HR su dung)"

import Foundation
import SwiftyJSON

//class BillLoadShopPhongBan: Jsonable {
//
//    required init(json: JSON) {
//        Code = json["Code"].string ?? "";
//        FullName = json["FullName"].string ?? "";
//        Name = json["Name"].string ?? "";
//    }
//
//    var Code: String?
//    var FullName: String?
//    var Name: String?
//}


class BillLoadShopPhongBan: NSObject {
    
    var Code: String
    var FullName: String
    var Name: String
    
    init(Code: String, FullName: String, Name: String) {
        
        self.Code = Code
        self.FullName = FullName
        self.Name = Name
    }
    
    class func parseObjfromArray(array:[JSON])->[BillLoadShopPhongBan]{
        var list:[BillLoadShopPhongBan] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> BillLoadShopPhongBan{
        
        var Code = data["Code"].string
        var FullName = data["FullName"].string
        var Name = data["Name"].string
        
        Code = Code == nil ? "" : Code
        FullName = FullName == nil ? "" : FullName
        Name = Name == nil ? "" : Name
    
        return BillLoadShopPhongBan(Code: Code!, FullName: FullName!, Name: Name!)
    }
}
