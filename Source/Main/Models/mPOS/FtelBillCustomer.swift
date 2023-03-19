//
//  FtelBillCustomer.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 1/8/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class FtelBillCustomer: NSObject {
    
    var AmountCurrentFtel: Int
    var CustomerNameFtel: String
    var Description: String
    var BillDescription: String
    var ReturnCode: String
    
    var FtelBillDate: String
    var FtelBillList: String
    var ListBill:[BillFtel]
    var UserName: String
    var FtelAmountList: String
    
    init(AmountCurrentFtel: Int, CustomerNameFtel: String, Description: String, BillDescription: String, ReturnCode: String, FtelBillDate: String, FtelBillList: String, ListBill:[BillFtel], UserName: String, FtelAmountList: String){
        self.AmountCurrentFtel = AmountCurrentFtel
        self.CustomerNameFtel = CustomerNameFtel
        self.Description = Description
        self.BillDescription = BillDescription
        self.ReturnCode = ReturnCode
        self.FtelBillDate = FtelBillDate
        self.FtelBillList = FtelBillList
        self.ListBill = ListBill
        self.UserName = UserName
        self.FtelAmountList = FtelAmountList
    }
    class func parseObjfromArray(array:[JSON])->[FtelBillCustomer]{
        var list:[FtelBillCustomer] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> FtelBillCustomer{
        var AmountCurrentFtel = data["AmountCurrentFtel"].int
        var CustomerNameFtel = data["CustomerNameFtel"].string
        var Description = data["Description"].string
        var BillDescription = data["BillDescription"].string
        var ReturnCode = data["ReturnCode"].string
        
        var FtelBillDate = data["FtelBillDate"].string
        var FtelBillList = data["FtelBillList"].string
        
        var UserName = data["UserName"].string
        var FtelAmountList = data["FtelAmountList"].string
        
        var ListBill = data["ListBill"].array
        
        AmountCurrentFtel = AmountCurrentFtel == nil ? 0 : AmountCurrentFtel
        CustomerNameFtel = CustomerNameFtel == nil ? "" : CustomerNameFtel
        Description = Description == nil ? "" : Description
        BillDescription = BillDescription == nil ? "" : BillDescription
        ReturnCode = ReturnCode == nil ? "" : ReturnCode
        
        FtelBillDate = FtelBillDate == nil ? "" : FtelBillDate
        FtelBillList = FtelBillList == nil ? "" : FtelBillList
        
        UserName = UserName == nil ? "" : UserName
        FtelAmountList = FtelAmountList == nil ? "" : FtelAmountList
        ListBill = ListBill == nil ? [] : ListBill
        
        let list = BillFtel.parseObjfromArray(array: ListBill!)
        
        return FtelBillCustomer(AmountCurrentFtel: AmountCurrentFtel!, CustomerNameFtel: CustomerNameFtel!, Description: Description!, BillDescription: BillDescription!, ReturnCode: ReturnCode!, FtelBillDate: FtelBillDate!, FtelBillList: FtelBillList!, ListBill:list, UserName: UserName!, FtelAmountList: FtelAmountList!)
        
    }
}
