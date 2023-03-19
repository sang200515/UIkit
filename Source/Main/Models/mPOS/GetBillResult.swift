//
//  GetBillResult.swift
//  mPOS
//
//  Created by sumi on 11/21/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetBillResult: NSObject {
    
    var RandomString:String
    var IsOffline:String
    var ReturnCode: String
    var Description: String
    var PaymentFeeType: String
    var PercentFee: String
    var ConstantFee: String
    var MinFee: String
    var MaxFee: String
    var PaymentRule: String
    var CustomerInfo: String
    var CustomerName: String
    var BusinessName: String
    var BusinessOrderNo: String
    var FlyInfo: String
    var TenNCCEcom: String
    var PaymentRange: String
    var TotalAmount: Int
    var PaymentFee: Int
    var ListMutiBill: String
    var IDCardNo: String
    var CompanyName: String
    var AgriTransactionCode: String
    var ListDetailAgribank: String
    
    init(RandomString:String, IsOffline:String, ReturnCode: String, Description: String, PaymentFeeType: String, PercentFee: String, ConstantFee: String, MinFee: String, MaxFee: String, PaymentRule: String, CustomerInfo: String, CustomerName: String, BusinessName: String, BusinessOrderNo: String, FlyInfo: String, TenNCCEcom: String, PaymentRange: String, TotalAmount: Int, PaymentFee: Int, ListMutiBill: String, IDCardNo: String, CompanyName: String, AgriTransactionCode: String, ListDetailAgribank: String){
        self.RandomString = RandomString
        self.IsOffline = IsOffline
        self.ReturnCode = ReturnCode
        self.Description = Description
        self.PaymentFeeType = PaymentFeeType
        self.PercentFee = PercentFee
        self.ConstantFee = ConstantFee
        self.MinFee = MinFee
        self.MaxFee = MaxFee
        self.PaymentRule = PaymentRule
        self.CustomerInfo = CustomerInfo
        self.CustomerName = CustomerName
        self.BusinessName = BusinessName
        self.BusinessOrderNo = BusinessOrderNo
        self.FlyInfo = FlyInfo
        self.TenNCCEcom = TenNCCEcom
        self.PaymentRange = PaymentRange
        self.TotalAmount = TotalAmount
        self.PaymentFee = PaymentFee
        self.ListMutiBill = ListMutiBill
        self.IDCardNo = IDCardNo
        self.CompanyName = CompanyName
        self.AgriTransactionCode = AgriTransactionCode
        self.ListDetailAgribank = ListDetailAgribank
    }
    class func parseObjfromArray(array:[JSON])->[GetBillResult]{
        var list:[GetBillResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> GetBillResult{
        var IsOffline = data["IsOffline"].string
        var RandomString = data["RandomString"].string
        var ReturnCode = data["ReturnCode"].string
        
        IsOffline = IsOffline == nil ? "": IsOffline
        RandomString = RandomString == nil ? "": RandomString
        ReturnCode = ReturnCode == nil ? "": ReturnCode
        
        var Description = data["Description"].string
        var PaymentFeeType = data["PaymentFeeType"].string
        var PercentFee = data["PercentFee"].string
        
        Description = Description == nil ? "": Description
        PaymentFeeType = PaymentFeeType == nil ? "": PaymentFeeType
        PercentFee = PercentFee == nil ? "": PercentFee
        
        var ConstantFee = data["ConstantFee"].string
        var MinFee = data["MinFee"].string
        var MaxFee = data["MaxFee"].string
        
        ConstantFee = ConstantFee == nil ? "": ConstantFee
        MinFee = MinFee == nil ? "": MinFee
        MaxFee = MaxFee == nil ? "": MaxFee
        
        var PaymentRule = data["PaymentRule"].int
        var CustomerInfo = data["CustomerInfo"].string
        var  CustomerName = data["CustomerName"].string
        
        PaymentRule = PaymentRule == nil ? 0 : PaymentRule
        CustomerInfo = CustomerInfo == nil ? "": CustomerInfo
        CustomerName = CustomerName == nil ? "": CustomerName
        
        var  BusinessName = data["BusinessName"].string
        var BusinessOrderNo = data["BusinessOrderNo"].string
        var  FlyInfo = data["FlyInfo"].string
        
        BusinessName = BusinessName == nil ? "": BusinessName
        BusinessOrderNo = BusinessOrderNo == nil ? "": BusinessOrderNo
        FlyInfo = FlyInfo == nil ? "": FlyInfo
        
        var TenNCCEcom = data["TenNCCEcom"].string
        var  PaymentRange = data["PaymentRange"].string
        var TotalAmount = data["TotalAmount"].int
        
        TenNCCEcom = TenNCCEcom == nil ? "": TenNCCEcom
        PaymentRange = PaymentRange == nil ? "": PaymentRange
        TotalAmount = TotalAmount == nil ? 0 : TotalAmount
        
        var PaymentFee = data["PaymentFee"].int
        var ListMutiBill = data["ListMutiBill"].string
        var  IDCardNo = data["IDCardNo"].string
        
        PaymentFee = PaymentFee == nil ? 0 : PaymentFee
        ListMutiBill = ListMutiBill == nil ? "": ListMutiBill
        IDCardNo = IDCardNo == nil ? "": IDCardNo
        
        var CompanyName = data["CompanyName"].string
        var AgriTransactionCode = data["AgriTransactionCode"].string
        var ListDetailAgribank = data["ListDetailAgribank"].string
        
        CompanyName = CompanyName == nil ? "": CompanyName
        AgriTransactionCode = AgriTransactionCode == nil ? "": AgriTransactionCode
        ListDetailAgribank = ListDetailAgribank == nil ? "": ListDetailAgribank
        
        return GetBillResult(RandomString:RandomString!, IsOffline:IsOffline!, ReturnCode: ReturnCode!, Description: Description!, PaymentFeeType: PaymentFeeType!, PercentFee: PercentFee!, ConstantFee: ConstantFee!, MinFee: MinFee!, MaxFee: MaxFee!, PaymentRule: "\(PaymentRule!)", CustomerInfo: CustomerInfo!, CustomerName: CustomerName!, BusinessName: BusinessName!, BusinessOrderNo: BusinessOrderNo!, FlyInfo: FlyInfo!, TenNCCEcom: TenNCCEcom!, PaymentRange: PaymentRange!, TotalAmount: TotalAmount!, PaymentFee: PaymentFee!, ListMutiBill: ListMutiBill!, IDCardNo: IDCardNo!, CompanyName: CompanyName!, AgriTransactionCode: AgriTransactionCode!, ListDetailAgribank: ListDetailAgribank!)
    }
    
}



