//
//  SOHeader.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
import Foundation
import SwiftyJSON
class SOHeader: NSObject {
    var CardName: String
    var DiscPrcnt: Float
    var DocEntry: Int
    var DocStatus: String
    var DocType: String
    var FMoney: Int
    var Note: String
    var Payment: String
    var SO_POS: Int
    var StockManager: String
    var U_Address1: String
    var U_City1: String
    var U_CmpPrivate: String
    var U_CrDate: String
    var U_CrdCod: Int
    var U_Email: String
    var U_EplCod: String
    var U_EplName: String
    var U_ErrDesc: String
    var U_Inv3rd: String
    var U_LicTrad: String
    var U_NuBill: String
    var U_ShpCod: String
    var U_Status: Int
    
    var LaiSuat: Float
    var LoaiTraGop: Int
    var SoTienTraTruoc: Float
    var TrangThaiDH:String
    
    var MaCTTG:String
    var So_HD:String
    var TenCtyTraGop:String
    var TraGopUuDai: Int
    var TypeSO_Mpos: Int
    var FlagEdit: Int
    var gender: Int
    var period: Int
    var IdentityCard: String
    var TrangThaiDH_Color: String
    var U_TMonBi: Float
    var EcomNum: Int
    var U_Desc: String
    var LoanAmount:Int
    var Downpayment_ecom: Float
    
