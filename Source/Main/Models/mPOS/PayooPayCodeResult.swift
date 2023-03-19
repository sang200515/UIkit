//
//  PayooPayCodeResult.swift
//  mPOS
//
//  Created by sumi on 11/15/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON


class PayooPayCodeResult: NSObject {
    
    
    var InvoiceNo : String
    var ProviderId: String
    var Quantity: Int
    var SOMPOS: String
    var SystemTrace: String
    var TotalPurchasingAmount: Int
    var TotalReferAmount: Int
    var TransactionTime: Double
    var PayCodes: [CardCodePayoo]
    
    init(InvoiceNo: String, ProviderId: String, Quantity: Int, SOMPOS: String, SystemTrace : String, TotalPurchasingAmount: Int, TotalReferAmount: Int, TransactionTime: Double, PayCodes: [CardCodePayoo]){
        self.InvoiceNo = InvoiceNo
        self.ProviderId = ProviderId
        self.Quantity = Quantity
        self.SOMPOS = SOMPOS
        self.SystemTrace = SystemTrace
        self.TotalPurchasingAmount = TotalPurchasingAmount
        self.TotalReferAmount = TotalReferAmount
        self.TransactionTime = TransactionTime
        self.PayCodes = PayCodes
    }
    class func parseObjfromArray(array:[JSON])->[PayooPayCodeResult]{
        var list:[PayooPayCodeResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> PayooPayCodeResult{
        var InvoiceNo = data["InvoiceNo"].string
        var ProviderId = data["ProviderId"].string
        var Quantity = data["Quantity"].int
        var SOMPOS = data["SOMPOS"].string
        var SystemTrace = data["SystemTrace"].string
        var TotalPurchasingAmount = data["TotalPurchasingAmount"].int
        var TotalReferAmount = data["TotalReferAmount"].int
        var TransactionTime = data["TransactionTime"].double
        let PayCodes = CardCodePayoo.parseObjfromArray(array: data["PayCodes"].arrayValue)
        
        InvoiceNo = InvoiceNo == nil ? "" : InvoiceNo
        ProviderId = ProviderId == nil ? "" : ProviderId
        Quantity = Quantity == nil ? 0 : Quantity
        SOMPOS = SOMPOS == nil ? "" : SOMPOS
        SystemTrace = SystemTrace == nil ? "" : SystemTrace
        TotalPurchasingAmount = TotalPurchasingAmount == nil ? 0 : TotalPurchasingAmount
        
        TotalReferAmount = TotalReferAmount == nil ? 0 : TotalReferAmount
        TransactionTime = TransactionTime == nil ? 0 : TransactionTime
      
        
        return PayooPayCodeResult(InvoiceNo : InvoiceNo!, ProviderId: ProviderId!, Quantity : Quantity!, SOMPOS: SOMPOS!, SystemTrace : SystemTrace!, TotalPurchasingAmount: TotalPurchasingAmount!, TotalReferAmount : TotalReferAmount!, TransactionTime: TransactionTime!, PayCodes: PayCodes)
        
    }
}
