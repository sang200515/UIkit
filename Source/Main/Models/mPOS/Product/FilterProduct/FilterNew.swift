//
//  FilterNew.swift
//  fptshop
//
//  Created by Ngo Dang tan on 8/24/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class FilterNew: NSObject {
    var sort: SortFilter
    var price:PriceFilter
    var group_name:SortFilter
    var firm_name:SortFilter
    var inventory:SortFilter
    
    init(sort: SortFilter
    , price:PriceFilter
    , group_name:SortFilter
    , firm_name:SortFilter
         ,inventory:SortFilter){
        self.sort = sort
        self.price = price
        self.group_name = group_name
        self.firm_name = firm_name
        self.inventory = inventory
    }

    class func getObjFromDictionary(data:JSON) -> FilterNew{
        
        //sort
        let sortDic = data["_sort"]
        let sort  = SortFilter.getObjFromDictionary(data: sortDic)
        //price
        let priceDic = data["_price"]
        let price  = PriceFilter.getObjFromDictionary(data: priceDic)
        //_group_name
        let groupNameDic = data["_group_name"]
        let groupname  = SortFilter.getObjFromDictionary(data: groupNameDic)
        //_firm_name
        let firmNameDic = data["_firm_name"]
        let firmname  = SortFilter.getObjFromDictionary(data: firmNameDic)
        //_inventory
        let inventoryDic = data["_inventory"]
        let inventory  = SortFilter.getObjFromDictionary(data: inventoryDic)
        
        return FilterNew(sort: sort, price: price, group_name: groupname, firm_name: firmname,inventory: inventory)
    }
}
