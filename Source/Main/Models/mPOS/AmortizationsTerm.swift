//
//  AmortizationsTerm.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class AmortizationsTerm: NSObject {
    var TermID: String
    var TermName: String
    
    init(TermID:String,TermName:String) {
        self.TermID = TermID
        self.TermName = TermName
    }
    class func parseObjfromArray(array:[JSON])->[AmortizationsTerm]{
        var list:[AmortizationsTerm] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> AmortizationsTerm{
        
        var termID = data["TermID"].string
        var termName = data["TermName"].string
        
        termID = termID == nil ? "" : termID
        termName = termName == nil ? "" : termName
        
        return AmortizationsTerm(TermID:termID!,TermName:termName!)
    }
}
