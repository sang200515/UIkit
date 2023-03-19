//
//  pgInfo.swift
//  CheckIn
//
//  Created by Apple on 1/19/19.
//  Copyright © 2019 Apple. All rights reserved.
//

///"loaiPG": "PG Mobile",
//"doiTac": "Oppo",
//"chucDanh": "PG hãng",
//"pgCode": "PG0136210108161530",
//"fullName": "ĐÌNH VĂN AN",
//"tenQL": "",
//"personalID": "013620959",
//"gioiTinh": null,
//"soDT": null,
//"email": "khanhmax248@gmail.com",
//"ngaysinh": "0001-01-01T00:00:00",
//"shop": null,
//"trangThai": "Chưa check in"

import UIKit
import SwiftyJSON

class PGInfo: NSObject {
    let loaiPG: String
    let doiTac: String
    let chucDanh: String
    let pgCode: String
    let fullName: String
    let tenQL: String
    let personalID: String
    let gioiTinh: String
    let soDT: String
    let email: String
    let ngaysinh: String
    let shop: String
    let trangThai: String
    
    init(loaiPG: String, doiTac: String, chucDanh: String, pgCode: String, fullName: String, tenQL: String, personalID: String, gioiTinh: String, soDT: String, email: String, ngaysinh: String, shop: String, trangThai: String) {
        self.loaiPG = loaiPG
        self.doiTac = doiTac
        self.chucDanh = chucDanh
        self.pgCode = pgCode
        self.fullName = fullName
        self.tenQL = tenQL
        self.personalID = personalID
        self.gioiTinh = gioiTinh
        self.soDT = soDT
        self.email = email
        self.ngaysinh = ngaysinh
        self.shop = shop
        self.trangThai = trangThai
    }
    
    class func parseObjfromArray(array:[JSON])->[PGInfo]{
        var list:[PGInfo] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> PGInfo{
        let loaiPG = data["loaiPG"].stringValue
        let doiTac = data["doiTac"].stringValue
        let chucDanh = data["chucDanh"].stringValue
        let pgCode = data["pgCode"].stringValue
        let fullName = data["fullName"].stringValue
        let tenQL = data["tenQL"].stringValue
        let personalID = data["personalID"].stringValue
        let gioiTinh = data["gioiTinh"].stringValue
        let soDT = data["soDT"].stringValue
        let email = data["email"].stringValue
        let ngaysinh = data["ngaysinh"].stringValue
        let shop = data["shop"].stringValue
        let trangThai = data["trangThai"].stringValue
        
        return PGInfo(loaiPG: loaiPG, doiTac: doiTac, chucDanh: chucDanh, pgCode: pgCode, fullName: fullName, tenQL: tenQL, personalID: personalID, gioiTinh: gioiTinh, soDT: soDT, email: email, ngaysinh: ngaysinh, shop: shop, trangThai: trangThai)
    }
}
