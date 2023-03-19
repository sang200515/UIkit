//
//  GetTopUpPriceResult.swift
//  mPOS
//
//  Created by MinhDH on 11/12/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class GetTopUpPriceResult: NSObject {
    
    var CardValue : Int
    var CardValueCode: String
    var CardValueName : String
    var PurchasingPrice: Int
    var ReferPrice: Int
    
    init(CardValue: Int, CardValueCode: String, CardValueName: String, PurchasingPrice: Int, ReferPrice: Int){
        self.CardValue = CardValue
        self.CardValueCode = CardValueCode
        self.CardValueName = CardValueName
        self.PurchasingPrice = PurchasingPrice
        self.ReferPrice = ReferPrice
    }
    class func parseObjfromArray(array:[JSON])->[GetTopUpPriceResult]{
        var list:[GetTopUpPriceResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> GetTopUpPriceResult{
        var CardValue = data["CardValue"].int
        var CardValueCode = data["CardValueCode"].string
        var CardValueName = data["CardValueName"].string
        var PurchasingPrice = data["PurchasingPrice"].int
        var ReferPrice = data["ReferPrice"].int
        
        CardValue = CardValue == nil ? 0 : CardValue
        CardValueCode = CardValueCode == nil ? "" : CardValueCode
        CardValueName = CardValueName == nil ? "" : CardValueName
        PurchasingPrice = PurchasingPrice == nil ? 0 : PurchasingPrice
        ReferPrice = ReferPrice == nil ? 0 : ReferPrice
        
        return GetTopUpPriceResult(CardValue: CardValue!, CardValueCode: CardValueCode!, CardValueName: CardValueName!, PurchasingPrice: PurchasingPrice!, ReferPrice: ReferPrice!)
    }
}

