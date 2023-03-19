//
//  SubsidyOrder.swift
//  mPOS
//
//  Created by MinhDH on 1/6/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class SubsidyOrder: NSObject {
    
    var LoaiDonHang: String
    var CardName: String
    var LicTradNum: String
    var CreateDate: String
    var SDTSubsidy: String
    var Provider: String
    var SOMPOS: Int
    var SO_POS: Int
    var TTDH: String
    var GoiCuoc: String
    var NameShop: String
    var DiaChi:String
    
    init(LoaiDonHang: String, CardName: String, LicTradNum: String, CreateDate: String, SDTSubsidy: String, Provider: String, SOMPOS: Int, SO_POS: Int, TTDH: String, GoiCuoc: String, NameShop: String,DiaChi:String){
        self.LoaiDonHang = LoaiDonHang
        self.CardName = CardName
        self.LicTradNum = LicTradNum
        self.CreateDate = CreateDate
        self.SDTSubsidy = SDTSubsidy
        self.Provider = Provider
        self.SOMPOS = SOMPOS
        self.SO_POS = SO_POS
        self.TTDH = TTDH
        self.GoiCuoc = GoiCuoc
        self.NameShop = NameShop
        self.DiaChi = DiaChi
    }

    
    
    class func parseObjfromArray(array:[JSON])->[SubsidyOrder]{
        var list:[SubsidyOrder] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    
    class func getObjFromDictionary(data:JSON) -> SubsidyOrder{
        
        var loaiDonHang = data["LoaiDonHang"].string
        var cardName = data["CardName"].string
        var licTradNum = data["LicTradNum"].string
        var createDate = data["CreateDate"].string
        var sdtSubsidy = data["SDTSubsidy"].string
        var provider = data["Provider"].string
        var soMPOS = data["SOMPOS"].int
        var so_POS = data["SO_POS"].int
        var ttdh = data["TTDH"].string
        var goiCuoc = data["GoiCuoc"].string
        var nameShop = data["NameShop"].string
        var diaChi = data["DiaChi"].string
        
        loaiDonHang = loaiDonHang == nil ? "" : loaiDonHang
        cardName = cardName == nil ? "" : cardName
        licTradNum = licTradNum == nil ? "" : licTradNum
        createDate = createDate == nil ? "" : createDate
        sdtSubsidy = sdtSubsidy == nil ? "" : sdtSubsidy
        provider = provider == nil ? "" : provider
        soMPOS = soMPOS == nil ? 0 : soMPOS
        so_POS = so_POS == nil ? 0 : so_POS
        ttdh = ttdh == nil ? "" : ttdh
        goiCuoc = goiCuoc == nil ? "" : goiCuoc
        nameShop = nameShop == nil ? "" : nameShop
        diaChi = diaChi == nil ? "" : diaChi
        
        return SubsidyOrder(LoaiDonHang: loaiDonHang!, CardName: cardName!, LicTradNum: licTradNum!, CreateDate: createDate!, SDTSubsidy: sdtSubsidy!, Provider: provider!, SOMPOS: soMPOS!, SO_POS: so_POS!, TTDH: ttdh!, GoiCuoc: goiCuoc!, NameShop: nameShop!,DiaChi:diaChi!)
    }
    
}
