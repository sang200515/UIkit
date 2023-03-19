//
//  CheckListModel.swift
//  fptshop
//
//  Created by Ngoc Bao on 16/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class ListSMModel : Mappable {
    var success : Bool = false
    var data : ListSMItem?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        success <- map["Success"]
        data <- map["Data"]
    }
    
}

class ListSMItem : Mappable {
    var iD : Int = 0
    var template : String = ""
    var buttonName : String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        iD <- map["ID"]
        template <- map["Template"]
        buttonName <- map["ButtonName"]
    }
    
}

//=======
class ComfimSMModel : Mappable {
    var Success : Bool = false
    var data : ComfimSMItem?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        Success <- map["Success"]
        data <- map["Data"]
    }
    
}

class ComfimSMItem : Mappable {
    var Success : Int = 0
    var Mess : String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        Success <- map["Success"]
        Mess <- map["Mess"]
    }
    
}
