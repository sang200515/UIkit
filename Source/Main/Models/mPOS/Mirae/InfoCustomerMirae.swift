//
//  InfoCustomerMirae.swift
//  fptshop
//
//  Created by tan on 5/28/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class InfoCustomerMirae: NSObject {
    var IDMPOS:String
    var processId:String
    var activityId:String
    var tpPathDC:String
    var ftpPathContract:String
    var p_status:Int
    var p_messagess:String
    //
    var cmnd:String
    var hoten:String
    var sdt:String
    var diachi:String
    var selectKyhan:String
    var kyhan:String
    var selectGoi:String
    var goi:String
    var sotientratruoc:Float
    var idgoi:String
    
    var tongdonhang:Float

    var sotienvay:Float
    var phibaohiem:Float
    var LastName:String
    var MiddleName:String
    var FirstName:String
    var Gender:Int
    var BirthDay:String
    var Native:String
    var pre_docentry:String
    var sotientratruocInput:Float
    var IssueDate:String
    var base64_mt:String
    var base64_ms:String
    var fee_insurance:Float
    var TenCTyTraGop: String

    
    init( IDMPOS:String
    , processId:String
    , activityId:String
    , tpPathDC:String
    , ftpPathContract:String
    , p_status:Int
    , p_messagess:String
        ,cmnd:String
        ,hoten:String
        ,sdt:String
        ,diachi:String
    , selectKyhan:String
    , kyhan:String
    , selectGoi:String
    , goi:String
        , sotientratruoc:Float
        ,idgoi:String
    , tongdonhang:Float
    , sotienvay:Float
    , phibaohiem:Float
    , LastName:String
    , MiddleName:String
    , FirstName:String
        ,Gender:Int
        ,BirthDay:String
        ,Native:String
        ,pre_docentry:String
        ,sotientratruocInput:Float
        ,IssueDate:String
        ,base64_mt:String
        ,base64_ms:String
        ,fee_insurance:Float
          ,TenCTyTraGop: String){
    
        self.IDMPOS = IDMPOS
        self.processId = processId
        self.activityId = activityId
        self.tpPathDC = tpPathDC
        self.ftpPathContract = ftpPathContract
        self.p_status = p_status
        self.p_messagess = p_messagess
        self.cmnd = cmnd
        self.hoten = hoten
        self.sdt = sdt
        self.diachi = diachi
        self.selectKyhan = selectKyhan
        self.kyhan = kyhan
        self.selectGoi = selectGoi
        self.goi = goi
        self.sotientratruoc = sotientratruoc
        self.idgoi = idgoi
        
        self.tongdonhang = tongdonhang
        self.sotienvay = sotienvay
        self.phibaohiem = phibaohiem
        self.LastName = LastName
        self.MiddleName = MiddleName
        self.FirstName = FirstName
        self.Gender = Gender
        self.BirthDay = BirthDay
        self.Native = Native
        self.pre_docentry = pre_docentry
        self.sotientratruocInput = sotientratruocInput
        self.IssueDate = IssueDate
        self.base64_mt = base64_mt
        self.base64_ms = base64_ms
        self.fee_insurance = fee_insurance
        self.TenCTyTraGop = TenCTyTraGop
    }
    
    class func parseObjfromArray(array:[JSON])->[InfoCustomerMirae]{
        var list:[InfoCustomerMirae] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> InfoCustomerMirae{
        
        var IDMPOS = data["IDMPOS"].string
        var processId = data["processId"].string
        var activityId = data["activityId"].string
        var tpPathDC = data["tpPathDC"].string
        var ftpPathContract = data["ftpPathContract"].string
        var p_status = data["p_status"].int
        var p_messagess = data["p_messagess"].string
//        var base64_mt = data["base64_mt"].string
//        var base64_ms = data["base64_ms"].string
        var fee_insurance = data["fee_insurance"].float
        let TenCTyTraGop = data["TenCTyTraGop"].stringValue
        
        IDMPOS = IDMPOS == nil ? "" : IDMPOS
           processId = processId == nil ? "" : processId
           activityId = activityId == nil ? "" : activityId
           tpPathDC = tpPathDC == nil ? "" : tpPathDC
           ftpPathContract = ftpPathContract == nil ? "" : ftpPathContract
           p_status = p_status == nil ? 0 : p_status
           p_messagess = p_messagess == nil ? "" : p_messagess
        fee_insurance = fee_insurance == nil ? 0 : fee_insurance
//        base64_mt = base64_mt == nil ? "" : base64_mt
//        base64_ms = base64_ms == nil ? "" : base64_ms
        
        
        
        return InfoCustomerMirae(IDMPOS:IDMPOS!
            , processId:processId!
            , activityId:activityId!
            , tpPathDC:tpPathDC!
            , ftpPathContract:ftpPathContract!
            , p_status:p_status!
            , p_messagess:p_messagess!
            ,cmnd:""
            ,hoten:""
            ,sdt:""
            ,diachi:""
        ,selectKyhan: ""
        ,kyhan: ""
        ,selectGoi: ""
        ,goi: ""
        ,sotientratruoc: 0
            ,idgoi:""
        , tongdonhang:0
        , sotienvay:0
        , phibaohiem:0
            , LastName: ""
            , MiddleName: ""
            , FirstName:""
            ,Gender:0
            ,BirthDay:""
            ,Native:""
            ,pre_docentry:""
                                 ,sotientratruocInput:0,IssueDate:"",base64_mt:"",base64_ms:"",fee_insurance:0,TenCTyTraGop: TenCTyTraGop)
    }
    
}
