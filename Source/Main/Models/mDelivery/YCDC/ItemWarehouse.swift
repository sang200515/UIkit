//
//  ItemWarehouse.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 19/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class ItemWarehouse: NSObject {
    var shopCode : String
    var shopName: String
    var whsCode : String
    var whsName: String
    var distance: String
    var qty_Available: String
    
    var itemCode: String
    var itemName: String
    var manSerNum: String
    
    init(shopCode:String,shopName:String,whsCode:String,whsName:String,distance:String,qty_Available: String,itemCode:String,itemName:String,manSerNum:String){
        self.shopCode = shopCode
        self.shopName = shopName
        self.whsCode = whsCode
        self.whsName = whsName
        self.distance = distance
        self.qty_Available = qty_Available
        self.itemCode = itemCode
        self.itemName = itemName
        self.manSerNum = manSerNum
    }
}