    init(CardName: String, DiscPrcnt: Float, DocEntry: Int, DocStatus: String, DocType: String, FMoney: Int, Note: String, Payment: String, SO_POS: Int, StockManager: String, U_Address1: String, U_City1: String, U_CmpPrivate: String, U_CrDate: String, U_CrdCod: Int, U_Email: String, U_EplCod: String, U_EplName: String, U_ErrDesc: String, U_Inv3rd: String, U_LicTrad: String, U_NuBill: String, U_ShpCod: String,U_Status: Int,LaiSuat: Float, LoaiTraGop: Int, SoTienTraTruoc: Float,TrangThaiDH:String, MaCTTG:String, So_HD:String, TenCtyTraGop:String, TraGopUuDai: Int, TypeSO_Mpos: Int, FlagEdit: Int, gender: Int, period: Int, IdentityCard: String, TrangThaiDH_Color: String, U_TMonBi: Float, EcomNum: Int, U_Desc: String, LoanAmount:Int, Downpayment_ecom: Float) {
        self.CardName = CardName
        self.DiscPrcnt = DiscPrcnt
        self.DocEntry = DocEntry
        self.DocStatus = DocStatus
        self.DocType = DocType
        self.FMoney = FMoney
        self.Note = Note
        self.Payment = Payment
        self.SO_POS = SO_POS
        self.StockManager = StockManager
        self.U_Address1 = U_Address1
        self.U_City1 = U_City1
        self.U_CmpPrivate = U_CmpPrivate
        self.U_CrDate = U_CrDate
        self.U_CrdCod = U_CrdCod
        self.U_Email = U_Email
        self.U_EplCod = U_EplCod
        self.U_EplName = U_EplName
        self.U_ErrDesc = U_ErrDesc
        self.U_Inv3rd = U_Inv3rd
        self.U_LicTrad = U_LicTrad
        self.U_NuBill = U_NuBill
        self.U_ShpCod = U_ShpCod
        self.U_Status = U_Status
        self.LaiSuat = LaiSuat
        self.LoaiTraGop = LoaiTraGop
        self.SoTienTraTruoc = SoTienTraTruoc
        self.TrangThaiDH = TrangThaiDH
        
        self.MaCTTG = MaCTTG
        self.So_HD = So_HD
        self.TenCtyTraGop = TenCtyTraGop
        self.TraGopUuDai = TraGopUuDai
        self.TypeSO_Mpos = TypeSO_Mpos
        self.FlagEdit = FlagEdit
        self.gender = gender
        self.period = period
        self.IdentityCard = IdentityCard
        self.TrangThaiDH_Color = TrangThaiDH_Color
        self.U_TMonBi = U_TMonBi
        self.EcomNum = EcomNum
        self.U_Desc = U_Desc
        self.LoanAmount = LoanAmount
        self.Downpayment_ecom = Downpayment_ecom
    }
    class func parseObjfromArray(array:[JSON])->[SOHeader]{
        var list:[SOHeader] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> SOHeader{
        
        var cardName = data["CardName"].string
        var discPrcnt = data["DiscPrcnt"].float
        var docEntry = data["DocEntry"].int
        var docStatus = data["DocStatus"].string
        var docType = data["DocType"].string
        
        var fMoney = data["FMoney"].int
        var note = data["Note"].string
        var payment = data["Payment"].string
        var so_POS = data["SO_POS"].int
        var stockManager = data["StockManager"].string
        
        var u_Address1 = data["U_Address1"].string
        var u_City1 = data["U_City1"].string
        var u_CmpPrivate = data["U_CmpPrivate"].string
        var u_CrDate = data["U_CrDate"].string
        var u_CrdCod = data["U_CrdCod"].int
        
        var u_Email = data["U_Email"].string
        var u_EplCod = data["U_EplCod"].string
        var u_EplName = data["U_EplName"].string
        var u_ErrDesc = data["U_ErrDesc"].string
        var u_Inv3rd = data["U_Inv3rd"].string
        
        var u_LicTrad = data["U_LicTrad"].string
        var u_NuBill = data["U_NuBill"].string
        var u_ShpCod = data["U_ShpCod"].string
        var u_Status = data["U_Status"].int
        
        var laiSuat = data["LaiSuat"].float
        var loaiTraGop = data["LoaiTraGop"].int
        var soTienTraTruoc = data["SoTienTraTruoc"].float
        var TrangThaiDH = data["TrangThaiDH"].string
        
        var MaCTTG = data["MaCTTG"].string
        var So_HD = data["So_HD"].string
        var TenCtyTraGop = data["TenCtyTraGop"].string
        var TraGopUuDai = data["TraGopUuDai"].int
        var TypeSO_Mpos = data["TypeSO_Mpos"].int
        var FlagEdit = data["FlagEdit"].int
        var gender = data["gender"].int
        var period = data["period"].int
        var IdentityCard = data["IdentityCard"].string
        var TrangThaiDH_Color = data["TrangThaiDH_Color"].string
        var EcomNum = data["EcomNum"].int
        var U_TMonBi = data["U_TMonBi"].float
        var U_Desc = data["U_Desc"].string
        var LoanAmount = data["LoanAmount"].int
        var Downpayment_ecom = data["Downpayment_ecom"].float
        
        cardName = cardName == nil ? "" : cardName
        discPrcnt = discPrcnt == nil ? 0 : discPrcnt
        docEntry = docEntry == nil ? 0 : docEntry
        docStatus = docStatus == nil ? "" : docStatus
        docType = docType == nil ? "" : docType
        
        fMoney = fMoney == nil ? 0 : fMoney
        note = note == nil ? "" : note
        payment = payment == nil ? "" : payment
        so_POS = so_POS == nil ? 0 : so_POS
        stockManager = stockManager == nil ? "" : stockManager
        
        u_Address1 = u_Address1 == nil ? "" : u_Address1
        u_City1 = u_City1 == nil ? "" : u_City1
        u_CmpPrivate = u_CmpPrivate == nil ? "" : u_CmpPrivate
        u_CrDate = u_CrDate == nil ? "" : u_CrDate
        u_CrdCod = u_CrdCod == nil ? 0 : u_CrdCod
        
        u_Email = u_Email == nil ? "" : u_Email
        u_EplCod = u_EplCod == nil ? "" : u_EplCod
        u_EplName = u_EplName == nil ? "" : u_EplName
        u_ErrDesc = u_ErrDesc == nil ? "" : u_ErrDesc
        u_Inv3rd = u_Inv3rd == nil ? "" : u_Inv3rd
        
        u_LicTrad = u_LicTrad == nil ? "" : u_LicTrad
        u_NuBill = u_NuBill == nil ? "" : u_NuBill
        u_ShpCod = u_ShpCod == nil ? "" : u_ShpCod
        u_Status = u_Status == nil ? 0 : u_Status
        
        laiSuat = laiSuat == nil ? 0 : laiSuat
        loaiTraGop = loaiTraGop == nil ? 0 : loaiTraGop
        soTienTraTruoc = soTienTraTruoc == nil ? 0 : soTienTraTruoc
        TrangThaiDH = TrangThaiDH == nil ? "" : TrangThaiDH
        
        MaCTTG = MaCTTG == nil ? "" : MaCTTG
        So_HD = So_HD == nil ? "" : So_HD
        TenCtyTraGop = TenCtyTraGop == nil ? "" : TenCtyTraGop
        TraGopUuDai = TraGopUuDai == nil ? 0 : TraGopUuDai
        TypeSO_Mpos = TypeSO_Mpos == nil ? 0 : TypeSO_Mpos
        FlagEdit = FlagEdit == nil ? 0 : FlagEdit
        gender = gender == nil ? 0 : gender
        period = period == nil ? 0 : period
        IdentityCard = IdentityCard == nil ? "" : IdentityCard
        TrangThaiDH_Color = TrangThaiDH_Color == nil ? "" : TrangThaiDH_Color
        EcomNum = EcomNum == nil ? 0 : EcomNum
        U_TMonBi = U_TMonBi == nil ? 0 : U_TMonBi
        U_Desc = U_Desc == nil ? "" : U_Desc
        LoanAmount = LoanAmount == nil ? 0 : LoanAmount
        Downpayment_ecom = Downpayment_ecom == nil ? 0 : Downpayment_ecom
        
        return SOHeader(CardName: cardName!, DiscPrcnt: discPrcnt!, DocEntry: docEntry!, DocStatus: docStatus!, DocType: docType!, FMoney: fMoney!, Note: note!, Payment: payment!, SO_POS: so_POS!, StockManager: stockManager!, U_Address1: u_Address1!, U_City1: u_City1!, U_CmpPrivate: u_CmpPrivate!, U_CrDate: u_CrDate!, U_CrdCod: u_CrdCod!, U_Email: u_Email!, U_EplCod: u_EplCod!, U_EplName: u_EplName!, U_ErrDesc: u_ErrDesc!, U_Inv3rd: u_Inv3rd!, U_LicTrad: u_LicTrad!, U_NuBill: u_NuBill!, U_ShpCod: u_ShpCod!,U_Status: u_Status!,LaiSuat: laiSuat!, LoaiTraGop: loaiTraGop!, SoTienTraTruoc: soTienTraTruoc!,TrangThaiDH:TrangThaiDH!, MaCTTG: MaCTTG!, So_HD: So_HD!, TenCtyTraGop: TenCtyTraGop!, TraGopUuDai: TraGopUuDai!, TypeSO_Mpos: TypeSO_Mpos!, FlagEdit: FlagEdit!, gender: gender!, period: period!, IdentityCard: IdentityCard!, TrangThaiDH_Color: TrangThaiDH_Color!, U_TMonBi: U_TMonBi!, EcomNum: EcomNum!, U_Desc: U_Desc!, LoanAmount: LoanAmount!, Downpayment_ecom: Downpayment_ecom!)
    }
}
