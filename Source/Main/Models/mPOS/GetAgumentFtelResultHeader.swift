//
//  GetAgumentFtelResult.swift
//  mPOS
//
//  Created by sumi on 12/4/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON
class GetAgumentFtelResultHeader: NSObject {
    
    var ReturnCode: String
    var Description: String
    var CustomerNameFtel: String
    var UserName: String
    var AmountCurrentFtel: Int
    var FtelBillList: String
    var FtelAmountList: String
    var FtelBillDate: String
    var BillDescription: String
    
    init(ReturnCode: String, Description: String, CustomerNameFtel: String, UserName: String, AmountCurrentFtel: Int, FtelBillList: String, FtelAmountList: String, FtelBillDate: String, BillDescription: String){
        self.ReturnCode =  ReturnCode
        self.Description = Description
        self.CustomerNameFtel = CustomerNameFtel
        self.UserName = UserName
        self.AmountCurrentFtel = AmountCurrentFtel
        self.FtelBillList = FtelBillList
        self.FtelAmountList = FtelAmountList
        self.FtelBillDate = FtelBillDate
        self.BillDescription = BillDescription
    }
    class func parseObjfromArray(array:[JSON])->[GetAgumentFtelResultHeader]{
        var list:[GetAgumentFtelResultHeader] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> GetAgumentFtelResultHeader{
        var ReturnCode = data["ReturnCode"].string
        var  Description = data["Description"].string
        var  CustomerNameFtel = data["CustomerNameFtel"].string
        var  UserName = data["UserName"].string
        var  AmountCurrentFtel = data["AmountCurrentFtel"].int
        var FtelBillList = data["FtelBillList"].string
        var   FtelAmountList = data["FtelAmountList"].string
        var FtelBillDate = data["FtelBillDate"].string
        var  BillDescription = data["BillDescription"].string
        
        ReturnCode = ReturnCode == nil ? "" : ReturnCode
        Description = Description == nil ? "" :Description
        CustomerNameFtel = CustomerNameFtel == nil ? "" : CustomerNameFtel
        UserName = UserName == nil ? "" : UserName
        AmountCurrentFtel = AmountCurrentFtel == nil ? 0 : AmountCurrentFtel
        FtelBillList = FtelBillList == nil ? "" : FtelBillList
        FtelAmountList = FtelAmountList == nil ? "" : FtelAmountList
        FtelBillDate = FtelBillDate == nil ? "" : FtelBillDate
        BillDescription = BillDescription == nil ? "" : BillDescription
        
        return GetAgumentFtelResultHeader(ReturnCode: ReturnCode!, Description: Description!, CustomerNameFtel: CustomerNameFtel!, UserName: UserName!, AmountCurrentFtel: AmountCurrentFtel!, FtelBillList: FtelBillList!, FtelAmountList: FtelAmountList!, FtelBillDate: FtelBillDate!, BillDescription: BillDescription!)
    }
    
}

