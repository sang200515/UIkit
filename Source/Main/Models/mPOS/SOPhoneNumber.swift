//
//  SOPhoneNumber.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 3/7/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class SOPhoneNumber: NSObject  {
    
    var headers:[SOPhoneNumberHeader]
    var detailSPs:[SoPhoneNumberDetailSP]
    
    init(headers:[SOPhoneNumberHeader],detailSPs:[SoPhoneNumberDetailSP]){
        self.headers = headers
        self.detailSPs = detailSPs
    }
    class func getObjFromDictionary(data:JSON) -> SOPhoneNumber{
        var headers:[SOPhoneNumberHeader]? = nil
        var detailSPs:[SoPhoneNumberDetailSP]?  = nil
        
        let headerDic = data["Header"].array
        if(headerDic != nil){
            headers = SOPhoneNumberHeader.parseObjfromArray(array: headerDic!)
        }
        let detailsDic = data["Details"].array
        if(detailsDic != nil){
            detailSPs = SoPhoneNumberDetailSP.parseObjfromArray(array: detailsDic!)
        }
        headers = headers == nil ? [] : headers
        detailSPs = detailSPs == nil ? [] : detailSPs
        return SOPhoneNumber(headers:headers!,detailSPs:detailSPs!)
    }
}
