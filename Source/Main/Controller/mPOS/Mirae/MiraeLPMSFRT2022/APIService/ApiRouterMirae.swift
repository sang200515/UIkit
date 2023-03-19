//
//  ApiRouterMirae.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 25/04/2022.
//

import Alamofire
import Kingfisher

enum ApiRouterMirae: URLRequestConvertible {
    
    case orcCMNDCCCDMirae(
        partnerId:String,
        userCode:String,
        shopCode:String,
        frontBase64 : String,
        backBase64:String
    )
    case submitAppCapNhatChungTu(applicationId:String,userCode:String,shopCode:String,partnerId:String,appDocEntry:String,workInfo:Dictionary<String, Any>,documentType:String)
    case loadDanhSachLichSu(userCode:String,shopCode:String,partnerId:String,loadType:String)
    case loadTinh(userCode:String,shopCode:String,partnerId:String)
    case loadLyDoHuy(userCode:String,shopCode:String,partnerId:String)
    case loadMoiQuanHeGiaDinh(userCode:String,shopCode:String,partnerId:String)
    case loadLoaiHopDong(userCode:String,shopCode:String,partnerId:String)
    case loadLoaiChungTu(userCode:String,shopCode:String,partnerId:String)
    case loadChucVuLamViec(userCode:String,shopCode:String,partnerId:String)
    case loadMaNoiBo(userCode:String,shopCode:String,partnerId:String)
    case loadQuanHuyen(userCode:String,shopCode:String,partnerId:String,codeTinh:String)
    case loadXaPhuong(userCode:String,shopCode:String,partnerId:String,codeQuanHuyen:String)
    case loadChiTietDonHangMirae(userCode:String,shopCode:String,partnerId:String,appDocEntry:String)
    case loadChiTietDonHangCoc(userCode:String,shopCode:String,partnerId:String,appDocEntry:String,soPOS:String)
    case luuHoSoMirae(userCode:String,
                      shopCode:String,
                      partnerId:String,
                      customerInfo:Dictionary<String,Any>,
                      permanentAddress:Dictionary<String,Any>,
                      residenceAddress:Dictionary<String,Any>,
                      refPerson1:Dictionary<String,Any>,
                      refPerson2:Dictionary<String,Any>)
    case upLoadHinhHoSo(userCode:String,
                        shopCode:String,
                        partnerId:String,
                        base64:String,
                        fileId: Int,
                        appDocEntry: Int,
                        applicationId:String)
    case timDonCoc(userCode:String,
                   shopCode:String,
                   partnerId:String,
                   soPOS:String)
    case loadThongTinKH(userCode:String,shopCode:String,partnerId:String,appDocEntry:String)
    case loadGoiTraGop(userCode:String,shopCode:String,partnerId:String,RDR1:String)
    case loadNgayThanhToan(userCode:String,
                           shopCode:String,
                           partnerId:String)
    case loadChiTietThongTinDatCoc(userCode:String,shopCode:String,partnerId:String,appDocEntry:String)
    case hoanTatHoSo(userCode:String,shopCode:String,partnerId:String,appDocEntry:String)
    case updateThongTinCongViec(userCode:String,
                                shopCode:String,
                                partnerId:String,
                                appDocEntry:String,
                                customerInfo:Dictionary<String,Any>,
                                permanentAddress:Dictionary<String,Any>,
                                residenceAddress:Dictionary<String,Any>,
                                refPerson1:Dictionary<String,Any>,
                                refPerson2:Dictionary<String,Any>,
                                workInfo:Dictionary<String, Any>)
    case updateThongTinKhachHang(userCode:String,shopCode:String,partnerId:String,appDocEntry:String,customerInfo:Dictionary<String, Any>,permanentAddress:Dictionary<String,Any>)
    case sumitApplicationMirae(discount: Double,
                               loaiTraGop: String,
                               voucher: String,
                               diviceType: String,
                               payments: String,
                               doctype: String,
                               soTienTraTruoc: Float,
                               tenCTyTraGop: String,
                               token: String,
                               shopCode: String,
                               ngaySinh: String,
                               cardName: String,
                               soHDtragop: String,
                               address: String,
                               mail: String,
                               phone: String,
                               pre_docentry: String,
                               xmlspGiamGiaTay: String,
                               xmlVoucherDH: String,
                               U_EplCod: String,
                               xml_url_pk: String,
                               cardcode: String,
                               laiSuat: Float,
                               is_sale_MDMH: String,
                               CMND: String,
                               is_DH_DuAn: String,
                               PROMOS: String,
                               U_des: String,
                               is_sale_software: String,
                               is_samsung: String,
                               RDR1: String,
                               xmlstringpay: String,
                               kyhan: Int,
                               is_KHRotTG: Int,
                               gioitinh: Int,
                               CRMCode: String,
                               appDocEntry: Int,
                               schemecode: String)
    case huyHopDong(userCode:String,shopCode:String,partnerId:String,appDocEntry:String,reason:String)
    case loadAnhConThieu(userCode:String,shopCode:String,partnerId:String,appDocEntry:String)
    case updateAnhConThieu(userCode:String,shopCode:String,partnerId:String,appDocEntry:String)
    case updateGoiVay(discount: Double,
                      loaiTraGop: String,
                      voucher: String,
                      diviceType: String,
                      payments: String,
                      doctype: String,
                      soTienTraTruoc: Float,
                      tenCTyTraGop: String,
                      token: String,
                      shopCode: String,
                      ngaySinh: String,
                      cardName: String,
                      soHDtragop: String,
                      address: String,
                      mail: String,
                      phone: String,
                      pre_docentry: String,
                      xmlspGiamGiaTay: String,
                      xmlVoucherDH: String,
                      U_EplCod: String,
                      xml_url_pk: String,
                      cardcode: String,
                      laiSuat: Float,
                      is_sale_MDMH: String,
                      CMND: String,
                      is_DH_DuAn: String,
                      PROMOS: String,
                      U_des: String,
                      is_sale_software: String,
                      is_samsung: String,
                      RDR1: String,
                      xmlstringpay: String,
                      kyhan: Int,
                      is_KHRotTG: Int,
                      gioitinh: Int,
                      CRMCode: String,
                      appDocEntry: Int,
                      schemecode: String)
    case resubmitToMirae(userCode:String,shopCode:String,partnerId:String,appDocEntry:String)
 
