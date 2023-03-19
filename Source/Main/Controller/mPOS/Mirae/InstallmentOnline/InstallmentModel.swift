//
//  InstallmentModel.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 05/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

// api/Order/Customer

class DataOrder: NSObject {
    var soStatus : String
    var docNum : String
    var docEntry : String
    var u_CardCode : String
    var u_EplCod : String
    var u_CrDate : String
    var u_Status : String
    var u_Desc : String
    var u_INV_TYPE : String
    var u_ShipTyp : String
    var u_ShpCod : String
    var u_CompCod : String
    var u_CmpPrivate : String
    var u_UCode : String
    var u_Phone : String
    var u_LicTrad : String
    var u_Address1 : String
    var u_CodeECom : String
    var u_SOType : String
    var isConfirm : String
    var u_PayOnline : String
    var u_TMonBi : String
    var u_Mustpay : String
    var applicationID : String
    var contractNumber : String
    var gender : String
    var dateofbirth : String
    var cmnd : String
    var downpayment : String
    var schemeID : String
    var tenure : String
    var schemeName : String
    
    init(soStatus: String, docNum: String, docEntry: String, u_CardCode: String, u_EplCod: String, u_CrDate: String, u_Status: String, u_Desc: String, u_INV_TYPE: String, u_ShipTyp: String, u_ShpCod: String, u_CompCod: String, u_CmpPrivate: String, u_UCode: String, u_Phone: String, u_LicTrad: String, u_Address1: String, u_CodeECom: String, u_SOType: String, isConfirm: String, u_PayOnline: String, u_TMonBi: String, u_Mustpay: String, applicationID: String, contractNumber: String, gender: String, dateofbirth: String, cmnd: String, downpayment: String, schemeID: String, tenure: String, schemeName: String) {
        self.soStatus = soStatus
        self.docNum = docNum
        self.docEntry = docEntry
        self.u_CardCode = u_CardCode
        self.u_EplCod = u_EplCod
        self.u_CrDate = u_CrDate
        self.u_Status = u_Status
        self.u_Desc = u_Desc
        self.u_INV_TYPE = u_INV_TYPE
        self.u_ShipTyp = u_ShipTyp
        self.u_ShpCod = u_ShpCod
        self.u_CompCod = u_CompCod
        self.u_CmpPrivate = u_CmpPrivate
        self.u_UCode = u_UCode
        self.u_Phone = u_Phone
        self.u_LicTrad = u_LicTrad
        self.u_Address1 = u_Address1
        self.u_CodeECom = u_CodeECom
        self.u_SOType = u_SOType
        self.isConfirm = isConfirm
        self.u_PayOnline = u_PayOnline
        self.u_TMonBi = u_TMonBi
        self.u_Mustpay = u_Mustpay
        self.applicationID = applicationID
        self.contractNumber = contractNumber
        self.gender = gender
        self.dateofbirth = dateofbirth
        self.cmnd = cmnd
        self.downpayment = downpayment
        self.schemeID = schemeID
        self.tenure = tenure
        self.schemeName = schemeName
    }
    
    class func getObjFromDictionary(data:JSON) -> DataOrder {
        
        let soStatus = data["soStatus"].stringValue
        let docNum = data["docNum"].stringValue
        let docEntry = data["docEntry"].stringValue
        let u_CardCode = data["u_CardCode"].stringValue
        let u_EplCod = data["u_EplCod"].stringValue
        let u_CrDate = data["u_CrDate"].stringValue
        let u_Status = data["u_Status"].stringValue
        let u_Desc = data["u_Desc"].stringValue
        let u_INV_TYPE = data["u_INV_TYPE"].stringValue
        let u_ShipTyp = data["u_ShipTyp"].stringValue
        let u_ShpCod = data["u_ShpCod"].stringValue
        let u_CompCod = data["u_CompCod"].stringValue
        let u_CmpPrivate = data["u_CmpPrivate"].stringValue
        let u_UCode = data["u_UCode"].stringValue
        let u_Phone = data["u_Phone"].stringValue
        let u_LicTrad = data["u_LicTrad"].stringValue
        let u_Address1 = data["u_Address1"].stringValue
        let u_CodeECom = data["u_CodeECom"].stringValue
        let u_SOType = data["u_SOType"].stringValue
        let isConfirm = data["isConfirm"].stringValue
        let u_PayOnline = data["u_PayOnline"].stringValue
        let u_TMonBi = data["u_TMonBi"].stringValue
        let u_Mustpay = data["u_Mustpay"].stringValue
        let applicationID = data["applicationID"].stringValue
        let contractNumber = data["contractNumber"].stringValue
        let gender = data["gender"].stringValue
        let dateofbirth = data["dateofbirth"].stringValue
        let cmnd = data["cmnd"].stringValue
        let downpayment = data["downpayment"].stringValue
        let schemeID = data["schemeID"].stringValue
        let tenure = data["tenure"].stringValue
        let schemeName = data["schemeName"].stringValue
        
