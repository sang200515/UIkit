//
//  BaoHanhUploadImageNewObject.swift
//  mPOS
//
//  Created by sumi on 8/23/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit

class BaoHanhUploadImageNewObject: NSObject {
    
    var p_FileName:String
    var p_Base64: String
    var p_IsSign:String
    
    init(p_FileName:String, p_Base64: String, p_IsSign:String) {
        self.p_FileName = p_FileName
        self.p_Base64 = p_Base64
        self.p_IsSign = p_IsSign
        
    }
}
extension BaoHanhUploadImageNewObject {
    func toJSON() -> Dictionary<String, Any> {
        return [
            "p_FileName": self.p_FileName,
            "p_Base64": self.p_Base64,
            "p_IsSign": self.p_IsSign
        ]
    }
    
}
