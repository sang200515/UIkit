//
//  SearchCustomersResult.swift
//  mPOS
//
//  Created by tuan luong on 14/11/2017.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON


class SearchCustomersResult: NSObject {
    
    var CustomerName : String
    var SDT: String
    var ServiceID : String
    var ServiceName: String
    var ProviderID: String
    var ProviderName : String
    var NumberContract: String
    
    init(CustomerName : String, SDT: String, ServiceID : String, ServiceName: String, ProviderID: String, ProviderName : String, NumberContract: String){
        self.CustomerName = CustomerName
        self.SDT = SDT
        self.ServiceID = ServiceID
        self.ServiceName = ServiceName
        self.ProviderID = ProviderID
        self.ProviderName = ProviderName
        self.NumberContract = NumberContract
    }
    
    class func parseObjfromArray(array:[JSON])->[SearchCustomersResult]{
        var list:[SearchCustomersResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    class func getObjFromDictionary(data:JSON) -> SearchCustomersResult{
        var  CustomerName = data["CustomerName"].string
        var  SDT = data["SDT"].string
        var  ServiceID = data["ServiceID"].string
        var  ServiceName = data["ServiceName"].string
        var  ProviderID = data["ProviderID"].string
        var  ProviderName = data["ProviderName"].string
        var  NumberContract = data["NumberContract"].string
        
        CustomerName = CustomerName == nil ? "" : CustomerName
        SDT = SDT == nil ? "" : SDT
        ServiceID = ServiceID == nil ? "" : ServiceID
        ServiceName = ServiceName == nil ? "" : ServiceName
        ProviderID = ProviderID == nil ? "" : ProviderID
        ProviderName = ProviderName == nil ? "" : ProviderName
        NumberContract = NumberContract == nil ? "" : NumberContract
        
        return SearchCustomersResult(CustomerName : CustomerName!, SDT: SDT!, ServiceID : ServiceID!, ServiceName: ServiceName!, ProviderID: ProviderID!, ProviderName : ProviderName!, NumberContract: NumberContract!)
    }
}


