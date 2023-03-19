//
//  ConfirmThuKhoResult.swift
//  NewmDelivery
//
//  Created by sumi on 3/28/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class ConfirmThuKhoResult2: NSObject {
    var Result : String
    var Description: String
    
    init(Result: String, Description: String) {
        self.Result = Result
        self.Description = Description
    }
    class func getObjFromDictionary(data:JSON) -> ConfirmThuKhoResult2{
        
        var Result = data["Result"].string
        var Description = data["Description"].string
        
        Result = Result == nil ? "" : Result
        Description = Description == nil ? "" : Description
        
        return ConfirmThuKhoResult2(Result : Result!, Description : Description!)
    }
    class func parseObjfromArray(array:[JSON])->[ConfirmThuKhoResult2]{
        var list:[ConfirmThuKhoResult2] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
}
