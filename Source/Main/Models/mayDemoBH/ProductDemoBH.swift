//
//  ProductDemoBH.swift
//  fptshop
//
//  Created by DiemMy Le on 5/12/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"id": 1,
//"item_code": "0001",
//"item_name": "Test insert",
//"imei": "12345678+9",
//"create_datetime": "14:55 11/05/2020",
//"status_code": "P",
//"status_name": "Chưa cập nhật",
//"type_item": "DDTD",
//"warranty_code": 0

//"update_datetime" : null,
//"emp_update" : " - ",

import UIKit
import SwiftyJSON

class ProductDemoBH: NSObject {

    let id:Int
    let warranty_code:String
    let item_code:String
    let item_name: String
    let imei: String
    let create_datetime: String
    let status_code: String
    let status_name: String
    let type_item: String
    var listIDError: String
    let update_datetime: String
    let emp_update: String
    
    init(id:Int, warranty_code:String, item_code:String, item_name: String, imei: String, create_datetime: String, status_code: String, status_name: String, type_item: String, listIDError: String, update_datetime: String, emp_update: String) {
        self.id = id
        self.warranty_code = warranty_code
        self.item_code = item_code
        self.item_name = item_name
        self.imei = imei
        self.create_datetime = create_datetime
        self.status_code = status_code
        self.status_name = status_name
        self.type_item = type_item
        self.listIDError = listIDError
        self.update_datetime = update_datetime
        self.emp_update = emp_update
    }
    
    class func parseObjfromArray(array:[JSON])->[ProductDemoBH]{
        var list:[ProductDemoBH] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
        
    class func getObjFromDictionary(data:JSON) -> ProductDemoBH{
        var id = data["id"].int
        var warranty_code = data["warranty_code"].string
        var item_code = data["item_code"].string
        var item_name = data["item_name"].string
        var imei = data["imei"].string
        var create_datetime = data["create_datetime"].string
        var status_code = data["status_code"].string
        var status_name = data["status_name"].string
        var type_item = data["type_item"].string
        var update_datetime = data["update_datetime"].string
        var emp_update = data["emp_update"].string
        
        id = id == nil ? 0 : id
        warranty_code = warranty_code == nil ? "" : warranty_code
        item_code = item_code == nil ? "" : item_code
        item_name = item_name == nil ? "" : item_name
        imei = imei == nil ? "" : imei
        create_datetime = create_datetime == nil ? "" : create_datetime
        status_code = status_code == nil ? "" : status_code
        status_name = status_name == nil ? "" : status_name
        type_item = type_item == nil ? "" : type_item
        update_datetime = update_datetime == nil ? "" : update_datetime
        emp_update = emp_update == nil ? "" : emp_update
        
        return ProductDemoBH(id: id!, warranty_code: warranty_code!, item_code: item_code!, item_name: item_name!, imei: imei!, create_datetime: create_datetime!, status_code: status_code!, status_name: status_name!, type_item: type_item!, listIDError: "", update_datetime: update_datetime!, emp_update:emp_update!)
    }
}
