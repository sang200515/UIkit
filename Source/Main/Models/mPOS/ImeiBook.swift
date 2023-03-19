//
//  ImeiBook.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ImeiBook: NSObject {
    var ItemCode:String
    var WhsCode:String
    var DistNumber:String
    var Quantity:Int
    var SL_book:Int
    var STT:Int
    
    init(ItemCode:String,WhsCode:String,DistNumber:String,Quantity:Int,SL_book:Int,STT:Int){
        self.ItemCode = ItemCode
        self.WhsCode = WhsCode
        self.DistNumber = DistNumber
        self.Quantity = Quantity
        self.SL_book = SL_book
        self.STT = STT
        
    }
    class func parseObjfromArray(array:[JSON])->[ImeiBook]{
        var list:[ImeiBook] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ImeiBook{
        var ItemCode = data["ItemCode"].string
        var WhsCode = data["WhsCode"].string
        var DistNumber = data["DistNumber"].string
        var Quantity = data["Quantity"].int
        var SL_book = data["SL_book"].int
        
        ItemCode = ItemCode == nil ? "" : ItemCode
        WhsCode = WhsCode == nil ? "" : WhsCode
        DistNumber = DistNumber == nil ? "" : DistNumber
        Quantity = Quantity == nil ? 0 : Quantity
        SL_book = SL_book == nil ? 0 : SL_book
        
        return ImeiBook(ItemCode: ItemCode!, WhsCode: WhsCode!, DistNumber: DistNumber!, Quantity: Quantity!, SL_book: SL_book!,STT:0)
    }
    
}


