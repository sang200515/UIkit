//
//  TinhThanhFFriend.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/13/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class TinhThanhFFriend: NSObject {
    
    var ID: Int
    var TenTinhThanh: String
    
    init(ID: Int, TenTinhThanh: String){
        self.ID = ID
        self.TenTinhThanh = TenTinhThanh
    }
    class func parseObjfromArray(array:[JSON])->[TinhThanhFFriend]{
        var list:[TinhThanhFFriend] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> TinhThanhFFriend{
        
        var id = data["ID"].int
        var tenTinhThanh = data["TenTinhThanh"].string
        
        id = id == nil ? -1 : id
        tenTinhThanh = tenTinhThanh == nil ? "" : tenTinhThanh
        
        return TinhThanhFFriend(ID: id!, TenTinhThanh: tenTinhThanh!)
    }
    
}
