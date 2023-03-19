//
//  4GOTPData.swift
//  mPOS
//
//  Created by tan on 7/9/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class OTPRequestConvertData: NSObject {
    var code:Int
    var message:String
    var OTPRequestConvertData2:OTPRequestConvertData2?
    
    init(code:Int,message:String,OTPRequestConvertData2:OTPRequestConvertData2){
        
        self.code = code
        self.message = message
        self.OTPRequestConvertData2 = OTPRequestConvertData2
        
    }
}

