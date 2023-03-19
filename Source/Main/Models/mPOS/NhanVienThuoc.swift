//
//  NhanVienThuoc.swift
//  mPOS
//
//  Created by tan on 9/4/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class NhanVienThuoc: NSObject {
    var MaNV:String
    var TenNv:String
    var Phone:String
    
    init(MaNV:String,TenNv:String,Phone:String){
        self.MaNV = MaNV
        self.TenNv = TenNv
        self.Phone = Phone
    }
    
    
    class func parseObjfromArray(array:[JSON])->[NhanVienThuoc]{
        var list:[NhanVienThuoc] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    class func getObjFromDictionary(data:JSON) -> NhanVienThuoc{
        var MaNV = data["MaNV"].string
        var TenNv = data["TenNv"].string
        var Phone = data["Phone"].string
        
        MaNV = MaNV == nil ? "" : MaNV
        TenNv = TenNv == nil ? "" : TenNv
        Phone = Phone == nil ? "" : Phone
        return NhanVienThuoc(MaNV: MaNV!, TenNv: TenNv!, Phone:Phone!)
    }
}
