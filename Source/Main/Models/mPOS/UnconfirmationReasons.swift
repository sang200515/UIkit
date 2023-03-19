//
//  UnconfirmationReasons.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 3/1/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class UnconfirmationReasons: NSObject {
    var ItemCode: String
    var imei: String
    var issuccess: Int
    var userapprove: String
    var Discount: Int
    var Lydo_giamgia: Int
    var Note: String
    
    init(ItemCode: String, imei: String,issuccess: Int, userapprove: String,Discount:Int,Lydo_giamgia: Int, Note: String) {
        self.ItemCode = ItemCode
        self.imei = imei
        self.issuccess = issuccess
        self.userapprove = userapprove
        self.Discount = Discount
        self.Lydo_giamgia =  Lydo_giamgia
        self.Note =  Note
    }
    class func parseObjfromArray(array:[JSON])->[UnconfirmationReasons]{
        var list:[UnconfirmationReasons] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> UnconfirmationReasons{
        
        var itemCode = data["ItemCode"].string
        var imei = data["imei"].string
        var issuccess = data["issuccess"].int
        var userapprove = data["userapprove"].string
        var discount = data["Discount"].int
        var lydo_giamgia = data["Lydo_giamgia"].int
        var Note = data["Note"].string
        
        itemCode = itemCode == nil ? "" : itemCode
        imei = imei == nil ? "" : imei
        issuccess = issuccess == nil ? 0 : issuccess
        userapprove = userapprove == nil ? "" : userapprove
        discount = discount == nil ? 0 : discount
        lydo_giamgia = lydo_giamgia == nil ? 0 : lydo_giamgia
        Note = Note == nil ? "" : Note
        
        return UnconfirmationReasons(ItemCode: itemCode!, imei: imei!,issuccess: issuccess!, userapprove: userapprove!,Discount:discount!,Lydo_giamgia:lydo_giamgia!, Note:Note!)
    }
}
