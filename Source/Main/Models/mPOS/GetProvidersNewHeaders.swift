//
//  GetProvidersNewHeaders.swift
//  mPOS
//
//  Created by sumi on 11/20/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetProvidersNewHeaders: NSObject {

    var PaymentBillServiceName: String
    
    init(PaymentBillServiceName:String){
        self.PaymentBillServiceName = PaymentBillServiceName
    }

    class func parseObjfromArray(array:[JSON])->[GetProvidersNewHeaders]{
        var list:[GetProvidersNewHeaders] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    class func getObjFromDictionary(data:JSON) -> GetProvidersNewHeaders{
        var PaymentBillServiceName = data["PaymentBillServiceName"].string
        PaymentBillServiceName = PaymentBillServiceName == nil ? "" : PaymentBillServiceName
        return GetProvidersNewHeaders(PaymentBillServiceName: PaymentBillServiceName!)
    }
}