        return DataOrder(soStatus: soStatus, docNum: docNum, docEntry: docEntry, u_CardCode: u_CardCode, u_EplCod: u_EplCod, u_CrDate: u_CrDate, u_Status: u_Status, u_Desc: u_Desc, u_INV_TYPE: u_INV_TYPE, u_ShipTyp: u_ShipTyp, u_ShpCod: u_ShpCod, u_CompCod: u_CompCod, u_CmpPrivate: u_CmpPrivate, u_UCode: u_UCode, u_Phone: u_Phone, u_LicTrad: u_LicTrad, u_Address1: u_Address1, u_CodeECom: u_CodeECom, u_SOType: u_SOType, isConfirm: isConfirm, u_PayOnline: u_PayOnline, u_TMonBi: u_TMonBi, u_Mustpay: u_Mustpay, applicationID: applicationID, contractNumber: contractNumber, gender: gender, dateofbirth: dateofbirth, cmnd: cmnd, downpayment: downpayment, schemeID: schemeID, tenure: tenure, schemeName: schemeName)
    }
    
    
    class func parseObjfromArray(array:[JSON])->[DataOrder]{
        var list:[DataOrder] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
}


class Messages: NSObject {
    var result : String
    var message : String
    
    init(result: String, message: String) {
        self.result = result
        self.message = message
    }
    
    class func getObjFromDictionary(data:JSON) -> Messages {
        let result = data["result"].stringValue
        let message = data["message"].stringValue
        
        return Messages(result: result, message: message)
    }
    
    class func parseObjfromArray(array:[JSON])->[Messages]{
        var list:[Messages] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
}

class CustomerOrder: NSObject {
    
    var data : [DataOrder]
    var messages : [Messages]
    
    init(data: [DataOrder], messages: [Messages]) {
        self.data = data
        self.messages = messages
    }
    
    class func getObjFromDictionary(data:JSON) -> CustomerOrder {
        let dataRes = data["data"].arrayValue
        let dataArr = DataOrder.parseObjfromArray(array: dataRes)
        
        let messageRes = data["messages"].arrayValue
        let messArr = Messages.parseObjfromArray(array: messageRes)
        
        return CustomerOrder(data: dataArr, messages: messArr)
    }
    
}

class CustomerOrderNew: NSObject {
    
    var IsSuccess: Bool
    var Message: String
    var Data: [OrderNewItem]
    
    init(IsSuccess: Bool, Message: String, Data: [OrderNewItem]) {
        self.IsSuccess = IsSuccess
        self.Message = Message
        self.Data = Data
    }
    
    class func getObjFromDictionary(data:JSON) -> CustomerOrderNew {
        let dataRes = data["Data"].arrayValue
        let dataArr = OrderNewItem.parseObjfromArray(array: dataRes)

        let messageRes = data["Message"].stringValue
        let isSUccess = data["IsSuccess"].boolValue
        return CustomerOrderNew(IsSuccess: isSUccess, Message: messageRes, Data: dataArr)
    }
    
}

class OrderNewItem: NSObject {
    var PosSoNum: String
    var CreatedDate: String
    var FullName: String
    var PhoneNumber: String
    var NationalIdNum: String
    var ContractNumber: String
    var ShipType: String
    var ApplicationId: String
    var SchemeCode: String
    var SchemeName: String
    var EcomNum: String
    
