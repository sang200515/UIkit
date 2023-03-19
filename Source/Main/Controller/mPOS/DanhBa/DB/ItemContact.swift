//
//  ItemContact.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 1/4/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"Email": "Huunp2@fpt.com.vn",
//"EmployeeName": "Nguyễn Phúc Hữu",
//"IPPhone": "87937",
//"IsShift": "Không trong ca",
//"JobtitleName": "Trưởng quản lý cửa hàng",
//"NoteContact": "",
//"OrganizationHierachyName": "Chuỗi FPT Shop",
//"Phone": "0922383113",
//"Tinh": "Hồ Chí Minh",
//"WarehouseName": "HCM 305 Tô Hiến Thành"

import RealmSwift
import SwiftyJSON
class ItemContact: Object {
    @objc dynamic var Tinh = ""
    @objc dynamic var WarehouseName = ""
    @objc dynamic var NoteContact = ""
    @objc dynamic var OrganizationHierachyName = ""
    @objc dynamic var Phone = ""
    @objc dynamic var Email = ""
    @objc dynamic var IPPhone = ""
    @objc dynamic var EmployeeName = ""
    @objc dynamic var JobtitleName = ""

    @objc dynamic var EmployeeNameSearch = ""
    @objc dynamic var WarehouseNameSearch = ""
    @objc dynamic var EmailSearch = ""
    @objc dynamic var OrganizationHierachyNameSearch = ""
    
    @objc dynamic var IsShift = ""
    
    class func parseObjfromArray(array:[JSON])->[ItemContact]{
        var list:[ItemContact] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ItemContact{
        
        var Tinh = data["Tinh"].string
        var WarehouseName = data["WarehouseName"].string
        var NoteContact = data["NoteContact"].string
        var OrganizationHierachyName = data["OrganizationHierachyName"].string
        var Phone = data["Phone"].string
        var Email = data["Email"].string
        var IPPhone = data["IPPhone"].string
        var EmployeeName = data["EmployeeName"].string
        var JobtitleName = data["JobtitleName"].string
        var IsShift = data["IsShift"].string
        
        Tinh = Tinh == nil ? "" : Tinh
        WarehouseName = WarehouseName == nil ? "" : WarehouseName
        NoteContact = NoteContact == nil ? "" : NoteContact
        OrganizationHierachyName = OrganizationHierachyName == nil ? "" : OrganizationHierachyName
        Phone = Phone == nil ? "" : Phone
        Email = Email == nil ? "" : Email
        IPPhone = IPPhone == nil ? "" : IPPhone
        EmployeeName = EmployeeName == nil ? "" : EmployeeName
        JobtitleName = JobtitleName == nil ? "" : JobtitleName
        IsShift = IsShift == nil ? "" : IsShift
        
        let EmployeeNameSearch = (EmployeeName ?? "").folding(options: .diacriticInsensitive, locale: nil)
        let WarehouseNameSearch = (WarehouseName ?? "").folding(options: .diacriticInsensitive, locale: nil)
        let OrganizationHierachyNameSearch = (OrganizationHierachyName ?? "").folding(options: .diacriticInsensitive, locale: nil)

        let item = ItemContact()
        item.Tinh = Tinh ?? ""
        item.WarehouseName = WarehouseName ?? ""
        item.NoteContact = NoteContact ?? ""
        item.OrganizationHierachyName = OrganizationHierachyName ?? ""
        item.Phone = Phone ?? ""
        item.Email = Email ?? ""
        item.IPPhone = IPPhone ?? ""
        item.EmployeeName = EmployeeName ?? ""
        item.JobtitleName = JobtitleName ?? ""
        item.EmployeeNameSearch = EmployeeNameSearch.uppercased()
        item.WarehouseNameSearch = WarehouseNameSearch.uppercased()
        item.EmailSearch = (Email ?? "").uppercased()
        item.OrganizationHierachyNameSearch = OrganizationHierachyNameSearch.uppercased()
        item.IsShift = IsShift ?? ""
        return item
    }
}
