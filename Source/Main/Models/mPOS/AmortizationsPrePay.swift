//
//  AmortizationsPrePay.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class AmortizationsPrePay: NSObject {
    var ID: Int
    var PrePayID: String
    var PrePayName: String
    var PrePayValue: Float
    init(ID:Int,PrePayID:String,PrePayName:String,PrePayValue:Float) {
        self.ID = ID
        self.PrePayID = PrePayID
        self.PrePayName = PrePayName
        self.PrePayValue = PrePayValue
    }
    class func parseObjfromArray(array:[JSON])->[AmortizationsPrePay]{
        var list:[AmortizationsPrePay] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> AmortizationsPrePay{
        
        var id = data["ID"].int
        var prePayID = data["PrePayID"].string
        var prePayName = data["PrePayName"].string
        var prePayValue = data["PrePayValue"].float
        
        id = id == nil ? 0 : id
        prePayID = prePayID == nil ? "" : prePayID
        prePayName = prePayName == nil ? "" : prePayName
        prePayValue = prePayValue == nil ? 0 : prePayValue
        
        return AmortizationsPrePay(ID:id!,PrePayID:prePayID!,PrePayName:prePayName!,PrePayValue:prePayValue!)
    }
}

