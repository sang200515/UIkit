//
//  CreateInfoCustomer.swift
//  fptshop
//
//  Created by tan on 5/29/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class CreateInfoCustomer: NSObject {
    var IDMPOS:String
    var processId:String
    var activityId:String
    var p_status:Int
    var p_messagess:String
    
    init(IDMPOS:String
    , processId:String
    , activityId:String
    , p_status:Int
    , p_messagess:String){
        self.IDMPOS = IDMPOS
        self.processId = processId
        self.activityId = activityId
        self.p_status = p_status
        self.p_messagess = p_messagess
    }
    
    class func parseObjfromArray(array:[JSON])->[CreateInfoCustomer]{
        var list:[CreateInfoCustomer] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> CreateInfoCustomer{
        
        var IDMPOS = data["IDMPOS"].string
        var processId = data["processId"].string
        var activityId = data["activityId"].string
        var p_status = data["p_status"].int
        var p_messagess = data["p_messagess"].string
        
        
        IDMPOS = IDMPOS == nil ? "" : IDMPOS
        processId = processId == nil ? "" : processId
        activityId = activityId == nil ? "" : activityId
        p_status = p_status == nil ? 0 : p_status
         p_messagess = p_messagess == nil ? "" : p_messagess
        
        return CreateInfoCustomer(IDMPOS:IDMPOS!
            , processId:processId!
            , activityId:activityId!
            , p_status:p_status!
            , p_messagess:p_messagess!
        )
    }
}
