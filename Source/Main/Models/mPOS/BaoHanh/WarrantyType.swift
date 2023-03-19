//
//  WarrantyType.swift
//  mPOS
//
//  Created by MinhDH on 5/11/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class WarrantyType: NSObject {
    
    var ID: Int
    var TenLoai: String
    
    init(ID: Int,TenLoai: String){
        self.ID = ID
        self.TenLoai = TenLoai
    }

    
    
    class func parseObjfromArray(array:[JSON])->[WarrantyType]{
        var list:[WarrantyType] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    class func getObjFromDictionary(data:JSON) -> WarrantyType{
        
        var id = data["ID"].int
        var tenLoai = data["TenLoai"].string
        
        id = id == nil ? 0 : id
        tenLoai = tenLoai == nil ? "" : tenLoai
        
        return WarrantyType(ID: id!,TenLoai: tenLoai!)
    }
    
}
