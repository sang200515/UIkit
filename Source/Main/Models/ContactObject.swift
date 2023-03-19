//
//  ContactObject.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 1/4/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ContactObject: NSObject {
    let Tinh: String
    let WarehouseName: String
    let NoteContact: String
    let OrganizationHierachyName: String
    let Phone: String
    let Email: String
    let IPPhone: String
    let EmployeeName: String
    let JobtitleName: String
    
    init(Tinh: String, WarehouseName: String, NoteContact: String, OrganizationHierachyName: String, Phone: String, Email: String, IPPhone: String, EmployeeName: String, JobtitleName: String){
        self.Tinh = Tinh
        self.WarehouseName = WarehouseName
        self.NoteContact = NoteContact
        self.OrganizationHierachyName = OrganizationHierachyName
        self.Phone = Phone
        self.Email = Email
        self.IPPhone = IPPhone
        self.EmployeeName = EmployeeName
        self.JobtitleName = JobtitleName
    }
    class func getObjFromDictionary(data:JSON) -> ContactObject{
        
        var Tinh = data["Tinh"].string
        var WarehouseName = data["WarehouseName"].string
        var NoteContact = data["NoteContact"].string
        var OrganizationHierachyName = data["OrganizationHierachyName"].string
        var Phone = data["Phone"].string
        var Email = data["Email"].string
        var IPPhone = data["IPPhone"].string
        var EmployeeName = data["EmployeeName"].string
        var JobtitleName = data["JobtitleName"].string
        
        Tinh = Tinh == nil ? "" : Tinh
        WarehouseName = WarehouseName == nil ? "" : WarehouseName
        NoteContact = NoteContact == nil ? "" : NoteContact
        OrganizationHierachyName = OrganizationHierachyName == nil ? "" : OrganizationHierachyName
        Phone = Phone == nil ? "" : Phone
        Email = Email == nil ? "" : Email
        IPPhone = IPPhone == nil ? "" : IPPhone
        EmployeeName = EmployeeName == nil ? "" : EmployeeName
        JobtitleName = JobtitleName == nil ? "" : JobtitleName
        
        
        
        return ContactObject(Tinh: Tinh!, WarehouseName: WarehouseName!, NoteContact: NoteContact!, OrganizationHierachyName: OrganizationHierachyName!, Phone: Phone!, Email: Email!, IPPhone: IPPhone!, EmployeeName: EmployeeName!, JobtitleName: JobtitleName!)
    }
    class func parseObjfromArray(array:[JSON])->[ContactObject]{
        var list:[ContactObject] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
}



