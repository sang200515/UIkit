//
//  ValueFilterPrice.swift
//  fptshop
//
//  Created by Ngo Dang tan on 8/24/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ValueFilterPrice: NSObject {
    var label:String
    var from:Float
    var to:Float
    var isSelectFilter:Bool
    
    init(label:String
    , from:Float
    , to:Float
         ,isSelectFilter:Bool = false){
        self.label = label
        self.from = from
        self.to = to
        self.isSelectFilter = isSelectFilter
    }
    
    class func getObjFromDictionary(data:JSON) -> ValueFilterPrice{
            
        var label = data["label"].string
        var from = data["from"].float
        var to = data["to"].float
        
        
        label = label == nil ? "" : label
        from = from == nil ? 0 : from
        to = to == nil ? 0 : to
            
        return ValueFilterPrice(label:label!, from:from!,to:to!)
        }
        class func parseObjfromArray(array:[JSON])->[ValueFilterPrice]{
            var list:[ValueFilterPrice] = []
            for item in array {
                list.append(self.getObjFromDictionary(data: item))
            }
            return list
        }
}
