//
//  Include_Tintuc.swift
//  fptshop
//
//  Created by DiemMy Le on 4/15/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class Include_Tintuc: NSObject {
    var type:String
    var id:String
    var img_url:String
    var include_url_name:String
    
    init(type:String, id:String, img_url:String, include_url_name:String) {
        self.type = type
        self.id = id
        self.img_url = img_url
        self.include_url_name = include_url_name
    }
    
    class func parseObjfromArray(array:[JSON])->[Include_Tintuc]{
        var list:[Include_Tintuc] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> Include_Tintuc{
        var type = data["type"].string
        var id = data["id"].string
        
        let attributes_include = data["attributes"]
        let uri = attributes_include["uri"]
        var img_url = uri["url"].string
        var include_url_name = uri["value"].string
 
        type = type == nil ? "" : type
        id = id == nil ? "" : id
        img_url = img_url == nil ? "" : img_url
        include_url_name = include_url_name == nil ? "" : include_url_name
//
        return Include_Tintuc(type: type!, id: id!, img_url: img_url!, include_url_name:include_url_name!)
    }
}