    private var url:String {
        switch self {
        case    .orcCMNDCCCDMirae,
                .loadTinh,
                .loadQuanHuyen,
                .loadXaPhuong,
                .loadDanhSachLichSu,
                .loadChiTietDonHangMirae,
                .luuHoSoMirae,
                .upLoadHinhHoSo,
                .timDonCoc,
                .loadThongTinKH,
                .loadGoiTraGop,
                .loadNgayThanhToan,
                .loadChiTietThongTinDatCoc,
                .hoanTatHoSo,
                .updateThongTinCongViec,
                .updateThongTinKhachHang,
                .sumitApplicationMirae,
                .loadLyDoHuy,
                .loadMoiQuanHeGiaDinh,
                .loadLoaiHopDong,
                .loadLoaiChungTu,
                .loadChucVuLamViec,
                .loadMaNoiBo,
                .submitAppCapNhatChungTu,
                .huyHopDong,
                .loadAnhConThieu,
                .updateAnhConThieu,
                .updateGoiVay,
                .resubmitToMirae,
                .loadChiTietDonHangCoc:
            return Config.manager.URL_GATEWAY
        }
    }
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case    .orcCMNDCCCDMirae,
                .luuHoSoMirae,
                .upLoadHinhHoSo,
                .loadGoiTraGop,
                .updateThongTinCongViec,
                .updateThongTinKhachHang,
                .sumitApplicationMirae,
                .submitAppCapNhatChungTu,
                .huyHopDong,
                .updateGoiVay:
            return .post
        case    .loadTinh,
                .loadQuanHuyen,
                .loadXaPhuong,
                .loadDanhSachLichSu,
                .loadChiTietDonHangMirae,
                .timDonCoc,
                .loadThongTinKH,
                .loadNgayThanhToan,
                .loadChiTietThongTinDatCoc,
                .hoanTatHoSo,
                .loadLyDoHuy,
                .loadMoiQuanHeGiaDinh,
                .loadLoaiHopDong,
                .loadLoaiChungTu,
                .loadChucVuLamViec,
                .loadMaNoiBo,
                .loadAnhConThieu,
                .updateAnhConThieu,
                .resubmitToMirae,
                .loadChiTietDonHangCoc:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .orcCMNDCCCDMirae:
            return "/mpos-cloud-api/api/miraeV1/ocrCMND"
        case .loadTinh:
            return "/mpos-cloud-api/api/miraeV1/loadProvince"
        case .loadQuanHuyen:
            return "/mpos-cloud-api/api/miraeV1/loadDistrict"
        case .loadXaPhuong:
            return "/mpos-cloud-api/api/miraeV1/loadPrecinct"
        case .loadDanhSachLichSu:
            return "/mpos-cloud-api/api/miraeV1/getApplicationList"
        case .loadChiTietDonHangMirae:
            return "/mpos-cloud-api/api/miraeV1/getOrderDetail"
        case .luuHoSoMirae:
            return "/mpos-cloud-api/api/miraeV1/createCustomerInfo"
        case .upLoadHinhHoSo:
            return "/mpos-cloud-api/api/miraeV1/uploadApplicationImage"
        case .timDonCoc:
            return "/mpos-cloud-api/api/miraeV1/getDepositInfo"
        case .loadThongTinKH:
            return "/mpos-cloud-api/api/miraeV1/getCustomerInfo"
        case .loadGoiTraGop:
            return "/mpos-cloud-api/api/miraeV1/loadSchemeCode"
        case .loadNgayThanhToan:
            return "/mpos-cloud-api/api/miraeV1/loadDueDate"
        case .loadChiTietThongTinDatCoc:
            return "/mpos-cloud-api/api/miraeV1/getDepositInfoDetail"
        case .hoanTatHoSo:
            return "/mpos-cloud-api/api/miraeV1/finishApplication"
        case .updateThongTinCongViec:
            return "/mpos-cloud-api/api/miraeV1/updateCustomerInfo"
        case .updateThongTinKhachHang:
            return "/mpos-cloud-api/api/miraeV1/updateCustomerInfo"
        case .sumitApplicationMirae:
            return "/mpos-cloud-api/api/miraeV1/saveOrderAndCheckCustomer"
        case .loadLyDoHuy:
            return "/mpos-cloud-api/api/miraeV1/LoadReasonCancel"
        case .loadMoiQuanHeGiaDinh:
            return "/mpos-cloud-api/api/miraeV1/LoadRelationship"
        case .loadLoaiHopDong:
            return "/mpos-cloud-api/api/miraeV1/loadAppType"
        case .loadLoaiChungTu:
            return "/mpos-cloud-api/api/miraeV1/loadDocType"
        case .loadChucVuLamViec:
            return "/mpos-cloud-api/api/miraeV1/loadPosition"
        case .loadMaNoiBo:
            return "/mpos-cloud-api/api/miraeV1/LoadInternalCode"
        case .submitAppCapNhatChungTu:
            return "/mpos-cloud-api/api/miraeV1/submitApplication"
        case .huyHopDong:
            return "/mpos-cloud-api/api/miraeV1/cancelApplication"
        case .loadAnhConThieu:
            return "mpos-cloud-api/api/miraeV1/getImageUpdateInfo"
        case .updateAnhConThieu:
            return "mpos-cloud-api/api/miraeV1/updateImageUpdateInfo"
        case .updateGoiVay:
            return "mpos-cloud-api/api/miraeV1/updateLoanAmount"
        case .resubmitToMirae:
            return "mpos-cloud-api/api/miraeV1/resubmitApplication"
        case .loadChiTietDonHangCoc:
            return "mpos-cloud-api/api/miraeV1/getDepositInfoDetail"
        }
    }
    
    // MARK: - Headers
    private var headers: HTTPHeaders {
        let token = UserDefaults.standard.string(forKey: "access_token") ?? ""
        let headers:HTTPHeaders = ["Content-Type": "application/json","Authorization":"Bearer \(token)"]
        switch self {
        case    .orcCMNDCCCDMirae,
                .loadTinh,
                .loadQuanHuyen,
                .loadXaPhuong,
                .loadDanhSachLichSu,
                .loadChiTietDonHangMirae,
                .luuHoSoMirae,
                .upLoadHinhHoSo,
                .timDonCoc,
                .loadThongTinKH,
                .loadGoiTraGop,
                .loadNgayThanhToan,
                .loadChiTietThongTinDatCoc,
                .hoanTatHoSo,
                .updateThongTinCongViec,
                .updateThongTinKhachHang,
                .sumitApplicationMirae,
                .loadLyDoHuy,
                .loadMoiQuanHeGiaDinh,
                .loadLoaiHopDong,
                .loadLoaiChungTu,
                .loadChucVuLamViec,
                .loadMaNoiBo,
                .submitAppCapNhatChungTu,
                .huyHopDong,
                .loadAnhConThieu,
                .updateAnhConThieu,
                .updateGoiVay,
                .resubmitToMirae,
                .loadChiTietDonHangCoc:
            break
        }
        return headers
    }

    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .orcCMNDCCCDMirae(partnerId: let partnerId,
                               userCode: let userCode,
                               shopCode: let shopCode,
                               frontBase64: let frontBase64,
                               backBase64: let backBase64):
            return [
                "partnerId":partnerId,
                "userCode":userCode,
                "shopCode":shopCode,
                "frontBase64":frontBase64,
                "backBase64":backBase64
            ]
        case .loadXaPhuong(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId, codeQuanHuyen: let codeQuanHuyen):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId,
                "districtCode":codeQuanHuyen
            ]
        case .loadQuanHuyen(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId, codeTinh: let codeTinh):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId,
                "provinceCode":codeTinh
            ]
        case .loadTinh(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId
            ]
        case .loadDanhSachLichSu(userCode: let userCode,
                                 shopCode: let shopCode,
                                 partnerId: let partnerId,
                                 loadType: let loadType):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId,
                "loadType":loadType
            ]
        case .loadChiTietDonHangMirae(userCode: let userCode,
                                      shopCode: let shopCode,
                                      partnerId: let partnerId,
                                      appDocEntry: let appDocEntry):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId,
                "appDocEntry":appDocEntry
            ]
        case .luuHoSoMirae(userCode: let userCode,
                           shopCode: let shopCode,
                           partnerId: let partnerId,
                           customerInfo: let customerInfo,
                           permanentAddress: let permanentAddress,
                           residenceAddress: let residenceAddress,
                           refPerson1: let refPerson1, refPerson2: let refPerson2):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId,
                "CustomerInfo":customerInfo,
                "permanentAddress":permanentAddress,
                "residenceAddress":residenceAddress,
                "refPerson1":refPerson1,
                "refPerson2":refPerson2
            ]
        case .upLoadHinhHoSo(userCode: let userCode,
                             shopCode: let shopCode,
                             partnerId: let partnerId,
                             base64: let base64,
                             fileId: let fileId,
                             appDocEntry: let appDocEntry,
                             applicationId: let applicationId):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId,
                "base64":base64,
                "fileId":fileId,
                "appDocEntry":appDocEntry,
                "applicationId":applicationId
            ]
        case .timDonCoc(userCode: let userCode,
                        shopCode: let shopCode,
                        partnerId: let partnerId,
                        soPOS: let soPOS):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId,
                "soPOS":soPOS,
            ]
        case .loadThongTinKH(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId, appDocEntry: let appDocEntry):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId,
                "appDocEntry":appDocEntry
            ]
        case .loadGoiTraGop(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId,RDR1:let RDR1):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId,
                "RDR1":RDR1
            ]
        case .loadNgayThanhToan(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId
            ]
        case .loadChiTietThongTinDatCoc(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId, appDocEntry: let appDocEntry):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId,
                "appDocEntry":appDocEntry
            ]
        case .hoanTatHoSo(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId, appDocEntry: let appDocEntry):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId,
                "appDocEntry":appDocEntry
            ]
        case .updateThongTinCongViec(userCode: let userCode,
                                     shopCode: let shopCode,
                                     partnerId: let partnerId,
                                     appDocEntry:let appDocEntry,
                                     customerInfo: let customerInfo,
                                     permanentAddress: let permanentAddress,
                                     residenceAddress: let residenceAddress,
                                     refPerson1: let refPerson1,
                                     refPerson2: let refPerson2,
                                     workInfo:let workInfo):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId,
                "CustomerInfo":customerInfo,
                "permanentAddress":permanentAddress,
                "residenceAddress":residenceAddress,
                "refPerson1":refPerson1,
                "refPerson2":refPerson2,
                "workInfo":workInfo,
                "appDocEntry":appDocEntry
            ]
        case .updateThongTinKhachHang(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId, appDocEntry: let appDocEntry, customerInfo: let customerInfo, permanentAddress: let permanentAddress):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId,
                "appDocEntry":appDocEntry,
                "customerInfo":customerInfo,
                "permanentAddress":permanentAddress
                
            ]
        case .sumitApplicationMirae(discount: let discount,
                                    loaiTraGop: let loaiTraGop,
                                    voucher: let voucher,
                                    diviceType: let diviceType,
                                    payments: let payments,
                                    doctype: let doctype,
                                    soTienTraTruoc: let soTienTraTruoc,
                                    tenCTyTraGop: let tenCTyTraGop,
                                    token: let token,
                                    shopCode: let shopCode,
                                    ngaySinh: let ngaySinh,
                                    cardName: let cardName,
                                    soHDtragop: let soHDtragop,
                                    address: let address,
                                    mail: let mail,
                                    phone: let phone,
                                    pre_docentry: let pre_docentry,
                                    xmlspGiamGiaTay: let xmlspGiamGiaTay,
                                    xmlVoucherDH: let xmlVoucherDH,
                                    U_EplCod: let U_EplCod,
                                    xml_url_pk: let xml_url_pk,
                                    cardcode: let cardcode,
                                    laiSuat: let laiSuat,
                                    is_sale_MDMH: let is_sale_MDMH,
                                    CMND: let CMND,
                                    is_DH_DuAn: let is_DH_DuAn,
                                    PROMOS: let PROMOS,
                                    U_des: let U_des,
                                    is_sale_software: let is_sale_software,
                                    is_samsung: let is_samsung,
                                    RDR1: let RDR1,
                                    xmlstringpay: let xmlstringpay,
                                    kyhan: let kyhan,
                                    is_KHRotTG: let is_KHRotTG,
                                    gioitinh: let gioitinh,
                                    CRMCode: let CRMCode,
                                    appDocEntry: let appDocEntry,
                                    schemecode: let schemecode):
            return [
                "discount": discount,
                "LoaiTraGop": loaiTraGop,
                "voucher": voucher,
                "DiviceType": diviceType,
                "payments": payments,
                "Doctype": doctype,
                "SoTienTraTruoc": soTienTraTruoc.clean,
                "TenCTyTraGop": tenCTyTraGop,
                "Token": token,
                "ShopCode": shopCode,
                "NgaySinh": ngaySinh,
                "CardName": cardName,
                "soHDtragop": soHDtragop,
                "Address": address,
                "Mail": mail,
                "phone": phone,
                "pre_docentry": pre_docentry,
                "xmlspGiamGiaTay": xmlspGiamGiaTay,
                "xmlVoucherDH":xmlVoucherDH,
                "U_EplCod": U_EplCod,
                "xml_url_pk": xml_url_pk,
                "cardcode": cardcode,
                "LaiSuat": laiSuat,
                "is_sale_MDMH": is_sale_MDMH,
                "CMND": CMND,
                "is_DH_DuAn": is_DH_DuAn,
                "PROMOS": PROMOS,
                "U_des": U_des,
                "is_sale_software": is_sale_software,
                "is_samsung": is_samsung,
                "RDR1": RDR1,
                "xmlstringpay": xmlstringpay,
                "kyhan": kyhan,
                "is_KHRotTG": is_KHRotTG,
                "gioitinh": gioitinh,
                "CRMCode": CRMCode,
                "appDocEntry": appDocEntry,
                "chemecode": schemecode,
                "partnerId":PARTNERID
            ]
        case .loadLyDoHuy(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId
            ]
        case .loadMoiQuanHeGiaDinh(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId
            ]
        case .loadLoaiHopDong(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId
            ]
        case .loadLoaiChungTu(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId
            ]
        case .loadChucVuLamViec(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId
            ]
        case .loadMaNoiBo(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId
            ]
        case .submitAppCapNhatChungTu(applicationId: let applicationId, userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId, appDocEntry: let appDocEntry, workInfo: let workInfo,documentType: let documentType):
            return [
                "applicationId": applicationId,
                "partnerId": partnerId,
                "appDocEntry" :appDocEntry,
                "userCode":userCode,
                "shopCode":shopCode,
                "documentType":documentType,
                "workInfo":workInfo
            ]
        case .huyHopDong(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId, appDocEntry: let appDocEntry, reason: let reason):
            return [
                "partnerId": partnerId,
                "appDocEntry" :appDocEntry,
                "userCode":userCode,
                "shopCode":shopCode,
                "reason":reason
            ]
        case .loadAnhConThieu(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId, appDocEntry: let appDocEntry):
            return [
                "partnerId": partnerId,
                "appDocEntry" :appDocEntry,
                "userCode":userCode,
                "shopCode":shopCode
            ]
        case .updateAnhConThieu(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId, appDocEntry: let appDocEntry):
            return [
                "partnerId": partnerId,
                "appDocEntry" :appDocEntry,
                "userCode":userCode,
                "shopCode":shopCode
            ]
        case .updateGoiVay(discount: let discount, loaiTraGop: let loaiTraGop, voucher: let voucher, diviceType: let diviceType, payments: let payments, doctype: let doctype, soTienTraTruoc: let soTienTraTruoc, tenCTyTraGop: let tenCTyTraGop, token: let token, shopCode: let shopCode, ngaySinh: let ngaySinh, cardName: let cardName, soHDtragop: let soHDtragop, address: let address, mail: let mail, phone: let phone, pre_docentry: let pre_docentry, xmlspGiamGiaTay: let xmlspGiamGiaTay, xmlVoucherDH: let xmlVoucherDH, U_EplCod: let U_EplCod, xml_url_pk: let xml_url_pk, cardcode: let cardcode, laiSuat: let laiSuat, is_sale_MDMH: let is_sale_MDMH, CMND: let CMND, is_DH_DuAn: let is_DH_DuAn, PROMOS: let PROMOS, U_des: let U_des, is_sale_software: let is_sale_software, is_samsung: let is_samsung, RDR1: let RDR1, xmlstringpay: let xmlstringpay, kyhan: let kyhan, is_KHRotTG: let is_KHRotTG, gioitinh: let gioitinh, CRMCode: let CRMCode, appDocEntry: let appDocEntry, schemecode: let schemecode):
            return [
                "discount": discount,
                "LoaiTraGop": loaiTraGop,
                "voucher": voucher,
                "DiviceType": diviceType,
                "payments": payments,
                "Doctype": doctype,
                "SoTienTraTruoc": soTienTraTruoc.clean,
                "TenCTyTraGop": tenCTyTraGop,
                "Token": token,
                "ShopCode": shopCode,
                "NgaySinh": ngaySinh,
                "CardName": cardName,
                "soHDtragop": soHDtragop,
                "Address": address,
                "Mail": mail,
                "phone": phone,
                "pre_docentry": pre_docentry,
                "xmlspGiamGiaTay": xmlspGiamGiaTay,
                "xmlVoucherDH":xmlVoucherDH,
                "U_EplCod": U_EplCod,
                "xml_url_pk": xml_url_pk,
                "cardcode": cardcode,
                "LaiSuat": laiSuat,
                "is_sale_MDMH": is_sale_MDMH,
                "CMND": CMND,
                "is_DH_DuAn": is_DH_DuAn,
                "PROMOS": PROMOS,
                "U_des": U_des,
                "is_sale_software": is_sale_software,
                "is_samsung": is_samsung,
                "RDR1": RDR1,
                "xmlstringpay": xmlstringpay,
                "kyhan": kyhan,
                "is_KHRotTG": is_KHRotTG,
                "gioitinh": gioitinh,
                "CRMCode": CRMCode,
                "appDocEntry": appDocEntry,
                "chemecode": schemecode,
                "partnerId":PARTNERID
            ]
        case .resubmitToMirae(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId, appDocEntry: let appDocEntry):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId,
                "appDocEntry":appDocEntry
            ]
        case .loadChiTietDonHangCoc(userCode: let userCode, shopCode: let shopCode, partnerId: let partnerId, appDocEntry: let appDocEntry, soPOS: let soPOS):
            return [
                "userCode":userCode,
                "shopCode":shopCode,
                "partnerId":partnerId,
                "appDocEntry":appDocEntry,
                "soPOS":soPOS
            ]
        }
    }

    // MARK: - URL request
    func asURLRequest() throws -> URLRequest {
        
        let url = try self.url.asURL()

        var urlRequest: URLRequest = URLRequest(url: url.appendingPathComponent(path.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) ?? ""))

        urlRequest.httpMethod = self.method.rawValue

        self.headers.forEach { (header) in
            urlRequest.addValue(header.value, forHTTPHeaderField: header.name)
        }
        
        if self.parameters == nil {
            print("Param nil")
        }
        
        if let parameters = self.parameters {
            do {
                if urlRequest.httpMethod == "GET" {
                    urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
                }else {
                    urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
                }
            } catch {
                print("Encoding Parameters fail")
            }
        }
        
        return urlRequest
    }
    
}


