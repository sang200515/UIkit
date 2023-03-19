//
//  SimHistoryItem.swift
//  fptshop
//
//  Created by Apple on 4/24/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"SoMPos": 1014,
//"Phonenumber": "0987687939",
//"FullName": "Trần Thị Kim Phương",
//"CMND": "023060975",
//"LoaiSim": "SIM thu?ng",
//"is_trasau": "N",
//"Provider": "Viettel",
//"NgayThaySim": "13:50 24/04/2019"
//"SeriSim_New": "8984048000062658583"

import UIKit
import SwiftyJSON

class SimHistoryItem: NSObject {

    let SoMPos: Int
    let Phonenumber: String
    let FullName: String
    let CMND: String
    let LoaiSim: String
    let is_trasau: String
    let Provider: String
    let NgayThaySim: String
    let SeriSim_New: String
    let TenShop: String
    let Doctotal: Int
    
    init(SoMPos: Int, Phonenumber: String, FullName: String, CMND: String, LoaiSim: String, is_trasau: String, Provider: String, NgayThaySim: String, SeriSim_New: String,TenShop: String,Doctotal:Int) {
        
        self.SoMPos = SoMPos
        self.Phonenumber = Phonenumber
        self.FullName = FullName
        self.CMND = CMND
        self.LoaiSim = LoaiSim
        self.is_trasau = is_trasau
        self.Provider = Provider
        self.NgayThaySim = NgayThaySim
        self.SeriSim_New = SeriSim_New
        self.TenShop = TenShop
        self.Doctotal = Doctotal
    }
    
    class func parseObjfromArray(array:[JSON])->[SimHistoryItem]{
        var list:[SimHistoryItem] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> SimHistoryItem{
        var SoMPos = data["SoMPos"].int
        var Phonenumber = data["Phonenumber"].string
        var FullName = data["FullName"].string
        var CMND = data["CMND"].string
        var LoaiSim = data["LoaiSim"].string
        var is_trasau = data["is_trasau"].string
        var Provider = data["Provider"].string
        var NgayThaySim = data["NgayThaySim"].string
        var SeriSim_New = data["SeriSim_New"].string
        let TenShop = data["TenShop"].stringValue
        let Doctotal = data["Doctotal"].intValue
        
        SoMPos = SoMPos == nil ? 0 : SoMPos
        Phonenumber = Phonenumber == nil ? "" : Phonenumber
        FullName = FullName == nil ? "" : FullName
        CMND = CMND == nil ? "" : CMND
        LoaiSim = LoaiSim == nil ? "" : LoaiSim
        is_trasau = is_trasau == nil ? "" : is_trasau
        Provider = Provider == nil ? "" : Provider
        NgayThaySim = NgayThaySim == nil ? "" : NgayThaySim
        SeriSim_New = SeriSim_New == nil ? "" : SeriSim_New
        
        return SimHistoryItem(SoMPos: SoMPos!, Phonenumber: Phonenumber!, FullName: FullName!, CMND: CMND!, LoaiSim: LoaiSim!, is_trasau: is_trasau!, Provider: Provider!, NgayThaySim: NgayThaySim!, SeriSim_New: SeriSim_New!,TenShop: TenShop,Doctotal: Doctotal)
    }
}
