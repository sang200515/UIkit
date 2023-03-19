//
//  HuyBookSoV2.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class HuyBookSoV2: NSObject {
    var Success:Bool
    var Result:String
    var Message:String
    
    init(Success:Bool,Result:String,Message:String){
        self.Success = Success
        self.Result = Result
        self.Message = Message
    }
}

