//
//  UploadImageLockDevideResult.swift
//  mPOS
//
//  Created by tan on 8/23/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class UploadImageLockDevideResult: NSObject {
    var Success:Bool
    var Url:String
    var Message:String
    
    init(Success:Bool,Url:String,Message:String){
        self.Success = Success
        self.Url = Url
        self.Message = Message
        
    }
}
