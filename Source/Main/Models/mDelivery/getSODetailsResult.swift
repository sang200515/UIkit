//
//  getSODetailsResult.swift
//  NewmDelivery
//
//  Created by sumi on 4/2/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class getSODetailsResult: NSObject {
    
    var ID : String
    var ORDRID: String
    
    var U_ItmCod : String
    var U_ItmName: String
    var U_Imei : String
    var U_Qutity: String
    
    var U_Price : String
    var U_DisCou: String
    var U_TMoney : String
    
    
    init(getSODetailsResult: JSON)
    {
        ID = getSODetailsResult["ID"].stringValue;
        ORDRID = getSODetailsResult["ORDRID"].stringValue;
        
        U_ItmCod = getSODetailsResult["U_ItmCod"].stringValue;
        U_ItmName = getSODetailsResult["U_ItmName"].stringValue;
        U_Imei = getSODetailsResult["U_Imei"].stringValue;
        U_Qutity = getSODetailsResult["U_Qutity"].stringValue;
        U_Price = getSODetailsResult["U_Price"].stringValue;
        U_DisCou = getSODetailsResult["U_DisCou"].stringValue;
        U_TMoney = getSODetailsResult["U_TMoney"].stringValue;
    }
}
