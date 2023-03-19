//
//  DebitCustomer.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/31/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class DebitCustomer: NSObject {
    
    var TenCty: String
    var CustomerIdCard: String
    var TenureOfLoan: Int
    var Interestrate: Float
    var ContractNo_AgreementNo: String
    var MaCty:String
    var DownPaymentAmount: Float
    
    
    init(TenCty: String,CustomerIdCard: String,TenureOfLoan: Int,Interestrate: Float,ContractNo_AgreementNo: String,MaCty:String,DownPaymentAmount: Float){
        self.TenCty = TenCty
        self.CustomerIdCard = CustomerIdCard
        self.TenureOfLoan = TenureOfLoan
        self.Interestrate = Interestrate
        self.ContractNo_AgreementNo = ContractNo_AgreementNo
        self.MaCty = MaCty
        self.DownPaymentAmount = DownPaymentAmount
    }
    class func parseObjfromArray(array:[JSON])->[DebitCustomer]{
        var list:[DebitCustomer] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> DebitCustomer{
        
        var tenCty = data["TenCty"].string
        var customerIdCard = data["CustomerIdCard"].string
        var tenureOfLoan = data["TenureOfLoan"].int
        var interestrate = data["interestrate"].float
        var contractNo_AgreementNo = data["ContractNo_AgreementNo"].string
        var maCty = data["MaCty"].string
        var downPaymentAmount = data["DownPaymentAmount"].float
        
        tenCty = tenCty == nil ? "" : tenCty
        customerIdCard = customerIdCard == nil ? "" : customerIdCard
        tenureOfLoan = tenureOfLoan == nil ? 0 : tenureOfLoan
        interestrate = interestrate == nil ? 0.0 : interestrate
        contractNo_AgreementNo = contractNo_AgreementNo == nil ? "" : contractNo_AgreementNo
        maCty = maCty == nil ? "" : maCty
        downPaymentAmount = downPaymentAmount == nil ? 0.0 : downPaymentAmount
        
        return DebitCustomer(TenCty: tenCty!,CustomerIdCard: customerIdCard!,TenureOfLoan: tenureOfLoan!,Interestrate: interestrate!,ContractNo_AgreementNo: contractNo_AgreementNo!,MaCty:maCty!,DownPaymentAmount: downPaymentAmount!)
    }
    
}

