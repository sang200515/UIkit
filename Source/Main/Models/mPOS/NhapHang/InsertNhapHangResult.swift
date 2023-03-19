//
//  InsertNhapHangResult.swift
//  mPOS
//
//  Created by tan on 8/21/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class InsertNhapHangResult: NSObject{
    var Success:Bool
    var Result:String
    var Message:String
    
    init(Success:Bool,Result:String,Message:String){
        self.Success = Success
        self.Result = Result
        self.Message = Message
        
    }
    
    
    
}
