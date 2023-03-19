//
//  InsuranceContactTribiFlight.swift
//  fptshop
//
//  Created by Ngo Dang tan on 1/8/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class InsuranceContactTribiFlight:NSObject{
    var id:Int
    var gender:String
    var firstName:String
    var lastName:String
    var fullName:String
    var email:String
    var dob:String
    var phone1:String
    var passport:String
    var totalPrice:Float
    
    init(id:Int
    , gender:String
    , firstName:String
    , lastName:String
    , fullName:String
    , email:String
    , dob:String
    , phone1:String
    , passport:String
    , totalPrice:Float){
        self.id = id
        self.gender = gender
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = fullName
        self.email = email
        self.dob = dob
        self.phone1 = phone1
        self.passport = passport
        self.totalPrice = totalPrice
    }
    
    class func getObjFromDictionary(data:JSON) -> InsuranceContactTribiFlight{
         
         var id = data["id"].int
         var gender = data["gender"].string
         var firstName = data["firstName"].string
         var lastName = data["lastName"].string
        var fullName = data["fullName"].string
        var email = data["email"].string
        var dob = data["dob"].string
        var phone1 = data["phone1"].string
        var passport = data["passport"].string
        var totalPrice = data["totalPrice"].float
         
         
         id = id == nil ? 0 : id
         gender = gender == nil ? "" : gender
         firstName = firstName == nil ? "" : firstName
         lastName = lastName == nil ? "" : lastName
        fullName = fullName == nil ? "" : fullName
        email = email == nil ? "" : email
        dob = dob == nil ? "" : dob
        phone1 = phone1 == nil ? "" : phone1
        passport = passport == nil ? "" : passport
        totalPrice = totalPrice == nil ? 0 : totalPrice
         return InsuranceContactTribiFlight(id:id!
         , gender:gender!
         , firstName:firstName!
         , lastName:lastName!
         , fullName:fullName!
         , email:email!
         , dob:dob!
         , phone1:phone1!
         , passport:passport!
         , totalPrice:totalPrice!
         )
     }
}
