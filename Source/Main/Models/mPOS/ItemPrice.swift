//
//  ItemPrice.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/21/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
public class ItemPrice:NSObject{
    
    var ID:String
    var PriceCard:Int
    var TelecomName:String
    var TypeNCC:String
    var TelecomCode:String
    var Price:Int
    var isSelect:Bool
    
    init(ID:String, PriceCard:Int, TelecomName:String, TypeNCC:String, TelecomCode:String, Price:Int, isSelect:Bool){
        self.ID = ID
        self.PriceCard = PriceCard
        self.TelecomName = TelecomName
        self.TypeNCC = TypeNCC
        self.TelecomCode = TelecomCode
        self.Price = Price
        self.isSelect = isSelect
    }
}
