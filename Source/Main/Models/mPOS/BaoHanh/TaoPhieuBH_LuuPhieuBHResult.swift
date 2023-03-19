//
//  TaoPhieuBH_LuuPhieuBHResult.swift
//  mPOS
//
//  Created by sumi on 1/9/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class TaoPhieuBH_LuuPhieuBHResult: NSObject {
    
    var Result: String
    var SophieuBH: String
    var ThongBaoLoi: String
    var HoanTat: String
    var Log: String
    
    
    
    init(TaoPhieuBH_LuuPhieuBHResult: JSON)
    {
        Result = TaoPhieuBH_LuuPhieuBHResult["Result"].stringValue ;
        SophieuBH = TaoPhieuBH_LuuPhieuBHResult["SophieuBH"].stringValue;
        ThongBaoLoi = TaoPhieuBH_LuuPhieuBHResult["ThongBaoLoi"].stringValue ;
        HoanTat = TaoPhieuBH_LuuPhieuBHResult["HoanTat"].stringValue;
        Log = TaoPhieuBH_LuuPhieuBHResult["Log"].stringValue;
        
    }
    
}
