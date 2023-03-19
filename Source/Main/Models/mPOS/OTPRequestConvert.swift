//
//  4GOTP.swift
//  mPOS
//
//  Created by tan on 7/9/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation

class OTPRequestConvert: NSObject{
    
    var Success:Bool
    var Message:String
    var OTPRequestConvertData:OTPRequestConvertData?
    
    init(Success:Bool,Message:String,OTPRequestConvertData:OTPRequestConvertData){
        self.Success = Success
        self.Message = Message
        self.OTPRequestConvertData = OTPRequestConvertData
    }
}
