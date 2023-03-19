//
//  ChiTietLoi_227.swift
//  fptshop
//
//  Created by DiemMy Le on 4/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"ChiTietLoi": "Ho so nay tao lao qua, up anh gi ma toan anh Ngoc Trinh khong la sao",
//"NgayGhiNhanLoi": "21/04/2020",
//"STT": 1

import UIKit
import SwiftyJSON

class ChiTietLoi_227: NSObject {

    let ChiTietLoi: String
    let NgayGhiNhanLoi: String
    let STT: Int
    
    init(ChiTietLoi: String, NgayGhiNhanLoi: String, STT:Int) {
        self.ChiTietLoi = ChiTietLoi
        self.NgayGhiNhanLoi = NgayGhiNhanLoi
        self.STT = STT
    }
    
    class func parseObjfromArray(array:[JSON])->[ChiTietLoi_227]{
        var list:[ChiTietLoi_227] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ChiTietLoi_227 {
        var ChiTietLoi = data["ChiTietLoi"].string
        var NgayGhiNhanLoi = data["NgayGhiNhanLoi"].string
        var STT = data["STT"].int
        
        ChiTietLoi = ChiTietLoi == nil ? "" : ChiTietLoi
        NgayGhiNhanLoi = NgayGhiNhanLoi == nil ? "" : NgayGhiNhanLoi
        STT = STT == nil ? 0 : STT
        
        return ChiTietLoi_227(ChiTietLoi: ChiTietLoi!, NgayGhiNhanLoi: NgayGhiNhanLoi!, STT: STT!)
    }
}
