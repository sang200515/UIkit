//
//  CameraShop.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 5/14/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class CameraShop: NSObject {
    var STT:Int
    var WarehouseCode:String
    var WarehouseName:String
    var Tinh:String
    var LinkOff:String
    var LinkLive:String
    
    init(STT:Int, WarehouseCode:String, WarehouseName:String, Tinh:String, LinkOff:String, LinkLive:String){
        self.STT = STT
        self.WarehouseCode = WarehouseCode
        self.WarehouseName = WarehouseName
        self.Tinh = Tinh
        self.LinkOff = LinkOff
        self.LinkLive = LinkLive
        
    }
    
    class func parseObjfromArray(array:[JSON])->[CameraShop]{
        var list:[CameraShop] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> CameraShop{
        
        var STT = data["STT"].int
        var WarehouseCode = data["WarehouseCode"].string
        var WarehouseName = data["WarehouseName"].string
        var Tinh = data["Tinh"].string
        var LinkOff = data["LinkOff"].string
        var LinkLive = data["LinkLive"].string
        
        
        STT = STT == nil ? 0 : STT
        WarehouseCode = WarehouseCode == nil ? "" : WarehouseCode
        WarehouseName = WarehouseName == nil ? "" : WarehouseName
        Tinh = Tinh == nil ? "" : Tinh
        LinkOff = LinkOff == nil ? "" : LinkOff
        LinkLive = LinkLive == nil ? "" : LinkLive
        
        
        return CameraShop(STT:STT!, WarehouseCode:WarehouseCode!, WarehouseName:WarehouseName!, Tinh:Tinh!, LinkOff:LinkOff!, LinkLive:LinkLive!)
    }
}

