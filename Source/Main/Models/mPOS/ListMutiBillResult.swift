//
//  ListMutiBillResult.swift
//  mPOS
//
//  Created by sumi on 12/4/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class ListMutiBillResult: NSObject {
    
    var CustomerIDMutiBill: String
    var MoneyAmount: String
    var Title: String
    
    init(CustomerIDMutiBill: String, MoneyAmount: String, Title: String){
        self.CustomerIDMutiBill =  CustomerIDMutiBill
        self.MoneyAmount = MoneyAmount
        self.Title = Title
    }
    class func parseObjfromArray(array:[JSON])->[ListMutiBillResult]{
        var list:[ListMutiBillResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ListMutiBillResult{
        var CustomerIDMutiBill = data["CustomerIDMutiBill"].string
        var MoneyAmount = data["MoneyAmount"].string
        var Title = data["Title"].string
        
        CustomerIDMutiBill = CustomerIDMutiBill == nil ? "" : CustomerIDMutiBill
        MoneyAmount = MoneyAmount == nil ? "" : MoneyAmount
        Title = Title == nil ? "" : Title
        return ListMutiBillResult(CustomerIDMutiBill: CustomerIDMutiBill!, MoneyAmount: MoneyAmount!, Title: Title!)
        
    }
}


