//
//  HoanTatResult.swift
//  mPOS
//
//  Created by tan on 8/23/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class HoanTatResult: NSObject {
    var Success:Bool
    var Message:String
    
    
    init(Success:Bool,Message:String){
        self.Success = Success
        self.Message = Message
    }
    
    
}
