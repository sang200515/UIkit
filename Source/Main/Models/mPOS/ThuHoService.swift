//
//  ThuHoService.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/30/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ThuHoService: NSObject {
    var PaymentBillServiceName: String
    var ListProvider: [ThuHoProvider]
    
    init(PaymentBillServiceName: String,ListProvider: [ThuHoProvider]) {
        self.PaymentBillServiceName = PaymentBillServiceName
        self.ListProvider = ListProvider
    }
    class func parseObjfromArray(array:[JSON])->[ThuHoService]{
        var list:[ThuHoService] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ThuHoService{
        
        var PaymentBillServiceName = data["PaymentBillServiceName"].string
        var ListProvider = data["ListProvider"].array
        PaymentBillServiceName = PaymentBillServiceName == nil ? "" : PaymentBillServiceName
        ListProvider = ListProvider == nil ? [] : ListProvider
        
        let arr = ThuHoProvider.parseObjfromArray(array: ListProvider!)
        
        return ThuHoService(PaymentBillServiceName: PaymentBillServiceName!,ListProvider: arr)
    }
}
