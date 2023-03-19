//
//  GetFtelLocationsResult.swift
//  mPOS
//
//  Created by sumi on 12/1/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON
class GetFtelLocationsResult: NSObject {
    
    var ProvinceCode: Int
    var ProvinceName: String
    
    init(ProvinceCode: Int, ProvinceName: String){
        self.ProvinceCode =  ProvinceCode
        self.ProvinceName = ProvinceName
    }
    class func parseObjfromArray(array:[JSON])->[GetFtelLocationsResult]{
        var list:[GetFtelLocationsResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> GetFtelLocationsResult{
        var ProvinceName = data["ProvinceName"].string
        var ProvinceCode = data["ProvinceCode"].int
        
        ProvinceName = ProvinceName == nil ? "" : ProvinceName
        ProvinceCode = ProvinceCode == nil ? 0 : ProvinceCode
        
        return GetFtelLocationsResult(ProvinceCode: ProvinceCode!, ProvinceName: ProvinceName!)
        
    }
}

