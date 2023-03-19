//
//  PO.swift
//  mPOS
//
//  Created by tan on 8/15/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class PO: NSObject {
    var poNumber:Int
    var date:String
    var isInput:Bool
    var listProductNhap:[ProductNhap]

    
    init(poNumber:Int,date:String , listProductNhap:[ProductNhap],isInput:Bool){
        self.poNumber = poNumber
        self.date = date
        self.listProductNhap = listProductNhap
        self.isInput = isInput
       
      
        
    }
}
