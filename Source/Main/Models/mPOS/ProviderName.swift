//
//  ProviderName.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ProviderName: NSObject {
    var NhaMang: String
    var isSelect:Bool
    var id:Int
    init(NhaMang: String, isSelect:Bool, id:Int){
        self.NhaMang = NhaMang
         self.isSelect = isSelect
        self.id = id
    }
    class func parseObjfromArray(array:[JSON])->[ProviderName]{
        var list:[ProviderName] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ProviderName{
        var nhaMang = data["CDName"].string
        nhaMang = nhaMang == nil ? "" : nhaMang
        return ProviderName(NhaMang: nhaMang!,isSelect:false,id:0)
    }
}

