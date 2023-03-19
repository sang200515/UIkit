
//
//  BankRP.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/18/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class CardBankRP: NSObject {
    var CreditCard:Int
    var CardName:String
    var PercentFee:Float
    
    init( CreditCard:Int
        , CardName:String
        , PercentFee:Float){
        self.CreditCard = CreditCard
        self.CardName = CardName
        self.PercentFee = PercentFee
    }
    
    
    class func parseObjfromArray(array:[JSON])->[CardBankRP]{
        var list:[CardBankRP] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> CardBankRP{
        var CreditCard = data["CreditCard"].int
        var CardName = data["CardName"].string
        var PercentFee = data["PercentFee"].float
        
        CreditCard = CreditCard == nil ? 0 : CreditCard
        CardName = CardName == nil ? "" : CardName
        PercentFee = PercentFee == nil ? 0 : PercentFee
        return CardBankRP(CreditCard:CreditCard!
            , CardName:CardName!
            ,PercentFee:PercentFee!
        )
    }
    
}
