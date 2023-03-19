//
//  OTPInfoActiveSim.swift
//  mPOS
//
//  Created by tan on 6/4/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class OTPInfoActiveSim: NSObject {
    
    var code:Int
    var message:String
    var otpActiveData:OTPActiveSimData?

    init(code:Int,message:String,otpActiveData:OTPActiveSimData){
        
        self.code = code
        self.message = message
        self.otpActiveData = otpActiveData
        
    }
}

