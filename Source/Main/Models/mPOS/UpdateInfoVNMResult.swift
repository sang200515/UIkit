//
//  UpdateInfoVNMResult.swift
//  mPOS
//
//  Created by tan on 6/4/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class UpdateInfoVNMResult: NSObject {
    var code:Int
    var message:String
    var data:String
    var dataResultInfoUpdateSim:DataResultInfoUpdateSim?
    
    
    init(code:Int,message:String,data:String,dataResultInfoUpdateSim:DataResultInfoUpdateSim){
        
        self.code = code
        self.message = message
        self.data = data
        self.dataResultInfoUpdateSim = dataResultInfoUpdateSim
        
    }
}
