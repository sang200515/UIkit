//
//  CheckListSmEnpoint.swift
//  fptshop
//
//  Created by Ngoc Bao on 16/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftUI

enum CheckListSMEnPoint {
    case getData
    case confirm(id: Int)
}

extension CheckListSMEnPoint: EndPointType {
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getData:
            return .get
        default:
            return .post
        }
    }

    var path: String {
        let BASE_URL = Config.manager.URL_GATEWAY!
            
        switch self {
        case .getData:
            return BASE_URL + "/mpos-cloud-api/api/Notification/sp_mpos_oneapp_getTemplate_ChecklistSM"
        case .confirm:
            return BASE_URL + "/mpos-cloud-api/api/Notification/sp_mpos_oneapp_PushlogChecklistSM"
        }
    }
    
    var parameters: JSONDictionary {
        
        switch self {
        case .getData:
            return [
                "Usercode": Cache.user!.UserName
            ]
        case .confirm(let id):
            return [
                "Usercode": Cache.user!.UserName,
                "Id_Template": id,
                "Status": 1
            ]
        }
    }
}
