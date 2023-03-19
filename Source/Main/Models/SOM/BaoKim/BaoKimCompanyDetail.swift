//
//  BaoKimCompanyDetail.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 19/01/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class BaoKimCompanyDetail: Mappable {
    var data: [BaoKimCompanyDetailData] = []
    var responseCode: Int = 0
    var responseMessage: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.data <- map["Data"]
        self.responseCode <- map["ResponseCode"]
        self.responseMessage <- map["ResponseMessage"]
    }
}

class BaoKimCompanyDetailData: Mappable {
    var caption: BaoKimCompanyDetailCaption = BaoKimCompanyDetailCaption(JSON: [:])!
    var title: BaoKimCompanyDetailCaption = BaoKimCompanyDetailCaption(JSON: [:])!
    var files: BaoKimFiles = BaoKimFiles(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.caption <- map["Caption"]
        self.title <- map["Title"]
        self.files <- map["Files"]
    }
}

class BaoKimCompanyDetailCaption: Mappable {
    var vi: String = ""
    var en: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.vi <- map["Vi"]
        self.en <- map["En"]
    }
}
