//
//  GiaHanSSDResult.swift
//  mPOS
//
//  Created by tan on 10/4/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class GiaHanSSDResult:NSObject{
    var Success:Bool
    var NVasID:String
    var errorCode:String
    var errorDetail:String
    var mdn:String
    
    init(Success: Bool
        , NVasID:String
        , errorCode:String
        , errorDetail:String
        , mdn:String){
        self.Success = Success
        self.NVasID = NVasID
        self.errorCode = errorCode
        self.errorDetail = errorDetail
        self.mdn = mdn
    }
    
    class func parseObjfromArray(array:[JSON])->[GiaHanSSDResult]{
        var list:[GiaHanSSDResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    class func getObjFromDictionary(data:JSON) -> GiaHanSSDResult{
        var Success = data["Success"].bool
        var NVasID = data["NVasID"].string
        var errorCode = data["errorCode"].string
        var errorDetail = data["errorDetail"].string
        var mdn = data["mdn"].string
        
        
        Success = Success == nil ? false : Success
        NVasID = NVasID == nil ? "" : NVasID
        errorCode = errorCode == nil ? "" : errorCode
        errorDetail = errorDetail == nil ? "" : errorDetail
        mdn = mdn == nil ? "" : mdn
        return GiaHanSSDResult(Success:Success!,NVasID:NVasID!
            , errorCode:errorCode!
            , errorDetail:errorDetail!
            , mdn:mdn!)
    }
    
}
