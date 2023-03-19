//
//  ThuHoOutside.swift
//  fptshop
//
//  Created by Apple on 4/3/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"SoMPos": 281032,
//"Ngay": "16:55-03/04/2019",
//"ProviderName": "FE Credit",
//"DocTotal": 200000,
//"NumberContract": "201609266240573663",
//"PhiThuHo": 0,
//"Phonenumber": "0904592677",
//"transcode_crm_insert": 101468

import UIKit
import SwiftyJSON

class ThuHoOutside: NSObject {

    let SoMPos: Int
    let Ngay: String
    let ProviderName: String
    let DocTotal: Int
    let NumberContract: String
    let PhiThuHo: Int
    let MaNhaDichVu: String
    let Phonenumber: String
    let transcode_crm_insert: String
    
    
    init(SoMPos: Int, Ngay: String, ProviderName: String, DocTotal: Int, NumberContract: String, PhiThuHo: Int, MaNhaDichVu: String, Phonenumber: String, transcode_crm_insert: String) {
        
        self.SoMPos = SoMPos
        self.Ngay = Ngay
        self.ProviderName = ProviderName
        self.DocTotal = DocTotal
        self.NumberContract = NumberContract
        self.PhiThuHo = PhiThuHo
        self.MaNhaDichVu = MaNhaDichVu
        self.Phonenumber = Phonenumber
        self.transcode_crm_insert = transcode_crm_insert
    }
    
    class func BuildItemFromJSON(data:JSON) -> ThuHoOutside{
        
        var SoMPos = data["SoMPos"].int
        var Ngay = data["Ngay"].string
        var ProviderName = data["ProviderName"].string
        var DocTotal = data["DocTotal"].int
        var NumberContract = data["NumberContract"].string
        var PhiThuHo = data["PhiThuHo"].int
        var MaNhaDichVu = data["MaNhaDichVu"].string
        var Phonenumber = data["Phonenumber"].string
        var transcode_crm_insert = data["transcode_crm_insert"].string
        
        SoMPos = SoMPos == nil ? 0 : SoMPos
        Ngay = Ngay == nil ? "" : Ngay
        ProviderName = ProviderName == nil ? "" : ProviderName
        DocTotal = DocTotal == nil ? 0 : DocTotal
        NumberContract = NumberContract == nil ? "" : NumberContract
        PhiThuHo = PhiThuHo == nil ? 0 : PhiThuHo
        MaNhaDichVu = MaNhaDichVu == nil ? "" : MaNhaDichVu
        Phonenumber = Phonenumber == nil ? "" : Phonenumber
        transcode_crm_insert = transcode_crm_insert == nil ? "" : transcode_crm_insert
        
        return ThuHoOutside(SoMPos: SoMPos!, Ngay: Ngay!, ProviderName: ProviderName!, DocTotal: DocTotal!, NumberContract: NumberContract!, PhiThuHo: PhiThuHo!, MaNhaDichVu: MaNhaDichVu!, Phonenumber: Phonenumber!, transcode_crm_insert: transcode_crm_insert!)
    }
    
    class func parseObjfromArray(array: [JSON])->[ThuHoOutside]{
        var list:[ThuHoOutside] = []
        for item in array {
            list.append(self.BuildItemFromJSON(data: item))
        }
        return list
    }
}