    init(PosSoNum: String, CreatedDate: String, FullName: String, PhoneNumber: String, NationalIdNum: String, ContractNumber: String, ShipType: String, ApplicationId: String, SchemeCode: String, SchemeName: String, EcomNum: String) {
        self.PosSoNum = PosSoNum
        self.CreatedDate = CreatedDate
        self.FullName = FullName
        self.PhoneNumber = PhoneNumber
        self.NationalIdNum = NationalIdNum
        self.ContractNumber = ContractNumber
        self.ShipType = ShipType
        self.ApplicationId = ApplicationId
        self.SchemeCode = SchemeCode
        self.SchemeName = SchemeName
        self.EcomNum = EcomNum
    }
    
    
    class func getObjFromDictionary(data:JSON) -> OrderNewItem {
       
        let PosSoNum = data["PosSoNum"].stringValue
        let CreatedDate = data["CreatedDate"].stringValue
        let FullName = data["FullName"].stringValue
        let PhoneNumber = data["PhoneNumber"].stringValue
        let NationalIdNum = data["NationalIdNum"].stringValue
        let ContractNumber = data["ContractNumber"].stringValue
        let ShipType = data["ShipType"].stringValue
        let ApplicationId = data["ApplicationId"].stringValue
        let SchemeCode = data["SchemeCode"].stringValue
        let SchemeName = data["SchemeName"].stringValue
        let EcomNum = data["EcomNum"].stringValue
        return OrderNewItem(PosSoNum: PosSoNum, CreatedDate: CreatedDate, FullName: FullName
                            , PhoneNumber: PhoneNumber, NationalIdNum: NationalIdNum, ContractNumber: ContractNumber, ShipType: ShipType, ApplicationId: ApplicationId, SchemeCode: SchemeCode, SchemeName: SchemeName, EcomNum: EcomNum)
    }
    
    class func parseObjfromArray(array:[JSON])->[OrderNewItem]{
        var list:[OrderNewItem] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
}

// OnlineInstallmentOrderDetail


class InstallmentOrderData : NSObject {
    
    var header : InstallmentHeader
    var customer : InstallmentCustomer
    var product : InstallmentProduct
    var promotions : [InstallmentPromotions]
    var payment : InstallmentPayment
    var otherInfos : InstallmentOtherInfos
    var Buttons: ButotnInfo
    
    init(header: InstallmentHeader, customer: InstallmentCustomer, product: InstallmentProduct, promotions: [InstallmentPromotions], payment: InstallmentPayment, otherInfos: InstallmentOtherInfos,Buttons: ButotnInfo ) {
        self.header = header
        self.customer = customer
        self.product = product
        self.promotions = promotions
        self.payment = payment
        self.otherInfos = otherInfos
        self.Buttons = Buttons
    }

    class func getObjFromDictionary(map:JSON) -> InstallmentOrderData {
        
        let header = InstallmentHeader.getObjFromDictionary(map: map["Header"])
        let customer = InstallmentCustomer.getObjFromDictionary(map: map["Customer"])
        let product = InstallmentProduct.getObjFromDictionary(map: map["Product"])
        let promotions = InstallmentPromotions.parseObjfromArray(array: map["Promotions"].arrayValue)
        let payment = InstallmentPayment.getObjFromDictionary(map: map["Payment"])
        let otherInfos = InstallmentOtherInfos.getObjFromDictionary(map: map["OtherInfos"])
        let buttons = ButotnInfo.getObjFromDictionary(map: map["Buttons"])
        
        return InstallmentOrderData(header: header, customer: customer, product: product, promotions: promotions, payment: payment, otherInfos: otherInfos, Buttons: buttons)
    }
    
    var realPrice: Double {
        return product.price * Double((1 + (Double(otherInfos.taxRate) / 100.0)))
    }
    
