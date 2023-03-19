//
//  ItemMutiBill.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/30/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ItemMutiBill: NSObject {
    
    var CustomerIDMutiBill: String
    var MoneyAmount: String
    var Title: String
    
    init(CustomerIDMutiBill: String, MoneyAmount: String, Title: String){
        self.CustomerIDMutiBill =  CustomerIDMutiBill
        self.MoneyAmount = MoneyAmount
        self.Title = Title
    }
    class func parseObjfromArray(array:[JSON])->[ItemMutiBill]{
        var list:[ItemMutiBill] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ItemMutiBill{
        var CustomerIDMutiBill = data["CustomerIDMutiBill"].string
        var MoneyAmount = data["MoneyAmount"].string
        var Title = data["Title"].string
        
        CustomerIDMutiBill = CustomerIDMutiBill == nil ? "" : CustomerIDMutiBill
        MoneyAmount = MoneyAmount == nil ? "" : MoneyAmount
        Title = Title == nil ? "" : Title
        return ItemMutiBill(CustomerIDMutiBill: CustomerIDMutiBill!, MoneyAmount: MoneyAmount!, Title: Title!)
        
    }
}


