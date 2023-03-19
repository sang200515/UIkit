//
//  ProductNhap.swift
//  mPOS
//
//  Created by tan on 8/16/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class ProductNhap: NSObject {
    var ItemCode:String
    var ItemName:String
    var slnhap:Int = 0
    var SLDat:Int
    var listImei:[String]
    var ManSerNum:String
    var poNum:Int
    
    init(ItemCode:String,ItemName:String,slnhap:Int,SLDat:Int,listImei:[String],ManSerNum:String,poNum:Int){
        self.ItemCode = ItemCode
        self.ItemName = ItemName
        self.slnhap = slnhap
        self.SLDat = SLDat
        self.listImei = listImei
        self.ManSerNum = ManSerNum
        self.poNum = poNum
    }
    
  
}
