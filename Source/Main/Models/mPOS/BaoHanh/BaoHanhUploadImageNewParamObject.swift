//
//  BaoHanhUploadImageNewParamObject.swift
//  mPOS
//
//  Created by sumi on 8/23/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit

class BaoHanhUploadImageNewParamObject: NSObject {
    var p_UserCode:String
    var p_UserName: String
    var p_MaPhieuBH:String
    var mObject:[BaoHanhUploadImageNewObject]
    
    init(p_UserCode:String, p_UserName: String,p_MaPhieuBH:String,mObject: [BaoHanhUploadImageNewObject]) {
        self.p_UserCode = p_UserCode
        self.p_UserName = p_UserName
        self.p_MaPhieuBH = p_MaPhieuBH
        self.mObject = mObject
    }
    
    
    
    
}
extension BaoHanhUploadImageNewParamObject {
    func toJSON() -> Dictionary<String, Any> {
        return [
            "p_UserCode": self.p_UserCode,
            "p_UserName": self.p_UserName,
            "p_MaPhieuBH": self.p_MaPhieuBH,
            "p_FileUpload": self.mObject.map({$0.toJSON()})
        ]
    }
    
}
