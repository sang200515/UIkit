//
//  PayooTopupResult.swift
//  mPOS
//
//  Created by MinhDH on 11/12/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class PayooTopupResult: NSObject {
    
    var InvoiceNo : String
    var CardValue: Int
    var PrimaryAccount : String
    var SOMPOS:String
    var TotalPurchasingAmount: Int
    var TotalReferAmount: Int
    
    init(InvoiceNo: String, CardValue: Int, PrimaryAccount : String, SOMPOS:String, TotalPurchasingAmount: Int, TotalReferAmount: Int){
        self.InvoiceNo = InvoiceNo
        self.CardValue = CardValue
        self.PrimaryAccount = PrimaryAccount
        self.SOMPOS = SOMPOS
        self.TotalPurchasingAmount = TotalPurchasingAmount
        self.TotalReferAmount = TotalReferAmount
    }
    class func parseObjfromArray(array:[JSON])->[PayooTopupResult]{
        var list:[PayooTopupResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> PayooTopupResult{
        var InvoiceNo = data["InvoiceNo"].string
        var CardValue = data["CardValue"].int
        var PrimaryAccount = data["PrimaryAccount"].string
        var SOMPOS = data["SOMPOS"].string
        var TotalPurchasingAmount = data["TotalPurchasingAmount"].int
        var TotalReferAmount = data["TotalReferAmount"].int
        
        InvoiceNo = InvoiceNo == nil ? "" : InvoiceNo
        CardValue = CardValue == nil ? 0 : CardValue
        PrimaryAccount = PrimaryAccount == nil ? "" : PrimaryAccount
        SOMPOS = SOMPOS == nil ? "" : SOMPOS
        TotalPurchasingAmount = TotalPurchasingAmount == nil ? 0 : TotalPurchasingAmount
        TotalReferAmount = TotalReferAmount == nil ? 0 : TotalReferAmount
        
        return PayooTopupResult(InvoiceNo: InvoiceNo!, CardValue: CardValue!, PrimaryAccount : PrimaryAccount!, SOMPOS:SOMPOS!, TotalPurchasingAmount: TotalPurchasingAmount!, TotalReferAmount: TotalReferAmount!)
        
    }
}

