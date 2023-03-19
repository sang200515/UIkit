//
//  ChangeSim4GResult.swift
//  mPOS
//
//  Created by tan on 7/9/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class ChangeSim4GResult: NSObject {
    var Success: Bool
    var Message: String
    var change4GResultData: Change4GResultData?
    
    
    init(Success:Bool,Message:String,change4GResultData:Change4GResultData){
        
        self.Success = Success
        self.Message = Message
        self.change4GResultData = change4GResultData
        
    }
    
    
}

