//
//  LichSuNhapPOFilter.swift
//  mPOS
//
//  Created by tan on 8/27/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class LichSuNhapPOFilter: NSObject {
  
    var CardName:String
    var PONum:Int
    var SLNhap:Int
    var SLPO:Int
    var ItemName:String
  

    
    
    init(CardName:String,PONum:Int,SLNhap:Int,SLPO:Int,ItemName:String){
        self.CardName = CardName
        self.PONum = PONum
        self.SLNhap = SLNhap
        self.SLPO = SLPO
        self.ItemName = ItemName
        
    }
}
