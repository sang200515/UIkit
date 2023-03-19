//
//  Cache.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/25/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct Cache{
    static var codevnpay: String =  ""
    static var is_DH_DuAn:String = "N"
    static var khoanvay:Int = 0
    static var is_samsung:Int = 0
    static var INSIDE_URL:String = "https://insidenew.fptshop.com.vn"
    static var is_KHRotTG:Int = 0
    static var is_getaway:Int = 1
    static var SO_POS:Int = 0
    static var IdentityCard:String = ""
    static var IDFinancier:String = ""
    static var period:Int = 0
    static var LaiSuat:Float = 0
    static var SoTienTraTruocCache:Int = 0
    static var NumberContract:String = ""
    static var DocEntryEcomCache:Int = 0
    static var unconfirmationReasons: [UnconfirmationReasons] = []
    //THECAO
    static var ruleMenus:[RuleMenu] = []
    static var versionApps:[VersionApp] = []
    static var itemPriceCardTopup:ItemPrice?
    static var listVoucherCardTopup:[CheckVoucherResult] = []
    static var typeCashPaymentCardTopup:Bool = false
    static var typeCardPaymentCardTopup:Bool = false
    static var ValuePromotionCardTopup:Int = 0
    static var quantityValueCardTopup:Int = 0
    static var phoneCardTopup:String = ""
    static var typeCardTopup:Int = 0
    static var cashValueCardTopup:Int = 0
    static var cardValueCardTopup:Int = 0
    static var payooPayCodeResult:PayooPayCodeResult?
    static var payooPayCodeHeaderResult:PayooPayCodeHeaderResult?
    static var theCaoVietNamMobile:TheCao_VietNamMobile?
    static var theCaoVietNamMobileHeaders:TheCao_VietNamMobileHeaders?
    static var payooTopupResultCardTopup:PayooTopupResult?
    static var viettelPayCodeResult:ViettelPayCodeResult?
    static var isCardPromotionTopup:Bool = false
    static var itemPromotionActivedSim:PromotionActivedSim?
    static var viettelTopup:ViettelPayTopup?
    
    static var dataNotificationOpen:[AnyHashable: Any] = [:]
    static let listSkuVNMobile: [String] = ["00401226","00401227","00399239"]
    static var user:User?
    static var shopInfo: ShopInfo?;
    static var TOKEN:String = ""
    static var UUID:String  = ""
    static var sku: String = ""
    static var model_id:String = ""
    static var carts:[Cart] = []
    static var product: ProductBySku?
    static var segment: [Product] = []
    static var segmentSku: String = ""
    static var compareProduct: Product?
    static var itemsPromotion: [ProductPromotions] = []
    static var indexScreenShow:Int = 0
    static var companyAmortizations: [CompanyAmortization] = []
    static var mCallLogToken: String = "";
    
    static var selectedShopCode: String = "";
    static var selectedShopNameDSTarget: String = "";
    static var selectedEmployeeCode: String = "";
    static var userPosition: String = "";
    
    static var code: Int = 0
    static var phone: String = ""
    static var name: String = ""
    static var voucher: String = ""
    static var address: String = ""
    static var email: String = ""
    static var note: String = ""
    static var orderPayType:Int = -1
    static var genderType:Int = -1
    static var radioType:Int = 0
    static var orderType:Int = -1
    static var typeOrder1:String = ""
    static var orderPayInstallment:Int = -1
    static var vlInterestRate:String = ""
    static var vlPrepay:String = ""
    static var vlBirthday:String = ""
    static var valueInterestRate:Float = 0
    static var valuePrepay:Float = 0
    static var listVoucher: [String] = []
    static var listVoucherTemp: [String] = []
    static var type_so:Int = 0 //0:mpos, 1:pos, 2:ecom
    static var payOnlineEcom:Float = 0


	static var packageBookSim: DataBookSimV2?
    static var phoneNumberBookSim:String = ""
    static var phoneNumberBookSimTemp:String = ""
    static var promotions: [String:NSMutableArray] = [:]
    static var group: [String]!
    static var itemsPromotionTemp: [ProductPromotions] = []
    
    static var cartsTemp:[Cart] = []
    static var phoneTemp: String = ""
    static var nameTemp: String = ""
    static var addressTemp: String = ""
    static var emailTemp: String = ""
    static var noteTemp: String = ""
    static var docTypeTemp: String = ""
    static var payTypeTemp: String = ""
    static var voucherTemp:String = ""
    static var birthdayTemp:String = ""
    static var genderTemp:Int = 0
    static var debitCustomerTemp:DebitCustomer?
    static var debitCustomer:DebitCustomer?
    
    static var orderPayTypeTemp:Int = -1
    static var orderTypeTemp:Int = -1
    static var orderPayInstallmentTemp:Int = -1
    static var vlInterestRateTemp:String = ""
    static var vlPrepayTemp:String = ""
    static var valueInterestRateTemp:Float = 0
    static var valuePrepayTemp:Float = 0
    static var docEntry: String = ""
    static var resultPromostions: [PromotionsObject] = []
    static var ShopInfo:ShopInfo?
    static var searchOld:Bool = false
    
    static var ocfdFFriend:OCRDFFriend?
    static var listIDSaoKeLuongFFriend:String = ""
    static var CRD_SaoKeLuong1:String = ""
    static var CRD_SaoKeLuong2:String = ""
    static var CRD_SaoKeLuong3:String = ""
    static var typeOrder:String = ""
    
    static var cartsFF:[Cart] = []
    static var itemsPromotionFF: [ProductPromotions] = []
    static var promotionsFF: [String:NSMutableArray] = [:]
    static var groupFF: [String]!
    static var itemsPromotionTempFF: [ProductPromotions] = []
    
    static var resultPromostionsFF: [PromotionsObject] = []
    static var cartsTempFF:[Cart] = []
    static var topUpPrice:[GetTopUpListResult] = []
    static var depositEcomNumFF:String = ""
    static var codePayment:Int = 0
    static var listVoucherNoPrice:[VoucherNoPrice] = []
    static var listVoucherNoPriceFF:[VoucherNoPrice] = []
    
    
    // nhap hang
    static var listPO:[PO] = []
    static var listPONum:[Int] = []
    static var vendorNum:String = ""
    
    static var CRMCode: String = ""
    //combopk
    static var comboPKSP:ComboPK_Search_TableView?
    //mirae
    static var cartsMirae:[Cart] = []
    static var itemsPromotionMirae: [ProductPromotions] = []
    static var promotionsMirae: [String:NSMutableArray] = [:]
    static var groupMirae: [String]!
    static var itemsPromotionTempMirae: [ProductPromotions] = []
    
    static var resultPromostionsMirae: [PromotionsObject] = []
    static var cartsTempMirae:[Cart] = []
    static var infoCustomerMirae:InfoCustomerMirae?
    static var infoKHMirae:KhachHangMiraeModel?
    static var listVoucherMirae: [String] = []
    static var listVoucherTempMirae: [String] = []
    static var voucherMirae: String = ""
    static var listDatCocMirae:[Cart] = []
    static var soTienCocMirae:Float = 0
    static var is_sale_MDMH: String = ""
    static var is_sale_software: String = ""
    static var phithamgia: Float = 0
    //vnpt
    static var cartsVNPT:[Cart] = []
    static var itemsPromotionVNPT: [ProductPromotions] = []
    static var promotionsVNPT: [String:NSMutableArray] = [:]
    static var groupVNPT: [String]!
    static var itemsPromotionTempVNPT: [ProductPromotions] = []
    
    static var resultPromostionsVNPT: [PromotionsObject] = []
    static var cartsTempVNPT:[Cart] = []
    static var listVoucherVNPT: [String] = []
    static var listVoucherTempVNPT: [String] = []
    static var voucherVNPT: String = ""
    static var infoCMNDVNPT:InfoCmndVNPT?
    //RIGHT PHONE
    static var RP_cmndNumber: String = ""
    static var RP_ngayCapCMND: String = ""
    static var RP_noiCapCMND: String = ""
    static var RP_cmndAddress: String = ""
    static var RP_addressHome: String = ""
    static var RP_phoneNumber: String = ""
    static var RP_deviceStatus: String = ""
    static var RP_accessoriesStatus: String = ""
    static var RP_otpSMS: String = ""
    static var RP_suggestedPrice: String = ""
    static var arrShiftChamCong:[ShiftDateByEmployee] = []
    
    func parseXMLProduct()->String{
        var rs:String = "<line>"
        for item in Cache.cartsMirae {
            var name = item.product.name
            name = name.replace(target: "&", withString:"&#38;")
            name = name.replace(target: "<", withString:"&#60;")
            name = name.replace(target: ">", withString:"&#62;")
            name = name.replace(target: "\"", withString:"&#34;")
            name = name.replace(target: "'", withString:"&#39;")
            
            if(item.imei == "N/A"){
                item.imei = ""
            }
            
            item.imei = item.imei.replace(target: "&", withString:"&#38;")
            item.imei = item.imei.replace(target: "<", withString:"&#60;")
            item.imei = item.imei.replace(target: ">", withString:"&#62;")
            item.imei = item.imei.replace(target: "\"", withString:"&#34;")
            item.imei = item.imei.replace(target: "'", withString:"&#39;")
            
            rs = rs + "<item U_ItmCod=\"\(item.product.sku)\" U_Imei=\"\(item.imei)\" U_Quantity=\"\(item.quantity)\"  U_Price=\"\(String(format: "%.6f", item.product.price))\" U_WhsCod=\"\(Cache.user!.ShopCode)010\" U_ItmName=\"\(name)\"/>"
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
}

//Order Status Table
//ID   //Code                       //Mô tả

//0    NON_SUPPORT                  Không hỗ trợ
//1    CREATE                       Đã tạo giao dịch
//2    SUCCESS                      Giao dịch thành công
//3    FAILED                       Giao dịch thất bại
//4    CANCELLED                    Đã hủy
//5    PUSHED_TO_POS                Đã đẩy sang POS
//6    REQUEST_CANCEL               Yêu cầu hủy
//7    PROCESSING                   Đang thực hiện
//8    CANCEL_FAILED                Hủy thất bại (Giao dịch thành công)
//9    CANCEL_PROCESSING            Đang thực hiện hủy
//10   PARTIAL_CANCEL               Đã hủy 1 phần
//11   NEED_ADDITIONAL_INFORMATION  Cần bổ sung thông tin

enum CreateOrderResultViettelPay_SOM:Int {
    case NON_SUPPORT
    case CREATE
    case SUCCESS
    case FAILED
    case CANCELLED
    case PUSHED_TO_POS
    case REQUEST_CANCEL
    case PROCESSING
    case CANCEL_FAILED
    case CANCEL_PROCESSING
    case PARTIAL_CANCEL
    case NEED_ADDITIONAL_INFORMATION
    
    var message: String {
        switch self {
        case .NON_SUPPORT: return "Không hỗ trợ"
        case .CREATE: return "Đã tạo giao dịch (thu tiền khách hàng)"
        case .SUCCESS: return "Giao dịch thành công"
        case .FAILED: return "Giao dịch thất bại"
        case .CANCELLED: return "Đã hủy"
        case .PUSHED_TO_POS: return "Đã đẩy sang POS"
        case .REQUEST_CANCEL: return "Yêu cầu hủy"
        case .PROCESSING: return "Đang thực hiện (thu tiền khách hàng)"
        case .CANCEL_FAILED: return "Hủy thất bại (Giao dịch thành công)"
        case .CANCEL_PROCESSING: return "Đang thực hiện hủy"
        case .PARTIAL_CANCEL: return "Đã hủy 1 phần"
        case .NEED_ADDITIONAL_INFORMATION: return "Cần bổ sung thông tin"

        }
    }
     
}
