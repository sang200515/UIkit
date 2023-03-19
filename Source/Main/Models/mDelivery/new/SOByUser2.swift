//
//  SOByUser.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/22/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class SOByUser2: NSObject {
    
    let ID : String
    let Code: String
    let UserName : String
    let EmpName: String
    let BookDate : String
    let WHConfirmed: String
    let WHDate : String
    let RejectReason: String
    let RejectDate: String
    let PaymentType: String
    let FinishLatitude : String
    let FinishLongitude: String
    let FinishTime : String
    let PaidConfirmed: String
    let PaidDate : String
    let OrderStatus: String
    let DocEntry : String
    let U_NuBill: String
    let U_ReveRe : String
    let U_CrdName: String
    let U_CAddress: String
    let U_CPhone: String
    let U_SyBill : String
    let U_CrDate: String
    let U_Desc: String
    let U_TMonPr : String
    let U_MonPer: String
    let U_TMonTx : String
    let U_DownPay: String
    let U_TMonBi : String
    let U_Receive: String
    let U_AdrDel : String
    let U_Phone: String
    let U_DateDe : String
    let U_NumEcom: String
    let U_ShpCode: String
    let U_Deposit: String
    let U_PaidMoney : String
    let SourceType: String
    let RowVersion: String
    let mType: String
    let Is_CN : String
    let HTTT_FF: String
    let ImgUrl_PDK_MatTruocCMND : String
    let ImgUrl_PDK_MatSauCMND: String
    let ImgUrl_GiayUyQuyen_MatSauCMND : String
    let ImgUrl_GiayThayDoiChuKy: String
    let CMND : String
    let Ten_DN: String
    let SM_ChiuTrachNhiem : String
    let Is_Upload_TGH: String
    let Is_Upload_NKH: String
    let Is_Upload_PGH: String
    let _WHConfirmed_MaTen:String
    let ImgUrl_TGH: String
    let ImgUrl_NKH: String
    let ImgUrl_PGH: String
    let ImgUrl_TTD: String
    let ReturnReason: String
    let SoTienTraTruoc:String
    let mCreateType:String
    let ImgUrl_MatTruocCMND:String
    let ImgUrl_HDTC1:String
    let ContentWork:String
    let UserBookCode:String
    let InstallLocation:String
    let U_ShopName:String
    let UserBookName:String
    let ImgUploadTime:String
    let ImgUrl_XNGH:String
    let Ma_HD:String
    
    init(ID : String, Code: String, UserName : String, EmpName: String, BookDate : String, WHConfirmed: String, WHDate : String, RejectReason: String, RejectDate: String, PaymentType: String, FinishLatitude : String, FinishLongitude: String, FinishTime : String, PaidConfirmed: String, PaidDate : String, OrderStatus: String, DocEntry : String, U_NuBill: String, U_ReveRe : String, U_CrdName: String, U_CAddress: String, U_CPhone: String, U_SyBill : String, U_CrDate: String, U_Desc: String, U_TMonPr : String, U_MonPer: String, U_TMonTx : String, U_DownPay: String, U_TMonBi : String, U_Receive: String, U_AdrDel : String, U_Phone: String, U_DateDe : String, U_NumEcom: String, U_ShpCode: String, U_Deposit: String, U_PaidMoney : String, SourceType: String, RowVersion: String, mType: String, Is_CN : String, HTTT_FF: String, ImgUrl_PDK_MatTruocCMND : String, ImgUrl_PDK_MatSauCMND: String, ImgUrl_GiayUyQuyen_MatSauCMND : String, ImgUrl_GiayThayDoiChuKy: String, CMND : String, Ten_DN: String, SM_ChiuTrachNhiem : String, Is_Upload_TGH: String, Is_Upload_NKH: String, Is_Upload_PGH: String, _WHConfirmed_MaTen:String, ImgUrl_TGH: String, ImgUrl_NKH: String, ImgUrl_PGH: String, ImgUrl_TTD: String, ReturnReason: String, SoTienTraTruoc:String, mCreateType:String, ImgUrl_MatTruocCMND:String, ImgUrl_HDTC1:String, ContentWork:String, UserBookCode:String, InstallLocation:String, U_ShopName:String, UserBookName:String, ImgUploadTime:String, ImgUrl_XNGH:String, Ma_HD:String){
        
        self.ID = ID
        self.Code = Code
        self.UserName = UserName
        self.EmpName = EmpName
        self.BookDate = BookDate
        self.WHConfirmed = WHConfirmed
        self.WHDate = WHDate
        self.RejectReason = RejectReason
        self.RejectDate = RejectDate
        self.PaymentType = PaymentType
        self.FinishLatitude = FinishLatitude
        self.FinishLongitude = FinishLongitude
        self.FinishTime = FinishTime
        self.PaidConfirmed = PaidConfirmed
        self.PaidDate = PaidDate
        self.OrderStatus = OrderStatus
        self.DocEntry = DocEntry
        self.U_NuBill = U_NuBill
        self.U_ReveRe = U_ReveRe
        self.U_CrdName = U_CrdName
        self.U_CAddress = U_CAddress
        self.U_CPhone = U_CPhone
        self.U_SyBill = U_SyBill
        self.U_CrDate = U_CrDate
        self.U_Desc = U_Desc
        self.U_TMonPr = U_TMonPr
        self.U_MonPer = U_MonPer
        self.U_TMonTx = U_TMonTx
        self.U_DownPay = U_DownPay
        self.U_TMonBi = U_TMonBi
        self.U_Receive = U_Receive
        self.U_AdrDel = U_AdrDel
        self.U_Phone = U_Phone
        self.U_DateDe = U_DateDe
        self.U_NumEcom = U_NumEcom
        self.U_ShpCode = U_ShpCode
        self.U_Deposit = U_Deposit
        self.U_PaidMoney = U_PaidMoney
        self.SourceType = SourceType
        self.RowVersion = RowVersion
        self.mType = mType
        self.Is_CN = Is_CN
        self.HTTT_FF = HTTT_FF
        self.ImgUrl_PDK_MatTruocCMND = ImgUrl_PDK_MatTruocCMND
        self.ImgUrl_PDK_MatSauCMND = ImgUrl_PDK_MatSauCMND
        self.ImgUrl_GiayUyQuyen_MatSauCMND = ImgUrl_GiayUyQuyen_MatSauCMND
        self.ImgUrl_GiayThayDoiChuKy = ImgUrl_GiayThayDoiChuKy
        self.CMND = CMND
        self.Ten_DN = Ten_DN
        self.SM_ChiuTrachNhiem = SM_ChiuTrachNhiem
        self.Is_Upload_TGH = Is_Upload_TGH
        self.Is_Upload_NKH = Is_Upload_NKH
        self.Is_Upload_PGH = Is_Upload_PGH
        self._WHConfirmed_MaTen = _WHConfirmed_MaTen
        self.ImgUrl_TGH = ImgUrl_TGH
        self.ImgUrl_NKH = ImgUrl_NKH
        self.ImgUrl_PGH = ImgUrl_PGH
        self.ImgUrl_TTD = ImgUrl_TTD
        self.ReturnReason = ReturnReason
        self.SoTienTraTruoc = SoTienTraTruoc
        self.mCreateType = mCreateType
        self.ImgUrl_MatTruocCMND = ImgUrl_MatTruocCMND
        self.ImgUrl_HDTC1 = ImgUrl_HDTC1
        self.ContentWork = ContentWork
        self.UserBookCode = UserBookCode
        self.InstallLocation = InstallLocation
        self.U_ShopName = U_ShopName
        self.UserBookName = UserBookName
        self.ImgUploadTime = ImgUploadTime
        self.ImgUrl_XNGH = ImgUrl_XNGH
        self.Ma_HD = Ma_HD
    }
    class func parseObjfromArray(array:[JSON])->[SOByUser2]{
        var list:[SOByUser2] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> SOByUser2{
        
        var ID = data["ID"].string
        var Code = data["Code"].string
        var UserName = data["UserName"].string
        
        ID = ID == nil ? "" : ID
        Code = Code == nil ? "" : Code
        UserName = UserName == nil ? "" : UserName
        
        var EmpName = data["EmpName"].string
        var BookDate = data["BookDate"].string
        var WHConfirmed = data["WHConfirmed"].string
        
        EmpName = EmpName == nil ? "" : EmpName
        BookDate = BookDate == nil ? "" : BookDate
        WHConfirmed = WHConfirmed == nil ? "" : WHConfirmed
        
        var WHDate = data["WHDate"].string
        var RejectReason = data["RejectReason"].string
        var RejectDate = data["RejectDate"].string
        
        WHDate = WHDate == nil ? "" : WHDate
        RejectReason = RejectReason == nil ? "" : RejectReason
        RejectDate = RejectDate == nil ? "" : RejectDate
        
        var PaymentType = data["PaymentType"].string
        var FinishLatitude = data["FinishLatitude"].string
        var FinishLongitude = data["FinishLongitude"].string
        
        PaymentType = PaymentType == nil ? "" : PaymentType
        FinishLatitude = FinishLatitude == nil ? "" : FinishLatitude
        FinishLongitude = FinishLongitude == nil ? "" : FinishLongitude
        
        var FinishTime = data["FinishTime"].string
        var PaidConfirmed = data["PaidConfirmed"].string
        var PaidDate = data["PaidDate"].string
        
        FinishTime = FinishTime == nil ? "" : FinishTime
        PaidConfirmed = PaidConfirmed == nil ? "" : PaidConfirmed
        PaidDate = PaidDate == nil ? "" : PaidDate
        
        var OrderStatus = data["OrderStatus"].string
        var DocEntry = data["DocEntry"].string
        var U_NuBill = data["U_NuBill"].string
        
        OrderStatus = OrderStatus == nil ? "" : OrderStatus
        DocEntry = DocEntry == nil ? "" : DocEntry
        U_NuBill = U_NuBill == nil ? "" : U_NuBill
        
        var U_ReveRe = data["U_ReveRe"].string
        var U_CrdName = data["U_CrdName"].string
        var U_CAddress = data["U_CAddress"].string
        
        U_ReveRe = U_ReveRe == nil ? "" : U_ReveRe
        U_CrdName = U_CrdName == nil ? "" : U_CrdName
        U_CAddress = U_CAddress == nil ? "" : U_CAddress
        
        var U_CPhone = data["U_CPhone"].string
        var U_SyBill = data["U_SyBill"].string
        var U_CrDate = data["U_CrDate"].string
        
        U_CPhone = U_CPhone == nil ? "" : U_CPhone
        U_SyBill = U_SyBill == nil ? "" : U_SyBill
        U_CrDate = U_CrDate == nil ? "" : U_CrDate
        
        var U_Desc = data["U_Desc"].string
        var U_TMonPr = data["U_TMonPr"].string
        var U_MonPer = data["U_MonPer"].string
        
        U_Desc = U_Desc == nil ? "" : U_Desc
        U_TMonPr = U_TMonPr == nil ? "" : U_TMonPr
        U_MonPer = U_MonPer == nil ? "" : U_MonPer
        
        var U_TMonTx = data["U_TMonTx"].string
        var U_DownPay = data["U_DownPay"].string
        var U_TMonBi = data["U_TMonBi"].string
        
        U_TMonTx = U_TMonTx == nil ? "" : U_TMonTx
        U_DownPay = U_DownPay == nil ? "" : U_DownPay
        U_TMonBi = U_TMonBi == nil ? "" : U_TMonBi
        
        var U_Receive = data["U_Receive"].string
        var U_AdrDel = data["U_AdrDel"].string
        var U_Phone = data["U_Phone"].string
        
        U_Receive = U_Receive == nil ? "" : U_Receive
        U_AdrDel = U_AdrDel == nil ? "" : U_AdrDel
        U_Phone = U_Phone == nil ? "" : U_Phone
        
        var U_DateDe = data["U_DateDe"].string
        var U_NumEcom = data["U_NumEcom"].string
        var U_ShpCode = data["U_ShpCode"].string
        
        U_DateDe = U_DateDe == nil ? "" : U_DateDe
        U_NumEcom = U_NumEcom == nil ? "" : U_NumEcom
        U_ShpCode = U_ShpCode == nil ? "" : U_ShpCode
        
        var U_Deposit = data["U_Deposit"].string
        var U_PaidMoney = data["U_PaidMoney"].string
        var SourceType = data["SourceType"].string
        
        U_Deposit = U_Deposit == nil ? "" : U_Deposit
        U_PaidMoney = U_PaidMoney == nil ? "" : U_PaidMoney
        SourceType = SourceType == nil ? "" : SourceType
        
        var RowVersion = data["RowVersion"].string
        var mType = data["Type"].string
        var  Is_CN = data["Is_CN"].string
        
        RowVersion = RowVersion == nil ? "" : RowVersion
        mType = mType == nil ? "" : mType
        Is_CN = Is_CN == nil ? "" : Is_CN
        
        var HTTT_FF = data["HTTT_FF"].string
        var ImgUrl_PDK_MatTruocCMND = data["ImgUrl_PDK_MatTruocCMND"].string
        var ImgUrl_PDK_MatSauCMND = data["ImgUrl_PDK_MatSauCMND"].string
        
        HTTT_FF = HTTT_FF == nil ? "" : HTTT_FF
        ImgUrl_PDK_MatTruocCMND = ImgUrl_PDK_MatTruocCMND == nil ? "" : ImgUrl_PDK_MatTruocCMND
        ImgUrl_PDK_MatSauCMND = ImgUrl_PDK_MatSauCMND == nil ? "" : ImgUrl_PDK_MatSauCMND
        
        var ImgUrl_GiayUyQuyen_MatSauCMND = data["ImgUrl_GiayUyQuyen_MatSauCMND"].string
        var ImgUrl_GiayThayDoiChuKy = data["ImgUrl_GiayThayDoiChuKy"].string
        var CMND = data["CMND"].string
        
        ImgUrl_GiayUyQuyen_MatSauCMND = ImgUrl_GiayUyQuyen_MatSauCMND == nil ? "" : ImgUrl_GiayUyQuyen_MatSauCMND
        ImgUrl_GiayThayDoiChuKy = ImgUrl_GiayThayDoiChuKy == nil ? "" : ImgUrl_GiayThayDoiChuKy
        CMND = CMND == nil ? "" : CMND
        
        var Ten_DN = data["Ten_DN"].string
        var SM_ChiuTrachNhiem = data["SM_ChiuTrachNhiem"].string
        var Is_Upload_TGH = data["Is_Upload_TGH"].string
        
        Ten_DN = Ten_DN == nil ? "" : Ten_DN
        SM_ChiuTrachNhiem = SM_ChiuTrachNhiem == nil ? "" : SM_ChiuTrachNhiem
        Is_Upload_TGH = Is_Upload_TGH == nil ? "" : Is_Upload_TGH
        
        
        
        var Is_Upload_NKH = data["Is_Upload_NKH"].string
        var Is_Upload_PGH = data["Is_Upload_PGH"].string
        var _WHConfirmed_MaTen = data["_WHConfirmed_MaTen"].string
        
        Is_Upload_NKH = Is_Upload_NKH == nil ? "" : Is_Upload_NKH
        Is_Upload_PGH = Is_Upload_PGH == nil ? "" : Is_Upload_PGH
        _WHConfirmed_MaTen = _WHConfirmed_MaTen == nil ? "" : _WHConfirmed_MaTen
        
        var ImgUrl_TGH = data["ImgUrl_TGH"].string
        var ImgUrl_NKH = data["ImgUrl_NKH"].string
        var ImgUrl_PGH = data["ImgUrl_PGH"].string
        
        ImgUrl_TGH = ImgUrl_TGH == nil ? "" : ImgUrl_TGH
        ImgUrl_NKH = ImgUrl_NKH == nil ? "" : ImgUrl_NKH
        ImgUrl_PGH = ImgUrl_PGH == nil ? "" : ImgUrl_PGH
        
        var  ReturnReason = data["ReturnReason"].string
        var  SoTienTraTruoc = data["SoTienTraTruoc"].string
        var  mCreateType = data["CreateType"].string
        
        ReturnReason = ReturnReason == nil ? "" : ReturnReason
        SoTienTraTruoc = SoTienTraTruoc == nil ? "" : SoTienTraTruoc
        mCreateType = mCreateType == nil ? "" : mCreateType
        
        var ImgUrl_TTD =  data["ImgUrl_TTD"].string
        var  ImgUrl_MatTruocCMND = data["ImgUrl_MatTruocCMND"].string
        var ImgUrl_HDTC1 = data["ImgUrl_HDTC1"].string
        
        ImgUrl_TTD = ImgUrl_TTD == nil ? "" : ImgUrl_TTD
        ImgUrl_MatTruocCMND = ImgUrl_MatTruocCMND == nil ? "" : ImgUrl_MatTruocCMND
        ImgUrl_HDTC1 = ImgUrl_HDTC1 == nil ? "" : ImgUrl_HDTC1
        
        var  ContentWork = data["ContentWork"].string
        var  UserBookCode = data["UserBookCode"].string
        var  InstallLocation = data["InstallLocation"].string
        
        ContentWork = ContentWork == nil ? "" : ContentWork
        UserBookCode = UserBookCode == nil ? "" : UserBookCode
        InstallLocation = InstallLocation == nil ? "" : InstallLocation
        
        var  U_ShopName = data["U_ShopName"].string
        var  UserBookName = data["UserBookName"].string
        var   ImgUploadTime = data["ImgUploadTime"].string
        
        U_ShopName = U_ShopName == nil ? "" : U_ShopName
        UserBookName = UserBookName == nil ? "" : UserBookName
        ImgUploadTime = ImgUploadTime == nil ? "" : ImgUploadTime
        
        var   ImgUrl_XNGH = data["ImgUrl_XNGH"].string
        var  Ma_HD = data["Ma_HD"].string
        
        ImgUrl_XNGH = ImgUrl_XNGH == nil ? "" : ImgUrl_XNGH
        Ma_HD = Ma_HD == nil ? "" : Ma_HD
        
        
        
        return SOByUser2(ID : ID!, Code: Code!, UserName : UserName!, EmpName: EmpName!, BookDate : BookDate!, WHConfirmed: WHConfirmed!, WHDate : WHDate!, RejectReason: RejectReason!, RejectDate: RejectDate!, PaymentType: PaymentType!, FinishLatitude : FinishLatitude!, FinishLongitude: FinishLongitude!, FinishTime : FinishTime!, PaidConfirmed: PaidConfirmed!, PaidDate : PaidDate!, OrderStatus: OrderStatus!, DocEntry : DocEntry!, U_NuBill: U_NuBill!, U_ReveRe : U_ReveRe!, U_CrdName: U_CrdName!, U_CAddress: U_CAddress!, U_CPhone: U_CPhone!, U_SyBill : U_SyBill!, U_CrDate: U_CrDate!, U_Desc: U_Desc!, U_TMonPr : U_TMonPr!, U_MonPer: U_MonPer!, U_TMonTx : U_TMonTx!, U_DownPay: U_DownPay!, U_TMonBi : U_TMonBi!, U_Receive: U_Receive!, U_AdrDel : U_AdrDel!, U_Phone: U_Phone!, U_DateDe : U_DateDe!, U_NumEcom: U_NumEcom!, U_ShpCode: U_ShpCode!, U_Deposit: U_Deposit!, U_PaidMoney : U_PaidMoney!, SourceType: SourceType!, RowVersion: RowVersion!, mType: mType!, Is_CN : Is_CN!, HTTT_FF: HTTT_FF!, ImgUrl_PDK_MatTruocCMND : ImgUrl_PDK_MatTruocCMND!, ImgUrl_PDK_MatSauCMND: ImgUrl_PDK_MatSauCMND!, ImgUrl_GiayUyQuyen_MatSauCMND : ImgUrl_GiayUyQuyen_MatSauCMND!, ImgUrl_GiayThayDoiChuKy: ImgUrl_GiayThayDoiChuKy!, CMND : CMND!, Ten_DN: Ten_DN!, SM_ChiuTrachNhiem : SM_ChiuTrachNhiem!, Is_Upload_TGH: Is_Upload_TGH!, Is_Upload_NKH: Is_Upload_NKH!, Is_Upload_PGH: Is_Upload_PGH!, _WHConfirmed_MaTen:_WHConfirmed_MaTen!, ImgUrl_TGH: ImgUrl_TGH!, ImgUrl_NKH: ImgUrl_NKH!, ImgUrl_PGH: ImgUrl_PGH!, ImgUrl_TTD: ImgUrl_TTD!, ReturnReason: ReturnReason!, SoTienTraTruoc:SoTienTraTruoc!, mCreateType:mCreateType!, ImgUrl_MatTruocCMND:ImgUrl_MatTruocCMND!, ImgUrl_HDTC1:ImgUrl_HDTC1!, ContentWork:ContentWork!, UserBookCode:UserBookCode!, InstallLocation:InstallLocation!, U_ShopName:U_ShopName!, UserBookName:UserBookName!, ImgUploadTime:ImgUploadTime!, ImgUrl_XNGH:ImgUrl_XNGH!, Ma_HD:Ma_HD!)
    }
}
