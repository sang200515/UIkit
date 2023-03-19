//
//  ProvinceRightPhone.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/20/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ProvinceRightPhone: NSObject {
    var Value:String
    var Text:String
    
    init(Value:String,Text:String){
        self.Value = Value
        self.Text = Text
    }
    class func parseObjfromArray(array:[JSON])->[ProvinceRightPhone]{
          var list:[ProvinceRightPhone] = []
          for item in array {
              list.append(self.getObjFromDictionary(data: item))
          }
          return list
      }
      
      class func getObjFromDictionary(data:JSON) -> ProvinceRightPhone{
          var Value = data["Value"].string
          var Text = data["Text"].string
      
          
          Value = Value == nil ? "" : Value
          Text = Text == nil ? "" : Text
    
          return ProvinceRightPhone(Value:Value!
          , Text:Text!

          )
      }
    
    
}
