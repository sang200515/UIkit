//
//  MayCuECom.swift
//  fptshop
//
//  Created by DiemMy Le on 11/13/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.

import UIKit
import SwiftyJSON

class MayCuECom: NSObject {

    let ID: Int
    let Sku: String
    let ItemName: String
    let CreateDate: String
    let UpdateDate: String
    let Status: String
    let StatusCode: Int
    let Imei: String
    
    init(ID: Int, Sku: String, ItemName: String, CreateDate: String, UpdateDate: String, Status: String, StatusCode: Int, Imei: String) {
        self.ID = ID
        self.Sku = Sku
        self.ItemName = ItemName
        self.CreateDate = CreateDate
        self.UpdateDate = UpdateDate
        self.Status = Status
        self.StatusCode = StatusCode
        self.Imei = Imei
    }
    
    class func parseObjfromArray(array:[JSON])->[MayCuECom]{
        var list:[MayCuECom] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> MayCuECom {
        var ID = data["ID"].int
        var Sku = data["Sku"].string
        var ItemName = data["ItemName"].string
        var CreateDate = data["CreateDate"].string
        var UpdateDate = data["UpdateDate"].string
        var Status = data["Status"].string
        var StatusCode = data["StatusCode"].int
        var Imei = data["Imei"].string
        
        ID = ID == nil ? 0 : ID
        Sku = Sku == nil ? "" : Sku
        ItemName = ItemName == nil ? "" : ItemName
        CreateDate = CreateDate == nil ? "" : CreateDate
        UpdateDate = UpdateDate == nil ? "" : UpdateDate
        Status = Status == nil ? "" : Status
        StatusCode = StatusCode == nil ? 0 : StatusCode
        Imei = Imei == nil ? "" : Imei
        
        return MayCuECom(ID: ID!, Sku: Sku!, ItemName: ItemName!, CreateDate: CreateDate!, UpdateDate: UpdateDate!, Status: Status!, StatusCode: StatusCode!, Imei:Imei!)
    }
}
