//
//  BillLoadDiaChiNhan.swift
//  fptshop
//
//  Created by Apple on 5/6/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"Address": "1111",
//"HoTenNguoiNhan": null,
//"Id": 1,
//"MaHuyen": 1,
//"MaTinh": 1,
//"OrganizationHierachyCode": "0001",
//"OrganizationHierachyCodeSend": "90001",
//"OrganizationHierachyName": "FRT (HR su dung)",
//"SoDienThoaiNguoiNhan": "",
//"TenHuyen": "Thành phố Long Xuyên",
//"TenTinh": "An Giang",
//"TypeAddress": 1

import Foundation
import SwiftyJSON

//class BillLoadDiaChiNhan: Jsonable {
//
//    required init(json: JSON) {
//        Address = json["Address"].string ?? "";
//        HoTenNguoiNhan = json["HoTenNguoiNhan"].string ?? "";
//        Id = json["Id"].int ?? 0;
//        MaHuyen = json["MaHuyen"].int ?? 0;
//        MaTinh = json["MaTinh"].int ?? 0;
//        OrganizationHierachyCode = json["OrganizationHierachyCode"].string ?? "";
//        OrganizationHierachyCodeSend = json["OrganizationHierachyCodeSend"].string ?? "";
//        OrganizationHierachyName = json["OrganizationHierachyName"].string ?? "";
//        SoDienThoaiNguoiNhan = json["SoDienThoaiNguoiNhan"].string ?? "";
//        TenHuyen = json["TenHuyen"].string ?? "";
//        TenTinh = json["TenTinh"].string ?? "";
//        TypeAddress = json["TypeAddress"].int ?? 0;
//    }
//
//    var Address: String?
//    var HoTenNguoiNhan: String?
//    var Id: Int?
//    var MaHuyen: Int?
//    var MaTinh: Int?
//    var OrganizationHierachyCode: String?
//    var OrganizationHierachyCodeSend: String?
//    var OrganizationHierachyName: String?
//    var SoDienThoaiNguoiNhan: String?
//    var TenHuyen: String?
//    var TenTinh: String?
//    var TypeAddress: Int?
//}


class BillLoadDiaChiNhan: NSObject {
    
    var Address: String
    var HoTenNguoiNhan: String
    var Id: Int
    var MaHuyen: Int
    var MaTinh: Int
    var OrganizationHierachyCode: String
    var OrganizationHierachyCodeSend: String
    var OrganizationHierachyName: String
    var SoDienThoaiNguoiNhan: String
    var TenHuyen: String
    var TenTinh: String
    var TypeAddress: Int
    
    init(Address: String, HoTenNguoiNhan: String, Id: Int, MaHuyen: Int, MaTinh: Int, OrganizationHierachyCode: String, OrganizationHierachyCodeSend: String, OrganizationHierachyName: String, SoDienThoaiNguoiNhan: String, TenHuyen: String, TenTinh: String, TypeAddress: Int) {
        
        self.Address = Address
        self.HoTenNguoiNhan = HoTenNguoiNhan
        self.Id = Id
        self.MaHuyen = MaHuyen
        self.MaTinh = MaTinh
        self.OrganizationHierachyCode = OrganizationHierachyCode
        self.OrganizationHierachyCodeSend = OrganizationHierachyCodeSend
        self.OrganizationHierachyName = OrganizationHierachyName
        self.SoDienThoaiNguoiNhan = SoDienThoaiNguoiNhan
        self.TenHuyen = TenHuyen
        self.TenTinh = TenTinh
        self.TypeAddress = TypeAddress
    }
    
    class func parseObjfromArray(array:[JSON])->[BillLoadDiaChiNhan]{
        var list:[BillLoadDiaChiNhan] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> BillLoadDiaChiNhan{
        var Address = data["Address"].string
        var HoTenNguoiNhan = data["HoTenNguoiNhan"].string
        var Id = data["Id"].int
        var MaHuyen = data["MaHuyen"].int
        var MaTinh = data["MaTinh"].int
        var OrganizationHierachyCode = data["OrganizationHierachyCode"].string
        var OrganizationHierachyCodeSend = data["OrganizationHierachyCodeSend"].string
        var OrganizationHierachyName = data["OrganizationHierachyName"].string
        var SoDienThoaiNguoiNhan = data["SoDienThoaiNguoiNhan"].string
        var TenHuyen = data["TenHuyen"].string
        var TenTinh = data["TenTinh"].string
        var TypeAddress = data["TypeAddress"].int
        
        Address = Address == nil ? "" : Address
        HoTenNguoiNhan = HoTenNguoiNhan == nil ? "" : HoTenNguoiNhan
        Id = Id == nil ? 0 : Id
        MaHuyen = MaHuyen == nil ? 0 : MaHuyen
        MaTinh = MaTinh == nil ? 0 : MaTinh
        OrganizationHierachyCode = OrganizationHierachyCode == nil ? "" : OrganizationHierachyCode
        OrganizationHierachyCodeSend = OrganizationHierachyCodeSend == nil ? "" : OrganizationHierachyCodeSend
        OrganizationHierachyName = OrganizationHierachyName == nil ? "" : OrganizationHierachyName
        SoDienThoaiNguoiNhan = SoDienThoaiNguoiNhan == nil ? "" : SoDienThoaiNguoiNhan
        TenHuyen = TenHuyen == nil ? "" : TenHuyen
        TenTinh = TenTinh == nil ? "" : TenTinh
        TypeAddress = TypeAddress == nil ? 1 : TypeAddress
        
        
        return BillLoadDiaChiNhan(Address: Address!, HoTenNguoiNhan: HoTenNguoiNhan!, Id: Id!, MaHuyen: MaHuyen!, MaTinh: MaTinh!, OrganizationHierachyCode: OrganizationHierachyCode!, OrganizationHierachyCodeSend: OrganizationHierachyCodeSend!, OrganizationHierachyName: OrganizationHierachyName!, SoDienThoaiNguoiNhan: SoDienThoaiNguoiNhan!, TenHuyen: TenHuyen!, TenTinh: TenTinh!, TypeAddress: TypeAddress!)
    }
}
