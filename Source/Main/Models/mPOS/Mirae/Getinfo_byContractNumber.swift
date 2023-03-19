//
//  Getinfo_byContractNumber.swift
//  fptshop
//
//  Created by tan on 6/3/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class Getinfo_byContractNumber: NSObject {
    var processId:String
    var SoMPOS:Int
    var Docentry:Int
    var activityId:String
    var partnerId:Int
    var title:String
    var mobile:String
    var assetProduct:String
    var schemeId:Int
    var assetCost:Int
    var downPayment:Int
    var tenure:Int
    var stateId:String
    var city:String
    var zipcode:String
    var address:String
    var stateId_2:String
    var city_2:String
    var zipcode_2:String
    var address_2:String
    var fileName:String
    var empSalary:Int
    var empName:String
    var empPosition:String
    var empYear:Int
    var empStateId:String
    var empCity:String
    var empZipcode:String
    var empPhone:String
    var empAddress:String
    var additionalIdType:String
    var addIdentification:String
    var refName:String
    var refRelationship:String
    var refContact:String
    var imei:Int
    var FirstImei_day:String
    var ftpPathDC_Mirae:String
    var dueDate:String
    var Flag_Image:String
    var ftpPath3Party_Mirae:String
    var list_update_mirae:String
    var BirthDay:String
    var ftpPathContract_Mirae:String
    var Flag_Image_PDK:String
    var Flag_Img_PDK_details:String
    var idIssuedBy:String
    var idIssuedDate:String
    var phone1:String
    var refName_2:String
    var refRelationship_2:String
    var is_update_info:Int
    var refContact_2:String
    var is_tttb:Int
    
    init(     processId:String
    , SoMPOS:Int
    , Docentry:Int
    , activityId:String
    , partnerId:Int
    , title:String
    , mobile:String
    , assetProduct:String
    , schemeId:Int
    , assetCost:Int
    , downPayment:Int
    , tenure:Int
    , stateId:String
    , city:String
    , zipcode:String
    , address:String
    , stateId_2:String
    , city_2:String
    , zipcode_2:String
    , address_2:String
    , fileName:String
    , empSalary:Int
    , empName:String
    , empPosition:String
    , empYear:Int
    , empStateId:String
    , empCity:String
    , empZipcode:String
    , empPhone:String
    , empAddress:String
    , additionalIdType:String
    , addIdentification:String
    , refName:String
    , refRelationship:String
    , refContact:String
    , imei:Int
    , FirstImei_day:String
        , ftpPathDC_Mirae:String
        , dueDate:String
        ,Flag_Image:String
        ,ftpPath3Party_Mirae:String
        ,list_update_mirae:String
        ,BirthDay:String
        ,ftpPathContract_Mirae:String
        ,Flag_Image_PDK:String
        ,Flag_Img_PDK_details:String
        ,idIssuedBy:String
        ,idIssuedDate:String
        ,phone1:String
    , refName_2:String
    , refRelationship_2:String
        ,is_update_info:Int
        ,refContact_2:String
    ,is_tttb:Int){
        self.processId = processId
        self.SoMPOS = SoMPOS
        self.Docentry = Docentry
        self.activityId = activityId
        self.partnerId = partnerId
        self.title = title
        self.mobile = mobile
        self.assetProduct = assetProduct
        self.schemeId = schemeId
        self.assetCost = assetCost
        self.downPayment = downPayment
        self.tenure = tenure
        self.stateId = stateId
        self.city = city
        self.zipcode = zipcode
        self.address = address
        self.stateId_2 = stateId_2
        self.city_2 = city_2
        self.zipcode_2 = zipcode_2
        self.address_2 = address_2
        self.fileName = fileName
        self.empSalary = empSalary
        self.empName = empName
        self.empPosition = empPosition
        self.empYear = empYear
        self.empStateId = empStateId
        self.empCity = empCity
        self.empZipcode = empZipcode
        self.empPhone = empPhone
        self.empAddress = empAddress
        self.additionalIdType = additionalIdType
        self.addIdentification = addIdentification
        self.refName = refName
        self.refRelationship = refRelationship
        self.refContact = refContact
        self.imei = imei
        self.FirstImei_day = FirstImei_day
        self.ftpPathDC_Mirae = ftpPathDC_Mirae
        self.dueDate = dueDate
        self.Flag_Image = Flag_Image
        self.ftpPath3Party_Mirae  = ftpPath3Party_Mirae
        self.list_update_mirae = list_update_mirae
        self.BirthDay = BirthDay
        self.ftpPathContract_Mirae = ftpPathContract_Mirae
        self.Flag_Image_PDK = Flag_Image_PDK
        self.Flag_Img_PDK_details = Flag_Img_PDK_details
        self.idIssuedBy = idIssuedBy
        self.idIssuedDate = idIssuedDate
        self.phone1 = phone1
        self.refName_2 = refName_2
        self.refRelationship_2 = refRelationship_2
        self.is_update_info = is_update_info
        self.refContact_2 = refContact_2
        self.is_tttb = is_tttb
    }
    
    class func parseObjfromArray(array:[JSON])->[Getinfo_byContractNumber]{
        var list:[Getinfo_byContractNumber] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> Getinfo_byContractNumber{
        
      
        var processId = data["processId"].string
        var SoMPOS = data["SoMPOS"].int
        var Docentry = data["Docentry"].int
        
        var activityId = data["activityId"].string
        var partnerId = data["partnerId"].int
        
        var title = data["title"].string
        var mobile = data["mobile"].string
        
        var assetProduct = data["assetProduct"].string
        var schemeId = data["schemeId"].int
        
        var assetCost = data["assetCost"].int
        var downPayment = data["downPayment"].int
        
        var tenure = data["tenure"].int
        var stateId = data["stateId"].string
        
        var city = data["city"].string
        var zipcode = data["zipcode"].string
        
        var address = data["address"].string
        var stateId_2 = data["stateId_2"].string
        
        var city_2 = data["city_2"].string
        var zipcode_2 = data["zipcode_2"].string
        
        var address_2 = data["address_2"].string
        var fileName = data["fileName"].string
        
        var empSalary = data["empSalary"].int
        var empName = data["empName"].string
        
        var empPosition = data["empPosition"].string
        var empYear = data["empYear"].int
        
        var empStateId = data["empStateId"].string
        var empCity = data["empCity"].string
        
        var empZipcode = data["empZipcode"].string
        var empPhone = data["empPhone"].string
        
        var empAddress = data["empAddress"].string
        var additionalIdType = data["additionalIdType"].string
        
        var addIdentification = data["addIdentification"].string
        var refName = data["refName"].string
        
        var refRelationship = data["refRelationship"].string
        var refContact = data["refContact"].string
        
        var imei = data["imei"].int
        var FirstImei_day = data["FirstImei_day"].string
        var ftpPathDC_Mirae = data["ftpPathDC_Mirae"].string
        var dueDate = data["dueDate"].string
        var Flag_Image = data["Flag_Image"].string
        var ftpPath3Party_Mirae = data["ftpPath3Party_Mirae"].string
        var list_update_mirae = data["list_update_mirae"].string
        var BirthDay = data["BirthDay"].string
        var ftpPathContract_Mirae = data["ftpPathContract_Mirae"].string
        var Flag_Image_PDK = data["Flag_Image_PDK"].string
        var Flag_Img_PDK_details = data["Flag_Img_PDK_details"].string
        var idIssuedBy = data["idIssuedBy"].string
        var idIssuedDate = data["idIssuedDate"].string
        var phone1 = data["phone1"].string
        var refName_2 = data["refName_2"].string
        var refRelationship_2 = data["refRelationship_2"].string
        var is_update_info = data["is_update_info"].int
        var refContact_2 = data["refContact_2"].string
        var is_tttb = data["is_tttb"].int
        
        processId = processId == nil ? "" : processId
        SoMPOS = SoMPOS == nil ? 0 : SoMPOS
        Docentry = Docentry == nil ? 0 : Docentry
        
        activityId = activityId == nil ? "" : activityId
         partnerId = partnerId == nil ? 0 : partnerId
        
        title = title == nil ? "" : title
        mobile = mobile == nil ? "" : mobile
        
        assetProduct = assetProduct == nil ? "" : assetProduct
         schemeId = schemeId == nil ? 0 : schemeId
        
        assetCost = assetCost == nil ? 0 : assetCost
        downPayment = downPayment == nil ? 0 : downPayment
        
        tenure = tenure == nil ? 0 : tenure
        stateId = stateId == nil ? "" : stateId
        
          city = city == nil ? "" : city
           zipcode = zipcode == nil ? "" : zipcode
        
        address = address == nil ? "" : address
          stateId_2 = stateId_2 == nil ? "" : stateId_2
        
           city_2 = city_2 == nil ? "" : city_2
           zipcode_2 = zipcode_2 == nil ? "" : zipcode_2
        
         address_2 = address_2 == nil ? "" : address_2
             fileName = fileName == nil ? "" : fileName
        
        empSalary = empSalary == nil ? 0 : empSalary
           empName = empName == nil ? "" : empName
        
        empPosition = empPosition == nil ? "" : empPosition
          empYear = empYear == nil ? 0 : empYear
        
         empStateId = empStateId == nil ? "" : empStateId
         empCity = empCity == nil ? "" : empCity
        
         empZipcode = empZipcode == nil ? "" : empZipcode
          empPhone = empPhone == nil ? "" : empPhone
        
           empAddress = empAddress == nil ? "" : empAddress
         additionalIdType = additionalIdType == nil ? "" : additionalIdType
        
            addIdentification = addIdentification == nil ? "" : addIdentification
           refName = refName == nil ? "" : refName
        
           refRelationship = refRelationship == nil ? "" : refRelationship
           refContact = refContact == nil ? "" : refContact
        
          imei = imei == nil ? 0 : imei
         FirstImei_day = FirstImei_day == nil ? "" : FirstImei_day
        ftpPathDC_Mirae = ftpPathDC_Mirae == nil ? "" : ftpPathDC_Mirae
        dueDate = dueDate == nil ? "" : dueDate
        Flag_Image = Flag_Image == nil ? "" : Flag_Image
        ftpPath3Party_Mirae = ftpPath3Party_Mirae == nil ? "" : ftpPath3Party_Mirae
        list_update_mirae = list_update_mirae == nil ? "" : list_update_mirae
        BirthDay = BirthDay == nil ? "" : BirthDay
        ftpPathContract_Mirae = ftpPathContract_Mirae == nil ? "" : ftpPathContract_Mirae
        Flag_Image_PDK = Flag_Image_PDK == nil ? "" : Flag_Image_PDK
        Flag_Img_PDK_details = Flag_Img_PDK_details == nil ? "" : Flag_Img_PDK_details
        idIssuedBy = idIssuedBy == nil ? "" : idIssuedBy
        idIssuedDate = idIssuedDate == nil ? "" : idIssuedDate
        phone1 = phone1 == nil ? "" : phone1
        refName_2 = refName_2 == nil ? "" : refName_2
        refRelationship_2 = refRelationship_2 == nil ? "" : refRelationship_2
        is_update_info = is_update_info == nil ? 0 : is_update_info
        refContact_2 = refContact_2 == nil ? "" : refContact_2
        is_tttb = is_tttb == nil ? 0 : is_tttb
        
        return Getinfo_byContractNumber(processId:processId!
            , SoMPOS:SoMPOS!
            , Docentry:Docentry!
            , activityId:activityId!
            , partnerId:partnerId!
            , title:title!
            , mobile:mobile!
            , assetProduct:assetProduct!
            , schemeId:schemeId!
            , assetCost:assetCost!
            , downPayment:downPayment!
            , tenure:tenure!
            , stateId:stateId!
            , city:city!
            , zipcode:zipcode!
            , address:address!
            , stateId_2:stateId_2!
            , city_2:city_2!
            , zipcode_2:zipcode_2!
            , address_2:address_2!
            , fileName:fileName!
            , empSalary:empSalary!
            , empName:empName!
            , empPosition:empPosition!
            , empYear:empYear!
            , empStateId:empStateId!
            , empCity:empCity!
            , empZipcode:empZipcode!
            , empPhone:empPhone!
            , empAddress:empAddress!
            , additionalIdType:additionalIdType!
            , addIdentification:addIdentification!
            , refName:refName!
            , refRelationship:refRelationship!
            , refContact:refContact!
            , imei:imei!
            , FirstImei_day:FirstImei_day!
            , ftpPathDC_Mirae:ftpPathDC_Mirae!
            , dueDate:dueDate!
            ,Flag_Image:Flag_Image!
            ,ftpPath3Party_Mirae:ftpPath3Party_Mirae!
            ,list_update_mirae:list_update_mirae!
            ,BirthDay:BirthDay!
            ,ftpPathContract_Mirae:ftpPathContract_Mirae!
            ,Flag_Image_PDK:Flag_Image_PDK!
            ,Flag_Img_PDK_details:Flag_Img_PDK_details!
            ,idIssuedBy:idIssuedBy!
            ,idIssuedDate:idIssuedDate!
            ,phone1:phone1!
            ,refName_2:refName_2!
            ,refRelationship_2:refRelationship_2!
            ,is_update_info:is_update_info!
            ,refContact_2:refContact_2!
            ,is_tttb:is_tttb!
        )
    }
}