    func parseXMLPromotion(productCode: String, discount: Double) -> String{
        var rs:String = "<line>"
        for item in promotions {
            
            var tenSanPham_Tang = item.itemName
            tenSanPham_Tang = tenSanPham_Tang.replace(target: "&", withString:"&#38;")
            tenSanPham_Tang = tenSanPham_Tang.replace(target: "<", withString:"&#60;")
            tenSanPham_Tang = tenSanPham_Tang.replace(target: ">", withString:"&#62;")
            tenSanPham_Tang = tenSanPham_Tang.replace(target: "\"", withString:"&#34;")
            tenSanPham_Tang = tenSanPham_Tang.replace(target: "'", withString:"&#39;")
            
            rs = rs + "<item SanPham_Mua=\"\(productCode)\" TienGiam=\"\(String(format: "%.6f", discount))\" LoaiKM=\"\" SanPham_Tang=\"\(item.itemCode)\" TenSanPham_Tang=\"\(tenSanPham_Tang)\" SL_Tang=\"\(item.quantity)\" Nhom=\"\" MaCTKM=\"\" TenCTKM=\"\"/>"
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
    
    class func parseObjfromArray(array:[JSON])->[InstallmentOrderData]{
        var list:[InstallmentOrderData] = []
        for item in array {
            list.append(self.getObjFromDictionary(map: item))
        }
        return list
    }

}

class ButotnInfo : NSObject {
    
    var UpdateImeiBtn: Bool
    var CheckEkycBtn: Bool
    var CancelBtn: Bool
    var HomeEkycBtn: Bool
    
    init(UpdateImeiBtn: Bool, CheckEkycBtn: Bool, CancelBtn: Bool, HomeEkycBtn: Bool) {
        self.UpdateImeiBtn = UpdateImeiBtn
        self.CheckEkycBtn = CheckEkycBtn
        self.CancelBtn = CancelBtn
        self.HomeEkycBtn = HomeEkycBtn
    }


    class func getObjFromDictionary(map:JSON) -> ButotnInfo {

        let UpdateImeiBtn = map["UpdateImeiBtn"].boolValue
        let CheckEkycBtn = map["CheckEkycBtn"].boolValue
        let CancelBtn = map["CancelBtn"].boolValue
        let HomeEkycBtn = map["HomeEkycBtn"].boolValue
        
        return ButotnInfo(UpdateImeiBtn: UpdateImeiBtn, CheckEkycBtn: CheckEkycBtn, CancelBtn: CancelBtn,HomeEkycBtn:HomeEkycBtn)
    }
}

class InstallmentOtherInfos : NSObject {
    
    var docEntry : Int
    var contractStatus : String
    var DocStatus : String
    var createdBy : String
    var shopCode : String
    var schemeCode : String
    var applicationId : String
    var soNumber : String
    var taxRate : Int
    var cancelReason : String
    var IsImeiUpdated: Bool
    var IsEkycChecked: Bool
    var IsDelivered: Bool
    var MposSoNum:String
    var PosSoNum: String
    var EcomNum: String
    
    
    init(docEntry: Int, contractStatus: String,DocStatus : String, createdBy: String, shopCode: String, schemeCode: String, applicationId: String, soNumber: String, taxRate: Int, cancelReason: String, IsImeiUpdated: Bool, IsEkycChecked: Bool, IsDelivered: Bool, MposSoNum: String, PosSoNum: String, EcomNum: String) {
        self.docEntry = docEntry
        self.contractStatus = contractStatus
        self.createdBy = createdBy
        self.shopCode = shopCode
        self.schemeCode = schemeCode
        self.applicationId = applicationId
        self.soNumber = soNumber
        self.taxRate = taxRate
        self.cancelReason = cancelReason
        self.IsImeiUpdated = IsImeiUpdated
        self.IsEkycChecked = IsEkycChecked
        self.IsDelivered = IsDelivered
        self.MposSoNum = MposSoNum
        self.PosSoNum = PosSoNum
        self.EcomNum = EcomNum
        self.DocStatus = DocStatus
    }


    class func getObjFromDictionary(map:JSON) -> InstallmentOtherInfos {

        let docEntry = map["DocEntry"].intValue
        let contractStatus = map["ContractStatus"].stringValue
        let createdBy = map["CreatedBy"].stringValue
        let shopCode = map["ShopCode"].stringValue
        let schemeCode = map["SchemeCode"].stringValue
        let applicationId = map["ApplicationId"].stringValue
        let soNumber = map["SoNumber"].stringValue
        let taxRate = map["TaxRate"].intValue
        let cancelReason = map["CancelReason"].stringValue
        
        let IsImeiUpdated = map["IsImeiUpdated"].boolValue
        let IsEkycChecked = map["IsEkycChecked"].boolValue
        let IsDelivered = map["IsDelivered"].boolValue
        
        let MposSoNum = map["MposSoNum"].stringValue
        let PosSoNum = map["PosSoNum"].stringValue
        let EcomNum = map["EcomNum"].stringValue
        let DocStatus = map["DocStatus"].stringValue
        
        return InstallmentOtherInfos(docEntry: docEntry, contractStatus: contractStatus, DocStatus: DocStatus
                          , createdBy: createdBy, shopCode: shopCode, schemeCode: schemeCode, applicationId: applicationId, soNumber: soNumber, taxRate: taxRate
                                     , cancelReason: cancelReason,IsImeiUpdated: IsImeiUpdated,IsEkycChecked: IsEkycChecked,IsDelivered: IsDelivered, MposSoNum: MposSoNum,PosSoNum: PosSoNum, EcomNum: EcomNum)
    }
}

class InstallmentHeader : NSObject {
    
    var contractNumber : String
    var createdDate : String
    var shipType : String
    var ApplicationId: String
    
    init(contractNumber: String, createdDate: String, shipType: String,ApplicationId: String) {
        self.contractNumber = contractNumber
        self.createdDate = createdDate
        self.shipType = shipType
        self.ApplicationId = ApplicationId
    }

    class func getObjFromDictionary(map:JSON) -> InstallmentHeader {
        let contractNumber = map["ContractNumber"].stringValue
        let createdDate = map["CreatedDate"].stringValue
        let shipType = map["ShipType"].stringValue
        let ApplicationId = map["ApplicationId"].stringValue
        return InstallmentHeader(contractNumber: contractNumber, createdDate: createdDate, shipType: shipType, ApplicationId: ApplicationId)
    }

}

class InstallmentProduct : NSObject {
    
    var name : String
    var imei : String
    var price : Double
    var code : String
    var quantity: Int
    
    init(name: String, imei: String, price: Double,code : String, quantity: Int) {
       self.name = name
       self.imei = imei
       self.price = price
        self.code = code
        self.quantity = quantity
   }

    class func getObjFromDictionary(map:JSON) -> InstallmentProduct {
        let name = map["Name"].stringValue
        let imei = map["Imei"].stringValue
        let price = map["Price"].doubleValue
        let code = map["Code"].stringValue
        let quantity = map["Quantity"].intValue
        return InstallmentProduct(name: name, imei: imei, price: price,code: code, quantity: quantity)
    }
    
    func parseXMLProduct(phone:String, imeiS: String = "") -> String{
        
        let imeidetail = imeiS == "" ? imei : imeiS
        var rs:String = "<line>"
        var aName = self.name
        aName = aName.replace(target: "&", withString:"&#38;")
        aName = aName.replace(target: "<", withString:"&#60;")
        aName = aName.replace(target: ">", withString:"&#62;")
        aName = aName.replace(target: "\"", withString:"&#34;")
        aName = aName.replace(target: "'", withString:"&#39;")
            
            rs = rs + "<item U_ItmCod=\"\(code)\" U_Imei=\"\(imeidetail)\" U_Quantity=\"\(quantity)\" PhoneNumber=\"\(phone)\" Warr_imei=\"\"  U_Price=\"\(String(format: "%.6f", price))\" U_WhsCod=\"\(Cache.user!.ShopCode)\" U_ItmName=\"\(aName)\"/>"
        
        rs = rs + "</line>"
        print(rs)
        return rs
    }

}

class InstallmentPayment : NSObject {
    
    var schemeName : String
    var tenure : Int
    var downPayment : Int
    var total : Double
    var discount : Double
    var InterestRate : Double
    var LoanAmount : Double
    
    
    init(schemeName: String, tenure: Int, downPayment: Int, total: Double, discount: Double,InterestRate: Double,LoanAmount: Double) {
       self.schemeName = schemeName
       self.tenure = tenure
       self.downPayment = downPayment
       self.total = total
       self.discount = discount
       self.InterestRate = InterestRate
        self.LoanAmount = LoanAmount
   }

    
    class func getObjFromDictionary(map:JSON) -> InstallmentPayment {
        let schemeName = map["SchemeName"].stringValue
        let tenure = map["Tenure"].intValue
        let downPayment = map["DownPayment"].intValue
        let total = map["Total"].doubleValue
        let discount = map["Discount"].doubleValue
        let InterestRate = map["InterestRate"].doubleValue
        let LoanAmount = map["LoanAmount"].doubleValue
        
        
        return InstallmentPayment(schemeName: schemeName, tenure: tenure, downPayment: downPayment, total: total, discount: discount,InterestRate: InterestRate,LoanAmount: LoanAmount)
    }

}

class InstallmentPromotions : NSObject {
    
    var itemCode : String
    var itemName : String
    var quantity : String
    
    init(itemCode: String, itemName: String, quantity: String) {
        self.itemCode = itemCode
        self.itemName = itemName
        self.quantity = quantity
    }

    class func getObjFromDictionary(map:JSON) -> InstallmentPromotions {
        let itemCode = map["ItemCode"].stringValue
        let itemName = map["ItemName"].stringValue
        let quantity = map["Quantity"].stringValue
        return InstallmentPromotions(itemCode: itemCode, itemName: itemName, quantity: quantity)
    }
    
    class func parseObjfromArray(array:[JSON])->[InstallmentPromotions]{
        var list:[InstallmentPromotions] = []
        for item in array {
            list.append(self.getObjFromDictionary(map: item))
        }
        return list
    }

}

class InstallmentCustomer : NSObject {
    
    var phoneNumber : String
    var cMND : String
    var fullName : String
    var address : String
    
    init(phoneNumber: String, cMND: String, fullName: String, address: String) {
        self.phoneNumber = phoneNumber
        self.cMND = cMND
        self.fullName = fullName
        self.address = address
    }

    class func getObjFromDictionary(map:JSON) -> InstallmentCustomer {

        let phoneNumber = map["PhoneNumber"].stringValue
        let cMND = map["CMND"].stringValue
        let fullName = map["FullName"].stringValue
        let address = map["Address"].stringValue
        return InstallmentCustomer(phoneNumber: phoneNumber, cMND: cMND, fullName: fullName, address: address)
    }

}

class InstallmentOrderDetailBase : NSObject {
    
    var isSuccess : Bool
    var message : String
    var data : InstallmentOrderData
    
    init(isSuccess: Bool, message: String, data: InstallmentOrderData) {
        self.isSuccess = isSuccess
        self.message = message
        self.data = data
    }

    class func getObjFromDictionary(map:JSON) -> InstallmentOrderDetailBase {
        let isSuccess = map["IsSuccess"].boolValue
        let message = map["Message"].stringValue
        let data = InstallmentOrderData.getObjFromDictionary(map: map["Data"])
        return InstallmentOrderDetailBase(isSuccess: isSuccess, message: message, data: data)
    }

}

// upload imeiModel

class InstallmentBaseResponse: NSObject {
    var isSuccess : Bool
    var message : String
    var data: [InstallmentOrderData]
    
    init(isSuccess: Bool, message: String, data: [InstallmentOrderData]) {
        self.isSuccess = isSuccess
        self.message = message
        self.data = data
    }
    
    class func getObjFromDictionary(map:JSON) -> InstallmentBaseResponse {
        let isSuccess = map["IsSuccess"].boolValue
        let message = map["Message"].stringValue
        let data = InstallmentOrderData.parseObjfromArray(array: map["Data"].arrayValue)
        return InstallmentBaseResponse(isSuccess: isSuccess, message: message,data: data)
    }
}

// Installment History

class HistoryIsdetailBase: NSObject {
    
    var isSuccess : Bool
    var message : String
    var data : [HistoryIsdetailData]
    
    init(isSuccess: Bool, message: String, data: [HistoryIsdetailData]) {
        self.isSuccess = isSuccess
        self.message = message
        self.data = data
    }


    class func getObjFromDictionary(map:JSON) -> HistoryIsdetailBase {
        let isSuccess = map["IsSuccess"].boolValue
        let message = map["Message"].stringValue
        let data = HistoryIsdetailData.parseObjfromArray(array: map["Data"].arrayValue)
        
        return HistoryIsdetailBase(isSuccess: isSuccess, message: message, data: data)
    }

}

class HistoryIsdetailData : NSObject {
    
    var docEntry : Int
    var soNumber : String
    var createdDate : String
    var fullName : String
    var phoneNumber : String
    var nationalIdNum : String
    var contractNumber : String
    var shipType : String
    var contractStatus : String
    var imei : String
    var applicationId : String
    var DocStatus: String
    var IsImeiUpdated: Bool
    var ShipTypeString: String
    var DocStatusString: String
    var ImeiStatus: String
    
    init(docEntry: Int, soNumber: String, createdDate: String, fullName: String, phoneNumber: String, nationalIdNum: String, contractNumber: String, shipType: String, contractStatus: String, imei: String, applicationId: String,DocStatus: String,IsImeiUpdated: Bool,ShipTypeString: String,DocStatusString: String, ImeiStatus: String) {
        self.docEntry = docEntry
        self.soNumber = soNumber
        self.createdDate = createdDate
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        self.nationalIdNum = nationalIdNum
        self.contractNumber = contractNumber
        self.shipType = shipType
        self.contractStatus = contractStatus
        self.imei = imei
        self.applicationId = applicationId
        self.DocStatus = DocStatus
        self.IsImeiUpdated = IsImeiUpdated
        self.ShipTypeString = ShipTypeString
        self.DocStatusString = DocStatusString
        self.ImeiStatus = ImeiStatus
    }

    class func getObjFromDictionary(map:JSON) -> HistoryIsdetailData {

        let docEntry = map["DocEntry"].intValue
        let soNumber = map["PosSoNum"].stringValue
        let createdDate = map["CreatedDate"].stringValue
        let fullName = map["FullName"].stringValue
        let phoneNumber = map["PhoneNumber"].stringValue
        let nationalIdNum = map["NationalIdNum"].stringValue
        let contractNumber = map["ContractNumber"].stringValue
        let shipType = map["ShipType"].stringValue
        let contractStatus = map["ContractStatus"].stringValue
        let imei = map["Imei"].stringValue
        let applicationId = map["ApplicationId"].stringValue
        
        let DocStatus = map["DocStatus"].stringValue
        let IsImeiUpdated = map["IsImeiUpdated"].boolValue
        let ShipTypeString = map["ShipTypeString"].stringValue
        let DocStatusString = map["DocStatusString"].stringValue
        let ImeiStatus = map["ImeiStatus"].stringValue
        
        return HistoryIsdetailData(docEntry: docEntry, soNumber: soNumber, createdDate: createdDate, fullName: fullName, phoneNumber: phoneNumber, nationalIdNum: nationalIdNum, contractNumber: contractNumber, shipType: shipType, contractStatus: contractStatus, imei: imei, applicationId: applicationId, DocStatus: DocStatus, IsImeiUpdated: IsImeiUpdated,ShipTypeString: ShipTypeString,DocStatusString: DocStatusString, ImeiStatus: ImeiStatus)
    }
    
    class func parseObjfromArray(array:[JSON])->[HistoryIsdetailData]{
        var list:[HistoryIsdetailData] = []
        for item in array {
            list.append(self.getObjFromDictionary(map: item))
        }
        return list
    }

}


extension String {
    func toNewStrDate(withFormat format: String = "MM/dd/yyyy HH:mm:ss", newFormat: String = "dd/MM/yyyy HH:mm") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        let resultFormat = DateFormatter()
        resultFormat.dateFormat = newFormat
        if let aDate = date {
            let str = resultFormat.string(from: aDate)
            return str
        } else {
            return self
        }
    }
}
