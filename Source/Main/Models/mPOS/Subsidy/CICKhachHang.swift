//
//  CICKhachHang.swift
//  mPOS
//
//  Created by tan on 11/4/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class CICKhachHang: NSObject {
    var IDCallLog:Int
    var GhiChu:String
    var TrangThaiCallLog:String
    
    init(IDCallLog:Int
        , GhiChu:String
        , TrangThaiCallLog:String){
        self.IDCallLog = IDCallLog
        self.GhiChu = GhiChu
        self.TrangThaiCallLog = TrangThaiCallLog
    }
    

    
    class func parseObjfromArray(array:[JSON])->[CICKhachHang]{
        var list:[CICKhachHang] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> CICKhachHang{
        var IDCallLog = data["IDCallLog"].int
        var GhiChu = data["GhiChu"].string
        var TrangThaiCallLog = data["TrangThaiCallLog"].string
        
        
        
        IDCallLog = IDCallLog == nil ? 0 : IDCallLog
        GhiChu = GhiChu == nil ? "" : GhiChu
        TrangThaiCallLog = TrangThaiCallLog == nil ? "" : TrangThaiCallLog
        
        
        
        return CICKhachHang(IDCallLog:IDCallLog!
            , GhiChu:GhiChu!
            , TrangThaiCallLog:TrangThaiCallLog!)
    }
    
}
