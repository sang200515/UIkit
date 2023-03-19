//
//  ItemYCDC.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 19/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class ItemYCDC: NSObject {
    var itemCode: String
    var itemName: String
    var warehouse: ItemWarehouse
    var amount : Int
    var manSerNum: String
    
    init(itemCode: String,itemName: String,warehouse:ItemWarehouse,amount:Int,manSerNum: String){
        self.itemCode = itemCode
        self.itemName = itemName
        self.warehouse = warehouse
        self.amount = amount
        self.manSerNum = manSerNum
    }
}
