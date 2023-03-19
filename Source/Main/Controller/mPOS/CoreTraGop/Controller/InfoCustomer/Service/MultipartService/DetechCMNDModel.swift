//
//  DetechCMNDModel.swift
//  QuickCode
//
//  Created by Sang Trương on 18/07/2022.
//
import UIKit
import ObjectMapper
import SwiftyJSON

struct DetechCMNDModel:Codable  {
    var idCard : String?
    var idCardType : Int?
    var birthDate : String?
    var proviceName : String?
    var wardName : String?
    var firstName : String?
    var middleName : String?
    var lastName : String?
    var street : String?
    var wardCode : String?
    var idCardIssuedDate : String?
    var districtName : String?
    var proviceCode : String?
    var idCardIssuedExpiration : String?
    var idCardIssuedBy : String?
    var districtCode : String?
    var idCardIssuedByCode : String?
    var uploadFiles : [UploadFiles]?
    var error : Error1?
    var fullName:String!{
        return "\(lastName ?? "") " + "\(middleName ?? "") " + "\(firstName ?? "")"
    }


}
struct UploadFiles : Codable {

    let fileType : String?
    let fileName : String?
    let urlImage : String?



}
