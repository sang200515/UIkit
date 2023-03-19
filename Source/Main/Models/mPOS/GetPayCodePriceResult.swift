//
//  GetPayCodePriceResult.swift
//  mPOS
//
//  Created by MinhDH on 11/12/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON
class GetPayCodePriceResult: NSObject {
    var ProviderId : Int
    var CardValue: Int
    var PurchasingPrice : Int
    var ReferPrice: Int

    init(ProviderId : Int, CardValue: Int, PurchasingPrice : Int, ReferPrice: Int){
        self.ProviderId = ProviderId
        self.PurchasingPrice = PurchasingPrice
        self.ReferPrice = ReferPrice
        self.CardValue = CardValue
    }
    class func parseObjfromArray(array:[JSON])->[GetPayCodePriceResult]{
        var list:[GetPayCodePriceResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> GetPayCodePriceResult{
        var ProviderId = data["ProviderId"].int
        var CardValue = data["CardValue"].int
        var PurchasingPrice = data["PurchasingPrice"].int
        var ReferPrice = data["ReferPrice"].int
        
        ProviderId = ProviderId == nil ? 0 : ProviderId
        CardValue = CardValue == nil ? 0 : CardValue
        PurchasingPrice = PurchasingPrice == nil ? 0 : PurchasingPrice
        ReferPrice = ReferPrice == nil ? 0 : ReferPrice
        
        return GetPayCodePriceResult(ProviderId : ProviderId!, CardValue: CardValue!, PurchasingPrice : PurchasingPrice!, ReferPrice: ReferPrice!)
    }
}

