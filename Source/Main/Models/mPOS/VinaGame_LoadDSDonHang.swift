//
//  VinaGame_LoadDSDonHang.swift
//  mPOS
//
//  Created by sumi on 9/6/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class VinaGame_LoadDSDonHang: NSObject {
    var CreateBy: String
    var SOMPOS: Int
    var SO_POS: Int
    var NgayTao: String
    var CardName: String
    var U_Imei: String
    
    init(CreateBy: String, SOMPOS: Int, SO_POS: Int, NgayTao: String, CardName: String, U_Imei: String){
        self.CreateBy = CreateBy
        self.SOMPOS = SOMPOS
        self.SO_POS = SO_POS
        self.NgayTao = NgayTao
        self.CardName = CardName
        self.U_Imei = U_Imei
    }
    
    class func parseObjfromArray(array:[JSON])->[VinaGame_LoadDSDonHang]{
        var list:[VinaGame_LoadDSDonHang] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> VinaGame_LoadDSDonHang{
        var CreateBy = data["CreateBy"].string
        var SOMPOS = data["SOMPOS"].int
        var SO_POS = data["SO_POS"].int
        var NgayTao = data["NgayTao"].string
        var CardName = data["CardName"].string
        var U_Imei = data["U_Imei"].string
        
        CreateBy = CreateBy == nil ? "" : CreateBy
        SOMPOS = SOMPOS == nil ? 0 : SOMPOS
        SO_POS = SO_POS == nil ? 0 : SO_POS
        NgayTao = NgayTao == nil ? "" : NgayTao
        CardName = CardName == nil ? "" : CardName
        U_Imei = U_Imei == nil ? "" : U_Imei
        
        return VinaGame_LoadDSDonHang(CreateBy: CreateBy!, SOMPOS: SOMPOS!, SO_POS: SO_POS!, NgayTao: NgayTao!, CardName: CardName!, U_Imei: U_Imei!)
    }
}

