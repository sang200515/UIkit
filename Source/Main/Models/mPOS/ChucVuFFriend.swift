//
//  ChucVuFFriend.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ChucVuFFriend: NSObject {
    
    var ID: String
    var ChucVu: String
    var Luong: String
    var HanMuc: String
    
    init(ID: String,ChucVu: String,Luong: String,HanMuc: String){
        self.ID = ID
        self.ChucVu = ChucVu
        self.Luong = Luong
        self.HanMuc = HanMuc
    }
    class func parseObjfromArray(array:[JSON])->[ChucVuFFriend]{
        var list:[ChucVuFFriend] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ChucVuFFriend{
        
        var id = data["ID"].string
        var chucVu = data["ChucVu"].string
        var luong = data["Luong"].string
        var hanMuc = data["HanMuc"].string
        
        id = id == nil ? "" : id
        chucVu = chucVu == nil ? "" : chucVu
        luong = luong == nil ? "" : luong
        hanMuc = hanMuc == nil ? "0" : hanMuc
        
        
        return ChucVuFFriend(ID: id!,ChucVu: chucVu!,Luong: luong!,HanMuc: hanMuc!)
    }
    
}

