//
//  InfoCallLogSearchCMND.swift
//  mPOS
//
//  Created by tan on 11/5/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class InfoCallLogSearchCMND: NSObject {
    var IDCallLog:Int
    var GhiChu:String
    var TrangThaiCallLog:String
    
    init(IDCallLog:Int
        , GhiChu:String
        , TrangThaiCallLog:String){
        self.IDCallLog = IDCallLog
        self.GhiChu = GhiChu
        self.TrangThaiCallLog = TrangThaiCallLog
        
    }
    
    class func parseObjfromArray(array:[JSON])->[InfoCallLogSearchCMND]{
        var list:[InfoCallLogSearchCMND] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> InfoCallLogSearchCMND{
        var IDCallLog = data["IDCallLog"].int
        var GhiChu = data["GhiChu"].string
        var TrangThaiCallLog = data["TrangThaiCallLog"].string
        
        
        
        IDCallLog = IDCallLog == nil ? 0 : IDCallLog
        GhiChu = GhiChu == nil ? "" : GhiChu
        TrangThaiCallLog = TrangThaiCallLog == nil ? "" : TrangThaiCallLog
        
        
        
        return InfoCallLogSearchCMND(IDCallLog:IDCallLog!
            , GhiChu:GhiChu!
            , TrangThaiCallLog:TrangThaiCallLog!)
    }
    
    
}

