//
//  Contact.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 08/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class Contact: Jsonable{
    required init?(json: JSON) {
        self.Email = json["Email"].string ?? "";
        self.EmployeeName = json["EmployeeName"].string ?? "";
        self.IPPhone = json["IPPhone"].string ?? "";
        self.JobtitleName = json["JobtitleName"].string ?? "";
        self.NoteContact = json["NoteContact"].string ?? "";
        self.OrganizationHierachyName = json["OrganizationHierachyName"].string ?? "";
        self.Phone = json["Phone"].string ?? "";
        self.WarehouseName = json["WarehouseName"].string ?? "";
        self.Tinh = json["Tinh"].string ?? "" ;
//        self.IsShift = json["IsShift"].string ?? "" ;
    }
    
    var Email: String?;
    var EmployeeName: String?;
    var IPPhone: String?;
    var JobtitleName: String?;
    var NoteContact: String?;
    var OrganizationHierachyName: String?;
    var Phone: String?;
    var WarehouseName: String?;
    var Tinh: String?;
//    var IsShift: String?;
    
}
