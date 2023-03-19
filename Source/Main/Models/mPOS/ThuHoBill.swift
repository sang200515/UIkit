//
//  ThuHoBill.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/30/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ThuHoBill: NSObject {
    
    var RandomString:String
    var IsOffline:Int
    var ReturnCode: String
    var Description: String
    var PaymentFeeType: Int
    var PercentFee: Int
    var ConstantFee: Int
    var MinFee: Int
    var MaxFee: Int
    var PaymentRule: Int
    var CustomerInfo: String
    var CustomerName: String
    var BusinessName: String
    var BusinessOrderNo: String
    var FlyInfo: String
    var TenNCCEcom: String
    var PaymentRange: String
    var TotalAmount: Int
    var PaymentFee: Int
    var ListMutiBill: [ItemMutiBill]
    var IDCardNo: String
    var CompanyName: String
    var AgriTransactionCode: String
    var ListDetailAgribank: [ItemDetailAgribank]
    var ListDetailPayoo: [ItemDetailPayoo]
    
    init(RandomString:String, IsOffline:Int, ReturnCode: String, Description: String, PaymentFeeType: Int, PercentFee: Int, ConstantFee: Int, MinFee: Int, MaxFee: Int, PaymentRule: Int, CustomerInfo: String, CustomerName: String, BusinessName: String, BusinessOrderNo: String, FlyInfo: String, TenNCCEcom: String, PaymentRange: String, TotalAmount: Int, PaymentFee: Int, ListMutiBill: [ItemMutiBill], IDCardNo: String, CompanyName: String, AgriTransactionCode: String, ListDetailAgribank: [ItemDetailAgribank], ListDetailPayoo: [ItemDetailPayoo]){
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
        self.ListDetailPayoo = ListDetailPayoo
    }
    class func parseObjfromArray(array:[JSON])->[ThuHoBill]{
        var list:[ThuHoBill] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ThuHoBill{
        var IsOffline = data["IsOffline"].int
        var RandomString = data["RandomString"].string
        var ReturnCode = data["ReturnCode"].string
        
        IsOffline = IsOffline == nil ? 0 : IsOffline
        RandomString = RandomString == nil ? "": RandomString
        ReturnCode = ReturnCode == nil ? "": ReturnCode
        
        var Description = data["Description"].string
        var PaymentFeeType = data["PaymentFeeType"].int
        var PercentFee = data["PercentFee"].int
        
        Description = Description == nil ? "": Description
        PaymentFeeType = PaymentFeeType == nil ? 0 : PaymentFeeType
        PercentFee = PercentFee == nil ? 0 : PercentFee
        
        var ConstantFee = data["ConstantFee"].int
        var MinFee = data["MinFee"].int
        var MaxFee = data["MaxFee"].int
        
        ConstantFee = ConstantFee == nil ? 0 : ConstantFee
        MinFee = MinFee == nil ? 0 : MinFee
        MaxFee = MaxFee == nil ? 0 : MaxFee
        
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
        var ListMutiBill = data["ListMutiBill"].array
        var  IDCardNo = data["IDCardNo"].string
        
        PaymentFee = PaymentFee == nil ? 0 : PaymentFee
        ListMutiBill = ListMutiBill == nil ? [] : ListMutiBill
        IDCardNo = IDCardNo == nil ? "": IDCardNo
        
        var CompanyName = data["CompanyName"].string
        var AgriTransactionCode = data["AgriTransactionCode"].string
        var ListDetailAgribank = data["ListDetailAgribank"].array
        var ListDetailPayoo = data["ListDetailPayoo"].array
        
        CompanyName = CompanyName == nil ? "": CompanyName
        AgriTransactionCode = AgriTransactionCode == nil ? "": AgriTransactionCode
        ListDetailAgribank = ListDetailAgribank == nil ? []: ListDetailAgribank
        ListDetailPayoo = ListDetailPayoo == nil ? []: ListDetailPayoo
        
        let listPayoo = ItemDetailPayoo.parseObjfromArray(array: ListDetailPayoo!)
        let listAgribank = ItemDetailAgribank.parseObjfromArray(array: ListDetailAgribank!)
        let listMutiBill = ItemMutiBill.parseObjfromArray(array: ListMutiBill!)
        
        return ThuHoBill(RandomString:RandomString!, IsOffline:IsOffline!, ReturnCode: ReturnCode!, Description: Description!, PaymentFeeType: PaymentFeeType!, PercentFee: PercentFee!, ConstantFee: ConstantFee!, MinFee: MinFee!, MaxFee: MaxFee!, PaymentRule: PaymentRule!, CustomerInfo: CustomerInfo!, CustomerName: CustomerName!, BusinessName: BusinessName!, BusinessOrderNo: BusinessOrderNo!, FlyInfo: FlyInfo!, TenNCCEcom: TenNCCEcom!, PaymentRange: PaymentRange!, TotalAmount: TotalAmount!, PaymentFee: PaymentFee!, ListMutiBill: listMutiBill, IDCardNo: IDCardNo!, CompanyName: CompanyName!, AgriTransactionCode: AgriTransactionCode!, ListDetailAgribank: listAgribank,ListDetailPayoo:listPayoo)
    }
}

