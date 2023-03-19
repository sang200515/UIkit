//
//  GetTechnicalEmpShopKyThuat.swift
//  NewmDelivery
//
//  Created by sumi on 6/29/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetTechnicalEmpShopKyThuat: NSObject {
    
    var employeeCode : String
    var fullName: String
    
    
    init(GetTechnicalEmpShopKyThuat: JSON)
    {
        employeeCode = GetTechnicalEmpShopKyThuat["employeeCode"].stringValue;
        fullName = GetTechnicalEmpShopKyThuat["fullName"].stringValue;
        
        
        
    }
    
    
}
