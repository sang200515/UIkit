//
//  Change4GResultData.swift
//  mPOS
//
//  Created by tan on 7/11/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class Change4GResultData: NSObject {
    
    var code: Int
    var message: String
    
    init(code:Int,message:String){
        
        self.code = code
        self.message = message
        
    }
    
}

