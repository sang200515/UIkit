//
//  BaoHiemHistory.swift
//  fptshop
//
//  Created by Apple on 9/24/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"FullName": "Test hệ thống",
//"Gender": "F",
//"phonenumber": "0396440823",
//"address": "test",
//"Note": "",
//"NgayTao": "24/09/2019",
//"TrangThai": "Tạo hs thành công",
//"NVPG": "",
//"NgayPGconfirm": "24/09/2019"

import UIKit
import SwiftyJSON

class BaoHiemHistory: NSObject {

    let FullName: String
    let Gender: String
    let phonenumber: String
    let address: String
    let Note: String
    let NgayTao: String
    let TrangThai: String
    let NVPG: String
    let NgayPGconfirm: String
    
    init(FullName: String, Gender: String, phonenumber: String, address: String, Note: String, NgayTao: String, TrangThai: String, NVPG: String, NgayPGconfirm: String) {
        self.FullName = FullName
        self.Gender = Gender
        self.phonenumber = phonenumber
        self.address = address
        self.Note = Note
        self.NgayTao = NgayTao
        self.TrangThai = TrangThai
        self.NVPG = NVPG
        self.NgayPGconfirm = NgayPGconfirm
    }
    
    class func parseObjfromArray(array:[JSON])->[BaoHiemHistory]{
        var list:[BaoHiemHistory] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> BaoHiemHistory {
        var FullName = data["FullName"].string
        var Gender = data["Gender"].string
        var phonenumber = data["phonenumber"].string
        var address = data["address"].string
        var Note = data["Note"].string
        var NgayTao = data["NgayTao"].string
        var TrangThai = data["TrangThai"].string
        var NVPG = data["NVPG"].string
        var NgayPGconfirm = data["NgayPGconfirm"].string
        
        FullName = FullName == nil ? "" : FullName
        Gender = Gender == nil ? "" : Gender
        phonenumber = phonenumber == nil ? "" : phonenumber
        address = address == nil ? "" : address
        Note = Note == nil ? "" : Note
        NgayTao = NgayTao == nil ? "" : NgayTao
        TrangThai = TrangThai == nil ? "" : TrangThai
        NVPG = NVPG == nil ? "" : NVPG
        NgayPGconfirm = NgayPGconfirm == nil ? "" : NgayPGconfirm
        
        return BaoHiemHistory(FullName: FullName!, Gender: Gender!, phonenumber: phonenumber!, address: address!, Note: Note!, NgayTao: NgayTao!, TrangThai: TrangThai!, NVPG: NVPG!, NgayPGconfirm: NgayPGconfirm!)
    }
}
