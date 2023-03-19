//
//  InfoCustomerByImageIDCard.swift
//  mPOS
//
//  Created by MinhDH on 6/13/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class InfoCustomerByImageIDCard: NSObject {
    var FullName: String
    var Birthday: String
    var Gender: Int
    var Address: String
    var DateCreateCMND: String
    var PalaceCreateCMND: String
    var ProvinceCode: String
    var DistrictCode: String
    var PrecinctCode: String
    var CMND:String
    
    var ethnicity:String
    var religion:String
    var issue_date:String
    var issue_loc:String
    var FirstName:String
    var LastName:String
    
    
    init(FullName: String, Birthday: String, Gender: Int, Address: String, DateCreateCMND: String, PalaceCreateCMND: String, ProvinceCode: String, DistrictCode: String, PrecinctCode: String,CMND:String,ethnicity:String
        , religion:String
        , issue_date:String
        , issue_loc:String
        , FirstName:String
        , LastName:String){
        self.FullName = FullName
        self.Birthday = Birthday
        self.Gender = Gender
        self.Address = Address
        self.DateCreateCMND = DateCreateCMND
        self.PalaceCreateCMND = PalaceCreateCMND
        self.ProvinceCode = ProvinceCode
        self.DistrictCode = DistrictCode
        self.PrecinctCode = PrecinctCode
        self.CMND = CMND
        
        self.ethnicity = ethnicity
        self.religion = religion
        self.issue_date = issue_date
        self.issue_loc = issue_loc
        self.FirstName = FirstName
        self.LastName = LastName
    }
    class func parseObjfromArray(array:[JSON])->[InfoCustomerByImageIDCard]{
        var list:[InfoCustomerByImageIDCard] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> InfoCustomerByImageIDCard{
        
        var fullName = data["FullName"].string
        var birthday = data["Birthday"].string
        var gender = data["Gender"].int
        var address = data["Address"].string
        
        var dateCreateCMND = data["DateCreateCMND"].string
        var palaceCreateCMND = data["PalaceCreateCMND"].string
        var provinceCode = data["ProvinceCode"].string
        var districtCode = data["DistrictCode"].string
        var precinctCode = data["PrecinctCode"].string
        var cmnd = data["CMND"].string
        
        var ethnicity = data["ethnicity"].string
        var religion = data["religion"].string
        var issue_date = data["issue_date"].string
        var issue_loc = data["issue_loc"].string
        var FirstName = data["FirstName"].string
        var LastName = data["LastName"].string
        
        fullName = fullName == nil ? "" : fullName
        birthday = birthday == nil ? "" : birthday
        gender = gender == nil ? 0 : gender
        address = address == nil ? "" : address
        
        dateCreateCMND = dateCreateCMND == nil ? "" : dateCreateCMND
        palaceCreateCMND = palaceCreateCMND == nil ? "" : palaceCreateCMND
        provinceCode = provinceCode == nil ? "" : provinceCode
        districtCode = districtCode == nil ? "" : districtCode
        precinctCode = precinctCode == nil ? "" : precinctCode
        cmnd = cmnd == nil ? "" : cmnd
        
        ethnicity = ethnicity == nil ? "" : ethnicity
        religion = religion == nil ? "" : religion
        issue_date = issue_date == nil ? "" : issue_date
        issue_loc = issue_loc == nil ? "" : issue_loc
        FirstName = FirstName == nil ? "" : FirstName
        LastName = LastName == nil ? "" : LastName
        
        return InfoCustomerByImageIDCard(FullName: fullName!, Birthday: birthday!, Gender: gender!, Address: address!, DateCreateCMND: dateCreateCMND!, PalaceCreateCMND: palaceCreateCMND!, ProvinceCode: provinceCode!, DistrictCode: districtCode!, PrecinctCode: precinctCode!,CMND:cmnd!,ethnicity:ethnicity!
            , religion:religion!
            , issue_date:issue_date!
            , issue_loc:issue_loc!
            ,FirstName:FirstName!
            ,LastName:LastName!)
    }
}
