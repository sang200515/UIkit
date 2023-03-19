//
//  MapperData.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 13/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

struct MapperData {
    static func mapObject<T: Mappable>(_ successHandler: @escaping SuccessHandler<T>.object) -> NetworkSuccess {
        return { baseResponse in
            let res = Mapper<T>().map(JSONObject: baseResponse)
            successHandler(res)
        }
    }

    static func mapArray<T: Mappable>(_ successHandler: @escaping SuccessHandler<T>.array) -> NetworkSuccess {
        return { baseResponse in
            let obj = Mapper<T>().mapArray(JSONObject: baseResponse)
            if let _obj = obj {
                successHandler(_obj)
            } else {
                successHandler([])
            }
        }
    }
}
