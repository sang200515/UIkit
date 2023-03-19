//
//  BillLoadDiaChiGui.swift
//  fptshop
//
//  Created by Apple on 5/6/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"Address": "305 Tô Hiến Thành, phường 13, Quận 10",
//"Id": 68,
//"MaHuyen": 234,
//"MaTinh": 23,
//"OrganizationHierachyCode": "00757",
//"OrganizationHierachyCodeSend": "00757",
//"OrganizationHierachyName": "Nhóm Call Log",
//"SoDienThoaiNguoiGui": "0348164822",
//"TenHuyen": "Quận 10",
//"TenTinh": "Hồ Chí Minh"

import Foundation
import SwiftyJSON

//class BillLoadDiaChiGui: Jsonable {
//
//    required init(json: JSON) {
//        Address = json["Address"].string ?? "";
//        Id = json["Id"].int ?? 0;
//        MaHuyen = json["MaHuyen"].int ?? 0;
//        MaTinh = json["MaTinh"].int ?? 0;
//        OrganizationHierachyCode = json["OrganizationHierachyCode"].string ?? "";
//        OrganizationHierachyCodeSend = json["OrganizationHierachyCodeSend"].string ?? "";
//        OrganizationHierachyName = json["OrganizationHierachyName"].string ?? "";
//        SoDienThoaiNguoiGui = json["SoDienThoaiNguoiGui"].string ?? "";
//        TenHuyen = json["TenHuyen"].string ?? "";
//        TenTinh = json["TenTinh"].string ?? "";
//    }
//
//    init(Address: String, Id: Int, MaHuyen: Int, MaTinh: Int, OrganizationHierachyCode: String, OrganizationHierachyCodeSend: String, OrganizationHierachyName: String, SoDienThoaiNguoiGui: String, TenHuyen: String, TenTinh: String) {
//
//        self.Address = Address
//        self.Id = Id
//        self.MaHuyen = MaHuyen
//        self.MaTinh = MaTinh
//        self.OrganizationHierachyCode = OrganizationHierachyCode
//        self.OrganizationHierachyCodeSend = OrganizationHierachyCodeSend
//        self.OrganizationHierachyName = OrganizationHierachyName
//        self.SoDienThoaiNguoiGui = SoDienThoaiNguoiGui
//        self.TenHuyen = TenHuyen
//        self.TenTinh = TenTinh
//    }
//
//    var Address: String?
//    var Id: Int?
//    var MaHuyen: Int?
//    var MaTinh: Int?
//    var OrganizationHierachyCode: String?
//    var OrganizationHierachyCodeSend: String?
//    var OrganizationHierachyName: String?
//    var SoDienThoaiNguoiGui: String?
//    var TenHuyen: String?
//    var TenTinh: String?
//}

class BillLoadDiaChiGui: NSObject {
    
    var Address: String
    var Id: Int
    var MaHuyen: Int
    var MaTinh: Int
    var OrganizationHierachyCode: String
    var OrganizationHierachyCodeSend: String
    var OrganizationHierachyName: String
    var SoDienThoaiNguoiGui: String
    var TenHuyen: String
    var TenTinh: String
    
    init(Address: String, Id: Int, MaHuyen: Int, MaTinh: Int, OrganizationHierachyCode: String, OrganizationHierachyCodeSend: String, OrganizationHierachyName: String, SoDienThoaiNguoiGui: String, TenHuyen: String, TenTinh: String) {
        
        self.Address = Address
        self.Id = Id
        self.MaHuyen = MaHuyen
        self.MaTinh = MaTinh
        self.OrganizationHierachyCode = OrganizationHierachyCode
        self.OrganizationHierachyCodeSend = OrganizationHierachyCodeSend
        self.OrganizationHierachyName = OrganizationHierachyName
        self.SoDienThoaiNguoiGui = SoDienThoaiNguoiGui
        self.TenHuyen = TenHuyen
        self.TenTinh = TenTinh
    }

    class func parseObjfromArray(array:[JSON])->[BillLoadDiaChiGui]{
        var list:[BillLoadDiaChiGui] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> BillLoadDiaChiGui{
        var Address = data["Address"].string
        var Id = data["Id"].int
        var MaHuyen = data["MaHuyen"].int
        var MaTinh = data["MaTinh"].int
        var OrganizationHierachyCode = data["OrganizationHierachyCode"].string
        var OrganizationHierachyCodeSend = data["OrganizationHierachyCodeSend"].string
        var OrganizationHierachyName = data["OrganizationHierachyName"].string
        var SoDienThoaiNguoiGui = data["SoDienThoaiNguoiGui"].string
        var TenHuyen = data["TenHuyen"].string
        var TenTinh = data["TenTinh"].string
        
        Address = Address == nil ? "" : Address
        Id = Id == nil ? 0 : Id
        MaHuyen = MaHuyen == nil ? 0 : MaHuyen
        MaTinh = MaTinh == nil ? 0 : MaTinh
        OrganizationHierachyCode = OrganizationHierachyCode == nil ? "" : OrganizationHierachyCode
        OrganizationHierachyCodeSend = OrganizationHierachyCodeSend == nil ? "" : OrganizationHierachyCodeSend
        OrganizationHierachyName = OrganizationHierachyName == nil ? "" : OrganizationHierachyName
        SoDienThoaiNguoiGui = SoDienThoaiNguoiGui == nil ? "" : SoDienThoaiNguoiGui
        TenHuyen = TenHuyen == nil ? "" : TenHuyen
        TenTinh = TenTinh == nil ? "" : TenTinh
        
        
        return BillLoadDiaChiGui(Address: Address!, Id: Id!, MaHuyen: MaHuyen!, MaTinh: MaTinh!, OrganizationHierachyCode: OrganizationHierachyCode!, OrganizationHierachyCodeSend: OrganizationHierachyCodeSend!, OrganizationHierachyName: OrganizationHierachyName!, SoDienThoaiNguoiGui: SoDienThoaiNguoiGui!, TenHuyen: TenHuyen!, TenTinh: TenTinh!)
    }
}
