//
//  InfoCustomerByImageIDCardSau.swift
//  fptshop
//
//  Created by Ngo Dang tan on 11/19/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"issue_loc" : "D067",
//   "issue_date" : "03\/04\/2014",
//   "ethnicity" : "KINH",
//   "religion" : "KHÔNG"
import Foundation
import SwiftyJSON
class InfoCustomerByImageIDCardSau: NSObject {
    var issue_loc:String
    var issue_date:String
    var ethnicity:String
    var religion:String
    
    init(  issue_loc:String
        , issue_date:String
        , ethnicity:String
        , religion:String){
        self.issue_loc = issue_loc
        self.issue_date = issue_date
        self.ethnicity = ethnicity
        self.religion = religion
    }
    
    
    class func parseObjfromArray(array:[JSON])->[InfoCustomerByImageIDCardSau]{
        var list:[InfoCustomerByImageIDCardSau] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> InfoCustomerByImageIDCardSau{
        var issue_loc = data["issue_loc"].string
        var issue_date = data["issue_date"].string
        var ethnicity = data["ethnicity"].string
        var religion = data["religion"].string
        
        
        issue_loc = issue_loc == nil ? "" : issue_loc
        issue_date = issue_date == nil ? "" : issue_date
        ethnicity = ethnicity == nil ? "" : ethnicity
        religion = religion == nil ? "" : religion
        
        return InfoCustomerByImageIDCardSau(
            issue_loc:issue_loc!
            , issue_date:issue_date!
            ,ethnicity:ethnicity!
            ,religion:religion!
        )
    }
    
}
