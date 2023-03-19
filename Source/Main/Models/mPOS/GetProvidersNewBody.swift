//
//  GetProvidersNew.swift
//  mPOS
//
//  Created by sumi on 11/20/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetProvidersNewBody: NSObject {
    
    var PaymentBillProviderID: String
    var PaymentBillProviderCode : String
    var PaymentBillProviderName: String
    var PaymentBillServiceID: String
    var PaymentBillServiceCode : String
    var PaymentBillServiceName: String
    var PartnerUserCode: String
    var AgriBankProviderCode: String
    var AllowCardPayment: String
    var AllowCashPayment: String
    var AllowVoucherPayment: String
    var PaymentNote: String
    var SelectedComboTypeCard: String
    
    init(PaymentBillProviderID: String, PaymentBillProviderCode : String, PaymentBillProviderName: String, PaymentBillServiceID: String, PaymentBillServiceCode : String, PaymentBillServiceName: String, PartnerUserCode: String, AgriBankProviderCode: String, AllowCardPayment: String, AllowCashPayment: String, AllowVoucherPayment: String, PaymentNote: String, SelectedComboTypeCard: String){
        
        self.PaymentBillProviderID = PaymentBillProviderID
        self.PaymentBillProviderCode = PaymentBillProviderCode
        self.PaymentBillProviderName = PaymentBillProviderName
        self.PaymentBillServiceID = PaymentBillServiceID
        self.PaymentBillServiceCode = PaymentBillServiceCode
        self.PaymentBillServiceName = PaymentBillServiceName
        self.PartnerUserCode = PartnerUserCode
        self.AgriBankProviderCode = AgriBankProviderCode
        self.AllowCardPayment = AllowCardPayment
        self.AllowCashPayment = AllowCashPayment
        self.AllowVoucherPayment = AllowVoucherPayment
        self.PaymentNote = PaymentNote
        self.SelectedComboTypeCard = SelectedComboTypeCard
    }
    
    class func parseObjfromArray(array:[JSON])->[GetProvidersNewBody]{
        var list:[GetProvidersNewBody] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> GetProvidersNewBody{
        
        var PaymentBillProviderID = data["PaymentBillProviderID"].string
        var PaymentBillProviderCode = data["PaymentBillProviderCode"].string
        var PaymentBillProviderName = data["PaymentBillProviderName"].string
        
        PaymentBillProviderID = PaymentBillProviderID == nil ? "": PaymentBillProviderID
        PaymentBillProviderCode = PaymentBillProviderCode == nil ? "": PaymentBillProviderCode
        PaymentBillProviderName = PaymentBillProviderName == nil ? "": PaymentBillProviderName
        
        
        var  PaymentBillServiceID = data["PaymentBillServiceID"].string
        var PaymentBillServiceCode = data["PaymentBillServiceCode"].string
        var PaymentBillServiceName = data["PaymentBillServiceName"].string
        
        PaymentBillServiceID = PaymentBillServiceID == nil ? "": PaymentBillServiceID
        PaymentBillServiceCode = PaymentBillServiceCode == nil ? "": PaymentBillServiceCode
        PaymentBillServiceName = PaymentBillServiceName == nil ? "": PaymentBillServiceName
        
        var PartnerUserCode = data["PartnerUserCode"].string
        var  AgriBankProviderCode = data["AgriBankProviderCode"].string
        var AllowCardPayment = data["AllowCardPayment"].string
        
        PartnerUserCode = PartnerUserCode == nil ? "": PartnerUserCode
        AgriBankProviderCode = AgriBankProviderCode == nil ? "": AgriBankProviderCode
        AllowCardPayment = AllowCardPayment == nil ? "": AllowCardPayment
        
        var  AllowCashPayment = data["AllowCashPayment"].string
        var  AllowVoucherPayment = data["AllowVoucherPayment"].string
        var  PaymentNote = data["PaymentNote"].string
        var  SelectedComboTypeCard = data["SelectedComboTypeCard"].string
        
        AllowCashPayment = AllowCashPayment == nil ? "": AllowCashPayment
        AllowVoucherPayment = AllowVoucherPayment == nil ? "": AllowVoucherPayment
        PaymentNote = PaymentNote == nil ? "": PaymentNote
        SelectedComboTypeCard = SelectedComboTypeCard == nil ? "": SelectedComboTypeCard
        
        return GetProvidersNewBody(PaymentBillProviderID: PaymentBillProviderID!, PaymentBillProviderCode : PaymentBillProviderCode!, PaymentBillProviderName: PaymentBillProviderName!, PaymentBillServiceID: PaymentBillServiceID!, PaymentBillServiceCode : PaymentBillServiceCode!, PaymentBillServiceName: PaymentBillServiceName!, PartnerUserCode: PartnerUserCode!, AgriBankProviderCode: AgriBankProviderCode!, AllowCardPayment: AllowCardPayment!, AllowCashPayment: AllowCashPayment!, AllowVoucherPayment: AllowVoucherPayment!, PaymentNote: PaymentNote!, SelectedComboTypeCard: SelectedComboTypeCard!)
    }
}


