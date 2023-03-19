//
//  ScoringKyHan.swift
//  fptshop
//
//  Created by tan on 4/19/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ScoringKyHan: NSObject {
    var ID:String
    var KyHan:String
    
    init(    ID:String
    , KyHan:String){
        self.ID = ID
        self.KyHan = KyHan
    }
    
    class func parseObjfromArray(array:[JSON])->[ScoringKyHan]{
        var list:[ScoringKyHan] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ScoringKyHan{
        
        var ID = data["ID"].string
        var KyHan = data["KyHan"].string
        
        
        ID = ID == nil ? "0" : ID
        KyHan = KyHan == nil ? "" : KyHan
        
        
        return ScoringKyHan(ID: ID!,KyHan:KyHan!)
    }
}
