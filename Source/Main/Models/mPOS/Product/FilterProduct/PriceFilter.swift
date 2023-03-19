//
//  PriceFilter.swift
//  fptshop
//
//  Created by Ngo Dang tan on 8/24/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class PriceFilter:NSObject{
    var name:String
    var param_key:String
    var valueFilterPrices: [ValueFilterPrice]
    
    
    init(name:String
    , param_key:String
    , valueFilterPrices: [ValueFilterPrice]){
        self.name = name
        self.param_key = param_key
        self.valueFilterPrices = valueFilterPrices
    }
    
    
    class func getObjFromDictionary(data:JSON) -> PriceFilter{
        
        var name = data["name"].string
        var param_key = data["param_key"].string
        let valueFiltersDic = data["data"].array
        let valueFilters = ValueFilterPrice.parseObjfromArray(array: valueFiltersDic ?? [])
        name = name == nil ? "" : name
        param_key = param_key == nil ? "" : param_key
        
        return PriceFilter(name: name!,param_key:param_key!, valueFilterPrices: valueFilters)
    }
    class func parseObjfromArray(array:[JSON])->[PriceFilter]{
        var list:[PriceFilter] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
}
class ParamPriceFilter:Encodable{
    var from:Float?
    var to:Float?

    init(from:Float,to:Float){
        self.from = from
        self.to = to

    }
    class func dictionary(object:ParamPriceFilter) -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        guard let json = try? encoder.encode(object),
            let dict = try? JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] else {
                return [:]
        }
        return dict
    }
    class func convertParams(sortPriceFrom:Float,sortPriceTo:Float) -> [Any]{
        var lstDict:[Any] = []
        let paramPriceFilters:[ParamPriceFilter] = [ParamPriceFilter(from:sortPriceFrom ,to:sortPriceTo )]
        if(paramPriceFilters.count > 0){
            for item in paramPriceFilters{
                let dict = dictionary(object: item)
                lstDict.append(dict as Any)
            }
        }
        return lstDict
    }
}
class ParamPaginationFilter:Encodable{
    var from:Int?
    var size:Int?

    init(from:Int,size:Int){
        self.from = from
        self.size = size

    }
    class func dictionary(object:ParamPaginationFilter) -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        guard let json = try? encoder.encode(object),
            let dict = try? JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] else {
                return [:]
        }
        return dict
    }
    class func convertParams(from:Int,size:Int) -> [Any]{
        var lstDict:[Any] = []
        let paramPriceFilters:[ParamPaginationFilter] = [ParamPaginationFilter(from:from ,size:size )]
        if(paramPriceFilters.count > 0){
            for item in paramPriceFilters{
                let dict = dictionary(object: item)
                lstDict.append(dict as Any)
            }
        }
        return lstDict
    }
}
