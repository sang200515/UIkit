//
//  Compare.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class Compare: NSObject {
    var keySellingPoint: [KeySellingPoint]
    var basicInformation: [BasicInformation]
    
    init(keySellingPoint: [KeySellingPoint], basicInformation: [BasicInformation]) {
        self.keySellingPoint = keySellingPoint
        self.basicInformation = basicInformation
    }
    
    class func getObjFromDictionary(data:JSON) -> Compare{
        
        let keySellingPointArr = data["keySellingPoint"].array
        let keySellingPoint = KeySellingPoint.parseObjfromArray(array: keySellingPointArr!)
        let basicInformationArr = data["basicInformation"].array
        let basicInformation = BasicInformation.parseObjfromArray(array: basicInformationArr!)
        
        return Compare(keySellingPoint: keySellingPoint, basicInformation: basicInformation)
    }
    class func parseObjfromArray(array:[JSON])->[Compare]{
        var list:[Compare] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
}

