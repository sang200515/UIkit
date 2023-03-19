//
//  User.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/25/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class User: NSObject {
    let AvatarImageLink: String
    let CashAccount: String
    let CompanyCode: String
    let CompanyCodeB1: String
    let CompanyName: String
    let EmployeeName: String
    let Id: Int
    let JobTitle: String
    var ShopCode: String
    var ShopName: String
    let UserName: String
    let LoginTime: Float
    let p_messages: String
    let p_status: Int
    let type_shop: Int
    let Address: String
    var Token:String
    var is_popup:String
    var multi_shop:Int
    var Email:String
    var JobTitleName: String
    var phonenumber: String
    var shopOfficeUservice: String
    
    init(avatarImageLink: String, cashAccount: String, companyCode: String, companyCodeB1: String,
         companyName: String, employeeName: String, iD: Int, JobTitle: String, shopCode: String, shopName: String, userName: String,loginTime: Float,p_messages: String,p_status: Int,type_shop: Int,Address: String,Token:String,is_popup:String,multi_shop:Int, Email: String, JobTitleName: String, phonenumber: String, shop_office_uservice: String){
        self.AvatarImageLink = avatarImageLink
        self.CashAccount = cashAccount
        self.CompanyCode = companyCode
        self.CompanyCodeB1 = companyCodeB1
        self.CompanyName = companyName
        self.EmployeeName = employeeName
        self.Id = iD
        self.JobTitle = JobTitle
        self.ShopCode = shopCode
        self.ShopName = shopName
        self.UserName = userName
        self.LoginTime = loginTime
        
        self.p_messages = p_messages
        self.p_status = p_status
        self.type_shop = type_shop
        self.Address = Address
        self.Token = Token
        self.is_popup = is_popup
        self.multi_shop = multi_shop
        self.Email = Email
        self.JobTitleName = JobTitleName
        self.phonenumber = phonenumber
        self.shopOfficeUservice = shop_office_uservice
    }
    class func getObjFromDictionary(data:JSON) -> User{
        
        var avatarImageLink = data["AvatarImageLink"].string
        var cashAccount = data["CashAccount"].string
        var companyCode = data["CompanyCode"].string
        var companyCodeB1 = data["CompanyCodeB1"].string
        var companyName = data["CompanyName"].string
        var employeeName = data["EmployeeName"].string
        var id = data["ID"].int
        var jobTitle = data["JobTitle"].string
        var loginTime = data["LoginTime"].float
        var shopCode = data["ShopCode"].string
        var shopName = data["ShopName"].string
        var userName = data["UserName"].string
        var p_messages = data["p_messages"].string
        var p_status = data["p_status"].int
        var type_shop = data["type_shop"].int
        var address = data["Address"].string
        var token = data["Token"].string
        var is_popup = data["is_popup"].string
        var multi_shop = data["multi_shop"].int
        var Email = data["Email"].string
        var JobTitleName = data["JobTitleName"].string
        var phonenumber = data["phonenumber"].string
        var shopOfficeUservice = data["shop_office_uservice"].string
        
        avatarImageLink = avatarImageLink == nil ? "" : avatarImageLink
        cashAccount = cashAccount == nil ? "" : cashAccount
        companyCode = companyCode == nil ? "" : companyCode
        companyCodeB1 = companyCodeB1 == nil ? "" : companyCodeB1
        companyName = companyName == nil ? "" : companyName
        employeeName = employeeName == nil ? "" : employeeName
        id = id == nil ? 0 : id
        jobTitle = jobTitle == nil ? "" : jobTitle
        loginTime = loginTime == nil ? 0 : loginTime
        shopCode = shopCode == nil ? "" : shopCode
        shopName = shopName == nil ? "" : shopName
        userName = userName == nil ? "" : userName
        
        p_messages = p_messages == nil ? "" : p_messages
        p_status = p_status == nil ? 0 : p_status
        type_shop = type_shop == nil ? 0 : type_shop
        is_popup = is_popup == nil ? "" : is_popup
        multi_shop = multi_shop == nil ? 0 : multi_shop
        
        //        type_shop = 3
        
        address = address == nil ? "" : address
        token = token == nil ? "" : token
        Email = Email == nil ? "" : Email
        JobTitleName = JobTitleName == nil ? "" : JobTitleName
        phonenumber = phonenumber == nil ? "" : phonenumber
        shopOfficeUservice = shopOfficeUservice == nil ? "" : shopOfficeUservice
        
        return User(avatarImageLink: avatarImageLink!, cashAccount: cashAccount!, companyCode: companyCode!, companyCodeB1: companyCodeB1!,
                    companyName: companyName!, employeeName: employeeName!, iD: id!, JobTitle: jobTitle!, shopCode: shopCode!, shopName: shopName!, userName: userName!,loginTime: loginTime!,p_messages:p_messages!,p_status:p_status!,type_shop:type_shop!,Address:address!,Token:token!,is_popup:is_popup!,multi_shop:multi_shop!, Email:Email!, JobTitleName: JobTitleName!, phonenumber: phonenumber!, shop_office_uservice: shopOfficeUservice!)
    }
    
}
class UserInfoAD: NSObject{

    var email:String
    var name:String
    var sub:String
    var inside_id:String
    var warehouse:String
    var full_name:String
    var phone_number:String
    var title:String
    var pictureInfo:String
    var employee_code:String
    
    init(email:String
    , name:String
    , sub:String
    , inside_id:String
    , warehouse:String
    , full_name:String
    , phone_number:String
    , title:String
    , pictureInfo:String
    , employee_code:String){
        self.email = email
        self.name = name
        self.sub = sub
        self.inside_id = inside_id
        self.warehouse = warehouse
        self.full_name = full_name
        self.phone_number = phone_number
        self.title = title
        self.pictureInfo = pictureInfo
        self.employee_code = employee_code
    }
    
    class func getObjFromDictionary(data:JSON) -> UserInfoAD{
        
        var email = data["email"].string
        var name = data["name"].string
        var sub = data["sub"].string
        var inside_id = data["inside_id"].string
        var warehouse = data["warehouse"].string
        var full_name = data["full_name"].string
        var phone_number = data["phone_number"].string
        var title = data["title"].string
        var pictureInfo = data["picture"].string
        var employee_code = data["employee_code"].string
       
        
        email = email == nil ? "" : email
        name = name == nil ? "" : name
        sub = sub == nil ? "" : sub
        inside_id = inside_id == nil ? "" : inside_id
        warehouse = warehouse == nil ? "" : warehouse
        full_name = full_name == nil ? "" : full_name
        phone_number = phone_number == nil ? "" : phone_number
        title = title == nil ? "" : title
        pictureInfo = pictureInfo == nil ? "" : pictureInfo
        employee_code = employee_code == nil ? "" : employee_code
  
        
        return UserInfoAD(email: email!, name: name!,sub:sub!,inside_id: inside_id!, warehouse: warehouse!, full_name: full_name!, phone_number: phone_number!, title: title!, pictureInfo: pictureInfo!, employee_code: employee_code!)
    }
    
    
}

