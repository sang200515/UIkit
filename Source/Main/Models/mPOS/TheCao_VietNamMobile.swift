//
//  TheCao_VietNamMobile.swift
//  mPOS
//
//  Created by sumi on 8/3/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class TheCao_VietNamMobile: NSObject {
    
    var CardValue: String
    var DocEntry: String
    var Expiration: String
    var Pin: String
    var Serial: String
    var TransactionDate: String
    var TransactionId: String
    
    init(CardValue: String, DocEntry: String, Expiration: String, Pin: String, Serial: String, TransactionDate: String, TransactionId: String){
        self.CardValue = CardValue
        self.DocEntry = DocEntry
        self.Expiration = Expiration
        self.Pin = Pin
        self.Serial = Serial
        self.TransactionDate = TransactionDate
        self.TransactionId = TransactionId
    }
    class func parseObjfromArray(array:[JSON])->[TheCao_VietNamMobile]{
        var list:[TheCao_VietNamMobile] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> TheCao_VietNamMobile{
        var CardValue = data["CardValue"].string
        var DocEntry = data["DocEntry"].string
        var Expiration = data["Expiration"].string
        var Pin = data["Pin"].string
        var Serial = data["Serial"].string
        var TransactionDate = data["TransactionDate"].string
        var TransactionId = data["TransactionId"].string
        
        CardValue = CardValue == nil ? "" : CardValue
        DocEntry = DocEntry == nil ? "" : DocEntry
        Expiration = Expiration == nil ? "" : Expiration
        Pin = Pin == nil ? "" : Pin
        Serial = Serial == nil ? "" : Serial
        TransactionDate = TransactionDate == nil ? "" : TransactionDate
        TransactionId = TransactionId == nil ? "" : TransactionId
        
        return TheCao_VietNamMobile(CardValue: CardValue!, DocEntry: DocEntry!, Expiration: Expiration!, Pin: Pin!, Serial: Serial!, TransactionDate: TransactionDate!, TransactionId: TransactionId!)
        
    }
}


