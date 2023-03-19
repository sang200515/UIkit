//
//  AmortizationsProperty.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class AmortizationsProperty: NSObject {
    var CreateBy: String
    var CreateDate: String
    var ProID: Int
    var ProName: String
    var ProType: Int
    var ProValue: String
    var UpdateBy: String
    var UpdateDate: String
    init(CreateBy: String, CreateDate: String, ProID: Int, ProName: String, ProType: Int, ProValue: String, UpdateBy: String, UpdateDate: String) {
        self.CreateBy = CreateBy
        self.CreateDate = CreateDate
        self.ProID = ProID
        self.ProName = ProName
        self.ProType = ProType
        self.ProValue = ProValue
        self.UpdateBy = UpdateBy
        self.UpdateDate = UpdateDate
    }
    class func parseObjfromArray(array:[JSON])->[AmortizationsProperty]{
        var list:[AmortizationsProperty] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> AmortizationsProperty{
        
        var createBy = data["CreateBy"].string
        var createDate = data["CreateDate"].string
        var proID = data["ProID"].int
        var proName = data["ProName"].string
        var proType = data["ProType"].int
        var proValue = data["ProValue"].string
        var updateBy = data["UpdateBy"].string
        var updateDate = data["UpdateDate"].string
        
        createBy = createBy == nil ? "" : createBy
        createDate = createDate == nil ? "" : createDate
        proID = proID == nil ? 0 : proID
        proName = proName == nil ? "" : proName
        proType = proType == nil ? 0 : proType
        proValue = proValue == nil ? "" : proValue
        updateBy = updateBy == nil ? "" : updateBy
        updateDate = updateDate == nil ? "" : updateDate
        
        return AmortizationsProperty(CreateBy: createBy!, CreateDate: createDate!, ProID: proID!, ProName: proName!, ProType: proType!, ProValue: proValue!, UpdateBy: updateBy!, UpdateDate: updateDate!)
    }
}

