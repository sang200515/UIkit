//
//  BookSoV2.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class BookSoV2:NSObject{
    var Success:Bool
    var Result:String
    var Message:String
    var dataBookSimV2:DataBookSimV2
    
    init(Success:Bool,Result:String,Message:String,dataBookSimV2:DataBookSimV2){
        self.Success = Success
        self.Result = Result
        self.Message = Message
        self.dataBookSimV2 = dataBookSimV2
    }
}

