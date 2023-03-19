//
//  LichSuNhapPONCC.swift
//  mPOS
//
//  Created by tan on 8/24/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class GroupNCCHistory: NSObject {
    var nccName:String
    var isExpand:Bool
    var listPO:[LichSuNhapPO]
    
    
    
    init(nccName:String,listPO:[LichSuNhapPO],isExpand:Bool){
        self.nccName = nccName
        self.listPO = listPO
        self.isExpand = isExpand
        
    }
}
