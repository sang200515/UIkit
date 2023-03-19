//
//  CMSNHistory.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 08/03/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class CMSNResponse: Mappable {
    var success: Bool = false
    var message: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.success <- map["success"]
        self.message <- map["message"]
    }
}

class CMSNHistory: Mappable {
    var success: Bool = false
    var message: String = ""
    var data: [CMSNHistoryData] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.success <- map["Success"]
        self.message <- map["Message"]
        self.data <- map["Data"]
    }
}

class CMSNHistoryData: Mappable {
    var id: Int = 0
    var fullname: String = ""
    var phoneNumber: String = ""
    var birthday: String = ""
    var idCard: String = ""
    var updatedBy: String = ""
    var updatedDate: String = ""
    var status: String = ""
    var statusColor: String = ""
    var sftpFileURL: String = ""
    var cancelPopupContent: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.fullname <- map["fullname"]
        self.phoneNumber <- map["phoneNumber"]
        self.birthday <- map["birthday"]
        self.idCard <- map["idCard"]
        self.updatedBy <- map["updatedBy"]
        self.updatedDate <- map["updatedDate"]
        self.status <- map["status"]
        self.statusColor <- map["statusColor"]
        self.sftpFileURL <- map["sftpFileUrl"]
        self.cancelPopupContent <- map["cancelPopupContent"]
    }
}
