//
//  GenImage_Confirm_DeliverResult.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/19/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class GenImage_Confirm_DeliverResult2: NSObject {
    var Success : String
    var Url : String
    var Message : String
    
    init(Success : String, Url : String, Message : String) {
        self.Success = Success
        self.Url = Url
        self.Message = Message
    }
    
    class func getObjFromDictionary(data:JSON) -> GenImage_Confirm_DeliverResult2{
        
        var Success = data["Success"].string
        var Url = data["Url"].string
        var  Message = data["Message"].string
        
        Success = Success == nil ? "" : Success
        Url = Url == nil ? "" : Url
        Message = Message == nil ? "" : Message
        
        return GenImage_Confirm_DeliverResult2(Success : Success!, Url : Url!, Message : Message!)
    }
    class func parseObjfromArray(array:[JSON])->[GenImage_Confirm_DeliverResult2]{
        var list:[GenImage_Confirm_DeliverResult2] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
}
