//
//  DataResultInfoUpdateSim.swift
//  mPOS
//
//  Created by tan on 6/19/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class DataResultInfoUpdateSim: NSObject {
    var transId:String
    var status:String
    var message:String
    
    init(transId:String,status:String,message:String){
        
        self.transId = transId
        self.status = status
        self.message = message
        
    }
    class func parseObjfromArray(array:[JSON])->[DataResultInfoUpdateSim]{
        var list:[DataResultInfoUpdateSim] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> DataResultInfoUpdateSim{
        var transId = data["transId"].string
        var status = data["status"].string
        var message = data["message"].string
        transId = transId == nil ? "": transId
        status = status == nil ? "" : status
        message = message == nil ? "": message
        return DataResultInfoUpdateSim(transId: transId!, status: status!, message: message!)
    }
}

