//
//  BankRP.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/18/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class BankRP: NSObject {
    var code:Int
    var name:String
    
    init(code:Int,name:String){
        self.code = code
        self.name = name
    }
    
    class func parseObjfromArray(array:[JSON])->[BankRP]{
         var list:[BankRP] = []
         for item in array {
             list.append(self.getObjFromDictionary(data: item))
         }
         return list
     }
     
     class func getObjFromDictionary(data:JSON) -> BankRP{
         var code = data["code"].int
         var name = data["name"].string

         
         code = code == nil ? 0 : code
         name = name == nil ? "" : name
     
         return BankRP(code:code!
             , name:name!

         )
     }
}
