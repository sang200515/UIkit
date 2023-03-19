//
//  ComBoPKResult.swift
//  fptshop
//
//  Created by tan on 3/12/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class ComBoPKResult: NSObject {
    
    var thongtinTV:[ThongTuVanComboPK]
    var sanPhamGoiYs:[SanPhamGoiYComboPK]
    
    init(     thongtinTV:[ThongTuVanComboPK]
    , sanPhamGoiYs:[SanPhamGoiYComboPK]){
        self.thongtinTV = thongtinTV
        self.sanPhamGoiYs = sanPhamGoiYs
    }
}
