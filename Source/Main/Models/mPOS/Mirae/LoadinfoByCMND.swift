//
//  LoadinfoByCMND.swift
//  fptshop
//
//  Created by tan on 5/29/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class LoadinfoByCMND: NSObject {

    var Docentry:Int
    var Gender:String
    var FirstName:String
    var MiddleName:String
    var LastName:String
    var IDCard:String
    var PhoneNumber:String
    var p_status:Int
    var p_messagess:String
    var NgaySinh:String
    var Native:String
    var fptrequest_Front:String
    var fptrequest_Behind:String
    var IdCard:String
    var IssueDate:String
    init(Docentry:Int
    , Gender:String
    , FirstName:String
    , MiddleName:String
    , LastName:String
    , IDCard:String
    , PhoneNumber:String
    , p_status:Int
    , p_messagess:String
        ,NgaySinh:String
        ,Native:String
        ,fptrequest_Front:String
        ,fptrequest_Behind:String
        ,IdCard:String
        ,IssueDate:String){
        self.Docentry = Docentry
        self.Gender = Gender
        self.FirstName = FirstName
        self.MiddleName = MiddleName
        self.LastName = LastName
        self.IDCard = IDCard
        self.PhoneNumber = PhoneNumber
        self.p_status = p_status
        self.p_messagess = p_messagess
        self.NgaySinh = NgaySinh
        self.Native = Native
        self.fptrequest_Front = fptrequest_Front
        self.fptrequest_Behind = fptrequest_Behind
        self.IdCard = IdCard
        self.IssueDate = IssueDate
    }
    
    
    class func parseObjfromArray(array:[JSON])->[LoadinfoByCMND]{
        var list:[LoadinfoByCMND] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> LoadinfoByCMND{
        
        var Docentry = data["Docentry"].int
        var Gender = data["Gender"].string
        var FirstName = data["FirstName"].string
        var MiddleName = data["MiddleName"].string
        var LastName = data["LastName"].string
        var IDCard = data["IDCard"].string
        var PhoneNumber = data["PhoneNumber"].string
        var p_status = data["p_status"].int
        var p_messagess = data["p_messagess"].string
        var NgaySinh = data["NgaySinh"].string
        var fptrequest_Front = data["fptrequest_Front"].string
        var fptrequest_Behind = data["fptrequest_Behind"].string
        var IdCard = data["IdCard"].string
        var IssueDate = data["IssueDate"].string
        
        Docentry = Docentry == nil ? 0 : Docentry
        Gender = Gender == nil ? "" : Gender
        FirstName = FirstName == nil ? "" : FirstName
        MiddleName = MiddleName == nil ? "" : MiddleName
        LastName = LastName == nil ? "" : LastName
        IDCard = IDCard == nil ? "" : IDCard
        PhoneNumber = PhoneNumber == nil ? "" : PhoneNumber
        p_status = p_status == nil ? 0 : p_status
        p_messagess = p_messagess == nil ? "" : p_messagess
        NgaySinh = NgaySinh == nil ? "" : NgaySinh
        fptrequest_Front = fptrequest_Front == nil ? "" : fptrequest_Front
        fptrequest_Behind = fptrequest_Behind == nil ? "" : fptrequest_Behind
        IdCard = IdCard == nil ? "" : IdCard
        IssueDate = IssueDate == nil ? "" : IssueDate
        return LoadinfoByCMND(Docentry:Docentry!
            , Gender:Gender!,FirstName:FirstName!,MiddleName:MiddleName!,LastName:LastName!,IDCard:IDCard!,PhoneNumber:PhoneNumber!,p_status:p_status!,p_messagess:p_messagess!,NgaySinh:NgaySinh!,Native:"", fptrequest_Front:fptrequest_Front!,fptrequest_Behind:fptrequest_Behind!,IdCard:IdCard!,IssueDate:IssueDate!
        )
    }
}
