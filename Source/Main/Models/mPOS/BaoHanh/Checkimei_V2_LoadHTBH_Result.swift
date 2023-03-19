//
//  Checkimei_V2_LoadHTBH_Result.swift
//  mPOS
//
//  Created by sumi on 1/12/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class Checkimei_V2_LoadHTBH_Result: NSObject {
    
    var DoUuTien: String
    var MaHinhThuc: String
    var TenHinhThuc: String
    
    
    init(Checkimei_V2_LoadHTBH_Result: JSON)
    {
        DoUuTien = Checkimei_V2_LoadHTBH_Result["DoUuTien"].stringValue ;
        MaHinhThuc = Checkimei_V2_LoadHTBH_Result["MaHinhThuc"].stringValue ;
        TenHinhThuc = Checkimei_V2_LoadHTBH_Result["TenHinhThuc"].stringValue ;
        
    }
}
