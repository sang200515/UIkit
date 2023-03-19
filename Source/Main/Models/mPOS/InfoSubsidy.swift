//
//  InfoSubsidy.swift
//  mPOS
//
//  Created by MinhDH on 4/6/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class InfoSubsidy: NSObject {
    
    var listThongTinSubsidy: [ThongTinSubsidy]
    var listLogRequestImei: [LogRequestImei]
    var listThongTinCongNo: [ThongTinCongNo]
    
    init(listThongTinSubsidy: [ThongTinSubsidy], listLogRequestImei: [LogRequestImei], listThongTinCongNo: [ThongTinCongNo]){
        self.listThongTinSubsidy = listThongTinSubsidy
        self.listLogRequestImei = listLogRequestImei
        self.listThongTinCongNo = listThongTinCongNo
    }
    class func parseObjfromArray(array:[JSON])->[InfoSubsidy]{
        var list:[InfoSubsidy] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> InfoSubsidy{
        
        var listThongTinSubsidy: [ThongTinSubsidy]?
        var listLogRequestImei: [LogRequestImei]?
        var listThongTinCongNo: [ThongTinCongNo]?
        
        if let listThongTinSubsidyDic = data["listThongTinSubsidy"].array {
            listThongTinSubsidy  = ThongTinSubsidy.parseObjfromArray(array: listThongTinSubsidyDic)
        }
        if let listLogRequestImeiDic = data["listLogRequestImei"].array{
            listLogRequestImei = LogRequestImei.parseObjfromArray(array: listLogRequestImeiDic)
        }
        if let listThongTinCongNoDic = data["listThongTinCongNo"].array{
            listThongTinCongNo = ThongTinCongNo.parseObjfromArray(array: listThongTinCongNoDic)
        }
          listThongTinSubsidy = listThongTinSubsidy == nil ? [] : listThongTinSubsidy
        listLogRequestImei = listLogRequestImei == nil ? [] : listLogRequestImei
        listThongTinCongNo = listThongTinCongNo == nil ? [] : listThongTinCongNo
        
        
        return InfoSubsidy(listThongTinSubsidy: listThongTinSubsidy!, listLogRequestImei: listLogRequestImei!, listThongTinCongNo: listThongTinCongNo!)
    }
}
