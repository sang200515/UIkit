//
//  MPOSAPIManager.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import Alamofire
import KeychainSwift
import SwiftyBeaver

public class MPOSAPIManager{

    class func FRT_SP_mpos_loadSPTraGop(MaSP:String,DonGia:String,handler: @escaping (_ success:[SPTraGop],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        var rs:[SPTraGop] = []
        provider.request(.FRT_SP_mpos_loadSPTraGop(MaSP:MaSP,DonGia:DonGia)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                log.debug(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = SPTraGop.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getAmortizationsDefinitions(itemCode:String,price:String,handler: @escaping (_ success:[AmortizationsDefinition],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[AmortizationsDefinition] = []
        provider.request(.getAmortizationsDefinitions(itemCode:itemCode,price:price)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                
                if let data = json?["getAmortizationsDefinitionsResult"].array {
                    rs = AmortizationsDefinition.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getAllAmortizationsProperties(handler: @escaping (_ success:[AmortizationsProperty],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[AmortizationsProperty] = []
        provider.request(.getAllAmortizationsProperties){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                
                if let data = json?["getAllAmortizationsPropertiesResult"].array {
                    rs = AmortizationsProperty.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getAllAmortizationsPrePays(handler: @escaping (_ success:[AmortizationsPrePay],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[AmortizationsPrePay] = []
        provider.request(.getAllAmortizationsPrePays){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                
                if let data = json?["getAllAmortizationsPrePaysResult"].array {
                    rs = AmortizationsPrePay.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getAllAmortizationsTerms(handler: @escaping (_ success:[AmortizationsTerm],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[AmortizationsTerm] = []
        provider.request(.getAllAmortizationsTerms){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                if let data = json["getAllAmortizationsTermsResult"].array {
                    rs = AmortizationsTerm.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getAmortizationsDefinitionsDetail(itemCode:String,price:String,proID:String,prePayID:String,termID:String,handler: @escaping (_ success:[AmortizationsDefinition],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[AmortizationsDefinition] = []
        provider.request(.getAmortizationsDefinitionsDetail(itemCode:itemCode,price:price,proID:proID,prePayID:prePayID,termID:termID)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let data = json["getAmortizationsDefinitionsDetailResult"].array {
                    rs = AmortizationsDefinition.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func checkInventory(shopCode:String,itemCode:String,handler: @escaping (_ success:[Inventory],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[Inventory] = []
        provider.request(.checkInventory(shopCode:shopCode,itemCode:itemCode)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                
                if let data = json?["checkInventory_V3Result"].array {
                    rs = Inventory.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getTonKhoShopGanNhat(listsp:String,shopCode:String,handler: @escaping (_ success:[ShopInventory],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[ShopInventory] = []
        provider.request(.getTonKhoShopGanNhat(listsp:listsp,shopCode:shopCode)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = ShopInventory.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getListImeiBook(itemCode:String,handler: @escaping (_ success:[ImeiBook],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[ImeiBook] = []
        provider.request(.getListImeiBook(itemCode:itemCode)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = ImeiBook.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getVendorInstallment(handler: @escaping (_ success:[VendorInstallment],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[VendorInstallment] = []
        provider.request(.getVendorInstallment){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = VendorInstallment.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func loadDebitCustomer(phone:String,handler: @escaping (_ success:[DebitCustomer],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[DebitCustomer] = []
        provider.request(.loadDebitCustomer(phone:phone)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = DebitCustomer.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func checkVoucherKMBookSim(sdt:String,xmlvoucher:String,handler: @escaping (_ success:CheckVCKM?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:CheckVCKM?
        provider.request(.checkVoucherKMBookSim(sdt:sdt,xmlvoucher:xmlvoucher)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    let message = json["Message"].stringValue
                    if(success){
                        rs = CheckVCKM.getObjFromDictionary(data: json)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func checkPromotionNew(u_CrdCod:String,sdt:String,LoaiDonHang:String,LoaiTraGop:String,LaiSuat:Float,SoTienTraTruoc:Float,voucher:String,kyhan:String,U_cardcode:String,HDNum:String,is_KHRotTG:Int,is_DH_DuAn:String,handler: @escaping (_ success:Promotion?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var param:Dictionary = Dictionary<String, Any>()
        var xml = "<line>"
        for item in Cache.carts{
            var whsCod = "\(Cache.user!.ShopCode)010"
            if(item.whsCode.count > 0){
                whsCod = item.whsCode
            }
            var imei = item.imei
            if(imei == "N/A"){
                imei = ""
            }
            //            xml  = xml + "<item U_ItmCod=\"\(item.product.sku)\" U_Imei=\"\(imei)\" U_Quantity=\"\(item.quantity)\" U_PriceBT=\"\(String(format: "%.6f", item.product.priceBeforeTax))\" U_Price=\"\(String(format: "%.6f", item.product.price))\" U_WhsCod=\"\(whsCod)\" Discount=\"\(String(describing: item.discount))\" Reason=\"\(item.reason)\" userapprove=\"\(item.userapprove)\"/>"
            xml  = xml + "<item U_ItmCod=\"\(item.sku)\" U_Imei=\"\(imei)\" U_Quantity=\"\(item.quantity)\" U_PriceBT=\"\(String(format: "%.6f", item.product.priceBeforeTax))\" U_Price=\"\(String(format: "%.6f", item.product.price))\" U_WhsCod=\"\(whsCod)\" Discount=\"\(String(describing: item.discount))\" Reason=\"\(item.reason)\" userapprove=\"\(item.userapprove)\"/>"
        }
        xml = xml + "</line>"
        var loaiGop = LoaiTraGop
        if (loaiGop == "-1"){
            loaiGop = "0"
        }
        
        
        param.updateValue(u_CrdCod, forKey: "u_CrdCod")
        param.updateValue(xml, forKey: "itemsInXML")
        param.updateValue(sdt, forKey: "sdt")
        param.updateValue(LoaiDonHang, forKey: "LoaiDonHang")
        param.updateValue(loaiGop, forKey: "LoaiTraGop")
        param.updateValue("\(String(format: "%.6f", LaiSuat))", forKey: "LaiSuat")
        param.updateValue("\(String(format: "%.6f", SoTienTraTruoc))", forKey: "SoTienTraTruoc")
        param.updateValue(voucher, forKey: "voucher")
        param.updateValue("0", forKey: "idCardCodeFriend")
        param.updateValue(kyhan, forKey: "kyhan")
        param.updateValue(HDNum, forKey: "HDNum")
        param.updateValue(U_cardcode, forKey: "U_cardcode")
        param.updateValue("\(Cache.user!.UserName)", forKey: "UserID")
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        param.updateValue("\(crm ?? "")", forKey: "CRMCode")
        param.updateValue("\(Cache.user!.Token)", forKey: "Token")
        param.updateValue("\(is_KHRotTG)", forKey: "is_KHRotTG")
        param.updateValue("\(is_DH_DuAn)", forKey: "is_DH_DuAn")
        param.updateValue(Cache.type_so, forKey: "type_so")
        param.updateValue("\(Cache.DocEntryEcomCache)", forKey: "Docentry")
        
        debugPrint(param)
        var promotion:Promotion? = nil
        provider.request(.checkPromotionNew(param:param)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        let data = json!["Data"]
                        if(!data.isEmpty){
                            let returnMessage = data["ReturnMessage"]
                            if(!returnMessage.isEmpty){
                                let p_status = returnMessage["p_status"].boolValue
                                let p_messagess = returnMessage["p_messagess"].stringValue
                                let khoanvay = returnMessage["khoanvay"].intValue
                                //let codevnpay = returnMessage["codevnpay"].stringValue
                                Cache.khoanvay = khoanvay
                                //Cache.codevnpay = codevnpay
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                if(p_status){
                                    promotion = Promotion.getObjFromDictionary(data: data)
                                    handler(promotion,"")
                                }else{
                                    handler(promotion,p_messagess)
                                }
                            }else{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(promotion,"Kiểm tra khuyến mại thất bại!")
                            }
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(promotion,"Kiểm tra khuyến mại thất bại!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(promotion,"Kiểm tra khuyến mại thất bại!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(promotion,"Kiểm tra khuyến mại thất bại!")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(promotion,error.localizedDescription)
            }
        }
    }
    class func searchCustomersToshiba(phoneNumber:String,handler: @escaping (_ success:[CustomerToshiba],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[CustomerToshiba] = []
        provider.request(.searchCustomersToshiba(phoneNumber:phoneNumber)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = CustomerToshiba.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getToshibaPoint(idCardPoint:String,handler: @escaping (_ success:ToshibaPoint?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.getToshibaPoint(idCardPoint:idCardPoint)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        if(!data.isEmpty){
                            let rs = ToshibaPoint.getObjFromDictionary(data: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(nil,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func getImei(productCode:String,shopCode:String,handler: @escaping (_ success:[Imei],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[Imei] = []
        provider.request(.getImei(productCode:productCode,shopCode:shopCode)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let data = json["getImei_V3Result"].array {
                    rs = Imei.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func removeSO(docEntry:String,handler: @escaping (_ success:Int,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.removeSO(docEntry:docEntry)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        var returnCode = json["Result"].int
                        var returnMessage = json["Message"].string
                        
                        returnCode = returnCode == nil ? 3 : returnCode
                        returnMessage = returnMessage == nil ? "" : returnMessage
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(returnCode!,returnMessage!)
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(3,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(3,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(3,error.localizedDescription)
            }
        }
    }
    
    class func saveOrder(phone:String,cardName:String,doctype:String,u_EplCod:String,shopCode:String,payments:String,mail:String,address:String,u_des:String,rDR1:String,pROMOS:String,LoaiTraGop:String,LaiSuat:Float,SoTienTraTruoc:Float,voucher:String,gender:String,birthday:String,soHDtragop:String,kyhan:String,CMND:String,TenCTyTraGop:String,is_KHRotTG:Int,xmlspGiamGiaTay:String,xmlstringpay:String,xmlVoucherDH:String,xml_url_pk:String,is_DH_DuAn:String,is_sale_MDMH: String,is_sale_software:String,handler: @escaping (_ result:Int,_ docentry:Int,_ So_HD:String, _ path: String,_ err: String) ->Void){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        var param:Dictionary = Dictionary<String, Any>()
        
        
        param.updateValue(phone, forKey: "phone")
        param.updateValue(cardName, forKey: "CardName")
        param.updateValue(doctype, forKey: "Doctype")
        param.updateValue(u_EplCod, forKey: "U_EplCod")
        param.updateValue(shopCode, forKey: "ShopCode")
        param.updateValue(payments, forKey: "payments")
        param.updateValue(mail, forKey: "Mail")
        param.updateValue(address, forKey: "Address")
        param.updateValue(u_des, forKey: "U_des")
        param.updateValue(rDR1, forKey: "RDR1")
        param.updateValue(pROMOS, forKey: "PROMOS")
        param.updateValue(LoaiTraGop, forKey: "LoaiTraGop")
        
        param.updateValue("\(String(format: "%.6f", LaiSuat))", forKey: "LaiSuat")
        param.updateValue("\(String(format: "%.6f", SoTienTraTruoc))", forKey: "SoTienTraTruoc")
        param.updateValue(voucher, forKey: "voucher")
        param.updateValue("2", forKey: "DiviceType")
        param.updateValue(gender, forKey: "gioitinh")
        param.updateValue(birthday, forKey: "NgaySinh")
        
        param.updateValue(soHDtragop, forKey: "soHDtragop")
        param.updateValue(kyhan, forKey: "kyhan")
        param.updateValue(CMND, forKey: "CMND")
        param.updateValue(TenCTyTraGop, forKey: "TenCTyTraGop")
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        param.updateValue("\(crm ?? "")", forKey: "CRMCode")
        param.updateValue("\(Cache.user!.Token)", forKey: "Token")
        param.updateValue(Cache.DocEntryEcomCache, forKey: "pre_docentry")
        param.updateValue(is_KHRotTG, forKey: "is_KHRotTG")
        param.updateValue(xmlspGiamGiaTay, forKey: "xmlspGiamGiaTay")
        param.updateValue(xmlstringpay, forKey: "xmlstringpay")
        param.updateValue(xmlVoucherDH, forKey: "xmlVoucherDH")
        param.updateValue(Cache.DocEntryEcomCache, forKey: "pre_docentry")
        param.updateValue("\(Cache.is_samsung)", forKey: "is_samsung")
        param.updateValue(xml_url_pk, forKey: "xml_url_pk")
        param.updateValue(is_DH_DuAn, forKey: "is_DH_DuAn")
        param.updateValue(is_sale_MDMH, forKey: "is_sale_MDMH")
        param.updateValue(is_sale_software, forKey: "is_sale_software")
        param.updateValue("\(Cache.codePayment)", forKey: "cardcode")
        log.debug(param)
        provider.request(.saveOrder(param:param)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        if(!data.isEmpty){
                            
                            var returnCode = data["ReturnCode"].int
                            var docentry = data["Docentry"].int
                            var returnMessage = data["ReturnMessage"].string
                            var so_HD = data["So_HD"].string
                            var path = data["Path"].string
                            
                            returnCode = returnCode == nil ? 3 : returnCode
                            docentry = docentry == nil ? 0 : docentry
                            returnMessage = returnMessage == nil ? "" : returnMessage
                            so_HD = so_HD == nil ? "" : so_HD
                            path = path == nil ? "" : path
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(returnCode!,docentry!,so_HD!, path!,returnMessage!)
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(3,0,"", "","Không thể lưu đơn hàng!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(3,0,"", "","Không thể lưu đơn hàng!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(3,0,"", "","Không thể lưu đơn hàng!")
                }
            case .failure:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(3,0,"", "","Không thể lưu đơn hàng!")
            }
        }
    }
    
    class func getPriceDatCoc(rdr1: String, handler: @escaping (_ price: Int,_ err: String) ->Void){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        var param:Dictionary = Dictionary<String, Any>()
        param.updateValue(rdr1, forKey: "RDR1")
        param.updateValue(Cache.user!.UserName, forKey: "usercode")
        param.updateValue(Cache.user!.ShopCode, forKey: "shopcode")
        
        provider.request(.getPriceDatCoc(param:param)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                if let price = json["price"].int {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(price, "")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"Không thể lấy giá đặt cọc!")
                }
            case .failure:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"Không thể lấy giá đặt cọc!")
            }
        }
    }
    
    class func getListLoaiSimV2(itemCode:String,handler: @escaping (_ success:[LoaiSimV2],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[LoaiSimV2] = []
        provider.request(.getListLoaiSimV2(itemCode: itemCode)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = LoaiSimV2.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getSearchSimV2(NhaMang:String,ProductID:String,SimType:String,Random:String,ProductCode:String,handler: @escaping (_ success:[SimV2],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[SimV2] = []
        
        var param:Dictionary = Dictionary<String, Any>()
        
        param.updateValue("\(Cache.user!.ShopCode)", forKey: "WarehouseCode")
        param.updateValue("\(Cache.user!.UserName)", forKey: "employeeCode")
        param.updateValue(NhaMang, forKey: "Provider")
        param.updateValue(ProductID, forKey: "ProductID")
        param.updateValue(SimType, forKey: "SimType")
        param.updateValue(Random, forKey: "Random")
        param.updateValue(ProductCode, forKey: "ProductCode")
        print(param)
        
        provider.request(.getSearchSimV2(param:param)){ result in
            switch result {
            case let .success(moyaResponse):
                
                let data = moyaResponse.data
                
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json!["Data"].array {
                            
                            rs = SimV2.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func checkGoiCuocVaSim(ProductCode:String,PhoneNumber:String,xmlrdr1:String,handler: @escaping (_ success:[CheckGoiCuocVaSim],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[CheckGoiCuocVaSim] = []
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        var param:Dictionary = Dictionary<String, Any>()
        param.updateValue(ProductCode, forKey: "ProductCode")
        param.updateValue(PhoneNumber, forKey: "PhoneNumber")
        param.updateValue(xmlrdr1, forKey: "xmlrdr1")
        param.updateValue("\(Cache.user!.UserName)", forKey: "UserID")
        param.updateValue("\(Cache.user!.Token)", forKey: "Token")
        param.updateValue(crm ?? "", forKey: "CRMCode")
        
        provider.request(.checkGoiCuocVaSim(param:param)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = CheckGoiCuocVaSim.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        let data = json?["p_Message"].stringValue
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,data ?? "LOAD API ERROR !")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func dangKyBookSoV2(tenKH:String,NhaMang:String,phoneNumber:String,maGoiCuoc:String,tenGoiCuoc:String,giaGoiCuoc:Int,giaSim:Int,handler: @escaping (_ success:BookSoV2,_ IsLogin:String,_ p_Status:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        var param:Dictionary = Dictionary<String, Any>()
        
        param.updateValue(phoneNumber, forKey: "PhoneNumber")
        param.updateValue(NhaMang, forKey: "Provider")
        param.updateValue("\(Cache.user!.ShopCode)", forKey: "ShopCode")
        param.updateValue(maGoiCuoc, forKey: "MaGoiCuoc")
        param.updateValue(tenGoiCuoc, forKey: "TenGoiCuoc")
        param.updateValue("\(giaGoiCuoc)", forKey: "GiaGoiCuoc")
        param.updateValue(giaSim, forKey: "GiaSim")
        param.updateValue(tenKH, forKey: "CardName")
        param.updateValue("\(Cache.user!.UserName)", forKey: "UserID")
        param.updateValue("2", forKey: "DeviceType")
        param.updateValue("\(Cache.user!.Token)", forKey: "Token")
        param.updateValue(crm ?? "", forKey: "CRMCode")
        print(param)
        var dataBookSimV2:DataBookSimV2 = DataBookSimV2(CardName:""
            , GiaCuoc:0
            , IsSubsidy:0
            , MaGoiCuoc:""
            , Message:""
            , PackofData:""
            , PhoneNumber:""
            , Provider:""
            , Result:0
            , ShopCode:""
            , SoEcom:""
            , SoMpos:0
            , TenGoiCuoc:""
            , type:0)
        let bookSoV2:BookSoV2 = BookSoV2(Success: false, Result: "", Message: "",dataBookSimV2: dataBookSimV2)
        provider.request(.dangKyBookSoV2(param:param)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let success = json["Success"].boolValue
                let result = json["Result"].stringValue
                let message = json["Message"].stringValue
                let data1 = json["Data"].array
                
                let IsLogin = json["IsLogin"].stringValue
                let p_Status = json["p_Status"].stringValue
                let p_Message = json["p_Message"].stringValue
                
                if(IsLogin == "1"){
                    handler(bookSoV2,IsLogin,p_Status,p_Message)
                }else{
                    if(p_Status == "0"){
                        handler(bookSoV2,IsLogin,p_Status,p_Message)
                    }else{
                        if(data1!.count > 0){
                            dataBookSimV2 = DataBookSimV2.getObjFromDictionary(data: data1![0])
                            bookSoV2.Success = success
                            bookSoV2.Result = result
                            bookSoV2.Message = message
                            bookSoV2.dataBookSimV2 = dataBookSimV2
                            handler(bookSoV2,IsLogin,p_Status,"")
                        }else{
                            let p_Message = json["p_Message"].stringValue
                            handler(bookSoV2,IsLogin,p_Status,p_Message)
                        }
                        
                    }
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(bookSoV2,"0","1",error.localizedDescription)
            }
        }
    }
    class func getListSimBookByShopV2(sdt:String,handler: @escaping (_ success:[SimBookByShopV2],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[SimBookByShopV2] = []
        provider.request(.getListSimBookByShopV2(sdt:sdt)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = SimBookByShopV2.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func huyBookSoV2(phoneNumber:String,handler: @escaping (_ success:HuyBookSoV2?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let huySoV2:HuyBookSoV2 = HuyBookSoV2(Success: false, Result: "", Message: "")
        provider.request(.huyBookSoV2(phoneNumber:phoneNumber)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                let success = json["Success"].boolValue
                let result = json["Result"].stringValue
                let message = json["Message"].stringValue
                
                
                huySoV2.Success = success
                huySoV2.Result = result
                huySoV2.Message = message
                handler(huySoV2,"")
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(huySoV2,error.localizedDescription)
            }
        }
    }
    class func GetDistricts(MaCodeTinh:String,NhaMang:String,handler: @escaping (_ success:[District],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[District] = []
        provider.request(.GetDistricts(MaCodeTinh:MaCodeTinh,NhaMang:NhaMang)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = District.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func GetPrecincts(MaCodeHUyen:String,MaCodeTinh:String,NhaMang:String,handler: @escaping (_ success:[Precinct],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[Precinct] = []
        provider.request(.GetPrecincts(MaCodeHUyen:MaCodeHUyen,MaCodeTinh:MaCodeTinh,NhaMang:NhaMang)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = Precinct.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func SearchNationality(Nhamang:String,handler: @escaping (_ success:[National],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[National] = []
        provider.request(.SearchNationality(Nhamang:Nhamang)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = National.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func GetProvinces(NhaMang:String,handler: @escaping (_ success:[Province],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[Province] = []
        provider.request(.GetProvinces(NhaMang:NhaMang)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = Province.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getListCustomersViettel(idNo:String,handler: @escaping (_ success:[ClientViettel],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[ClientViettel] = []
        provider.request(.getListCustomersViettel(idNo:idNo)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = ClientViettel.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func checkGoiCuocVNMobile(phoneNumber:String,cmnd:String,productCode:String,goiCuoc:String,userId:String,maShop:String,nhaMang:String,handler: @escaping (_ success:Bool,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.checkGoiCuocVNMobile(phoneNumber:phoneNumber,cmnd:cmnd,productCode:productCode,goiCuoc:goiCuoc,userId:userId,maShop:maShop,nhaMang:nhaMang)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                let success = json["Success"].boolValue
                let data1 = json["Data"].stringValue
                
                handler(success,data1)
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(false,error.localizedDescription)
            }
        }
    }
    class func AutoCreateImageActiveSimViettelHD(p_MaKH:String,p_SoNha:String,p_Duong:String,p_Phuong:String,p_Quan:String,p_Tinh:String,p_QuocTich:String,ChuKy:String,p_SoPhieuYeuCau: String,p_TenKH:String,p_DT_LienHe_KH:String,p_NgaySinh_KH:String,p_GioiTinh_KH:String,p_SoCMND_KH:String,p_NoiCap_CMND_KH:String,p_NgayCap_CMND_KH:String,p_DiaChi_CMND_KH:String,p_GoiCuocDK_Line1:String,p_SoThueBao_Line1:String,p_SoSerialSim_Imei_Line1:String,p_Visa:String,handler: @escaping (_ success:SimAutoImage?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var param:Dictionary = Dictionary<String, Any>()
        
        param.updateValue(p_SoPhieuYeuCau, forKey: "p_SoPhieuYeuCau")
        param.updateValue(p_MaKH, forKey: "p_MaKH")
        param.updateValue(p_TenKH, forKey: "p_TenKH")
        param.updateValue(p_NgaySinh_KH, forKey: "p_NgaySinh_KH")
        param.updateValue(p_GioiTinh_KH, forKey: "p_GioiTinh_KH")
        param.updateValue(p_DT_LienHe_KH, forKey: "p_DT_LienHe_KH")
        param.updateValue(p_SoCMND_KH, forKey: "p_SoCMND_KH")
        param.updateValue(p_NoiCap_CMND_KH, forKey: "p_NoiCap_CMND_KH")
        param.updateValue(p_NgayCap_CMND_KH, forKey: "p_NgayCap_CMND_KH")
        param.updateValue(p_DiaChi_CMND_KH, forKey: "p_DiaChi_CMND_KH")
        
        param.updateValue(p_SoNha, forKey: "p_SoNha")
        param.updateValue(p_Duong, forKey: "p_Duong")
        param.updateValue(p_Phuong, forKey: "p_Phuong")
        param.updateValue(p_Quan, forKey: "p_Quan")
        param.updateValue(p_Tinh, forKey: "p_Tinh")
        param.updateValue(p_QuocTich, forKey: "p_QuocTich")
        
        param.updateValue(p_GoiCuocDK_Line1, forKey: "p_GoiCuocLine1")
        param.updateValue(p_SoThueBao_Line1, forKey: "p_SoThueBaoLine1")
        param.updateValue(p_SoSerialSim_Imei_Line1, forKey: "p_SoSerialSimLine1")
        param.updateValue("\(Cache.user!.ShopName)", forKey: "p_TenDiemDV")
        param.updateValue(p_Visa, forKey: "p_Visa")
        param.updateValue(ChuKy, forKey: "p_ChuKy")
        var imageInfo:SimAutoImage? = nil
        provider.request(.AutoCreateImageActiveSimViettelHD(param:param)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                let data1 = json["CustomerResult_HDViettelResult"]
                
                if(!data1.isEmpty){
                    imageInfo = SimAutoImage.getObjFromDictionary(data: data1)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(imageInfo,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(imageInfo,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(imageInfo,error.localizedDescription)
            }
        }
    }
    class func AutoCreateImageActiveSimVNPhone(p_HopDongSo:String,p_ShopDangKy: String,p_TenKH:String,p_SoDTLienHe:String,p_NgaySinh:String,p_GioiTinh:String,p_QuocTich:String,p_SoCMND:String,p_NgayCap:String,p_NoiCap:String,p_DiaChiThuongChu:String,p_SoThueBao_Line1:String,p_Serial_Line1:String,p_GoiCuoc_Line1:String,p_ChuKy:String,p_SoNha:String,p_Duong:String,p_To:String,p_Phuong:String, p_Quan: String, p_Tinh: String,p_Email:String,handler: @escaping (_ success:SimAutoImage?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var param:Dictionary = Dictionary<String, Any>()
        
        param.updateValue(p_Serial_Line1, forKey: "p_Serial_Line1")
        param.updateValue(p_GoiCuoc_Line1, forKey: "p_GoiCuoc_Line1")
        param.updateValue(p_ChuKy, forKey: "p_ChuKy")
        param.updateValue("\(Cache.user!.EmployeeName)", forKey: "p_NVGiaoDich")
        
        param.updateValue(p_QuocTich, forKey: "p_QuocTich")
        param.updateValue(p_SoCMND, forKey: "p_SoCMND")
        param.updateValue(p_NgayCap, forKey: "p_NgayCap")
        param.updateValue(p_NoiCap, forKey: "p_NoiCap")
        param.updateValue(p_DiaChiThuongChu, forKey: "p_DiaChiThuongChu")
        param.updateValue(p_SoThueBao_Line1, forKey: "p_SoThueBao_Line1")
        
        param.updateValue(p_HopDongSo, forKey: "p_HopDongSo")
        param.updateValue(p_ShopDangKy, forKey: "p_ShopDangKy")
        param.updateValue(p_TenKH, forKey: "p_TenKH")
        param.updateValue(p_SoDTLienHe, forKey: "p_SoDTLienHe")
        param.updateValue(p_NgaySinh, forKey: "p_NgaySinh")
        param.updateValue(p_GioiTinh, forKey: "p_GioiTinh")
        
        param.updateValue(p_SoNha, forKey: "p_SoNha")
        param.updateValue(p_Duong, forKey: "p_Duong")
        param.updateValue(p_To, forKey: "p_To")
        param.updateValue(p_Phuong, forKey: "p_Phuong")
        param.updateValue(p_Quan, forKey: "p_Quan")
        param.updateValue(p_Tinh, forKey: "p_Tinh")
        param.updateValue(p_Email, forKey: "p_Email")
        
        var imageInfo:SimAutoImage? = nil
        provider.request(.AutoCreateImageActiveSimVNPhone(param:param)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                let data1 = json["CustomerResult_HDVNPhoneResult"]
                
                if(!data1.isEmpty){
                    imageInfo = SimAutoImage.getObjFromDictionary(data: data1)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(imageInfo,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(imageInfo,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(imageInfo,error.localizedDescription)
            }
        }
    }
    class func AutoCreateImageActiveSimMobiPhone(p_HopDongSo:String,p_ShopDangKy: String,p_TenKH:String,p_SoDTLienHe:String,p_NgaySinh:String,p_GioiTinh:String,p_QuocGia:String,p_SoCMND:String,p_NgayCap:String,p_NoiCap:String,p_DiaChiThuongChu:String,p_SoThueBao_Line1:String,p_Serial_Line1:String,p_GoiCuoc_Line1:String,p_ChuKy:String,handler: @escaping (_ success:SimAutoImage?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var param:Dictionary = Dictionary<String, Any>()
        
        param.updateValue(p_HopDongSo, forKey: "p_HopDongSo")
        param.updateValue(p_ShopDangKy, forKey: "p_ShopDangKy")
        param.updateValue(p_TenKH, forKey: "p_TenKH")
        param.updateValue(p_SoDTLienHe, forKey: "p_SoDTLienHe")
        
        param.updateValue(p_NgaySinh, forKey: "p_NgaySinh")
        param.updateValue(p_GioiTinh, forKey: "p_GioiTinh")
        param.updateValue(p_QuocGia, forKey: "p_QuocGia")
        param.updateValue(p_SoCMND, forKey: "p_SoCMND")
        param.updateValue(p_NgayCap, forKey: "p_NgayCap")
        param.updateValue(p_NoiCap, forKey: "p_NoiCap")
        
        param.updateValue(p_DiaChiThuongChu, forKey: "p_DiaChiThuongChu")
        param.updateValue(p_SoThueBao_Line1, forKey: "p_SoThueBao_Line1")
        param.updateValue(p_Serial_Line1, forKey: "p_serial_line1")
        param.updateValue(p_GoiCuoc_Line1, forKey: "p_GoiCuoc_Line1")
        param.updateValue(p_ChuKy, forKey: "p_ChuKy")
        param.updateValue("\(Cache.user!.EmployeeName)", forKey: "p_NVGiaoDich")
        
        
        var imageInfo:SimAutoImage? = nil
        print(param)
        provider.request(.AutoCreateImageActiveSimMobiPhone(param:param)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                let data1 = json["CustomerResult_HDMobiPhoneResult"]
                
                if(!data1.isEmpty){
                    imageInfo = SimAutoImage.getObjFromDictionary(data: data1)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(imageInfo,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(imageInfo,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(imageInfo,error.localizedDescription)
            }
        }
    }
    class func AutoCreateImageActiveSimVietnamobile(p_HopDongSo:String,p_TenKH: String,p_CMND_KH:String,p_NgayCapCMND_KH:String,p_NoiCapCMND_KH:String,p_NgaySinh_KH:String,p_GioiTinh_KH:String,p_QuocGia_KH:String,p_NoiThuongTru_KH:String,p_ChuKy:String,p_SoThueBao_Line1:String,p_SoICCID_Line1:String,handler: @escaping (_ success:SimAutoImage?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var param:Dictionary = Dictionary<String, Any>()
        
        param.updateValue(p_HopDongSo, forKey: "p_HopDongSo")
        param.updateValue(p_TenKH, forKey: "p_TenKH")
        param.updateValue(p_CMND_KH, forKey: "p_CMND_KH")
        param.updateValue(p_NgayCapCMND_KH, forKey: "p_NgayCapCMND_KH")
        
        param.updateValue(p_NoiCapCMND_KH, forKey: "p_NoiCapCMND_KH")
        param.updateValue(p_NgaySinh_KH, forKey: "p_NgaySinh_KH")
        param.updateValue(p_GioiTinh_KH, forKey: "p_GioiTinh_KH")
        param.updateValue(p_QuocGia_KH, forKey: "p_QuocGia_KH")
        param.updateValue(p_NoiThuongTru_KH, forKey: "p_NoiThuongTru_KH")
        param.updateValue("\(Cache.user!.ShopCode)", forKey: "p_MaDiemGD")
        
        param.updateValue("\(Cache.user!.ShopName)", forKey: "p_TenDiemGiaoDich")
        param.updateValue("\(Cache.user!.EmployeeName)", forKey: "p_NVGiaoDich")
        param.updateValue("\(Cache.user!.ShopName)", forKey: "p_DCGiaoDich")
        param.updateValue(p_ChuKy, forKey: "p_ChuKy")
        param.updateValue(p_SoThueBao_Line1, forKey: "p_SoThueBao_Line1")
        param.updateValue(p_SoICCID_Line1, forKey: "p_SoICCID_Line1")
        
        
        var imageInfo:SimAutoImage? = nil
        provider.request(.AutoCreateImageActiveSimVietnamobile(param:param)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                let data1 = json["CustomerResult_HDVietNamMobileResult"]
                
                if(!data1.isEmpty){
                    imageInfo = SimAutoImage.getObjFromDictionary(data: data1)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(imageInfo,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(imageInfo,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(imageInfo,error.localizedDescription)
            }
        }
    }
    class func ActiveSim(Provider:String,Phonenumber: String,Imei:String,SeriSIM:String,IMSI:String,FullName:String,Birthday:String,Gender:String,Address:String,CMND:String,DateCreateCMND:String,PalaceCreateCMND:String,Nationality:String,ProvinceCode:String,DistrictCode:String,PrecinctCode:String,contractNo:String,Note:String,ShopCode:String,UserCode:String,Images:String,ID:String,GoiCuoc:String,ProductCode:String,LoaiGiayTo:String,Passport:String,DayGrantPassport:String,SOPOS:String,NgayHetHanGiayTo:String,TenShop:String,DiaChiShop:String,TenNhanVien:String,NoiCapPassport:String,SoVisa:String,CustId:String,SSD:String,IsEsim:Int,Home:String,StreetName:String,StreetBlockName:String,byPassValidateAI:String,lan:String,ocr_confirm:String,handler: @escaping (_ status:Bool,_ data:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        var param:Dictionary = Dictionary<String, Any>()
        
        param.updateValue(Provider, forKey: "Provider")
        param.updateValue(Phonenumber, forKey: "Phonenumber")
        param.updateValue(Imei, forKey: "Imei")
        param.updateValue(SeriSIM, forKey: "SeriSIM")
        
        param.updateValue(IMSI, forKey: "IMSI")
        param.updateValue(FullName, forKey: "FullName")
        param.updateValue(Birthday, forKey: "Birthday")
        param.updateValue(Gender, forKey: "Gender")
        param.updateValue(Address, forKey: "Address")
        param.updateValue(LoaiGiayTo, forKey: "LoaiGiayTo")
        
        param.updateValue(CMND, forKey: "CMND")
        param.updateValue(DateCreateCMND, forKey: "DateCreateCMND")
        param.updateValue(PalaceCreateCMND, forKey: "PalaceCreateCMND")
        param.updateValue(Nationality, forKey: "Nationality")
        param.updateValue(ProvinceCode, forKey: "ProvinceCode")
        param.updateValue(DistrictCode, forKey: "DistrictCode")
        
        param.updateValue(PrecinctCode, forKey: "PrecinctCode")
        param.updateValue(contractNo, forKey: "ContractNo")
        param.updateValue(Note, forKey: "Note")
        param.updateValue(ShopCode, forKey: "ShopCode")
        
        param.updateValue(UserCode, forKey: "UserCode")
        param.updateValue(ID, forKey: "ID")
        param.updateValue(GoiCuoc, forKey: "GoiCuoc")
        param.updateValue(ProductCode, forKey: "ProductCode")
        
        param.updateValue(Passport, forKey: "Passport")
        param.updateValue(DayGrantPassport, forKey: "DayGrantPassport")
        param.updateValue(NoiCapPassport, forKey: "NoiCapPassport")
        param.updateValue(SoVisa, forKey: "SoVisa")
        
        param.updateValue(SOPOS, forKey: "SOPOS")
        param.updateValue(NgayHetHanGiayTo, forKey: "NgayHetHanGiayTo")
        param.updateValue(Images, forKey: "Images")
        param.updateValue(TenShop, forKey: "TenShop")
        
        param.updateValue("\(Cache.user!.Address)", forKey: "DiaChiShop")
        param.updateValue("\(Cache.user!.EmployeeName)", forKey: "TenNhanVien")
        param.updateValue(CustId, forKey: "CustId")
        param.updateValue(SSD, forKey: "SSD")
        param.updateValue(IsEsim, forKey: "IsEsim")
        param.updateValue("\(Common.versionApp())",forKey: "Version")
        if(Provider == "Mobifone"){
            param.updateValue(Home, forKey: "Home")
            param.updateValue(StreetName, forKey: "StreetName")
            param.updateValue(StreetBlockName, forKey: "StreetBlockName")
        }
        param.updateValue(byPassValidateAI, forKey: "byPassValidateAI")
        param.updateValue(ocr_confirm, forKey: "ocr_confirm")
        //        if(Provider == "Viettel"){
        //                param.updateValue(byPassValidateAI, forKey: "byPassValidateAI")
        //        }
        param.updateValue("\(lan)",forKey: "lan")
        
        log.debug(param)
        
        provider.request(.ActiveSim(param:param)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                //log.debug(json)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let success = json?["Success"].bool {
                    if let returnData = json!["Data"].string {
                        handler(success,returnData)
                    }else{
                        handler(success,"Có lỗi xảy ra")
                    }
                }else{
                    handler(false,"Có lỗi xảy ra")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(false,error.localizedDescription)
            }
        }
    }

    class func GetListSearchOldProduct(keySearch:String,shop:String,skip:Int,top:Int,type:Int,handler: @escaping (_ success:[ProductOld],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[ProductOld] = []
        provider.request(.GetListSearchOldProduct(keySearch:keySearch,shop:shop,skip:skip,top:top,type:type)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let list = json["list"].array {
                    rs = ProductOld.parseObjfromArray(array: list)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getListOldProduct(shop:String,skip:Int,top:Int,type:Int,handler: @escaping (_ success:[ProductOld],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[ProductOld] = []
        provider.request(.getListOldProduct(shop:shop,skip:skip,top: top,type:type)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let list = json["list"].array {
                    rs = ProductOld.parseObjfromArray(array: list)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getEmployeeSOHeaders(handler: @escaping (_ success:[SOHeader],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[SOHeader] = []
        let parameter: [String: String] = [
            "UserCode":"\(Cache.user!.UserName)",
            "ShopCode":"\(Cache.user!.ShopCode)"
        ]
        provider.request(.getEmployeeSOHeaders(param: parameter)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                
                let msg = json["Message"].string
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = SOHeader.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,msg ?? "Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getEcomSOHeader(userCode:String,shopCode:String,handler: @escaping (_ success:[EcomSOHeader],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[EcomSOHeader] = []
        provider.request(.getEcomSOHeader(userCode:userCode,shopCode:shopCode)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                if let data = json["getEcomSOHeaderResult"].array {
                    rs = EcomSOHeader.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func getOCRDFFriend(cmnd:String,HinhThucMua:String,MaShop:String,isQrCode:String,handler: @escaping (_ success:[OCRDFFriend],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[OCRDFFriend] = []
        provider.request(.getOCRDFFriend(cmnd:cmnd,HinhThucMua:HinhThucMua,MaShop:MaShop,isQrCode:isQrCode)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                
                let p_Status = json?["p_Status"].stringValue
                let p_Message = json?["p_Message"].stringValue
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = OCRDFFriend.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if(p_Status == "0"){
                            handler(rs,p_Message ?? "LOAD API ERROR")
                        }else{
                            handler(rs,"Load API ERROR")
                        }
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_sp_LichSuMuahang(IDCardCode:String,handler: @escaping (_ success:[HistoryFFriend],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[HistoryFFriend] = []
        provider.request(.mpos_sp_LichSuMuahang(IDCardCode:IDCardCode)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = HistoryFFriend.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_sp_CancelFormDKSingle_TraGopOnline(IDFormDK:String,UserID:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.mpos_sp_CancelFormDKSingle_TraGopOnline(IDFormDK:IDFormDK,UserID:UserID)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                let messages = json["Messages"].stringValue
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(messages,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("",messages)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    
    class func getSODetails(docEntry:String,handler: @escaping (_ success:SODetail?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.getSODetails(docEntry:docEntry)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let data1 = json["getSODetailsResult"]
                if (!data1.isEmpty) {
                    let rs = SODetail.getObjFromDictionary(data: data1)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    
    class func mpos_sp_calllog_UpdateImei_Ecom(UserID:String,Imei:String,Itemcode:String,IDFinal:String,handler: @escaping (_ success:String,_ result:Int,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.mpos_sp_calllog_UpdateImei_Ecom(UserID:UserID,Imei:Imei,Itemcode:Itemcode,IDFinal:IDFinal)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                let suc = json["Success"].boolValue
                let rs = json["Result"].intValue
                let data1 = json["Message"].stringValue
                if(suc){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(data1,rs, "")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("",rs, data1)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",-1,error.localizedDescription)
            }
        }
    }
    class func mpos_sp_PrintPhieuDKPOS(IDCardCode:String,UserID:String,ID_Final:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.mpos_sp_PrintPhieuDKPOS(IDCardCode:IDCardCode,UserID:UserID,ID_Final:ID_Final)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                let suc = json["Success"].boolValue
                let data1 = json["Message"].stringValue
                if(suc){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(data1, "")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", data1)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func mpos_sp_UploadHinhAnhPDK(IDFinal:String,ShopCode:String,UserID:String,ChuKy:String,DiviceType:String,str64_CMNDMT:String,str64_CMNDMS:String,str64_ChanDung:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.mpos_sp_UploadHinhAnhPDK(IDFinal:IDFinal,ShopCode:ShopCode,UserID:UserID,ChuKy:ChuKy,DiviceType:DiviceType,str64_CMNDMT:str64_CMNDMT,str64_CMNDMS:str64_CMNDMS,str64_ChanDung:str64_ChanDung)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                
                let suc = json["Success"].boolValue
                let data1 = json["Message"].stringValue
                if(suc){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(data1, "")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", data1)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func mpos_sp_UploadChungTuHinhAnh(IdCardCode:String,Link_UQTN_1:String,Link_UQTN_2:String,Link_UQTN_3:String,Link_CMNDMT:String,Link_CMNDMS:String,UserID:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.mpos_sp_UploadChungTuHinhAnh(IdCardCode:IdCardCode,Link_UQTN_1:Link_UQTN_1,Link_UQTN_2:Link_UQTN_2,Link_UQTN_3:Link_UQTN_3,Link_CMNDMT:Link_CMNDMT,Link_CMNDMS:Link_CMNDMS,UserID:UserID)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                let suc = json["Success"].boolValue
                let data1 = json["Data"].stringValue
                if(suc){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(data1, "")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", data1)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func mpos_sp_SaveImageFriend_ChungTuDoiTra(insideCode:String,idFinal:String,base64_ChungTuDoiTra:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.mpos_sp_SaveImageFriend_ChungTuDoiTra(insideCode:insideCode,idFinal:idFinal,base64_ChungTuDoiTra:base64_ChungTuDoiTra)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                let suc = json["Success"].boolValue
                let data1 = json["Message"].stringValue
                if(suc){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(data1, "")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", data1)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func getVendorFFriend(LoaiDN:String,handler: @escaping (_ success:[CompanyFFriend],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[CompanyFFriend] = []
        provider.request(.getVendorFFriend(LoaiDN:LoaiDN)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = CompanyFFriend.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func sp_mpos_CheckCreateCustomer(VendorCode:String,LoaiKH:String,handler: @escaping (_ result:Int,_ message:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.sp_mpos_CheckCreateCustomer(VendorCode:VendorCode,LoaiKH:LoaiKH)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            
                            if(data.count > 0){
                                let dataJSON = data[0]
                                let result = dataJSON["Result"].intValue
                                let message = dataJSON["Message"].stringValue
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(result, message)
                            }else{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(0, "Load API Error!")
                            }
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(0,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,error.localizedDescription)
            }
        }
    }
    class func AddCustomerFFriend(VendorCode:String,CMND:String,FullName:String,SDT:String,HoKhauTT:String,NgayCapCMND:String,NoiCapCMND:String,ChucVu:String,NgayKiHD:String,SoTKNH:String,IdBank:String,ChiNhanhNH:String,Email:String,Note:String,CreateBy:String,FileAttachName:String,ChiNhanhDN:String,IDCardCode:String,LoaiKH:String,NgaySinh:String,CreditCard:String,MaNV_KH:String,VendorCodeRef:String,CMND_TinhThanhPho:String,CMND_QuanHuyen:String,CMND_PhuongXa:String,NguoiLienHe:String,SDT_NguoiLienHe:String,QuanHeVoiNguoiLienHe:String,NguoiLienHe_2:String,SDT_NguoiLienHe_2:String,QuanHeVoiNguoiLienHe_2:String,AnhDaiDien:String,GioThamDinh_TimeFrom:String,GioThamDinh_TimeTo:String,GioThamDinh_OtherTime:String,IdCardcodeRef:String,TenSPThamDinh:String,Gender:Int,IDImageXN:String,ListIDSaoKe:String,NguoiLienHe_3:String,SDT_NguoiLienHe_3:String,QuanHeVoiNguoiLienHe_3:String,NguoiLienHe_4:String,SDT_NguoiLienHe_4:String,QuanHeVoiNguoiLienHe_4:String,EVoucher:String,SoHopDong:String,isQrCode:String,isComplete:String,OTP:String,handler: @escaping (_ success:String,_ code:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let log = SwiftyBeaver.self
        var NgayCapCMNDTemp = NgayCapCMND
        if(NgayCapCMNDTemp == "01/01/1970"){
            NgayCapCMNDTemp = ""
        }
        var NgayKiHDTemp = NgayKiHD
        if(NgayKiHDTemp == "01/01/1970"){
            NgayKiHDTemp = ""
        }
        var NgaySinhTemp = NgaySinh
        if(NgaySinhTemp == "01/01/1970"){
            NgaySinhTemp = ""
        }
        var AnhDaiDienTemp = AnhDaiDien
        if(AnhDaiDien == "null"){
            AnhDaiDienTemp = ""
        }
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        var gioitinh:String = ""
        if(Gender != -1){
            gioitinh = "\(Gender)"
        }
        let parameters: [String: String] = [
            "VendorCode" : "\(VendorCode)",
            "CMND" : "\(CMND)",
            "FullName" : "\(FullName)",
            "SDT" : "\(SDT)",
            "HoKhauTT" : "\(HoKhauTT)",
            "NgayCapCMND" : "\(NgayCapCMNDTemp)",
            "NoiCapCMND" : "\(NoiCapCMND)",
            "ChucVu" : "\(ChucVu)",
            "NgayKiHD" : "\(NgayKiHDTemp)",
            "SoTKNH" : "\(SoTKNH)",
            "IdBank" : "\(IdBank)",
            "ChiNhanhNH" : "\(ChiNhanhNH)",
            "Email" : "\(Email)",
            "CreateBy" : "\(CreateBy)",
            "Note" : "\(Note)",
            "FileAttachName" : "\(FileAttachName)|\(AnhDaiDienTemp)",
            "ChiNhanhDN" : "\(ChiNhanhDN)",
            "IDCardCode" : "\(IDCardCode)",
            "LoaiKH" : "\(LoaiKH)",
            "NgaySinh": "\(NgaySinhTemp)",
            "CreditCard": "\(CreditCard)",
            "MaNV_KH": "\(MaNV_KH)",
            "DiviceType" :"2",
            "VendorCodeRef":"\(VendorCodeRef)",
            "CMND_TinhThanhPho":"\(CMND_TinhThanhPho)",
            "CMND_QuanHuyen":"\(CMND_QuanHuyen)",
            "CMND_PhuongXa":"\(CMND_PhuongXa)",
            "NguoiLienHe":"\(NguoiLienHe)",
            "SDT_NguoiLienHe":"\(SDT_NguoiLienHe)",
            "QuanHeVoiNguoiLienHe":"\(QuanHeVoiNguoiLienHe)",
            "NguoiLienHe_2":"\(NguoiLienHe_2)",
            "SDT_NguoiLienHe_2":"\(SDT_NguoiLienHe_2)",
            "QuanHeVoiNguoiLienHe_2":"\(QuanHeVoiNguoiLienHe_2)",
            "AnhDaiDien":"\(AnhDaiDienTemp)",
            "GioThamDinh_TimeFrom":"\(GioThamDinh_TimeFrom)",
            "GioThamDinh_TimeTo":"\(GioThamDinh_TimeTo)",
            "GioThamDinh_OtherTime":"\(GioThamDinh_OtherTime)",
            "IdCardcodeRef":"\(IdCardcodeRef)",
            "TenSPThamDinh":"\(TenSPThamDinh)",
            "CRMCode":"\(crm ?? "")",
            "Token":"\(Cache.user!.Token)",
            "UserID":"\(Cache.user!.UserName)",
            "Gender":"\(gioitinh)",
            "IDImageXNLog":"\(IDImageXN)",
            "ListIDSaoKe":"\(ListIDSaoKe)",
            "NguoiLienHe_3":"\(NguoiLienHe_3)",
            "SDT_NguoiLienHe_3":"\(SDT_NguoiLienHe_3)",
            "QuanHeVoiNguoiLienHe_3":"\(QuanHeVoiNguoiLienHe_3)",
            "NguoiLienHe_4":"\(NguoiLienHe_4)",
            "SDT_NguoiLienHe_4":"\(SDT_NguoiLienHe_4)",
            "QuanHeVoiNguoiLienHe_4":"\(QuanHeVoiNguoiLienHe_4)",
            // "EVoucher":"\(EVoucher)",
            "SoHopDong":"\(SoHopDong)",
            "isQrCode":"\(isQrCode)",
            "isComplete":"\(isComplete)",
            "OTP":"\(OTP)"
        ]
        log.debug(parameters)
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.AddCustomerFFriend(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                log.debug(json as Any)
                let suc = json?["Success"].boolValue
                let message = json?["message"].stringValue
                let p_Status = json?["p_Status"].stringValue
                let p_Message = json?["p_Message"].stringValue
                if(suc ?? false){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let idCardCode = json?["IDCardCode"].stringValue
                    handler(message ?? "",idCardCode ?? "", "")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if(p_Status == "0"){
                        handler("","", p_Message ?? "LOAD API ERROR !")
                    }else{
                        handler("","", message ?? "LOAD API ERROR !")
                    }
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("","",error.localizedDescription)
            }
        }
    }
    class func sp_CreditNoneCard_UploadImage_RequestV2(InsideCode:String,IdCardCode:String,CRD_MT_CMND:String,CRD_MS_CMND:String,CRD_KH_CMND:String,CRD_GPLX_MT:String,CRD_GPLX_MS:String,CRD_MoThe:String,CRD_DXTNTD:String,CRD_SHK_1:String,CRD_SHK_2:String,CRD_SHK_3:String,CRD_SHK_4:String,CRD_SHK_5:String,CRD_SHK_6:String,CRD_SHK_7:String,CRD_SHK_8:String,Link_CRD_MT_CMND:String,Link_CRD_MS_CMND:String,CRD_DXTNTD_M2:String,CRD_CD_DKMoThe:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        
        let parameters: [String: String] = [
            "InsideCode" : "\(InsideCode)",
            "IdCardCode" : "\(IdCardCode)",
            "DiviceType" : "2",
            "CRD_MT_CMND" : "\(CRD_MT_CMND)",
            "CRD_MS_CMND" : "\(CRD_MS_CMND)",
            "CRD_KH_CMND" : "\(CRD_KH_CMND)",
            "CRD_GPLX_MT" : "\(CRD_GPLX_MT)",
            "CRD_GPLX_MS" : "\(CRD_GPLX_MS)",
            "CRD_MoThe" : "\(CRD_MoThe)",
            "CRD_DXTNTD" : "\(CRD_DXTNTD)",
            "CRD_SHK_1" : "\(CRD_SHK_1)",
            "CRD_SHK_2" : "\(CRD_SHK_2)",
            "CRD_SHK_3" : "\(CRD_SHK_3)",
            "CRD_SHK_4" : "\(CRD_SHK_4)",
            "CRD_SHK_5" : "\(CRD_SHK_5)",
            "CRD_SHK_6" : "\(CRD_SHK_6)",
            "CRD_SHK_7" : "\(CRD_SHK_7)",
            "CRD_SHK_8" : "\(CRD_SHK_8)",
            "Link_CRD_MT_CMND" : "\(Link_CRD_MT_CMND)",
            "Link_CRD_MS_CMND" : "\(Link_CRD_MS_CMND)",
            "CRD_DXTNTD_M2":"\(CRD_DXTNTD_M2)",
            "CRD_CD_DKMoThe":"\(CRD_CD_DKMoThe)"
        ]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.sp_CreditNoneCard_UploadImage_RequestV2(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                let suc = json["Success"].boolValue
                let data1 = json["Message"].stringValue
                if(suc){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(data1, "")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", data1)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func UploadImage_CreditNoCard(IdCardCode:String,base64:String,Type:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        
        let parameters: [String: String] = [
            "IdCardCode" : "\(IdCardCode)",
            "base64" : "\(base64)",
            "Type" : "\(Type)",
            "DiviceType" : "2"
        ]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.UploadImage_CreditNoCard(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                let suc = json["Success"].boolValue
                let data1 = json["Message"].stringValue
                if(suc){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(data1, "")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", data1)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func mpos_sp_GetBank_CreditNoCard(handler: @escaping (_ success:[BankFFriend],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[BankFFriend] = []
        provider.request(.mpos_sp_GetBank_CreditNoCard){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = BankFFriend.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func mpos_sp_GetLink_CMND_UQTN_Credit(CMND:String,handler: @escaping (_ cmndmt:String,_ cmndms:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.mpos_sp_GetLink_CMND_UQTN_Credit(CMND:CMND)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            if(data.count > 0){
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                let item = data[0]
                                var cmndmt = item["CMNDMT"].string
                                var cmndms = item["CMNDMS"].string
                                cmndmt = cmndmt == nil ? "" : cmndmt
                                cmndms = cmndms == nil ? "" : cmndms
                                handler(cmndmt!,cmndms!, "Load API Error!")
                            }else{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler("","", "Load API Error!")
                            }
                            
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler("","", "Load API Error!")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("","", "Load API Error!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","", "Load API Error!")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("","",error.localizedDescription)
            }
        }
    }
    class func mpos_sp_getVendors_All(handler: @escaping (_ success:[SearchVendor],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[SearchVendor] = []
        provider.request(.mpos_sp_getVendors_All){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = SearchVendor.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_sp_SearchVendor(vendor:String,handler: @escaping (_ result:String,_ err:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.mpos_sp_SearchVendor(vendor:vendor)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if(data.count > 0){
                                let item = data[0]
                                let message = item["Message"].stringValue
                                handler(message, "")
                            }else{
                                handler("", "Load API Error!")
                            }
                            
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler("","Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("","Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func mpos_sp_SaveImageFriend(insideCode:String,strImage_H1:String,base64_H1:String,strImage_H2:String,base64_H2:String,strImage_H3:String,base64_H3:String,handler: @escaping (_ result:String,_ err:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let parameters: [String: String] = [
            "InsideCode" : "\(insideCode)",
            "strImage" : "\(strImage_H1)",
            "base64" : "\(base64_H1)",
            "strImage_H1":"\(strImage_H1)",
            "base64_H1":"\(base64_H1)",
            "strImage_H2":"\(strImage_H2)",
            "base64_H2":"\(base64_H2)",
            "strImage_H3":"\(strImage_H3)",
            "base64_H3":"\(base64_H3)",
            "DiviceType" : "2"
        ]
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.mpos_sp_SaveImageFriend(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            
                            if(data.count > 0){
                                let item = data[0]
                                let message = item["PathFile"].stringValue
                                handler(message, "")
                            }else{
                                handler("", "Load API Error!")
                            }
                            
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler("","Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("","Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func mpos_sp_SaveImageFriend_ChanDung(insideCode:String,strImage_ChanDung:String,base64_ChanDung:String,handler: @escaping (_ result:String,_ err:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let parameters: [String: String] = [
            "InsideCode" : "\(insideCode)",
            "strImage_ChanDung" : "\(strImage_ChanDung)",
            "base64_ChanDung" : "\(base64_ChanDung)",
            "DiviceType" : "2"
        ]
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.mpos_sp_SaveImageFriend_ChanDung(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        let data1 = json["Result"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(data1, "")
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("","Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func getTinhThanhFFriend(handler: @escaping (_ success:[TinhThanhFFriend],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[TinhThanhFFriend] = []
        provider.request(.getTinhThanhFFriend){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = TinhThanhFFriend.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getThongTinNganHangFFriend(Vendor:String,CNVendor:String,handler: @escaping (_ success:[BankFFriend],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[BankFFriend] = []
        provider.request(.getThongTinNganHangFFriend(Vendor:Vendor,CNVendor:CNVendor)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = BankFFriend.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_sp_LoadTinhThanhPho(handler: @escaping (_ success:[TinhThanhPhoFFriend],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[TinhThanhPhoFFriend] = []
        provider.request(.mpos_sp_LoadTinhThanhPho){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = TinhThanhPhoFFriend.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_sp_LoadQuanHuyen(TinhThanh:String,handler: @escaping (_ success:[QuanHuyenFFriend],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[QuanHuyenFFriend] = []
        provider.request(.mpos_sp_LoadQuanHuyen(TinhThanh:TinhThanh)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = QuanHuyenFFriend.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_sp_GetMoiLienHeVoiNguoiLL(handler: @escaping (_ success:[MoiLienHeVoiNguoiLL],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[MoiLienHeVoiNguoiLL] = []
        provider.request(.mpos_sp_GetMoiLienHeVoiNguoiLL){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = MoiLienHeVoiNguoiLL.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_sp_PrintUQTNPOS(IDCardCode:String,UserID:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.mpos_sp_PrintUQTNPOS(IDCardCode:IDCardCode,UserID:UserID)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                let suc = json["Success"].boolValue
                let data1 = json["Message"].stringValue
                if(suc){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(data1, "")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", data1)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func mpos_sp_SendOTPCustomerFriend(UserID:String,ListSP:String,IDcardCode:String,Doctype:String,xml_sp:String,handler: @escaping (_ success:String,_ result:Int,_ error:String) ->Void){
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        let parameters: [String: String] = [
            "UserID" : "\(UserID)",
            "ListSP" : "\(ListSP)",
            "IDcardCode" : "\(IDcardCode)",
            "Doctype" : "\(Doctype)",
            "ShopCode" : "\(Cache.user!.ShopCode)",
            "DiviceType":"2",
            "CRMCode":"\(crm ?? "")",
            "xml_sp":"\(xml_sp)",
            "Token":"\(Cache.user!.Token)"
        ]
        print(parameters)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.mpos_sp_SendOTPCustomerFriend(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(parameters)
                let suc = json["Success"].boolValue
                let data1 = json["Message"].stringValue
                let rs = json["Result"].intValue
                if(suc){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(data1,rs, "")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("",-1, data1)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",-1,error.localizedDescription)
            }
        }
    }
    class func checkPromotionFF(u_CrdCod:String,sdt:String,LoaiDonHang:String,LoaiTraGop:String,LaiSuat:Float,SoTienTraTruoc:Float,voucher:String,IDCardcode:String,Docentry:String,handler: @escaping (_ success:Promotion?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var xml = "<line>"
        for item in Cache.cartsFF{
            var whsCod = "\(Cache.user!.ShopCode)010"
            if(item.whsCode.count > 0){
                whsCod = item.whsCode
            }
            var imei = item.imei
            if(imei == "N/A"){
                imei = ""
            }
            xml  = xml + "<item U_ItmCod=\"\(item.product.sku)\" U_Imei=\"\(imei)\" U_Quantity=\"\(item.quantity)\" U_PriceBT=\"\(String(format: "%.6f", item.product.priceBeforeTax))\" U_Price=\"\(String(format: "%.6f", item.product.price))\" U_WhsCod=\"\(whsCod)\"/>"
        }
        xml = xml + "</line>"
        var loaiGop = LoaiTraGop
        if (loaiGop == "-1"){
            loaiGop = "0"
        }
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        let parameters: [String: String] = [
            "u_CrdCod" : "\(u_CrdCod)",
            "itemsInXML" : "\(xml)",
            "sdt" : "\(sdt)",
            "LoaiDonHang" : "\(LoaiDonHang)",
            "LoaiTraGop" : "\(loaiGop)",
            "LaiSuat" : "\(String(format: "%.6f", LaiSuat))",
            "SoTienTraTruoc" : "\(String(format: "%.6f", SoTienTraTruoc))",
            "voucher" : "\(voucher)",
            "IDcardCodeFriend" :"\(IDCardcode)",
            "kyhan": "0",
            "HDNum": "",
            "U_cardcode": "0",
            "UserID": "\(Cache.user!.UserName)",
            "CRMCode": "\(crm ?? "")",
            "Token": "\(Cache.user!.Token)",
            "Docentry":"\(Docentry)"
        ]
        
        var promotion:Promotion? = nil
        provider.request(.checkPromotionFF(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        if(!data.isEmpty){
                            let returnMessage = data["ReturnMessage"]
                            if(!returnMessage.isEmpty){
                                let p_status = returnMessage["p_status"].boolValue
                                let p_messagess = returnMessage["p_messagess"].stringValue
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                if(p_status){
                                    promotion = Promotion.getObjFromDictionary(data: data)
                                    handler(promotion,"")
                                }else{
                                    handler(promotion,p_messagess)
                                }
                            }else{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(promotion,"Kiểm tra khuyến mại thất bại!")
                            }
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(promotion,"Kiểm tra khuyến mại thất bại!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(promotion,"Kiểm tra khuyến mại thất bại!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(promotion,"Kiểm tra khuyến mại thất bại!")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(promotion,error.localizedDescription)
            }
        }
    }
    
    class func sp_mpos_HuyCalllog_UQTN_HetHan(IDCardCode:String, UserID: String, DeviceType:String, handler: @escaping (_ resultCode:Int, _ message: String,_ MsgUQTN:String,_ error:String) ->Void){
        let parameters: [String: String] = [
            "IDCardCode":IDCardCode,
            "UserID":UserID,
            "DeviceType":"1"
        ]
        var resultCode: Int = 0
        var message = ""
        var MsgUQTN = ""
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.sp_mpos_HuyCalllog_UQTN_HetHan(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            for item in data {
                                resultCode = item["Result"].int ?? 0
                                message = item ["Message"].string ?? ""
                                MsgUQTN = item ["MsgUQTN"].string ?? ""
                            }
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(resultCode, message,MsgUQTN,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(resultCode, message,MsgUQTN,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"","","Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"","","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0, "","",error.localizedDescription)
            }
        }
    }
    
    class func mpos_sp_insert_order_ffriend(cmnd:String,CardName:String,U_EplCod:String,ShopCode:String,Sotientratruoc:String,Doctype:String,U_des:String,RDR1:String,PROMOS:String,LoaiTraGop:String,LaiSuat:String,voucher:String,otp:String,NgayDenShopMua:String,HinhThucGH:String,DiaChi:String,magioithieu:String,kyhan:String,Thanhtien:String,IDcardcode:String,HinhThucThuTien:String,ListSP:String,IsSkip:String,AuthenBy:String,TransactionID:Int,p_docentry:String,handler: @escaping (_ success:String, _ IdFinal:String,_ ifFromDK:String, _ IsExpired_CL_UQTN:String,_ error:String) ->Void){
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")!
        
        let parameters: [String: String] = [
            "cmnd":"\(cmnd)",
            "CardName":"\(CardName)",
            "U_EplCod":"\(U_EplCod)",
            "ShopCode":"\(ShopCode)",
            "Sotientratruoc":"\(Sotientratruoc)",
            "Doctype":"\(Doctype)",
            "U_des":"\(U_des)",
            "RDR1":"\(RDR1)",
            "PROMOS":"\(PROMOS)",
            "LoaiTraGop":"\(LoaiTraGop)",
            "LaiSuat":"\(LaiSuat)",
            "voucher":"\(voucher)",
            "otp":"\(otp)",
            "NgayDenShopMua":"\(NgayDenShopMua)",
            "HinhThucGH":"\(HinhThucGH)",
            "DiaChi":"\(DiaChi)",
            "magioithieu":"\(magioithieu)",
            "kyhan":"\(kyhan)",
            "Thanhtien":"\(Thanhtien)",
            "IDcardcode":"\(IDcardcode)",
            "HinhThucThuTien":"\(HinhThucThuTien)",
            "ListSP": "\(ListSP)",
            "DiviceType": "2",
            "IsSkip": "\(IsSkip)",
            "AuthenBy": "\(AuthenBy)",
            "CRMCode":"\(crm)",
            "Token":"\(Cache.user!.Token)",
            "UserID":"\(Cache.user!.UserName)",
            "TransactionID":"\(TransactionID)",
            "p_docentry":"\(p_docentry)"
            
        ]
        print(parameters)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.mpos_sp_insert_order_ffriend(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                guard let json = try? JSON(data: data) else {
                    handler("","","","0","Load API ERROR!")
                    return
                    
                }
                debugPrint(json)
                let suc = json["Success"].boolValue
                let messages = json["Messages"].stringValue
                let idFormDK = json["IDFormDK"].stringValue
                let idFinal = json["IdFinal"].stringValue
                let IsExpired_CL_UQTN = json["IsExpired_CL_UQTN"].stringValue
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("\(suc)","\(idFinal)","\(idFormDK)", "\(IsExpired_CL_UQTN)", messages)
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("","","","0",error.localizedDescription)
            }
        }
    }
    
    class func getHinhThucGiaoHangFFriend(handler: @escaping (_ success:[HinhThucGiaoHangFFriend],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[HinhThucGiaoHangFFriend] = []
        provider.request(.getHinhThucGiaoHangFFriend){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = HinhThucGiaoHangFFriend.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func sp_mpos_CheckAccount_SkipOTP_ShopApDung(handler: @escaping (_ result:Int,_ err:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        provider.request(.sp_mpos_CheckAccount_SkipOTP_ShopApDung){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if(data.count > 0){
                                let item = data[0]
                                let shopApDung = item["ShopApDung"].intValue
                                handler(shopApDung, "")
                            }else{
                                handler(0, "Load API Error!")
                            }
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(0, "Load API Error!")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0, "Load API Error!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0, "Load API Error!")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,error.localizedDescription)
            }
        }
    }
    class func CheckAccount_SkipOTP(UserID:String,PassWord:String,handler: @escaping (_ isCheck:Int,_ message:String,_ err:String) ->Void){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.CheckAccount_SkipOTP(UserID:UserID,PassWord:PassWord)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                let suc = json["Success"].boolValue
                let message = json["Message"].stringValue
                let isCheck = json["IsCheck"].intValue
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if(suc){
                    handler(isCheck,message, "")
                }else{
                    handler(isCheck, "",message)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"",error.localizedDescription)
            }
        }
    }
    class func FRT_SP_CRM_DSNhaMang_bookSim(handler: @escaping (_ success:[ProviderName],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        let parameters: [String: String] = [
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "CRMCode":"\(crm ?? "")",
            "Token":"\(Cache.user!.Token)",
        ]
        print(parameters)
        var rs:[ProviderName] = []
        provider.request(.FRT_SP_CRM_DSNhaMang_bookSim(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json!["Data"].array {
                            rs = ProviderName.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getListGoiCuocBookSimV2(NhaMang:String,handler: @escaping (_ success:[GoiCuocBookSimV2],_ IsLogin:String,_ p_Status:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var rs:[GoiCuocBookSimV2] = []
        provider.request(.getListGoiCuocBookSimV2(NhaMang:NhaMang)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                let IsLogin = json["IsLogin"].stringValue
                let p_Status = json["p_Status"].stringValue
                
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = GoiCuocBookSimV2.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,IsLogin,p_Status,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,IsLogin,p_Status,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,IsLogin,p_Status,"Success value false!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"0","1","Response not found!")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,"0","1",error.localizedDescription)
            }
        }
    }
    class func getListLichSuKichHoat(phoneNumber:String,FromDate:String,ToDate:String,handler: @escaping (_ success:[LichSuKichHoatV2],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        let parameters: [String: String] = [
            "FromDate" : "\(FromDate)",
            "ToDate": "\(ToDate)",
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "CRMCode":"\(crm ?? "")",
            "Token":"\(Cache.user!.Token)",
            "phonenumber":"\(phoneNumber)"
        ]
        print(parameters)
        var rs:[LichSuKichHoatV2] = []
        provider.request(.getListLichSuKichHoat(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = LichSuKichHoatV2.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getListLichSuKichHoatSerial(serial:String,FromDate:String,ToDate:String,handler: @escaping (_ success:[LichSuKichHoatV2],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "fromDate" : "2022-03-01",//"\(FromDate.toNewStrDate(withFormat: "dd/MM/yyyy", newFormat: "yyyy-MM-đ"))",
            "toDate": "2022-03-22",//"\(ToDate.toNewStrDate(withFormat: "dd/MM/yyyy", newFormat: "yyyy-MM-đ"))",
            "userCode": "35208",//"\(Cache.user!.UserName)",
            "shopCode": "\(Cache.user!.ShopCode)",
            "serial": "\(serial)"
        ]
        print(parameters)
        var rs:[LichSuKichHoatV2] = []
        provider.request(.getListLichSuKichHoatSerial(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = LichSuKichHoatV2.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getThongTinGiaHanSSD(phoneNumber:String,handler: @escaping (_ success:[ThongTinGiaHanSSD],_ IsLogin:String,_ p_Status:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")!
        let parameters: [String: String] = [
            "SDT" : "\(phoneNumber)",
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "CRMCode":"\(crm)",
            "Token":"\(Cache.user!.Token)",
        ]
        var rs:[ThongTinGiaHanSSD] = []
        provider.request(.getThongTinGiaHanSSD(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                let IsLogin = json["IsLogin"].stringValue
                let p_Status = json["p_Status"].stringValue
                //                let p_Message = json["p_Message"].stringValue
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = ThongTinGiaHanSSD.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,IsLogin,p_Status,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,IsLogin,p_Status,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,IsLogin,p_Status,"Success value false!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"0","1","Response not found!")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,"0","1",error.localizedDescription)
            }
        }
    }
    
    class func uploadHinhGiaHanSSD(p_Signature:String,thongtingiahan:ThongTinGiaHanSSD,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "p_Signature":p_Signature,
            "p_PhoneNumber":thongtingiahan.SDT,
            "p_Sompos":thongtingiahan.SoSOPOS,
            "p_CMND":thongtingiahan.CMND
        ]
        provider.request(.uploadHinhGiaHanSSD(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                let message = json["Data"].stringValue
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(message,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("",message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Response not found!")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func giaHanSSDResult(thongtingiahan:ThongTinGiaHanSSD,token:String,otp:String,handler: @escaping (_ success:GiaHanSSDResult,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "customerName": thongtingiahan.TenKH,
            "customerId": thongtingiahan.CMND,
            "dateOfBirth": thongtingiahan.NgaySinh,
            "mdn": thongtingiahan.SDT,
            "packageId": thongtingiahan.GoiCuoc,
            "packagePrice": "\(thongtingiahan.TienGoiCuoc)",
            "itemcode": thongtingiahan.ItemCode,
            "nCampaignId": thongtingiahan.CampaignID,
            "nVasID": thongtingiahan.VASID,
            "description": thongtingiahan.NoiDung,
            "token": token,
            "otp": otp,
            "userId": Cache.user!.UserName,
            "shopId": Cache.user!.ShopCode
        ]
        var giahanresult:GiaHanSSDResult = GiaHanSSDResult(Success: false, NVasID: "", errorCode: "", errorDetail: "", mdn: "")
        provider.request(.giaHanSSDResult(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                let message =  json["Message"].stringValue
                if let success = json["Success"].bool {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if(success){
                        let data1 = json["Data"]
                        giahanresult.Success = success
                        giahanresult = GiaHanSSDResult.getObjFromDictionary(data: data1)
                        handler(giahanresult,message)
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(giahanresult,message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(giahanresult,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(giahanresult,error.localizedDescription)
            }
        }
    }
    class func getOTPGiaHanSSD(isdn:String,handler: @escaping (_ success:OTPGiaHanSSD,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "isdn" : "\(isdn)"
        ]
        var otp:OTPGiaHanSSD = OTPGiaHanSSD(Isdn: "", Token: "", Status: "")
        provider.request(.getOTPGiaHanSSD(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                //                let message =  json["Message"].stringValue
                if let success = json["Success"].bool {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if(success){
                        let data1 = json["Data"]
                        otp = OTPGiaHanSSD.getObjFromDictionary(data: data1)
                        handler(otp,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(otp,"Data not found!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(otp,"Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(otp,error.localizedDescription)
            }
        }
    }
    class func getListNhaThuoc(handler: @escaping (_ success:[NhaThuoc],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")!
        let parameters: [String: String] = [
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "CRMCode":"\(crm)",
            "Token":"\(Cache.user!.Token)"
        ]
        var rs:[NhaThuoc] = []
        provider.request(.getListNhaThuoc(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = NhaThuoc.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getListNhanVienThuocLongChau(ShopCode_LC:String,handler: @escaping (_ success:[NhanVienThuoc],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        let parameters: [String: String] = [
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "CRMCode":"\(crm ?? "")",
            "Token":"\(Cache.user!.Token)",
            "ShopCode_LC":"\(ShopCode_LC)"
        ]
        var rs:[NhanVienThuoc] = []
        provider.request(.getListNhanVienThuocLongChau(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = NhanVienThuoc.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func insertThuHoLongChau(MaNV_LC:String,Password:String,ShopCode_LC:String,amount:Int,crmtokken:String,Note:String,handler: @escaping (_ success:XacNhanNhanVien,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        //        let pwd = PasswordEncrypter.encrypt(password: Password)
        let parameters: [String: String] = [
            "MaNV_LC" : "\(MaNV_LC)",
            "Password": "\(Password)",
            "ShopCode_LC": "\(ShopCode_LC)",
            "amount": "\(amount)",
            "UserID": "\(Cache.user!.UserName)",
            "MaShop": "\(Cache.user!.ShopCode)",
            "IPShop": "",
            "crmtoken": "\(crmtokken)",
            "Note": "\(Note)",
            "DeviceType": "2"
        ]
        let insertXMLResult:XacNhanNhanVien = XacNhanNhanVien(success: false,message:"",Result:"",docentry:"", sophieucrm: "", IDBill: "")
        provider.request(.insertThuHoLongChau(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let success = json["Success"].boolValue
                let docentry = json["DocEntry"].stringValue
                let result = json["Result"].stringValue
                let message = json["Message"].stringValue
                
                let sophieucrm = json["socrm"].stringValue
                let IDBill = json["IDBill"].stringValue
                
                insertXMLResult.success = success
                
                insertXMLResult.message = message
                insertXMLResult.Result = result
                insertXMLResult.docentry = docentry
                insertXMLResult.sophieucrm = sophieucrm
                insertXMLResult.IDBill = IDBill
                handler(insertXMLResult,"")
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(insertXMLResult,error.localizedDescription)
            }
        }
    }
    class func pushBillThuHoLongChau(printBill:BillParamThuHo) {
        
        let mn = Config.manager
        
        let action = "\(Cache.user!.ShopCode)/push"
        let urlString = "\(mn.URL_PRINT_BILL!)/api/\(action)"
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 160
        if let data =  try? JSONSerialization.data(withJSONObject: printBill.toJSON(), options: []){
            if let jsonData = String(data:data, encoding:.utf8) {
                print(jsonData)
                let billParam = BillParam(title: "In thu hộ Long Châu", body: jsonData,id: "POS", key: "pos_thuholongchau")
                let billMessage = BillMessage(message:billParam)
                
                print("\(urlString) \(billMessage.toJSON())")
                if let data2 =  try? JSONSerialization.data(withJSONObject: billMessage.toJSON(), options: []){
                    if let url = URL(string: urlString) {
                        var request = URLRequest(url: url)
                        request.httpMethod = HTTPMethod.post.rawValue
                        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                        request.httpBody = data2
                        manager.request(request).responseJSON {
                            (response) in
                            print(response)
                        }
                    }
                }
            }
        }
    }
    class func pushPrintBaoHiem(printBH:BaoHiem_PrintObject) {
        
        let mn = Config.manager
        
        let action = "\(Cache.user!.ShopCode)/push"
        let urlString = "\(mn.URL_PRINT_BILL!)/api/\(action)"
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 160
        if let data =  try? JSONSerialization.data(withJSONObject: printBH.toJSON(), options: []){
            if let jsonData = String(data:data, encoding:.utf8) {
                print(jsonData)
                let billParam = BillParam(title: "In bảo hiểm xe cơ giới ", body: jsonData,id: "POS", key: "pos_baohiem")
                let billMessage = BillMessage(message:billParam)
                
                print("\(urlString) \(billMessage.toJSON())")
                if let data2 =  try? JSONSerialization.data(withJSONObject: billMessage.toJSON(), options: []){
                    if let url = URL(string: urlString) {
                        var request = URLRequest(url: url)
                        request.httpMethod = HTTPMethod.post.rawValue
                        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                        request.httpBody = data2
                        manager.request(request).responseJSON {
                            (response) in
                            print(response)
                        }
                    }
                }
            }
        }
    }
    
    class func SendOTPConvert4G(isdn:String,handler: @escaping (_ success:OTPRequestConvert,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "isdn" : "\(isdn)"
        ]
        var otpRequestData2:OTPRequestConvertData2 = OTPRequestConvertData2(isdn: "", status: "")
        let otpRequestData:OTPRequestConvertData = OTPRequestConvertData(code: 0, message: "",OTPRequestConvertData2: otpRequestData2)
        let otpRequest:OTPRequestConvert = OTPRequestConvert(Success: false, Message: "", OTPRequestConvertData: otpRequestData)
        provider.request(.SendOTPConvert4G(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                let success = json["Success"].boolValue
                let message = json["Message"].stringValue
                
                otpRequest.Success = success
                otpRequest.Message = message
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if(success){
                    let data1 = json["Data"]
                    
                    let code = data1["code"].intValue
                    let message = data1["message"].stringValue
                    let objectResult2 = data1["Data"]
                    otpRequestData2 = OTPRequestConvertData2.getObjFromDictionary(data: objectResult2)
                    otpRequestData.code = code
                    otpRequestData.message = message
                    otpRequest.OTPRequestConvertData = otpRequestData
                    handler(otpRequest, "")
                }else{
                    handler(otpRequest, "Load API Error! \(message)")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(otpRequest, error.localizedDescription)
            }
        }
    }
    
    class func ChangeSim4G(sdt:String,iccid:String,otp:String,handler: @escaping (_ success:ChangeSim4GResult,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "isdn" : "\(sdt)",
            "iccid": "\(iccid)",
            "otp": "\(otp)",
            "mashop": "\(Cache.user!.ShopCode)",
            "userid": "\(Cache.user!.UserName)"
        ]
        let change4GResultData:Change4GResultData = Change4GResultData(code:0,message:"")
        let changeSimResult:ChangeSim4GResult = ChangeSim4GResult(Success: false, Message: "",change4GResultData: change4GResultData)
        provider.request(.changeSim4G(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                let success = json["Success"].boolValue
                let message = json["Message"].stringValue
                
                changeSimResult.Success = success
                changeSimResult.Message = message
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if(success){
                    let data1 = json["Data"]
                    
                    let code = data1["code"].intValue
                    let message = data1["message"].stringValue
                    change4GResultData.code = code
                    change4GResultData.message = message
                    changeSimResult.change4GResultData = change4GResultData
                    handler(changeSimResult, "")
                }else{
                    handler(changeSimResult, "Load API Error! \(message)")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(changeSimResult, error.localizedDescription)
            }
        }
    }
    class func getInfoActiveSimbyPhone(sdt:String,handler: @escaping (_ success:[InfoActiveSimbyPhone],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "Phonenumber":"\(sdt)"
        ]
        var rs:[InfoActiveSimbyPhone] = []
        provider.request(.getInfoActiveSimbyPhone(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json!["Data"].array {
                            rs = InfoActiveSimbyPhone.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func SendOTPInfoActiveSim(isdn:String,handler: @escaping (_ success:OTPInfoActiveSim?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "isdn" : "\(isdn)"
        ]
        var otpData:OTPActiveSimData?
        print(parameters)
        provider.request(.SendOTPInfoActiveSim(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if(success){
                    
                    let data1 = json["Data"]
                    let code = data1["code"].intValue
                    let message = data1["message"].stringValue
                    if(code == 0){
                        let data2 = data1["data"]
                        otpData = OTPActiveSimData.getObjFromDictionary(data: data2)
                        let otpInfoVNM = OTPInfoActiveSim(code: code, message: message, otpActiveData: otpData!)
                        handler(otpInfoVNM, "")
                    }else{
                        handler(nil, message)
                    }
                }else{
                    handler(nil, "Load API Error!")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
    class func updateInfoVNM(address:String, companyName:String, dateOfIssue:String,district:String,dob:String,
                             firstName:String,fullName:String,lastName:String,gender:String, idCard:String,placeOfIssue:String,province:String,mdn:String,taxCode:String,images:String,otp:String, userCode:String,employeeName:String,shopCode:String,shopName:String,shopAddress:String,sub_use_type:String,type_card:String,sub_payment_type:String,handler: @escaping (_ success:UpdateInfoVNMResult?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "address" : "\(address)",
            "companyName" : "\(companyName)",
            "country" : "Vietnam",
            "customer_type" : "1",
            "dateOfIssue" : "\(dateOfIssue)",
            "district" : "\(district)",
            "dob" : "\(dob)",
            "firstName" : "\(firstName)",
            "fullName" : "\(fullName)",
            "lastName" : "\(lastName)",
            "gender" : "\(gender)",
            "idCard" : "\(idCard)",
            "placeOfIssue" : "\(placeOfIssue)",
            "province" : "\(province)",
            "mdn" : "\(mdn)",
            "taxCode" : "\(taxCode)",
            "images" : "\(images)",
            "otp" : "\(otp)",
            "userCode" : "\(userCode)",
            "employeeName" : "\(employeeName)",
            "shopCode" : "\(shopCode)",
            "shopName" : "\(shopName)",
            "shopAddress":"\(shopAddress)",
            "sub_use_type":"\(sub_use_type)",
            "type_card":"\(type_card)",
            "sub_payment_type":"\(sub_payment_type)"
        ]
        
        var dataResult:DataResultInfoUpdateSim?
        
        provider.request(.updateInfoVNM(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                do {
                    let json = try JSON(data: data)
                    let success = json["Success"].boolValue
                    if(success){
                        let data1 = json["Data"]
                        let code = data1["code"].intValue
                        let message = data1["message"].stringValue
                        var dataString = ""
                        if(message == ""){
                            dataString = data1["data"].stringValue
                            
                        }else{
                            let data2 = data1["data"].arrayValue
                            if data2.count > 0 {
                                dataResult = DataResultInfoUpdateSim.parseObjfromArray(array: data2)[0]
                                let updateInfoVNMResult = UpdateInfoVNMResult(code: code, message: message, data: dataString, dataResultInfoUpdateSim: dataResult!)
                                handler(updateInfoVNMResult, "")
                            }else{
                                handler(nil, message)
                            }
                        }
                        handler(nil, message)
                    }else{
                        let data1 = json["Data"].stringValue
                        print(data1)
                        handler(nil, data1)
                    }
                } catch let error {
                    handler(nil, error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
    class func BaoHiem_GetHangXe(usercode:String,shopcode:String,maloaixe:String,handler: @escaping (_ success:[BaoHiem_getHangXeResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "usercode":"\(usercode)",
            "shopcode": "\(shopcode)",
            "maloaixe" : "\(maloaixe)"
        ]
        print("param hang xe: \(parameters)")
        var rs:[BaoHiem_getHangXeResult] = []
        provider.request(.BaoHiem_GetHangXe(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print("hang xe \(json)")
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = BaoHiem_getHangXeResult.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func Get_CardType_From_POS(handler: @escaping (_ success:[CardTypeFromPOSResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "type":"0"
        ]
        var rs:[CardTypeFromPOSResult] = []
        provider.request(.Get_CardType_From_POS(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print("card type: \(json)")
                if let data = json["sp_Get_CardType_From_POSResult"].array {
                    rs = CardTypeFromPOSResult.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                debugPrint(error.localizedDescription)
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func BaoHiem_GetLoaiXe(usercode:String,shopcode:String,handler: @escaping (_ success:[BaoHiem_getLoaiXeResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "usercode":"\(usercode)",
            "shopcode": "\(shopcode)"
        ]
        var rs:[BaoHiem_getLoaiXeResult] = []
        provider.request(.BaoHiem_GetLoaiXe(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = BaoHiem_getLoaiXeResult.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func BaoHiem_GetSP(usercode:String,shopcode:String,maloaixe:String,handler: @escaping (_ success:[BaoHiem_getSPResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "usercode":"\(usercode)",
            "shopcode": "\(shopcode)",
            "maloaixe": "\(maloaixe)"
        ]
        var rs:[BaoHiem_getSPResult] = []
        provider.request(.BaoHiem_GetSP(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = BaoHiem_getSPResult.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func BaoHiem_GetPhuongXa(usercode:String,shopcode:String,matinh:String,mahuyen:String,handler: @escaping (_ success:[BaoHiem_getPhuongXaResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "usercode":"\(usercode)",
            "shopcode": "\(shopcode)",
            "mahuyen": "\(mahuyen)",
            "matinh": "\(matinh)"
        ]
        var rs:[BaoHiem_getPhuongXaResult] = []
        provider.request(.BaoHiem_GetPhuongXa(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = BaoHiem_getPhuongXaResult.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func BaoHiem_GetQuan(usercode:String,shopcode:String,matinh:String,handler: @escaping (_ success:[BaoHiem_getQuanHuyenResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "usercode":"\(usercode)",
            "shopcode": "\(shopcode)",
            "matinh": "\(matinh)"
        ]
        var rs:[BaoHiem_getQuanHuyenResult] = []
        provider.request(.BaoHiem_GetQuan(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print("quan bao hiem: \(json)")
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = BaoHiem_getQuanHuyenResult.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func BaoHiem_GetDungTich(usercode:String,shopcode:String ,maloaixe:String,handler: @escaping (_ success:[BaoHiem_getDungTichResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "usercode":"\(usercode)",
            "shopcode": "\(shopcode)",
            "maloaixe": "\(maloaixe)"
        ]
        var rs:[BaoHiem_getDungTichResult] = []
        provider.request(.BaoHiem_GetDungTich(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = BaoHiem_getDungTichResult.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func BaoHiem_getGiaBan_BHX(usercode:String,shopcode:String ,maloaihinh:String,madoituong:String,loai:String,handler: @escaping (_ success:[BaoHiem_getGiaBanResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "usercode":"\(usercode)",
            "shopcode": "\(shopcode)",
            "maloaihinh": "\(maloaihinh)",
            "madoituong":"\(madoituong)",
            "loai":"\(loai)"
        ]
        var rs:[BaoHiem_getGiaBanResult] = []
        print("param gia \(parameters)")
        provider.request(.BaoHiem_getGiaBan_BHX(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            print("gia ban bao hiem \(json)")
                            rs = BaoHiem_getGiaBanResult.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func BaoHiem_getGiaBanAll_BHX(usercode:String,shopcode:String,handler: @escaping (_ success:[BaoHiem_getGiaBanAllResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "usercode":"\(usercode)",
            "shopcode": "\(shopcode)"
        ]
        var rs:[BaoHiem_getGiaBanAllResult] = []
        provider.request(.BaoHiem_getGiaBanAll_BHX(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = BaoHiem_getGiaBanAllResult.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func BaoHiem_GetToken(Loai:String,handler: @escaping (_ success:BaoHiem_GetTokenResult?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "Loai": "\(Loai)"
        ]
        provider.request(.BaoHiem_GetToken(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let data = json["Data"]
                        let rs = BaoHiem_GetTokenResult.getObjFromDictionary(data: data)
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func BaoHiem_GetTinhThanh(usercode:String,shopcode:String,handler: @escaping (_ success:[BaoHiem_getTinhThanhResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "usercode":"\(usercode)",
            "shopcode": "\(shopcode)"
        ]
        var rs:[BaoHiem_getTinhThanhResult] = []
        provider.request(.BaoHiem_GetTinhThanh(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print("tinh thanh bao hiem: \(json)")
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = BaoHiem_getTinhThanhResult.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func BaoHiem_AddOrder(userCode:String,shopCode:String,codeCrm:String,version:String,deviceType:String,Loai:String,ThanhToanXML:String,ListPaymentMethodCard:String,TotalPaymentCash:String,LoaiThanhToan:String,Quantity:String,Token:String,sale_code:String,motor_owner_name:String,motor_owner_id:String,motor_owner_add:String,motor_owner_mobile:String,motor_num_plate:String,motor_num_chassis:String,motor_num_engine:String,motor_color:String,motor_brand:String,motor_model:String,insurance_motor_addon_pa:String,insurance_effect_from:String,insurance_effect_to:String,buyer_name:String,buyer_add:String,buyer_mobile:String,city_code:String,District_code:String,ward_code:String,insurance_motor_type:String,insurance_motor_object:String,insurance_code:String,premium_main_motor_ctpl:String,premium_total:String,Payment_Status:String,IsAutoCard:String,ReceiverName:String,ReceiverPhone:String,isDiscountByFRT:String,handler: @escaping (_ result: BaoHiem_addOrderResult?,_ resultBody: BaoHiem_addOrderBodyResult?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = ["userCode":userCode,"shopCode":shopCode,"codeCrm":codeCrm,"version":version,"deviceType":deviceType,"Loai":Loai,"ThanhToanXML":ThanhToanXML,"ListPaymentMethodCard":ListPaymentMethodCard,"TotalPaymentCash":TotalPaymentCash,"LoaiThanhToan":LoaiThanhToan,"Quantity":Quantity,"Token":Token,"sale_code":sale_code,"motor_owner_name":motor_owner_name,"motor_owner_id":motor_owner_id,"motor_owner_add":motor_owner_add,"motor_owner_mobile":motor_owner_mobile,"motor_num_plate":motor_num_plate,"motor_num_chassis":motor_num_chassis,"motor_num_engine":motor_num_engine,"motor_color":motor_color,"motor_brand":motor_brand,"motor_model":motor_model,"insurance_motor_addon_pa":insurance_motor_addon_pa,"insurance_effect_from":insurance_effect_from,"insurance_effect_to":insurance_effect_to,"buyer_name":buyer_name,"buyer_add":buyer_add,"buyer_mobile":buyer_mobile,"city_code":city_code,"District_code":District_code,"ward_code":ward_code,"insurance_motor_type":insurance_motor_type,"insurance_motor_object":insurance_motor_object,"insurance_code":insurance_code,"premium_main_motor_ctpl":premium_main_motor_ctpl,"premium_total":premium_total,"Payment_Status":Payment_Status,"IsAutoCard":IsAutoCard,"CheckKM":"","ReceiverName":ReceiverName,"ReceiverPhone":ReceiverPhone,"IsDiscountByFRT":"\(isDiscountByFRT)"]
        print(parameters)
        provider.request(.BaoHiem_AddOrder(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let data1 = json["Data"]
                        let getSelectFromObject = BaoHiem_addOrderResult.getObjFromDictionary(data: data1)
                        
                        if(getSelectFromObject.ResultFRT == "-5")
                        {
                            handler(getSelectFromObject,nil,"")
                        }
                        else
                        {
                            let mObject = data1["taodonhangarray"].arrayValue
                            let ss = BaoHiem_addOrderBodyResult.parseObjfromArray(array: mObject)
                            handler(getSelectFromObject,ss[0],"")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,nil,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,nil,error.localizedDescription)
            }
        }
    }
    class func GetSearchCustomers(phoneNumber: String, cardName: String,numberContract: String,handler: @escaping (_ success:[SearchCustomersResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "phoneNumber":"\(phoneNumber)",
            "cardName": "\(cardName)",
            "numberContract":"\(numberContract)"
        ]
        var rs:[SearchCustomersResult] = []
        provider.request(.GetSearchCustomers(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = SearchCustomersResult.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func GetProvidersNew(MaNV: String, MaShop: String,handler: @escaping (_ result: [GetProvidersNewBody]?, _ result2: [GetProvidersNewHeaders]?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = ["MaNV" : MaNV,"MaShop" : MaShop]
        
        var getSelectFromResultArrayBody = [GetProvidersNewBody]();
        var getSelectFromResultArrayHeader = [GetProvidersNewHeaders]();
        
        provider.request(.GetProvidersNew(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data1 = json["Data"]
                        let jsonObject = data1["ListService"].arrayValue
                        
                        for j in 0..<jsonObject.count
                        {
                            let jsonObjectHeader = jsonObject[j]
                            let getSelectFromObject = GetProvidersNewHeaders.getObjFromDictionary(data: jsonObjectHeader)
                            
                            let jsonArrBody = jsonObject[j]["ListProvider"]
                            for i in 0..<jsonArrBody.count
                            {
                                let jsonObjectBody = jsonArrBody[i];
                                let getSelectFromObjectBody = GetProvidersNewBody.getObjFromDictionary(data: jsonObjectBody)
                                getSelectFromResultArrayBody.append(getSelectFromObjectBody)
                            }
                            getSelectFromResultArrayHeader.append(getSelectFromObject)
                        }
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(getSelectFromResultArrayBody,getSelectFromResultArrayHeader,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,nil,"Load API ERRO")
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,nil,error.localizedDescription)
            }
        }
    }
    class func GetAgumentFtel(MaKHFtel: String, MaShop: String,Province: String,handler: @escaping (_ result: [GetAgumentFtelResultHeader]?, _ result2: [GetAgumentFtelResultBody]?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = ["MaKHFtel" : MaKHFtel,"MaShop" : MaShop,"Province" : Province]
        
        var getSelectFromResultArrayBody = [GetAgumentFtelResultBody]();
        var getSelectFromResultArrayHeader = [GetAgumentFtelResultHeader]();
        debugPrint(parameters)
        provider.request(.GetAgumentFtel(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data1 = json["Data"]
                        let getSelectFromObject = GetAgumentFtelResultHeader.getObjFromDictionary(data: data1)
                        getSelectFromResultArrayHeader.append(getSelectFromObject)
                        if(data1["ReturnCode"].stringValue == "0" )
                        {
                            let jsonBody = data1["ListBill"].arrayValue
                            for i in 0..<jsonBody.count
                            {
                                let jsonBodyObject = jsonBody[i]
                                let getSelectFromObjectBody = GetAgumentFtelResultBody.getObjFromDictionary(data: jsonBodyObject)
                                getSelectFromResultArrayBody.append(getSelectFromObjectBody)
                            }
                            handler(getSelectFromResultArrayHeader,getSelectFromResultArrayBody,"")
                        }
                        else{
                            handler(nil,nil,data1["Description"].stringValue)
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,nil,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,nil,error.localizedDescription)
            }
        }
    }
    class func GetAgumentFtelV2(MaKHFtel: String, MaShop: String,Province: String,handler: @escaping (_ result: FtelBillCustomer?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = ["MaKHFtel" : MaKHFtel,"MaShop" : MaShop,"Province" : Province]
        
        provider.request(.GetAgumentFtel(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let success = json["Success"].bool {
                    if(success){
                        let data1 = json["Data"]
                        let rs = FtelBillCustomer.getObjFromDictionary(data: data1)
                        if(rs.ReturnCode == "0"){
                            handler(rs,"")
                        }else{
                            handler(nil,rs.Description)
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func pushBillThuHo(printBill:PrintBillThuHo) {
        
        let mn = Config.manager
        
        let action = "\(Cache.user!.ShopCode)/push"
        let urlString = "\(mn.URL_PRINT_BILL!)/api/\(action)"
        let manager = Alamofire.Session.default
        if let data =  try? JSONSerialization.data(withJSONObject: printBill.toJSON(), options: []){
            if let jsonData = String(data:data, encoding:.utf8) {
                print(jsonData)
                let billParam = BillParam(title: "Test PrintShare thu hộ", body: jsonData,id: "POS", key: "pos_thuho")
                let billMessage = BillMessage(message:billParam)
                
                if let data2 =  try? JSONSerialization.data(withJSONObject: billMessage.toJSON(), options: []){
                    if let url = URL(string: urlString) {
                        var request = URLRequest(url: url)
                        request.httpMethod = HTTPMethod.post.rawValue
                        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                        request.httpBody = data2
                        manager.request(request).responseJSON {
                            (response) in
                            print(response)
                        }
                    }
                }
            }
        }
    }
    class func GetPaymentFtel(MaNV: String,MaShop: String,DaGoiService: String,Province: String,SoTien: String,MaKHFtel: String,CustomerNameFtel: String,UserName: String,FtelBillList: String,FtelAmountList: String,FtelBillDate: String,BillDescription: String,ListBill: String,devicetype: String,version: String,codecrm: String,MaGDFRT: String,xmlstringpay:String,sdt:String,Diachi:String,handler: @escaping (_ success:[PaymentFtelResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = ["MaNV" : MaNV,"MaShop" : MaShop,"DaGoiService" : DaGoiService,"Province" : Province,"SoTien" : SoTien,"MaKHFtel" : MaKHFtel,"CustomerNameFtel" : CustomerNameFtel,"UserName" : UserName,"FtelBillList" : FtelBillList,"FtelAmountList" : FtelAmountList,"FtelBillDate" : FtelBillDate,"BillDescription" : BillDescription,"ListBill" : ListBill,"devicetype" : devicetype,"version" : version,"codecrm" : codecrm,"MaGDFRT" : MaGDFRT,"xmlstringpay":xmlstringpay,"sdt":sdt,"Diachi":Diachi]
        var rs:[PaymentFtelResult] = []
        provider.request(.GetPaymentFtel(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = PaymentFtelResult.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func GetPaymentFtelV2(MaNV: String,MaShop: String,DaGoiService: String,Province: String,SoTien: String,MaKHFtel: String,CustomerNameFtel: String,UserName: String,FtelBillList: String,FtelAmountList: String,FtelBillDate: String,BillDescription: String,ListBill: String,devicetype: String,version: String,codecrm: String,MaGDFRT: String,xmlstringpay:String,sdt:String,Diachi:String,handler: @escaping (_ success:PaymentFtelResult?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = ["MaNV" : MaNV,"MaShop" : MaShop,"DaGoiService" : DaGoiService,"Province" : Province,"SoTien" : SoTien,"MaKHFtel" : MaKHFtel,"CustomerNameFtel" : CustomerNameFtel,"UserName" : UserName,"FtelBillList" : FtelBillList,"FtelAmountList" : FtelAmountList,"FtelBillDate" : FtelBillDate,"BillDescription" : BillDescription,"ListBill" : ListBill,"devicetype" : devicetype,"version" : version,"codecrm" : codecrm,"MaGDFRT" : MaGDFRT,"xmlstringpay":xmlstringpay,"sdt":sdt,"Diachi":Diachi]
        debugPrint(parameters)
        provider.request(.GetPaymentFtel(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data1 = json["Data"]
                        let rs = PaymentFtelResult.getObjFromDictionary(data: data1)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let data1 = json["Data"].stringValue
                        handler(nil,data1)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func GetBill(WarehouseCode: String, ProviderCode: String,ServiceCode: String, PartnerUserCode: String, CustomerID: String,AgribankProviderCode: String, MomenyAmountReturnCode25: String,handler: @escaping (_ result: [GetBillResult]?, _ result2: [GetBillResultBody]?, _ result3: GetBillResultBodyAgribank? , _ result4: [ListMutiBillResult]?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = ["WarehouseCode" : WarehouseCode,"ProviderCode" : ProviderCode,"ServiceCode" : ServiceCode,"PartnerUserCode":PartnerUserCode,"CustomerID":CustomerID,"AgribankProviderCode" : AgribankProviderCode,"MomenyAmountReturnCode25" : MomenyAmountReturnCode25]
        
        var getSelectFromResultArrayBody = [GetBillResultBody]();
        var getListMutiBillResult = [ListMutiBillResult]();
        var getSelectFromResultArrayHeader = [GetBillResult]();
        debugPrint(parameters)
        provider.request(.GetBill(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        
                        let getSelectFromObject = GetBillResult.getObjFromDictionary(data: data)
                        
                        getSelectFromResultArrayHeader.append(getSelectFromObject)
                        
                        if(data["ReturnCode"].stringValue == "0" )
                        {
                            if(AgribankProviderCode != "")
                            {
                                let jsonBodyAgribank = data["ListDetailAgribank"].arrayValue
                                let getSelectFromResultArrayBodyAgribank = GetBillResultBodyAgribank.getObjFromDictionary(data: jsonBodyAgribank[0])
                                handler(getSelectFromResultArrayHeader,nil,getSelectFromResultArrayBodyAgribank,nil,"")
                            }
                            else
                            {
                                let jsonBody = data["ListDetailPayoo"].arrayValue
                                for i in 0..<jsonBody.count
                                {
                                    let jsonBodyObject = jsonBody[i];
                                    let getSelectFromObjectBody = GetBillResultBody.getObjFromDictionary(data: jsonBodyObject)
                                    getSelectFromResultArrayBody.append(getSelectFromObjectBody)
                                }
                                handler(getSelectFromResultArrayHeader,getSelectFromResultArrayBody,nil,nil,"")
                            }
                        }else if(data["ReturnCode"].stringValue == "3" || data["ReturnCode"].stringValue == "4" || data["ReturnCode"].stringValue == "-1")
                        {
                            handler(getSelectFromResultArrayHeader,nil,nil,nil,"")
                            
                        }
                        else if(data["ReturnCode"].stringValue == "-25" )
                        {
                            
                            let jsonBody = data["ListMutiBill"].arrayValue
                            for i in 0..<jsonBody.count
                            {
                                let jsonBodyObject = jsonBody[i];
                                let getListMutiBill = ListMutiBillResult.getObjFromDictionary(data: jsonBodyObject)
                                getListMutiBillResult.append(getListMutiBill)
                            }
                            handler(getSelectFromResultArrayHeader,nil,nil,getListMutiBillResult,"")
                            
                        }else if(data["ReturnCode"].stringValue == "-9" )
                        {
                            
                            let jsonBody = data["Description"].stringValue
                            
                            handler(nil,nil,nil,nil,jsonBody)
                            
                        }
                            
                        else{
                            handler(nil,nil,nil,nil,"Loi")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,nil,nil,nil,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,nil,nil,nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,nil,nil,nil,error.localizedDescription)
            }
        }
    }
    class func GetListCustomer(SearchValue: String, Type: String, Province: String,handler: @escaping (_ success:[GetListCustomerResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = ["SearchValue" : SearchValue,"Type" : Type,"Province": Province]
        var getResultArr = [GetListCustomerResult]();
        provider.request(.GetListCustomer(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let data = json["Data"]
                        if(data["ReturnCode"].stringValue == "0" )
                        {
                            let jsonObject = data["ListDetail"].arrayValue
                            for j in 0..<jsonObject.count
                            {
                                let jsonObject = jsonObject[j];
                                let getSelectFromObject = GetListCustomerResult.getObjFromDictionary(data: jsonObject)
                                getResultArr.append(getSelectFromObject)
                            }
                            handler(getResultArr,"")
                        }
                        else
                        {
                            handler(getResultArr,"Loi API")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(getResultArr,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(getResultArr,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(getResultArr,error.localizedDescription)
            }
        }
    }
    class func GetListCustomerV2(SearchValue: String, Type: String, Province: String,handler: @escaping (_ success:[GetListCustomerResult],_ error:String) ->Void){
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
            let parameters = ["SearchValue" : SearchValue,"Type" : Type,"Province": Province]
            var getResultArr = [GetListCustomerResult]();
            provider.request(.GetListCustomer(param:parameters)){ result in
                switch result {
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    guard let json = try? JSON(data: data) else {
                        handler(getResultArr,"Load API ERRO")
                        return
                    }
                    debugPrint(json)
                    if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let data = json["Data"]
                        if(data["ReturnCode"].stringValue == "0")
                        {
                            let jsonObject = data["ListDetail"].arrayValue
                            for j in 0..<jsonObject.count
                            {
                                let jsonObject = jsonObject[j];
                                let getSelectFromObject = GetListCustomerResult.getObjFromDictionary(data: jsonObject)
                                getResultArr.append(getSelectFromObject)
                            }
                            handler(getResultArr,"")
                        }
                        else
                        {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            let data = json["Data"]
                            let ms = data["Description"].stringValue
                            handler(getResultArr,ms)
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let data = json["Data"]
                        let ms = data["Description"].stringValue
                        handler(getResultArr,ms)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(getResultArr,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(getResultArr,error.localizedDescription)
            }
        }
    }
    class func GetEncashAgribankResult(PartnerCode: String, SoTien: String, MaShop: String,MaKH: String,TenKH: String, CMNDKH: String, TenCtyKH: String, AgribankProviderCode: String, ListBill: String, MaGDFRT: String ,devicetype: String, version:String , codecrm:String , MaNV: String,xmlstringpay:String ,phonenumber:String,handler: @escaping (_ success:EncashAgribankResult?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = ["PartnerCode" : PartnerCode,"SoTien" : SoTien,"MaShop" : MaShop,"MaKH":MaKH,"TenKH" : TenKH,"CMNDKH" : CMNDKH,"TenCtyKH" : TenCtyKH,"AgribankProviderCode" : AgribankProviderCode,"ListBill" : ListBill ,"devicetype": devicetype, "version":"2" , "codecrm":codecrm , "MaNV": MaNV ,"xmlstringpay":xmlstringpay,"phonenumber":phonenumber]
        provider.request(.GetEncashAgribankResult(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        let rs = EncashAgribankResult.getObjFromDictionary(data: data)
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func GetEncashpayooResult(PartnerCode: String, IsOffline: String, MaDichVu: String,MaNhaCungCap: String,SoTien: String, MaShop: String, TenDichVu: String, TenNCC: String, MaKH: String, TenKH: String, DiaChiNguoiDong: String,SDT :String,ChuTheANZ: String, SoTheANZ: String, PaymentRule: String,PhiThuHo: String,ListBill: String, IsCalledService: String,MaGDFRT:String , devicetype: String, version:String , codecrm:String , MaNV: String ,PaymentFeeType:String, PercentFee:String ,ConstantFee:String , MaxFee:String, MinFee:String,PaymentRange:String,xmlstringpay:String,handler: @escaping (_ success:EncashpayooResult?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = ["PartnerCode" : PartnerCode,"IsOffline" : IsOffline,"MaDichVu" : MaDichVu,"MaNhaCungCap":MaNhaCungCap,"SoTien":SoTien,"MaShop" : MaShop,"TenDichVu" : TenDichVu,"TenNCC" : TenNCC,"MaKH" : MaKH,"TenKH" : TenKH,"DiaChiNguoiDong" : DiaChiNguoiDong,"SDT" : SDT,"ChuTheANZ" : ChuTheANZ,"SoTheANZ" : SoTheANZ,"PaymentRule" : PaymentRule,"PhiThuHo":PhiThuHo,"ListBill":ListBill,"IsCalledService" : IsCalledService,"MaGDFRT" : MaGDFRT , "devicetype": devicetype, "version":version , "codecrm":codecrm , "MaNV": MaNV ,"PaymentFeeType":PaymentFeeType, "PercentFee":PercentFee ,"ConstantFee":ConstantFee , "MaxFee":MaxFee, "MinFee":MinFee,"PaymentRange":PaymentRange,"xmlstringpay":xmlstringpay]
        
        debugPrint(parameters)
        provider.request(.GetEncashpayooResult(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let success = json?["Success"].bool {
                    if(success){
                        let data = json!["Data"]
                        let rs = EncashpayooResult.getObjFromDictionary(data: data)
                        handler(rs,"")
                    }else{
                        let data = json?["Data"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,data ?? "LOAD API ERROR ")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func GetFtelLocations(MaNV: String, MaShop: String,handler: @escaping (_ success:[GetFtelLocationsResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = ["MaNV" : MaNV,"MaShop" : MaShop]
        var getFtelLocationsResultArr = [GetFtelLocationsResult]();
        provider.request(.GetFtelLocations(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let data = json["Data"]
                        if(data["ReturnCode"].stringValue == "0" )
                        {
                            let jsonObject = data["ListProvinceFtel"].arrayValue
                            for j in 0..<jsonObject.count
                            {
                                let jsonObject = jsonObject[j];
                                let getSelectFromObject = GetFtelLocationsResult.getObjFromDictionary(data: jsonObject)
                                getFtelLocationsResultArr.append(getSelectFromObject)
                            }
                            handler(getFtelLocationsResultArr,"")
                        }
                        else
                        {
                            handler(getFtelLocationsResultArr,"Loi API")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(getFtelLocationsResultArr,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(getFtelLocationsResultArr,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(getFtelLocationsResultArr,error.localizedDescription)
            }
        }
    }
    class func GetFtelLocationsV2(MaNV: String, MaShop: String,handler: @escaping (_ success:[GetFtelLocationsResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = ["MaNV" : MaNV,"MaShop" : MaShop]
        var getFtelLocationsResultArr = [GetFtelLocationsResult]();
        provider.request(.GetFtelLocations(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let data = json["Data"]
                        if(data["ReturnCode"].stringValue == "0" )
                        {
                            let jsonObject = data["ListProvinceFtel"].arrayValue
                            for j in 0..<jsonObject.count
                            {
                                let jsonObject = jsonObject[j];
                                let getSelectFromObject = GetFtelLocationsResult.getObjFromDictionary(data: jsonObject)
                                getFtelLocationsResultArr.append(getSelectFromObject)
                            }
                            handler(getFtelLocationsResultArr,"")
                        }
                        else
                        {
                            handler(getFtelLocationsResultArr,"Loi API")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(getFtelLocationsResultArr,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(getFtelLocationsResultArr,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(getFtelLocationsResultArr,error.localizedDescription)
            }
        }
    }
    
    class func pushBillTopUpCard(printBill:CardCodePayooTopUp) {
        
        let mn = Config.manager
        let action = "\(Cache.user!.ShopCode)/push"
        let urlString = "\(mn.URL_PRINT_BILL!)/api/\(action)"
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 160
        
        if let data =  try? JSONSerialization.data(withJSONObject: printBill.toJSON(), options: []){
            if let jsonData = String(data:data, encoding:.utf8) {
                print(jsonData)
                let billParam = BillParam(title: "In Top Up", body: jsonData,id: "POS", key: "pos_topup")
                let billMessage = BillMessage(message:billParam)
                
                print("\(urlString) \(billMessage.toJSON())")
                if let data2 =  try? JSONSerialization.data(withJSONObject: billMessage.toJSON(), options: []){
                    if let url = URL(string: urlString) {
                        var request = URLRequest(url: url)
                        request.httpMethod = HTTPMethod.post.rawValue
                        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                        request.httpBody = data2
                        manager.request(request).responseJSON {
                            (response) in
                            print(response)
                        }
                    }
                }
            }
        }
    }
    class func pushBillCard(printBill:PrintBillCard) {
        
        let mn = Config.manager
        let action = "\(Cache.user!.ShopCode)/push"
        let urlString = "\(mn.URL_PRINT_BILL!)/api/\(action)"
        let manager = Alamofire.Session.default
        if let data =  try? JSONSerialization.data(withJSONObject: printBill.toJSON(), options: []){
            if let jsonData = String(data:data, encoding:.utf8) {
                print(jsonData)
                let billParam = BillParam(title: "In key the cao", body: jsonData,id: "POS", key: "pos_thecao")
                let billMessage = BillMessage(message:billParam)
                debugPrint(billMessage.toJSON())
                if let data2 =  try? JSONSerialization.data(withJSONObject: billMessage.toJSON(), options: []){
                    if let url = URL(string: urlString) {
                        var request = URLRequest(url: url)
                        request.httpMethod = HTTPMethod.post.rawValue
                        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                        request.httpBody = data2
                        manager.request(request).responseJSON {
                            (response) in
                            print(response)
                        }
                    }
                }
            }
        }
    }
    class func GetPayCodePrice(providerId: String, cardValue: String,handler: @escaping (_ success:GetPayCodePriceResult?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters = [
            "providerId" : providerId,
            "cardValue" : cardValue
        ]
        provider.request(.GetPayCodePrice(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        let rs = GetPayCodePriceResult.getObjFromDictionary(data: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func GetPayCodeList(shopCode: String, userCode: String,handler: @escaping (_ success:[GetPayCodeListResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "shopCode" : shopCode,
            "userCode" : userCode
        ]
        var rs:[GetPayCodeListResult] = []
        provider.request(.GetPayCodeList(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = GetPayCodeListResult.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func GetPayooPayResult(UserID: String, ShopCode: String, CardValue: String,ProviderId: String,Quantity: String, TotalPurchasingAmount: String, TotalReferAmount: String, PhoneNumber: String, xmlstringpay: String, devicetype: String, version: String,codecrm :String,isCheckPromotion:String,OTPNumber:String,ValuePromotion:String,is_HeThongHD:Int,handler: @escaping (_ resultObject: PayooPayCodeResult? , _ resultObjectHeader:PayooPayCodeHeaderResult?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "UserID" : UserID,"ShopCode" : ShopCode,"CardValue" : CardValue,"ProviderId":ProviderId,"Quantity":Quantity,"TotalPurchasingAmount" : TotalPurchasingAmount,"TotalReferAmount" : TotalReferAmount,"PhoneNumber" : PhoneNumber,"xmlstringpay" : xmlstringpay,"devicetype" : devicetype,"version": version,"codecrm": codecrm,"isCheckPromotion":isCheckPromotion,"OTPNumber":OTPNumber,"ValuePromotion":ValuePromotion,"is_HeThongHD":"\(is_HeThongHD)"
        ]
        debugPrint(parameters)
        provider.request(.GetPayooPayResult(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        let data = json!["Data"]
                        let getSelectFromObject = PayooPayCodeResult.getObjFromDictionary(data: data)
                        let getSelectFromObjectHeader = PayooPayCodeHeaderResult.getObjFromDictionary(data: json!)
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(getSelectFromObject,getSelectFromObjectHeader,"")
                        
                    }else{
                        let data = json?["Data"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,nil,data ?? "Load API Error !")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,nil,error.localizedDescription)
            }
        }
    }
    class func GetViettelPayResult(UserID: String, ShopCode: String, CardValue: String,ProviderId: String,Quantity: String, TotalPurchasingAmount: String, TotalReferAmount: String, PhoneNumber: String, xmlstringpay: String, devicetype: String, version: String,codecrm :String,isCheckPromotion:String,OTPNumber:String,ValuePromotion:String,is_HeThongHD:Int,handler: @escaping (_ resultObject: ViettelPayCodeResult?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "UserID" : UserID,"ShopCode" : ShopCode,"CardValue" : CardValue,"ProviderId":ProviderId,"Quantity":Quantity,"TotalPurchasingAmount" : TotalPurchasingAmount,"TotalReferAmount" : TotalReferAmount,"PhoneNumber" : PhoneNumber,"xmlstringpay" : xmlstringpay,"devicetype" : devicetype,"version": version,"codecrm": codecrm,"isCheckPromotion":isCheckPromotion,"OTPNumber":OTPNumber,"ValuePromotion":ValuePromotion,"SubId":"23","is_HeThongHD":"\(is_HeThongHD)"
        ]
        //SubId = 23 hardcode
        debugPrint(parameters)
        provider.request(.GetViettelPayResult(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                guard let json = try? JSON(data: data) else{
                    handler(nil,"Load API ERROR")
                    return
                }
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        let getSelectFromObject = ViettelPayCodeResult.getObjFromDictionary(data: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if(getSelectFromObject.error_code == "00"){
                            let Tu_ngay = json["Tu_ngay"].stringValue
                            let Den_Ngay = json["Den_Ngay"].stringValue
                            let u_vocher = json["u_vocher"].stringValue
                            let u_Vchname = json["u_Vchname"].stringValue
                            getSelectFromObject.Tu_ngay = Tu_ngay
                            getSelectFromObject.Den_Ngay = Den_Ngay
                            getSelectFromObject.u_vocher = u_vocher
                            getSelectFromObject.u_Vchname = u_Vchname
                            handler(getSelectFromObject,"")
                        }else{
                            handler(nil,getSelectFromObject.error_msg)
                        }
                    }else{
                        let data = json["Message"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,data)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    
    class func GetPayooTopup(UserID: String, ShopCode: String, CardValue: String, TotalPurchasingAmount: String, TotalReferAmount: String, PhoneNumber: String, xmlstringpay: String, devicetype: String, version: String,codecrm: String,isCheckPromotion:String,OTPNumber:String,ValuePromotion:String,ProviderId:String,is_HeThongHD:Int,handler: @escaping (_ result: PayooTopupResult?, _ mObjectHeader:PayooPayCodeHeaderResult?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "UserID" : UserID,
            "ShopCode" : ShopCode,
            "CardValue" : CardValue,
            "TotalPurchasingAmount" : TotalPurchasingAmount,
            "TotalReferAmount" : TotalReferAmount,
            "PhoneNumber" : PhoneNumber,
            "xmlstringpay" : xmlstringpay,
            "devicetype" : devicetype,
            "version" : version,
            "codecrm" : codecrm
            ,"isCheckPromotion":isCheckPromotion,"OTPNumber":OTPNumber,"ValuePromotion":ValuePromotion,"ProviderId":ProviderId,
             "is_HeThongHD":"\(is_HeThongHD)"
        ]
        debugPrint(parameters)
        provider.request(.GetPayooTopup(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        let data = json!["Data"]
                        
                        let getSelectFromObject = PayooTopupResult.getObjFromDictionary(data: data)
                        let mObjectHeader = PayooPayCodeHeaderResult.getObjFromDictionary(data: json!)
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(getSelectFromObject,mObjectHeader,"")
                        
                    }else{
                        let data = json?["Data"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,nil,data ?? "LOAD API ERROR !")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,nil,error.localizedDescription)
            }
        }
    }
    class func GetVietNamMobileTheCaoPayResult(UserID: String, ShopCode: String, CardValue: String,ProviderId: String,Quantity: String, TotalPurchasingAmount: String, TotalReferAmount: String, PhoneNumber: String, xmlstringpay: String, devicetype: String, version: String,codecrm :String,is_HeThongHD:Int,handler: @escaping (_ resultObject: TheCao_VietNamMobile? , _ resultObjectHeader:TheCao_VietNamMobileHeaders?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "UserID" : UserID,"ShopCode" : ShopCode,"CardValue" : CardValue,"ProviderId":ProviderId,"Quantity":Quantity,"TotalPurchasingAmount" : TotalPurchasingAmount,"TotalReferAmount" : TotalReferAmount,"PhoneNumber" : PhoneNumber,"xmlstringpay" : xmlstringpay,"devicetype" : devicetype,"version" : version,"codecrm" : codecrm,"is_HeThongHD":"\(is_HeThongHD)"
        ]
        provider.request(.GetVietNamMobileTheCaoPayResult(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        
                        let getSelectFromObject = TheCao_VietNamMobile.getObjFromDictionary(data: data)
                        let mObjectHeader = TheCao_VietNamMobileHeaders.getObjFromDictionary(data: json)
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(getSelectFromObject,mObjectHeader,"")
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,nil,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,nil,error.localizedDescription)
            }
        }
    }
    class func GetTopupVNM(UserID: String, ShopCode: String,ProviderId: String, CardValue: String, TotalPurchasingAmount: String, TotalReferAmount: String, PhoneNumber: String, xmlstringpay: String, devicetype: String, version: String,codecrm: String,isCheckPromotion:String,OTPNumber:String,ValuePromotion:String,is_HeThongHD:Int,handler: @escaping (_ resultObject: PayooTopupResult? , _ resultObjectHeader:PayooPayCodeHeaderResult?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters = [
            "UserID" : UserID,"ShopCode" : ShopCode,"ProviderId" : ProviderId,"CardValue" : CardValue,"TotalPurchasingAmount" : TotalPurchasingAmount,"TotalReferAmount" : TotalReferAmount,"PhoneNumber" : PhoneNumber,"xmlstringpay" : xmlstringpay,"devicetype" : devicetype,"version" : version,"codecrm" : codecrm,"isCheckPromotion":isCheckPromotion,"OTPNumber":OTPNumber,"ValuePromotion":ValuePromotion,"is_HeThongHD":"\(is_HeThongHD)"]
        log.debug(parameters)
        provider.request(.GetTopupVNM(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        
                        let getSelectFromObject = PayooTopupResult.getObjFromDictionary(data: data)
                        let mObjectHeader = PayooPayCodeHeaderResult.getObjFromDictionary(data: json)
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(getSelectFromObject,mObjectHeader,"")
                        
                    }else{
                        let message = json["Message"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,nil,message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,nil,error.localizedDescription)
            }
        }
    }
    class func GetCheckVoucher(userID: String, voucherNum: String,handler: @escaping (_ result: CheckVoucherResult?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "userID" : userID,
            "voucherNum" : voucherNum
        ]
        provider.request(.GetCheckVoucher(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        let getSelectFromObject = CheckVoucherResult.getObjFromDictionary(data: data,voucher:voucherNum)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(getSelectFromObject,"")
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,"")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    
    class func GetTopUpPrice(phoneNumber: String, cardValue: String,handler: @escaping (_ result: GetTopUpPriceResult?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "phoneNumber" : phoneNumber,
            "cardValue" : cardValue
        ]
        provider.request(.GetTopUpPrice(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        
                        let rs = GetTopUpPriceResult.getObjFromDictionary(data: data)
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                        
                    }else{
                        let data = json["Data"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,data)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func GetTopUpList(phoneNumber: String,shopCode: String ,userCode: String,handler: @escaping (_ result: [GetTopUpListResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "phoneNumber" : phoneNumber,
            "shopCode" : shopCode,
            "userCode" : userCode
        ]
        var rs:[GetTopUpListResult] = []
        provider.request(.GetTopUpList(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = GetTopUpListResult.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getThongTinDatCoc(userCode:String,shopCode:String,handler: @escaping (_ result: [DepositInfo],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        let parameters = [
            "userCode" : userCode,
            "shopCode" : shopCode,
            "CRMCode": crm ?? "",
            "Token":"\(Cache.user!.Token)"
        ]
        var rs:[DepositInfo] = []
        provider.request(.getThongTinDatCoc(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = DepositInfo.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getPriceGoiBH(IMEI:String,InsuranceCode:String,priceMainProduct:String,completion: @escaping ((InsuranceCodeItem?, String) ->Void)){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "IMEI" : IMEI,
            "InsuranceCode" : InsuranceCode,    
            "Price" : priceMainProduct
        ]
        provider.request(.getPriceGoiBH(param:parameters)){ result in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    print("return value: \(json)")
                    let rs = InsuranceCodeItem.getObjFromDictionary(map: json)
                    if rs.message?.message_Code != 200 {
                        completion(nil,rs.message?.message_Desc ?? "Đã xảy ra lỗi \(rs.message?.message_Code ?? 0)")
                    } else {
                        completion(rs,"")
                    }
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    class func mpos_sp_GetInfoSubsidy(imei:String,sdt:String,handler: @escaping (_ success:InfoSubsidy?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        let parameters = [
            "imei" : imei,
            "sdt" : sdt,
            "CRMCode": crm ?? "",
            "Token":"\(Cache.user!.Token)"
        ]
        provider.request(.mpos_sp_GetInfoSubsidy(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                
                let data1 = json["mpos_sp_GetInfoSubsidyResult"]
                let rs = InfoSubsidy.getObjFromDictionary(data: data1)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,"")
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func GetPasscode_Form2Key(tokenapi:String,pass:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")!
        let parameters = [
            "tokenapi" : tokenapi,
            "pass" : pass,
            "CRMCode": crm,
            "Token":"\(Cache.user!.Token)"
        ]
        provider.request(.GetPasscode_Form2Key(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                var data1 = json["mPOS_sp_GetPasscode_Form2KeyResult"].string
                data1 = data1 == nil ? "" : data1
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(data1!,"")
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func getListNCC(handler: @escaping (_ success:[NhaCungCap],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var list:[NhaCungCap] = []
        let parameters: [String: String] = [
            "UserID" : "\(Cache.user!.UserName)",
            "MaShop": "\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.getListNCC(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
             
                if let success = json?["Success"].bool {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if(success){
                        if let data = json?["Data"].array {
                            
                            list = NhaCungCap.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"Load API ERROR")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(list,"Data not found!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,error.localizedDescription)
            }
        }
    }
    class func getListPOAll(MaNCC:String,handler: @escaping (_ success:[POAll],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var list:[POAll] = []
        let parameters: [String: String] = [
            "UserID" : "\(Cache.user!.UserName)",
            "MaShop": "\(Cache.user!.ShopCode)",
            "MaNCC": "\(MaNCC)"
        ]
        provider.request(.getListPOAll(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                
                if let success = json?["Success"].bool {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if(success){
                        if let data = json?["Data"].array {
                            
                            list = POAll.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"Load API ERROR")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(list,"Data not found!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,error.localizedDescription)
            }
        }
    }
    class func insertXMLNhapHang(MaNCC:String,stringxml:String,handler: @escaping (_ success:InsertNhapHangResult,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let insertXMLResult:InsertNhapHangResult = InsertNhapHangResult(Success: false,Result: "",Message:"")
        let parameters: [String: String] = [
            "MaShop" : "\(Cache.user!.ShopCode)",
            "UserID": "\(Cache.user!.UserName)",
            "MaNCC": "\(MaNCC)",
            "TenNCC": "\(Cache.user!.UserName)",
            "stringxml": "\(stringxml)",
            "DiviceType": "2"
        ]
        print(parameters)
        provider.request(.insertXMLNhapHang(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
              
                if let success = json?["Success"].bool {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    let kq = json?["Result"].stringValue
                    let message = json?["Message"].stringValue
                    
                    insertXMLResult.Success = success
                    insertXMLResult.Result = kq ?? ""
                    insertXMLResult.Message = message ?? ""
                    handler(insertXMLResult,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(insertXMLResult,"Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(insertXMLResult,error.localizedDescription)
            }
        }
    }
    class func getHistoryNhapHang(handler: @escaping (_ success:[LichSuNhapPO],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var list:[LichSuNhapPO] = []
        let parameters: [String: String] = [
            "User" : "\(Cache.user!.UserName)",
            "MaShop": "\(Cache.user!.ShopCode)"
        ]
        provider.request(.getHistoryNhapHang(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
             
                
                if let success = json?["Success"].bool {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if(success){
                        if let data = json?["Data"].array {
                            
                            list = LichSuNhapPO.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"Load API ERROR")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(list,"Data not found!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,error.localizedDescription)
            }
        }
    }
    class func searchCNMD_subsidy(cmnd:String,usercode:String,handler: @escaping (_ success:[SubsidyOrder],_ IsLogin:String,_ p_Status:String,_ message:String,_ Flag_CreateCallLog:Int,_ infoCallLog:InfoCallLogSearchCMND,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var infoCallLogSearchCMND:InfoCallLogSearchCMND = InfoCallLogSearchCMND(IDCallLog:0
            , GhiChu: ""
            , TrangThaiCallLog: "")
        var list:[SubsidyOrder] = []
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")!
        let parameters: [String: String] = [
            "cmnd" : "\(cmnd)",
            "usercode": "\(Cache.user!.UserName)",
            "CRMCode": "\(crm)",
            "Token":"\(Cache.user!.Token)"
            
        ]
        print(parameters)
        provider.request(.searchCNMD_subsidy(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                
                let suc = json["Success"].bool
                let IsLogin = json["IsLogin"].string
                let p_Status = json["p_Status"].string
                let p_Message = json["p_Message"].string
                if(IsLogin == "1"){
                    handler(list,IsLogin!,p_Status!,"",0,infoCallLogSearchCMND,p_Message!)
                    
                }else{
                    if(p_Status == "0"){
                        handler(list,IsLogin!,p_Status!,"",0,infoCallLogSearchCMND,p_Message!)
                    }else{
                        if(suc!){
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            let data = json["Data"]
                            if let subsidyOrders = data["SubsidyOrders"].array{
                                list = SubsidyOrder.parseObjfromArray(array: subsidyOrders)
                                let returnMessage = data["ReturnMessage"]
                                
                                //                                    var p_status = returnMessage["p_status"] as? Int
                                let messagess = returnMessage["messagess"].stringValue
                                let Flag_CreateCallLog = returnMessage["Flag_CreateCallLog"].int
                                
                                let infoCalllog = data["InfoCallLog"]
                                infoCallLogSearchCMND = InfoCallLogSearchCMND.getObjFromDictionary(data: infoCalllog)
                                handler(list,IsLogin!,p_Status!,messagess,Flag_CreateCallLog!,infoCallLogSearchCMND,"")
                            }else{
                                handler(list,IsLogin!,p_Status!,"",0,infoCallLogSearchCMND,"SubsidyOrders not found!")
                            }
                        }else{
                            handler(list,IsLogin!,p_Status!,"",0,infoCallLogSearchCMND,"Success value false!")
                            
                        }
                    }
                }
                
                //                if let success = json["Success"].bool {
                //                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //                    if(success){
                //                        if let data = json["Data"].array {
                //
                //                            list = LichSuNhapPO.parseObjfromArray(array: data)
                //                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //                            handler(list,"")
                //                        }else{
                //                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //                            handler(list,"Load API ERROR")
                //                        }
                //                    }else{
                //                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //                        handler(list,"Data not found!")
                //                    }
                //                }else{
                //                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //                    handler(list,"Load API ERROR")
            //                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,"","","",0,infoCallLogSearchCMND,error.localizedDescription)
            }
        }
    }
    class func checkCICKhachHang(CMNDKH:String,handler: @escaping (_ success:[CICKhachHang],_ message:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var list:[CICKhachHang] = []
        let parameters: [String: String] = [
            "CMNDKH" : CMNDKH,
            "User": "\(Cache.user!.UserName)",
            "ShopCode": "\(Cache.user!.ShopCode)"
        ]
        provider.request(.checkCICKhachHang(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                if let success = json["Success"].bool {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let message = json["Message"].string
                    if(success){
                        if let data = json["Data"].array {
                            list = CICKhachHang.parseObjfromArray(array: data)
                            
                            handler(list,message!,"")
                        } else {
                            handler(list,message!,"Data not found!")
                        }
                    }else{
                        handler(list,message!,"Success value false!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"","Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,"",error.localizedDescription)
            }
        }
    }
    class func uploadImageLockDevice(CMND:String,base64:String,type:String,handler: @escaping (_ success:UploadImageLockDevideResult,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let result2:UploadImageLockDevideResult = UploadImageLockDevideResult(Success: false,Url: "",Message:"")
        let parameters: [String: String] = [
            "CMND" : "\(CMND)",
            "Base64": "\(base64)",
            "MaShop": "\(Cache.user!.ShopCode)",
            "TenShop": "\(Cache.user!.ShopName)",
            "EplName": "\(Cache.user!.EmployeeName)",
            "Type": "\(type)",
            "DiviceType": "2"
        ]
        provider.request(.uploadImageLockDevice(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                if let success = json["Success"].bool {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if(success){
                        
                        let kq = json["Url"].stringValue
                        let message = json["Message"].stringValue
                        
                        
                        result2.Success = success
                        result2.Url = kq
                        result2.Message = message
                        
                        handler(result2,"")
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(result2,"Data not found!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(result2,"Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(result2,error.localizedDescription)
            }
        }
    }
    class func hoantatLockDevice(Device:String,url_cmnd_matTruoc:String,url_cmnd_matsau:String,url_PhieuCamKet:String,handler: @escaping (_ success:HoanTatResult,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let result2:HoanTatResult = HoanTatResult(Success: false,Message:"")
        let parameters: [String: String] = [
            "Device": "\(Device)",
            "UserID": "\(Cache.user!.UserName)",
            "MaShop": "\(Cache.user!.ShopCode)",
            "Note": "\("")",
            "url_cmnd_matTruoc": "\(url_cmnd_matTruoc)",
            "url_cmnd_matsau": "\(url_cmnd_matsau)",
            "url_PhieuCamKet": "\(url_PhieuCamKet)",
            "DiviceType": "2"
        ]
        provider.request(.hoantatLockDevice(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                if let success = json["Success"].bool {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if(success){
                        let message = json["Message"].stringValue
                        
                        result2.Success = success
                        
                        result2.Message = message
                        handler(result2,"")
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(result2,"Data not found!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(result2,"Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(result2,error.localizedDescription)
            }
        }
    }
    class func loadInfoLockDevice(CMND:String,handler: @escaping (_ success:[InfoLockDevide],_ IsLogin:String,_ p_Status:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var list:[InfoLockDevide] = []
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")!
        let parameters: [String: String] = [
            "CMND" : CMND,
            "UserID": "\(Cache.user!.UserName)",
            "CRMCode": "\(crm)",
            "Token":"\(Cache.user!.Token)"
        ]
        provider.request(.loadInfoLockDevice(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                if let success = json["Success"].bool {
                    let IsLogin = json["IsLogin"].stringValue
                    let p_Status = json["p_Status"].stringValue
                    let p_Message = json["p_Message"].stringValue
                    if(IsLogin == "1"){
                        handler(list,IsLogin,p_Status,p_Message)
                    }else{
                        if(p_Status == "0"){
                            handler(list,IsLogin,p_Status,p_Message)
                        }else{
                            if(success){
                                if let data = json["Data"].array {
                                    list = InfoLockDevide.parseObjfromArray(array: data)
                                    handler(list,IsLogin,p_Status,"")
                                } else {
                                    handler(list,IsLogin,p_Status,"Data not found!")
                                }
                            }else{
                                handler(list,IsLogin,p_Status,"Success value false!")
                            }
                        }
                        
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"","","Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,"","",error.localizedDescription)
            }
        }
    }
    class func GoiPopupHang_Mobile(p_MaPhieuBH: String,handler: @escaping (_ error: Error?, _ success: Bool, _ result: GoiPopupHang_MobileResult?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        
        let parameters = ["p_MaPhieuBH": p_MaPhieuBH]
        print(parameters)
        provider.request(.GoiPopupHang_Mobile(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let taskData = json["mPOSWarranty_sp_GoiPopupHang_MobileResult"]
                let jsonObject = taskData;
                let getSelectFromObject = GoiPopupHang_MobileResult.init(GoiPopupHang_MobileResult: jsonObject)
                handler(nil,true,getSelectFromObject)
            case .failure(_):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //                handler(list,"",error.localizedDescription)
                handler(nil,true,nil)
            }
        }
    }
    class func TaoPhieuBH_AutoMailChoHang(p_MaPhieuBH: String,p_BuocKiemTra:String,p_KetLuan:String,p_MalinhKien:String,p_GhiChu:String,p_Type:String,handler: @escaping (_ error: Error?, _ success: Bool, _ result: AutoMailChoHangResult?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        //        var getSelectFromResultArrayBody = [TaoPhieuBH_NgayHenTraResult]();
        
        let parameters = ["p_MaPhieuBH": p_MaPhieuBH,"p_BuocKiemTra":p_BuocKiemTra,"p_KetLuan":p_KetLuan,"p_MalinhKien":p_MalinhKien,"p_GhiChu":p_GhiChu,"p_Type":p_Type]
        
        print(parameters)
        provider.request(.TaoPhieuBH_AutoMailChoHang(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                
                let taskData = json["mPOSWarranty_sp_TaoPhieuBH_AutoMailChoHangResult"]
                let jsonObject = taskData;
                let getSelectFromObject = AutoMailChoHangResult.init(AutoMailChoHangResult: jsonObject)
                
                handler(nil,true,getSelectFromObject)
                
            case .failure(_):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //handler(list,"",error.localizedDescription)
                handler(nil,true,nil)
            }
        }
    }
    class func Checkimei_V2(p_Imei: String,p_BILL: String,p_SO_DocNum: String,p_PhoneNumber: String,p_Type: String,handler: @escaping (_ error: Error?, _ success: Bool, _ result: [Checkimei_V2Result]?,_ result2: Checkimei_V2_ImeiInfoServices_Result?,_ result3: [Checkimei_V2_LoadHTBH_Result]?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var getSelectFromResultArrayBody = [Checkimei_V2Result]();
        //        var getSelectFromResultArrayBody2 = [Checkimei_V2_ImeiInfoServices_Result]();
        var getSelectFromResultArrayBody3 = [Checkimei_V2_LoadHTBH_Result]();
        
        let parameters = ["p_Imei" : p_Imei,"p_BILL" : p_BILL,"p_SO_DocNum" : p_SO_DocNum,"p_PhoneNumber" : p_PhoneNumber,"p_Type" : p_Type]
        print(parameters)
        provider.request(.Checkimei_V2(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                guard let json = try? JSON(data: data) else {
                    handler(nil,false,nil,nil,nil)
                    return
                }
                print(json)
                let taskData = json["mPOSWarranty_sp_Checkimei_V2Result"]
                let dataHeaderMainV2 = taskData["mPOSWarranty_ImeiInfoResult"]
                
                for i in 0..<dataHeaderMainV2.count
                {
                    let jsonObject = dataHeaderMainV2[i];
                    let getSelectFromObject = Checkimei_V2Result.init(Checkimei_V2Result: jsonObject)
                    getSelectFromResultArrayBody.append(getSelectFromObject)
                }
                //////
                let dataHeaderMainV2_result2 = taskData["mPOSWarranty_ImeiInfoServicesResult"]
                let getSelectFromObject2 = Checkimei_V2_ImeiInfoServices_Result.init(Checkimei_V2_ImeiInfoServices_Result: dataHeaderMainV2_result2)
                //////
                
                let dataHeaderMainV2_result3 = taskData["mPOSWarranty_LoadHTBHResult"]
                
                for i in 0..<dataHeaderMainV2_result3.count
                {
                    let jsonObject = dataHeaderMainV2_result3[i];
                    let getSelectFromObject = Checkimei_V2_LoadHTBH_Result.init(Checkimei_V2_LoadHTBH_Result: jsonObject)
                    getSelectFromResultArrayBody3.append(getSelectFromObject)
                }
                
                handler(nil,true,getSelectFromResultArrayBody,getSelectFromObject2,getSelectFromResultArrayBody3)
                
                
            case .failure:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                handler(nil,true,nil,nil,nil)
            }
        }
    }
    class func LayHinhThucBanGiaoChoBHV(p_HinhThucBH_Ma: String,p_MaShop:String,handler: @escaping (_ error: Error?, _ success: Bool, _ result: [LayHinhThucBanGiaoChoBHVResult]?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        
        var getSelectFromResultArrayBody = [LayHinhThucBanGiaoChoBHVResult]();
        
        let parameters = ["p_HinhThucBH_Ma" : p_HinhThucBH_Ma , "p_MaShop" : p_MaShop]
        
        provider.request(.LayHinhThucBanGiaoChoBHV(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                
                let taskData = json["mPOSWarranty_sp_TaoPhieuBH_LayHinhThucBanGiaoChoBHVResult"]
                for i in 0..<taskData.count
                {
                    let jsonObject = taskData[i];
                    let getSelectFromObject = LayHinhThucBanGiaoChoBHVResult.init(LayHinhThucBanGiaoChoBHVResult: jsonObject)
                    getSelectFromResultArrayBody.append(getSelectFromObject)
                }
                
                handler(nil,true,getSelectFromResultArrayBody)
                
            case  .failure:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //handler(list,"",error.localizedDescription)
                
                handler(nil,true,nil)
            }
        }
    }
    class func LoadHinhThucBanGiao(p_MaCuaHang: String,p_NganhHang:String,p_LoaiHang: String,p_NhomHangCRM:String,p_Hang: String,p_HinhThucBH:String,p_LoaiBH:String,handler: @escaping (_ error: Error?, _ success: Bool, _ result: [LayHinhThucBanGiaoChoBHVResult]?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        
        var getSelectFromResultArrayBody = [LayHinhThucBanGiaoChoBHVResult]();
        
        let parameters = ["p_MaCuaHang" : p_MaCuaHang , "p_NganhHang" : p_NganhHang, "p_LoaiHang" : p_LoaiHang, "p_NhomHangCRM" : p_NhomHangCRM, "p_Hang" : p_Hang, "p_HinhThucBH" : p_HinhThucBH, "p_LoaiBH" : p_LoaiBH]
        print(parameters)
        provider.request(.LoadHinhThucBanGiao(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                
                let taskData = json["mPOSWarranty_sp_TaoPhieuBH_LoadHinhThucBanGiaoResult"]
                for i in 0..<taskData.count
                {
                    let jsonObject = taskData[i];
                    let getSelectFromObject = LayHinhThucBanGiaoChoBHVResult.init(LayHinhThucBanGiaoChoBHVResult: jsonObject)
                    getSelectFromResultArrayBody.append(getSelectFromObject)
                }
                
                handler(nil,true,getSelectFromResultArrayBody)
                
            case  .failure:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //handler(list,"",error.localizedDescription)
                handler(nil,true,nil)
            }
        }
    }
    class func TaoPhieuBH_NgayHenTra(p_LoaiCK: String,p_CuaHangTaoPhieu:String,p_Hang: String,p_HinhThucBH:String,p_NhomhangCRM: String,handler: @escaping (_ error: Error?, _ success: Bool, _ result: TaoPhieuBH_NgayHenTraResult?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        
        let parameters = ["p_LoaiCK" : p_LoaiCK , "p_CuaHangTaoPhieu" : p_CuaHangTaoPhieu, "p_Hang" : p_Hang, "p_HinhThucBH" : p_HinhThucBH, "p_NhomhangCRM" : p_NhomhangCRM]
        print(parameters)
        provider.request(.TaoPhieuBH_NgayHenTra(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let taskData = json["mPOSWarranty_sp_TaoPhieuBH_NgayHenTraResult"]
                let jsonObject = taskData;
                let getSelectFromObject = TaoPhieuBH_NgayHenTraResult.init(TaoPhieuBH_NgayHenTraResult: jsonObject)
                
                
                handler(nil,true,getSelectFromObject)
                
            case .failure(_):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //handler(list,"",error.localizedDescription)
                handler(nil,true,nil)
            }
        }
    }
    class func BaoHanhUploadImageNew(mListObject:BaoHanhUploadImageNewParamObject,completion: @escaping(_ error: Error?, _ success: Bool, _ result: String?, _ resultMessage: String?)->Void)
    {
        let action = "/mPOSWarranty/Service.svc/UpLoadImageList"
        let urlString = "\(Config.manager.URL_GATEWAY!)/mpos-cloud-warranty\(action)"
        if let data =  try? JSONSerialization.data(withJSONObject: mListObject.toJSON(), options: []){
            
            let jsonData = String(data:data, encoding:.utf8)
            print("{jsonnnnnnnnnnew} \(jsonData!)" )
            if let url = URL(string: urlString) {
                var request = URLRequest(url: url)
                print("urljsonnnnnnnnnnew \(url)")
                request.httpMethod = HTTPMethod.post.rawValue
                request.setValue("Basic MXFhejJ3c3gwb2ttOWlqblhjWHh4", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                request.httpBody = data
                let manager = Alamofire.Session.default
                manager.request(request).responseJSON { response in
                    switch response.result
                    {
                    case .failure(let error):
                        print(error)
                        completion(error,false,"","")
                    case .success(let value):
//                        if let _ = response.result.value {
                            let mJson = JSON(value)
                            print("mPOSWarranty_UpLoadImage_BienBanBHResult \(mJson)")
                            let taskImageName = mJson["ImageName"]
                            completion(nil,true,"\(taskImageName)","")
                            
//                        }
//                        else
//                        {
//                            return completion(nil,false,"","")
//                        }
                    }
                }
            }
        }
    }
    class func TaoPhieuBH_UpLoadImage(p_FileName: String,p_UserCode:String,p_UserName:String,p_Base64:String,handler: @escaping (_ error: Error?, _ success: Bool, _ result: BaoHanhUpLoadImageResult?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        
        let parameters = ["p_FileName" : p_FileName ,"p_UserCode": p_UserCode , "p_UserName" : p_UserName, "p_Base64" : p_Base64]
        print("parameters \(parameters)")
        
        
        provider.request(.TaoPhieuBH_UpLoadImage(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                
                let taskData = json["mPOSWarranty_UpLoadImageResult"]
                let jsonObject = taskData;
                let getSelectFromObject = BaoHanhUpLoadImageResult.init(BaoHanhUpLoadImageResult: jsonObject)
                
                
                handler(nil,true,getSelectFromObject)
                
            case .failure:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //handler(list,"",error.localizedDescription)
                
                handler(nil,true,nil)
            }
        }
    }
    class func GetBaoHanhPhuKien(handler: @escaping ( _ error: Error?,  _ success: Bool, _ result: [LayThongTinPhuKienResult]?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var getSelectFromResultArray = [LayThongTinPhuKienResult]();
        provider.request(.GetBaoHanhPhuKien){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                guard let json = try? JSON(data: data) else { return }
                
                let taskData = json["mPOSWarranty_sp_LayThongTinPhuKienResult"]
                for i in 0..<taskData.count
                {
                    let jsonObject = taskData[i];
                    let getSelectFromObject = LayThongTinPhuKienResult.init(LayThongTinPhuKienResult: jsonObject)
                    getSelectFromResultArray.append(getSelectFromObject)
                }
                handler(nil,true,getSelectFromResultArray)
                
            case .failure:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //handler(list,"",error.localizedDescription)
                handler(nil,true,nil)
            }
        }
    }
    class func TaoPhieuBH_LuuPhieuBH(p_LoaiBH: String,p_HinhThucBH:String,p_MoTaLoi: String,p_DienGiai:String,p_NgayDuKienTra: String,p_MaShopTao: String,p_TenShopTao:String,p_NhanVienTao: String,p_MaTTBH1:String,p_MaTTBH2: String,p_MaHTBanGiao: String,p_TenHTBanGiao:String,p_SoNgayCamKet: String,p_SanPhamBH:String,p_SolanBH: String,p_SoDonHang: String,p_MaCuaHangBan:String,p_TenCuaHangBan: String,p_LoaiDonHang:String,p_MaSanPham: String,p_TenSanPham: String,p_NgayHetHanBH:String,p_NgayMua: String,p_SoHoaDonDo:String,p_Imei: String,p_Imei2: String,p_MaSPBHV:String,p_SoLanBHV: String,p_MaHopDongBHV:String,p_TrangThaiBHV: String,p_MauSac: String,p_TenKH:String,p_SoDienThoaiKH: String,p_SoDienThoaiKhac:String,p_DiaChi: String,p_GhiChu: String,p_Email:String,p_MaKho: String,p_TB_PhuKien_PhieuBH:String,p_TB_TinhTrangMay_PhieuBH: String,p_MaSPBHNhanh: String,p_MaHDBHNhanh:String,p_HieuLucBHNhanh: String,p_MaSPBHTanNoi:String,p_MaHDBHTanNoi: String,p_HieuLucBHTanNoi: String,p_MaSPBHVIP:String,p_MaHDBHVIP: String,p_HieuLucVIP:String,p_MaBook: String,p_MaSPSamSungVIP: String,p_MaHDSamSungVIP:String,p_HieuLucSamSungVIP: String,p_TypeDevice:String,p_ChuoiDinhKem:String,p_IsCapMobile:String,p_NgayCapLaiICloud:String,handler: @escaping (_ error: Error?, _ success: Bool, _ result: TaoPhieuBH_LuuPhieuBHResult?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        
        let parameters = ["p_LoaiBH": p_LoaiBH,"p_HinhThucBH":p_HinhThucBH,"p_MoTaLoi": p_MoTaLoi,"p_DienGiai":p_DienGiai,"p_NgayDuKienTra": p_NgayDuKienTra,"p_MaShopTao": p_MaShopTao,"p_TenShopTao":p_TenShopTao,"p_NhanVienTao": p_NhanVienTao,"p_MaTTBH1":p_MaTTBH1,"p_MaTTBH2": p_MaTTBH2,"p_MaHTBanGiao": p_MaHTBanGiao,"p_TenHTBanGiao":p_TenHTBanGiao,"p_SoNgayCamKet": p_SoNgayCamKet,"p_SanPhamBH":p_SanPhamBH,"p_SolanBH": p_SolanBH,"p_SoDonHang": p_SoDonHang,"p_MaCuaHangBan":p_MaCuaHangBan,"p_TenCuaHangBan": p_TenCuaHangBan,"p_LoaiDonHang":p_LoaiDonHang,"p_MaSanPham": p_MaSanPham,"p_TenSanPham": p_TenSanPham,"p_NgayHetHanBH":p_NgayHetHanBH,"p_NgayMua": p_NgayMua,"p_SoHoaDonDo":p_SoHoaDonDo,"p_Imei": p_Imei,"p_Imei2": p_Imei2,"p_MaSPBHV":p_MaSPBHV,"p_SoLanBHV": p_SoLanBHV,"p_MaHopDongBHV":p_MaHopDongBHV,"p_TrangThaiBHV": p_TrangThaiBHV,"p_MauSac": p_MauSac,"p_TenKH":p_TenKH,"p_SoDienThoaiKH": p_SoDienThoaiKH,"p_SoDienThoaiKhac":p_SoDienThoaiKhac,"p_DiaChi": p_DiaChi,"p_GhiChu": p_GhiChu,"p_Email":p_Email,"p_MaKho": p_MaKho,"p_TB_PhuKien_PhieuBH":p_TB_PhuKien_PhieuBH,"p_TB_TinhTrangMay_PhieuBH": p_TB_TinhTrangMay_PhieuBH,"p_MaSPBHNhanh": p_MaSPBHNhanh,"p_MaHDBHNhanh":p_MaHDBHNhanh,"p_HieuLucBHNhanh": p_HieuLucBHNhanh,"p_MaSPBHTanNoi":p_MaSPBHTanNoi,"p_MaHDBHTanNoi": p_MaHDBHTanNoi,"p_HieuLucBHTanNoi": p_HieuLucBHTanNoi,"p_MaSPBHVIP":p_MaSPBHVIP,"p_MaHDBHVIP": p_MaHDBHVIP,"p_HieuLucVIP":p_HieuLucVIP,"p_MaBook": p_MaBook,"p_MaSPSamSungVIP": p_MaSPSamSungVIP,"p_MaHDSamSungVIP":p_MaHDSamSungVIP,"p_HieuLucSamSungVIP": p_HieuLucSamSungVIP,"p_TypeDevice":"2","p_ChuoiDinhKem":p_ChuoiDinhKem,"p_IsCapMobile":p_IsCapMobile,"p_NgayCapLaiICloud":p_NgayCapLaiICloud]
        print("parameters TaoPhieuBH_NgayHenTraResult \(parameters)")
        
        
        provider.request(.TaoPhieuBH_LuuPhieuBH(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                
                
                let taskData = json["mPOSWarranty_sp_TaoPhieuBH_LuuPhieuBHResult"]
                let jsonObject = taskData;
                let getSelectFromObject = TaoPhieuBH_LuuPhieuBHResult.init(TaoPhieuBH_LuuPhieuBHResult: jsonObject)
                
                
                handler(nil,true,getSelectFromObject)
                
            case .failure:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //handler(list,"",error.localizedDescription)
                
                handler(nil,true,nil)
            }
        }
    }
    class func LayTinhTrangMay(handler: @escaping (_ error: Error?, _ success: Bool, _ result: [LayTinhTrangMayResult]?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var getSelectFromResultArrayBody = [LayTinhTrangMayResult]();
        
        
        provider.request(.LayTinhTrangMay){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                guard let json = try? JSON(data: data) else { return }
                
                let taskData = json["mPOSWarranty_sp_LayTinhTrangMayResult"]
                for i in 0..<taskData.count
                {
                    let jsonObject = taskData[i];
                    let getSelectFromObject = LayTinhTrangMayResult.init(LayTinhTrangMayResult: jsonObject)
                    getSelectFromResultArrayBody.append(getSelectFromObject)
                }
                
                handler(nil,true,getSelectFromResultArrayBody)
                
            case .failure:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //handler(list,"",error.localizedDescription)
                
                handler(nil,true,nil)
            }
        }
    }
    class func GetImageBienBanBH( p_MaPhieuBH:String,  p_Base64_CusSign:String,p_Base64_EplSign
        : String, p_Type:String, p_UserCode:String, p_UserName:String,p_Manager: String,
                  p_ManagerSignature: String,handler: @escaping (_ error: Error?, _ success: Bool, _ result: String?, _ resultMessage: String?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        
        let parameters = ["p_MaPhieuBH" : p_MaPhieuBH,"p_Base64_CusSign":p_Base64_CusSign,"p_Base64_EplSign":p_Base64_EplSign,"p_Type":p_Type,"p_UserCode":p_UserCode,"p_UserName":p_UserName,"p_Manager":p_Manager,"p_ManagerSignature":p_ManagerSignature]
        print("parameters \(parameters)")
        
        
        provider.request(.GetImageBienBanBH(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                
                
                
                let taskData = json["mPOSWarranty_UpLoadImage_BienBanBHResult"]["Result"]
                let taskDataMess = json["mPOSWarranty_UpLoadImage_BienBanBHResult"]["ImageName"]
                handler(nil,true,"\(taskData)","\(taskDataMess)")
                
            case .failure:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //handler(list,"",error.localizedDescription)
                handler(nil,true,"","")
            }
        }
    }
    class func TaoPhieuBH_Timsanpham(p_ItemCode: String,p_ItemName: String,handler: @escaping (_ error: Error?, _ success: Bool, _ result: [TaoPhieuBH_TimsanphamResult]?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var getSelectFromResultArrayBody = [TaoPhieuBH_TimsanphamResult]();
        
        let parameters = ["p_ItemCode" : p_ItemCode,"p_ItemName" : p_ItemName]
        
        
        provider.request(.TaoPhieuBH_Timsanpham(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                let taskData = json["mPOSWarranty_sp_TaoPhieuBH_TimsanphamResult"]
                for i in 0..<taskData.count
                {
                    let jsonObject = taskData[i];
                    let getSelectFromObject = TaoPhieuBH_TimsanphamResult.init(TaoPhieuBH_TimsanphamResult: jsonObject)
                    getSelectFromResultArrayBody.append(getSelectFromObject)
                }
                handler(nil,true,getSelectFromResultArrayBody)
                
            case .failure:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //handler(list,"",error.localizedDescription)
                
                handler(nil,true,nil)
            }
        }
    }
    class func LayThongTinHinhThucBH(p_MaLoaiBaoHanh: String,handler: @escaping (_ error: Error?, _ success: Bool, _ result: [LayThongTinHinhThucBHResult]?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        
        var getSelectFromResultArrayBody = [LayThongTinHinhThucBHResult]();
        
        let parameters = ["p_MaLoaiBaoHanh" : p_MaLoaiBaoHanh]
        provider.request(.LayThongTinHinhThucBH(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                let taskData = json["mPOSWarranty_sp_LayThongTinHinhThucBHResult"]
                for i in 0..<taskData.count
                {
                    let jsonObject = taskData[i];
                    let getSelectFromObject = LayThongTinHinhThucBHResult.init(LayThongTinHinhThucBHResult: jsonObject)
                    getSelectFromResultArrayBody.append(getSelectFromObject)
                }
                print("mPOSWarranty_sp_LayThongTinHinhThucBHResult \(getSelectFromResultArrayBody[0].MaHinhThuc)")
                handler(nil,true,getSelectFromResultArrayBody)
                
            case .failure:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //handler(list,"",error.localizedDescription)
                
                handler(nil,true,nil)
                
            }
        }
    }
    class func Checkimei_V2_More(p_Imei: String,p_BILL: String,p_SO_DocNum: String,p_PhoneNumber:String,p_Type:String,handler: @escaping (_ error: Error?, _ success: Bool, _ result: [Checkimei_V2_MoreResult]?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        
        var getSelectFromResultArrayBody = [Checkimei_V2_MoreResult]();
        
        let parameters = ["p_Imei": p_Imei,"p_BILL": p_BILL,"p_SO_DocNum": p_SO_DocNum ,"p_PhoneNumber":p_PhoneNumber,"p_Type": "1"]
        
        print(parameters)
        provider.request(.Checkimei_V2_More(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                
                
                let taskData = json["mPOSWarranty_sp_Checkimei_V2_MoreResult"]
                for i in 0..<taskData.count
                {
                    let jsonObject = taskData[i];
                    let getSelectFromObject = Checkimei_V2_MoreResult.init(Checkimei_V2_MoreResult: jsonObject)
                    
                    getSelectFromResultArrayBody.append(getSelectFromObject)
                }
                handler(nil,true,getSelectFromResultArrayBody)
                
            case .failure:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //handler(list,"",error.localizedDescription)
                
                handler(nil,true,nil)
            }
        }
    }
    class func LoadThongTinTimKiemThem_Mobile(p_BienTruyenVao: String,p_LineChon: String,p_SoDonHang: String,handler: @escaping (_ error: Error?, _ success: Bool, _ result: [Checkimei_V2Result]?,_ result2: Checkimei_V2_ImeiInfoServices_Result?,_ result3: [Checkimei_V2_LoadHTBH_Result]?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var getSelectFromResultArrayBody = [Checkimei_V2Result]();
        var getSelectFromResultArrayBody3 = [Checkimei_V2_LoadHTBH_Result]();
        
        let parameters = ["p_BienTruyenVao": p_BienTruyenVao,"p_LineChon": p_LineChon,"p_SoDonHang":p_SoDonHang]
        
        print(parameters)
        provider.request(.LoadThongTinTimKiemThem_Mobile(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                
                print(json)
                let taskData = json["mPOSWarranty_sp_LoadThongTinTimKiemThem_MobileResult"]
                let dataHeaderMainV2 = taskData["mPOSWarranty_ImeiInfoResult"]
                
                for i in 0..<dataHeaderMainV2.count
                {
                    let jsonObject = dataHeaderMainV2[i];
                    let getSelectFromObject = Checkimei_V2Result.init(Checkimei_V2Result: jsonObject)
                    getSelectFromResultArrayBody.append(getSelectFromObject)
                }
                //////
                let dataHeaderMainV2_result2 = taskData["mPOSWarranty_ImeiInfoServicesResult"]
                let getSelectFromObject2 = Checkimei_V2_ImeiInfoServices_Result.init(Checkimei_V2_ImeiInfoServices_Result: dataHeaderMainV2_result2)
                //////
                
                let dataHeaderMainV2_result3 = taskData["mPOSWarranty_LoadHTBHResult"]
                
                for i in 0..<dataHeaderMainV2_result3.count
                {
                    let jsonObject = dataHeaderMainV2_result3[i];
                    let getSelectFromObject = Checkimei_V2_LoadHTBH_Result.init(Checkimei_V2_LoadHTBH_Result: jsonObject)
                    getSelectFromResultArrayBody3.append(getSelectFromObject)
                }
                
                handler(nil,true,getSelectFromResultArrayBody,getSelectFromObject2,getSelectFromResultArrayBody3)
                
            case .failure:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //handler(list,"",error.localizedDescription)
                
                handler(nil,true,nil,nil,nil)
            }
        }
    }
    class func GetLoadThongTinPhieuTraKH(p_MaPhieuBH:String,p_Imei: String,p_SDT: String,p_ShopTraMay: String,handler: @escaping (_ error: Error?, _ success: Bool, _ result: [TraMay_LoadThongTinPhieuTraKHResult]?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var getSelectFromResultArrayBody = [TraMay_LoadThongTinPhieuTraKHResult]();
        
        let parameters = ["p_MaPhieuBH":p_MaPhieuBH,"p_Imei" : p_Imei,"p_SDT" : p_SDT,"p_ShopTraMay" : p_ShopTraMay]
        print("parameters \(parameters)")
        
        
        provider.request(.GetLoadThongTinPhieuTraKH(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                guard let json = try? JSON(data: data) else {
                    handler(nil,true,nil)
                    return
                    
                }
                print(json)
                
                
                let taskData = json["mPOSWarranty_sp_LoadThongTinPhieuTraKHResult"]
                for i in 0..<taskData.count
                {
                    let jsonObject = taskData[i];
                    let getSelectFromObject = TraMay_LoadThongTinPhieuTraKHResult.init(TraMay_LoadThongTinPhieuTraKHResult: jsonObject)
                    getSelectFromResultArrayBody.append(getSelectFromObject)
                }
                handler(nil,true,getSelectFromResultArrayBody)
                
            case .failure:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //handler(list,"",error.localizedDescription)
                
                handler(nil,true,nil)
            }
        }
    }
    class func GetLoadThongTinBBTraMay(p_MaPhieuBH: String,handler: @escaping (_ error: Error?, _ success: Bool, _ result: TraMay_LoadThongTinBBTraMayResult?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        
        let parameters = ["p_MaPhieuBH" : p_MaPhieuBH]
        print("parameters \(parameters)")
        
        
        provider.request(.GetLoadThongTinBBTraMay(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                
                
                let taskData = json["mPOSWarranty_sp_LoadThongTinBBTraMayResult"]
                
                let getSelectFromObject = TraMay_LoadThongTinBBTraMayResult.init(TraMay_LoadThongTinBBTraMayResult: taskData)
                handler(nil,true,getSelectFromObject)
                
            case .failure:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //handler(list,"",error.localizedDescription)
                
                handler(nil,true,nil)
            }
        }
    }
    class func GetDongBoKnox(p_MaPhieuBH: String,p_Imei:String,p_ImeiNew:String,p_UserCode:String,handler: @escaping (_ error: Error?, _ success: Bool, _ result: String?, _ resultMessage: String?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        
        let parameters = ["p_MaPhieuBH" : p_MaPhieuBH,"p_Imei":p_Imei,"p_ImeiNew":p_ImeiNew,"p_UserCode":p_UserCode]
        print("parameters \(parameters)")
        
        
        provider.request(.GetDongBoKnox(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                
                let mData = json["mPOSWarranty_sp_SyncKnoxTraKHResult"]
                let taskData = mData["Result"]
                let taskDataMess = mData["Message"]
                handler(nil,true,"\(taskData)","\(taskDataMess)")
                
            case .failure:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //handler(list,"",error.localizedDescription)
                
                handler(nil,true,"","")
            }
        }
    }
    class func baoHanhPhuKien_SearchLichSu(p_sodonhang:String,p_type:String,sdt_so:String,handler: @escaping (_ success:[WarrantyItem],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        
        var list:[WarrantyItem] = []
        
        let parameters: [String: String] = [
            "p_DocEntry":"\(0)",
            "p_FromDate":"",
            "p_ToDate":"",
            "p_ShopCode":"\(Cache.user!.ShopCode)",
            "p_sodonhang":"\(p_sodonhang)",
            "p_type":"\(p_type)"
            ,"p_SDT":"\(sdt_so)"
        ]
        print(parameters)
        
        
        provider.request(.baoHanhPhuKien_SearchLichSu(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                
                
                //
                if let shopResult = json["mPOSWarranty_sp_BaoHanhPhuKien_SearchLichSuResult"].array {
                    list = WarrantyItem.parseObjfromArray(array: shopResult)
                    handler(list,"")
                } else {
                    handler(list,"Không thể kiểm tra được thông tin shop!")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //handler(list,"",error.localizedDescription)
                
                handler(list,error.localizedDescription)
            }
        }
    }
    class func baoHanhPhuKien_LoadLoai(handler: @escaping (_ success:[WarrantyType],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        
        var list:[WarrantyType] = []
        
        
        provider.request(.baoHanhPhuKien_LoadLoai){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                
                //
                if let shopResult = json["mPOSWarranty_sp_BaoHanhPhuKien_LoadLoaiResult"].array {
                    list = WarrantyType.parseObjfromArray(array: shopResult)
                    handler(list,"")
                } else {
                    handler(list,"Không thể kiểm tra được thông tin shop!")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //handler(list,"",error.localizedDescription)
                
                handler(list,error.localizedDescription)
            }
        }
    }
    class func mpos_sp_Get_ThongTinSSD_ChiTietGoiCuoc(MaSPMay:String,MaSPGoiCuoc:String,SoTienChiTieu:Float,GiaMay:Float,handler: @escaping (_ success:[DetailSubsidy],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")!
        let parameters = [
            "MaSPMay" : "\(MaSPMay)",
            "MaSPGoiCuoc":"\(MaSPGoiCuoc)",
            "SoTienChiTieu": "\(String(format: "%.6f", SoTienChiTieu))",
            "GiaMay":"\(String(format: "%.6f", GiaMay))",
            "CRMCode": crm,
            "Token":"\(Cache.user!.Token)"
        ]
        var list: [DetailSubsidy] = []
        provider.request(.mpos_sp_Get_ThongTinSSD_ChiTietGoiCuoc(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let data = json["mpos_sp_Get_ThongTinSSD_ChiTietGoiCuocResult"].array {
                    list = DetailSubsidy.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,error.localizedDescription)
            }
        }
    }
    class func sp_mpos_SSD_MSP_SIM_10_11_for_MPOS(MSPGoiCuoc:String,MSPMay:String,handler: @escaping (_ success:[ItemSSD],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")!
        let parameters = [
            "MSPGoiCuoc" : "\(MSPGoiCuoc)",
            "MSPMay" : "\(MSPMay)",
            "CRMCode": crm,
            "Token":"\(Cache.user!.Token)"
        ]
        var list: [ItemSSD] = []
        provider.request(.sp_mpos_SSD_MSP_SIM_10_11_for_MPOS(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let data = json["sp_mpos_SSD_MSP_SIM_10_11_for_MPOSResult"].array {
                    list = ItemSSD.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,error.localizedDescription)
            }
        }
    }
    class func sp_mpos_GetList_ItemCodeSubSidy(maSPSubsidy:String,handler: @escaping (_ success:[ItemCodeSubSidy],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")!
        let parameters = [
            "maSPSubsidy" : "\(maSPSubsidy)",
            "CRMCode": crm,
            "Token":"\(Cache.user!.Token)"
        ]
        var list: [ItemCodeSubSidy] = []
        provider.request(.sp_mpos_GetList_ItemCodeSubSidy(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let data = json["sp_mpos_GetList_ItemCodeSubSidyResult"].array {
                    list = ItemCodeSubSidy.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,error.localizedDescription)
            }
        }
    }
    
    class func VinaGame_InsertInstallapp( UserID:String,  MaShop:String,Listapp
        : String, SoMPOS:String, SOPOS:String, IMeI:String,Status: String,handler: @escaping (_ result:String,_ message:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")!
        let parameters = [
            "UserID" : UserID,"MaShop":MaShop,"Listapp":Listapp,"SoMPOS":SoMPOS,"SOPOS":SOPOS,"IMeI":IMeI,"Status":Status,
            "CRMCode": crm,
            "Token":"\(Cache.user!.Token)"
        ]
        provider.request(.VinaGame_InsertInstallapp(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let result1 = json["Result"].stringValue
                let message1 = json["Message"].stringValue
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(result1,message1,"")
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("","",error.localizedDescription)
            }
        }
    }
    
    class func VinaGame_GetListDHIntalled(UserID: String,MaShop: String,handler: @escaping (_ success:[VinaGame_LoadDSDonHangInstalled],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")!
        let parameters = [
            "MaShop": "\(MaShop)",
            "UserID": "\(UserID)",
            "CRMCode": crm,
            "Token":"\(Cache.user!.Token)"
        ]
        var list: [VinaGame_LoadDSDonHangInstalled] = []
        provider.request(.VinaGame_GetListDHIntalled(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            list = VinaGame_LoadDSDonHangInstalled.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(list,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,error.localizedDescription)
            }
        }
    }
    
    class func mpos_sp_Get_ThongTinSSD_from_itemcode_goicuoc(MaSPMay:String,MaSPGoiCuoc:String,SoTienChiTieu:Float,GiaMay:Float,handler: @escaping (_ success:[ThongTinSSD],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")!
        let parameters = [
            "MaSPMay" : "\(MaSPMay)",
            "MaSPGoiCuoc":"\(MaSPGoiCuoc)",
            "SoTienChiTieu": "\(String(format: "%.6f", SoTienChiTieu))",
            "GiaMay":"\(String(format: "%.6f", GiaMay))",
            "CRMCode": crm,
            "Token":"\(Cache.user!.Token)"
        ]
        var list: [ThongTinSSD] = []
        provider.request(.mpos_sp_Get_ThongTinSSD_from_itemcode_goicuoc(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let data = json["mpos_sp_Get_ThongTinSSD_from_itemcode_goicuocResult"].array {
                    list = ThongTinSSD.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,error.localizedDescription)
            }
        }
    }
    
    class func sp_mpos_Get_SSD_GoiCuoc_for_MPOS(tienChiTieu:String,Provider:String,handler: @escaping (_ success:[SSDGoiCuoc],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")!
        let parameters = [
            "TienChiTieu" : tienChiTieu,
            "Provider" : Provider,
            "CRMCode": crm,
            "Token":"\(Cache.user!.Token)"
        ]
        var list: [SSDGoiCuoc] = []
        provider.request(.sp_mpos_Get_SSD_GoiCuoc_for_MPOS(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let data = json["sp_mpos_Get_SSD_GoiCuoc_for_MPOSResult"].array {
                    list = SSDGoiCuoc.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,error.localizedDescription)
            }
        }
    }
    
    class func sp_mpos_FRT_SP_SSD_SoSanhGoiSSD_GoiThuong(GiaMay:String,MaSP_goicuoc:String,handler: @escaping (_ success:[SoSanhGoiSSD],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")!
        let parameters = [
            "GiaMay" : "\(GiaMay)",
            "MaSP_goicuoc": "\(MaSP_goicuoc)",
            "MaShop": "\(Cache.user!.ShopCode)",
            "UserID": "\(Cache.user!.UserName)",
            "CRMCode": crm,
            "Token":"\(Cache.user!.Token)"
        ]
        var list: [SoSanhGoiSSD] = []
        provider.request(.sp_mpos_FRT_SP_SSD_SoSanhGoiSSD_GoiThuong(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            list = SoSanhGoiSSD.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(list,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,error.localizedDescription)
            }
        }
    }
    
    class func VinaGame_GetListDH(UserID: String,MaShop: String,handler: @escaping (_ success:[VinaGame_LoadDSDonHang],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")!
        let parameters = [
            "UserID" : "\(UserID)",
            "MaShop": "\(MaShop)",
            "CRMCode": crm,
            "Token":"\(Cache.user!.Token)"
        ]
        var list: [VinaGame_LoadDSDonHang] = []
        provider.request(.VinaGame_GetListDH(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            list = VinaGame_LoadDSDonHang.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(list,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,error.localizedDescription)
            }
        }
    }
    
    class func checkpromotionActivedSim(Provider:String,CardValue:String,Phonenumber:String,Quantityuse:String,handler: @escaping (_ success:[PromotionActivedSim],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        let parameters = [
            "Provider":Provider,
            "CardValue":CardValue,
            "Phonenumber":Phonenumber,
            "Quantityuse":Quantityuse,
            "ShopCode":"\(Cache.user!.ShopCode)",
            "DeviceType":"2",
            "CRMCode": crm ?? "",
            "Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        var list: [PromotionActivedSim] = []
        provider.request(.checkpromotionActivedSim(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            list = PromotionActivedSim.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(list,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,error.localizedDescription)
            }
        }
    }


    class func inMoMo(soPhieuThu:String,maGiaoDich:String,thoiGianThu:String,sdt_KH:String,tenKH:String,tongTienNap:String,tenVoucher:String,hanSuDung:String,nhaCungCap:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        
        let shopCode:String = (Cache.user?.ShopCode)!
        let userName:String = (Cache.user?.UserName)!
        let empName:String = (Cache.user?.EmployeeName)!
        let address:String = (Cache.user?.Address)!
        let parameters: [String: String] = [
            "shopCode":"\(shopCode)",
            "shopAddress":"\(address)",
            "soPhieuThu": "\(soPhieuThu)",
            "maGiaoDich":"\(maGiaoDich)",
            "thoiGianThu":"\(thoiGianThu)",
            "dichVu":"Ví điện tử MoMo",
            "nhaCungCap":nhaCungCap,
            "sdt_KH":"\(sdt_KH)",
            "tenKH":"\(tenKH)",
            "tongTienNap":"\(tongTienNap)",
            "nguoiThuPhieu":"\(empName)",
            "maNV":"\(userName)",
            "tenVoucher":"\(tenVoucher)",
            "hanSuDung":"\(hanSuDung)"
        ]
        print(parameters)
        provider.request(.inMoMo(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                
                
                let code = json["Code"].stringValue
                let Detail = json["Detail"].stringValue
                if(code == "001"){
                    handler(Detail,"")
                }else{
                    handler("",Detail)
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                handler("",error.localizedDescription)
            }
        }
    }
  
    class func getDanhSachPhieuMoMo(handler: @escaping (_ success:[PhieuGiaoDichMoMo],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let shopCode:String = (Cache.user?.ShopCode)!
        let userName:String = (Cache.user?.UserName)!
        let parameters: [String: String] = [
            "userID" : "\(userName)",
            "shopCode":"\(shopCode)",
            "token":"\(Cache.user!.Token)"
        ]
        print(parameters)
        var list:[PhieuGiaoDichMoMo] = []
        provider.request(.getDanhSachPhieuMoMo(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let code = json["Code"].stringValue
                let Detail = json["Detail"].stringValue
                if(code == "001"){
                    if let data = json["Data"].array{
                        list = PhieuGiaoDichMoMo.parseObjfromArray(array: data)
                        handler(list,"")
                    }
                }else{
                    handler(list,Detail)
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                handler(list,error.localizedDescription)
            }
        }
    }
    
    class func GetCRMPaymentHistory(usercode: String,shopcode: String,transType:String,handler: @escaping (_ success:[GetCRMPaymentHistoryTheNapResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        let parameters = [
            "usercode" : "\(usercode)",
            "shopcode": "\(shopcode)",
            "transType": "\(transType)",
            "CRMCode": crm ?? "",
            "Token":"\(Cache.user!.Token)"
        ]
        var list: [GetCRMPaymentHistoryTheNapResult] = []
        provider.request(.GetCRMPaymentHistory(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            list = GetCRMPaymentHistoryTheNapResult.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(list,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,error.localizedDescription)
            }
        }
    }

    class func GetThuHoServices(MaNV: String, MaShop: String,handler: @escaping (_ results: [ThuHoService],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = ["MaNV" : MaNV,"MaShop" : MaShop]
        
        var rs:[ThuHoService] = []
        provider.request(.GetProvidersNew(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let data1 = json["Data"]
                        if let ListService = data1["ListService"].array {
                            rs = ThuHoService.parseObjfromArray(array: ListService)
                            handler(rs,"")
                        }else{
                            var Description = json["Description"].string
                            Description = Description == nil ? "Load API ERRO" : Description
                            handler(rs,Description!)
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func GetBillV2(WarehouseCode: String, ProviderCode: String,ServiceCode: String, PartnerUserCode: String, CustomerID: String,AgribankProviderCode: String, MomenyAmountReturnCode25: String,handler: @escaping (_ result: ThuHoBill?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = ["WarehouseCode" : WarehouseCode,"ProviderCode" : ProviderCode,"ServiceCode" : ServiceCode,"PartnerUserCode":PartnerUserCode,"CustomerID":CustomerID,"AgribankProviderCode" : AgribankProviderCode,"MomenyAmountReturnCode25" : MomenyAmountReturnCode25]
        
        debugPrint(parameters)
        provider.request(.GetBill(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let success = json?["Success"].bool {
                    if(success){
                        let data = json!["Data"]
                        let rs = ThuHoBill.getObjFromDictionary(data: data)
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    
    
    //    class func pushBillInRutTien(printBill:BillParamInRutTienMoMo) {
    //
    //        let mn = Config.manager
    //        let action = "\(Cache.user!.ShopCode)/push"
    //        let urlString = "\(mn.URL_PRINT_BILL!)/api/\(action)"
    //        let manager = Alamofire.SessionManager.default
    //        manager.session.configuration.timeoutIntervalForRequest = 160
    //
    //        if let data =  try? JSONSerialization.data(withJSONObject: printBill.toJSON(), options: []){
    //            if let jsonData = String(data:data, encoding:.utf8) {
    //                print(jsonData)
    //                let billParam = BillParam(title: "In phiếu chi Momo", body: jsonData,id: "POS", key: "pos_chimomo")
    //                let billMessage = BillMessage(message:billParam)
    //
    //                print("\(urlString) \(billMessage.toJSON())")
    //                if let data2 =  try? JSONSerialization.data(withJSONObject: billMessage.toJSON(), options: []){
    //                    if let url = URL(string: urlString) {
    //                        var request = URLRequest(url: url)
    //                        request.httpMethod = HTTPMethod.post.rawValue
    //                        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
    //                        request.httpBody = data2
    //                        manager.request(request).responseJSON {
    //                            (response) in
    //                            print(response)
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }
    
    //pd ffriend
    
    class func getVendorCurator(handler: @escaping (_ results: [VendorCuratorGetvendor],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        
        var rs:[VendorCuratorGetvendor] = []
        provider.request(.getVendorCurator_Getvendor){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = VendorCuratorGetvendor.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            
                            handler(rs,"Không load được data!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func getVendorCurator_GetHead_PD(handler: @escaping (_ results: [VendorCuratorGetHeadPD],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        
        var rs:[VendorCuratorGetHeadPD] = []
        provider.request(.getVendorCurator_GetHead_PD){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = VendorCuratorGetHeadPD.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            
                            handler(rs,"Không load được data!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func getVendorCurator_GetCurator(handler: @escaping (_ results: [VendorCuratorGetCurator],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        
        var rs:[VendorCuratorGetCurator] = []
        provider.request(.getVendorCurator_GetCurator){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = VendorCuratorGetCurator.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            
                            handler(rs,"Không load được data!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func getInfo_Curator(VendorCode:String,CuratorCode:String,Head_PDCode:String,handler: @escaping (_ results: [InfoCurator],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = ["VendorCode" : VendorCode
            ,"CuratorCode": CuratorCode
            ,"Head_PDCode": Head_PDCode ]
        
        var rs:[InfoCurator] = []
        provider.request(.getInfo_Curator(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = InfoCurator.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            
                            handler(rs,"Không load được data!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func UpLoadImageSingle_TaoPhieuBH(p_MaPhieuBH: String,p_FileName:String,p_Base64:String,p_IsSign:String,handler: @escaping (_ error:String, _ success: Bool, _ result: String?, _ resultMessage: String?) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters = ["p_UserCode" : Cache.user!.UserName,
                          "p_UserName" : Cache.user!.EmployeeName,
                          "p_MaPhieuBH" : p_MaPhieuBH,
                          "p_FileName": p_FileName,
                          "p_Base64": p_Base64,
                          "p_IsSign" : p_IsSign]
        
        //debugPrint(parameters)
        log.info(parameters)
        provider.request(.UpLoadImageSingle_TaoPhieuBH(param:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                guard let json = try? JSON(data: data) else {
                    handler("",false,"","")
                    return
                }
                log.info(json)
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                if let Result = json["Result"].int {
                    if(Result == 1){
                        
                        let taskImageName = json["ImageName"].string
                        handler("",true,"\(taskImageName!)","")
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("",false,"","")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(error.localizedDescription,false,"","")
            }
        }
    }
    
    
    class func getVendorCurator_Saveinfo(VendorCode:String,CuratorCode:String,Head_PDCode:String,
                                         Reason:String ,handler: @escaping (_ results: [VendorCurator_Saveinfo],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "VendorCode":VendorCode,
            "CuratorCode":CuratorCode,
            "Head_PDCode":Head_PDCode,
            "Reason":Reason,
            "CreateBy": "\(Cache.user!.UserName)",
            "DeviceType":"2"
        ]
        debugPrint(parameters)
        
        var rs:[VendorCurator_Saveinfo] = []
        provider.request(.getVendorCurator_Saveinfo(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = VendorCurator_Saveinfo.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            
                            handler(rs,"Không load được data!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func vendorCurator_Deleteinfo(VendorCode:String,handler: @escaping (_ results: [VendorCurator_DeleteInfo],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            
            
            
            "ID_VendorCurator":VendorCode,
            "CreateBy": "\(Cache.user!.UserName)",
            "DeviceType":"2"
            
        ]
        debugPrint(parameters)
        var rs:[VendorCurator_DeleteInfo] = []
        provider.request(.vendorCurator_DeleteInfo(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = VendorCurator_DeleteInfo.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            
                            handler(rs,"Không load được data!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    
    class func checkIn(smCreate: String, userCodePG: String, password: String, handler: @escaping(_ success:SimpleResponse?, _ error: String) -> Void) {
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = ["smCreate": smCreate,
                                            "userCodePG": userCodePG,
                                            "password": password]
        provider.request(.checkIn(params: parameters)) { (result) in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let detail = json["Detail"]
                let response = SimpleResponse.getObjFromDictionary(data: json)
                guard let ms = detail.string else {
                    return
                }
                handler(response, ms)
            case let .failure(error):
                debugPrint(error)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    
    class func updateOffEmployee(userCode: String, updateBy: String, handler: @escaping(_ success:SimpleResponse?, _ error: String) -> Void) {
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = ["userCode":userCode, "updateBy":updateBy]
        provider.request(.updateOffEmployee(params: parameters)) { (result) in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let detail = json["Detail"]
                let response = SimpleResponse.getObjFromDictionary(data: json)
                guard let ms = detail.string else {
                    return
                }
                handler(response, ms)
            case let .failure(error):
                debugPrint(error)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    
    class func getListVendors(handler: @escaping(_ success: VendorList?, _ error: String) -> Void) {
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request( .getListVendors) { (result) in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let detail = json["Detail"]
                let response = VendorList.getObjFromDictionary(data: json)
                guard let ms = detail.string else {
                    return
                }
                handler(response, ms)
            case let .failure(error):
                debugPrint(error)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func getHistoryCheckIn(str_FromDate: String, str_ToDate: String, userCode: String,handler: @escaping (_ success:[PGCheckIn]?,_ detail:String,_ Code: String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[PGCheckIn] = []
        let parameters: [String: String] = ["str_FromDate":str_FromDate, "str_ToDate":str_ToDate, "userCode":userCode]
        provider.request(.getHistoryCheckIn(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let detail = json["Detail"].string
                let Code = json["Code"].string
                if Code == "001" {
                    if let list = json["Data"].array {
                        rs = PGCheckIn.parseObjfromArray(array: list)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,detail ?? "",Code ?? "")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO", Code ?? "")
                    }
                } else {
                    handler(nil,detail ?? "",Code ?? "")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription, "")
            }
        }
    }
    class func register(name: String, birthYear: Int,idCard: String, phone: String, vender:String, password:String, userCreate: String,jobtitleName: String, leaderPG: String , pgCode: String, email: String, isReg: Int, handler: @escaping (_ success: PGInfo?,_ error: String, _ responseCode: String) ->Void){
        
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = ["empName":name,
                                         "birthYear":"\(birthYear)",
            "idCard":idCard,
            "phoneNumber":phone,
            "vendorCode":vender,
            "passWord":password,
            "userCreate":userCreate,
            "jobtitleName":jobtitleName,
            "leaderPG":leaderPG,
            "pgCode": pgCode,
            "email":email,
            "IsReg":isReg]
        provider.request(.register(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let detail = json["Detail"].string
                let Code = json["Code"].string
                let pgInfoData = json["Data"]
                let response = PGInfo.getObjFromDictionary(data: pgInfoData)
                handler(response,detail!, Code!)
            case let .failure(error):
                debugPrint(error)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription, "")
            }
        }
    }
    
    class func getEmployeeInfo(idCard: String, handler: @escaping (_ success: PGInfo?,_ error: String, _ responseCode: String) -> Void) {
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = ["idCard":idCard]
        provider.request(.getEmployeeInfo(params: parameters)) { (result) in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let detail = json["Detail"].string
                let Code = json["Code"].string
                let pgInfoData = json["Data"]
                let response = PGInfo.getObjFromDictionary(data: pgInfoData)
                handler(response, detail ?? "", Code ?? "")
            case let .failure(error):
                debugPrint(error)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription, "")
            }
        }
    }
    class func getTonKhoShop(listsp:String,userCode:String,shopCode:String,handler: @escaping (_ results: [InventoryProduct],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[InventoryProduct] = []
        
        let parameters: [String: String] = [
            "listsp":listsp,
            "userCode":"\(userCode)",
            "shopCode":shopCode
        ]
        provider.request(.getTonKhoShop(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json!["Data"].array {
                            rs = InventoryProduct.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Không load được data!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func mpos_sp_UpdateTargetPD_GetPD(handler: @escaping (_ results: [CuratorPD],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[CuratorPD] = []
        provider.request(.mpos_sp_UpdateTargetPD_GetPD){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = CuratorPD.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            
                            handler(rs,"Không load được data!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func mpos_sp_UpdateTargerPD_GetInfo(CuratorCode:String,Thang:String,handler: @escaping (_ results: [InfoUpdateTarget],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = ["CuratorCode" : CuratorCode
            ,"Thang": Thang
            ,"UserID": "\(Cache.user!.UserName)" ]
        
        var rs:[InfoUpdateTarget] = []
        provider.request(.mpos_sp_UpdateTargerPD_GetInfo(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = InfoUpdateTarget.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            
                            handler(rs,"Không load được data!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_sp_UpdateTargerPD_Saveinfo(CuratorCode:String,Target:String,
                                               Note:String ,handler: @escaping (_ results: [SaveInfoTarget],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "CuratorCode":CuratorCode,
            "Target":Target,
            "Note":Note,
            "UserID":"\(Cache.user!.UserName)",
            "DeviceType":"2"
        ]
        debugPrint(parameters)
        
        var rs:[SaveInfoTarget] = []
        provider.request(.mpos_sp_UpdateTargerPD_Saveinfo(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = SaveInfoTarget.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Không load được data!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                        
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func inov_masterDataLyDoGiamGia(handler: @escaping (_ success:[LyDoGiamGia],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[LyDoGiamGia] = []
        let parameters: [String: String] = [
            "shopcode":"\(Cache.user!.ShopCode)",
            "usercode":"\(Cache.user!.UserName)"
        ]
        provider.request(.inov_masterDataLyDoGiamGia(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = LyDoGiamGia.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                    
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func inov_listTonKhoSanPham(listmasp:String,handler: @escaping (_ success:[TonKhoSanPham],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[TonKhoSanPham] = []
        let parameters: [String: String] = [
            "mashop":"\(Cache.user!.ShopCode)",
            "listmasp":"\(listmasp)"
        ]
        provider.request(.inov_listTonKhoSanPham(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = TonKhoSanPham.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func checkPromotionImeis(ItemCode:String,Whscode:String,handler: @escaping (_ success:[PromotionImei],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[PromotionImei] = []
        let parameters: [String: String] = [
            "itemcode":"\(ItemCode)",
            "warehouse":"\(Whscode)"
        ]
        provider.request(.checkPromotionImeis(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = PromotionImei.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_sp_UpdateTargerPD_Delete(CuratorCode:String,Thang:String,IDTarget:String,handler: @escaping (_ results: [DeleteTarget],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            
            
            
            "CuratorCode":"\(CuratorCode)",
            "Thang": "\(Thang)",
            "UserID": "\(Cache.user!.UserName)",
            "IDTarget":"\(IDTarget)"
            
        ]
        debugPrint(parameters)
        var rs:[DeleteTarget] = []
        provider.request(.mpos_sp_UpdateTargerPD_Delete(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = DeleteTarget.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            
                            handler(rs,"Không load được data!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func mpos_sp_CheckUpdateInfo_TraGop(VendorCode:String,CMND:String,FullName:String,SDT:String,HoKhauTT:String,NgayCapCMND:String,NoiCapCMND:String,ChucVu:String,NgayKiHD:String,SoTKNH:String,IdBank:String,ChiNhanhNH:String,Email:String,Note:String,CreateBy:String,FileAttachName:String,ChiNhanhDN:String,IDCardCode:String,LoaiKH:String,NgaySinh:String,CreditCard:String,MaNV_KH:String,VendorCodeRef:String,CMND_TinhThanhPho:String,CMND_QuanHuyen:String,CMND_PhuongXa:String,NguoiLienHe:String,SDT_NguoiLienHe:String,QuanHeVoiNguoiLienHe:String,NguoiLienHe_2:String,SDT_NguoiLienHe_2:String,QuanHeVoiNguoiLienHe_2:String,AnhDaiDien:String,GioThamDinh_TimeFrom:String,GioThamDinh_TimeTo:String,GioThamDinh_OtherTime:String,IdCardcodeRef:String,TenSPThamDinh:String,Gender:Int,handler: @escaping (_ success:String,_ pstatus:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        var NgayCapCMNDTemp = NgayCapCMND
        if(NgayCapCMNDTemp == "01/01/1970"){
            NgayCapCMNDTemp = ""
        }
        var NgayKiHDTemp = NgayKiHD
        if(NgayKiHDTemp == "01/01/1970"){
            NgayKiHDTemp = ""
        }
        var NgaySinhTemp = NgaySinh
        if(NgaySinhTemp == "01/01/1970"){
            NgaySinhTemp = ""
        }
        var AnhDaiDienTemp = AnhDaiDien
        if(AnhDaiDien == "null"){
            AnhDaiDienTemp = ""
        }
        
        var gioitinh:String = ""
        if(Gender != -1){
            gioitinh = "\(Gender)"
        }
        let parameters: [String: String] = [
            "VendorCode" : "\(VendorCode)",
            "CMND" : "\(CMND)",
            "FullName" : "\(FullName)",
            "SDT" : "\(SDT)",
            "HoKhauTT" : "\(HoKhauTT)",
            "NgayCapCMND" : "\(NgayCapCMNDTemp)",
            "NoiCapCMND" : "\(NoiCapCMND)",
            "ChucVu" : "\(ChucVu)",
            "NgayKiHD" : "\(NgayKiHDTemp)",
            "SoTKNH" : "\(SoTKNH)",
            "IdBank" : "\(IdBank)",
            "ChiNhanhNH" : "\(ChiNhanhNH)",
            "Email" : "\(Email)",
            "CreateBy" : "\(CreateBy)",
            "Note" : "\(Note)",
            
            "ChiNhanhDN" : "\(ChiNhanhDN)",
            "IDCardCode" : "\(IDCardCode)",
            "LoaiKH" : "\(LoaiKH)",
            "NgaySinh": "\(NgaySinhTemp)",
            "CreditCard": "\(CreditCard)",
            "MaNV_KH": "\(MaNV_KH)",
            "DiviceType" :"2",
            "VendorCodeRef":"\(VendorCodeRef)",
            "CMND_TinhThanhPho":"\(CMND_TinhThanhPho)",
            "CMND_QuanHuyen":"\(CMND_QuanHuyen)",
            "CMND_PhuongXa":"\(CMND_PhuongXa)",
            "NguoiLienHe":"\(NguoiLienHe)",
            "SDT_NguoiLienHe":"\(SDT_NguoiLienHe)",
            "QuanHeVoiNguoiLienHe":"\(QuanHeVoiNguoiLienHe)",
            "NguoiLienHe_2":"\(NguoiLienHe_2)",
            "SDT_NguoiLienHe_2":"\(SDT_NguoiLienHe_2)",
            "QuanHeVoiNguoiLienHe_2":"\(QuanHeVoiNguoiLienHe_2)",
            "AnhDaiDien":"\(AnhDaiDienTemp)",
            "FileAttachName":"\(FileAttachName)",
            "UserID":"\(Cache.user!.UserName)",
            "Gender":"\(gioitinh)"
        ]
        print(parameters)
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.mpos_sp_CheckUpdateInfo_TraGop(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let suc = json["Success"].boolValue
                // let message = json["message"].stringValue
                let p_Status = json["p_Status"].stringValue
                let p_Message = json["p_Message"].stringValue
                if(suc){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(p_Message,p_Status, "")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","", p_Message)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("","",error.localizedDescription)
            }
        }
    }
    //get goi cuoc ecom
    class func sp_mpos_FRT_SP_SIM_loadDSGoiCuoc_ecom(handler: @escaping (_ success:[GoiCuocEcom],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)"
        ]
        var rs:[GoiCuocEcom] = []
        provider.request(.sp_mpos_FRT_SP_SIM_loadDSGoiCuoc_ecom(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = GoiCuocEcom.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
        
    }
    class func mpos_sp_zen_vocuher_pos(sdt:String,xml_string:String,handler: @escaping (_ success:[GenVoucher],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let keychain = KeychainSwift()
        var list_VC = ""
        if let list = keychain.get("list_VC"){
            list_VC = list
        }
        let parameters: [String: String] = [
            "devicetype" : "2",
            "userID":"\(Cache.user!.UserName)",
            "Mashop":"\(Cache.user!.ShopCode)",
            "sdt":"\(sdt)",
            "xml_string":"\(xml_string)",
            "list_VC":"\(list_VC)"
        ]
        print(parameters)
        var list:[GenVoucher] = []
        provider.request(.mpos_sp_zen_vocuher_pos(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let data = json["mpos_sp_zen_vocuher_posResult"].array {
                    list = GenVoucher.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    var listVC = ""
                    for item in list {
                        if(listVC == ""){
                            listVC = "\(item.VC_code)"
                        }else{
                            listVC = ",\(item.VC_code)"
                        }
                    }
                    keychain.set(listVC, forKey: "list_VC")
                    handler(list,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,error.localizedDescription)
            }
        }
    }
    class func sp_mpos_Get_PaymentType_From_POS(handler: @escaping (_ success:[PaymentType],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[PaymentType] = []
        let parameters: [String: String] = [
            "WarehouseCode":"\(Cache.user!.ShopCode)",
            "UserID":"\(Cache.user!.UserName)"
        ]
        provider.request(.sp_mpos_Get_PaymentType_From_POS(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = PaymentType.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
                
            }
        }
    }
    
    class func mpos_FRT_MD_mpos_searchkeyword(keyword:String,type:Int,handler: @escaping (_ success:[PhoneNumberSearch],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")!
        let parameters: [String: String] = [
            "keyword":keyword,
            "Type": "\(type)",
            "Shopcode": Cache.user!.ShopCode,
            "CRMCode": crm,
            "Token" : Cache.user!.Token,
            "UserID" : Cache.user!.UserName,
        ]
        var rs:[PhoneNumberSearch] = []
        provider.request(.mpos_FRT_MD_mpos_searchkeyword(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    let p_Message = json["p_Message"].stringValue
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = PhoneNumberSearch.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,p_Message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_LoadSO_mpos_pre(docentry:String,type:Int,handler: @escaping (_ success:SOPhoneNumber?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "docentry":docentry,
            "ShopCode": Cache.user!.ShopCode,
            "UserID" : Cache.user!.UserName,
        ]
        provider.request(.mpos_FRT_SP_LoadSO_mpos_pre(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    let Message = json["Message"].stringValue
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let rs = SOPhoneNumber.getObjFromDictionary(data: json)
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,Message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func sp_mpos_GetCRMCode_ByMail(UserID:String,Password:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserID" : UserID,
            "Password":Password,
            "MaShop":"",
            "DeviceType":"2"
        ]
        debugPrint(parameters)
        provider.request(.sp_mpos_GetCRMCode_ByMail(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    let Message = json["Message"].stringValue
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(Message,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("",Message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func sp_mpos_FRT_SP_comboPK_fix_Price(handler: @escaping (_ success:Int?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "userID": Cache.user!.UserName,
            "MaShop" : Cache.user!.ShopCode
        ]
        
        provider.request(.sp_mpos_FRT_SP_comboPK_fix_Price(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            let rs = data[0]["price"].int
                            handler(rs,"")
                        }else{
                            handler(nil,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func sp_mpos_FRT_SP_comboPK_calculator(price:String,priceadd:String,xmllistsp:String,handler: @escaping (_ success:ComBoPKResult?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "MaShop": Cache.user!.ShopCode,
            "UserID" : Cache.user!.UserName,
            "price": price,
            "priceadd": priceadd,
            "xmllistsp":"\(xmllistsp)"
        ]
        print(parameters)
        var thongTinTv:[ThongTuVanComboPK] = []
        var sanPham:[SanPhamGoiYComboPK] = []
        let comboPK:ComBoPKResult = ComBoPKResult(thongtinTV: thongTinTv, sanPhamGoiYs: sanPham)
        provider.request(.sp_mpos_FRT_SP_comboPK_calculator(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["ThongTinTuVan"].array {
                            thongTinTv = ThongTuVanComboPK.parseObjfromArray(array: data)
                            if let data2 = json["SanPhamGoiY"].array {
                                sanPham = SanPhamGoiYComboPK.parseObjfromArray(array: data2)
                                comboPK.thongtinTV = thongTinTv
                                comboPK.sanPhamGoiYs = sanPham
                                handler(comboPK,"")
                            }else{
                                handler(nil,"Load API ERRO")
                            }
                            
                        }else{
                            handler(nil,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
        
    }
    
    class func sp_mpos_FRT_SP_TraGop_LoadThongTin_LenDoiSP(ItemCodeGoc:String,ItemCodeTuVan:String,GiaSPTuVan:String,handler: @escaping (_ success:[LenDoiSP],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserID": Cache.user!.UserName,
            "MaShop" : Cache.user!.ShopCode,
            "ItemCodeGoc":ItemCodeGoc,
            "ItemCodeTuVan":ItemCodeTuVan,
            "GiaSPTuVan":GiaSPTuVan
        ]
        var rs:[LenDoiSP] = []
        provider.request(.sp_mpos_FRT_SP_TraGop_LoadThongTin_LenDoiSP(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = LenDoiSP.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_MD_SP_MPOS_PhanLoai(keyword:String,handler: @escaping (_ success:Int,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "keyword":keyword
        ]
        provider.request(.mpos_FRT_MD_SP_MPOS_PhanLoai(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json!["Data"].array {
                            if(data.count > 0){
                                var p_type = data[0]["p_type"].int
                                p_type = p_type == nil ? 1 : p_type
                                handler(p_type!,"")
                            }else{
                                handler(1,"")
                            }
                        }else{
                            handler(1,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(1,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(1,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(1,error.localizedDescription)
            }
        }
    }
    
    //get qr code esim
    class func sp_mpos_FRT_SP_ESIM_getqrcode(SDT:
        String,SOMPOS:String,SeriSim:String,handler: @escaping (_ success:[EsimQRCode],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "Version":"\(Common.versionApp())",
            "UserCode":"\(Cache.user!.UserName)",
            "ShopCode":"\(Cache.user!.ShopCode)",
            "SerialSim":"\(SeriSim)"
        ]
        print(parameters)
        var rs:[EsimQRCode] = []
        provider.request(.sp_mpos_FRT_SP_ESIM_getqrcode(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        if !data.isEmpty{
                            let object = EsimQRCode.getObjFromDictionary(data: data)
                            rs.append(object)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        let message = json["Message"].string
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,message!)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func sp_mpos_FRT_SP_Esim_getSeri(SDT:
        String,ItemCode:String,SoMpos:String,handler: @escaping (_ success:[EsimSeri],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "SDT":"\(SDT)",
            "ItemCode":"\(ItemCode)",
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "SoMpos":"\(SoMpos)"
        ]
        print(parameters)
        var rs:[EsimSeri] = []
        provider.request(.sp_mpos_FRT_SP_Esim_getSeri(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = EsimSeri.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
                
            }
            
        }
        
    }
    
    class func sp_mpos_InstallCustInfo_CalllogCIC_CheckAndCreate(IDCardCode:String,handler: @escaping (_ success:[CustInfo_CalllogCIC],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "IDCardCode": IDCardCode,
            "UserID" : "\(Cache.user!.UserName)",
            "DeviceType":"2"
        ]
        print(parameters)
        var rs:[CustInfo_CalllogCIC] = []
        provider.request(.sp_mpos_InstallCustInfo_CalllogCIC_CheckAndCreate(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = CustInfo_CalllogCIC.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getAllCompanyAmortizations(handler: @escaping (_ success:[CompanyAmortization],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[CompanyAmortization] = []
        provider.request(.getAllCompanyAmortizations){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                
                if let data = json?["getAllCompanyAmortizationsResult"].array {
                    rs = CompanyAmortization.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func sp_mpos_FRT_SP_OutSide_LS_TheCao(userID:String, MaShop: String,handler: @escaping (_ success:[TheCaoOutside],_ error:String) ->Void){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "userID" : "\(Cache.user!.UserName)",
            "MaShop":MaShop
        ]
        print(parameters)
        var rs:[TheCaoOutside] = []
        provider.request(.sp_mpos_FRT_SP_OutSide_LS_TheCao(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = TheCaoOutside.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func sp_mpos_FRT_SP_OutSide_ls_naptien(userID:String, MaShop: String,handler: @escaping (_ success:[NapTienBHOutside],_ error:String) ->Void){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "userID" : "\(Cache.user!.UserName)",
            "MaShop":MaShop
        ]
        print(parameters)
        var rs:[NapTienBHOutside] = []
        provider.request(.sp_mpos_FRT_SP_OutSide_ls_naptien(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = NapTienBHOutside.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func sp_mpos_FRT_SP_Load_OutSide_Info(userID:String, MaShop: String,handler: @escaping (_ success:[OutsideInfo],_ error:String) ->Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "userID" : "\(Cache.user!.UserName)",
            "MaShop":MaShop
        ]
        print(parameters)
        var rs:[OutsideInfo] = []
        provider.request(.sp_mpos_FRT_SP_Load_OutSide_Info(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = OutsideInfo.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func sp_mpos_FRT_SP_OutSide_LS_ThuHo(userID:String, MaShop: String,handler: @escaping (_ success:[ThuHoOutside],_ error:String) ->Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "userID" : "\(Cache.user!.UserName)",
            "MaShop":MaShop
        ]
        print(parameters)
        var rs:[ThuHoOutside] = []
        provider.request(.sp_mpos_FRT_SP_OutSide_LS_ThuHo(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = ThuHoOutside.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getViettelPayTopup(UserID: String, ShopCode: String, CardValue: String,ProviderId: String,Quantity: String, TotalPurchasingAmount: String, TotalReferAmount: String, PhoneNumber: String, xmlstringpay: String, devicetype: String, version: String,codecrm :String,isCheckPromotion:String,OTPNumber:String,ValuePromotion:String,is_HeThongHD:Int,handler: @escaping (_ resultObject: ViettelPayTopup?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters = [
            "UserID" : UserID,"ShopCode" : ShopCode,"CardValue" : CardValue,"DiaChiShop":"\(Cache.user!.Address)","ProviderId":ProviderId,"Quantity":Quantity,"TotalPurchasingAmount" : TotalPurchasingAmount,"TotalReferAmount" : TotalReferAmount,"PhoneNumber" : PhoneNumber,"xmlstringpay" : xmlstringpay,"devicetype" : devicetype,"version": version,"codecrm": codecrm,"isCheckPromotion":isCheckPromotion,"OTPNumber":OTPNumber,"ValuePromotion":ValuePromotion,"SubId":"23","is_HeThongHD":"\(is_HeThongHD)"
        ]
        //SubId = 23 hardcode
        log.debug(parameters)
        provider.request(.ViettelPayTopup(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data1 = json["Data"]
                        let getSelectFromObject = ViettelPayTopup.getObjFromDictionary(data: data1)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if(getSelectFromObject.error_code == "00"){
                            let Tu_ngay = json["Tu_ngay"].stringValue
                            let Den_Ngay = json["Den_Ngay"].stringValue
                            let u_vocher = json["u_vocher"].stringValue
                            let u_Vchname = json["u_Vchname"].stringValue
                            getSelectFromObject.Tu_ngay = Tu_ngay
                            getSelectFromObject.Den_Ngay = Den_Ngay
                            getSelectFromObject.u_vocher = u_vocher
                            getSelectFromObject.u_Vchname = u_Vchname
                            handler(getSelectFromObject,"")
                        }else{
                            let error_message = json["error_msg"].string
                            handler(nil,error_message ?? "Thanh toán thất bại")
                        }
                        
                    }else{
                        let data = json["Message"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,data)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func sp_mpos_Getinfo_SaoKeLuong(IDCardCode:String,CMND:String,handler: @escaping (_ success:[SaoKeLuong],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "IDCardCode": IDCardCode,
            "CMND":CMND
        ]
        print(parameters)
        var rs:[SaoKeLuong] = []
        provider.request(.sp_mpos_Getinfo_SaoKeLuong(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = SaoKeLuong.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func sp_mpos_Update_ThongTinSaoKeLuong(IDCardCode:String,Thang:String,Luong:String,CMND:String,UrlSaoKe:String,handler: @escaping (_ success:[ThemSaoKe],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "IDCardCode": IDCardCode,
            "Thang":"\(Thang)",
            "Nam":"2019",
            "Luong":"\(Luong)",
            "UserID":"\(Cache.user!.UserName)",
            "CMND":CMND,
            "DeviceType":"2",
            "UrlSaoKe": "\(UrlSaoKe)"
        ]
        print(parameters)
        var rs:[ThemSaoKe] = []
        provider.request(.sp_mpos_Update_ThongTinSaoKeLuong(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = ThemSaoKe.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func sp_mpos_info_SaoKeLuong_Huy(IDSaoKe:String,handler: @escaping (_ success:[ThemSaoKe],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "IDSaoKe": IDSaoKe,
            "UserID":"\(Cache.user!.UserName)",
            "DeviceType":"2"
        ]
        print(parameters)
        var rs:[ThemSaoKe] = []
        provider.request(.sp_mpos_info_SaoKeLuong_Huy(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = ThemSaoKe.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func UploadImage_CalllogScoring(IdCardCode:String,base64:String
        ,type:String,CMND:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters: [String: String] = [
            "IdCardCode": IdCardCode,
            "base64":"\(base64)",
            "Type":"\(type)",
            "CMND":"\(CMND)"
        ]
        log.info(parameters)
        
        provider.request(.UploadImage_CalllogScoring(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let rs = json["Message"].string
                        handler(rs!,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        //handler("","Load API ERRO")
                        let rs = json["Message"].string
                        handler(rs!,"")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func sp_mpos_UploadImageScoring(UserID:String,IdCardCode:String,Url_MT_CMND:String,Url_MS_CMND:String,Url_GPLX_MT:String,Url_GPLX_MS:String,Url_TheNV:String,Url_ChanDungKH:String,Url_XacNhanNhanSu:String,Url_SoHoKhau_1:String,Url_SoHoKhau_2:String,Url_SoHoKhau_3:String,Url_SoHoKhau_4:String,Url_SoHoKhau_5:String,Url_SoHoKhau_6:String,Url_SoHoKhau_7:String,Url_SaoKeLuong_1:String,Url_SaoKeLuong_2:String,Url_SaoKeLuong_3:String,CMND:String,VendorCode:String,handler: @escaping (_ success:[UploadImageScoringResult],_ error:String) ->Void){
        let log = SwiftyBeaver.self
        let parameters: [String: String] = [
            "UserID" : "\(UserID)",
            "IDCardCode" : "\(IdCardCode)",
            "DeviceType" : "2",
            "Url_MT_CMND" : "\(Url_MT_CMND)",
            "Url_MS_CMND" : "\(Url_MS_CMND)",
            "Url_GPLX_MT" : "\(Url_GPLX_MT)",
            "Url_GPLX_MS" : "\(Url_GPLX_MS)",
            "Url_TheNV" : "\(Url_TheNV)",
            "Url_ChanDungKH" : "\(Url_ChanDungKH)",
            "Url_XacNhanNhanSu" : "\(Url_XacNhanNhanSu)",
            "Url_SoHoKhau_1" : "\(Url_SoHoKhau_1)",
            "Url_SoHoKhau_2" : "\(Url_SoHoKhau_2)",
            "Url_SoHoKhau_3" : "\(Url_SoHoKhau_3)",
            "Url_SoHoKhau_4" : "\(Url_SoHoKhau_4)",
            "Url_SoHoKhau_5" : "\(Url_SoHoKhau_5)",
            "Url_SoHoKhau_6" : "\(Url_SoHoKhau_6)",
            "Url_SoHoKhau_7" : "\(Url_SoHoKhau_7)",
            "Url_SaoKeLuong_1" : "\(Url_SaoKeLuong_1)",
            "Url_SaoKeLuong_2" : "\(Url_SaoKeLuong_2)",
            "Url_SaoKeLuong_3" : "\(Url_SaoKeLuong_3)",
            "CMND":"\(CMND)",
            "VendorCode":"\(VendorCode)"
        ]
        log.debug(parameters)
        var rs:[UploadImageScoringResult] = []
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.sp_mpos_UploadImageScoring(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = UploadImageScoringResult.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func sp_mpos_Scoring_CheckDiemLietFRT(IDCardCode:String,handler: @escaping (_ success:[DiemLietFRT],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters: [String: String] = [
            "IDCardCode": IDCardCode,
            "UserID":"\(Cache.user!.UserName)",
            "DeviceType":"2"
        ]
        log.debug(parameters)
        var rs:[DiemLietFRT] = []
        provider.request(.sp_mpos_Scoring_CheckDiemLietFRT(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = DiemLietFRT.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func sp_mpos_Scoring_CheckDiemLietFRT_ByCMND(CMND:String,handler: @escaping (_ success:[CheckDiemLietFRT_ByCMND],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "CMND": CMND
        ]
        print(parameters)
        var rs:[CheckDiemLietFRT_ByCMND] = []
        provider.request(.sp_mpos_Scoring_CheckDiemLietFRT_ByCMND(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                guard let json = try? JSON(data: data) else {
                    handler(rs,"Load API ERROR")
                    return
                    
                }
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = CheckDiemLietFRT_ByCMND.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func sp_mpos_Scoring_LoadKyHanTraGop(IDCardCode:String,handler: @escaping (_ success:[ScoringKyHan],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "IDCardCode": IDCardCode,
            "MaShop":"\(Cache.user!.ShopCode)",
            "UserID": "\(Cache.user!.UserName)"
        ]
        print(parameters)
        var rs:[ScoringKyHan] = []
        provider.request(.sp_mpos_Scoring_LoadKyHanTraGop(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = ScoringKyHan.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func VTGetSimInfoByPhoneNumber(isdn:String,handler: @escaping (_ success:SimThuong?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "isdn": isdn
        ]
        print(parameters)
        provider.request(.VTGetSimInfoByPhoneNumber(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let suc = json["Success"].bool {
                    let Message = json["Message"].stringValue
                    if(suc){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let data = json["Data"]
                        if !data.isEmpty {
                            let rs = SimThuong.getObjFromDictionary(data: data)
                            handler(rs,Message)
                        }else{
                            handler(nil,Message)
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,Message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    
    class func VTGetListCustomerByIsdnErp(Isdn:String, idNo:String ,handler: @escaping (_ success:[SimCustomer],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "Isdn": Isdn,
            "idNo": idNo
        ]
        print(parameters)
        var rs:[SimCustomer] = []
        provider.request(.VTGetListCustomerByIsdnErp(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let suc = json["Success"].bool {
                    let Message = json["Message"].stringValue
                    if(suc){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = SimCustomer.parseObjfromArray(array: data)
                            handler(rs,Message)
                        }else{
                            handler(rs,Message)
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,Message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func VTGetReasonCodes(UserId:String, MaShop:String, is_trasau:String, is_otp: String ,handler: @escaping (_ success:[ReasonCodes],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserId": UserId,
            "MaShop": MaShop,
            "is_trasau": is_trasau,
            "is_otp": "\(is_otp)"
        ]
        print(parameters)
        var rs:[ReasonCodes] = []
        provider.request(.VTGetReasonCodes(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let suc = json["Success"].bool {
                    let Message = json["Message"].stringValue
                    if(suc){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = ReasonCodes.parseObjfromArray(array: data)
                            handler(rs,Message)
                        }else{
                            handler(rs,Message)
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,Message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func GetProvincesSim(NhaMang: String ,handler: @escaping (_ success:[Province],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "NhaMang": NhaMang
        ]
        print(parameters)
        var rs:[Province] = []
        provider.request(.GetProvincesSim(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let suc = json["Success"].bool {
                    if(suc){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = Province.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func VTChangeSimErp(FullName:String, BirthDay: String, Gender: String, Address: String, DateCreateCMND: String, PalaceCreateCMND: String, is_esim: String, is_trasau: String, Provider: String, Isdn: String, normalIsdn: Bool, idNo: String, otpCode: String, reasonCode: String, oldSerial: String, newSerial: String, isdnContact1: String, isdnContact2: String, isdnContact3: String, ShopCode: String, UserCode: String, Images: String,
                              handler: @escaping (_ success:Bool,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        
        let parameters: [String: Any] = [
            "FullName": FullName,
            "BirthDay": BirthDay,
            "Gender": Gender,
            "Address": Address,
            "DateCreateCMND": DateCreateCMND,
            "PalaceCreateCMND": PalaceCreateCMND,
            "is_esim": is_esim,
            "is_trasau": is_trasau,
            "Provider": Provider,
            "Isdn": Isdn,
            "normalIsdn": normalIsdn,
            "idNo": idNo,
            "otpCode": otpCode,
            "reasonCode": reasonCode,
            "oldSerial": oldSerial,
            "newSerial": newSerial,
            "isdnContact1": isdnContact1,
            "isdnContact2": isdnContact2,
            "isdnContact3": isdnContact3,
            "ShopCode": ShopCode,
            "UserCode": UserCode,
            "Images": Images,
            "deviceType": "2",
            "version": "\(Common.versionApp())"
        ]
        print(parameters)
        provider.request(.VTChangeSimErp(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                debugPrint(json)
                let success = json["Success"].boolValue
                let Message = json["Message"].stringValue
                handler(success, Message)
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(false,error.localizedDescription)
                
            }
        }
    }
    
    class func VTGetChangeSimHistory(fromdate:String,toDate:String,UserName: String, ShopCode:String, IsdnOrSerial: String, handler: @escaping (_ success:[SimHistoryItem],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let from = Common.convertDateToStringWith(dateString: fromdate, formatIn: "dd/MM/yyyy", formatOut: "yyyy-MM-dd")
        let to = Common.convertDateToStringWith(dateString: toDate, formatIn: "dd/MM/yyyy", formatOut: "yyyy-MM-dd")
        let parameters: [String: String] = [
            "UserCode": UserName,
            "ShopCode": ShopCode,
            "IsdnOrSerial": IsdnOrSerial,
            "FromDate": "\(from) 00:00:00",
              "ToDate": "\(to) 23:59:59"
        ]
        print(parameters)
        var rs:[SimHistoryItem] = []
        provider.request(.VTGetChangeSimHistory(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let success = json["Success"].boolValue
                    let Message = json["Message"].stringValue
                    if success {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = SimHistoryItem.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"")
                        }
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler([], Message)
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([],error.localizedDescription)
            }
        }
    }
    class func confirmPasswordUpdatePG(cmnd: String, password:String, handler: @escaping (_ mCode:String, _ mData: String,_ mDetail:String) ->Void) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "userCode": cmnd,
            "passWord": password
        ]
        print(parameters)
        provider.request(.confirmPasswordUpdatePG(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let mCode = json["Code"].string
                let mData = json["Data"].string
                let mDetail = json["Detail"].string
                handler(mCode!,mData!, mDetail!)
            case .failure(_):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("","","")
            }
        }
    }
    
    class func sp_mpos_FRT_SP_combopk_searchsp(keyword:String,handler: @escaping (_ success:[ComboPK_SearchSP],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[ComboPK_SearchSP] = []
        let parameters: [String: String] = [
            "keyword": keyword,
            "UserID" : "\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.sp_mpos_FRT_SP_combopk_searchsp(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = ComboPK_SearchSP.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
                
            }
        }
    }
    
    class func thong_bao_tai_lieu(handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:String = ""
        
        provider.request(.thong_bao_tai_lieu) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let success = json["data"].string {
                    handler(success,"")
                } else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func sp_mpos_FRT_SP_GetFormNotiHome(handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:String = ""
        let parameters: [String: String] = [
            
            "UserID" : "\(Cache.user!.UserName)"
            
        ]
        print(parameters)
        provider.request(.sp_mpos_FRT_SP_GetFormNotiHome(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json!["Data"].array {
                            if(data.count > 0){
                                rs = data[0]["p_messagess"].string!
                                handler(rs,"")
                            }else{
                                handler(rs,"Load API ERRO")
                            }
                            
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
                
            }
        }
    }
    class func sp_mpos_FRT_SP_GetNotiSauChamCong(handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:String = ""
        let parameters: [String: String] = [
            "UserCode" : "\(Cache.user!.UserName)"
        ]
        print(parameters)
        provider.request(.sp_mpos_FRT_SP_GetNotiSauChamCong(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json!["Data"].dictionaryObject {
                            print(data)
                            if let result = data["content"]  {
                                rs = result as! String
                                handler(rs,"")
                            }else{
                                handler(rs,"Load API ERRO")
                            }
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)

            }
        }
    }
    class func sp_mpos_FRT_SP_Camera_listShopByUser(handler: @escaping (_ success:[CameraShop],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[CameraShop] = []
        let parameters: [String: String] = [
            "UserID" : "\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.sp_mpos_FRT_SP_Camera_listShopByUser(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = CameraShop.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
                
            }
        }
    }
    class func sp_mpos_FRT_SP_Camera_getLinkDetail_online(MaShop:String,handler: @escaping (_ success:[CameraDetail],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[CameraDetail] = []
        let parameters: [String: String] = [
            "UserID" : "\(Cache.user!.UserName)",
            "MaShop":"\(MaShop)"
        ]
        print(parameters)
        provider.request(.sp_mpos_FRT_SP_Camera_getLinkDetail_online(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = CameraDetail.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_UploadImage_CalllogInside(FileName:String,Base64String:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserCode" : "\(Cache.user!.UserName)",
            "FileName":"\(FileName)",
            "Base64String":"\(Base64String)"
        ]
        provider.request(.mpos_UploadImage_CalllogInside(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    var Message = json["Message"].string
                    var Path_Image = json["Path_Image"].string
                    Message = Message == nil ? "" : Message
                    Path_Image = Path_Image == nil ? "" : Path_Image
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(Path_Image!,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("",Message!)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
                
            }
        }
    }
    class func mpos_FRT_SP_Calllog_createissue(Message_user:String,message_api:String,urlimage_1:String,urlimage_2:String,urlimage_3:String,ItemId:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserID" : "\(Cache.user!.UserName)",
            "MaShop" : "\(Cache.user!.ShopCode)",
            "Message_user":"\(Message_user)",
            "message_api":"\(message_api)",
            "urlimage_1" : "\(urlimage_1)",
            "urlimage_2":"\(urlimage_2)",
            "urlimage_3":"\(urlimage_3)",
            "ItemId": "\(ItemId)",
            "DeviceType": "2"
        ]
        provider.request(.mpos_FRT_SP_Calllog_createissue(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let data1 = json["Data"]
                        if(!data1.isEmpty){
                            if(data1.count > 0){
                                let p_status = data1[0]["p_status"].boolValue
                                let p_messagess = data1[0]["p_messagess"].stringValue
                                if(p_status){
                                    handler(p_messagess,"")
                                }else{
                                    handler("",p_messagess)
                                }
                            }else{
                                handler("","Load API ERRO")
                            }
                            
                        }else{
                            handler("","Load API ERRO")
                        }
                    }else{
                        var data1 = json["Data"].string
                        data1 = data1 == nil ? "" : data1
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("",data1!)
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
                
            }
        }
    }
    class func getVendorFFriendV2(LoaiDN:String,handler: @escaping (_ success:[CompanyFFriend],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[CompanyFFriend] = []
        let parameters: [String: String] = [
            
            :]
        print(parameters)
        provider.request(.getVendorFFriend_V2(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = CompanyFFriend.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getBranchCompanyFFriend(VendorCode:String,handler: @escaping (_ success:[BranchCompanyFFriend],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[BranchCompanyFFriend] = []
        let parameters: [String: String] = [
            "VendorCode": "\(VendorCode)"
        ]
        print(parameters)
        provider.request(.mpos_sp_GetVendor_ChiNhanhDN(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = BranchCompanyFFriend.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func getChucVuFFriend(handler: @escaping (_ success:[ChucVuFFriend],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        var rs:[ChucVuFFriend] = []
        let parameters: [String: String] = [
            
            :]
        log.debug(parameters)
        provider.request(.mpos_sp_GetVendor_ChucVu(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = ChucVuFFriend.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func sp_mpos_CheckHanMucKH(IdCardCode:String,KyHan:String,handler: @escaping (_ result:Int,_ message:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "IdCardCode":IdCardCode,
            "KyHan":KyHan
        ]
        print(parameters)
        provider.request(.sp_mpos_CheckHanMucKH(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            
                            let result = data[0]["Result"].intValue
                            let message = data[0]["Message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(result,message,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(0,"","Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"","Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"",error.localizedDescription)
            }
        }
    }
    
    class func mpos_sp_verify_VC_mpos_innovation(sdt:String,doctypeSO:String,tmonbi:String,basexml_list_VC_added:String,basexml_list_detail_SO:String,vC_code:String,handler: @escaping (_ success:[VerifyVoucher],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "sdt":"\(sdt)",
            "devicetype" : "2",
            "userID":"\(Cache.user!.UserName)",
            "maShop":"\(Cache.user!.ShopCode)",
            "doctypeSO":"\(doctypeSO)",
            "tmonbi":"\(tmonbi)",
            "basexml_list_VC_added":"\(basexml_list_VC_added)",
            "basexml_list_detail_SO": "\(basexml_list_detail_SO)",
            "vC_code":"\(vC_code)"
        ]
        print(parameters)
        var rs:[VerifyVoucher] = []
        provider.request(.mpos_sp_verify_VC_mpos_innovation(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print("card type: \(json)")
                if let data = json["mpos_sp_verify_VC_mpos_innovationResult"].array {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    rs = VerifyVoucher.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                debugPrint(error.localizedDescription)
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func mpos_sp_GetVendor_DuoiEmail(VendorCode:String,handler: @escaping (_ success:[DuoiEmailFFriend],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        var rs:[DuoiEmailFFriend] = []
        let parameters: [String: String] = [
            "VendorCode":VendorCode
        ]
        log.debug(parameters)
        provider.request(.mpos_sp_GetVendor_DuoiEmail(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = DuoiEmailFFriend.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func getProvidersGrab(handler: @escaping (_ success:[Providers],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "MaNV": "\(Cache.user!.UserName)",
            "MaShop": "\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        var rs:[Providers] = []
        provider.request(.getProvidersGrab(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let suc = json["Success"].bool {
                    let Message = json["Message"].stringValue
                    if(suc){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let data = json["Data"]
                        let listService = data["ListService"].array
                        for item in listService!{
                            if(item["PaymentBillServiceName"].string == "Nạp tiền tài khoản"){
                                if let listProvider = item["ListProvider"].array{
                                    rs = Providers.parseObjfromArray(array: listProvider)
                                    handler(rs, "")
                                }else{
                                    handler(rs,Message)
                                }
                            }
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,Message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                debugPrint(error.localizedDescription)
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func payOfflineBillBE(serviceCode:String,serviceName:String,providerCode:String,providerName:String,customerId:String,customerName:String,customerPhone:String,customerAddress:String,contactAddress:String,contactName:String,contactPhoneNumber:String,moneyAmount:String,xmlStringPay:String,addingInput:String,handler: @escaping (_ success:PayOfflineBillBE,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        let parameters: [String: String] = [
            
            "userCode":"\(Cache.user!.UserName)",
            "shopCode": "\(Cache.user!.ShopCode)",
            "codeCrm": "\(crm ?? "")",
            "deviceType": "2",
            "token": "\(Cache.user!.Token)",
            "serviceCode": "\(serviceCode)",
            "serviceName": "\(serviceName)",
            "providerCode": "\(providerCode)",
            "providerName": "\(providerName)",
            "customerId": "\(customerId)", //so hop dong
            "customerName": "\(customerName)",
            "customerPhone": "\(customerPhone)",
            "customerAddress": "\(customerAddress)",
            "contactAddress": "\(contactAddress)",
            "contactName": "\(contactName)",
            "contactPhoneNumber": "\(contactPhoneNumber)",
            "moneyAmount": "\(moneyAmount)",
            "fee": "0",
            "invoiceNo": "00000",
            "isConfirmed": "false",
            "addingInput": "\(addingInput)",
            "xmlStringPay": "\(xmlStringPay)"
        ]
        print(parameters)
        var rs:PayOfflineBillBE?
        provider.request(.payOfflineBillBE(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let suc = json["Success"].bool {
                    let Message = json["Message"].stringValue
                    if(suc){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let data = json["Data"]
                        rs = PayOfflineBillBE.getObjFromDictionary(data: data)
                        handler(rs!,"")
                        
                    }else{
                        let rs2: PayOfflineBillBE = PayOfflineBillBE(OrderNo:""
                            , ReturnCode:""
                            , ReturnCodeDescription:""
                            , DocEntry:0
                            , MaGDFRT: ""
                            ,VCName:""
                            ,VCnum:""
                            ,Den_ngay:""
                            ,Tu_ngay:"")
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs2,Message)
                    }
                }else{
                    rs = nil
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs!,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs!,error.localizedDescription)
            }
        }
    }
    class func genQRCode(amount:String,purpose:String,handler: @escaping (_ success:QRCodeVNPay?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "shopCode":"\(Cache.user!.ShopCode)",
            "amount":amount,
            "creatBy":"\(Cache.user!.UserName)",
            "terminalId":"FPT02",
            "note":"",
            "purpose": purpose
        ]
        provider.request(.genQRCode(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let code = json["Code"].string {
                    if(code == "001"){
                        let data1 = json["Data"]
                        let rs = QRCodeVNPay.getObjFromDictionary(data: data1)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    
    class func PayOfflineBillBEHistory_Grab(handler: @escaping (_ success:[HistoryGrab],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "userCode": "\(Cache.user!.UserName)",
            "shopCode": "\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        var rs:[HistoryGrab] = []
        provider.request(.PayOfflineBillBEHistory_Grab(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let suc = json["Success"].bool {
                    let Message = json["Message"].stringValue
                    if(suc){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = HistoryGrab.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,Message)
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,Message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func checkTransactionQR(transactionQR:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "ddMMyyyy"
        let dateString = inputFormatter.string(from: Date())
        let log = SwiftyBeaver.self
        let parameters: [String: String] = [
            "transactionQR":transactionQR,
            "paymentDate":dateString,
            "terminalID":"FPT02",
            "shopCode":"\(Cache.user!.ShopCode)",
            "creatBy":"\(Cache.user!.UserName)",
        ]
        log.debug(parameters)
        provider.request(.checkTransactionQR(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                if let code = json["Code"].string {
                    if(code == "001"){
                        let data1 = json["Data"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(data1,"")
                    }else{
                        let data1 = json["Data"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("",data1)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    
    class func pushBillThuHoGrab(printBill: BillParamGrab) {
        
        let mn = Config.manager
        
        let action = "\(Cache.user!.ShopCode)/push"
        let urlString = "\(mn.URL_PRINT_BILL!)/api/\(action)"
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 160
        if let data =  try? JSONSerialization.data(withJSONObject: printBill.toJSON(), options: []){
            if let jsonData = String(data:data, encoding:.utf8) {
                print(jsonData)
                let billParam = BillParam(title: "In Thu Ho Grap", body: jsonData,id: "POS", key: "pos_thuho_grap")
                let billMessage = BillMessage(message:billParam)
                
                print("\(urlString) \(billMessage.toJSON())")
                if let data2 =  try? JSONSerialization.data(withJSONObject: billMessage.toJSON(), options: []){
                    if let url = URL(string: urlString) {
                        var request = URLRequest(url: url)
                        request.httpMethod = HTTPMethod.post.rawValue
                        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                        request.httpBody = data2
                        manager.request(request).responseJSON {
                            (response) in
                            print(response)
                        }
                    }
                }
            }
        }
    }
    
    class func mpos_verify_maxacthuc_point(sdt:String,MaXacThuc:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "sdt":"\(sdt)",
            "devicetype" : "2",
            "UserID":"\(Cache.user!.UserName)",
            "Mashop":"\(Cache.user!.ShopCode)",
            "MaXacThuc":"\(MaXacThuc)",
        ]
        provider.request(.mpos_verify_maxacthuc_point(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                print("card type: \(json)")
                if let data = json["mpos_verify_maxacthuc_pointResult"].array {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if(data.count > 0){
                        let it = data[0]
                        var p_messagess = it["p_messagess"].string
                        var p_status = it["p_status"].int
                        p_status = p_status == nil ? 0 : p_status
                        p_messagess = p_messagess == nil ? "" : p_messagess
                        if(p_status == 1){
                            handler(p_messagess!,"")
                        }else{
                            handler("",p_messagess!)
                        }
                    }else{
                        handler("","Xác nhận không thành công!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                debugPrint(error.localizedDescription)
                handler("",error.localizedDescription)
            }
        }
    }
    
    
    //tra gop mirae
    class func mpos_FRT_SP_mirae_checkinfocustomer(IDcard:String,Gender:String,FirstName:String,MiddleName:String,LastName:String,BirthDay:String,PhoneNumber:String,fptrequest_Front:String,fptrequest_Behind:String,partnerID: String,handler: @escaping (_ success:[InfoCustomerMirae],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[InfoCustomerMirae] = []
        var gioitinh:String = ""
        if(Gender == "0"){
            gioitinh = "M"
        }else{
            gioitinh = "F"
        }
        let parameters: [String: String] = [
            "IDcard":"\(IDcard)",
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "Gender":"\(gioitinh)",
            "FirstName":"\(FirstName)",
            "MiddleName":"\(MiddleName)",
            "LastName":"\(LastName)",
            "BirthDay":"\(BirthDay)",
            "PhoneNumber":"\(PhoneNumber)",
            "fptrequest_Front":"\(fptrequest_Front)",
            "fptrequest_Behind":"\(fptrequest_Behind)",
            "DeviceType":"1",
            "partnerId":partnerID
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_mirae_checkinfocustomer(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = InfoCustomerMirae.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERROR")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,json["Data"].description != "" ? json["Data"].description :  "Load API ERROR")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_Mirae_loadTypeDoc(handler: @escaping (_ success:[MiraeLoaiChungTu],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[MiraeLoaiChungTu] = []
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_Mirae_loadTypeDoc(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = MiraeLoaiChungTu.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_Mirae_loadProvince(handler: @escaping (_ success:[TinhThanhMirae],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[TinhThanhMirae] = []
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_Mirae_loadProvince(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                //  print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = TinhThanhMirae.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func BaoLoiNguoiDung__GetConv(p_RequestId:Int,handler: @escaping (_ success:[CallLogErrorMessage],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[CallLogErrorMessage] = []
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user!.UserName)",
            "p__Token": "\(Cache.user!.Token)",
            "p_RequestId": "\(p_RequestId)"
        ]
        provider.request(.BaoLoiNguoiDung__GetConv(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let data = json?["sp__mCallLog__BaoLoiNguoiDung__GetConvResult"].array {
                    rs = CallLogErrorMessage.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func mpos_FRT_SP_Mirae_loadDistrict(ProvinceCode:String,handler: @escaping (_ success:[QuanHuyenMirae],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[QuanHuyenMirae] = []
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "ProvinceCode":"\(ProvinceCode)"
            
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_Mirae_loadDistrict(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = QuanHuyenMirae.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_Mirae_loadPrecinct(ProvinceCode:String,DistrictCode:String,handler: @escaping (_ success:[PhuongXaMirae],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[PhuongXaMirae] = []
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "ProvinceCode":"\(ProvinceCode)",
            "DistrictCode":"\(DistrictCode)"
            
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_Mirae_loadPrecinct(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = PhuongXaMirae.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_Mirae_Insert_image_contract(base64Xmlimage:String,Docentry:String,processId:String,IsUpdate:String,handler: @escaping (_ success:[InsertImageMirae],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
     
        var rs:[InsertImageMirae] = []
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "base64Xmlimage":"\(base64Xmlimage)",
            "Docentry":"\(Docentry)",
            "processId":"\(processId)",
            "DeviceID":"2",
            "IsUpdate":"\(IsUpdate)"
            
        ]
   
        provider.request(.mpos_FRT_SP_Mirae_Insert_image_contract(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
            
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = InsertImageMirae.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_mirae_loadinfoByCMND(base64_MT:String,base64_MS:String,handler: @escaping (_ success:[LoadinfoByCMND],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[LoadinfoByCMND] = []
        let log = SwiftyBeaver.self
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "base64_MT":"\(base64_MT)",
            "base64_MS":"\(base64_MS)",
            "partnerId" : PARTNERIDORDER
        ]
        log.debug(parameters)
        //print(parameters)
        provider.request(.mpos_FRT_SP_mirae_loadinfoByCMND(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                
            
                log.debug(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json!["Data"].array {
                            rs = LoadinfoByCMND.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_Mirae_create_infoCustomer(IDMPOS:String,P_ProvinceCode:String,P_DistrictCode:String,P_PrecinctCode:String,P_Address:String,CompanyName:String,JobTilte:String,Seniority:String,Salary:String,C_ProvinceCode:String,C_DistrictCode:String,C_PrecinctCode:String,C_Address:String,IDcard_old:String,C_PhoneNumber:String,C_TypeDoc:String,Ref_FullName:String,Ref_relationship:String,Ref_phonenumber:String,processId:String,activityId:String,DeviceID:String,WorkYear:String,dueday:String,FirstImei_day:String,BirthDay:String,PhoneNumber:String,IDcard:String,LastName:String,MiddleName:String,FirstName:String,Gender:String,idIssuedBy:String,idIssuedDate:String,Ref_phonenumber_2:String,refName_2:String,refRelationship_2:String,P_ProvinceCode_2:String,P_DistrictCode_2:String,P_PrecinctCode_2:String,P_Address_2:String,handler: @escaping (_ success:[CreateInfoCustomer],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[CreateInfoCustomer] = []
        let log = SwiftyBeaver.self
        let parameters: [String: String] = [
            
            "IDMPOS": IDMPOS,
            "MaShop":"\(Cache.user!.ShopCode)",
            "UserID":"\(Cache.user!.UserName)",
            "P_ProvinceCode": P_ProvinceCode,
            "P_DistrictCode": P_DistrictCode,
            "P_PrecinctCode": P_PrecinctCode,
            "P_Address": P_Address,
            "CompanyName": CompanyName,
            "JobTilte": JobTilte,
            "Seniority": Seniority,
            "Salary": Salary,
            "C_ProvinceCode": C_ProvinceCode,
            "C_DistrictCode": C_DistrictCode,
            "C_PrecinctCode": C_PrecinctCode,
            "C_Address": C_Address,
            "IDcard_old": IDcard_old,
            "C_PhoneNumber": C_PhoneNumber,
            "C_TypeDoc": C_TypeDoc,
            "Ref_FullName": Ref_FullName,
            "Ref_relationship": Ref_relationship,
            "Ref_phonenumber": Ref_phonenumber,
            "processId": processId,
            "activityId": activityId,
            "DeviceID": DeviceID,
            "WorkYear":"\(WorkYear)",
            "dueday":"\(dueday)",
            "FirstImei_day":"\(FirstImei_day)",
            "idIssuedBy":"\(idIssuedBy)",
            "idIssuedDate":"\(idIssuedDate)",
            "Ref_phonenumber_2":"\(Ref_phonenumber_2)",
            "Ref_FullName_2":"\(refName_2)",
            "Ref_relationship_2":"\(refRelationship_2)",
            "P_ProvinceCode_2":"\(P_ProvinceCode_2)",
            "P_DistrictCode_2":"\(P_DistrictCode_2)",
            "P_PrecinctCode_2":"\(P_PrecinctCode_2)",
            "P_Address_2":"\(P_Address_2)"
            //            "BirthDay":"\(BirthDay)",
            //            "PhoneNumber":"\(PhoneNumber)",
            //            "IDcard":"\(IDcard)",
            //            "LastName":"\(LastName)",
            //            "MiddleName":"\(MiddleName)",
            //            "FirstName":"\(FirstName)",
            //            "Gender":"\(Gender)"
            
        ]
        log.debug(parameters)
        //print(parameters)
        provider.request(.mpos_FRT_SP_Mirae_create_infoCustomer(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                //print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = CreateInfoCustomer.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_Mirae_loadscheme(RDR1:String,partnerId: String,handler: @escaping (_ success:[LaiSuatMirae],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[LaiSuatMirae] = []
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "RDR1":"\(RDR1)",
            "partnerId":partnerId
            
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_Mirae_loadscheme(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = LaiSuatMirae.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_mirae_loadDueDay(handler: @escaping (_ success:[DueDayMirae],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[DueDayMirae] = []
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_mirae_loadDueDay(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = DueDayMirae.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func checkPromotionMirae(u_CrdCod:String,sdt:String,LoaiDonHang:String,LoaiTraGop:String,LaiSuat:Float,SoTienTraTruoc:Float,voucher:String,kyhan:String,U_cardcode:String,HDNum:String,Docentry:String,schemecode:String,isProsShinhanHistory: Bool = false,handler: @escaping (_ success:Promotion?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var param:Dictionary = Dictionary<String, Any>()
        var xml = "<line>"
        for item in Cache.cartsMirae{
            var whsCod = "\(Cache.user!.ShopCode)010"
            if(item.whsCode.count > 0){
                whsCod = item.whsCode
            }
            var imei = item.imei
            if(imei == "N/A"){
                imei = ""
            }
            xml  = xml + "<item U_ItmCod=\"\(item.sku)\" U_Imei=\"\(imei)\" U_Quantity=\"\(item.quantity)\" U_PriceBT=\"\(String(format: "%.6f", item.product.priceBeforeTax))\" U_Price=\"\(String(format: "%.6f", item.product.price))\" U_WhsCod=\"\(whsCod)\"/>"
        }
        xml = xml + "</line>"
        var loaiGop = LoaiTraGop
        if (loaiGop == "-1"){
            loaiGop = "0"
        }
        
        
        param.updateValue(u_CrdCod, forKey: "u_CrdCod")
        param.updateValue(isProsShinhanHistory ? ShinhanData.createXmlPromotion() : xml, forKey: "itemsInXML")
        param.updateValue(sdt, forKey: "sdt")
        param.updateValue(LoaiDonHang, forKey: "LoaiDonHang")
        param.updateValue(loaiGop, forKey: "LoaiTraGop")
        param.updateValue("\(String(format: "%.6f", LaiSuat))", forKey: "LaiSuat")
        param.updateValue("\(String(format: "%.6f", SoTienTraTruoc))", forKey: "SoTienTraTruoc")
        param.updateValue(voucher, forKey: "voucher")
        param.updateValue("0", forKey: "idCardCodeFriend")
        param.updateValue(kyhan, forKey: "kyhan")
        param.updateValue(HDNum, forKey: "HDNum")
        param.updateValue(U_cardcode, forKey: "U_cardcode")
        param.updateValue("\(Cache.user!.UserName)", forKey: "UserID")
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        param.updateValue("\(crm ?? "")", forKey: "CRMCode")
        param.updateValue("\(Cache.user!.Token)", forKey: "Token")
        param.updateValue("\(Docentry)", forKey: "Docentry")
        param.updateValue("\(schemecode)", forKey: "schemecode")
        print(param)
        var promotion:Promotion? = nil
        provider.request(.checkPromotionMirae(params:param)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        if(!data.isEmpty){
                            let returnMessage = data["ReturnMessage"]
                            if(!returnMessage.isEmpty){
                                let p_status = returnMessage["p_status"].boolValue
                                let p_messagess = returnMessage["p_messagess"].stringValue
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                if(p_status){
                                    promotion = Promotion.getObjFromDictionary(data: data)
                                    handler(promotion,p_messagess)
                                }else{
                                    handler(promotion,p_messagess)
                                }
                            }else{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(promotion,"Kiểm tra khuyến mại thất bại!")
                            }
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(promotion,"Kiểm tra khuyến mại thất bại!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(promotion,"Kiểm tra khuyến mại thất bại!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(promotion,"Kiểm tra khuyến mại thất bại!")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(promotion,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_mirae_Getinfo_byContractNumber(IDMPOS:String,handler: @escaping (_ success:Getinfo_byContractNumber?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters: [String: String] = [
            "contractnumber":"",
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "Type":"\(1)",
            "IDMPOS":IDMPOS
            
            
        ]
        log.debug(parameters)
        provider.request(.mpos_FRT_SP_mirae_Getinfo_byContractNumber(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        if(!data.isEmpty){
                            let info = data["Info"]
                            if(!info.isEmpty){
                                let rs = Getinfo_byContractNumber.getObjFromDictionary(data: info)
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(rs,"")
                            }else{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(nil,"Không load được thông tin KH Info = null")
                            }
                            
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(nil,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_Mirae_laythongtinkhachhang_order(IDMPOS:String,handler: @escaping (_ success:[ThongTinKhachHangOrder],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[ThongTinKhachHangOrder] = []
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "IDMPOS":"\(IDMPOS)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_Mirae_laythongtinkhachhang_order(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = ThongTinKhachHangOrder.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_Mirae_LoadKyHan(xmlSP:String,IDMPOS:String,schemecode:String,partnerId: String,handler: @escaping (_ success:[KyHanMirae],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[KyHanMirae] = []
        let parameters: [String: String] = [
            "xmlSP":"\(xmlSP)",
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "IDMPOS":"\(IDMPOS)",
            "schemecode":"\(schemecode)",
            "partnerId": partnerId
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_Mirae_LoadKyHan(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = KyHanMirae.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func UploadImage_Mirae(base64:String,processId:String,IdCardNo:String,contentType:String,DirectoryMirae:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "processId":"\(processId)",
            "IdCardNo":"\(IdCardNo)",
            "base64":"\(base64)",
            "contentType":"\(contentType)",
            "DirectoryMirae":"\(DirectoryMirae)"
        ]
        print(parameters)
        provider.request(.UploadImage_Mirae(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        let FileName = json["FileName"].string
                        handler(FileName!,"")
                        
                    }else{
                        let message = json["Message"].string
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("",message!)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func mpos_sp_insert_order_mirae(phone:String,cmnd:String,CardName:String,U_EplCod:String,ShopCode:String,Sotientratruoc:String,Doctype:String,U_des:String,RDR1:String,PROMOS:String,LoaiTraGop:String,LaiSuat:String,voucher:String,otp:String,NgayDenShopMua:String,HinhThucGH:String,DiaChi:String,magioithieu:String,kyhan:String,Thanhtien:String,IDcardcode:String,HinhThucThuTien:String,soHDtragop:String,IsSkip:String,AuthenBy:String,chemecode:String,pre_docentry:String, tenCtyTraGop: String,handler: @escaping (_ result:Int,_ docentry:Int,_ err: String) ->Void){
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        
        let parameters: [String: String] = [
            "CMND":"\(cmnd)",
            "CardName":"\(CardName)",
            "U_EplCod":"\(U_EplCod)",
            "ShopCode":"\(ShopCode)",
            "SoTienTraTruoc":"\(Sotientratruoc)",
            "Doctype":"\(Doctype)",
            "U_des":"\(U_des)",
            "RDR1":"\(RDR1)",
            "PROMOS":"\(PROMOS)",
            "LoaiTraGop":"\(LoaiTraGop)",
            "LaiSuat":"\(LaiSuat)",
            "voucher":"\(voucher)",
            "Address":"\(DiaChi)",
            "gioitinh":"0",
            "kyhan":"\(kyhan)",
            "Thanhtien":"\(Thanhtien)",
            "soHDtragop":"\(soHDtragop)",
            "payments":"\(HinhThucThuTien)",
            "Mail":"",
            "DiviceType": "2",
            "NgaySinh":"",
            "CRMCode":"\(crm ?? "")",
            "Token":"\(Cache.user!.Token)",
            "UserID":"\(Cache.user!.UserName)",
            "chemecode":"\(chemecode)",
            "phone":"\(phone)",
            "TenCTyTraGop":tenCtyTraGop,
            "pre_docentry":"\(pre_docentry)"
        ]
        print(parameters)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.saveOrderMirae(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        if(!data.isEmpty){
                            
                            var returnCode = data["ReturnCode"].int
                            var docentry = data["Docentry"].int
                            var returnMessage = data["ReturnMessage"].string
                            
                            returnCode = returnCode == nil ? 3 : returnCode
                            docentry = docentry == nil ? 0 : docentry
                            returnMessage = returnMessage == nil ? "" : returnMessage
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(returnCode!,docentry!,returnMessage!)
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(3,0,"Không thể lưu đơn hàng!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(3,0,"Không thể lưu đơn hàng!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(3,0,"Không thể lưu đơn hàng!")
                }
            case .failure(_):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(3,0,"Không thể lưu đơn hàng!")
            }
        }
    }
    class func mpos_FRT_SP_mirae_history_order_byuser(handler: @escaping (_ success:[HistoryOrderByUser],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[HistoryOrderByUser] = []
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "partnerId": PARTNERID
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_mirae_history_order_byuser(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = HistoryOrderByUser.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_mirae_history_order_byID(IDMPOS:String,handler: @escaping (_ success:[HistoryOrderByID],_ soDetail:[SODetailMirae],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        var rs:[HistoryOrderByID] = []
        var soDetailMirae:[SODetailMirae] = []
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "IDMPOS":"\(IDMPOS)"
        ]
        log.debug(parameters)
        provider.request(.mpos_FRT_SP_mirae_history_order_byID(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
        
                log.debug(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let header = json!["Header"].array {
                            rs = HistoryOrderByID.parseObjfromArray(array: header)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if let detail = json!["Details"].array {
                                soDetailMirae = SODetailMirae.parseObjfromArray(array: detail)
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                
                                handler(rs,soDetailMirae,"")
                            }else{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(rs,soDetailMirae,"Load API ERRO")
                            }
                            
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,soDetailMirae,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,soDetailMirae,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,soDetailMirae,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,soDetailMirae,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_mirae_cance_hopdong(IDMPOS:String,reason:String,note:String,processId_Mirae:String,handler: @escaping (_ success:[HoanTatMirae],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "IDMPOS":IDMPOS,
            "reason":reason,
            "note":note,
            "processId_Mirae":"\(processId_Mirae)"
        ]
        print(parameters)
        var rs:[HoanTatMirae] = []
        provider.request(.mpos_FRT_SP_mirae_cance_hopdong(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = HoanTatMirae.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_mirae_finish_hopdong(IDMPOS:String,Imei:String,handler: @escaping (_ success:[HoanTatMirae],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "IDMPOS":IDMPOS,
            "Imei":Imei
        ]
        var rs:[HoanTatMirae] = []
        print(parameters)
        provider.request(.mpos_FRT_SP_mirae_finish_hopdong(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = HoanTatMirae.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        let Message = json?["Message"].string
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,Message ?? "LOAD API ERROR !")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_Mirae_UpdateImei(processID:String,activityId:String,Imei_old:String,imei_new:String,IDmpos:String,handler: @escaping (_ success:[HoanTatMirae],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            
            "processID":"\(processID)",
            "activityId":"\(activityId)",
            "Imei_old":Imei_old,
            "imei_new":imei_new,
            "IDmpos":IDmpos,
            "UserId":"\(Cache.user!.UserName)"
        ]
        var rs:[HoanTatMirae] = []
        print(parameters)
        provider.request(.mpos_Mirae_UpdateImei(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = HoanTatMirae.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        if let data = json["Data"].array {
                            rs = HoanTatMirae.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            let message = json["Message"].string
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,message!)
                        }
                        //                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        //                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_ReSubmitAplication(IDMPOS:String,P_ProvinceCode:String,P_DistrictCode:String,P_PrecinctCode:String,P_Address:String,CompanyName:String,JobTilte:String,Seniority:String,Salary:String,C_ProvinceCode:String,C_DistrictCode:String,C_PrecinctCode:String,C_Address:String,IDcard_old:String,C_PhoneNumber:String,C_TypeDoc:String,Ref_FullName:String,Ref_relationship:String,Ref_phonenumber:String,processId:String,activityId:String,DeviceID:String,WorkYear:String,dueday:String,FirstImei_day:String,Birthday:String,PhoneNumber:String,idIssuedBy:String,idIssuedDate:String,Ref_phonenumber_2:String,refName_2:String,refRelationship_2:String,P_ProvinceCode_2:String,P_DistrictCode_2:String,P_PrecinctCode_2:String,P_Address_2:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters: [String: String] = [
            
            "IDMPOS": IDMPOS,
            "MaShop":"\(Cache.user!.ShopCode)",
            "UserID":"\(Cache.user!.UserName)",
            "P_ProvinceCode": P_ProvinceCode,
            "P_DistrictCode": P_DistrictCode,
            "P_PrecinctCode": P_PrecinctCode,
            "P_Address": P_Address,
            "CompanyName": CompanyName,
            "JobTilte": JobTilte,
            "Seniority": Seniority,
            "Salary": Salary,
            "C_ProvinceCode": C_ProvinceCode,
            "C_DistrictCode": C_DistrictCode,
            "C_PrecinctCode": C_PrecinctCode,
            "C_Address": C_Address,
            "IDcard_old": IDcard_old,
            "C_PhoneNumber": C_PhoneNumber,
            "C_TypeDoc": C_TypeDoc,
            "Ref_FullName": Ref_FullName,
            "Ref_relationship": Ref_relationship,
            "Ref_phonenumber": Ref_phonenumber,
            "processId": processId,
            "activityId": activityId,
            "DeviceID": DeviceID,
            "WorkYear":"\(WorkYear)",
            "dueday":"\(dueday)",
            "FirstImei_day":"\(FirstImei_day)",
            "Birthday":"\(Birthday)",
            "PhoneNumber":"\(PhoneNumber)",
            "idIssuedBy":"\(idIssuedBy)",
            "idIssuedDate":"\(idIssuedDate)",
            "Ref_phonenumber_2":"\(Ref_phonenumber_2)",
            "Ref_FullName_2":"\(refName_2)",
            "Ref_relationship_2":"\(refRelationship_2)",
            "P_ProvinceCode_2":"\(P_ProvinceCode_2)",
            "P_DistrictCode_2":"\(P_DistrictCode_2)",
            "P_PrecinctCode_2":"\(P_PrecinctCode_2)",
            "P_Address_2":"\(P_Address_2)"
            
        ]
        log.debug(parameters)
        provider.request(.mpos_ReSubmitAplication(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                if let success = json["Success"].bool {
                    if(success){
                        let message = json["Message"].string
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(message!,"")
                        
                    }else{
                        let message = json["Message"].string
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("",message!)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    
    class func BaoLoiNguoiDung__PushConv(p_RequestId:Int,p_Message:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user!.UserName)",
            "p__Token": "\(Cache.user!.Token)",
            "p_RequestId": "\(p_RequestId)",
            "p_UserCode": "\(Cache.user!.UserName)",
            "p_Message": "\(p_Message)"
        ]
        provider.request(.BaoLoiNguoiDung__PushConv(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let data = json["sp__mCallLog__BaoLoiNguoiDung__PushConvResult"].array {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if(data.count > 0){
                        var Msg = data[0]["Msg"].string
                        var Result = data[0]["Result"].int
                        Msg = Msg == nil ? "" : Msg
                        Result = Result == nil ? 0 : Result
                        if(Result! == 1){
                            handler(Msg!,"")
                        }else{
                            handler("",Msg!)
                        }
                    }else{
                        handler("","LOAD API ERROR")
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","LOAD API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    
    class func mpos_ConfirmUploadComplete(activityId:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters: [String: String] = [
            
            "activityId":"\(activityId)"
        ]
        log.debug(parameters)
        provider.request(.mpos_ConfirmUploadComplete(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Message"].string
                        handler(data!,"")
                    }else{
                        let data = json["Message"].string
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("",data!)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_Mirae_DS_sanpham(handler: @escaping (_ success:[SPTuVanMirae],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)"
        ]
        var rs:[SPTuVanMirae] = []
        print(parameters)
        provider.request(.mpos_FRT_SP_Mirae_DS_sanpham(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = SPTuVanMirae.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        let Message = json["Message"].string
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,Message!)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func VTCheckSim(isdn: String, custId:String, handler: @escaping (_ p_status:Int, _ p_messagess:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "isdn": "\(isdn)",
            "custId": "\(custId)",
            "usercode": "\(Cache.user?.UserName ?? "")",
            "shopcode": "\(Cache.user?.ShopCode ?? "")"
        ]
        print(parameters)
        provider.request(.VTCheckSim(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let suc = json["Success"].bool {
                    let Message = json["Message"].string
                    if(suc){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        
                        let mData = json["Data"]
                        let statusCode = mData["p_status"].int
                        let msg = mData["p_messagess"].string
                        
                        handler(statusCode ?? 0,msg ?? "", "")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,Message ?? "Kiểm tra thất bại!", "")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"Load API ERRO", "")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"",error.localizedDescription)
            }
        }
    }
    class func VTSendOTPErp(isdn: String, handler: @escaping (_ success:Bool, _ Message:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "isdn": "\(isdn)",
            "actionType": "11"
        ]
        print(parameters)
        provider.request(.VTSendOTPErp(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let suc = json["Success"].bool {
                    let Message = json["Message"].string
                    
                    handler(suc,Message ?? "Không tìm thấy thông tin thuê bao!", "")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(false,"Load API ERRO", "")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(false,"",error.localizedDescription)
            }
        }
    }
    class func Score_GetListObject(handler: @escaping (_ success:[DoiTuongChamDiem],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserCode": "\(Cache.user?.UserName ?? "")"
        ]
        var rs:[DoiTuongChamDiem] = []
        provider.request(.Score_GetListObject(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = DoiTuongChamDiem.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func Score_GetGroupItem(handler: @escaping (_ success:[NhomHangMuc],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserCode": "\(Cache.user?.UserName ?? "")"
        ]
        var rs:[NhomHangMuc] = []
        provider.request(.Score_GetGroupItem(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = NhomHangMuc.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func Score_GetContentGroupItem(handler: @escaping (_ success:[ContentNhomHangMuc],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserCode": "\(Cache.user?.UserName ?? "")"
        ]
        var rs:[ContentNhomHangMuc] = []
        provider.request(.Score_GetContentGroupItem(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = ContentNhomHangMuc.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func Score_GetListScore(handler: @escaping (_ success:[ScoreError],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[ScoreError] = []
        let parameters: [String: String] = [
            "UserCode" : "\(Cache.user!.UserName)"
        ]
        print(parameters)
        provider.request(.Score_GetListScore(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = ScoreError.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func Score_CreateObject(ObjectName:String, ScoreLevel:Int, Percent:Int, handler: @escaping (_ success:[CreateObjectResponse],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "ObjectName": "\(ObjectName)",
            "ScoreLevel": ScoreLevel,
            "Percent": Percent,
            "UserCode": "\(Cache.user?.UserName ?? "")",
            "Device":2
        ]
        print(parameters)
        var rs:[CreateObjectResponse] = []
        provider.request(.Score_CreateObject(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = CreateObjectResponse.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Tạo đối tượng thất bại!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func Score_CreateGroupItem(GroupName:String, ListObject:String, handler: @escaping (_ success:[CreateObjectResponse],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "GroupName":"\(GroupName)",
            "ListObject": "\(ListObject)",
            "UserCode":"\(Cache.user?.UserName ?? "")",
            "Device":2
        ]
        print(parameters)
        var rs:[CreateObjectResponse] = []
        provider.request(.Score_CreateGroupItem(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = CreateObjectResponse.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Tạo nhóm hạng mục thất bại!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func Score_CreateContentScore(GroupID:Int, ContentName:String, ObjectID:String, ContentBody:String, Base64String:String, handler: @escaping (_ success:[CreateObjectResponse],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "GroupID":GroupID,
            "ContentName":"\(ContentName)",
            "ObjectID":ObjectID,
            "ContentBody": "\(ContentBody)",
            "Base64String":"\(Base64String)",
            "UserCode":"\(Cache.user?.UserName ?? "")",
            "Device":2
        ]
        print(parameters)
        var rs:[CreateObjectResponse] = []
        provider.request(.Score_CreateContentScore(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = CreateObjectResponse.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Tạo hạng mục thất bại!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func Score_SendRequestScoreToSM(HeaderID:Int, handler: @escaping (_ success:Bool, _ message: String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "HeaderID":HeaderID,
            "UserCode":"\(Cache.user?.UserName ?? "")",
            "Device":2
        ]
        print(parameters)
        provider.request(.Score_SendRequestScoreToSM(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let suc = json["Success"].bool {
                    if(suc){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let mdata = json["Data"].array {
                            for item in mdata {
                                let msg = item["Message"].string
                                handler(suc, msg ?? "","")
                            }
                        }else{
                            handler(suc,"","")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(false, "","Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(false, "","Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(false,"",error.localizedDescription)
            }
        }
    }
    class func Score_InActiveOGC(ID:Int, Type:Int, handler: @escaping (_ success:[CreateObjectResponse],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "ID":ID,
            "Type":Type,
            "UserCode":"\(Cache.user?.UserName ?? "")",
            "Device":2
        ]
        print(parameters)
        var rs:[CreateObjectResponse] = []
        provider.request(.Score_InActiveOGC(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = CreateObjectResponse.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func Score_GetImageListContent(GroupID: Int, ObjectID: Int, handler: @escaping (_ success:[ImageContent],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[ImageContent] = []
        let parameters: [String: Any] = [
            "GroupID":GroupID,
            "ObjectID":ObjectID
        ]
        print(parameters)
        provider.request(.Score_GetImageListContent(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = ImageContent.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func Score_UploadImage(Base64String:String, handler: @escaping (_ Result:Int, _ Message: String, _ UrlImage:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "Base64String":Base64String
        ]
        print(parameters)
        provider.request(.Score_UploadImage(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let success = json["Success"].bool {
                    if success {
                        let mdata = json["Data"].dictionary
                        let Result = mdata?["Result"]?.int
                        let Message = mdata?["Message"]?.string
                        let UrlImage = mdata?["UrlImage"]?.string
                        
                        handler(Result ?? 0,Message ?? "",UrlImage ?? "", "")
                    } else {
                        handler(0,"", "", "Load API ERRO")
                    }
                } else {
                    handler(0,"", "", "Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"", "",error.localizedDescription)
            }
        }
    }
    class func Score_CreateRequestScore(ObjectID:Int, ShopCode: String, GroupID:Int, Content: String, handler: @escaping (_ success:[CreateObjectResponse],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "ObjectID":ObjectID,
            "ShopCode":"\(ShopCode)",
            "GroupID":GroupID,
            "Content":"\(Content)",
            "UserCode":"\(Cache.user?.UserName ?? "")",
            "Device":2
        ]
        
        print(parameters)
        var rs:[CreateObjectResponse] = []
        provider.request(.Score_CreateRequestScore(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = CreateObjectResponse.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    //    Score_UpdateRequestScore
    //    "ContentBody":"<line><item U_DetailID=\"1\" U_UrlImage=\"1- Image\"  /><item U_DetailID=\"2\" U_UrlImage=\"2 - Image\" /></line>",
    class func Score_UpdateRequestScore(HeaderID:Int, ContentBody: String, handler: @escaping (_ success:[CreateObjectResponse],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "HeaderID":HeaderID,
            "ContentBody":"\(ContentBody)",
            "UserCode":"\(Cache.user?.UserName ?? "")",
            "Device":2
        ]
        var rs:[CreateObjectResponse] = []
        print(parameters)
        provider.request(.Score_UpdateRequestScore(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = CreateObjectResponse.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func sp_FRT_Web_BrowserPaymentRequest_GetBank(handler: @escaping (_ success:[RequestPaymentBank],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[RequestPaymentBank] = []
        provider.request(.sp_FRT_Web_BrowserPaymentRequest_GetBank){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let suc = json["Success"].bool {
                    if(suc){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = RequestPaymentBank.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func Score_UpdateObject(ObjectName:String, ScoreLevel:Int, Percent:Int, ObjectId:Int, handler: @escaping (_ success:[CreateObjectResponse],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "ObjectName": "\(ObjectName)",
            "ScoreLevel": ScoreLevel,
            "Percent": Percent,
            "UserCode": "\(Cache.user?.UserName ?? "")",
            "Device":2,
            "Id": ObjectId
        ]
        var rs:[CreateObjectResponse] = []
        print(parameters)
        provider.request(.Score_UpdateObject(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = CreateObjectResponse.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Update đối tượng thất bại!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func Score_UpdateGroupItem(GroupName:String, ListObject:String, GroupId: Int, handler: @escaping (_ success:[CreateObjectResponse],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "GroupName":"\(GroupName)",
            "ListObject": "\(ListObject)",
            "UserCode":"\(Cache.user?.UserName ?? "")",
            "Device":2,
            "Id":GroupId
        ]
        print(parameters)
        var rs:[CreateObjectResponse] = []
        provider.request(.Score_UpdateGroupItem(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = CreateObjectResponse.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Update nhóm hạng mục thất bại!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func Score_UpdateContentScore(GroupID:Int, ContentName:String, ObjectID:String, ContentBody:String, Base64String:String, ContentID:Int, handler: @escaping (_ success:[CreateObjectResponse],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "GroupID":GroupID,
            "ContentName":"\(ContentName)",
            "ObjectID":ObjectID,
            "ContentBody": "\(ContentBody)",
            "Base64String":"\(Base64String)",
            "UserCode":"\(Cache.user?.UserName ?? "")",
            "Device":2,
            "Id":ContentID
        ]
        print(parameters)
        var rs:[CreateObjectResponse] = []
        provider.request(.Score_UpdateContentScore(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = CreateObjectResponse.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Tạo hạng mục thất bại!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func FRT_SP_GetSMS_loyaty(SDT:String,handler: @escaping (_ success:Int,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "SDT":SDT,
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)"
        ]
        debugPrint(parameters)
        provider.request(.FRT_SP_GetSMS_loyaty(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let data = json["FRT_SP_GetSMS_loyatyResult"].array {
                    if(data.count > 0){
                        let dataJSON = data[0]
                        let p_status = dataJSON["p_status"].intValue
                        let p_messagess = dataJSON["p_messagess"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(p_status, p_messagess)
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0, "Load API Error!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,error.localizedDescription)
            }
        }
    }
    
    //back tp school
    //    BackToSchool_CheckSBD
    class func BackToSchool_CheckSBD(SoBaoDanh:String, handler: @escaping (_ success: String,_ mError:String, _ mdata:StudentBTSInfo?, _ err: String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "SoBaoDanh": SoBaoDanh,
            "User": "\(Cache.user?.UserName ?? "")"
        ]
        print(parameters)
        provider.request(.BackToSchool_CheckSBD(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let suc = json["Success"].string
                let err = json["Error"].string
                let mdata = json["Data"]
                if (!mdata.isEmpty){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let rs = StudentBTSInfo.getObjFromDictionary(data: mdata)
                    handler(suc ?? "0", err ?? "", rs, "")
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(suc ?? "0", err ?? "Số báo danh không tồn tại", nil, "Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("0", "", nil,error.localizedDescription)
            }
        }
    }
    //    BackToSchool_UploadImage
    class func BackToSchool_UploadImage(base64:String, cmnd: String, type: String, handler: @escaping (_ success: String,_ mError:String, _ mdata:String, _ err: String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "base64": base64,
            "CMND": cmnd,
            "Type": type
        ]
        print(parameters)
        provider.request(.BackToSchool_UploadImage(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    debugPrint(json)
                    let suc = json["Success"].string
                    let err = json["Error"].string
                    let mdata = json["Data"].string
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(suc ?? "0", err ?? "", mdata ?? "", "")
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("0", "", "",error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("0", "", "",error.localizedDescription)
            }
        }
    }
    //    BackToSchool_UpdateThongTinKhachHang
    class func BackToSchool_UpdateThongTinKhachHang(ID_BackToSchool:Int, SBD: String, HoTen: String, CMND: String, SDT: String, NgaySinh: Int, birthDay: String = "", shipType: String = "", handler: @escaping (_ success: String,_ mError:String, _ mdata:String, _ err: String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "ID_BackToSchool": ID_BackToSchool,
            "SBD":SBD,
            "HoTen":HoTen,
            "CMND":CMND,
            "SDT":SDT,
            "NgaySinh":NgaySinh,
            "User": "\(Cache.user?.UserName ?? "")",
            "Birthday": birthDay,
            "ShipType": shipType
            
        ]
        print(parameters)
        provider.request(.BackToSchool_UpdateThongTinKhachHang(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let suc = json["Success"].string
                let err = json["Error"].string
                let mdata = json["Data"].string
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(suc ?? "0", err ?? "", mdata ?? "", "")
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("0", "", "",error.localizedDescription)
            }
        }
    }
    //    BackToSchool_UpdateHinhAnh
    class func BackToSchool_UpdateHinhAnh(ID_BackToSchool:Int, SBD: String, Url_CMND_MT: String, Url_CMND_MS: String, Url_GiayBaoDuThi: String, handler: @escaping (_ success: String,_ mError:String, _ mdata:String, _ err: String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "ID_BackToSchool": ID_BackToSchool,
            "SBD":SBD,
            "Url_CMND_MT":Url_CMND_MT,
            "Url_CMND_MS":Url_CMND_MS,
            "Url_GiayBaoDuThi":Url_GiayBaoDuThi,
            "User": "\(Cache.user?.UserName ?? "")"
        ]
        print(parameters)
        provider.request(.BackToSchool_UpdateHinhAnh(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let suc = json["Success"].string
                let err = json["Error"].string
                let mdata = json["Data"].string
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(suc ?? "0", err ?? "", mdata ?? "", "")
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("0", "", "",error.localizedDescription)
            }
        }
    }
    //    BackToSchool_LoadThongTinKHBySBD
    class func BackToSchool_LoadThongTinKHBySBD(SoBaoDanh:Int, handler: @escaping (_ success: String,_ mError:String, _ mdata:StudentBTSInfo?, _ err: String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "Id_BackToSchool": SoBaoDanh
        ]
        print(parameters)
        provider.request(.BackToSchool_LoadThongTinKHBySBD(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let suc = json["Success"].string
                let err = json["Error"].string
                let mdata = json["Data"]
                if (!mdata.isEmpty){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let rs = StudentBTSInfo.getObjFromDictionary(data: mdata)
                    handler(suc ?? "0", err ?? "", rs, "")
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(suc ?? "0", err ?? "Có lỗi xảy ra trong quá trình lấy thông tin số báo danh!", nil, "Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("0", "", nil,error.localizedDescription)
            }
        }
    }
    
    //bts check ghtn is uploaded Image
    class func checkImageUploaded(idcard: String,voudcher: String, phone: String,sopos: Int, completion: @escaping(CheckBTSUploadItem?, String) -> Void) {
        var params = [String: Any]()
        params["IdCard"] = idcard
        params["Voucher"] = voudcher
        params["phoneNumber"] = phone
        params["SOPOS"] = sopos
        
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.checkBtsUploaded(params: params)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data

                do {
                    let json = try JSON(data: data)
                    let rs = CheckBTSUploadItem.getObjFromDictionary(data: json)
                    completion(rs,"")
                } catch let error{
                    completion(nil,error.localizedDescription)
                }
                
            case let .failure(error):
                completion(nil,error.localizedDescription)
            }
        }
        
    }
    
    //update image mdeli
    class func updateImageMdeli(ID_BackToSchool: Int,Url_CMND_MT: String, Url_CMND_MS: String,Url_GiayBaoDuThi: String,CMND: String,Birthday: String, completion: @escaping(UpdateMdeliItem?, String) -> Void) {
        var params = [String: Any]()
        params["ID_BackToSchool"] = ID_BackToSchool
        params["Url_CMND_MT"] = Url_CMND_MT
        params["Url_CMND_MS"] = Url_CMND_MS
        params["Url_GiayBaoDuThi"] = Url_GiayBaoDuThi
        params["User"] = Cache.user!.UserName
        params["CMND"] = CMND
        params["Birthday"] = Birthday
        
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.updateBTSMdeli(params: params)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    let rs = UpdateMdeliItem.getObjFromDictionary(data: json)
                    completion(rs,"")
                } catch let error{
                    completion(nil,error.localizedDescription)
                }
                
            case let .failure(error):
                completion(nil,error.localizedDescription)
            }
        }
        
    }
    
    // Back To School Insert Data Student FPT
    
    class func backToSchool_InsertDataStudentFPT(name: String, identity: String, phoneNumber: String, user: String, type: Int, birthday: String = "", shipType: String = "", completionHandle: @escaping (_ success: Bool?, _ mErr: String?, _ mData: InsertDataBackToSchoolStudentFPTItem.Data?, _ err: String?) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "HoTen": name,
            "CMND": identity,
            "SDT": phoneNumber,
            "User": user,
            "Type": type,
            "Birthday": birthday,
            "ShipType": shipType
        ]
        print(parameters)
        provider.request(.backToSchool_InsertData_SinhVienFPT(params: parameters)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let jsonData = response.data
                    let itemsResponse = try JSONDecoder().decode(InsertDataBackToSchoolStudentFPTItem.self, from: jsonData)
                    printLog(function: #function, json: itemsResponse)
                    if let success = itemsResponse.success {
                        if success {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if let data = itemsResponse.data {
                                completionHandle(success, nil, data, nil)
                            }
                        } else {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if let message = itemsResponse.message {
                                completionHandle(success, nil, nil, message)
                            }
                        }
                    }
                } catch let err {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    completionHandle(nil, nil, nil, err.localizedDescription)
                }
            case let .failure(err):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                completionHandle(false, nil, nil, err.localizedDescription)
            }
        }
    }
    
    class func backToSchool_TimKiemStudent(keySearch: String, completionHandle: @escaping (_ success: Bool?, _ data: [ListStudentInfoSearchItem.Data]?, _ msg: String? ) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "Keysearch": keySearch
        ]
        printLog(function: #function, json: parameters)
        provider.request(.backToSchool_TimKiem_ByKey(params: parameters)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let jsonData = response.data
                    let itemsResponse = try JSONDecoder().decode(ListStudentInfoSearchItem.self, from: jsonData)
                    printLog(function: #function, json: itemsResponse)
                    if let success = itemsResponse.success {
                        if success {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if let data = itemsResponse.data {
                                completionHandle(success, data, nil)
                            }
                        } else {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if let message = itemsResponse.message {
                                completionHandle(success, nil, message)
                            }
                        }
                    }
                } catch let err {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    completionHandle(nil, nil, err.localizedDescription)
                }
            case let .failure(errMoya):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                completionHandle(false, nil, errMoya.localizedDescription)
            }
        }
    }
    
    class func backToSchool_TimKiemStudentByUser(user: String, completionHandler: @escaping (_ success: Bool?, _ data: [ListStudentInfoSearchItem.Data]?, _ msg: String?) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "User": user
        ]
        printLog(function: #function, json: parameters)
        provider.request(.backToSchool_TimKiem_ByUser(params: parameters)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let jsonData = response.data
                    let itemsResponse = try JSONDecoder().decode(ListStudentInfoSearchItem.self, from: jsonData)
                    printLog(function: #function, json: itemsResponse)
                    if let success = itemsResponse.success {
                        if success {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if let data = itemsResponse.data {
                                completionHandler(success, data, nil)
                            }
                        } else {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if let message = itemsResponse.message {
                                completionHandler(success, nil, message)
                            }
                        }
                    }
                } catch let err {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    completionHandler(nil, nil, err.localizedDescription)
                }
            case let .failure(errMoya):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                completionHandler(false, nil, errMoya.localizedDescription)
            }
        }
    }
    
    class func backToSchool_cancelVoucherByUser(params: [String:Any], completionHandler: @escaping(_ success: Bool?, _ data: CancelVoucherItem.Data?, _ msg: String?) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = params
        printLog(function: #function, json: parameters)
        provider.request(.backToSchool_HuyVoucher(params: parameters)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let jsonData = response.data
                    let itemsResponse = try JSONDecoder().decode(CancelVoucherItem.self, from: jsonData)
                    printLog(function: #function, json: itemsResponse)
                    if let success = itemsResponse.success {
                        if success {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if let data = itemsResponse.data {
                                completionHandler(success, data, nil)
                            }
                        } else {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if let message = itemsResponse.message {
                                completionHandler(success, nil, message)
                            }
                        }
                    }
                } catch let err {
                    completionHandler(false, nil, err.localizedDescription)
                }
            case let .failure(errMoya):
                completionHandler(false, nil, errMoya.localizedDescription)
            }
        }
    }
    
    class func backToSchool_LoadHistoryKHBySBD(params: [String:Any], completionHandler: @escaping(_ success: String, _ data: DetailInfoStudentFPTItem.Data?, _ msg: String?) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = params
        provider.request(.backToSchool_LoadHistoryKHBySBD(params: parameters)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let jsonData = response.data
                    let itemsResponse = try JSONDecoder().decode(DetailInfoStudentFPTItem.self, from: jsonData)
                    if let success = itemsResponse.success {
                        if success == "1" {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if let data = itemsResponse.data {
                                completionHandler(success, data, nil)
                            }
                        } else {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if let message = itemsResponse.error {
                                completionHandler("0", nil, message)
                            }
                        }
                    }
                } catch let err {
                    completionHandler("0", nil, err.localizedDescription)
                }
            case let .failure(errMoya):
                completionHandler("0", nil, errMoya.localizedDescription)
            }
        }
    }
    
    //Sendo
    //    FRT_SP_linksendo
    class func FRT_SP_linksendo(handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserId":"\(Cache.user?.UserName ?? "")",
            "MaShop":"\(Cache.user?.ShopCode ?? "")"
        ]
        print(parameters)
        provider.request(.FRT_SP_linksendo(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            if data.count > 0 {
                                let item = data[0]
                                let rs = item["p_noidung"].string ?? ""
                                handler(rs,"")
                            } else {
                                handler("","Load API ERRO")
                            }
                            
                        }else{
                            handler("","Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("","Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    
    class func mpos_FRT_SP_mirae_loadreasoncance(handler: @escaping (_ success:[ReasonCancelMirae],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[ReasonCancelMirae] = []
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_mirae_loadreasoncance(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = ReasonCancelMirae.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func PaymentOfFunds_GetList(handler: @escaping (_ success:[DetailsCallLogNopQuyItem],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserCode":"\(Cache.user?.UserName ?? "")"
        ]
        print(parameters)
        var rs:[DetailsCallLogNopQuyItem] = []
        provider.request(.PaymentOfFunds_GetList(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = DetailsCallLogNopQuyItem.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Không có data!")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func sp_mpos_FRT_SP_innovation_checkgiamgiatay(whscode:String, itemcode:String, p_price:String, p_discount:String, imei:String, reasoncode:String,Note:String,is_DH_DuAn:String, handler: @escaping (_ success:[UnconfirmationReasons],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "userID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "whscode":whscode,
            "itemcode":itemcode,
            "p_price":p_price,
            "p_discount":p_discount,
            "imei":imei,
            "reasoncode":reasoncode,
            "Note":Note,
            "is_DH_DuAn":is_DH_DuAn
        ]
        print(parameters)
        var rs:[UnconfirmationReasons] = []
        provider.request(.sp_mpos_FRT_SP_innovation_checkgiamgiatay(params: parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            
                            rs = UnconfirmationReasons.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Không có data!")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func sp_FRTCallLog_Web_BrowserPaymentRequest_GetWarehouseByType(Type:Int,handler: @escaping (_ success:[RequestPaymentShop],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[RequestPaymentShop] = []
        let parameters: [String: String] = [
            "Type": "\(Type)"
        ]
        provider.request(.sp_FRTCallLog_Web_BrowserPaymentRequest_GetWarehouseByType(params: parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let suc = json["Success"].bool {
                    if(suc){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = RequestPaymentShop.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func PaymentOfFunds_CallLogNopQuy(handler: @escaping (_ success:[PaymentOfFunds_New],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserCode":"\(Cache.user?.UserName ?? "")"
        ]
        print(parameters)
        var rs:[PaymentOfFunds_New] = []
        provider.request(.PaymentOfFunds_CallLogNopQuy(params: parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            
                            rs = PaymentOfFunds_New.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func sp_mpos_FRT_SP_innovation_check_IQcode(SDT:String,p_IDQrCode:String, type: String, handler: @escaping (_ success:[IQcode],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "SDT":SDT,
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "p_IDQrCode": p_IDQrCode,
            "type":"\(type)"
        ]
        debugPrint(parameters)
        var rs:[IQcode] = []
        provider.request(.sp_mpos_FRT_SP_innovation_check_IQcode(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            
                            rs = IQcode.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func sp_FRT_Web_BrowserPaymentRequest_GetTinhThanh(handler: @escaping (_ success:[RequestPaymentProvince],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[RequestPaymentProvince] = []
        provider.request(.sp_FRT_Web_BrowserPaymentRequest_GetTinhThanh){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let suc = json["Success"].bool {
                    if(suc){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = RequestPaymentProvince.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func sp_FRT_Web_BrowserPaymentRequest_GetQuanHuyen(IDCity:Int,handler: @escaping (_ success:[RequestPaymentDistrict],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[RequestPaymentDistrict] = []
        let parameters: [String: String] = [
            "IDCity": "\(IDCity)"
        ]
        provider.request(.sp_FRT_Web_BrowserPaymentRequest_GetQuanHuyen(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let suc = json["Success"].bool {
                    if(suc){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = RequestPaymentDistrict.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func PaymentOfFunds_Update(DocEntry: Int, UrlImageSefie: String, UrlImageReceipt: String, Note: String ,handler: @escaping (_ success:[CreateObjectResponse],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "DocEntry":DocEntry,
            "UrlImageSefie":"\(UrlImageSefie)",
            "UrlImageReceipt":"\(UrlImageReceipt)",
            "Note":"\(Note)",
            "UserCode":"\(Cache.user?.UserName ?? "")",
            "Device":2,
            "Version":"\(Common.versionApp())"
        ]
        print(parameters)
        var rs:[CreateObjectResponse] = []
        provider.request(.PaymentOfFunds_Update(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = CreateObjectResponse.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Không có data!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func sp_FRT_Web_BrowserPaymentRequest_GetLoaiKyHD(handler: @escaping (_ success:[RequestPaymentContractType],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[RequestPaymentContractType] = []
        provider.request(.sp_FRT_Web_BrowserPaymentRequest_GetLoaiKyHD){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let suc = json["Success"].bool {
                    if(suc){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = RequestPaymentContractType.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func sp_FRT_Web_BrowserPaymentRequest_GetDonVi(handler: @escaping (_ success:[RequestPaymentUnit],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[RequestPaymentUnit] = []
        provider.request(.sp_FRT_Web_BrowserPaymentRequest_GetDonVi){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let suc = json["Success"].bool {
                    if(suc){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = RequestPaymentUnit.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func sp_FRT_Web_BrowserPaymentRequest_GetKyHan(handler: @escaping (_ success:[RequestPaymentPeriod],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[RequestPaymentPeriod] = []
        provider.request(.sp_FRT_Web_BrowserPaymentRequest_GetKyHan){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let suc = json["Success"].bool {
                    if(suc){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = RequestPaymentPeriod.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func PaymentOfFunds_UploadImage(Base64String: String, handler: @escaping (_ Result: Int, _ Message: String, _ UrlImage: String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "Base64String":"\(Base64String)"
        ]
        print(parameters)
        provider.request(.PaymentOfFunds_UploadImage(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let mData = json!["Data"]
                        if(!data.isEmpty){
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            let Result = mData["Result"].int
                            let Message = mData["Message"].string
                            let UrlImage = mData["UrlImage"].string
                            
                            handler(Result ?? 0, Message ?? "Lỗi up hình ảnh!!!", UrlImage ?? "","")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(0, "", "", "Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0, "", "", "Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0, "", "", "Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0, "", "",error.localizedDescription)
            }
        }
    }
    
    class func Uploads_FileAttachs(FileName:String,Base64String:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserCode" : "\(Cache.user!.UserName)",
            "FileName":"\(FileName)",
            "Base64String":"\(Base64String)"
        ]
        provider.request(.Uploads_FileAttachs(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    
                    var Result = json["Result"].int
                    var Msg = json["Msg"].string
                    var FilePath = json["FilePath"].string
                    Result = Result == nil ? 0 : Result
                    Msg = Msg == nil ? "" : Msg
                    FilePath = FilePath == nil ? "" : FilePath
                    if(Result! != 0){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(FilePath!,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("",Msg!)
                    }
                } catch {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Upload hình lỗi!")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
                
            }
        }
    }
    class func sp_FRTCallLog_Web_CreateRequestPaymentHomeFromMobile(TenChuNha:String,MaSoThueCN:String,SDT:String,ChuTaiKhoan:String,STK:String,NganHang:String,LoaiShop:String,MaShop:String,TenShop:String,DiaChiShop:String,QuanHuyen:String,TinhTP:String,ViTriThucTe:String,LoaiKyHD:String,SoHD:String,NgayNhanMB:String,NgayTTTNha:String,NgayKTHD:String,ThoiHanThue:String,TienDatCoc:String,DonVi:String,HTRutCoc:String,KyHanTT:String,NgayBDTT:String,NgayThanhToan:String,DienTich:String,Thue:String,SoTienChiuThue:String,UrlImageHD:String,UrlImageMatTien:String,XMLGTThang: String,NgayBDHD:String, MaPhongBan: String, TenPhongBan: String, CNNganHang: String, handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "TenChuNha":TenChuNha,
            "MaSoThueCN": MaSoThueCN,
            "SDT":SDT,
            "ChuTaiKhoan":ChuTaiKhoan,
            "STK":STK,
            "NganHang":NganHang,
            "LoaiShop":LoaiShop,
            "MaShop":MaShop,
            "TenShop":TenShop,
            "DiaChiShop":DiaChiShop,
            "QuanHuyen":QuanHuyen,
            "TinhTP":TinhTP,
            "ViTriThucTe":ViTriThucTe,
            "LoaiKyHD":LoaiKyHD,
            "SoHD":SoHD,
            "NgayNhanMB":NgayNhanMB,
            "NgayTTTNha":NgayTTTNha,
            "NgayKTHD":NgayKTHD,
            "ThoiHanThue":ThoiHanThue,
            "TienDatCoc":TienDatCoc,
            "DonVi":DonVi,
            "HTRutCoc":HTRutCoc,
            "KyHanTT":KyHanTT,
            "NgayBDTT":NgayBDTT,
            "NgayThanhToan":NgayThanhToan,
            "DienTich":DienTich,
            "Thue":Thue,
            "SoTienChiuThue":SoTienChiuThue,
            "CreateBy":"\(Cache.user!.UserName)",
            "UrlImageHD":UrlImageHD,
            "UrlImageMatTien":UrlImageMatTien,
            "XMLGTThang":XMLGTThang,
            "Device":"2",
            "NgayBDHD":NgayBDHD,
            "MaPhongBan": MaPhongBan,
            "TenPhongBan": TenPhongBan,
            "CNNganHang": CNNganHang
        ]
        
        debugPrint(parameters)
        provider.request(.sp_FRTCallLog_Web_CreateRequestPaymentHomeFromMobile(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let suc = json["Success"].bool {
                    if(suc){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            if(data.count > 0){
                                let dataJSON = data[0]
                                let result = dataJSON["Result"].intValue
                                let message = dataJSON["Message"].stringValue
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                if(result == 0){
                                    handler("", message)
                                }else{
                                    handler(message, "")
                                }
                            }else{
                                handler("","Load API ERRO")
                            }
                        }else{
                            handler("","Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("","Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func sp_FRT_Web_BrowserPaymentRequest_GetHistory(Date:String,handler: @escaping (_ success:[RequestPaymentHistory],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[RequestPaymentHistory] = []
        let parameters: [String: String] = [
            "Date":Date
        ]
        provider.request(.sp_FRT_Web_BrowserPaymentRequest_GetHistory(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let suc = json["Success"].bool {
                    if(suc){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = RequestPaymentHistory.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_RequestPaymentHome_UploadImage(Base64String:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "Base64String":"\(Base64String)"
        ]
        provider.request(.mpos_FRT_RequestPaymentHome_UploadImage(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    
                    let data = json["Data"]
                    var Result = data["Result"].int
                    var Message = data["Message"].string
                    var UrlImage = data["UrlImage"].string
                    Result = Result == nil ? 0 : Result
                    Message = Message == nil ? "" : Message
                    UrlImage = UrlImage == nil ? "" : UrlImage
                    if(Result! != 0){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(UrlImage!,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("",Message!)
                    }
                } catch {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Upload hình lỗi!")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    //nhan dang cmnd
    
    class func GenerateBirthdayOnMarchVoucher(idCard: String, phone: String, name: String, birthday: String, base64: String, handler: @escaping (_ success: Bool, _ message: String) -> Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "idCard": idCard,
            "phoneNumber": phone,
            "fullname": name,
            "birthday": birthday,
            "base64Front": base64,
            "userCode": "\(Cache.user!.UserName)",
            "shopCode": "\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        
        provider.request(.GenerateBirthdayOnMarchVoucher(params: parameters)) { result in
            switch result {
            case let .success(moyaResponse):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["success"].boolValue
                let message = json["message"].stringValue
                
                handler(success, message)
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(false, error.localizedDescription)
            }
        }
    }
    
    class func GetinfoCustomerByImageIDCard(Image_CMND:String,NhaMang:String,Type:String,handler: @escaping (_ success:[InfoCustomerByImageIDCard],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "Image_CMND":"\(Image_CMND)",
            "NhaMang":"\(NhaMang)",
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "Type":"\(Type)"

        ]
        var rs:[InfoCustomerByImageIDCard] = []
        print(parameters)
        provider.request(.GetinfoCustomerByImageIDCard(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = InfoCustomerByImageIDCard.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
                
            }
        }
    }
    
    class func GetinfoCustomerByImageIDCardSau(Image_CMND:String,NhaMang:String,Type:String,handler: @escaping (_ success:[InfoCustomerByImageIDCardSau],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "Image_CMND":"\(Image_CMND)",
            "NhaMang":"\(NhaMang)",
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "Type":"\(Type)"
            
        ]
        var rs:[InfoCustomerByImageIDCardSau] = []
        print(parameters)
        provider.request(.GetinfoCustomerByImageIDCard(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = InfoCustomerByImageIDCardSau.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
                
            }
        }
    }
    //ViettelPay
    class func getFeeEx(order_id:String,service_code:String,receiver_name:String,receiver_msisdn:String,receiver_id_number:String,receiver_province:String,receiver_district:String,receiver_precinct:String,receiver_address:String,amount:String,transfer_type:String,transfer_form:String,handler: @escaping (_ feeEx:FeeEx,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "order_id": order_id,
            "service_code": service_code,
            "receiver_name": receiver_name,
            "receiver_msisdn": receiver_msisdn,
            "receiver_id_number": receiver_id_number,
            "receiver_province": receiver_province,
            "receiver_district": receiver_district,
            "receiver_precinct": receiver_precinct,
            "receiver_address": receiver_address,
            "amount": amount,
            "transfer_type": transfer_type,
            "transfer_form": transfer_form,
            "shop_name": "\(Cache.user!.ShopCode)",
            "shop_address": "\(Cache.user!.Address)",
            "user_code": "\(Cache.user!.UserName)"
        ]
        print(parameters)
        var feeEX:FeeEx?
        provider.request(.getFeeEx(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                feeEX = FeeEx.getObjFromDictionary(data: json)
                let receiver = json["receiver"]
                
                feeEX!.name = receiver["name"].stringValue
                feeEX!.msisdn = receiver["msisdn"].stringValue
                feeEX!.id_number = receiver["id_number"].stringValue
                
                let address = json["address"]
                
                feeEX!.province_code = address["province_code"].stringValue
                feeEX!.district_code = address["district_code"].stringValue
                feeEX!.precinct_code = address["precinct_code"].stringValue
                feeEX!.address_detail = address["address_detail"].stringValue
                let channel_info = json["channel_info"]
                feeEX!.channel_type = channel_info["channel_type"].stringValue
                feeEX!.source = channel_info["source"].stringValue
                feeEX!.other_info = channel_info["other_info"].stringValue
                feeEX!.shop_name = channel_info["shop_name"].stringValue
                feeEX!.shop_address = channel_info["shop_address"].stringValue
                feeEX!.staff_id = channel_info["staff_id"].stringValue
                
                
                if(feeEX!.error_code == "00"){
                    handler(feeEX!,"")
                }else{
                    // feeEX = nil
                    handler(feeEX!,"\(feeEX!.error_msg)")
                }
                
                
                
            case let .failure(error):
                feeEX = nil
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(feeEX!,error.localizedDescription)
            }
        }
    }
    class func getMakeTransferHeaders(handler: @escaping (_ success:[TransferHeaders],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[TransferHeaders] = []
        let parameters: [String: String] = [
            
            "usercode": "\(Cache.user!.UserName)",
            "shopcode": "\(Cache.user!.ShopCode)"
            
        ]
        print(parameters)
        provider.request(.getMakeTransferHeaders(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = TransferHeaders.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func makeTransfer(order_id:String,service_code:String,receiver_name:String,receiver_msisdn:String,receiver_id_number:String,receiver_province:String,receiver_district:String,receiver_precinct:String,receiver_address:String,amount:String,transfer_type:String,transfer_form:String,sender_name:String,sender_msisdn:String,sender_id_number:String,expected_province:String,expected_district:String,expected_precinct:String,expected_address:String,image_cmtmt:String,image_cmtms:String,image_pct:String,cust_fee:String,handler: @escaping (_ results:TransferViettelPay,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "service_code": "TRANSFER",
            "sender_name": sender_name,
            "sender_msisdn": sender_msisdn,
            "sender_id_number": sender_id_number,
            "receiver_name": receiver_name,
            "receiver_msisdn": receiver_msisdn,
            "receiver_id_number": receiver_id_number,
            "receiver_province": receiver_province,
            "receiver_district": receiver_district,
            "receiver_precinct": receiver_precinct,
            "receiver_address": receiver_address,
            "expected_province": expected_province,
            "expected_district": expected_district,
            "expected_precinct": expected_precinct,
            "expected_address": expected_address,
            "amount": amount,
            "transfer_type": transfer_type,
            "transfer_form": transfer_form,
            "shop_name": "\(Cache.user!.ShopCode)",
            "shop_address": "\(Cache.user!.Address)",
            "user_code": "\(Cache.user!.UserName)",
            //            "image_cmtmt": "\(image_cmtmt)",
            //            "image_cmtms": "\(image_cmtmt)",
            "image_pct": "\(image_pct)",
            "device_type": "2",
            "version": "\(Common.versionApp())",
            "cust_fee":"\(cust_fee)"
        ]
        print(parameters)
        var trans:TransferViettelPay?
        provider.request(.makeTransfer(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                trans = TransferViettelPay.getObjFromDictionary(data: json)
                
                
                
                if(trans!.error_code == "00"){
                    let receiver = json["receiver"]
                    trans?.nameReceiver = receiver["name"].stringValue
                    trans?.phoneReceiver = receiver["msisdn"].stringValue
                    trans?.id_numberReceiver = receiver["id_number"].stringValue
                    let sender = json["sender"]
                    trans?.nameSender = sender["name"].stringValue
                    trans?.phoneSender = sender["msisdn"].stringValue
                    trans?.id_numberSender = sender["id_number"].stringValue
                    handler(trans!,"")
                }else{
                    handler(trans!,"\(trans!.error_msg)")
                }
            case let .failure(error):
                trans = nil
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(trans!,error.localizedDescription)
            }
        }
    }
    class func GetMakeTransferDetails(docentry:String,handler: @escaping (_ success:TransferDetails?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:TransferDetails?
        let parameters: [String: String] = [
            
            "docentry": "\(docentry)",
            "usercode": "\(Cache.user!.UserName)"
            
        ]
        print(parameters)
        provider.request(.GetMakeTransferDetails(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        let detail = json["Data"]
                        rs = TransferDetails.getObjFromDictionary(data: detail)
                        handler(rs!,"")
                    }else{
                        
                        let message = json["Message"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,message)
                    }
                }else{
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                rs = nil
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs!,error.localizedDescription)
            }
        }
    }
    class func partnerCancel(original_trans_id:String,original_order_id:String,handler: @escaping (_ success:PartnerCancel?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            
            "original_trans_id": original_trans_id,
            "original_order_id": original_order_id,
            "service_code": "TRANSFER",
            "shop_name": "\(Cache.user!.ShopCode)",
            "shop_address": "\(Cache.user!.Address)",
            "user_code": "\(Cache.user!.UserName)",
            "device_type": "2"
            
        ]
        var trans:PartnerCancel?
        print(parameters)
        provider.request(.partnerCancel(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                
                trans = PartnerCancel.getObjFromDictionary(data: json)
                if(trans!.error_code == "00"){
                    handler(trans!,"")
                }else{
                    handler(nil,"\(trans!.error_msg)")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func editTransfer(original_order_id:String,original_trans_id:String,service_code:String,transfer_type:String,sender_name:String,sender_msisdn:String,sender_id_number:String,receiver_name:String,receiver_msisdn:String,receiver_id_number:String,receiver_province:String,receiver_district:String,receiver_precinct:String,receiver_address:String,image_pct:String,handler: @escaping (_ results:TransferViettelPay,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "original_order_id": "\(original_order_id)",
            "original_trans_id": "\(original_trans_id)",
            "service_code": "\(service_code)",
            "transfer_type": "\(transfer_type)",
            "sender_name": "\(sender_name)",
            "sender_msisdn": sender_msisdn,
            "sender_id_number": sender_id_number,
            "receiver_name": receiver_name,
            "receiver_msisdn": receiver_msisdn,
            "receiver_id_number": receiver_id_number,
            "receiver_province": receiver_province,
            "receiver_district": receiver_district,
            "receiver_precinct": receiver_precinct,
            "receiver_address": receiver_address,
            "shop_name": "\(Cache.user!.ShopCode)",
            "shop_address": "\(Cache.user!.Address)",
            "user_code": "\(Cache.user!.UserName)",
            "device_type": "1",
            "image_pct":"\(image_pct)"
            
        ]
        print(parameters)
        var trans:TransferViettelPay?
        provider.request(.editTransfer(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                trans = TransferViettelPay.getObjFromDictionary(data: json)
                if(trans!.error_code == "00"){
                    handler(trans!,"")
                }else{
                    handler(trans!,"\(trans!.error_msg)")
                }
            case let .failure(error):
                trans = nil
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(trans!,error.localizedDescription)
            }
        }
    }
    class func initTransfer(trans_date:String,receiver_msisdn:String,receiver_id_number:String,receipt_code:String,amount:String,image_cmtmt:String,image_cmtms:String,receiver_address:String,image_pnt:String,init_type:String,handler: @escaping (_ results:InitTransferEx,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "service_code": "TRANSFER",
            "trans_date": trans_date,
            "receiver_msisdn": receiver_msisdn,
            "receiver_id_number": receiver_id_number,
            "receipt_code": receipt_code,
            "amount": amount,
            "init_type": init_type,
            //            "image_cmtmt": image_cmtmt,
            //            "image_cmtms": image_cmtms,
            "device_type": "2",
            "version": "\(Common.versionApp())",
            "shop_name": "\(Cache.user!.ShopCode)",
            "shop_address": "\(Cache.user!.Address)",
            "user_code": "\(Cache.user!.UserName)",
            "receiver_address":"\(receiver_address)",
            "image_pnt":"\(image_pnt)"
        ]
        print(parameters)
        var trans:InitTransferEx?
        provider.request(.initTransfer(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                trans = InitTransferEx.getObjFromDictionary(data: json)
                if(trans!.error_code == "00"){
                    handler(trans!,"")
                }else{
                    handler(trans!,"\(trans!.error_msg)")
                }
            case let .failure(error):
                trans = nil
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(trans!,error.localizedDescription)
            }
        }
    }
    class func otpCashInVTPayEx(order_id:String,trans_date:String,service_code:String,ben_bank_code:String,sender_name:String,sender_msisdn:String,receiver_msisdn:String,amount:String,handler: @escaping (_ results:OtpCashInVTPayEx,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "order_id": order_id,
            "trans_date": trans_date,
            "service_code": service_code,
            "ben_bank_code": ben_bank_code,
            "sender_name": sender_name,
            "sender_msisdn": sender_msisdn,
            "receiver_msisdn": receiver_msisdn,
            "amount": amount,
            "shop_name": "\(Cache.user!.ShopCode)",
            "shop_address": "\(Cache.user!.Address)",
            "user_code": "\(Cache.user!.UserName)"
        ]
        print(parameters)
        var trans:OtpCashInVTPayEx?
        provider.request(.otpCashInVTPayEx(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                trans = OtpCashInVTPayEx.getObjFromDictionary(data: json)
                if(trans!.error_code == "00"){
                    let receiver = json["receiver"]
                    trans?.nameReceiver = receiver["name"].stringValue
                    trans?.phoneReceiver = receiver["msisdn"].stringValue
                    let sender = json["sender"]
                    trans?.nameSender = sender["name"].stringValue
                    trans?.phoneSender = sender["msisdn"].stringValue
                    handler(trans!,"")
                }else{
                    handler(trans!,"\(trans!.error_msg)")
                }
            case let .failure(error):
                trans = nil
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(trans!,error.localizedDescription)
            }
        }
    }
    class func confirmDelivery(order_id:String,trans_id:String,confirm_code:String,doc_entry:String,handler: @escaping (_ results:TransferViettelPay,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "order_id": order_id,
            "trans_id": trans_id,
            "service_code": "TRANSFER",
            "confirm_code": confirm_code,
            "device_type": "2",
            "version":  "\(Common.versionApp())",
            "shop_name": "\(Cache.user!.ShopCode)",
            "shop_address": "\(Cache.user!.Address)",
            "user_code": "\(Cache.user!.UserName)",
            "doc_entry":"\(doc_entry)"
        ]
        print(parameters)
        var trans:TransferViettelPay?
        provider.request(.confirmDelivery(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                trans = TransferViettelPay.getObjFromDictionary(data: json)
                if(trans!.error_code == "00"){
                    handler(trans!,"")
                }else{
                    handler(trans!,"\(trans!.error_msg)")
                }
            case let .failure(error):
                trans = nil
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(trans!,error.localizedDescription)
            }
        }
    }
    class func GetCashInHeaders(handler: @escaping (_ success:[CashInHeader],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[CashInHeader] = []
        let parameters: [String: String] = [
            
            "usercode": "\(Cache.user!.UserName)",
            "shopcode": "\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.GetCashInHeaders(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = CashInHeader.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            let message = json["Message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,message)
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func GetCashInDetails(docentry:String,handler: @escaping (_ success:[CashInDetail],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[CashInDetail] = []
        let parameters: [String: String] = [
            
            "docentry": docentry,
            "usercode": "\(Cache.user!.UserName)"
        ]
        print(parameters)
        provider.request(.GetCashInDetails(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = CashInDetail.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            let message = json["Message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,message)
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func getFeeCashInEx(order_id:String,trans_date:String,sender_name:String,sender_msisdn:String,receiver_msisdn:String,amount:String,key_otp_fee:String,otp:String,trans_content:String,handler: @escaping (_ results:FeeCashInViettelPay,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "order_id": order_id,
            "trans_date": trans_date,
            "service_code": "TRANSFER",
            "ben_bank_code": "VTT",
            "sender_name": sender_name,
            "sender_msisdn": sender_msisdn,
            "receiver_msisdn": receiver_msisdn,
            "amount": amount,
            "key_otp_fee": key_otp_fee,
            "otp": otp,
            "trans_content": trans_content,
            "shop_name": "\(Cache.user!.ShopCode)",
            "shop_address": "\(Cache.user!.Address)",
            "user_code": "\(Cache.user!.UserName)"
        ]
        print(parameters)
        var trans:FeeCashInViettelPay?
        provider.request(.getFeeCashInEx(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                trans = FeeCashInViettelPay.getObjFromDictionary(data: json)
                
                
                
                if(trans!.error_code == "00"){
                    let receiver = json["receiver"]
                    trans?.nameReceiver = receiver["name"].stringValue
                    trans?.phoneReceiver = receiver["msisdn"].stringValue
                    let sender = json["sender"]
                    trans?.nameSender = sender["name"].stringValue
                    trans?.phoneSender = sender["msisdn"].stringValue
                    handler(trans!,"")
                }else{
                    handler(trans!,"\(trans!.error_msg)")
                }
            case let .failure(error):
                trans = nil
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(trans!,error.localizedDescription)
            }
        }
    }
    class func GetInitTransferHeaders(handler: @escaping (_ success:[InitTransferHeader],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[InitTransferHeader] = []
        let parameters: [String: String] = [
            
            "usercode": "\(Cache.user!.UserName)",
            "shopcode": "\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.GetInitTransferHeaders(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = InitTransferHeader.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            let message = json["Message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,message)
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func GetInitTransferDetails(docentry:String,handler: @escaping (_ success:[InitTransferDetail],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[InitTransferDetail] = []
        let parameters: [String: String] = [
            
            "docentry": docentry,
            "usercode": "\(Cache.user!.UserName)",
            
            
        ]
        print(parameters)
        provider.request(.GetInitTransferDetails(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = InitTransferDetail.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            let message = json["Message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,message)
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func resetReceiptCodeEx(order_id:String,trans_id:String,trans_date:String,handler: @escaping (_ results:ReceiptCodeEx,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "order_id": order_id,
            "trans_id": trans_id,
            "trans_date": trans_date,
            "service_code": "TRANSFER",
            "object_receipt_type": "1",
            "shop_name": "\(Cache.user!.ShopCode)",
            "shop_address": "\(Cache.user!.Address)",
            "user_code": "\(Cache.user!.UserName)"
        ]
        print(parameters)
        var trans:ReceiptCodeEx?
        provider.request(.resetReceiptCodeEx(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                trans = ReceiptCodeEx.getObjFromDictionary(data: json)
                if(trans!.error_code == "00"){
                    handler(trans!,"")
                }else{
                    handler(trans!,trans!.error_msg)
                }
                
            case let .failure(error):
                trans = nil
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(trans!,error.localizedDescription)
            }
        }
    }
    class func getTransInfoEx(order_id:String,trans_date:String,receipt_code:String,amount:String,receiver_msisdn:String,handler: @escaping (_ results:TransInfoViettelPay,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "order_id": order_id,
            "service_code": "TRANSFER",
            "trans_date": trans_date,
            "receipt_code": receipt_code,
            "amount": amount,
            "receiver_msisdn": receiver_msisdn,
            "shop_name": "\(Cache.user!.ShopCode)",
            "shop_address": "\(Cache.user!.Address)",
            "user_code": "\(Cache.user!.UserName)"
        ]
        print(parameters)
        var trans:TransInfoViettelPay?
        provider.request(.getTransInfoEx(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                trans = TransInfoViettelPay.getObjFromDictionary(data: json)
                if(trans!.error_code == "00"){
                    let receiver = json["receiver"]
                    trans?.nameReceiver = receiver["name"].stringValue
                    trans?.msisdnReceiver = receiver["msisdn"].stringValue
                    let sender = json["sender"]
                    trans?.nameSender = sender["name"].stringValue
                    trans?.msisdnSender = sender["msisdn"].stringValue
                    handler(trans!,"")
                }else{
                    handler(trans!,trans!.error_msg)
                }
            case let .failure(error):
                trans = nil
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(trans!,error.localizedDescription)
            }
        }
    }
    class func cashIn(trans_date:String,sender_name:String,sender_msisdn:String,receiver_name:String,receiver_msisdn:String,amount:String,key_otp_fee:String,otp:String,trans_content:String,trans_fee:String,handler: @escaping (_ results:CashInViettelPay?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            
            "trans_date": trans_date,
            "service_code": "TRANSFER",
            "ben_bank_code": "VTT",
            "sender_name": sender_name,
            "sender_msisdn": sender_msisdn,
            "receiver_name": receiver_name,
            "receiver_msisdn": receiver_msisdn,
            "amount": amount,
            "key_otp_fee": key_otp_fee,
            "otp": otp,
            "trans_content": trans_content,
            "trans_fee": trans_fee,
            "shop_name": "\(Cache.user!.ShopCode)",
            "shop_address": "\(Cache.user!.Address)",
            "user_code": "\(Cache.user!.UserName)",
            "device_type": "2",
            "version": "\(Common.versionApp())"
        ]
        print(parameters)
        var trans:CashInViettelPay?
        provider.request(.cashIn(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if(json != nil){
                    trans = CashInViettelPay.getObjFromDictionary(data: json!)
                    
                    if(trans!.error_code == "00"){
                        let receiver = json!["receiver"]
                        trans?.nameReceiver = receiver["name"].stringValue
                        trans?.phoneReceiver = receiver["msisdn"].stringValue
                        let sender = json!["sender"]
                        trans?.nameSender = sender["name"].stringValue
                        trans?.phoneSender = sender["msisdn"].stringValue
                        handler(trans!,"")
                    }else{
                        let message = json?["error_msg"].string
                        handler(nil,message ?? "Load API Error")
                    }
                }else{
                    handler(nil,"Lỗi Load API cashIn")
                }
                
            case let .failure(error):
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func initTransferEx(order_id:String,trans_date:String,receipt_code:String,amount:String,receiver_msisdn:String,handler: @escaping (_ results:InitTransferEx,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            
            "order_id": order_id,
            "service_code": "TRANSFER",
            "trans_date": trans_date,
            "receiver_msisdn": receiver_msisdn,
            "amount": amount,
            "receipt_code": receipt_code,
            "init_type": "1",
            "shop_name": "\(Cache.user!.ShopCode)",
            "shop_address": "\(Cache.user!.Address)",
            "user_code": "\(Cache.user!.UserName)"
        ]
        print(parameters)
        var trans:InitTransferEx?
        provider.request(.initTransferEx(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                trans = InitTransferEx.getObjFromDictionary(data: json)
                
                
                
                if(trans!.error_code == "00"){
                    //                    let receiver = json["receiver"]
                    //                    trans?.nameReceiver = receiver["name"].stringValue
                    //                    trans?.msisdnReceiver = receiver["msisdn"].stringValue
                    //                    let sender = json["sender"]
                    //                    trans?.nameSender = sender["name"].stringValue
                    //                    trans?.msisdnSender = sender["msisdn"].stringValue
                    handler(trans!,"")
                }else{
                    handler(trans!,trans!.error_msg)
                }
                
                
                
            case let .failure(error):
                trans = nil
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(trans!,error.localizedDescription)
            }
        }
    }
    class func confirmCancel(order_id:String,trans_id:String,confirm_code:String,original_order_id:String,handler: @escaping (_ results:ConfirmCancel,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            
            "order_id": order_id,
            "trans_id": trans_id,
            "service_code": "TRANSFER",
            "confirm_code": confirm_code,
            "original_order_id": original_order_id,
            "original_trans_id": trans_id,
            "device_type": "2",
            "shop_name": "\(Cache.user!.ShopCode)",
            "shop_address": "\(Cache.user!.Address)",
            "user_code": "\(Cache.user!.UserName)"
        ]
        print(parameters)
        var trans:ConfirmCancel?
        provider.request(.confirmCancel(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                trans = ConfirmCancel.getObjFromDictionary(data: json)
                
                
                
                if(trans!.error_code == "00"){
                    //                    let receiver = json["receiver"]
                    //                    trans?.nameReceiver = receiver["name"].stringValue
                    //                    trans?.msisdnReceiver = receiver["msisdn"].stringValue
                    //                    let sender = json["sender"]
                    //                    trans?.nameSender = sender["name"].stringValue
                    //                    trans?.msisdnSender = sender["msisdn"].stringValue
                    handler(trans!,"")
                }else{
                    handler(trans!,trans!.error_msg)
                }
                
                
                
            case let .failure(error):
                trans = nil
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(trans!,error.localizedDescription)
            }
        }
    }
    class func SaveSignatureOfCust(CardName:String,IDCard:String,PhoneNumber:String,Signature:String,handler: @escaping (_ results:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "CardName": CardName,
            "IDCard": "TRANSFER",
            "PhoneNumber": PhoneNumber,
            "Signature": Signature,
            "CreateBy": "\(Cache.user!.UserName)",
            "ShopCode": "\(Cache.user!.ShopName)"
        ]
        print(parameters)
        
        provider.request(.SaveSignatureOfCust(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        handler("","")
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func CheckCustFeeBack(trans_id:String,handler: @escaping (_ results:CustFeeBack?,_ message:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "trans_id": "\(trans_id)",
            "user_code": "\(Cache.user!.UserName)",
            "shop_code": "\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        var custFeeBack:CustFeeBack?
        provider.request(.CheckCustFeeBack(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                
                if let success = json["Success"].bool {
                    let object = json["Data"]
                    let message = json["Message"].stringValue
                    if(success){
                        custFeeBack = CustFeeBack.getObjFromDictionary(data: object)
                        handler(custFeeBack,message,"")
                        
                    }else{
                        handler(nil,"",message)
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"","Load API ERRO")
                }
                
                
            case let .failure(error):
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,"",error.localizedDescription)
            }
        }
    }
    class func mpos_DetectIDCard(Image_CMND:String,handler: @escaping (_ success:DetectIDCard?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters: [String: String] = [
            "Image_CMND":"\(Image_CMND)"
            
        ]
        var rs:DetectIDCard?
        //print(parameters)
        provider.request(.mpos_DetectIDCard(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                if let success = json["Success"].bool {
                    if(success){
                        let object = json["Data"]
                        rs = DetectIDCard.getObjFromDictionary(data: object)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        let message = json["Message"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
                
            }
        }
    }
    class func mpos_FRT_SP_mirae_load_by_SOPOS(SOPOS:String,docentry_mpos_HD:String,handler: @escaping (_ status:[StatusSOPOSMirae],_ header:[HeaderSOPOSMirae],_ detail:[DetailSOPOSMirae],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "SOPOS":"\(SOPOS)",
            "docentry_mpos_HD":"\(docentry_mpos_HD)"
            
        ]
        var statusArray:[StatusSOPOSMirae] = []
        var headerArray:[HeaderSOPOSMirae] = []
        var detailArray:[DetailSOPOSMirae] = []
        //print(parameters)
        provider.request(.mpos_FRT_SP_mirae_load_by_SOPOS(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        let jsonData = json!["Data"]
                        if let jsonStatus = jsonData["Status"].array {
                            statusArray = StatusSOPOSMirae.parseObjfromArray(array: jsonStatus)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if let jsonHeader = jsonData["Header"].array{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                headerArray = HeaderSOPOSMirae.parseObjfromArray(array: jsonHeader)
                                if let jsonDetail = jsonData["Details"].array{
                                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                    detailArray = DetailSOPOSMirae.parseObjfromArray(array: jsonDetail)
                                    handler(statusArray,headerArray,detailArray,"")
                                }else{
                                    let message = json!["Message"].stringValue
                                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                    handler(statusArray,headerArray,detailArray,message)
                                }
                            }else{
                                let message = json!["Message"].stringValue
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(statusArray,headerArray,detailArray,message)
                            }
                            
                        }else{
                            let message = json!["Message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(statusArray,headerArray,detailArray,message)
                        }
                        
                    }else{
                        let message = json?["Message"].string
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(statusArray,headerArray,detailArray,message ?? "Load API ERROR!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(statusArray,headerArray,detailArray,"Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(statusArray,headerArray,detailArray,error.localizedDescription)
                
            }
        }
    }
    
    //    sp_mpos_FRT_SP_Notify_Confirm
    class func sp_mpos_FRT_SP_Notify_Confirm(handler: @escaping (_ success:[SimpleResponse1],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserID":"\(Cache.user!.UserName)"
            
        ]
        var rs:[SimpleResponse1] = []
        //print(parameters)
        provider.request(.sp_mpos_FRT_SP_Notify_Confirm(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = SimpleResponse1.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
                
            }
        }
    }
    class func SearchProductWithItemCode(ItemCode:String,handler: @escaping (_ msg:String, _ rsInfoPlace:[InfoPlace],_ rsInfoProduct: [InfoProduct],_ error:String) ->Void){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "ShopCode":"\(Cache.user!.ShopCode)",
            "ItemCode":"\(ItemCode)"
        ]
        var rsInfoPlace:[InfoPlace] = []
        var rsInfoProduct:[InfoProduct] = []
        print(parameters)
        
        provider.request(.SearchProductWithItemCode(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        
                        let object = json["Data"]
                        let Message = json["Message"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if (!object.isEmpty){
                            let arrInfoPlace = object["InfoPlace"].array
                            rsInfoPlace = InfoPlace.parseObjfromArray(array: arrInfoPlace ?? [])
                            
                            let arrInfoProduct = object["InfoProduct"].array
                            rsInfoProduct = InfoProduct.parseObjfromArray(array: arrInfoProduct ?? [])
                            
                            handler(Message ,rsInfoPlace, rsInfoProduct, "")
                        } else {
                            handler(Message ,rsInfoPlace, rsInfoProduct, "")
                        }
                        
                    }else{
                        let Message = json["Message"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(Message ,rsInfoPlace, rsInfoProduct, "")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", [], [],"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("", [], [],error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_Mirae_getAll_Documents(Key:String,handler: @escaping (_ success:[AllDocumentsMirae],_ error:String) ->Void){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "Key":"\(Key)",
            "ShopCode":"\(Cache.user!.ShopCode)"
        ]
        var rs:[AllDocumentsMirae] = []
        //print(parameters)
        provider.request(.mpos_FRT_Mirae_getAll_Documents(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        
                        if let data = json["Data"].array {
                            rs = AllDocumentsMirae.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            let message = json["Message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,message)
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func SearchProductWithPlace(Place:String,handler: @escaping (_ msg:String, _ rsInfoProduct: [InfoProduct], _ rsImg: [ImgSearchProduct],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "ShopCode":"\(Cache.user!.ShopCode)",
            "Place":"\(Place)"
        ]
        
        var rsInfoProduct:[InfoProduct] = []
        var rsImg:[ImgSearchProduct] = []
        print(parameters)
        
        provider.request(.SearchProductWithPlace(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        let object = json["Data"]
                        let Message = json["Message"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if (!object.isEmpty) {
                            let arrInfoProduct = object["InfoProduct"].array
                            rsInfoProduct = InfoProduct.parseObjfromArray(array: arrInfoProduct ?? [])
                            
                            let arrImages = object["Images"].array
                            rsImg = ImgSearchProduct.parseObjfromArray(array: arrImages ?? [])
                            
                            handler(Message ,rsInfoProduct, rsImg, "")
                        } else {
                            handler(Message ,rsInfoProduct, rsImg, "")
                        }
                        
                    }else{
                        let Message = json["Message"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(Message ,rsInfoProduct, rsImg, "")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", [], [],"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("", [], [],error.localizedDescription)
                
            }
        }
    }
    class func mpos_FRT_Mirae_Check_Documents_Info(Info:String,handler: @escaping (_ success:[Documents_InfoMirae],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserCode":"\(Cache.user!.UserName)",
            "ShopCode":"\(Cache.user!.ShopCode)",
            "Info": "\(Info)",
            "Device": "2",
            "Version": "\(Common.versionApp())"
            
        ]
        var rs:[Documents_InfoMirae] = []
        print(parameters)
        provider.request(.mpos_FRT_Mirae_Check_Documents_Info(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = Documents_InfoMirae.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_UploadImage_Warranty(PhoneNumber:String, Images:String,handler: @escaping (_ urlString:[String], _ message: String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "PhoneNumber":"\(PhoneNumber)",
            "Images":"\(Images)"
        ]
        debugPrint(parameters)
        var rs:[String] = []
        provider.request(.mpos_FRT_UploadImage_Warranty(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                guard let json = try? JSON(data: data) else {
                    handler(rs, "", "LOAD API ERROR!")
                    return
                    
                }
                debugPrint(json)
                let Message = json["Message"].stringValue
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let mdata = json["Data"].array {
                            for i in 0..<mdata.count {
                                rs.append(mdata[i].stringValue)
                            }
                            handler(rs,Message, "")
                        }else{
                            handler(rs, Message, "Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs, Message, "Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs, Message, "Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, "", error.localizedDescription)
                
            }
        }
    }
    class func mpos_sp_GetImageWarrantyByDocEntry(DocEntry:String,handler: @escaping (_ success:[WarrantyImgItem], _ message: String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "DocEntry":"\(DocEntry)"
        ]
        debugPrint(parameters)
        var rs:[WarrantyImgItem] = []
        provider.request(.mpos_sp_GetImageWarrantyByDocEntry(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let Message = json["Message"].stringValue
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            rs = WarrantyImgItem.parseObjfromArray(array: data)
                            handler(rs,Message,"")
                        }else{
                            handler(rs,Message,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,Message,"Load API ERRO")
                    }
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs, Message, "Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, "", error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_Mirae_Update_WaybillNumber(RequestId:Int, WaybillNumber: String, handler: @escaping (_ resultCode:Int, _ message:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "UserCode":"\(Cache.user!.UserName)",
            "RequestId":RequestId,
            "WaybillNumber":"\(WaybillNumber)"
            
        ]
        print(parameters)
        provider.request(.mpos_FRT_Mirae_Update_WaybillNumber(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            let rsCode = data[0]["Result"].int
                            let msg = data[0]["Message"].string
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rsCode ?? 0, msg ?? "", "")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(0,"","")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0, "", "Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0, "", "Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0, "", error.localizedDescription)
                
            }
        }
    }
    class func mpos_FRT_Mirae_LoadInfo_Send_Bill(handler: @escaping (_ success:[Mirae_LoadInfo_Send_Bill],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var rs:[Mirae_LoadInfo_Send_Bill] = []
        provider.request(.mpos_FRT_Mirae_LoadInfo_Send_Bill){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = Mirae_LoadInfo_Send_Bill.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
                
            }
        }
    }
    class func mpos_FRT_SP_Mirae_loadTienCTMayCu(CTmayCu:String,handler: @escaping (_ success:Float,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserID":"\(Cache.user!.UserName)",
            "CTmayCu":"\(CTmayCu)"
            
        ]
        var rs:Float = 0
        print(parameters)
        provider.request(.mpos_FRT_SP_Mirae_loadTienCTMayCu(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = data[0]["Sotien"].floatValue
                            handler(rs,"")
                        }else{
                            
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
                
            }
        }
    }
    class func mpos_FRT_SP_ThuMuaMC_get_list_detail(ItemCode:String,p_loai:String,handler: @escaping (_ success:[MayDinhGia],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "ItemCode": "\(ItemCode)",
            "p_loai": "\(p_loai)"
            
        ]
        var rs:[MayDinhGia] = []
        print(parameters)
        provider.request(.mpos_FRT_SP_ThuMuaMC_get_list_detail(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = MayDinhGia.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            let message = json["Message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,message)
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
                
            }
        }
    }
    class func mpos_FRT_SP_ThuMuaMC_get_list_Loai(ItemCode:String,handler: @escaping (_ success:[LoaiDinhGiaMayCu],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "ItemCode": "\(ItemCode)"
            
        ]
        var rs:[LoaiDinhGiaMayCu] = []
        print(parameters)
        provider.request(.mpos_FRT_SP_ThuMuaMC_get_list_Loai(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = LoaiDinhGiaMayCu.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            let message = json["Message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,message)
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
                
            }
        }
    }
    class func mpos_FRT_SP_ThuMuaMC_get_list(handler: @escaping (_ success:[ThuMuaMayCuList],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)"
            
        ]
        var rs:[ThuMuaMayCuList] = []
        print(parameters)
        provider.request(.mpos_FRT_SP_ThuMuaMC_get_list(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = ThuMuaMayCuList.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            let message = json["Message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,message)
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
                
            }
        }
    }
    class func mpos_FRT_SP_ThuMuaMC_get_info(handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)"
            
        ]
        var rs:String = ""
        print(parameters)
        provider.request(.mpos_FRT_SP_ThuMuaMC_get_info(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = data[0]["info"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            let message = json["Message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,message)
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
                
            }
        }
    }
    
    class func getImeiFF(productCode:String,shopCode:String,handler: @escaping (_ success:[Imei],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[Imei] = []
        provider.request(.getImeiFF(productCode:productCode,shopCode:shopCode)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let data = json["getImeiResult"].array {
                    rs = Imei.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_Mirae_Send_Documents_Info(WaybillNumber:String, ListProcessID:String, handler: @escaping (_ rsCode:Int, _ message:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "UserCode":"\(Cache.user!.UserName)",
            "ShopCode":"\(Cache.user!.ShopCode)",
            "WaybillNumber":"\(WaybillNumber)",
            "ListContractNumber":"\(ListProcessID)",
            "Device":2,
            "Version":"\(Common.versionApp())"
        ]
        print(parameters)
        provider.request(.mpos_FRT_Mirae_Send_Documents_Info(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                debugPrint(json)
                
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        if(!data.isEmpty){
                            let Result = data["Result"].intValue
                            let Message = data["Message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(Result, Message,"")
                        } else  {
                            handler(0, "","Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0, "","Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0, "","Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0, "",error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_mirae_tinhsotienchenhlech(rdr1: String,schemecode:String,Sotienvay:String,kyhan:String,IDmpos:String,handler: @escaping (_ success:Float,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "schemecode":"\(schemecode)",
            "SotienVay":"\(Sotienvay)",
            "kyhan":"\(kyhan)",
            "IDmpos":"\(IDmpos)",
            "UserID":"\(Cache.user!.UserName)",
            "mashop":"\(Cache.user!.ShopCode)",
            "RDR1": rdr1,
            "partnerId": PARTNERIDORDER
        ]
        var rs:Float = 0
        print(parameters)
        provider.request(.mpos_FRT_SP_mirae_tinhsotienchenhlech(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = data[0]["Sotien"].floatValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            let message = json["Message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,message)
                        }
                        
                    }else{
                        let message = json["Message"].string
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,message ?? "Load API ERROR")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let message = json["MessageDetail"].string ?? "Load API ERROR"
                    handler(rs,message)
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
                
            }
        }
    }
    class func mpos_GetPlayBackCamera(ShopCode:String, CarrierName: String, isCellular: String,handler: @escaping (_ success:PlayBackCamera?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "ShopCode":"\(ShopCode)",
            "CarrierName":"\(CarrierName)",
            "isCellular":"\(isCellular)"
        ]
        provider.request(.mpos_GetPlayBackCamera(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data = PlayBackCamera.getObjFromDictionary(data: json["Data"])
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(data,"")
                    }else{
                        let message = json["Message"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,message)
                    }
                }else{
                    let message = json["Message"].stringValue
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,message)
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_Report_InstallApp(imei: String, fromDate: String, toDate: String, handler: @escaping (_ success:[ReportInstallVNG],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "imei":"\(imei)",
            "fromDate":"\(fromDate)",
            "toDate":"\(toDate)",
            "userCode":"\(Cache.user!.UserName)"
        ]
        var rs:[ReportInstallVNG] = []
        print(parameters)
        provider.request(.mpos_FRT_Report_InstallApp(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = ReportInstallVNG.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_Mirae_noteforsale(type:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters: [String: String] = [
            "UserID":"\(Cache.user!.UserName)",
            "type":"\(type)"
        ]
        log.debug(parameters)
        provider.request(.mpos_FRT_SP_Mirae_noteforsale(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
          
                log.debug(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data1 = json!["Data"].array {
                            if(data1.count > 0){
                                let a = data1[0]["note"].string == nil ? "" : data1[0]["note"].stringValue
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(a,"")
                            }else{
                                let message = json!["Message"].stringValue
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler("",message)
                            }
                        }else{
                            let message = json!["Message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler("",message)
                        }
                        
                    }else{
                        let message = json!["Message"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("",message)
                    }
                }else{
                    let message = json?["Message"].string
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("",message ?? "Load API Error")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    
    class func mpos_FRT_SP_mirae_history_order_byuser_HD_pending(handler: @escaping (_ success:[HistoryOrderByUser],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[HistoryOrderByUser] = []
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "partnerId": PARTNERID
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_mirae_history_order_byuser_HD_pending(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = HistoryOrderByUser.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }case let .failure(error):
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func sp_mpos_FRT_SP_innovation_loadDS_nhanvien(handler: @escaping (_ success:[SupportEmployee],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "mashop":"\(Cache.user!.ShopCode)",
            "userID":"\(Cache.user!.UserName)"
        ]
        var rs:[SupportEmployee] = []
        print(parameters)
        provider.request(.sp_mpos_FRT_SP_innovation_loadDS_nhanvien(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = SupportEmployee.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func Maycu_Ecom_GetListProduct(status: String, handler: @escaping (_ success:[MayCuECom],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserID":"\(Cache.user!.UserName)",
            "ShopCode":"\(Cache.user!.ShopCode)",
            "Status":"\(status)"
        ]
        var rs:[MayCuECom] = []
        print(parameters)
        provider.request(.Maycu_Ecom_GetListProduct(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = MayCuECom.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func Maycu_Ecom_GetColor_Product(sku: String, handler: @escaping (_ success:[ColorMayCu],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "Sku":"\(sku)"
        ]
        var rs:[ColorMayCu] = []
        print(parameters)
        provider.request(.Maycu_Ecom_GetColor_Product(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = ColorMayCu.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func MayCu_Ecom_Update(Id: String, Sku: String, Accessories: String, ShortDescription: String, xmlistImage: String, handler: @escaping ( _ success:Int, _ Message: String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "ID":"\(Id)",
            "Sku": "\(Sku)",
            "Accessories": "\(Accessories)",
            "ShortDescription": "\(ShortDescription)",
            "xmlistImage":"\(xmlistImage)",
            "UserID": "\(Cache.user!.UserName)",
            "ShopCode":"\(Cache.user!.ShopCode)",
            "DeviceType":"2"
        ]
        print(parameters)
        provider.request(.MayCu_Ecom_Update(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let success = json["Success"].boolValue
                    if(success){
                        let data = json["Data"].arrayValue
                        if data.count > 0 {
                            let rs = data[0]
                            let rsCode = rs["Result"].intValue
                            let msg = rs["Message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rsCode, msg, "")
                        } else {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(0, "","Load API ERROR")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0, "","Load API ERROR")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0, "", error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0, "", error.localizedDescription)
            }
        }
    }
    class func getSODetailsFF(docEntry:String,handler: @escaping (_ success:SODetail?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "Docentry":"\(docEntry)"
            
        ]
        
        print(parameters)
        provider.request(.getSODetailFF(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let data1 = json["Data"]
                if (!data1.isEmpty) {
                    let rs = SODetail.getObjFromDictionary(data: data1)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func pushBillThuHoViettelPay(printBill:BillParamViettelPay, title: String = "Test PrintShare thu hộ") {
        
        let mn = Config.manager
        
        let action = "\(Cache.user!.ShopCode)/push"
        let urlString = "\(mn.URL_PRINT_BILL!)/api/\(action)"
        let manager = Alamofire.Session.default
        if let data =  try? JSONSerialization.data(withJSONObject: printBill.toJSON(), options: []){
            if let jsonData = String(data:data, encoding:.utf8) {
                print(jsonData)
                let billParam = BillParam(title: title, body: jsonData,id: "POS", key: "pos_thuho")
                let billMessage = BillMessage(message:billParam)
                
                if let data2 =  try? JSONSerialization.data(withJSONObject: billMessage.toJSON(), options: []){
                    if let url = URL(string: urlString) {
                        var request = URLRequest(url: url)
                        request.httpMethod = HTTPMethod.post.rawValue
                        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                        request.httpBody = data2
                        manager.request(request).responseJSON {
                            (response) in
                            print(response)
                        }
                    }
                }
            }
        }
    }
    
    class func Moca_CreateQRCodeMobile(amount: String, handler: @escaping (_ success:CreateQRCodeMobile?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "currency": "VND",
            "amount": "\(amount)",
            "usercode": "\(Cache.user!.UserName)",
            "shopcode": "\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.Moca_CreateQRCodeMobile(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                
                if (!json.isEmpty){
                    let rs = CreateQRCodeMobile.getObjFromDictionary(data: json)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                    
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    
    class func Moca_Inquiry(partnerTxID: String, handler: @escaping (_ success:InquiryItem?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "currency": "VND",
            "txType": "P2M",
            "partnerTxID": "\(partnerTxID)",
            "usercode": "\(Cache.user!.UserName)",
            "shopcode": "\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.Moca_Inquiry(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                
                if (!json.isEmpty){
                    let rs = InquiryItem.getObjFromDictionary(data: json)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                    
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    
    class func MayCuEcom_GetItemDetail(Id: String, handler: @escaping (_ success:MayCuEcomDetail?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "ID":"\(Id)"
        ]
        print(parameters)
        provider.request(.MayCuEcom_GetItemDetail(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                
                if let success = json["Success"].bool {
                    if(success){
                        let mData = json["Data"]
                        let rs = MayCuEcomDetail.getObjFromDictionary(data: mData)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
                
            }
        }
    }
    class func Report_InstallApp_Utop(fromDate: String, toDate: String, handler: @escaping (_ success:[InstallApp_Utop],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "fromDate": "\(fromDate)",
            "toDate": "\(toDate)",
            "userCode": "\(Cache.user!.UserName)"
        ]
        print(parameters)
        var rs:[InstallApp_Utop] = []
        provider.request(.Report_InstallApp_Utop(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = InstallApp_Utop.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_VNPT_loadinfoByCMND(CMND:String,handler: @escaping (_ success:[InfoCmndVNPT],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "CMND":"\(CMND)",
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)"
        ]
        var rs:[InfoCmndVNPT] = []
        print(parameters)
        provider.request(.mpos_FRT_SP_VNPT_loadinfoByCMND(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = InfoCmndVNPT.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_Image_VNPT(CMND:String,IDMpos:String,Base64:String,Type:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters: [String: String] = [
            "CMND":"\(CMND)",
            "IDMpos":"\(IDMpos)",
            "Base64":"\(Base64)",
            "Type":"\(Type)"
        ]
        
        log.debug(parameters)
        provider.request(.mpos_FRT_Image_VNPT(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                if let success = json["Success"].bool {
                    if(success){
                        let url = json["Data"].stringValue
                        handler(url,"")
                        
                    }else{
                        let message = json["Data"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("",message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_VNPT_sendotp(CMND:String,sdt_email:String,type:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "cmnd":"\(CMND)",
            "userID":"\(Cache.user!.UserName)",
            "typeotp":"\(type)",
            "sdt_email":"\(sdt_email)"
        ]
        
        print(parameters)
        provider.request(.mpos_FRT_SP_VNPT_sendotp(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            let rs = data[0]["p_messagess"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler("","Load API ERRO")
                        }
                        
                    }else{
                        let message = json["Data"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("",message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_VNPT_create_info(otp:String,cmnd:String,sdt:String,TenKh:String,url_cmnd_matTruoc:String,url_cmnd_matsau:String,url_phieumuahang:String,handler: @escaping (_ success:[ResultCreateInfoVNPT],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
   
        let parameters: [String: String] = [
            "userID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "otp":"\(otp)",
            "CMND":"\(cmnd)",
            "SDT":"\(sdt)",
            "TenKh":"\(TenKh)",
            "url_cmnd_matTruoc":"\(url_cmnd_matTruoc)",
            "url_cmnd_matsau":"\(url_cmnd_matsau)",
            "url_phieumuahang":"\(url_phieumuahang)",
        ]
        var rs:[ResultCreateInfoVNPT] = []
     
        provider.request(.mpos_FRT_SP_VNPT_create_info(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
            
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = ResultCreateInfoVNPT.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        let message = json?["Data"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,message ?? "LOAD API ERROR !")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    class func saveOrderVNPT(phone:String,cardName:String,doctype:String,u_EplCod:String,shopCode:String,payments:String,mail:String,address:String,u_des:String,rDR1:String,pROMOS:String,LoaiTraGop:String,LaiSuat:Float,SoTienTraTruoc:Float,voucher:String,gender:String,birthday:String,soHDtragop:String,kyhan:String,CMND:String,TenCTyTraGop:String,is_KHRotTG:Int,xmlspGiamGiaTay:String,xmlstringpay:String,xmlVoucherDH:String,xml_url_pk:String,is_DH_DuAn:String,is_sale_MDMH: String,is_sale_software:String,handler: @escaping (_ result:Int,_ docentry:Int,_ So_HD:String,_ err: String) ->Void){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var param:Dictionary = Dictionary<String, Any>()
        
        
        param.updateValue(phone, forKey: "phone")
        param.updateValue(cardName, forKey: "CardName")
        param.updateValue(doctype, forKey: "Doctype")
        param.updateValue(u_EplCod, forKey: "U_EplCod")
        param.updateValue(shopCode, forKey: "ShopCode")
        param.updateValue(payments, forKey: "payments")
        param.updateValue(mail, forKey: "Mail")
        param.updateValue(address, forKey: "Address")
        param.updateValue(u_des, forKey: "U_des")
        param.updateValue(rDR1, forKey: "RDR1")
        param.updateValue(pROMOS, forKey: "PROMOS")
        param.updateValue(LoaiTraGop, forKey: "LoaiTraGop")
        
        param.updateValue("\(String(format: "%.6f", LaiSuat))", forKey: "LaiSuat")
        param.updateValue("\(String(format: "%.6f", SoTienTraTruoc))", forKey: "SoTienTraTruoc")
        param.updateValue(voucher, forKey: "voucher")
        param.updateValue("2", forKey: "DiviceType")
        param.updateValue(gender, forKey: "gioitinh")
        param.updateValue(birthday, forKey: "NgaySinh")
        
        param.updateValue(soHDtragop, forKey: "soHDtragop")
        param.updateValue(kyhan, forKey: "kyhan")
        param.updateValue(CMND, forKey: "CMND")
        param.updateValue(TenCTyTraGop, forKey: "TenCTyTraGop")
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")!
        param.updateValue("\(crm)", forKey: "CRMCode")
        param.updateValue("\(Cache.user!.Token)", forKey: "Token")
        param.updateValue(Cache.DocEntryEcomCache, forKey: "pre_docentry")
        param.updateValue(is_KHRotTG, forKey: "is_KHRotTG")
        param.updateValue(xmlspGiamGiaTay, forKey: "xmlspGiamGiaTay")
        param.updateValue(xmlstringpay, forKey: "xmlstringpay")
        param.updateValue(xmlVoucherDH, forKey: "xmlVoucherDH")
        param.updateValue(Cache.DocEntryEcomCache, forKey: "pre_docentry")
        param.updateValue("\(Cache.is_samsung)", forKey: "is_samsung")
        param.updateValue(xml_url_pk, forKey: "xml_url_pk")
        param.updateValue(is_DH_DuAn, forKey: "is_DH_DuAn")
        param.updateValue(is_sale_MDMH, forKey: "is_sale_MDMH")
        param.updateValue(is_sale_software, forKey: "is_sale_software")
        debugPrint(param)
        provider.request(.saveOrderVNPT(params:param)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        if(!data.isEmpty){
                            
                            var returnCode = data["ReturnCode"].int
                            var docentry = data["Docentry"].int
                            var returnMessage = data["ReturnMessage"].string
                            var so_HD = data["So_HD"].string
                            
                            returnCode = returnCode == nil ? 3 : returnCode
                            docentry = docentry == nil ? 0 : docentry
                            returnMessage = returnMessage == nil ? "" : returnMessage
                            so_HD = so_HD == nil ? "" : so_HD
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(returnCode!,docentry!,so_HD!,returnMessage!)
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(3,0,"","Không thể lưu đơn hàng!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(3,0,"","Không thể lưu đơn hàng!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(3,0,"","Không thể lưu đơn hàng!")
                }
            case .failure:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(3,0,"","Không thể lưu đơn hàng!")
            }
        }
    }
    class func checkPromotionVNPT(u_CrdCod:String,sdt:String,LoaiDonHang:String,LoaiTraGop:String,LaiSuat:Float,SoTienTraTruoc:Float,voucher:String,kyhan:String,U_cardcode:String,HDNum:String,is_KHRotTG:Int,is_DH_DuAn:String,Docentry:String,handler: @escaping (_ success:Promotion?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var param:Dictionary = Dictionary<String, Any>()
        var xml = "<line>"
        for item in Cache.cartsVNPT{
            var whsCod = "\(Cache.user!.ShopCode)010"
            if(item.whsCode.count > 0){
                whsCod = item.whsCode
            }
            var imei = item.imei
            if(imei == "N/A"){
                imei = ""
            }
            //            xml  = xml + "<item U_ItmCod=\"\(item.product.sku)\" U_Imei=\"\(imei)\" U_Quantity=\"\(item.quantity)\" U_PriceBT=\"\(String(format: "%.6f", item.product.priceBeforeTax))\" U_Price=\"\(String(format: "%.6f", item.product.price))\" U_WhsCod=\"\(whsCod)\" Discount=\"\(String(describing: item.discount))\" Reason=\"\(item.reason)\" userapprove=\"\(item.userapprove)\"/>"
            xml  = xml + "<item U_ItmCod=\"\(item.sku)\" U_Imei=\"\(imei)\" U_Quantity=\"\(item.quantity)\" U_PriceBT=\"\(String(format: "%.6f", item.product.priceBeforeTax))\" U_Price=\"\(String(format: "%.6f", item.product.price))\" U_WhsCod=\"\(whsCod)\" Discount=\"\(String(describing: item.discount))\" Reason=\"\(item.reason)\" userapprove=\"\(item.userapprove)\"/>"
        }
        xml = xml + "</line>"
        var loaiGop = LoaiTraGop
        if (loaiGop == "-1"){
            loaiGop = "0"
        }
        
        
        param.updateValue(u_CrdCod, forKey: "u_CrdCod")
        param.updateValue(xml, forKey: "itemsInXML")
        param.updateValue(sdt, forKey: "sdt")
        param.updateValue("03", forKey: "LoaiDonHang")
        param.updateValue("0", forKey: "LoaiTraGop")
        param.updateValue("0", forKey: "LaiSuat")
        param.updateValue("0", forKey: "SoTienTraTruoc")
        param.updateValue(voucher, forKey: "voucher")
        param.updateValue("0", forKey: "idCardCodeFriend")
        param.updateValue(kyhan, forKey: "kyhan")
        param.updateValue(HDNum, forKey: "HDNum")
        param.updateValue("VNPT", forKey: "U_cardcode")
        param.updateValue("\(Cache.user!.UserName)", forKey: "UserID")
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        param.updateValue("\(crm ?? "")", forKey: "CRMCode")
        param.updateValue("\(Cache.user!.Token)", forKey: "Token")
        param.updateValue("0", forKey: "is_KHRotTG")
        param.updateValue("", forKey: "is_DH_DuAn")
        param.updateValue("\(Docentry)", forKey: "Docentry")
        
        
        
        debugPrint(param)
        var promotion:Promotion? = nil
        provider.request(.checkPromotionVNPT(param:param)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        if(!data.isEmpty){
                            let returnMessage = data["ReturnMessage"]
                            if(!returnMessage.isEmpty){
                                let p_status = returnMessage["p_status"].boolValue
                                let p_messagess = returnMessage["p_messagess"].stringValue
                                let khoanvay = returnMessage["khoanvay"].intValue
                                let codevnpay = returnMessage["codevnpay"].stringValue
                                Cache.khoanvay = khoanvay
                                Cache.codevnpay = codevnpay
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                if(p_status){
                                    promotion = Promotion.getObjFromDictionary(data: data)
                                    handler(promotion,"")
                                }else{
                                    handler(promotion,p_messagess)
                                }
                            }else{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(promotion,"Kiểm tra khuyến mại thất bại!")
                            }
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(promotion,"Kiểm tra khuyến mại thất bại!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(promotion,"Kiểm tra khuyến mại thất bại!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(promotion,"Kiểm tra khuyến mại thất bại!")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(promotion,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_VNPT_upload_anhKH(CMND:String,url_anhkh:String,docentry:String,sompos:String,handler: @escaping (_ success:Int,_ messsage:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "docentry":"\(docentry)",
            "CMND":"\(CMND)",
            "sompos":"\(sompos)",
            "userID":"\(Cache.user!.UserName)",
            "mashop":"\(Cache.user!.ShopCode)",
            "url_anhkh":"\(url_anhkh)"
        ]
        
        print(parameters)
        provider.request(.mpos_FRT_SP_VNPT_upload_anhKH(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            let message = data[0]["p_messagess"].stringValue
                            let p_status = data[0]["p_status"].intValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(p_status,message,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(0,"","Load API ERRO")
                        }
                        
                    }else{
                        let message = json["Data"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"",message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"",error.localizedDescription)
            }
        }
    }
    
    class func mpos_FRT_SP_VNPT_load_history(keyword:String,handler: @escaping (_ success:[HistoryVNPT],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "keyword":"\(keyword)"
        ]
        var rs:[HistoryVNPT] = []
        print(parameters)
        provider.request(.mpos_FRT_SP_VNPT_load_history(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            rs = HistoryVNPT.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        let message = json?["Data"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,message ?? "LOAD API ERROR !")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_sp_vnpt_update_image_KH(docentry:String,url_cmnd_mattruoc:String,url_cmnd_matsau:String,url_PhieuMuaHang:String,url_kh:String,handler: @escaping (_ success:Int,_ messsage:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "docentry":"\(docentry)",
            "UserID":"\(Cache.user!.UserName)",
            "mashop":"\(Cache.user!.ShopCode)",
            "url_cmnd_mattruoc":"\(url_cmnd_mattruoc)",
            "url_cmnd_matsau":"\(url_cmnd_matsau)",
            "url_PhieuMuaHang":"\(url_PhieuMuaHang)",
            "url_kh":"\(url_kh)"
        ]
        
        print(parameters)
        provider.request(.mpos_FRT_sp_vnpt_update_image_KH(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            let message = data[0]["p_messagess"].stringValue
                            let p_status = data[0]["p_status"].intValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(p_status,message,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(0,"","Load API ERRO")
                        }
                        
                    }else{
                        let message = json["Data"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"",message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"",error.localizedDescription)
            }
        }
    }
    
    class func mpos_sp_insert_order_vnpt(phone:String,cmnd:String,CardName:String,U_EplCod:String,ShopCode:String,Sotientratruoc:String,Doctype:String,U_des:String,RDR1:String,PROMOS:String,LoaiTraGop:String,LaiSuat:String,voucher:String,otp:String,NgayDenShopMua:String,HinhThucGH:String,DiaChi:String,magioithieu:String,kyhan:String,Thanhtien:String,IDcardcode:String,HinhThucThuTien:String,soHDtragop:String,IsSkip:String,AuthenBy:String,chemecode:String,pre_docentry:String,handler: @escaping (_ result:Int,_ docentry:Int,_ err: String) ->Void){
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")!
        
        let parameters: [String: String] = [
            "CMND":"\(cmnd)",
            "CardName":"\(CardName)",
            "U_EplCod":"\(U_EplCod)",
            "ShopCode":"\(ShopCode)",
            "SoTienTraTruoc":"\(Sotientratruoc)",
            "Doctype":"\(Doctype)",
            "U_des":"\(U_des)",
            "RDR1":"\(RDR1)",
            "PROMOS":"\(PROMOS)",
            "LoaiTraGop":"\(LoaiTraGop)",
            "LaiSuat":"\(LaiSuat)",
            "voucher":"\(voucher)",
            "Address":"\(DiaChi)",
            "gioitinh":"0",
            "kyhan":"\(kyhan)",
            "Thanhtien":"\(Thanhtien)",
            "soHDtragop":"\(soHDtragop)",
            "payments":"\(HinhThucThuTien)",
            "Mail":"",
            "DiviceType": "2",
            "NgaySinh":"",
            "CRMCode":"\(crm)",
            "Token":"\(Cache.user!.Token)",
            "UserID":"\(Cache.user!.UserName)",
            "chemecode":"\(chemecode)",
            "phone":"\(phone)",
            "TenCTyTraGop":"VNPT",
            "pre_docentry":"\(pre_docentry)"
        ]
        print(parameters)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.saveOrderMirae(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        let data = json["Data"]
                        if(!data.isEmpty){
                            
                            var returnCode = data["ReturnCode"].int
                            var docentry = data["Docentry"].int
                            var returnMessage = data["ReturnMessage"].string
                            
                            returnCode = returnCode == nil ? 3 : returnCode
                            docentry = docentry == nil ? 0 : docentry
                            returnMessage = returnMessage == nil ? "" : returnMessage
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(returnCode!,docentry!,returnMessage!)
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(3,0,"Không thể lưu đơn hàng!")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(3,0,"Không thể lưu đơn hàng!")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(3,0,"Không thể lưu đơn hàng!")
                }
            case .failure(_):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(3,0,"Không thể lưu đơn hàng!")
            }
        }
    }
    class func mpos_FRT_SP_Ecom_FFriend_load_SOEcom(EcomNum:String,CMND:String,handler: @escaping ( _ status:[StatusDepositFF], _ header:[HeaderDepositFF], _ detail:[DetailDepositFF], _ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "EcomNum":"\(EcomNum)",
            "CMND":"\(CMND)"
            
        ]
        var statusArray:[StatusDepositFF] = []
        var headerArray:[HeaderDepositFF] = []
        var detailArray:[DetailDepositFF] = []
        //print(parameters)
        provider.request(.mpos_FRT_SP_Ecom_FFriend_load_SOEcom(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        let jsonData = json["Data"]
                        if let jsonStatus = jsonData["Result"].array {
                            statusArray = StatusDepositFF.parseObjfromArray(array: jsonStatus)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if let jsonHeader = jsonData["Header"].array{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                headerArray = HeaderDepositFF.parseObjfromArray(array: jsonHeader)
                                if let jsonDetail = jsonData["Details"].array{
                                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                    detailArray = DetailDepositFF.parseObjfromArray(array: jsonDetail)
                                    handler(statusArray,headerArray,detailArray,"")
                                }else{
                                    let message = json["Message"].stringValue
                                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                    handler(statusArray,headerArray,detailArray,message)
                                }
                            }else{
                                let message = json["Message"].stringValue
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(statusArray,headerArray,detailArray,message)
                            }
                            
                        }else{
                            let message = json["Message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(statusArray,headerArray,detailArray,message)
                        }
                        
                    }else{
                        let message = json["Message"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(statusArray,headerArray,detailArray,message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(statusArray,headerArray,detailArray,"Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(statusArray,headerArray,detailArray,error.localizedDescription)
                
            }
        }
    }
    class func mpos_FRT_SP_BH_insert_thongtinKH(fullname: String, gender: String, phonenumber: String, address: String,note: String, handler: @escaping (_ statusCode:Int, _ messages:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "fullname":"\(fullname)",
            "gender": "\(gender)",
            "phonenumber":"\(phonenumber)",
            "address":"\(address)",
            "devicetype":"2",
            "version":"\(Common.versionApp())",
            "note":"\(note)",
        ]
        
        print(parameters)
        provider.request(.mpos_FRT_SP_BH_insert_thongtinKH(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            let p_status = data[0]["p_status"].intValue
                            let p_messagess = data[0]["p_messagess"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(p_status, p_messagess, "")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(0, "", "Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0, "", "Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0, "", "Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0, "", error.localizedDescription)
            }
        }
    }
    
    class func mpos_FRT_SP_BH_history_thongtinKH(handler: @escaping (_ success:[BaoHiemHistory],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)"
        ]
        var rs:[BaoHiemHistory] = []
        print(parameters)
        provider.request(.mpos_FRT_SP_BH_history_thongtinKH(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = BaoHiemHistory.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            let message = json["Message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,message)
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
                
            }
        }
    }
    class func mpos_FRT_Mirae_NotiAfterUploadImageComplete(DocEntry:String,processId:String,handler: @escaping (_ success:Int,_ messsage:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "DocEntry":"\(DocEntry)",
            "UserID":"\(Cache.user!.UserName)",
            "processId":"\(Cache.user!.ShopCode)"
        ]
        
        print(parameters)
        provider.request(.mpos_FRT_Mirae_NotiAfterUploadImageComplete(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            let message = data[0]["p_messagess"].stringValue
                            let p_status = data[0]["p_status"].intValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(p_status,message,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(0,"","Load API ERRO")
                        }
                        
                    }else{
                        let message = json["Data"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"",message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"",error.localizedDescription)
            }
        }
    }
    
    class func mpos_FRT_Mirae_CreateCalllog_DuyetHinhAnh(DocEntry:String,processId:String,handler: @escaping (_ success:Int,_ messsage:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "DocEntry":"\(DocEntry)",
            "UserID":"\(Cache.user!.UserName)",
            "processId":"\(processId)"
        ]
        
        print(parameters)
        provider.request(.mpos_FRT_Mirae_CreateCalllog_DuyetHinhAnh(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            let message = data[0]["p_messagess"].stringValue
                            let p_status = data[0]["p_status"].intValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(p_status,message,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(0,"","Load API ERRO")
                        }
                        
                    }else{
                        let message = json["Data"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"",message)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"",error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_Mirae_history_order_byKeyword(Keyword:String,Type:String,handler: @escaping (_ success:[HistoryOrderByUser],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[HistoryOrderByUser] = []
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "Keyword":"\(Keyword)",
            "Type":"\(Type)",
            "partnerId": PARTNERID
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_Mirae_history_order_byKeyword(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = HistoryOrderByUser.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    //vemaybay
    class func mpos_FRT_Flight_Tripi_InsertBooking(Json:String,handler: @escaping (_ success:ResultInsertTribi?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "CreateBy": "\(Cache.user!.UserName)",
            "ShopCode": "\(Cache.user!.ShopCode)",
            "DeviceType": "2",
            "Json": Json,
            "Token":"\(Cache.user!.Token)"
        ]
        var rs:ResultInsertTribi? = nil
        print(parameters)
        provider.request(.mpos_FRT_Flight_Tripi_InsertBooking(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                rs = ResultInsertTribi.getObjFromDictionary(data: json)
                handler(rs,"")
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_Flight_Tripi_ConfirmBooking(DocEntry:String,bookingId:String,handler: @escaping (_ success:ResultInsertTribi?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "DocEntry": "\(DocEntry)",
            "bookingId": "\(bookingId)",
            "UserCode": "\(Cache.user!.UserName)",
            "ShopCode": "\(Cache.user!.ShopCode)",
            "Token":"\(Cache.user!.Token)"
        ]
        var rs:ResultInsertTribi? = nil
        print(parameters)
        provider.request(.mpos_FRT_Flight_Tripi_ConfirmBooking(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                rs = ResultInsertTribi.getObjFromDictionary(data: json)
                handler(rs,"")
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_Flight_Tripi_GetHistory(Key:String,Type:String,handler: @escaping (_ success:[HistoryFlightTribi],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "Key":"\(Key)",
            "Type":"\(Type)",
            "ShopCode":"\(Cache.user!.ShopCode)",
            "Token":"\(Cache.user!.Token)"
        ]
        var rs:[HistoryFlightTribi] = []
        print(parameters)
        provider.request(.mpos_FRT_Flight_Tripi_GetHistory(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["success"].bool {
                    if(success){
                        if let data = json?["data"].array {
                            rs = HistoryFlightTribi.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            let message = json?["message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,message ?? "LOAD API ERROR !")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
                
            }
        }
    }
    class func mpos_FRT_Flight_Tripi_GetDetailInfor(docentry:String,handler: @escaping (_ success:[DetailFlightTribi],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "docentry":"\(docentry)",
            "Token":"\(Cache.user!.Token)"
        ]
        var rs:[DetailFlightTribi] = []
        print(parameters)
        provider.request(.mpos_FRT_Flight_Tripi_GetDetailInfor(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["success"].bool {
                    if(success){
                        if let data = json["data"].array {
                            rs = DetailFlightTribi.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            let message = json["message"].stringValue
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,message)
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
                
            }
        }
    }
    class func Flight_Tripi_CreateCalllog(bookingId:String, DocenTry:String, Note: String, Type: String, Service: String,handler: @escaping (_ success:[Tripi_CreateCalllog],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[Tripi_CreateCalllog] = []
        let parameters: [String: String] = [
            "bookingId":"\(bookingId)",
            "DocenTry":"\(DocenTry)",
            "ShopCode":"\(Cache.user!.ShopCode)",
            "UserCode":"\(Cache.user!.UserName)",
            "Devicetype":"2",
            "Note":"\(Note)",
            "Token":"\(Cache.user!.Token)",
            "Type":"\(Type)",
            "Service":"\(Service)"
        ]
        print(parameters)
        provider.request(.Flight_Tripi_CreateCalllog(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["success"].boolValue
                let msg = json["message"].stringValue
                if(success){
                    if let data = json["data"].array {
                        rs = Tripi_CreateCalllog.parseObjfromArray(array: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"\(msg)")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    
    class func Flight_Tripi_GetConversation_CreateCalllog(bookingId:String, DocenTry:String, Type: String,handler: @escaping (_ success:[Tripi_GetConversation],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[Tripi_GetConversation] = []
        let parameters: [String: String] = [
            "bookingId":"\(bookingId)",
            "DocenTry":"\(DocenTry)",
            "Token":"\(Cache.user!.Token)",
            "Type":"\(Type)"
        ]
        print(parameters)
        provider.request(.Flight_Tripi_GetConversation_CreateCalllog(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["success"].boolValue
                let msg = json["message"].stringValue
                if(success){
                    if let data = json["data"].array {
                        rs = Tripi_GetConversation.parseObjfromArray(array: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"\(msg)")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    
    class func Get_Info_FF_From_QRCode(input_qrcode:String,handler: @escaping (_ success:QRcodeFFriend?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:QRcodeFFriend? = nil
        let parameters: [String: String] = [
            "input_qrcode":"\(input_qrcode)",
            "createby":"\(Cache.user!.UserName)"
            
        ]
        print(parameters)
        provider.request(.Get_Info_FF_From_QRCode(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                
                if(success){
                    let data = json["Data"]
                    if(!data.isEmpty){
                        
                        rs = QRcodeFFriend.getObjFromDictionary(data: data)
                        handler(rs,"")
                    }else{
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_mirae_sendsms(cmnd:String,phone:String,processId:String,partnerId: String,handler: @escaping (_ p_status:Int,_ p_messagess:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "cmnd":"\(cmnd)",
            "userID":"\(Cache.user!.UserName)",
            "phonenumber":"\(phone)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "processId":"\(processId)",
            "partnerId": partnerId
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_mirae_sendsms(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                
                if(success){
                    if let data = json["Data"].array {
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let p_status = data[0]["p_status"].intValue
                        let p_messagess = data[0]["p_messagess"].stringValue
                        handler(p_status,p_messagess,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"","Load API ERRO")
                    }
                    
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"", error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_SK_viewdetail_all(docentry:String,handler: @escaping (_ success:[DetailRPAll],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[DetailRPAll] = []
        let parameters: [String: String] = [
            "docentry":"\(docentry)",
            "userId":"\(Cache.user!.UserName)",
            "mashop":"\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_viewdetail_all(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                let msg = json["Message"].stringValue
                if(success){
                    if let data = json["Data"].array {
                        rs = DetailRPAll.parseObjfromArray(array: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"\(msg)")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_SK_viewdetail_Rcheck(docentry:String,handler: @escaping (_ success:[DetailRPRcheck],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[DetailRPRcheck] = []
        let parameters: [String: String] = [
            "docentry":"\(docentry)",
            "userId":"\(Cache.user!.UserName)",
            "mashop":"\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_viewdetail_Rcheck(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                let msg = json["Message"].stringValue
                if(success){
                    if let data = json["Data"].array {
                        rs = DetailRPRcheck.parseObjfromArray(array: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"\(msg)")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_Image_SKTelink(Base64:String,docentry:Int,Type:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters : [String: String] = [
            "docentry": "\(docentry)",
            "Base64": "\(Base64)",
            "Type": "\(Type)"
        ]
        //print(parameters)
        provider.request(.mpos_FRT_Image_SKTelink(params:parameters )){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                if let success = json["Success"].bool {
                    if(success){
                        let FileName = json["Data"].string
                        handler(FileName!,"")
                        
                    }else{
                        let message = json["Data"].string
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("",message!)
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    
    class func mpos_FRT_SP_SK_confirm_rcheck(name:String,mail:String,phone:String,docentry:String,handler: @escaping (_ p_status:Int,_ p_messagess:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "shopcode":"\(Cache.user!.ShopCode)",
            "userID":"\(Cache.user!.UserName)",
            "name":"\(name)",
            "mail": "\(mail)",
            "phone":"\(phone)",
            "docentry": "\(docentry)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_confirm_rcheck(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                
                if(success){
                    if let data = json["Data"].array {
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let p_status = data[0]["p_status"].intValue
                        let p_messagess = data[0]["p_messagess"].stringValue
                        handler(p_status,p_messagess,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"","Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"","")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"", error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_SK_Rcheck_insert(name:String,mail:String,phone:String,docentry:String,price:String,xml_pic:String,mota_dienthoai:String,mota_phukien:String,CMND:String,NgayCapCMND:String,NoiCapCMND:String,DiaChiThuongTru:String,DiaChiHienTai:String,SDT_home:String,OTP:String,imei:String,handler: @escaping (_ p_status:Int,_ p_messagess:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "OTP":"\(OTP)",
            "shopcode":"\(Cache.user!.ShopCode)",
            "userID":"\(Cache.user!.UserName)",
            "price":"\(price)",
            "name":"\(name)",
            "mail": "\(mail)",
            "phone":"\(phone)",
            "xml_pic":"\(xml_pic)",
            "docentry":"\(docentry)",
            "mota_dienthoai":"\(mota_dienthoai)",
            "mota_phukien":"\(mota_phukien)",
            "CMND":"\(CMND)",
            "NgayCapCMND":"\(NgayCapCMND)",
            "NoiCapCMND":"\(NoiCapCMND)",
            "DiaChiThuongTru":"\(DiaChiThuongTru)",
            "DiaChiHienTai":"\(DiaChiHienTai)",
            "SDT_home":"\(SDT_home)",
            "imei":"\(imei)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_Rcheck_insert(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                
                if(success){
                    if let data = json["Data"].array {
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let p_status = data[0]["p_status"].intValue
                        let p_messagess = data[0]["p_messagess"].stringValue
                        handler(p_status,p_messagess,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"","Load API ERRO")
                    }
                    
                } else {
                    let message = json["Message"].string
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,message!,"")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"", error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_SK_header_complete_detail(docentry:String,handler: @escaping (_ success:[HeaderCompleteDetailRP],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[HeaderCompleteDetailRP] = []
        let parameters: [String: String] = [
            "docentry":"\(docentry)",
            "userId":"\(Cache.user!.UserName)",
            "mashop":"\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_header_complete_detail(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                let msg = json["Message"].stringValue
                if(success){
                    if let data = json["Data"].array {
                        rs = HeaderCompleteDetailRP.parseObjfromArray(array: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"\(msg)")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_SK_header_complete(keysearch:String,handler: @escaping (_ success:[HeaderCompleteRP],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[HeaderCompleteRP] = []
        let parameters: [String: String] = [
            "keysearch":"\(keysearch)",
            "userId":"\(Cache.user!.UserName)",
            "mashop":"\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_header_complete(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                let msg = json["Message"].stringValue
                if(success){
                    if let data = json["Data"].array {
                        rs = HeaderCompleteRP.parseObjfromArray(array: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"\(msg)")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    
    class func mpos_FRT_SP_SK_confirm_book_order(Type:String,otp:String,docentry:String,xmlpay:String,note:String,imei:String,price:String,phone:String,handler: @escaping (_ p_status:Int,_ p_messagess:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "Type":"\(Type)",
            "UserID":"\(Cache.user!.UserName)",
            "Shopcode":"\(Cache.user!.ShopCode)",
            "otp":"\(otp)",
            "docentry":"\(docentry)",
            "xmlpay":"\(xmlpay)",
            "note":"\(note)",
            "imei": imei,
            "price": price,
            "phone": phone
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_confirm_book_order(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                
                if(success){
                    if let data = json["Data"].array {
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let p_status = data[0]["p_status"].intValue
                        let p_messagess = data[0]["p_messagess"].stringValue
                        handler(p_status,p_messagess,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"","Load API ERRO")
                    }
                    
                } else {
                    let Message = json["Message"].stringValue
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,Message,"")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"", error.localizedDescription)
            }
        }
    }
    
    class func mpos_FRT_SP_SK_cance_order(Docentry:String,Note:String,otp:String,Type:String,phone:String,imei:String,price:Int,name:String,mail:String,handler: @escaping (_ p_status:Int,_ p_messagess:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters = [
            "UserID":"\(Cache.user!.UserName)",
            "ShopCode":"\(Cache.user!.ShopCode)",
            "Docentry":"\(Docentry)",
            "Note":"\(Note)",
            "otp":"\(otp)",
            "Type":"\(Type)",
            "phone":"\(phone)",
            "imei":"\(imei)",
            "price":price,
            "name":"\(name)",
            "mail":"\(mail)"
            
            ] as [String : Any]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_cance_order(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                
                if(success){
                    if let data = json["Data"].array {
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let p_status = data[0]["p_status"].intValue
                        let p_messagess = data[0]["p_messagess"].stringValue
                        handler(p_status,p_messagess,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"","Load API ERRO")
                    }
                    
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"","")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"", error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_SK_view_detail_after_sale_rightphone(Docentry:String,handler: @escaping (_ success:[DetailAfterSaleRP],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[DetailAfterSaleRP] = []
        let parameters: [String: String] = [
            "Docentry":"\(Docentry)",
            "UserID":"\(Cache.user!.UserName)",
            "ShopCode":"\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_view_detail_after_sale_rightphone(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                let msg = json["Message"].stringValue
                if(success){
                    if let data = json["Data"].array {
                        rs = DetailAfterSaleRP.parseObjfromArray(array: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"\(msg)")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_SK_view_image(Docentry:String,handler: @escaping (_ image:[UrlImageRP],_ descriptionRightPhone:[DescriptionRightPhone],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rsImage:[UrlImageRP] = []
        var rsDescription:[DescriptionRightPhone] = []
        let parameters: [String: String] = [
            "docentry":"\(Docentry)",
            "userID":"\(Cache.user!.UserName)",
            "mashop":"\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_view_image(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                let msg = json["Message"].stringValue
                if(success){
                    let data = json["Data"]
                    if(!data.isEmpty){
                        if let image = data["Image"].array {
                            rsImage = UrlImageRP.parseObjfromArray(array: image)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if let description = data["Description"].array {
                                rsDescription = DescriptionRightPhone.parseObjfromArray(array: description)
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(rsImage,rsDescription,"")
                            }else{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(rsImage,rsDescription,"Load API ERRO")
                            }
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rsImage,rsDescription,"Load API ERRO")
                        }
                    }
                    
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rsImage,rsDescription,"\(msg)")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rsImage,rsDescription, error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_SK_nganhang_type(handler: @escaping (_ success:[CardBankRP],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[CardBankRP] = []
        let parameters: [String: String] = [
            
            "userid":"\(Cache.user!.UserName)",
            "mashop":"\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_nganhang_type(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                let msg = json["Message"].stringValue
                if(success){
                    if let data = json["Data"].array {
                        rs = CardBankRP.parseObjfromArray(array: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"\(msg)")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_SK_Send_OTP(sdt:String,docentry:String,handler: @escaping (_ p_status:Int,_ p_messagess:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "userid":"\(Cache.user!.UserName)",
            "mashop":"\(Cache.user!.ShopCode)",
            "sdt":"\(sdt)",
            "docentry":"\(docentry)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_Send_OTP(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                
                if(success){
                    if let data = json["Data"].array {
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let p_status = data[0]["p_status"].intValue
                        let p_messagess = data[0]["p_messagess"].stringValue
                        handler(p_status,p_messagess,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"","Load API ERRO")
                    }
                    
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"","")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"", error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_SK_nganhang(handler: @escaping (_ success:[BankRP],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[BankRP] = []
        let parameters: [String: String] = [
            
            "userid":"\(Cache.user!.UserName)",
            "mashop":"\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_nganhang(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                let msg = json["Message"].stringValue
                if(success){
                    if let data = json["Data"].array {
                        rs = BankRP.parseObjfromArray(array: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"\(msg)")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_SK_load_tinh(handler: @escaping (_ success:[ProvinceRightPhone],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[ProvinceRightPhone] = []
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_load_tinh(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                let msg = json["Message"].stringValue
                if(success){
                    if let data = json["Data"].array {
                        rs = ProvinceRightPhone.parseObjfromArray(array: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"\(msg)")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_SK_TaoPhieuRcheck(Imei:String,phone:String,mail:String,name:String,TenSP:String,NhanDT:String,mausac:String,xmlpay:String,handler: @escaping (_ p_status:Int,_ p_messagess:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "userID":"\(Cache.user!.UserName)",
            "shopcode":"\(Cache.user!.ShopCode)",
            "Imei":"\(Imei)",
            "phone":"\(phone)",
            "mail":"\(mail)",
            "name":"\(name)",
            "TenSP":"\(TenSP)",
            "NhanDT":"\(NhanDT)",
            "mausac":"\(mausac)",
            "xmlpay":"\(xmlpay)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_TaoPhieuRcheck(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                
                if(success){
                    if let data = json["Data"].array {
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let p_status = data[0]["p_status"].intValue
                        let p_messagess = data[0]["p_messagess"].stringValue
                        handler(p_status,p_messagess,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"","Load API ERRO")
                    }
                    
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"","")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"", error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_SK_Load_TienRcheck(handler: @escaping (_ success:Int,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:Int = 0
        let parameters: [String: String] = [
            
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_Load_TienRcheck(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                let msg = json["Message"].stringValue
                if(success){
                    if let data = json["Data"].array {
                        rs = data[0]["tien"].intValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"\(msg)")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0, error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_SK_confirm_upanh_xacnhan(Docentry:String,url_image:String,handler: @escaping (_ p_status:Int,_ p_messagess:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "Docentry":"\(Docentry)",
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)",
            "url_image":"\(url_image)"
            
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_confirm_upanh_xacnhan(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                
                if(success){
                    if let data = json["Data"].array {
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let p_status = data[0]["p_status"].intValue
                        let p_messagess = data[0]["p_messagess"].stringValue
                        handler(p_status,p_messagess,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"","Load API ERRO")
                    }
                    
                } else {
                    let message = json["Message"].string
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,message!,"")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"", error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_SK_update_info(Docentry:String,email:String,handler: @escaping (_ p_status:Int,_ p_messagess:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "docentry":"\(Docentry)",
            "userid":"\(Cache.user!.UserName)",
            "mashop":"\(Cache.user!.ShopCode)",
            "email":"\(email)"
            
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_update_info(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                
                if(success){
                    if let data = json["Data"].array {
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let p_status = data[0]["p_status"].intValue
                        let p_messagess = data[0]["p_messagess"].stringValue
                        handler(p_status,p_messagess,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"","Load API ERRO")
                    }
                    
                } else {
                    let message = json["Message"].string
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,message!,"")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"", error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_SK_load_header(keysearch:String,handler: @escaping (_ success:[ItemRPOnProgress],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[ItemRPOnProgress] = []
        let parameters: [String: String] = [
            "keysearch":"\(keysearch)",
            "userId":"\(Cache.user!.UserName)",
            "mashop":"\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_load_header(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                let msg = json["Message"].stringValue
                if(success){
                    if let data = json["Data"].array {
                        rs = ItemRPOnProgress.parseObjfromArray(array: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"\(msg)")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    class func Tintuc_detail_baiviet(id: String ,handler: @escaping (_ successData:[Sumary_TinTuc], _ successInclude:[Include_Tintuc],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rsData:[Sumary_TinTuc]? = nil
        var rsInclude:[Include_Tintuc]? = nil
        let parameters: [String: String] = [
            "sort":"-created,uid.name".encodeString(),
            "include": "field_hinh_chu_de,field_hinh_chu_de.image,field_media,field_media.image,field_media.field_document".encodeString(),
            "fields[media--image]": "name,status,metatag,path".encodeString(),
            "fields[media--document]": "name,status,metatag,path".encodeString(),
            "fields[file--file]":"uri,url".encodeString(),
            "filter[id]":"\(id)"
        ]
        print(parameters)
        provider.request(.Tintuc_detail_baiviet(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    
                    let mData = json["data"].array
                    let mInclude = json["included"].array
                    rsData = Sumary_TinTuc.parseObjfromArray(array: mData ?? [])
                    rsInclude = Include_Tintuc.parseObjfromArray(array: mInclude ?? [])
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rsData ?? [], rsInclude ?? [], "")
                    
                } catch (let error){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], [], error.localizedDescription)
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], [], error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_list_PMHThayThePK_ecom(itemcode:String,handler: @escaping (_ success:[PMHThayThePKEcom],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[PMHThayThePKEcom] = []
        let parameters: [String: String] = [
            "itemcode":"\(itemcode)",
            "shopcode":"\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_list_PMHThayThePK_ecom(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                let success = json?["Success"].boolValue
                let msg = json?["Message"].stringValue
                if(success ?? false){
                    if let data = json!["Data"].array {
                        rs = PMHThayThePKEcom.parseObjfromArray(array: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"\(msg ?? "Load API ERROR")")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    class func checkpromotionfrtBaoHiem(handler: @escaping (_ p_status:Int,_ p_messagess:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            
            "usercode":"\(Cache.user!.UserName)"
        ]
        print(parameters)
        provider.request(.checkpromotionfrtBaoHiem(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                
                if(success){
                    let data = json["Data"]
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let p_status = data["p_status"].intValue
                    let p_messagess = data["p_messages"].stringValue
                    handler(p_status,p_messagess,"")
                    
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"", error.localizedDescription)
            }
        }
    }
    class func mpos_CheckEmail_Vendor_SendOTP(vendorcode:String,idcard:String,phonenumber:String,email:String,idcardcode:String,handler: @escaping (_ p_status:Int,_ p_messagess:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
      
        let parameters: [String: String] = [
            
            "vendorcode":"\(vendorcode)",
            "idcard":"\(idcard)",
            "phonenumber":"\(phonenumber)",
            "email":"\(email)",
            "userid":"\(Cache.user!.UserName)",
            "idcardcode":"\(idcardcode)"
        ]
      
        
        provider.request(.mpos_CheckEmail_Vendor_SendOTP(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                
              
                let success = json?["success"].boolValue
                
                if(success ?? false){
                    let data = json!["Data"]
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let p_status = data["p_status"].intValue
                    let p_messagess = data["p_mess"].stringValue
                    handler(p_status,p_messagess,"")
                    
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"", error.localizedDescription)
            }
        }
    }
    class func getTinTuc_New(limit: String, handler: @escaping (_ success:[LoaiTinItem],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "limit":"\(limit)"
        ]
        provider.request(.getTinTuc_New(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    if let json = try JSON(data: data).array {
                        print(json)
                        let rs = LoaiTinItem.parseObjfromArray(array: json)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler([], "API ERROR!")
                    }
                } catch (let error){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_MayCuEcom_UploadImage(base64:String, handler: @escaping (_ fileImgName: String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "base64":"\(base64)"
        ]
        debugPrint(parameters)
        provider.request(.mpos_FRT_MayCuEcom_UploadImage(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let FileName = json["FileName"].stringValue
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(FileName,"")
                } catch (let error){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("", error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_MayCuEcom_GetHinhMau(itemcode:String, handler: @escaping (_ success: [HinhMauMayCu],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "itemcode":"\(itemcode)"
        ]
        debugPrint(parameters)
        provider.request(.mpos_FRT_MayCuEcom_GetHinhMau(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let success = json["Success"].boolValue
                    if(success){
                        let mData = json["Data"]
                        if let jsonListHinhMau = mData["listImg_Model"].array {
                            let rs = HinhMauMayCu.parseObjfromArray(array: jsonListHinhMau)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        } else {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler([],"API error!")
                        }
                        
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler([],"get api fail!")
                    }
                } catch (let error){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], error.localizedDescription)
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], error.localizedDescription)
            }
        }
    }
    class func CreateOrderForMobileSmartPay(amount:String,phoneNumber:String,requestType:String,xmrdr1:String,promotionCode:String,handler: @escaping (_ success:SmartPayQRCode?,_ requestId:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        var rs:SmartPayQRCode? = nil
        let parameters: [String: String] = [
            "amount": "\(amount)",
            "phoneNumber": "\(phoneNumber)",
            "requestType": "\(requestType)",
            "usercode": "\(Cache.user!.UserName)",
            "shopcode": "\(Cache.user!.ShopCode)",
            "xmlrdr1":"\(xmrdr1)",
            "promotionCode":"\(promotionCode)"
        ]
        log.debug(parameters)
        provider.request(.CreateOrderForMobile(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                let success = json["code"].stringValue
                
                if(success == "OK"){
                    let data = json["data"]
                    let requestId = json["requestId"].stringValue
                    if(!data.isEmpty){
                        
                        rs = SmartPayQRCode.getObjFromDictionary(data: data)
                        handler(rs,requestId,"")
                    }else{
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,requestId,"")
                    }
                } else {
                    if let message = json["message"].string {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"",message)
                    }
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"",success)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,"", error.localizedDescription)
            }
        }
    }
    class func QueryOrderSmartPay(orderNo:String,handler: @escaping (_ success:SmartPayOrder?,_ requestId:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        var rs:SmartPayOrder? = nil
        let parameters: [String: String] = [
            "orderNo": "\(orderNo)",
            "usercode": "\(Cache.user!.UserName)",
            "shopcode": "\(Cache.user!.ShopCode)"
            
        ]
        log.debug(parameters)
        provider.request(.QueryOrderSmartPay(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                let success = json["code"].stringValue
                
                if(success == "OK"){
                    let data = json["data"]
                    let requestId = json["requestId"].stringValue
                    if(!data.isEmpty){
                        
                        rs = SmartPayOrder.getObjFromDictionary(data: data)
                        handler(rs,requestId,"")
                    }else{
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,requestId,"")
                    }
                } else {
                    let message = json["message"].stringValue
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"",message)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,"", error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_SK_Load_default_imei(Imei:String,handler: @escaping (_ success:[DefaultImeiRightPhone],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[DefaultImeiRightPhone] = []
        let parameters: [String: String] = [
            "Imei":"\(Imei)",
            "UserID":"\(Cache.user!.UserName)",
            "MaShop":"\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_SP_SK_Load_default_imei(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                let msg = json["Message"].stringValue
                if(success){
                    if let data = json["Data"].array {
                        rs = DefaultImeiRightPhone.parseObjfromArray(array: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"\(msg)")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    class func Products_Demo_Warranty_ListProduct(status: String, handler: @escaping (_ success:[ProductDemoBH],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "status":"\(status)",
            "shopcode":"\(Cache.user!.ShopCode)"
        ]
        debugPrint(parameters)
        provider.request(.Products_Demo_Warranty_ListProduct(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let success = json["Success"].boolValue
                    if(success){
                        if let data = json["Data"].array {
                            let rs = ProductDemoBH.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler([],"Load API ERRO")
                        }
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler([],"Load API ERRO")
                    }
                } catch (let error){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], error.localizedDescription)
            }
        }
    }
    class func Products_Demo_Warrant_Product_Type_ImageAndError(type_item: String, handler: @escaping (_ rsListImage:[ImageMayDemoBH], _ rsListError: [ErrorItemMayDemoBH],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "type_item":"\(type_item)"
        ]
        debugPrint(parameters)
        provider.request(.Products_Demo_Warrant_Product_Type_ImageAndError(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    debugPrint(json)
                    let mData = json["Data"]
                    let jsonListImg = mData["lst_image"].arrayValue
                    let jsonListError = mData["lst_error"].arrayValue
                    let rsImg = ImageMayDemoBH.parseObjfromArray(array: jsonListImg)
                    let rsError = ErrorItemMayDemoBH.parseObjfromArray(array: jsonListError)
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rsImg, rsError, "")
                } catch (let error){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], [], error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], [], error.localizedDescription)
            }
        }
    }
    class func Products_Demo_Warranty_Update(id: String, xmlimage: String, list_type_error: String, warranty_code: String, handler: @escaping (_ resultCode:Int,_ messages: String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "id":"\(id)",
            "xmlimage":"\(xmlimage)",
            "list_type_error":"\(list_type_error)",
            "user_id":"\(Cache.user!.UserName)",
            "warranty_code":"\(warranty_code)"
        ]
        debugPrint(parameters)
        provider.request(.Products_Demo_Warranty_Update(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let success = json["Success"].boolValue
                    if(success){
                        let mData = json["Data"]
                        let rsCode = mData["result"].intValue
                        let msg = mData["messages"].string
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rsCode, msg ?? "Cập nhật thành công!","")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0, "","Load API ERRO")
                    }
                } catch (let error){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0, "", error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0, "", error.localizedDescription)
            }
        }
    }
    class func Products_Demo_Upload_Image_May_Demo(itemcode: String, base64: String, type_image: String, handler: @escaping (_ success:Bool,_ mData: String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "itemcode":"\(itemcode)",
            "base64":"\(base64)",
            "type_image":"\(type_image)"
        ]
        debugPrint(parameters)
        provider.request(.Products_Demo_Upload_Image_May_Demo(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let success = json["Success"].boolValue
                    let mData = json["Data"].stringValue
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(success, mData,"")
                } catch (let error){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(false, "", error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(false, "", error.localizedDescription)
            }
        }
    }
    class func Products_Demo_Warranty_Product_GetDetailsItem(id: String, handler: @escaping (_ rsListImage:[ImageMayDemoBH], _ rsListErrorID: String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "id":"\(id)"
        ]
        debugPrint(parameters)
        provider.request(.Products_Demo_Warranty_Product_GetDetailsItem(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let success = json["Success"].boolValue
                    if(success){
                        let mData = json["Data"]
                        let listErrorID = mData["lst_error"].stringValue
                        let jsonRSImg = mData["lst_image"].arrayValue
                        let rsImg = ImageMayDemoBH.parseObjfromArray(array: jsonRSImg)
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rsImg, listErrorID,"")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler([], "","Load API ERRO")
                    }
                } catch (let error){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], "", error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], "", error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_check_VC_crm(voucher:String,sdt:String,doctype:String,handler: @escaping (_ p_status:Int,_ p_messagess:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters: [String: String] = [
            "voucher":"\(voucher)",
            "sdt":"\(sdt)",
            "UserID":"\(Cache.user!.UserName)",
            "Mashop":"\(Cache.user!.ShopCode)",
            "doctype":"\(doctype)"
        ]
        log.debug(parameters)
        provider.request(.mpos_FRT_SP_check_VC_crm(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                let success = json["success"].boolValue
                
                if(success){
                    let data = json["data"]
                    if(!data.isEmpty){
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let p_status = data["p_status_otp"].intValue
                        let p_messagess = data["messagess"].stringValue
                        handler(p_status,p_messagess,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"","Load API ERROR")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"","Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"", error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_check_otp_VC_CRM(voucher:String,sdt:String,doctype:String,otp:String,handler: @escaping (_ p_status:Int,_ p_messagess:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters: [String: String] = [
            "voucher":"\(voucher)",
            "sdt":"\(sdt)",
            "UserID":"\(Cache.user!.UserName)",
            "Mashop":"\(Cache.user!.ShopCode)",
            "doctype":"\(doctype)",
            "otp":"\(otp)"
        ]
        log.debug(parameters)
        provider.request(.mpos_FRT_SP_check_otp_VC_CRM(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                let success = json["success"].boolValue
                
                if(success){
                    let data = json["data"]
                    if(!data.isEmpty){
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let p_status = data["p_status"].intValue
                        let p_messagess = data["p_messages"].stringValue
                        handler(p_status,p_messagess,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"","Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"","")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,"", error.localizedDescription)
            }
        }
    }
    class func CustomerResult_HDItel(p_HopDongSo:String,p_TenKH: String,p_CMND_KH:String,p_NgayCapCMND_KH:String,p_NoiCapCMND_KH:String,p_NgaySinh_KH:String,p_GioiTinh_KH:String,p_QuocGia_KH:String,p_NoiThuongTru_KH:String,p_ChuKy:String,p_SoThueBao_Line1:String,p_SoICCID_Line1:String,p_GoiCuoc_Line1:String,p_SoDTLienHe:String,handler: @escaping ( _ success:SimAutoImage?, _ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var param:Dictionary = Dictionary<String, Any>()
        
        param.updateValue(p_HopDongSo, forKey: "p_HopDongSo")
        param.updateValue(p_TenKH, forKey: "p_TenKH")
        param.updateValue(p_CMND_KH, forKey: "p_CMND_KH")
        param.updateValue(p_NgayCapCMND_KH, forKey: "p_NgayCapCMND_KH")
        
        param.updateValue(p_NoiCapCMND_KH, forKey: "p_NoiCapCMND_KH")
        param.updateValue(p_NgaySinh_KH, forKey: "p_NgaySinh_KH")
        param.updateValue(p_GioiTinh_KH, forKey: "p_GioiTinh_KH")
        param.updateValue(p_QuocGia_KH, forKey: "p_QuocGia_KH")
        param.updateValue(p_NoiThuongTru_KH, forKey: "p_NoiThuongTru_KH")
        param.updateValue("\(Cache.user!.ShopCode)", forKey: "p_MaDiemGD")
        
        param.updateValue("\(Cache.user!.ShopName)", forKey: "p_TenDiemGiaoDich")
        param.updateValue("\(Cache.user!.EmployeeName)", forKey: "p_NVGiaoDich")
        param.updateValue("\(Cache.user!.ShopName)", forKey: "p_DCGiaoDich")
        param.updateValue(p_ChuKy, forKey: "p_ChuKy")
        param.updateValue(p_SoThueBao_Line1, forKey: "p_SoThueBao_Line1")
        param.updateValue(p_SoICCID_Line1, forKey: "p_SoICCID_Line1")
        param.updateValue(p_GoiCuoc_Line1, forKey: "p_GoiCuoc_Line1")
        param.updateValue(p_SoDTLienHe, forKey: "p_SoDTLienHe")
        
        var imageInfo:SimAutoImage? = nil
        provider.request(.CustomerResult_HDItel(params:param)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                let data1 = json["CustomerResult_HDItelecom"]
                
                if(!data1.isEmpty){
                    imageInfo = SimAutoImage.getObjFromDictionary(data: data1)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(imageInfo,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(imageInfo,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(imageInfo,error.localizedDescription)
            }
        }
    }
    //search bank
    class func mpos_FRT_SMS_Banking_GetSMS(handler: @escaping (_ success:[SMS_Banking],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        var rs:[SMS_Banking] = []
        let parameters: [String: String] = [
            "shopcode":"\(Cache.user!.ShopCode)",
            "usercode":"\(Cache.user!.UserName)"
        ]
        log.debug(parameters)
        provider.request(.mpos_FRT_SMS_Banking_GetSMS(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                let success = json?["Success"].boolValue
                if(success ?? false){
                    if let data = json?["Data"].array {
                        rs = SMS_Banking.parseObjfromArray(array: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"LOAD API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_SP_GetCode_QRcode_payment(RDR1:String,PROMOS:String,Doctotal:String,type:String,typeOrder:String,handler: @escaping (_ codeQrcode:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters: [String: String] = [
            "userID":"\(Cache.user!.UserName)",
            "mashop":"\(Cache.user!.ShopCode)",
            "RDR1":"\(RDR1)",
            "PROMOS":"\(PROMOS)",
            "Doctotal": "\(Doctotal)",
            "type": "\(type)",
            "typeOrder":"\(typeOrder)"
        ]
        debugPrint(parameters)
        log.debug(parameters)
        
        provider.request(.mpos_FRT_SP_GetCode_QRcode_payment(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                debugPrint(json)
                log.debug(json)
                
                let success = json["success"].boolValue
                
                if(success){
                    let data = json["data"]
                    if(!data.isEmpty){
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let codeQrcode = data["Codeqrcode"].stringValue
                        
                        handler(codeQrcode,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("","Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("", error.localizedDescription)
                
                
            }
        }
    }
    
    class func mpos_FRT_SP_GetCode_QRcode_payment_Airpay(amount: Int,handler: @escaping (_ codeQrcode:AirpayResponse?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters: [String: Any] = [
            "usercode": Cache.user!.UserName,
            "shopcode":Cache.user!.ShopCode,
            "amount":amount
        ]
        debugPrint(parameters)
        log.debug(parameters)
        
        provider.request(.mpos_FRT_SP_GetCode_QRcode_payment_Airpay(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                let err = AirpayError.getObjFromDictionary(data: json["error"])
                if err.message.trim() != "" && err.message.trim() != "null" {
                    handler(nil,err.message)
                } else {
                    let sucess = AirpayResponse.getObjFromDictionary(data: json)
                    handler(sucess,"")
                }
                
                debugPrint(json)
                log.debug(json)
                
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
                
                
            }
        }
    }
    
    class func CheckStatusAirPay(orderId: String,handler: @escaping (_ status:AirpayStatus?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters: [String: Any] = [
            "usercode": Cache.user!.UserName,
            "shopcode":Cache.user!.ShopCode,
            "orderId": orderId,
            "StoreLocation": AirpayResponse.storeLocation,
            "traceId": AirpayResponse.traceId,
            "transactionType": AirpayResponse.transactionType,
            "amount":AirpayResponse.amount
        ]
        debugPrint(parameters)
        log.debug(parameters)
        
        provider.request(.mpos_FRT_SP_GetCode_QRcode_payment_AirpayStatus(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                let statusRes = AirpayStatus.getObjFromDictionary(data: json)
                if statusRes.messages.lowercased() == "successful" {
                    handler(statusRes,"")
                } else {
                    if json["error"]["details"].description.lowercased() != "" && json["error"]["details"].description.lowercased() != "null"  {
                        handler(nil,json["error"]["details"].description)
                    } else {
                        handler(nil,"Load Api error")
                    }
                }
                
                debugPrint(json)
                log.debug(json)
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
    
	class func mpos_FRT_SP_GetCode_QRcode_payment_Foxpay(customerCode: String, customerName: String, customerPhone: String, address: String, amount: Int,promotionCode:String, handler: @escaping (_ codeQrcode: AirpayResponse?, _ error:String) -> Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters: [String: Any] = [
            "provider": "Foxpay",
            "userCode": Cache.user!.UserName,
            "shopCode": Cache.user!.ShopCode,
            "customerCode": customerCode,
            "customerPhone": customerPhone,
            "customerName": customerName,
            "customerAddress": address,
            "amount": amount,
            "promotionCode": promotionCode,
            "description": "",
            "paymentMethod": "CASH",
            "requestType": "4",
            "deviceType": "iOS",
            "appVersion": Common.myCustomVersionApp()!
        ]
        
        debugPrint(parameters)
        log.debug(parameters)
        
        provider.request(.mpos_FRT_SP_GetCode_QRcode_payment_Foxpay(params: parameters)) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                let err = AirpayError.getObjFromDictionary(data: json["error"])
                if err.message.trim() != "" && err.message.trim() != "null" {
                    handler(nil,err.message)
                } else {
                    let sucess = AirpayResponse.getObjFromDictionary(data: json)
                    handler(sucess,"")
                }
                
                debugPrint(json)
                log.debug(json)
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
    
    class func CheckStatusFoxPay(orderId: String, handler: @escaping (_ status: FoxpayStatus?, _ error: String) -> Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters: [String: Any] = [
            "usercode": Cache.user!.UserName,
            "shopcode": Cache.user!.ShopCode,
            "orderId": orderId
        ]
        debugPrint(parameters)
        log.debug(parameters)
        
        provider.request(.mpos_FRT_SP_GetCode_QRcode_payment_FoxpayStatus(params: parameters)) { result in
            switch result {
            case let .success(moyaResponse):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                
                let err = AirpayError.getObjFromDictionary(data: json["error"])
                if err.message.trim() != "" && err.message.trim() != "null" {
                    handler(nil, err.message)
                } else {
                    let sucess = FoxpayStatus.getObjFromDictionary(data: json)
                    handler(sucess, "")
                }
                
                debugPrint(json)
                log.debug(json)
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
    
    class func mpos_FRT_SP_VC_get_list_voucher_by_phone(phonenumber:String,handler: @escaping (_ success:[VoucherNoPrice],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        var rs:[VoucherNoPrice] = []
        let parameters: [String: String] = [
            "userID":"\(Cache.user!.UserName)",
            "mashop":"\(Cache.user!.ShopCode)",
            "cardcode": "0",
            "phonenumber":"\(phonenumber)"
        ]
        log.debug(parameters)
        provider.request(.mpos_FRT_SP_VC_get_list_voucher_by_phone(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let success = json["success"].boolValue
                if(success){
                    if let data = json["data"].array {
                        rs = VoucherNoPrice.parseObjfromArray(array: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"LOAD API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_ActiveSim_VNM_Swap_Info_GetData(handler: @escaping (_ success:[HistoryUpdateVNM],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[HistoryUpdateVNM] = []
        let parameters: [String: String] = [
            
            "shopcode":"\(Cache.user!.ShopCode)",
            "usercode":"\(Cache.user!.UserName)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_ActiveSim_VNM_Swap_Info_GetData(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                
                if(success){
                    if let data = json["Data"].array {
                        rs = HistoryUpdateVNM.parseObjfromArray(array: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    class func mpos_sp_Order_getSOdetails(Docentry: String, handler: @escaping (_ rsLine_VC_NoPrice:[Line_VC_NoPrice],_ rsLineProduct:[LineProduct],_ rsLinePromos:[LinePromos],_ rsLineORCT:[LineORCT],_ rsLineVoucher:[LineVoucher],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var rsLine_VC_NoPrice:[Line_VC_NoPrice] = []
        var rsLineProduct:[LineProduct] = []
        var rsLinePromos:[LinePromos] = []
        var rsLineORCT:[LineORCT] = []
        var rsLineVoucher:[LineVoucher] = []
        
        let parameters: [String: String] = [
            "Docentry":"\(Docentry)",
            "userid":"\(Cache.user!.UserName)",
            "tokenapi":"\(Cache.user!.Token)"
        ]
        print(parameters)
        provider.request(.mpos_sp_Order_getSOdetails(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let success = json["Success"].boolValue
                    let msg = json["Message"].string
                    if(success){
                        let mdata = json["Data"]
                        let arrVCNoPrice = mdata["Line_VC_NoPrice"].array ?? []
                        let arrProduct = mdata["Lines"].array ?? []
                        let arrPromos = mdata["LinePromos"].array ?? []
                        let arrORCT = mdata["LineORCT"].array ?? []
                        let arrVoucher = mdata["LineVoucher"].array ?? []
                        
                        rsLine_VC_NoPrice = Line_VC_NoPrice.parseObjfromArray(array: arrVCNoPrice)
                        rsLineProduct = LineProduct.parseObjfromArray(array: arrProduct)
                        rsLinePromos = LinePromos.parseObjfromArray(array: arrPromos)
                        rsLineORCT = LineORCT.parseObjfromArray(array: arrORCT)
                        rsLineVoucher = LineVoucher.parseObjfromArray(array: arrVoucher)
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rsLine_VC_NoPrice, rsLineProduct, rsLinePromos, rsLineORCT, rsLineVoucher,"")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler([], [], [], [], [], msg ?? "Load API ERRO")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], [], [], [], [], error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], [], [], [], [], error.localizedDescription)
            }
        }
    }
    class func GetPayTeleChargeVTInfo(DocEntry:String,PhoneNumber:String,SubId:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        
        let parameters: [String: String] = [
            "DocEntry":"\(DocEntry)",
            "PhoneNumber":"\(PhoneNumber)",
            "SubId": "\(SubId)"
        ]
        log.debug(parameters)
        provider.request(.GetPayTeleChargeVTInfo(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let success = json["Success"].boolValue
                if(success){
                    let data = json["Data"]
                    if(!data.isEmpty){
                        let code = data["error_code"].stringValue
                        handler(code,"")
                    }else{
                        handler("","LOAD API ERROR")
                    }
                    
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","LOAD API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("", error.localizedDescription)
            }
        }
    }
    class func ViettelPay_RegisterAuthority(ServiceCode: String, BillingCode: String, Msisdn: String, handler: @escaping (_ success:RegisterAuthorityViettelTS?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "ServiceCode": "\(ServiceCode)",
            "BillingCode": "\(BillingCode)",
            "Msisdn": "\(Msisdn)",
            "UserCode": "\(Cache.user!.UserName)",
            "ShopCode": "\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.ViettelPay_RegisterAuthority(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    
                    let mData = RegisterAuthorityViettelTS.getObjFromDictionary(data: json)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(mData,"")
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
    class func ViettelPay_ConfirmAuthority(ServiceCode: String, BillingCode: String, Otp: String, handler: @escaping (_ success:RegisterAuthorityViettelTS?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "ServiceCode": "\(ServiceCode)",
            "BillingCode": "\(BillingCode)",
            "Otp": "\(Otp)",
            "UserCode": "\(Cache.user!.UserName)",
            "ShopCode": "\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.ViettelPay_ConfirmAuthority(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let mData = RegisterAuthorityViettelTS.getObjFromDictionary(data: json)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(mData,"")
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
    class func ViettelPay_GetPayTeleCharge(ServiceCode: String, BillingCode: String, handler: @escaping (_ success:GetPayTeleChargeViettelTS?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "ServiceCode": "\(ServiceCode)",
            "BillingCode": "\(BillingCode)",
            "SubId": "23",
            "UserCode": "\(Cache.user!.UserName)",
            "ShopCode": "\(Cache.user!.ShopCode)",
            "ShopAddress": "\(Cache.user!.Address)",
            "Device": "2",
            "Version": "\(Common.versionApp())"
        ]
        print(parameters)
        provider.request(.ViettelPay_GetPayTeleCharge(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let mData = GetPayTeleChargeViettelTS.getObjFromDictionary(data: json)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(mData,"")
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
    class func ViettelPay_PayTeleCharge(OrderId: String, OriginalTransId: String, ServiceCode: String, BillingCode: String, FullName: String, Amount: String, XmlStringPay: String, handler: @escaping (_ success:GetPayTeleChargeViettelTS?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "OrderId": "\(OrderId)",
            "OriginalTransId": "\(OriginalTransId)",
            "ServiceCode": "\(ServiceCode)",
            "BillingCode": "\(BillingCode)",
            "FullName": "\(FullName)",
            "XmlStringPay": "\(XmlStringPay)",
            "Amount": "\(Amount)",
            "SubId": "23",
            "UserCode": "\(Cache.user!.UserName)",
            "ShopCode": "\(Cache.user!.ShopCode)",
            "ShopAddress": "\(Cache.user!.Address)",
            "Version": "\(Common.versionApp())"
        ]
        print(parameters)
        provider.request(.ViettelPay_PayTeleCharge(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let mData = GetPayTeleChargeViettelTS.getObjFromDictionary(data: json)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(mData,"")
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
    class func THSmartPay_CheckInfo(contractNo: String, providerCode: String, handler: @escaping (_ success:CheckInfoTHSmartPay?,_ rsCode: String,_ msg: String?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "contractNo": "\(contractNo)",
            "providerCode": "\(providerCode)",
            "usercode": "\(Cache.user!.UserName)",
            "shopcode": "\(Cache.user!.ShopCode)",
        ]
        print(parameters)
        provider.request(.THSmartPay_CheckInfo(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
//                let json = try! JSON(data: data)
//                print(json)
//                let mData = json["data"]
//                let mDataCode = json["code"].stringValue
//                let msg = json["message"].stringValue
//
//                let rs = CheckInfoTHSmartPay.getObjFromDictionary(data: mData)
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                handler(rs, mDataCode, msg, "")
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let mData = json["data"]
                    let mDataCode = json["code"].stringValue
                    let msg = json["message"].stringValue

                    let rs = CheckInfoTHSmartPay.getObjFromDictionary(data: mData)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs, mDataCode, msg, "")
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil, "", "", error.localizedDescription)
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, "", "", error.localizedDescription)
            }
        }
    }
    class func THSmartPay_RepaymentForMobile(partnerCode: String, providerCode: String, providerName: String, serviceCode: String, serviceName: String, contractNo: String, customerName: String, amount: String, xmlstringpay: String, customerPhone: String, idCardNumber: String, overdueAmount: String, minAmount: String, handler: @escaping (_ requestId: String,_ transId: String,_ rsCode: String,_ voucher: RepaySmartpayVoucher?,_ msg: String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "partnerCode": "\(partnerCode)",
            "providerCode": "\(providerCode)",
            "providerName": "\(providerName)",
            "serviceCode": "\(serviceCode)",
            "serviceName": "\(serviceName)",
            "contractNo": "\(contractNo)",
            "customerName": "\(customerName)",
            "amount": "\(amount)",
            "overdueAmount": "\(overdueAmount)",
            "minAmount": "\(minAmount)",
            "xmlstringpay": "\(xmlstringpay)",
            "customerPhone": "\(customerPhone)",
            "idCardNumber": "\(idCardNumber)",
            "branch": "\(Cache.user!.ShopName)",
            "usercode": "\(Cache.user!.UserName)",
            "shopcode": "\(Cache.user!.ShopCode)",
            "deviceType": "2",
            "version": "\(Common.versionApp())"
        ]
        print(parameters)
        provider.request(.THSmartPay_RepaymentForMobile(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
//                let json = try! JSON(data: data)
//                print(json)
//                let mData = json["data"]
//                let requestId = mData["requestId"].stringValue
//                let transId = mData["transId"].stringValue
//                
//                let mDataCode = json["code"].stringValue
//                let msg = json["message"].string
//                let voucherJson = json["voucher"]
//                let rsVoucher = RepaySmartpayVoucher.getObjFromDictionary(data: voucherJson)
//                
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                handler(requestId, transId, mDataCode, rsVoucher, msg ?? "", "")
                
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let mData = json["data"]
                    let requestId = mData["requestId"].stringValue
                    let transId = mData["transId"].stringValue
                    
                    let mDataCode = json["code"].stringValue
                    let msg = json["message"].string
                    let voucherJson = json["voucher"]
                    let rsVoucher = RepaySmartpayVoucher.getObjFromDictionary(data: voucherJson)
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(requestId, transId, mDataCode, rsVoucher, msg ?? "", "")
                    
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", "", "", nil, "", error.localizedDescription)
                }

                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("", "", "", nil, "", error.localizedDescription)
            }
        }
    }
    class func sp_FRTCallLog_Web_BrowserPaymentRequest_GetOrganizationHierachies(handler: @escaping (_ success:[RequestPaymentShop],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[RequestPaymentShop] = []
        provider.request(.sp_FRTCallLog_Web_BrowserPaymentRequest_GetOrganizationHierachies){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    if let suc = json["Success"].bool {
                        if(suc){
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if let data = json["Data"].array {
                                rs = RequestPaymentShop.parseObjfromArray(array: data)
                                handler(rs,"")
                            }else{
                                handler(rs,"Load API ERRO")
                            }
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func sp_FRT_Web_BrowserPaymentRequest_GetThue(handler: @escaping (_ success:[TaxHDThueNha],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[TaxHDThueNha] = []
        provider.request(.sp_FRT_Web_BrowserPaymentRequest_GetThue){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    if let suc = json["Success"].bool {
                        if(suc){
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if let data = json["Data"].array {
                                rs = TaxHDThueNha.parseObjfromArray(array: data)
                                handler(rs,"")
                            }else{
                                handler(rs,"Load API ERRO")
                            }
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func checkTransactionMocaByItemCode(SanPhamXML: String,handler: @escaping (_ success:Int,_ messages:String,_ error:String) ->Void){
        ProgressView.shared.show()
        let provider = MoyaProvider<MPOSAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "UserCode":Cache.user!.UserName,
            "SanPhamXML":SanPhamXML
        ]
        print(parameters)
        provider.request(.checkTransactionMocaByItemCode(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Result"].int {

                    if let mess = json?["Mess"].string{
                        //Note : Result = 1 => app default số tiền thanh toán bằng tổng tiền đơn hàng (không cho nhập lại)
                        //Result = 0 => cho nhập như cũ
                        //Result = -1 => lỗi
                        if success == 1{
                            handler(success,mess,"Load API ERRO")
                            ProgressView.shared.hide()
                        }else if success == 0{
                            handler(success,mess,"Load API ERRO")
                            ProgressView.shared.hide()

                        }else {
                            handler(success,mess,"Load API ERRO")
                            ProgressView.shared.hide()
                        }
                    }
                }else{
                    handler(-1,"","Load API ERRO")
                    ProgressView.shared.hide()
                }
                ProgressView.shared.hide()
            case let .failure(error):
                ProgressView.shared.hide()
                handler(-1,"",error.localizedDescription)
            }
        }
    }
}

