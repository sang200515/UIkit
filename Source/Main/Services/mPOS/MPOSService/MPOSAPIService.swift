//
//  MPOSAPIService.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

import Alamofire

enum MPOSAPIService {
    
    case updateDeviceInfo
    case FRT_SP_mpos_loadSPTraGop(MaSP:String,DonGia:String)
    case getAmortizationsDefinitions(itemCode:String,price:String)
    case getAllAmortizationsProperties
    case getAllAmortizationsPrePays
    case getAllAmortizationsTerms
    case getAmortizationsDefinitionsDetail(itemCode:String,price:String,proID:String,prePayID:String,termID:String)
    case checkInventory(shopCode:String,itemCode:String)
    case getTonKhoShopGanNhat(listsp:String,shopCode:String)
    case getListImeiBook(itemCode:String)
    case getVendorInstallment
    case loadDebitCustomer(phone:String)
    case checkVoucherKMBookSim(sdt:String,xmlvoucher:String)
    case checkPromotionNew(param:Dictionary<String, Any>)
    case searchCustomersToshiba(phoneNumber:String)
    case getToshibaPoint(idCardPoint:String)
    case getImei(productCode:String,shopCode:String)
    case removeSO(docEntry:String)
    case saveOrder(param:Dictionary<String, Any>)
    case getPriceDatCoc(param:Dictionary<String, Any>)
    case getListLoaiSimV2(itemCode:String)
    case getSearchSimV2(param:Dictionary<String, Any>)
    case checkGoiCuocVaSim(param:Dictionary<String, Any>)
    case dangKyBookSoV2(param:Dictionary<String, Any>)
    case getListSimBookByShopV2(sdt:String)
    case huyBookSoV2(phoneNumber:String)
    case GetDistricts(MaCodeTinh:String,NhaMang:String)
    case GetPrecincts(MaCodeHUyen:String,MaCodeTinh:String,NhaMang:String)
    case SearchNationality(Nhamang:String)
    case GetProvinces(NhaMang:String)
    case getListCustomersViettel(idNo:String)
    case checkGoiCuocVNMobile(phoneNumber:String,cmnd:String,productCode:String,goiCuoc:String,userId:String,maShop:String,nhaMang:String)
    case AutoCreateImageActiveSimViettelHD(param:Dictionary<String, Any>)
    case AutoCreateImageActiveSimVNPhone(param:Dictionary<String, Any>)
    case AutoCreateImageActiveSimMobiPhone(param:Dictionary<String, Any>)
    case AutoCreateImageActiveSimVietnamobile(param:Dictionary<String, Any>)
    case ActiveSim(param:Dictionary<String, Any>)
    
    case GetListSearchOldProduct(keySearch:String,shop:String,skip:Int,top:Int,type:Int)
    case getListOldProduct(shop:String,skip:Int,top:Int,type:Int)
    case getEmployeeSOHeaders(param: [String: String])
    case getEcomSOHeader(userCode:String,shopCode:String)
    case getOCRDFFriend(cmnd:String,HinhThucMua:String,MaShop:String,isQrCode:String)
    case mpos_sp_LichSuMuahang(IDCardCode:String)
    case mpos_sp_CancelFormDKSingle_TraGopOnline(IDFormDK:String,UserID:String)
    case getSODetails(docEntry:String)
    case mpos_sp_calllog_UpdateImei_Ecom(UserID:String,Imei:String,Itemcode:String,IDFinal:String)
    case mpos_sp_PrintPhieuDKPOS(IDCardCode:String,UserID:String,ID_Final:String)
    case mpos_sp_UploadHinhAnhPDK(IDFinal:String,ShopCode:String,UserID:String,ChuKy:String,DiviceType:String,str64_CMNDMT:String,str64_CMNDMS:String,str64_ChanDung:String)
    case mpos_sp_UploadChungTuHinhAnh(IdCardCode:String,Link_UQTN_1:String,Link_UQTN_2:String,Link_UQTN_3:String,Link_CMNDMT:String,Link_CMNDMS:String,UserID:String)
    case  mpos_sp_SaveImageFriend_ChungTuDoiTra(insideCode:String,idFinal:String,base64_ChungTuDoiTra:String)
    case getVendorFFriend(LoaiDN:String)
    case sp_mpos_CheckCreateCustomer(VendorCode:String,LoaiKH:String)
    case AddCustomerFFriend(param:[String: String])
    case sp_CreditNoneCard_UploadImage_RequestV2(param:[String: String])
    case UploadImage_CreditNoCard(param:[String: String])
    case mpos_sp_GetBank_CreditNoCard
    case mpos_sp_GetLink_CMND_UQTN_Credit(CMND:String)
    case mpos_sp_getVendors_All
    case mpos_sp_SearchVendor(vendor:String)
    case mpos_sp_SaveImageFriend(param:[String: String])
    case mpos_sp_SaveImageFriend_ChanDung(param:[String: String])
    case getTinhThanhFFriend
    case getThongTinNganHangFFriend(Vendor:String,CNVendor:String)
    case mpos_sp_LoadTinhThanhPho
    case mpos_sp_LoadQuanHuyen(TinhThanh:String)
    case mpos_sp_GetMoiLienHeVoiNguoiLL
    case mpos_sp_PrintUQTNPOS(IDCardCode:String,UserID:String)
    case mpos_sp_SendOTPCustomerFriend(param:[String: String])
    case checkPromotionFF(param: [String: String] )
    case mpos_sp_insert_order_ffriend(param: [String: String] )
    case getHinhThucGiaoHangFFriend
    case sp_mpos_CheckAccount_SkipOTP_ShopApDung
    case CheckAccount_SkipOTP(UserID:String,PassWord:String)
    case FRT_SP_CRM_DSNhaMang_bookSim(param: [String: String])
    case getListGoiCuocBookSimV2(NhaMang:String)
    case getListLichSuKichHoat(param: [String: String])
    case getListLichSuKichHoatSerial(param: [String: String])
    case getThongTinGiaHanSSD(param: [String: String])
    case uploadHinhGiaHanSSD(param: [String: String])
    case giaHanSSDResult(param: [String: String])
    case getOTPGiaHanSSD(param: [String: String])
    case getListNhaThuoc(param: [String: String])
    case getListNhanVienThuocLongChau(param: [String: String])
    case insertThuHoLongChau(param: [String: String])
    case SendOTPConvert4G(param: [String: String])
    case changeSim4G(param: [String: String])
    case getInfoActiveSimbyPhone(param: [String: String])
    case SendOTPInfoActiveSim(param: [String: String])
    case updateInfoVNM(param: [String: String])
    case BaoHiem_GetHangXe(param: [String: String])
    case Get_CardType_From_POS(param: [String: String])
    case BaoHiem_GetLoaiXe(param: [String: String])
    case BaoHiem_GetSP(param: [String: String])
    case BaoHiem_GetPhuongXa(param: [String: String])
    case BaoHiem_GetQuan(param: [String: String])
    case BaoHiem_GetDungTich(param: [String: String])
    case BaoHiem_getGiaBan_BHX(param: [String: String])
    case BaoHiem_getGiaBanAll_BHX(param: [String: String])
    case BaoHiem_GetToken(param: [String: String])
    case BaoHiem_GetTinhThanh(param: [String: String])
    case BaoHiem_AddOrder(param: [String: String])
    case GetSearchCustomers(param: [String: String])
    case GetProvidersNew(param: [String: String])
    case GetAgumentFtel(param: [String: String])
    case GetPaymentFtel(param: [String: String])
    case GetBill(param: [String: String])
    case GetListCustomer(param: [String: String])
    case GetFtelLocations(param: [String: String])
    case GetEncashAgribankResult(param: [String: String])
    case GetEncashpayooResult(param: [String: String])
    case GetCheckVoucher(param: [String: String])
    case GetPayooTopup(param: [String: String])
    case GetPayooPayResult(param: [String: String])
    case GetVietNamMobileTheCaoPayResult(param: [String: String])
    case GetTopupVNM(param: [String: String])
    case GetTopUpList(param: [String: String])
    case GetTopUpPrice(param: [String: String])
    case GetPayCodeList(param: [String: String])
    case GetPayCodePrice(param: [String: String])
    case getThongTinDatCoc(param: [String: String])
    case getPriceGoiBH(param: [String: String])
    case mpos_sp_GetInfoSubsidy(param: [String: String])
    case GetPasscode_Form2Key(param: [String: String])
    case sp_mpos_Get_SSD_GoiCuoc_for_MPOS(param: [String: String])
    case mpos_sp_Get_ThongTinSSD_ChiTietGoiCuoc(param: [String: String])
    case mpos_sp_Get_ThongTinSSD_from_itemcode_goicuoc(param: [String: String])
    case sp_mpos_SSD_MSP_SIM_10_11_for_MPOS(param: [String: String])
    case sp_mpos_GetList_ItemCodeSubSidy(param: [String: String])
    case sp_mpos_FRT_SP_SSD_SoSanhGoiSSD_GoiThuong(param: [String: String])
    case VinaGame_InsertInstallapp(param: [String: String])
    case VinaGame_GetListDH(param: [String: String])
    case VinaGame_GetListDHIntalled(param: [String: String])
    case getListNCC(param: [String: String])
    case getListPOAll(param: [String: String])
    case insertXMLNhapHang(param: [String: String])
    case getHistoryNhapHang(param: [String: String])
    case searchCNMD_subsidy(param: [String: String])
    case checkCICKhachHang(param: [String: String])
    case uploadImageLockDevice(param: [String: String])
    case hoantatLockDevice(param: [String: String])
    case loadInfoLockDevice(param: [String: String])
    case GoiPopupHang_Mobile(param: [String: String])
    case TaoPhieuBH_AutoMailChoHang(param: [String: String])
    case Checkimei_V2(param: [String: String])
    case LayHinhThucBanGiaoChoBHV(param: [String: String])
    case LoadHinhThucBanGiao(param: [String: String])
    case TaoPhieuBH_NgayHenTra(param: [String: String])
    case BaoHanhUploadImageNew(param: [String: String])
    case TaoPhieuBH_UpLoadImage(param: [String: String])
    case GetBaoHanhPhuKien
    case TaoPhieuBH_LuuPhieuBH(param: [String: String])
    case LayTinhTrangMay
    case GetImageBienBanBH(param: [String: String])
    case TaoPhieuBH_Timsanpham(param: [String: String])
    case LayThongTinHinhThucBH(param: [String: String])
    case Checkimei_V2_More(param: [String: String])
    case GetLoadThongTinPhieuTraKH(param: [String: String])
    case GetLoadThongTinBBTraMay(param: [String: String])
    case GetDongBoKnox(param: [String: String])
    case baoHanhPhuKien_SearchLichSu(param: [String: String])
    case baoHanhPhuKien_LoadLoai
    
    
    case checkpromotionActivedSim(param: [String: String])
    
    
    
    case inMoMo(param: [String: String])
    case getDanhSachPhieuMoMo(param: [String: String])
    case GetCRMPaymentHistory(param: [String: String])
    
    case inRutTienMoMo(param: [String: String])
    case LoadThongTinTimKiemThem_Mobile(param: [String: String])
    case GetViettelPayResult(param: [String: String])
    case getVendorCurator_Getvendor
    case getVendorCurator_GetHead_PD
    case getVendorCurator_GetCurator
    case getInfo_Curator(param: [String: String])
    case getVendorCurator_Saveinfo(param: [String: String])
    case vendorCurator_DeleteInfo(param: [String: String])
    case UpLoadImageSingle_TaoPhieuBH(param: [String: String])
    case register(params: [String: Any])
    case getEmployeeInfo(params: [String: String])
    case checkIn(params: [String: String])
    case updateOffEmployee(params: [String: String])
    case getListVendors
    case getHistoryCheckIn(params: [String: String])
    case getTonKhoShop(params: [String: String])
    case mpos_sp_UpdateTargetPD_GetPD
    case mpos_sp_UpdateTargerPD_GetInfo(params: [String: String])
    case mpos_sp_UpdateTargerPD_Delete(params: [String: String])
    case mpos_sp_UpdateTargerPD_Saveinfo(params: [String: String])
    case mpos_sp_CheckUpdateInfo_TraGop(param: [String: String])
    case sp_mpos_FRT_SP_SIM_loadDSGoiCuoc_ecom(params: [String: String])
    case mpos_FRT_MD_SP_MPOS_PhanLoai(params: [String: String])
    case mpos_FRT_MD_mpos_searchkeyword(params: [String: String])
    case mpos_FRT_SP_LoadSO_mpos_pre(params: [String: String])
    
    
    
    
    case sp_mpos_GetCRMCode_ByMail(params: [String: String])
    
    
    case sp_mpos_FRT_SP_comboPK_fix_Price(params: [String:String])
    case sp_mpos_FRT_SP_comboPK_calculator(params: [String:String])
    case sp_mpos_InstallCustInfo_CalllogCIC_CheckAndCreate(params: [String:String])
    case sp_mpos_FRT_SP_ESIM_getqrcode(params: [String: String])
    case sp_mpos_FRT_SP_Esim_getSeri(params: [String: String])
    case sp_mpos_FRT_SP_TraGop_LoadThongTin_LenDoiSP(params: [String:String])
    
    
    case sp_mpos_HuyCalllog_UQTN_HetHan(params: [String: String])
    case getAllCompanyAmortizations
    case sp_mpos_FRT_SP_Load_OutSide_Info(params: [String:String])
    case sp_mpos_FRT_SP_OutSide_LS_ThuHo(params: [String:String])
    case sp_mpos_FRT_SP_OutSide_LS_TheCao(params: [String:String])
    case sp_mpos_FRT_SP_OutSide_ls_naptien(params: [String:String])
    
    case ViettelPayTopup(params: [String:String])
    
    
    ////thay sim
    case VTChangeSimErp(params: [String: Any])
    case VTGetSimInfoByPhoneNumber(params: [String: String])
    case VTGetListCustomerByIsdnErp(params: [String: String])
    case VTGetReasonCodes(params: [String: String])
    case VTGetChangeSimHistory(params: [String: String])
    case GetProvincesSim(params: [String: String])
    
    //bo sung thay sim
    case VTCheckSim(params: [String: String])
    case VTSendOTPErp(params: [String: String])
    
    //cap nhat pg
    
    
    case sp_mpos_Getinfo_SaoKeLuong(params: [String:String])
    case sp_mpos_info_SaoKeLuong_Huy(params: [String:String])
    case sp_mpos_Update_ThongTinSaoKeLuong(params: [String:String])
    case UploadImage_CalllogScoring(params: [String:String])
    case sp_mpos_UploadImageScoring(params: [String:String])
    case sp_mpos_Scoring_CheckDiemLietFRT(params: [String:String])
    case sp_mpos_Scoring_CheckDiemLietFRT_ByCMND(params: [String:String])
    case sp_mpos_Scoring_LoadKyHanTraGop(params: [String:String])
    case sp_mpos_FRT_SP_combopk_searchsp(params: [String:String])
    
    
    
    case confirmPasswordUpdatePG(params: [String: String])
    case sp_mpos_FRT_SP_GetFormNotiHome(params: [String: String])
    case thong_bao_tai_lieu
    case sp_mpos_FRT_SP_Camera_listShopByUser(params: [String: String])
    case sp_mpos_FRT_SP_Camera_getLinkDetail_online(params: [String: String])
    case mpos_UploadImage_CalllogInside(params: [String: String])
    case mpos_FRT_SP_Calllog_createissue(params: [String: String])
    
    case mpos_sp_GetVendor_DuoiEmail(params: [String: String])
    case mpos_sp_GetVendor_ChucVu(params: [String: String])
    case mpos_sp_GetVendor_ChiNhanhDN(params: [String: String])
    case getVendorFFriend_V2(params: [String: String])
    case sp_mpos_CheckHanMucKH(params: [String: String])
    
    case getProvidersGrab(params: [String: String])
    case payOfflineBillBE(params: [String: String])
    case PayOfflineBillBEHistory_Grab(params: [String: String])
    
    //tra gop mirae
    case mpos_FRT_SP_mirae_checkinfocustomer(params: [String: String])
    case mpos_FRT_SP_Mirae_loadTypeDoc(params: [String: String])
    case mpos_FRT_SP_Mirae_loadProvince(params: [String: String])
    case mpos_FRT_SP_Mirae_loadDistrict(params: [String: String])
    case mpos_FRT_SP_Mirae_loadPrecinct(params: [String: String])
    case mpos_FRT_SP_Mirae_Insert_image_contract(params: [String: String])
    case mpos_FRT_SP_Mirae_create_infoCustomer(params: [String: String])
    case mpos_FRT_SP_mirae_loadinfoByCMND(params: [String: String])
    case mpos_FRT_SP_Mirae_loadscheme(params: [String: String])
    case mpos_FRT_SP_mirae_loadDueDay(params: [String: String])
    case mpos_FRT_SP_Mirae_laythongtinkhachhang_order(params: [String: String])
    case mpos_FRT_SP_mirae_Getinfo_byContractNumber(params: [String: String])
    case mpos_FRT_SP_Mirae_LoadKyHan(params: [String: String])
    case UploadImage_Mirae(params: [String: String])
    case mpos_FRT_SP_mirae_history_order_byuser(params: [String: String])
    case saveOrderMirae(params: [String: String])
    case mpos_FRT_SP_mirae_history_order_byID(params: [String: String])
    case mpos_FRT_SP_mirae_cance_hopdong(params: [String: String])
    case mpos_FRT_SP_mirae_finish_hopdong(params: [String: String])
    case mpos_Mirae_UpdateImei(params: [String: String])
    case mpos_ReSubmitAplication(params: [String: String])
    case mpos_ConfirmUploadComplete(params: [String: String])
    case mpos_FRT_SP_Mirae_DS_sanpham(params: [String:String])
    case BaoLoiNguoiDung__GetConv(params: [String: String])
    case BaoLoiNguoiDung__PushConv(params: [String: String])
    case mpos_FRT_SP_mirae_loadreasoncance(params: [String: String])
    
    //cham diem
    //get
    case Score_GetListObject(params: [String:String])
    case Score_GetGroupItem(params: [String:String])
    case Score_GetContentGroupItem(params: [String:String])
    
    //post
    case Score_GetListScore(params: [String:String])
    case Score_CreateObject(params: [String:Any])
    case Score_CreateGroupItem(params: [String:Any])
    case Score_CreateContentScore(params: [String:Any])
    case Score_SendRequestScoreToSM(params: [String:Any])
    case Score_InActiveOGC(params: [String:Any])
    case Score_GetImageListContent(params: [String:Any])
    case Score_UploadImage(params: [String:Any])
    case Score_CreateRequestScore(params: [String:Any])
    case Score_UpdateRequestScore(params: [String:Any])
    case Score_UpdateObject(params: [String:Any])
    case Score_UpdateGroupItem(params: [String:Any])
    case Score_UpdateContentScore(params: [String:Any])
    
    //back to school
    
    case BackToSchool_CheckSBD(params: [String: String])
    case BackToSchool_LoadThongTinKHBySBD(params: [String: Any])
    case BackToSchool_UploadImage(params: [String:String])
    case BackToSchool_UpdateThongTinKhachHang(params: [String: Any])
    case BackToSchool_UpdateHinhAnh(params: [String: Any])
    case backToSchool_InsertData_SinhVienFPT(params: [String:Any])
    case backToSchool_TimKiem_ByKey(params: [String:Any])
    case backToSchool_TimKiem_ByUser(params: [String:Any])
    case backToSchool_HuyVoucher(params: [String:Any])
    case backToSchool_LoadHistoryKHBySBD(params: [String : Any])
    
    //Sendo
    case FRT_SP_linksendo(params: [String:String])
    
    //Nop quy NH
    
    case PaymentOfFunds_GetList(params: [String:String])
    case PaymentOfFunds_CallLogNopQuy(params: [String:String])
    case PaymentOfFunds_Update(params: [String:Any])
    case PaymentOfFunds_UploadImage(params: [String:String])
    
    case sp_FRT_Web_BrowserPaymentRequest_GetBank
    case sp_FRTCallLog_Web_BrowserPaymentRequest_GetWarehouseByType(params: [String: String])
    case sp_FRT_Web_BrowserPaymentRequest_GetTinhThanh
    case sp_FRT_Web_BrowserPaymentRequest_GetQuanHuyen(params: [String: String])
    case sp_FRT_Web_BrowserPaymentRequest_GetLoaiKyHD
    case sp_FRT_Web_BrowserPaymentRequest_GetDonVi
    case sp_FRT_Web_BrowserPaymentRequest_GetKyHan
    case sp_FRTCallLog_Web_CreateRequestPaymentHomeFromMobile(params: [String: String])
    case Uploads_FileAttachs(params: [String: String])
    case sp_FRT_Web_BrowserPaymentRequest_GetHistory(params: [String: String])
    case mpos_FRT_RequestPaymentHome_UploadImage(params: [String: String])
    case GetinfoCustomerByImageIDCard(params: [String: String])
    case GenerateBirthdayOnMarchVoucher(params: [String: String])
    //ViettelPay
    case otpCashInVTPayEx(params: [String: String])
    case getFeeEx(params: [String:String])
    case makeTransfer(params:[String:String])
    
    case getMakeTransferHeaders(params:[String:String])
    case GetMakeTransferDetails(params:[String:String])
    case partnerCancel(params:[String:String])
    case editTransfer(params: [String:String])
    case initTransfer(params: [String:String])
    case getFeeCashInEx(params: [String:String])
    case cashIn(params: [String:String])
    case GetInitTransferHeaders(params: [String:String])
    case GetInitTransferDetails(params: [String:String])
    case confirmDelivery(params: [String:String])
    case GetCashInHeaders(params: [String:String])
    case GetCashInDetails(params: [String:String])
    case getTransInfoEx(params: [String:String])
    case resetReceiptCodeEx(params: [String:String])
    case initTransferEx(params: [String:String])
    case confirmCancel(params: [String:String])
    case SaveSignatureOfCust(params: [String:String])
    case CheckCustFeeBack(params: [String:String])
    case mpos_DetectIDCard(params: [String:String])
    case mpos_FRT_SP_mirae_load_by_SOPOS(params: [String:String])
    
    case sp_mpos_FRT_SP_Notify_Confirm(params: [String:String])
    
    //Search MatKinh DongHo
    case SearchProductWithItemCode(params:[String:String])
    case SearchProductWithPlace(params:[String:String])
    //dat coc mirae
    case mpos_FRT_Mirae_getAll_Documents(params: [String:String])
    case mpos_FRT_Mirae_Check_Documents_Info(params: [String:String])
    case mpos_FRT_Mirae_Update_WaybillNumber(params: [String:Any])
    case mpos_FRT_Mirae_LoadInfo_Send_Bill
    case mpos_FRT_SP_Mirae_loadTienCTMayCu(params: [String:String])
    //dinh gia may cu
    case mpos_FRT_SP_ThuMuaMC_get_list_detail(params: [String:String])
    case mpos_FRT_SP_ThuMuaMC_get_list_Loai(params: [String:String])
    case mpos_FRT_SP_ThuMuaMC_get_list(params: [String:String])
    case mpos_FRT_SP_ThuMuaMC_get_info(params: [String:String])
    
    case inov_masterDataLyDoGiamGia(params: [String: String])
    case inov_listTonKhoSanPham(params: [String: String])
    case checkPromotionImeis(params: [String: String])
    case mpos_sp_zen_vocuher_pos(params: [String: String])
    case sp_mpos_Get_PaymentType_From_POS(params: [String: String])
    case mpos_verify_maxacthuc_point(params: [String: String])
    case mpos_sp_verify_VC_mpos_innovation(params: [String: String])
    case genQRCode(params: [String: String])
    case checkTransactionQR(params: [String: String])
    case FRT_SP_GetSMS_loyaty(params: [String: String])
    case sp_mpos_FRT_SP_innovation_checkgiamgiatay(params: [String: String])
    case sp_mpos_FRT_SP_innovation_check_IQcode(params: [String: String])
    
    case mpos_FRT_UploadImage_Warranty(params: [String: String])
    case mpos_sp_GetImageWarrantyByDocEntry(params: [String: String])
    case checkPromotionMirae(params:Dictionary<String, Any>)
    case getImeiFF(productCode:String,shopCode:String)
    case mpos_FRT_SP_mirae_tinhsotienchenhlech(params: [String: Any])
    case mpos_GetPlayBackCamera(params: [String: String])
    case mpos_FRT_Report_InstallApp(params: [String: String])
    case mpos_FRT_Mirae_Send_Documents_Info(params: [String: Any])
    case mpos_FRT_SP_Mirae_noteforsale(params: [String: Any])
    case mpos_FRT_SP_mirae_history_order_byuser_HD_pending(params: [String: String])
    case sp_mpos_FRT_SP_innovation_loadDS_nhanvien(params: [String: String])
    
    
    //Máy cũ_Ecom
    case Maycu_Ecom_GetListProduct(params: [String: String])
    case Maycu_Ecom_GetColor_Product(params: [String: String])
    case MayCu_Ecom_Update(params: [String: String])
    case MayCuEcom_GetItemDetail(params: [String: String])
    
    case getSODetailFF(params: [String: String])
    //moca
    case Moca_CreateQRCodeMobile(params: [String: String])
    case Moca_Inquiry(params: [String: String])
    case checkTransactionMocaByItemCode(params: [String: String])
    
    case Report_InstallApp_Utop(params: [String: String])
    //vnpt
    case mpos_FRT_SP_VNPT_loadinfoByCMND(params: [String: String])
    case mpos_FRT_SP_VNPT_sendotp(params: [String: String])
    case mpos_FRT_SP_VNPT_create_info(params: [String: String])
    case mpos_FRT_SP_VNPT_upload_anhKH(params: [String: String])
    case mpos_FRT_Image_VNPT(params: [String: String])
    case saveOrderVNPT(params:Dictionary<String, Any>)
    case checkPromotionVNPT(param:Dictionary<String, Any>)
    case mpos_FRT_SP_VNPT_load_history(params: [String: String])
    case mpos_FRT_sp_vnpt_update_image_KH(params: [String: String])
    case mpos_FRT_SP_Ecom_FFriend_load_SOEcom(params: [String: String])
    
    //bao hiem
    case mpos_FRT_SP_BH_insert_thongtinKH(params: [String: String])
    case mpos_FRT_SP_BH_history_thongtinKH(params: [String: String])
    //cr mirae popup
    case mpos_FRT_Mirae_NotiAfterUploadImageComplete(params: [String: String])
    case mpos_FRT_Mirae_CreateCalllog_DuyetHinhAnh(params: [String: String])
    case mpos_FRT_SP_Mirae_history_order_byKeyword(params: [String: String])
    
    case mpos_FRT_Flight_Tripi_InsertBooking(params: [String: String])
    case mpos_FRT_Flight_Tripi_ConfirmBooking(params: [String: String])
    case mpos_FRT_Flight_Tripi_GetHistory(params: [String: String])
    case mpos_FRT_Flight_Tripi_GetDetailInfor(params: [String: String])
    
    //Calllog TRIPI
    case Flight_Tripi_CreateCalllog(params: [String: String])
    case Flight_Tripi_GetConversation_CreateCalllog(params: [String: String])
    case Get_Info_FF_From_QRCode(params: [String: String])
    case mpos_FRT_SP_mirae_sendsms(params: [String: String])
    
    //sktelink
    case mpos_FRT_SP_SK_viewdetail_all(params: [String: String])
    case mpos_FRT_SP_SK_viewdetail_Rcheck(params: [String: String])
    case mpos_FRT_SP_SK_load_header(params: [String: String])
    case mpos_FRT_SP_SK_Rcheck_insert(params: [String: String])
    case mpos_FRT_SP_SK_confirm_rcheck(params: [String: String])
    case mpos_FRT_Image_SKTelink(params: [String: String])
    case mpos_FRT_SP_SK_header_complete_detail(params: [String: String])
    case mpos_FRT_SP_SK_header_complete(params: [String: String])
    case mpos_FRT_SP_SK_confirm_book_order(params: [String: String])
    case mpos_FRT_SP_SK_cance_order(params: [String : Any])
    case mpos_FRT_SP_SK_view_detail_after_sale_rightphone(params: [String: String])
    case mpos_FRT_SP_SK_view_image(params: [String: String])
    case mpos_FRT_SP_SK_nganhang_type(params: [String: String])
    case mpos_FRT_SP_SK_Send_OTP(params: [String: String])
    case mpos_FRT_SP_SK_nganhang(params: [String: String])
    case mpos_FRT_SP_SK_load_tinh(params: [String: String])
    case mpos_FRT_SP_SK_TaoPhieuRcheck(params: [String: String])
    case mpos_FRT_SP_SK_Load_TienRcheck(params: [String: String])
    case mpos_FRT_SP_SK_update_info(params: [String: String])
    case mpos_FRT_SP_SK_confirm_upanh_xacnhan(params: [String: String])
    case Tintuc_detail_baiviet(params: [String: String])
    case mpos_FRT_SP_list_PMHThayThePK_ecom(params: [String: String])
    case checkpromotionfrtBaoHiem(params: [String: String])
    case mpos_CheckEmail_Vendor_SendOTP(params: [String: String])
    case getTinTuc_New(params: [String: String])
    case mpos_FRT_MayCuEcom_UploadImage(params: [String: String])
    case mpos_FRT_MayCuEcom_GetHinhMau(params: [String: String])
    //smartPay
    case CreateOrderForMobile(params: [String: String])
    case QueryOrderSmartPay(params: [String: String])
    case mpos_FRT_SP_SK_Load_default_imei(params: [String: String])
    
    //May demo bh
    case Products_Demo_Warranty_ListProduct(params: [String: String])
    case Products_Demo_Warrant_Product_Type_ImageAndError(params: [String: String])
    case Products_Demo_Warranty_Update(params: [String: String])
    case Products_Demo_Upload_Image_May_Demo(params: [String: String])
    case Products_Demo_Warranty_Product_GetDetailsItem(params: [String: String])
    case mpos_FRT_SP_check_VC_crm(params: [String: String])
    case mpos_FRT_SP_check_otp_VC_CRM(params: [String: String])
    case CustomerResult_HDItel(params:Dictionary<String, Any>)
    //sms_banking
    case mpos_FRT_SMS_Banking_GetSMS(params: [String: String])
    case mpos_FRT_SP_GetCode_QRcode_payment(params: [String: String])
    case mpos_FRT_SP_GetCode_QRcode_payment_Airpay(params: [String: Any])
    case mpos_FRT_SP_GetCode_QRcode_payment_AirpayStatus(params: [String: Any])
    case mpos_FRT_SP_VC_get_list_voucher_by_phone(params: [String: String])
    case mpos_FRT_ActiveSim_VNM_Swap_Info_GetData(params: [String: String])
    //chi tiet don hang new
    case mpos_sp_Order_getSOdetails(params: [String: String])
    case GetPayTeleChargeVTInfo(params: [String: String])
    //Viettel tra sau
    case ViettelPay_RegisterAuthority(params: [String: String])
    case ViettelPay_ConfirmAuthority(params: [String: String])
    case ViettelPay_GetPayTeleCharge(params: [String: String])
    case ViettelPay_PayTeleCharge(params: [String: String])
    //thu ho smartpay
    case THSmartPay_CheckInfo(params: [String: String])
    case THSmartPay_RepaymentForMobile(params: [String: String])
    //hop dong thue nha
    case sp_FRTCallLog_Web_BrowserPaymentRequest_GetOrganizationHierachies
    case sp_FRT_Web_BrowserPaymentRequest_GetThue
    //CRlaptop
    case getReceiptMasterData(params: [String: Any])
    case CreateInstallationReceipt(params: [String: Any])
    case GetInstallationReceiptList(params: [String: Any])
    case GetInstallationReceiptDetailByReceiptId(params: [String: Any])
    case checkBtsUploaded(params: [String: Any])
    case updateBTSMdeli(params: [String: Any])
    case sendOTPForCustomer(params: [String: Any])
    case confirmOTPReceipt(params: [String: Any])
    case returnDeviceReceipt(params: [String: Any])
    case deleteInstallatioReceipt(params: [String: Any])

    
    //Foxpay
    case mpos_FRT_SP_GetCode_QRcode_payment_Foxpay(params: [String: Any])
    case mpos_FRT_SP_GetCode_QRcode_payment_FoxpayStatus(params: [String: Any])

    //    //Noti Sau cham cong
    case sp_mpos_FRT_SP_GetNotiSauChamCong(params: [String: String])

}
extension MPOSAPIService: TargetType {
    private static var _defaults = UserDefaults.standard
    private static var _manager = Config.manager
    
    var baseURL: URL {
        switch self {
        case .GetPayCodeList,.GetTopUpList,.checkpromotionActivedSim,.GetCheckVoucher,.GetTopUpPrice,.GetPayooTopup,.GetPayCodePrice,.GetViettelPayResult,.GetPayooPayResult,.GetVietNamMobileTheCaoPayResult,.GetBill,.GetProvidersNew,.GetEncashpayooResult,.GetListCustomer,.GetFtelLocations,.GetAgumentFtel,.GetPaymentFtel,.sp_mpos_FRT_SP_Load_OutSide_Info,.sp_mpos_FRT_SP_OutSide_LS_ThuHo,.sp_mpos_FRT_SP_OutSide_LS_TheCao,.sp_mpos_FRT_SP_OutSide_ls_naptien,.ViettelPayTopup,.sp_FRT_Web_BrowserPaymentRequest_GetHistory,.sp_FRT_Web_BrowserPaymentRequest_GetBank,.sp_FRTCallLog_Web_BrowserPaymentRequest_GetWarehouseByType,.sp_FRT_Web_BrowserPaymentRequest_GetTinhThanh,.sp_FRT_Web_BrowserPaymentRequest_GetLoaiKyHD,.sp_FRT_Web_BrowserPaymentRequest_GetDonVi,.sp_FRT_Web_BrowserPaymentRequest_GetKyHan,.sp_FRTCallLog_Web_CreateRequestPaymentHomeFromMobile,.sp_FRT_Web_BrowserPaymentRequest_GetQuanHuyen,.mpos_FRT_RequestPaymentHome_UploadImage,.getOCRDFFriend,.mpos_sp_LichSuMuahang,.sp_mpos_InstallCustInfo_CalllogCIC_CheckAndCreate,.sp_mpos_Scoring_CheckDiemLietFRT_ByCMND,.getVendorFFriend_V2,.mpos_sp_GetVendor_ChucVu,.mpos_sp_GetVendor_ChiNhanhDN,.getThongTinNganHangFFriend,.mpos_sp_GetVendor_DuoiEmail,.getTinhThanhFFriend,.mpos_sp_LoadTinhThanhPho,.mpos_sp_LoadQuanHuyen,.mpos_sp_GetMoiLienHeVoiNguoiLL,.sp_mpos_CheckCreateCustomer,.sp_mpos_UploadImageScoring,.AddCustomerFFriend,.mpos_sp_PrintUQTNPOS,.sp_mpos_Getinfo_SaoKeLuong,.sp_mpos_info_SaoKeLuong_Huy,.sp_mpos_Update_ThongTinSaoKeLuong,.mpos_sp_SendOTPCustomerFriend,.mpos_sp_insert_order_ffriend,.sp_mpos_HuyCalllog_UQTN_HetHan,.mpos_sp_PrintPhieuDKPOS,.checkPromotionFF,.sp_mpos_Scoring_LoadKyHanTraGop,.getHinhThucGiaoHangFFriend,.mpos_FRT_SP_Mirae_noteforsale,.mpos_sp_CheckUpdateInfo_TraGop,.sp_mpos_CheckHanMucKH,.getSODetailFF,.mpos_sp_CancelFormDKSingle_TraGopOnline,.Get_Info_FF_From_QRCode,.getListLoaiSimV2,.checkGoiCuocVaSim,.getSearchSimV2,.FRT_SP_CRM_DSNhaMang_bookSim,.sp_mpos_FRT_SP_SIM_loadDSGoiCuoc_ecom,.dangKyBookSoV2,.getListSimBookByShopV2,.huyBookSoV2,.ActiveSim,.GetDistricts,.GetPrecincts,.GetProvinces,.AutoCreateImageActiveSimViettelHD,.AutoCreateImageActiveSimVNPhone,.AutoCreateImageActiveSimMobiPhone,.AutoCreateImageActiveSimVietnamobile,.getListCustomersViettel,.SearchNationality,.checkGoiCuocVNMobile,.GetinfoCustomerByImageIDCard,.GenerateBirthdayOnMarchVoucher,.getListLichSuKichHoat,.sp_mpos_FRT_SP_ESIM_getqrcode,.getListGoiCuocBookSimV2,.FRT_SP_mpos_loadSPTraGop,.getTonKhoShopGanNhat,.getListImeiBook,.getVendorInstallment,.loadDebitCustomer,.checkVoucherKMBookSim,.checkPromotionNew,.searchCustomersToshiba,.removeSO,.saveOrder,.mpos_sp_calllog_UpdateImei_Ecom,.mpos_sp_getVendors_All,.getVendorFFriend,.mpos_sp_GetBank_CreditNoCard,.mpos_sp_GetLink_CMND_UQTN_Credit,.mpos_sp_SearchVendor,.sp_mpos_CheckAccount_SkipOTP_ShopApDung,.CheckAccount_SkipOTP,.getThongTinGiaHanSSD,.uploadHinhGiaHanSSD,.giaHanSSDResult,.getOTPGiaHanSSD,.getListNhaThuoc,.getListNhanVienThuocLongChau,.insertThuHoLongChau,.SendOTPConvert4G,.changeSim4G,.getInfoActiveSimbyPhone,.SendOTPInfoActiveSim,.updateInfoVNM,.BaoHiem_GetHangXe,.BaoHiem_GetLoaiXe,.BaoHiem_GetSP,.BaoHiem_GetPhuongXa,.BaoHiem_GetQuan,.BaoHiem_GetDungTich,.BaoHiem_getGiaBan_BHX,.BaoHiem_getGiaBanAll_BHX,.BaoHiem_GetToken,.BaoHiem_GetTinhThanh,.BaoHiem_AddOrder,.GetSearchCustomers,.GetEncashAgribankResult,.getThongTinDatCoc,.sp_mpos_FRT_SP_SSD_SoSanhGoiSSD_GoiThuong,.VinaGame_InsertInstallapp,.VinaGame_GetListDH,.VinaGame_GetListDHIntalled,.getListNCC,.getListPOAll,.insertXMLNhapHang,.getHistoryNhapHang,.searchCNMD_subsidy,.checkCICKhachHang,.hoantatLockDevice,.loadInfoLockDevice,.inMoMo,.getDanhSachPhieuMoMo,.GetCRMPaymentHistory,.inRutTienMoMo,.getVendorCurator_Getvendor,.getVendorCurator_GetHead_PD,.getVendorCurator_GetCurator,.getInfo_Curator,.getVendorCurator_Saveinfo,.vendorCurator_DeleteInfo,.getTonKhoShop,.mpos_sp_UpdateTargetPD_GetPD,.mpos_sp_UpdateTargerPD_GetInfo,.mpos_sp_UpdateTargerPD_Delete,.mpos_sp_UpdateTargerPD_Saveinfo,.mpos_FRT_MD_SP_MPOS_PhanLoai,.mpos_FRT_MD_mpos_searchkeyword,.mpos_FRT_SP_LoadSO_mpos_pre,.sp_mpos_GetCRMCode_ByMail,.sp_mpos_FRT_SP_comboPK_fix_Price,.sp_mpos_FRT_SP_comboPK_calculator,.sp_mpos_FRT_SP_Esim_getSeri,.sp_mpos_FRT_SP_TraGop_LoadThongTin_LenDoiSP,.sp_mpos_Scoring_CheckDiemLietFRT,.sp_mpos_FRT_SP_combopk_searchsp,.mpos_UploadImage_CalllogInside,.mpos_FRT_SP_Calllog_createissue,.getProvidersGrab,.payOfflineBillBE,.PayOfflineBillBEHistory_Grab,.mpos_FRT_SP_mirae_checkinfocustomer,.mpos_FRT_SP_Mirae_loadTypeDoc,.mpos_FRT_SP_Mirae_loadProvince,.mpos_FRT_SP_Mirae_loadDistrict,.mpos_FRT_SP_Mirae_loadPrecinct,.mpos_FRT_SP_Mirae_Insert_image_contract,.mpos_FRT_SP_Mirae_create_infoCustomer,.mpos_FRT_SP_mirae_loadinfoByCMND,.mpos_FRT_SP_Mirae_loadscheme,.mpos_FRT_SP_mirae_loadDueDay,.mpos_FRT_SP_Mirae_laythongtinkhachhang_order,.mpos_FRT_SP_mirae_Getinfo_byContractNumber,.mpos_FRT_SP_Mirae_LoadKyHan,.mpos_FRT_SP_mirae_history_order_byuser,.saveOrderMirae,.mpos_FRT_SP_mirae_history_order_byID,.mpos_FRT_SP_mirae_cance_hopdong,.mpos_FRT_SP_mirae_finish_hopdong,.mpos_Mirae_UpdateImei,.mpos_ReSubmitAplication,.mpos_ConfirmUploadComplete,.mpos_FRT_SP_Mirae_DS_sanpham,.Score_GetListObject,.Score_GetGroupItem,.Score_GetContentGroupItem,.Score_GetListScore,.Score_CreateObject,.Score_CreateGroupItem,.Score_CreateContentScore,.Score_SendRequestScoreToSM,.Score_InActiveOGC,.Score_GetImageListContent,.getToshibaPoint,.Score_UploadImage,.Score_CreateRequestScore,.Score_UpdateRequestScore,.Score_UpdateObject,.Score_UpdateGroupItem,.Score_UpdateContentScore,.inov_masterDataLyDoGiamGia,.inov_listTonKhoSanPham,.checkPromotionImeis,.sp_mpos_Get_PaymentType_From_POS,.genQRCode,.checkTransactionQR,.sp_mpos_FRT_SP_innovation_checkgiamgiatay,.sp_mpos_FRT_SP_innovation_check_IQcode,.BackToSchool_CheckSBD,.BackToSchool_UploadImage,.BackToSchool_UpdateThongTinKhachHang,.BackToSchool_UpdateHinhAnh,.BackToSchool_LoadThongTinKHBySBD,.FRT_SP_linksendo,.mpos_FRT_SP_mirae_loadreasoncance,.PaymentOfFunds_GetList,.PaymentOfFunds_CallLogNopQuy,.PaymentOfFunds_Update,.PaymentOfFunds_UploadImage,.otpCashInVTPayEx,.getFeeEx,.makeTransfer,.getMakeTransferHeaders,.GetMakeTransferDetails,.partnerCancel,.editTransfer,.initTransfer,.getFeeCashInEx,.cashIn,.GetInitTransferHeaders,.GetInitTransferDetails,.confirmDelivery,.GetCashInHeaders,.GetCashInDetails,.getTransInfoEx,.resetReceiptCodeEx,.initTransferEx,.confirmCancel,.SaveSignatureOfCust,.CheckCustFeeBack,.mpos_DetectIDCard,.mpos_FRT_SP_mirae_load_by_SOPOS,.sp_mpos_FRT_SP_Notify_Confirm,.SearchProductWithItemCode,.SearchProductWithPlace,.mpos_FRT_UploadImage_Warranty,.mpos_sp_GetImageWarrantyByDocEntry,.mpos_FRT_Mirae_getAll_Documents,.mpos_FRT_Mirae_Send_Documents_Info,.mpos_FRT_Mirae_Update_WaybillNumber,.mpos_FRT_Mirae_LoadInfo_Send_Bill,.mpos_FRT_SP_Mirae_loadTienCTMayCu,.mpos_FRT_SP_ThuMuaMC_get_list_detail,.mpos_FRT_SP_ThuMuaMC_get_list_Loai,.mpos_FRT_SP_ThuMuaMC_get_list,.mpos_FRT_SP_ThuMuaMC_get_info,.checkPromotionMirae,.mpos_FRT_SP_mirae_tinhsotienchenhlech,.mpos_FRT_Mirae_Check_Documents_Info,.mpos_FRT_SP_mirae_history_order_byuser_HD_pending,.sp_mpos_FRT_SP_innovation_loadDS_nhanvien,.Moca_CreateQRCodeMobile,.Moca_Inquiry,.Report_InstallApp_Utop,.mpos_FRT_SP_VNPT_loadinfoByCMND,.mpos_FRT_SP_VNPT_sendotp,.mpos_FRT_SP_VNPT_create_info,.mpos_FRT_SP_VNPT_upload_anhKH,.mpos_FRT_Image_VNPT,.saveOrderVNPT,.checkPromotionVNPT,.mpos_FRT_SP_VNPT_load_history,.mpos_FRT_sp_vnpt_update_image_KH,.mpos_FRT_SP_Ecom_FFriend_load_SOEcom,.mpos_FRT_Mirae_NotiAfterUploadImageComplete,.mpos_FRT_Mirae_CreateCalllog_DuyetHinhAnh,.mpos_FRT_SP_Mirae_history_order_byKeyword,.mpos_FRT_Flight_Tripi_InsertBooking,.mpos_FRT_Flight_Tripi_ConfirmBooking,.mpos_FRT_Flight_Tripi_GetHistory,.mpos_FRT_Flight_Tripi_GetDetailInfor,.Flight_Tripi_CreateCalllog,.Flight_Tripi_GetConversation_CreateCalllog,.mpos_FRT_SP_mirae_sendsms,.mpos_FRT_SP_SK_viewdetail_all,.mpos_FRT_SP_SK_viewdetail_Rcheck,.mpos_FRT_SP_SK_load_header,.mpos_FRT_SP_SK_Rcheck_insert,.mpos_FRT_SP_SK_confirm_rcheck,.mpos_FRT_Image_SKTelink,.mpos_FRT_SP_SK_header_complete_detail,.mpos_FRT_SP_SK_header_complete,.mpos_FRT_SP_SK_confirm_book_order,.mpos_FRT_SP_SK_cance_order,.mpos_FRT_SP_SK_view_detail_after_sale_rightphone,.mpos_FRT_SP_SK_view_image,.mpos_FRT_SP_SK_nganhang_type,.mpos_FRT_SP_SK_Send_OTP,.mpos_FRT_SP_SK_nganhang,.mpos_FRT_SP_SK_load_tinh,.mpos_FRT_SP_SK_TaoPhieuRcheck,.mpos_FRT_SP_SK_Load_TienRcheck,.mpos_FRT_SP_SK_update_info,.mpos_FRT_SP_SK_confirm_upanh_xacnhan,.mpos_FRT_SP_list_PMHThayThePK_ecom,.checkpromotionfrtBaoHiem,.mpos_CheckEmail_Vendor_SendOTP,.CreateOrderForMobile,.QueryOrderSmartPay,.getTinTuc_New,.mpos_FRT_SP_SK_Load_default_imei, .Products_Demo_Warranty_ListProduct, .Products_Demo_Warrant_Product_Type_ImageAndError, .Products_Demo_Warranty_Update, .Products_Demo_Upload_Image_May_Demo, .Products_Demo_Warranty_Product_GetDetailsItem,.mpos_FRT_SP_check_VC_crm,.mpos_FRT_SP_check_otp_VC_CRM,.CustomerResult_HDItel, .mpos_FRT_SMS_Banking_GetSMS,.mpos_FRT_SP_GetCode_QRcode_payment,.mpos_FRT_SP_VC_get_list_voucher_by_phone,.mpos_FRT_ActiveSim_VNM_Swap_Info_GetData, .mpos_sp_Order_getSOdetails,.getEmployeeSOHeaders, .backToSchool_InsertData_SinhVienFPT, .backToSchool_TimKiem_ByKey, .backToSchool_TimKiem_ByUser, .backToSchool_HuyVoucher, .GetPayTeleChargeVTInfo, .backToSchool_LoadHistoryKHBySBD, .sp_FRTCallLog_Web_BrowserPaymentRequest_GetOrganizationHierachies, .sp_FRT_Web_BrowserPaymentRequest_GetThue,.getReceiptMasterData,.CreateInstallationReceipt,.GetInstallationReceiptList,.GetInstallationReceiptDetailByReceiptId, .checkBtsUploaded,.updateBTSMdeli,.getPriceDatCoc,.sendOTPForCustomer,.confirmOTPReceipt,.returnDeviceReceipt,.deleteInstallatioReceipt,.getPriceGoiBH,.getListLichSuKichHoatSerial,.checkTransactionMocaByItemCode:

            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)")!

        case .mpos_FRT_SP_GetCode_QRcode_payment_Airpay,.mpos_FRT_SP_GetCode_QRcode_payment_AirpayStatus:
            return URL(string: "\(Config.manager.URL_GATEWAY!)/mpos-cloud-api")!
        case .mpos_FRT_SP_GetCode_QRcode_payment_Foxpay,.mpos_FRT_SP_GetCode_QRcode_payment_FoxpayStatus:
            return URL(string: "\(Config.manager.URL_GATEWAY!)/mpos-cloud-api")!
        case .GetTopupVNM:
            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)")!
        case .Get_CardType_From_POS:
            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)")!
        case .GoiPopupHang_Mobile,.TaoPhieuBH_AutoMailChoHang,.Checkimei_V2,.LayHinhThucBanGiaoChoBHV,.LoadHinhThucBanGiao,.TaoPhieuBH_NgayHenTra,.BaoHanhUploadImageNew,.TaoPhieuBH_UpLoadImage,.GetBaoHanhPhuKien,.TaoPhieuBH_LuuPhieuBH,.LayTinhTrangMay,.GetImageBienBanBH,.TaoPhieuBH_Timsanpham,.LayThongTinHinhThucBH,.Checkimei_V2_More,.GetLoadThongTinPhieuTraKH,.GetLoadThongTinBBTraMay,.GetDongBoKnox,.baoHanhPhuKien_SearchLichSu,.baoHanhPhuKien_LoadLoai,.LoadThongTinTimKiemThem_Mobile,.UpLoadImageSingle_TaoPhieuBH:
            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)")!
        case .GetListSearchOldProduct,.getListOldProduct:
            return URL(string: "\(MPOSAPIService._manager.URL_API!)")!
        case .getAllAmortizationsProperties,.getAllAmortizationsPrePays,.getAllAmortizationsTerms,.checkInventory,.getImei,.getEcomSOHeader,.getSODetails,.mpos_sp_GetInfoSubsidy,.GetPasscode_Form2Key,.sp_mpos_Get_SSD_GoiCuoc_for_MPOS,.mpos_sp_Get_ThongTinSSD_ChiTietGoiCuoc,.mpos_sp_Get_ThongTinSSD_from_itemcode_goicuoc,.sp_mpos_SSD_MSP_SIM_10_11_for_MPOS,.sp_mpos_GetList_ItemCodeSubSidy,.getAllCompanyAmortizations,.mpos_sp_zen_vocuher_pos,.mpos_verify_maxacthuc_point,.mpos_sp_verify_VC_mpos_innovation,.FRT_SP_GetSMS_loyaty,.getImeiFF:
            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)")!
        case .getAmortizationsDefinitions,.getAmortizationsDefinitionsDetail:
            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)")!
        case .mpos_sp_SaveImageFriend_ChungTuDoiTra:
            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)")!
        case .sp_CreditNoneCard_UploadImage_RequestV2,.UploadImage_CreditNoCard,.mpos_sp_SaveImageFriend,.uploadImageLockDevice,.UploadImage_Mirae:
            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)")!
        case .register, .getEmployeeInfo, .checkIn, .updateOffEmployee, .getListVendors, .getHistoryCheckIn, .VTChangeSimErp, .VTGetSimInfoByPhoneNumber, .VTGetListCustomerByIsdnErp, .VTGetReasonCodes, .VTGetChangeSimHistory, .GetProvincesSim, .confirmPasswordUpdatePG, .VTCheckSim, .VTSendOTPErp, .mpos_FRT_Report_InstallApp, .Maycu_Ecom_GetListProduct, .Maycu_Ecom_GetColor_Product, .MayCu_Ecom_Update, .MayCuEcom_GetItemDetail, .mpos_FRT_SP_BH_insert_thongtinKH, .mpos_FRT_SP_BH_history_thongtinKH,.mpos_FRT_MayCuEcom_UploadImage, .mpos_FRT_MayCuEcom_GetHinhMau, .ViettelPay_RegisterAuthority, .ViettelPay_ConfirmAuthority, .ViettelPay_GetPayTeleCharge, .ViettelPay_PayTeleCharge, .THSmartPay_CheckInfo, .THSmartPay_RepaymentForMobile:
            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)")!
        case .sp_mpos_FRT_SP_Camera_listShopByUser,.sp_mpos_FRT_SP_Camera_getLinkDetail_online,.sp_mpos_FRT_SP_GetFormNotiHome,.sp_mpos_FRT_SP_GetNotiSauChamCong,.thong_bao_tai_lieu:
            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)")!
        case .BaoLoiNguoiDung__GetConv,.BaoLoiNguoiDung__PushConv:
            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)/mpos-cloud-callog")!
        case .Uploads_FileAttachs:
            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)/mpos-cloud-callog")!
        case .mpos_sp_UploadHinhAnhPDK:
            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)")!
        case .UploadImage_CalllogScoring,.mpos_sp_UploadChungTuHinhAnh,.mpos_sp_SaveImageFriend_ChanDung:
            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)")!
        case .mpos_GetPlayBackCamera:
            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)")!
        case .Tintuc_detail_baiviet:
            return URL(string: "\(MPOSAPIService._manager.URL_TINTUC!)")!
        case .updateDeviceInfo:
            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)/mpos-cloud-api")!
//        case .sendOTPForCustomer:
//            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)")!
//        case .confirmOTPReceipt:
//            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)")!
//        case .returnDeviceReceipt:
//            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)")!
//        case .deleteInstallatioReceipt:
//            return URL(string: "\(MPOSAPIService._manager.URL_GATEWAY!)")!
        }
        
    }
    var path: String {
        switch self {
        case .updateDeviceInfo:
            return "/api/Notification/FRT_Notification_DeviceInfo_ReceiveData"
        case .FRT_SP_mpos_loadSPTraGop(_,_):
            return "/mpos-cloud-api/api/FFriend/FRT_SP_mpos_loadSPTraGop"
        case .getAmortizationsDefinitions(_,_):
            return "/mpos-cloud-api/api/product/getAmortizationsDefinitions"
        case .getAllAmortizationsProperties:
            return "/mpos-cloud-service/MPOSSale/Service.svc/getAllAmortizationsProperties"
        case .getAllAmortizationsPrePays:
            return "/mpos-cloud-service/MPOSSale/Service.svc/getAllAmortizationsPrePays"
        case .getAllAmortizationsTerms:
            return "/mpos-cloud-service/MPOSSale/Service.svc/getAllAmortizationsTerms"
        case .getAmortizationsDefinitionsDetail(_,_,_,_,_):
            return "/mpos-cloud-api/api/product/getAmortizationsDefinitionsDetail"
        case .checkInventory(_,_):
            return "/mpos-cloud-service/MPOSSale/Service.svc/checkInventory_V3"
        case .getTonKhoShopGanNhat(_,_):
            return "/mpos-cloud-api/api/product/getTonKhoShopGanNhat"
        case .getListImeiBook(_):
            return "/mpos-cloud-api/api/SIM/mpos_FRT_SP_ListIMEiBook"
        case .getVendorInstallment:
            return "/mpos-cloud-api/api/customer/getVendorInstallment"
        case .loadDebitCustomer(_):
            return "/mpos-cloud-api/api/customer/loadDebitCustomer"
        case .checkVoucherKMBookSim(_,_):
            return "/mpos-cloud-api/api/Subsidy/mpos_FRT_SP_checkVoucher_KM"
        case .checkPromotionNew(_):
            return "/mpos-cloud-api/api/order/checkPromotion_V2"
        case .searchCustomersToshiba(_):
            return "/mpos-cloud-api/api/customer/searchCustomers"
        case .getToshibaPoint(_):
            return "/mpos-cloud-api/api/customer/getToshibaPoint"
        case .getImei(_,_):
            return "/mpos-cloud-service/MPOSSale/Service.svc/getImei_V3"
        case .getImeiFF(_,_):
            return "/mpos-cloud-service/MPOSSale/Service.svc/getImei"
        case .removeSO(_):
            return "/mpos-cloud-api/api/Order/sp_mpos_CancelSO_New"
        case .saveOrder(_):
            return "/mpos-cloud-api/api/order/saveOrder_V2"
        case .getPriceDatCoc(_):
            return "/mpos-cloud-api/api/order/priceDocType05"
        case .getListLoaiSimV2:
            return "/mpos-cloud-api/api/Subsidy/sp_mpos_subsidy_Simtype"
        case .getSearchSimV2(_):
            return "/mpos-cloud-api/api/Subsidy/sp_mpos_FRT_SP_SearchSim_new"
        case .checkGoiCuocVaSim(_):
            return "/mpos-cloud-api/api/Subsidy/sp_mpos_Check_GoiCuocVaSim"
        case .dangKyBookSoV2(_):
            return "/mpos-cloud-api/api/Subsidy/sp_mpos_InsertBookSimNew"
        case .getListSimBookByShopV2(_):
            return "/mpos-cloud-api/api/Subsidy/sp_mpos_GetListBookSimNew"
        case .huyBookSoV2(_):
            return "/mpos-cloud-api/api/Subsidy/sp_mpos_HuyBookSim"
        case .GetDistricts(_,_):
            return "/mpos-cloud-api/api/area/GetDistricts"
        case .GetPrecincts(_,_,_):
            return "/mpos-cloud-api/api/area/GetPrecincts"
        case .SearchNationality(_):
            return "/mpos-cloud-api/api/sim/SearchNationality"
        case .GetProvinces(_):
            return "/mpos-cloud-api/api/area/GetProvinces"
        case .getListCustomersViettel(_):
            return "/mpos-cloud-api/api/sim/GetListCustomersViettel"
        case .checkGoiCuocVNMobile(_,_,_,_,_,_,_):
            return "/mpos-cloud-api/api/sim/CheckGoiCuocVNMobile"
        case .AutoCreateImageActiveSimViettelHD(_):
            return "/mpos-cloud-api/api/ImgActiveSim/CustomerResult_HDViettel"
        case .AutoCreateImageActiveSimVNPhone(_):
            return "/mpos-cloud-api/api/ImgActiveSim/CustomerResult_HDVNPhone"
        case .AutoCreateImageActiveSimMobiPhone(_):
            return "/mpos-cloud-api/api/ImgActiveSim/CustomerResult_HDMobiPhone"
        case .AutoCreateImageActiveSimVietnamobile(_):
            return "/mpos-cloud-api/api/ImgActiveSim/CustomerResult_HDVietNamMobile"
        case .ActiveSim(_):
            return "/mpos-cloud-api/api/sim/activeSim"
        case .GetListSearchOldProduct(_,_,_,_,_):
            return "/GetListSearchOldProduct"
        case .getListOldProduct(_,_,_,_):
            return "/GetListOldProduct"
        case .getEmployeeSOHeaders(_):
            return "/mpos-cloud-api/api/order/mpos_sp_Order_getListSO_With_Employee"
        case .getEcomSOHeader(_,_):
            return "/mpos-cloud-service/MPOSSale/Service.svc/getEcomSOHeader"
        case .getOCRDFFriend(_,_,_,_):
            return "/mpos-cloud-api/api/FFriend/getOCRDFFriend"
        case .mpos_sp_LichSuMuahang(_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_LichSuMuahang"
        case .mpos_sp_CancelFormDKSingle_TraGopOnline(_,_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_CancelFormDKSingle_TraGopOnline"
        case .getSODetails(_):
            return "/mpos-cloud-service/MPOSSale/Service.svc/getSODetails"
        case .mpos_sp_calllog_UpdateImei_Ecom(_,_,_,_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_calllog_UpdateImei_Ecom"
        case .mpos_sp_PrintPhieuDKPOS(_,_,_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_PrintPhieuDKPOS"
        case .mpos_sp_UploadHinhAnhPDK(_,_,_,_,_,_,_,_):
            return "/mpos-cloud-image/api/UpLoadImage/mpos_sp_UploadHinhAnhPDK"
        case .mpos_sp_UploadChungTuHinhAnh(_,_,_,_,_,_,_):
            return "/mpos-friend/api/UpLoadImage/mpos_sp_UploadChungTuHinhAnh"
        case .mpos_sp_SaveImageFriend_ChungTuDoiTra(_,_,_):
            return "/mpos-cloud-image/api/UpLoadImage/mpos_sp_SaveImageFriend_ChungTuDoiTra"
        case .getVendorFFriend(_):
            return "/mpos-cloud-api/api/FFriend/getVendorFFriend"
        case .sp_mpos_CheckCreateCustomer(_,_):
            return "/mpos-cloud-api/api/FFriend/sp_mpos_CheckCreateCustomer"
        case .AddCustomerFFriend(_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_SaveInfoCustomerFriend"
        case .sp_CreditNoneCard_UploadImage_RequestV2(_):
            return "/mpos-friend/api/FFriend/sp_CreditNoneCard_UploadImage_RequestV2"
        case .UploadImage_CreditNoCard(_):
            return "/mpos-friend/api/FFriend/UploadImage_CreditNoCard"
        case .mpos_sp_GetBank_CreditNoCard:
            return "/mpos-cloud-api/api/FFriend/mpos_sp_GetBank_CreditNoCard"
        case  .mpos_sp_GetLink_CMND_UQTN_Credit(_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_GetLink_CMND_UQTN_Credit"
        case .mpos_sp_getVendors_All:
            return "/mpos-cloud-api/api/FFriend/mpos_sp_getVendors_All"
        case .mpos_sp_SearchVendor(_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_SearchVendor"
        case .mpos_sp_SaveImageFriend(_):
            return "/mpos-friend/api/UpLoadImage/mpos_sp_SaveImageFriend"
        case .mpos_sp_SaveImageFriend_ChanDung(_):
            return "/mpos-image/api/UpLoadImage/mpos_sp_SaveImageFriend_ChanDung"
        case .getTinhThanhFFriend:
            return "/mpos-cloud-api/api/FFriend/getTinhThanhFFriend"
        case .getThongTinNganHangFFriend(_,_):
            return "/mpos-cloud-api/api/FFriend/getThongTinNganHangFFriend"
        case .mpos_sp_LoadTinhThanhPho:
            return "/mpos-cloud-api/api/FFriend/mpos_sp_LoadTinhThanhPho"
        case .mpos_sp_LoadQuanHuyen(_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_LoadQuanHuyen"
        case .mpos_sp_GetMoiLienHeVoiNguoiLL:
            return "/mpos-cloud-api/api/FFriend/mpos_sp_GetMoiLienHeVoiNguoiLL"
        case .mpos_sp_PrintUQTNPOS(_,_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_PrintUQTNPOS"
        case .mpos_sp_SendOTPCustomerFriend(_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_SendOTPCustomerFriend"
        case .checkPromotionFF(_):
            return "/mpos-cloud-api/api/order/checkPromotion"
        case .mpos_sp_insert_order_ffriend(_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_insert_order_ffriend"
        case .getHinhThucGiaoHangFFriend:
            return "/mpos-cloud-api/api/FFriend/getHinhThucGiaoHangFFriend"
        case .sp_mpos_CheckAccount_SkipOTP_ShopApDung:
            return "/mpos-cloud-api/api/FFriend/sp_mpos_CheckAccount_SkipOTP_ShopApDung"
        case .CheckAccount_SkipOTP(_,_):
            return "/mpos-cloud-api/api/FFriend/CheckAccount_SkipOTP"
        case .FRT_SP_CRM_DSNhaMang_bookSim(_):
            return "/mpos-cloud-api/api/sim/FRT_SP_CRM_DSNhaMang_bookSim"
        case .getListGoiCuocBookSimV2(_):
            return "/mpos-cloud-api/api/Subsidy/sp_mpos_CRMV2_LoadGoiCuocDangActive"
        case .getListLichSuKichHoat(_):
            return "/mpos-cloud-api/api/Subsidy/sp_Mpos_GetActiveSim_New"
        case .getListLichSuKichHoatSerial(_):
            return "/mpos-cloud-api/api/sim/FindSimDetailsBySimSerial"
        case .getThongTinGiaHanSSD(_):
            return "/mpos-cloud-api/api/Subsidy/FRT_SP_GiaHan_SSD_LoadThongTin"
        case .uploadHinhGiaHanSSD(_):
            return "/mpos-cloud-api/api/sim/SaveSignatureActiveSim_ReActive"
        case .giaHanSSDResult(_):
            return "/mpos-cloud-api/api/sim/ProvisioningWithCampaign"
        case .getOTPGiaHanSSD(_):
            return "/mpos-cloud-api/api/sim/GetOTP"
        case .getListNCC(_):
            return "/mpos-cloud-api/api/PO/FRT_sp_mpos_loadPO_NhapHang"
        case .getListPOAll(_):
            return "/mpos-cloud-api/api/PO/FRT_sp_mpos_loadPO_ByNCC_NhapHang"
        case .insertXMLNhapHang(_):
            return "/mpos-cloud-api/api/PO/mpos_FRT_SP_InsertXML_NhapHang"
        case .getHistoryNhapHang(_):
            return "/mpos-cloud-api/api/PO/mpos_FRT_SP_LoadHistoryPO_NhapHang"
        case .getListNhaThuoc(_):
            return "/mpos-cloud-api/api/PO/mpos_FRT_SP_CRM_LC_LoadDSShopThuoc"
        case .getListNhanVienThuocLongChau(_):
            return "/mpos-cloud-api/api/PO/mpos_FRT_SP_CRM_LC_LoadDSNhanVienThuoc"
        case .insertThuHoLongChau(_):
            return "/mpos-cloud-api/api/PO/mpos_FRT_SP_CRM_LC_InsertThuHo"
        case .SendOTPConvert4G(_):
            return "/mpos-cloud-api/api/sim/ChangeSim4G_RequestOTP"
        case .changeSim4G(_):
            return "/mpos-cloud-api/api/sim/ChangeSim4G"
        case .getInfoActiveSimbyPhone(_):
            return "/mpos-cloud-api/api/Sim/mpos_sp_GetInfoActiveSimbyPhone"
        case .SendOTPInfoActiveSim(_):
            return "/mpos-cloud-api/api/sim/CheckCustomerInfoVNM"
        case .updateInfoVNM(_):
            return "/mpos-cloud-api/api/sim/UpdateCustomerInfoVNM"
        case .BaoHiem_GetHangXe(_):
            return "/mpos-cloud-api/api/insurance/getHangXe"
        case .Get_CardType_From_POS(_):
            return "/mpos-cloud-service/MPOSSubsidy/Service.svc/sp_Get_CardType_From_POS"
        case .BaoHiem_GetLoaiXe(_):
            return "/mpos-cloud-api/api/insurance/getLoaiXe_BHX"
        case .BaoHiem_GetSP(_):
            return "/mpos-cloud-api/api/insurance/getSanPham_BHX"
        case .BaoHiem_GetPhuongXa(_):
            return "/mpos-cloud-api/api/insurance/getPhuongXa_BHX"
        case .BaoHiem_GetQuan(_):
            return "/mpos-cloud-api/api/insurance/getQuanHuyen_BHX"
        case .BaoHiem_GetDungTich(_):
            return "/mpos-cloud-api/api/insurance/getDungTichSoCho_BHX"
        case .BaoHiem_getGiaBan_BHX(_):
            return "/mpos-cloud-api/api/insurance/getGiaBan_BHX"
        case .BaoHiem_getGiaBanAll_BHX(_):
            return "/mpos-cloud-api/api/insurance/getGiaBanAll_BHX"
        case .BaoHiem_GetToken(_):
            return "/mpos-cloud-api/api/insurance/gettoken"
        case .BaoHiem_GetTinhThanh(_):
            return "/mpos-cloud-api/api/insurance/getTinhThanh_BHX"
        case .BaoHiem_AddOrder(_):
            return "/mpos-cloud-api/api/insurance/addOrder"
        case .GetSearchCustomers(_):
            return "/mpos-cloud-api/api/encashment/searchCustomers"
        case .GetProvidersNew(_):
            return "/mpos-cloud-api/api/encashment/getproviders"
        case .GetAgumentFtel(_):
            return "/mpos-cloud-api/api/encashment/GetAgumentFtel"
        case .GetPaymentFtel(_):
            return "/mpos-cloud-api/api/encashment/PaymentFtel"
        case .GetBill(_):
            return "/mpos-cloud-api/api/encashment/getbills"
        case .GetListCustomer(_):
            return "/mpos-cloud-api/api/encashment/GetListCustomer"
        case .GetFtelLocations(_):
            return "/mpos-cloud-api/api/encashment/GetFtelLocations"
        case .GetEncashAgribankResult(_):
            return "/mpos-cloud-api/api/encashment/encash"
        case .GetEncashpayooResult(_):
            return "/mpos-cloud-api/api/encashment/encash"
        case .GetCheckVoucher(_):
            return "/mpos-cloud-api/api/Customer/CheckVoucher"
        case .GetPayooTopup(_):
            return "/mpos-cloud-api/api/payoo/Topup"
        case .GetPayooPayResult(_):
            return "/mpos-cloud-api/api/payoo/PayCode"
        case .GetVietNamMobileTheCaoPayResult(_):
            return "/mpos-cloud-api/api/vietnamobile/PayCode"
        case .GetTopupVNM(_):
            return "/mpos-cloud-vnm/api/topup/TopUp"
        case .GetTopUpList(_):
            return "/mpos-cloud-api/api/payoo/GetTopUpList"
        case .GetTopUpPrice(_):
            return "/mpos-cloud-api/api/payoo/GetTopUpPrice"
        case .GetPayCodeList(_):
            return "/mpos-cloud-api/api/crm/GetPayCodeList"
        case .GetPayCodePrice(_):
            return "/mpos-cloud-api/api/payoo/GetPayCodePrice"
        case .getThongTinDatCoc(_):
            return "/mpos-cloud-api/api/order/getThongTinDatCoc"
        case .getPriceGoiBH(_):
            return "/promotion-service/api/v1/Insurance/insurance-price"
        case .mpos_sp_GetInfoSubsidy(_):
            return "/mpos-cloud-service/MPOSSale/Service.svc/mpos_sp_GetInfoSubsidy"
        case .GetPasscode_Form2Key(_):
            return "/mpos-cloud-service/MPOSSale/Service.svc/mPOS_sp_GetPasscode_Form2Key"
        case .sp_mpos_Get_SSD_GoiCuoc_for_MPOS(_):
            return "/mpos-cloud-service/MPOSSubsidy/Service.svc/sp_mpos_Get_SSD_GoiCuoc_for_MPOS"
        case .mpos_sp_Get_ThongTinSSD_ChiTietGoiCuoc(_):
            return "/mpos-cloud-service/MPOSSubsidy/Service.svc/mpos_sp_Get_ThongTinSSD_ChiTietGoiCuoc"
        case .mpos_sp_Get_ThongTinSSD_from_itemcode_goicuoc(_):
            return "/mpos-cloud-service/MPOSSubsidy/Service.svc/mpos_sp_Get_ThongTinSSD_from_itemcode_goicuoc"
        case .sp_mpos_SSD_MSP_SIM_10_11_for_MPOS(_):
            return "/mpos-cloud-service/MPOSSubsidy/Service.svc/sp_mpos_SSD_MSP_SIM_10_11_for_MPOS"
        case .sp_mpos_GetList_ItemCodeSubSidy(_):
            return "/mpos-cloud-service/MPOSSubsidy/Service.svc/sp_mpos_GetList_ItemCodeSubSidy"
        case .sp_mpos_FRT_SP_SSD_SoSanhGoiSSD_GoiThuong(_):
            return "/mpos-cloud-api/api/Subsidy/sp_mpos_FRT_SP_SSD_SoSanhGoiSSD_GoiThuong"
        case .VinaGame_InsertInstallapp(_):
            return "/mpos-cloud-api/api/VNG/mpos_FRT_SP_VNG_insertinstallapp"
        case .VinaGame_GetListDH(_):
            return "/mpos-cloud-api/api/VNG/mpos_FRT_SP_VNG_LoadDSDonHang"
        case .VinaGame_GetListDHIntalled(_):
            return "/mpos-cloud-api/api/VNG/mpos_FRT_SP_VNG_LoadDSInstallapp"
        case .searchCNMD_subsidy(_):
            return "/mpos-cloud-api/api/order/searchCNMD_subsidy"
        case .checkCICKhachHang(_):
            return "/mpos-cloud-api/api/Subsidy/sp_mpos_SSD_KiemTraCICKhachHang"
        case .uploadImageLockDevice(_):
            return "/mpos-friend/api/Subsidy/mpos_sp_UploadImage_LockDevice"
        case .hoantatLockDevice(_):
            return "/mpos-cloud-api/api/Subsidy/mpos_sp_FRT_SP_LockDevice_KhachHang"
        case .loadInfoLockDevice(_):
            return "/mpos-cloud-api/api/Subsidy/mpos_sp_LoadInfo_LockDevice"
        case .GoiPopupHang_Mobile(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/GoiPopupHang_Mobile"
        case .TaoPhieuBH_AutoMailChoHang(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/AutoMailChoHang"
        case .Checkimei_V2(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/Checkimei_V2"
        case .LayHinhThucBanGiaoChoBHV(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/TaoPhieuBH_LayHinhThucBanGiaoChoBHV"
        case .LoadHinhThucBanGiao(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/TaoPhieuBH_LoadHinhThucBanGiao"
        case .TaoPhieuBH_NgayHenTra(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/TaoPhieuBH_NgayHenTra"
        case .BaoHanhUploadImageNew(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/UpLoadImageList"
        case .TaoPhieuBH_UpLoadImage(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/UpLoadImage"
        case .GetBaoHanhPhuKien:
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/LayThongTinPhuKien"
        case .TaoPhieuBH_LuuPhieuBH(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/TaoPhieuBH_LuuPhieuBH"
        case .LayTinhTrangMay:
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/LayTinhTrangMay"
        case .GetImageBienBanBH(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/UploadImage_BienBanBH"
        case .TaoPhieuBH_Timsanpham(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/TaoPhieuBH_Timsanpham"
        case .LayThongTinHinhThucBH(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/LayThongTinHinhThucBH"
        case .Checkimei_V2_More(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/Checkimei_V2_More"
        case .GetLoadThongTinPhieuTraKH(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/LoadThongTinPhieuTraKH"
        case .GetLoadThongTinBBTraMay(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/LoadThongTinBBTraMay"
        case .GetDongBoKnox(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/SyncKnoxTraKH"
        case .baoHanhPhuKien_SearchLichSu(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/BaoHanhPhuKien_SearchLichSu"
        case .baoHanhPhuKien_LoadLoai:
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/BaoHanhPhuKien_LoadLoai"
        case .LoadThongTinTimKiemThem_Mobile(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/LoadThongTinTimKiemThem_Mobile"
        case .checkpromotionActivedSim(_):
            return "/mpos-cloud-api/api/CRM/sp_mpos_ActivedSim_Promotion_ActionsBy"
        case .inMoMo(_):
            return "/mpos-cloud-api/api/momo/printInvoice"
        case .getDanhSachPhieuMoMo(_):
            return "/mpos-cloud-api/api/momo/loadDSPhieu"
        case .GetCRMPaymentHistory(_):
            return "/mpos-cloud-api/api/crm/GetCRMPaymentHistory_V2"
        case .inRutTienMoMo(_):
            return "/mpos-cloud-api/api/momo/printInvoiceCashOut"
        case .GetViettelPayResult(_):
            return "/mpos-cloud-api/api/viettelpay/PayCode"
        case .getVendorCurator_Getvendor:
            return "/mpos-cloud-api/api/FFriend/mpos_sp_VendorCurator_Getvendor"
        case .getVendorCurator_GetHead_PD:
            return "/mpos-cloud-api/api/FFriend/mpos_sp_VendorCurator_GetHead_PD"
        case .getVendorCurator_GetCurator:
            return "/mpos-cloud-api/api/FFriend/mpos_sp_VendorCurator_GetCurator"
        case .getInfo_Curator(_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_VendorCurator_Getinfo_Curator"
        case .getVendorCurator_Saveinfo(_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_VendorCurator_Saveinfo"
        case .vendorCurator_DeleteInfo(_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_VendorCurator_Deleteinfo"
        case .UpLoadImageSingle_TaoPhieuBH(_):
            return "/mpos-cloud-warranty/mPOSWarranty/Service.svc/UpLoadImageSingle"
            //check-inPG
        case .register:
            return "/mpos-cloud-api/api/PGEmp/Register"
        case .getEmployeeInfo:
            return "/mpos-cloud-api/api/PGEmp/GetInfo"
        case .checkIn:
            return "/mpos-cloud-api/api/PGEmp/CheckIn"
        case .updateOffEmployee:
            return "/mpos-cloud-api/api/PGEmp/OffEmployee"
        case .getListVendors:
            return "/mpos-cloud-api/api/PGEmp/GetListVendors"
        case .getHistoryCheckIn:
            return "/mpos-cloud-api/api/PGEmp/GetHistoryCheckIn"
        case .getTonKhoShop:
            return "/mpos-cloud-api/api/product/getTonKhoShop"
            //get list goi cuoc tu ecom
        case .sp_mpos_FRT_SP_SIM_loadDSGoiCuoc_ecom(_):
            return "/mpos-cloud-api/api/Order/sp_mpos_FRT_SP_SIM_loadDSGoiCuoc_ecom"
        case .mpos_sp_UpdateTargetPD_GetPD:
            return "/mpos-cloud-api/api/FFriend/mpos_sp_UpdateTargetPD_GetPD"
        case .mpos_sp_UpdateTargerPD_GetInfo(_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_UpdateTargerPD_GetInfo"
        case .mpos_sp_UpdateTargerPD_Delete(_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_UpdateTargerPD_Delete"
        case .mpos_sp_UpdateTargerPD_Saveinfo(_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_UpdateTargerPD_Saveinfo"
        case .mpos_sp_CheckUpdateInfo_TraGop(_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_CheckUpdateInfo_TraGop"
        case .mpos_FRT_MD_SP_MPOS_PhanLoai:
            return "/mpos-cloud-api/api/Order/mpos_FRT_MD_SP_MPOS_PhanLoai"
        case .mpos_FRT_MD_mpos_searchkeyword:
            return "/mpos-cloud-api/api/Order/mpos_FRT_MD_mpos_searchkeyword"
        case .mpos_FRT_SP_LoadSO_mpos_pre:
            return "/mpos-cloud-api/api/Order/mpos_FRT_SP_LoadSO_mpos_pre"
        case .sp_mpos_GetCRMCode_ByMail:
            return "/mpos-cloud-api/api/Order/sp_mpos_GetCRMCode_ByMail"
        case .sp_mpos_FRT_SP_comboPK_fix_Price(_):
            return "/mpos-cloud-api/api/Order/sp_mpos_FRT_SP_comboPK_fix_Price"
        case .sp_mpos_FRT_SP_comboPK_calculator(_):
            return "/mpos-cloud-api/api/Order/sp_mpos_FRT_SP_comboPK_calculator"
        case .sp_mpos_InstallCustInfo_CalllogCIC_CheckAndCreate(_):
            return "/mpos-cloud-api/api/FFriend/sp_mpos_InstallCustInfo_CalllogCIC_CheckAndCreate"
        case .sp_mpos_FRT_SP_TraGop_LoadThongTin_LenDoiSP(_):
            return "/mpos-cloud-api/api/Order/sp_mpos_FRT_SP_TraGop_LoadThongTin_LenDoiSP"
        case .sp_mpos_FRT_SP_ESIM_getqrcode(_):
            return "/mpos-cloud-api/api/SIM/GetQRCodeBySerialSimViettel"
        case .sp_mpos_FRT_SP_Esim_getSeri(_):
            return "/mpos-cloud-api/api/SIM/sp_mpos_FRT_SP_Esim_getSeri"
        case .sp_mpos_Getinfo_SaoKeLuong(_):
            return "/mpos-cloud-api/api/FFriend/sp_mpos_Getinfo_SaoKeLuong"
        case .sp_mpos_info_SaoKeLuong_Huy(_):
            return "/mpos-cloud-api/api/FFriend/sp_mpos_info_SaoKeLuong_Huy"
        case .sp_mpos_Update_ThongTinSaoKeLuong(_):
            return "/mpos-cloud-api/api/FFriend/sp_mpos_Update_ThongTinSaoKeLuong"
        case .UploadImage_CalllogScoring(_):
            return "/mpos-friend/api/UpLoadImage/UploadImage_CalllogScoring"
        case .sp_mpos_UploadImageScoring(_):
            return "/mpos-cloud-api/api/FFriend/sp_mpos_UploadImageScoring"
        case .sp_mpos_Scoring_CheckDiemLietFRT(_):
            return "/mpos-cloud-api/api/FFriend/sp_mpos_Scoring_CheckDiemLietFRT"
        case .sp_mpos_Scoring_CheckDiemLietFRT_ByCMND(_):
            return "/mpos-cloud-api/api/FFriend/sp_mpos_Scoring_CheckDiemLietFRT_ByCMND"
        case .sp_mpos_Scoring_LoadKyHanTraGop(_):
            return "/mpos-cloud-api/api/FFriend/sp_mpos_Scoring_LoadKyHanTraGop"
        case .sp_mpos_HuyCalllog_UQTN_HetHan(_):
            return "/mpos-cloud-api/api/FFriend/sp_mpos_HuyCalllog_UQTN_HetHan"
        case .getAllCompanyAmortizations:
            return "/mpos-cloud-service/MPOSSale/Service.svc/getAllCompanyAmortizations"
        case .sp_mpos_FRT_SP_Load_OutSide_Info(_):
            return "/mpos-cloud-api/api/Order/sp_mpos_FRT_SP_Load_OutSide_Info"
        case .sp_mpos_FRT_SP_OutSide_LS_ThuHo(_):
            return "/mpos-cloud-api/api/Order/sp_mpos_FRT_SP_OutSide_LS_ThuHo"
        case .sp_mpos_FRT_SP_OutSide_LS_TheCao(_):
            return "/mpos-cloud-api/api/Order/sp_mpos_FRT_SP_OutSide_LS_TheCao"
        case .sp_mpos_FRT_SP_OutSide_ls_naptien(_):
            return "/mpos-cloud-api/api/Order/sp_mpos_FRT_SP_OutSide_ls_naptien"
        case .ViettelPayTopup(_):
            return "/mpos-cloud-api/api/viettelpay/Topup"
        case .VTChangeSimErp(_):
            return "/mpos-cloud-api/api/sim/VTChangeSimErp"
        case .VTGetSimInfoByPhoneNumber(_):
            return "/mpos-cloud-api/api/sim/VTGetRimInfoByIsdn"
        case .VTGetListCustomerByIsdnErp(_):
            return "/mpos-cloud-api/api/sim/VTGetListCustomerByIsdnErp"
        case .VTGetReasonCodes(_):
            return "/mpos-cloud-api/api/sim/VTGetReasonCodes"
        case .VTGetChangeSimHistory(_):
            return "/mpos-cloud-api/api/sim/VTGetChangeSimHistory"
        case .GetProvincesSim(_):
            return "/mpos-cloud-api/api/area/GetProvinces"
        case .confirmPasswordUpdatePG(_):
            return "/mpos-cloud-api/api/pgemp/Certificate"
        case .sp_mpos_FRT_SP_combopk_searchsp(_):
            return "/mpos-cloud-api/api/Order/sp_mpos_FRT_SP_combopk_searchsp"
        case .sp_mpos_FRT_SP_GetFormNotiHome(_):
            return "/mpos-cloud-api/api/Notification/sp_mpos_FRT_SP_GetFormNotiHome"
        case .thong_bao_tai_lieu:
            return "/content-hub-service/tai-lieu-chung/thong-bao-tai-lieu"
        case .sp_mpos_FRT_SP_Camera_listShopByUser(_):
            return "/mpos-cloud-delivery/api/Delivery/sp_mpos_FRT_SP_Camera_listShopByUser"
        case .sp_mpos_FRT_SP_Camera_getLinkDetail_online(_):
            return "/mpos-cloud-delivery/api/Delivery/sp_mpos_FRT_SP_Camera_getLinkDetail_online"
        case .mpos_UploadImage_CalllogInside(_):
            return "/mpos-cloud-api/api/Order/mpos_UploadImage_CalllogInside"
        case .mpos_FRT_SP_Calllog_createissue(_):
            return "/mpos-cloud-api/api/Order/mpos_FRT_SP_Calllog_createissue"
        case .mpos_sp_GetVendor_DuoiEmail(_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_GetVendor_DuoiEmail"
        case .mpos_sp_GetVendor_ChucVu(_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_GetVendor_ChucVu"
        case .mpos_sp_GetVendor_ChiNhanhDN(_):
            return "/mpos-cloud-api/api/FFriend/mpos_sp_GetVendor_ChiNhanhDN"
        case .getVendorFFriend_V2(_):
            return "/mpos-cloud-api/api/FFriend/getVendorFFriend_V2"
        case .sp_mpos_CheckHanMucKH(_):
            return "/mpos-cloud-api/api/FFriend/sp_mpos_CheckHanMucKH"
        case .getProvidersGrab(_):
            return "/mpos-cloud-api/api/encashment/getproviders"
        case .payOfflineBillBE(_):
            return "/mpos-cloud-api/api/payoo/PayOfflineBillBE"
        case .PayOfflineBillBEHistory_Grab(_):
            return "/mpos-cloud-api/api/payoo/PayOfflineBillBEHistory_Grab"
        case .mpos_FRT_SP_mirae_checkinfocustomer(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_mirae_checkinfocustomer"
        case .mpos_FRT_SP_Mirae_loadTypeDoc(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_Mirae_loadTypeDoc"
        case .mpos_FRT_SP_Mirae_loadProvince(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_Mirae_loadProvince"
        case .mpos_FRT_SP_Mirae_loadDistrict(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_Mirae_loadDistrict"
        case .mpos_FRT_SP_Mirae_loadPrecinct(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_Mirae_loadPrecinct"
        case .mpos_FRT_SP_Mirae_Insert_image_contract(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_Mirae_Insert_image_contract"
        case .mpos_FRT_SP_Mirae_create_infoCustomer(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_Mirae_create_infoCustomer"
        case .mpos_FRT_SP_mirae_loadinfoByCMND(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_mirae_loadinfoByCMND"
        case .mpos_FRT_SP_Mirae_loadscheme(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_Mirae_loadscheme"
        case .mpos_FRT_SP_mirae_loadDueDay(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_mirae_loadDueDay"
        case .mpos_FRT_SP_Mirae_laythongtinkhachhang_order(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_Mirae_laythongtinkhachhang_order"
        case .mpos_FRT_SP_mirae_Getinfo_byContractNumber(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_mirae_Getinfo_byContractNumber"
        case .mpos_FRT_SP_Mirae_LoadKyHan(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_Mirae_LoadKyHan"
        case .UploadImage_Mirae(_):
            return "/mpos-friend/api/UploadImage/UploadImage_Mirae"
        case .mpos_FRT_SP_mirae_history_order_byuser(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_mirae_history_order_byuser"
        case .saveOrderMirae(_):
            return "/mpos-cloud-api/api/order/saveOrder"
        case .mpos_FRT_SP_mirae_history_order_byID(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_mirae_history_order_byID"
        case .mpos_FRT_SP_mirae_cance_hopdong(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_mirae_cance_hopdong"
        case .mpos_FRT_SP_mirae_finish_hopdong(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_mirae_finish_hopdong"
        case .mpos_Mirae_UpdateImei(_):
            return "/mpos-cloud-api/api/Mirae/mpos_Mirae_UpdateImei"
        case .mpos_ReSubmitAplication(_):
            return "/mpos-cloud-api/api/Mirae/mpos_ReSubmitAplication"
        case .mpos_ConfirmUploadComplete(_):
            return "/mpos-cloud-api/api/Mirae/mpos_ConfirmUploadComplete"
        case .mpos_FRT_SP_Mirae_DS_sanpham(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_Mirae_DS_sanpham"
        case .mpos_FRT_SP_mirae_loadreasoncance(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_mirae_loadreasoncance"
        case .BaoLoiNguoiDung__GetConv(_):
            return "/mCallLog/Service.svc/BaoLoiNguoiDung__GetConv"
        case .BaoLoiNguoiDung__PushConv(_):
            return "/mCallLog/Service.svc/BaoLoiNguoiDung__PushConv"
            
            //bo sung esim
        case .VTCheckSim(_):
            return "/mpos-cloud-api/api/Sim/VTCheckSim"
        case .VTSendOTPErp(_):
            return "/mpos-cloud-api/api/Sim/VTSendOTPErp"
            //cham diem
        case .Score_GetListObject(_):
            return "/mpos-cloud-api/api/Score/mpos_sp_FRT_Score_GetListObject"
        case .Score_GetGroupItem(_):
            return "/mpos-cloud-api/api/Score/mpos_sp_FRT_Score_GetGroupItem"
        case .Score_GetContentGroupItem(_):
            return "/mpos-cloud-api/api/Score/mpos_sp_FRT_Score_GetContentGroupItem"
        case .Score_GetListScore(_):
            return "/mpos-cloud-api/api/Score/mpos_sp_FRT_Score_GetListScore"
        case .Score_CreateObject(_):
            return "/mpos-cloud-api/api/Score/mpos_sp_FRT_Score_CreateObject"
        case .Score_CreateGroupItem(_):
            return "/mpos-cloud-api/api/Score/mpos_sp_FRT_Score_CreateGroupItem"
        case .Score_CreateContentScore(_):
            return "/mpos-cloud-api/api/Score/mpos_sp_FRT_Score_CreateContentScore"
        case .Score_SendRequestScoreToSM(_):
            return "/mpos-cloud-api/api/Score/mpos_sp_FRT_Score_SendRequestScoreToSM"
        case .Score_InActiveOGC(_):
            return "/mpos-cloud-api/api/Score/mpos_sp_FRT_Score_InActiveOGC"
        case .Score_GetImageListContent(_):
            return "/mpos-cloud-api/api/Score/mpos_sp_FRT_Score_GetImageListContent"
        case .Score_UploadImage(_):
            return "/mpos-cloud-api/api/Score/mpos_FRT_Score_UploadImage"
        case .Score_CreateRequestScore(_):
            return "/mpos-cloud-api/api/Score/mpos_sp_FRT_Score_CreateRequestScore"
        case .Score_UpdateRequestScore(_):
            return "/mpos-cloud-api/api/Score/mpos_sp_FRT_Score_UpdateRequestScore"
        case .Score_UpdateObject(_):
            return "/mpos-cloud-api/api/Score/mpos_sp_FRT_Score_UpdateObject"
        case .Score_UpdateGroupItem(_):
            return "/mpos-cloud-api/api/Score/mpos_sp_FRT_Score_UpdateGroupItem"
        case .Score_UpdateContentScore(_):
            return "/mpos-cloud-api/api/Score/mpos_sp_FRT_Score_UpdateContentScore"
            //back tp school
        case .BackToSchool_CheckSBD(_):
            return "/mpos-cloud-api/Api/BackToSchool/mpos_sp_BackToSchool_CheckSBD"
        case .BackToSchool_UploadImage(_):
            return "/mpos-cloud-api/Api/BackToSchool/UploadImage"
        case .BackToSchool_UpdateThongTinKhachHang(_):
            return "/mpos-cloud-api/api/BackToSchool/mpos_sp_BackToSchool_UpdateThongTinKhachHang"
        case .BackToSchool_UpdateHinhAnh(_):
            return "/mpos-cloud-api/api/BackToSchool/mpos_sp_BackToSchool_UpdateHinhAnh"
        case .BackToSchool_LoadThongTinKHBySBD(_):
            return "/mpos-cloud-api/Api/BackToSchool/mpos_sp_BackToSchool_LoadThongTinKHBySBD"
        case .backToSchool_LoadHistoryKHBySBD(_):
            return "/mpos-cloud-api/api/backtoschool/mpos_sp_BackToSchool_LoadHistoryKHBySBD"
        case .backToSchool_InsertData_SinhVienFPT(_):
            return "/mpos-cloud-api/api/backtoschool/mpos_sp_BackToSchool_InsertData_SinhVienFPT"
        case .backToSchool_TimKiem_ByKey(_):
            return "/mpos-cloud-api/api/backtoschool/mpos_sp_BackToSchool_TimKiem"
        case .backToSchool_TimKiem_ByUser(_):
            return "/mpos-cloud-api/api/backtoschool/mpos_sp_BackToSchool_TimKiem_ByUser"
        case .backToSchool_HuyVoucher(_):
            return "/mpos-cloud-api/api/backtoschool/mpos_sp_BackToSchool_HuyVoucher"
            //Sendo
        case .FRT_SP_linksendo(_):
            return "/mpos-cloud-api/api/Order/sp_mpos_FRT_SP_linksendo"
            //Nop quy NH
        case .PaymentOfFunds_GetList(_):
            return "/mpos-cloud-api/api/PaymentBank/mpos_FRT_PaymentOfFunds_GetList"
        case .PaymentOfFunds_CallLogNopQuy(_):
            return "/mpos-cloud-api/api/PaymentBank/mpos_FRT_PaymentOfFunds_New"
        case .PaymentOfFunds_Update(_):
            return "/mpos-cloud-api/api/PaymentBank/mpos_FRT_PaymentOfFunds_Update"
        case .PaymentOfFunds_UploadImage(_):
            return "/mpos-cloud-api/api/PaymentBank/mpos_FRT_PaymentOfFunds_UploadImage"
        case .sp_FRT_Web_BrowserPaymentRequest_GetBank:
            return "/mpos-cloud-api/api/RequestPayment/sp_FRT_Web_BrowserPaymentRequest_GetBank"
        case .sp_FRTCallLog_Web_BrowserPaymentRequest_GetWarehouseByType:
            return "/mpos-cloud-api/api/RequestPayment/sp_FRTCallLog_Web_BrowserPaymentRequest_GetWarehouseByType"
        case .sp_FRT_Web_BrowserPaymentRequest_GetTinhThanh:
            return "/mpos-cloud-api/api/RequestPayment/sp_FRT_Web_BrowserPaymentRequest_GetTinhThanh"
        case .sp_FRT_Web_BrowserPaymentRequest_GetQuanHuyen:
            return "/mpos-cloud-api/api/RequestPayment/sp_FRT_Web_BrowserPaymentRequest_GetQuanHuyen"
        case .sp_FRT_Web_BrowserPaymentRequest_GetLoaiKyHD:
            return "/mpos-cloud-api/api/RequestPayment/sp_FRT_Web_BrowserPaymentRequest_GetLoaiKyHD"
        case .sp_FRT_Web_BrowserPaymentRequest_GetDonVi:
            return "/mpos-cloud-api/api/RequestPayment/sp_FRT_Web_BrowserPaymentRequest_GetDonVi"
        case .sp_FRT_Web_BrowserPaymentRequest_GetKyHan:
            return "/mpos-cloud-api/api/RequestPayment/sp_FRT_Web_BrowserPaymentRequest_GetKyHan"
        case .sp_FRTCallLog_Web_CreateRequestPaymentHomeFromMobile:
            return "/mpos-cloud-api/api/RequestPayment/sp_FRTCallLog_Web_CreateRequestPaymentHomeFromMobile"
        case .Uploads_FileAttachs:
            return "/Uploads/Uploads_FileAttachs"
        case .sp_FRT_Web_BrowserPaymentRequest_GetHistory:
            return "/mpos-cloud-api/api/RequestPayment/sp_FRT_Web_BrowserPaymentRequest_GetHistory"
        case .mpos_FRT_RequestPaymentHome_UploadImage:
            return "/mpos-cloud-api/api/RequestPayment/mpos_FRT_RequestPaymentHome_UploadImage"
        case .GetinfoCustomerByImageIDCard(_):
            return "/mpos-cloud-api/api/Sim/GetinfoCustomerByImageIDCard"
            //viettelpay
        case .GenerateBirthdayOnMarchVoucher(_):
            return "/mpos-cloud-api/api/Customer/GenerateBirthdayOnMarchVoucher"
        case .otpCashInVTPayEx(_):
            return "/mpos-cloud-api/api/ViettelPay/otpCashInVTPayEx"
        case .getFeeEx(_):
            return "/mpos-cloud-api/api/ViettelPay/getFeeEx"
        case .makeTransfer(_):
            return "/mpos-cloud-api/api/ViettelPay/makeTransfer"
        case .getMakeTransferHeaders(_):
            return "/mpos-cloud-api/api/ViettelPay/getMakeTransferHeaders"
        case .GetMakeTransferDetails(_):
            return "/mpos-cloud-api/api/ViettelPay/GetMakeTransferDetails"
        case .partnerCancel(_):
            return "/mpos-cloud-api/api/ViettelPay/partnerCancel"
        case .editTransfer(_):
            return "/mpos-cloud-api/api/ViettelPay/editTransfer"
        case .initTransfer(_):
            return "/mpos-cloud-api/api/ViettelPay/initTransfer"
        case .getFeeCashInEx(_):
            return "/mpos-cloud-api/api/ViettelPay/getFeeCashInEx"
        case .cashIn(_):
            return "/mpos-cloud-api/api/ViettelPay/cashIn"
        case .GetInitTransferHeaders(_):
            return "/mpos-cloud-api/api/ViettelPay/GetInitTransferHeaders"
        case .GetInitTransferDetails(_):
            return "/mpos-cloud-api/api/ViettelPay/GetInitTransferDetails"
        case .confirmDelivery(_):
            return "/mpos-cloud-api/api/ViettelPay/confirmDelivery"
        case .GetCashInHeaders(_):
            return "/mpos-cloud-api/api/ViettelPay/GetCashInHeaders"
        case .GetCashInDetails(_):
            return "/mpos-cloud-api/api/ViettelPay/GetCashInDetails"
        case .getTransInfoEx(_):
            return "/mpos-cloud-api/api/ViettelPay/getTransInfoEx"
        case .resetReceiptCodeEx(_):
            return "/mpos-cloud-api/api/ViettelPay/resetReceiptCodeEx"
        case .initTransferEx(_):
            return "/mpos-cloud-api/api/ViettelPay/initTransferEx"
        case .confirmCancel(_):
            return "/mpos-cloud-api/api/ViettelPay/confirmCancel"
        case .SaveSignatureOfCust(_):
            return "/mpos-cloud-api/api/ViettelPay/SaveSignatureOfCust"
        case .CheckCustFeeBack(_):
            return "/mpos-cloud-api/api/ViettelPay/CheckCustFeeBack"
        case .mpos_DetectIDCard(_):
            return "/mpos-cloud-api/api/Mirae/mpos_DetectIDCard"
        case .mpos_FRT_SP_mirae_load_by_SOPOS(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_mirae_load_by_SOPOS"
        case .sp_mpos_FRT_SP_Notify_Confirm(_):
            return "/mpos-cloud-api/api/Notification/sp_mpos_FRT_SP_Notify_Confirm"
            //Search MatKinh DongHo
        case .SearchProductWithItemCode(_):
            return "/mpos-cloud-api/api/FindProduct/mpos_sp_SearchProductWithItemCode"
        case .SearchProductWithPlace(_):
            return "/mpos-cloud-api/api/FindProduct/mpos_sp_SearchProductWithPlace"
        case .mpos_FRT_Mirae_getAll_Documents(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_Mirae_getAll_Documents"
        case .mpos_FRT_Mirae_Check_Documents_Info(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_Mirae_Check_Documents_Info"
        case .inov_masterDataLyDoGiamGia:
            return "/mpos-cloud-api/api/product/inov_masterDataLyDoGiamGia"
        case .inov_listTonKhoSanPham:
            return "/mpos-cloud-api/api/product/inov_listTonKhoSanPham"
        case .checkPromotionImeis:
            return "/mpos-cloud-api/api/order/checkPromotionImeis"
        case .mpos_sp_zen_vocuher_pos:
            return "/mpos-cloud-service/MPOSSale/Service.svc/mpos_sp_zen_vocuher_pos"
        case .sp_mpos_Get_PaymentType_From_POS:
            return "/mpos-cloud-api/api/Order/sp_mpos_Get_PaymentType_From_POS"
        case .mpos_verify_maxacthuc_point:
            return "/mpos-cloud-service/MPOSSale/Service.svc/mpos_verify_maxacthuc_point"
        case .mpos_sp_verify_VC_mpos_innovation:
            return "/mpos-cloud-service/MPOSSale/Service.svc/mpos_sp_verify_VC_mpos_innovation"
        case .genQRCode:
            return "/mpos-cloud-api/api/vnpay/genQRCode"
        case .checkTransactionQR:
            return "/mpos-cloud-api/api/vnpay/checkTransactionQR"
        case .FRT_SP_GetSMS_loyaty:
            return "/mpos-cloud-service/MPOSSale/Service.svc/FRT_SP_GetSMS_loyaty"
        case .sp_mpos_FRT_SP_innovation_checkgiamgiatay:
            return "/mpos-cloud-api/api/Order/sp_mpos_FRT_SP_innovation_checkgiamgiatay"
        case .sp_mpos_FRT_SP_innovation_check_IQcode:
            return "/mpos-cloud-api/api/Order/sp_mpos_FRT_SP_innovation_check_IQcode"
        case .mpos_FRT_UploadImage_Warranty(_):
            return "/mpos-cloud-api/api/Upload/mpos_FRT_UploadImage_Warranty"
        case .mpos_sp_GetImageWarrantyByDocEntry(_):
            return "/mpos-cloud-api/api/Order/mpos_sp_GetImageWarrantyByDocEntry"
        case .mpos_FRT_Mirae_Update_WaybillNumber(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_Mirae_Update_WaybillNumber"
        case .mpos_FRT_Mirae_LoadInfo_Send_Bill:
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_Mirae_LoadInfo_Send_Bill"
        case .mpos_FRT_SP_Mirae_loadTienCTMayCu(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_Mirae_loadTienCTMayCu"
        case .mpos_FRT_SP_ThuMuaMC_get_list_detail(_):
            return "/mpos-cloud-api/api/FindProduct/mpos_FRT_SP_ThuMuaMC_get_list_detail"
        case .mpos_FRT_SP_ThuMuaMC_get_list_Loai(_):
            return "/mpos-cloud-api/api/FindProduct/mpos_FRT_SP_ThuMuaMC_get_list_Loai"
        case .mpos_FRT_SP_ThuMuaMC_get_list(_):
            return "/mpos-cloud-api/api/FindProduct/mpos_FRT_SP_ThuMuaMC_get_list"
        case .mpos_FRT_SP_ThuMuaMC_get_info(_):
            return "/mpos-cloud-api/api/FindProduct/mpos_FRT_SP_ThuMuaMC_get_info"
        case .checkPromotionMirae(_):
            return "/mpos-cloud-api/api/order/checkPromotion"
        case .mpos_FRT_SP_mirae_tinhsotienchenhlech(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_mirae_tinhsotienchenhlech"
        case .mpos_GetPlayBackCamera(_):
            return "/mpos-cloud-api/api/order/mpos_GetPlayBackCamera"
        case .mpos_FRT_Report_InstallApp(_):
            return "/mpos-cloud-api/api/vng/mpos_FRT_Report_InstallApp"
        case .mpos_FRT_Mirae_Send_Documents_Info(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_Mirae_Send_Documents_Info"
        case .mpos_FRT_SP_Mirae_noteforsale(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_Mirae_noteforsale"
        case .mpos_FRT_SP_mirae_history_order_byuser_HD_pending(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_mirae_history_order_byuser_HD_pending"
        case .sp_mpos_FRT_SP_innovation_loadDS_nhanvien(_):
            return "/mpos-cloud-api/api/order/sp_mpos_FRT_SP_innovation_loadDS_nhanvien"
            //May cũ Ecom
        case .Maycu_Ecom_GetListProduct(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_Maycu_Ecom_GetListProduct"
        case .Maycu_Ecom_GetColor_Product(_):
            return "/mpos-cloud-api/api/Product/mpos_GetColor_Product"
        case .MayCu_Ecom_Update(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_MayCu_Ecom_Update"
        case .getSODetailFF(_):
            return "/mpos-cloud-api/api/Order/mpos_sp_getSODetails"
        case .Moca_CreateQRCodeMobile(_):
            return "/mpos-cloud-api/api/GrabPay/CreateQRCodeMobile"
        case .Moca_Inquiry(_):
            return "/mpos-cloud-api/api/GrabPay/Inquiry"
        case .checkTransactionMocaByItemCode(_):
            return "/mpos-cloud-api/api/VNPay/checkTransactionMocaByItemCode"
        case .MayCuEcom_GetItemDetail(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_MayCuEcom_GetItemDetail"
        case .Report_InstallApp_Utop(_):
            return "/mpos-cloud-api/api/report/sp_mpos_Report_InstallApp_Utop"
            //vnpt
        case .mpos_FRT_SP_VNPT_loadinfoByCMND(_):
            return "/mpos-cloud-api/api/VNPT/mpos_FRT_SP_VNPT_loadinfoByCMND"
        case .mpos_FRT_SP_VNPT_sendotp(_):
            return "/mpos-cloud-api/api/VNPT/mpos_FRT_SP_VNPT_sendotp"
        case .mpos_FRT_SP_VNPT_create_info(_):
            return "/mpos-cloud-api/api/VNPT/mpos_FRT_SP_VNPT_create_info"
        case .mpos_FRT_SP_VNPT_upload_anhKH(_):
            return "/mpos-cloud-api/api/VNPT/mpos_FRT_SP_VNPT_upload_anhKH"
        case .mpos_FRT_Image_VNPT(_):
            return "/mpos-cloud-api/api/Upload/mpos_FRT_Image_VNPT"
        case .saveOrderVNPT(_):
            return "/mpos-cloud-api/api/order/saveOrder_V2"
        case .checkPromotionVNPT(_):
            return "/mpos-cloud-api/api/order/checkPromotion_V2"
        case .mpos_FRT_SP_VNPT_load_history(_):
            return "/mpos-cloud-api/api/VNPT/mpos_FRT_SP_VNPT_load_history"
        case .mpos_FRT_sp_vnpt_update_image_KH(_):
            return "/mpos-cloud-api/api/VNPT/mpos_FRT_sp_vnpt_update_image_KH"
        case .mpos_FRT_SP_Ecom_FFriend_load_SOEcom(_):
            return "/mpos-cloud-api/api/FFriend/mpos_FRT_SP_Ecom_FFriend_load_SOEcom"
            //       bao hiem
        case .mpos_FRT_SP_BH_insert_thongtinKH(_):
            return "/mpos-cloud-api/api/Insurrance/mpos_FRT_SP_BH_insert_thongtinKH"
        case .mpos_FRT_SP_BH_history_thongtinKH(_):
            return "/mpos-cloud-api/api/Insurrance/mpos_FRT_SP_BH_history_thongtinKH"
        case .mpos_FRT_Mirae_NotiAfterUploadImageComplete(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_Mirae_NotiAfterUploadImageComplete"
        case .mpos_FRT_Mirae_CreateCalllog_DuyetHinhAnh(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_Mirae_CreateCalllog_DuyetHinhAnh"
        case .mpos_FRT_SP_Mirae_history_order_byKeyword(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_Mirae_history_order_byKeyword"
        case .mpos_FRT_Flight_Tripi_InsertBooking(_):
            return "/mpos-cloud-api/api/Tripi/mpos_FRT_Flight_Tripi_InsertBooking"
        case .mpos_FRT_Flight_Tripi_ConfirmBooking(_):
            return "/mpos-cloud-api/api/Tripi/mpos_FRT_Flight_Tripi_ConfirmBooking"
        case .mpos_FRT_Flight_Tripi_GetHistory(_):
            return "/mpos-cloud-api/api/Tripi/mpos_FRT_Flight_Tripi_GetHistory"
        case .mpos_FRT_Flight_Tripi_GetDetailInfor(_):
            return "/mpos-cloud-api/api/Tripi/mpos_FRT_Flight_Tripi_GetDetailInfor"
            //Calllog TRIPI
        case .Flight_Tripi_CreateCalllog(_):
            return "/mpos-cloud-api/api/Tripi/mpos_FRT_Flight_Tripi_CreateCalllog"
        case .Flight_Tripi_GetConversation_CreateCalllog(_):
            return "/mpos-cloud-api/api/Tripi/mpos_FRT_Flight_Tripi_GetConversation_CreateCalllog"
        case .Get_Info_FF_From_QRCode(_):
            return "/mpos-cloud-api/api/FFriend/Get_Info_FF_From_QRCode"
        case .mpos_FRT_SP_mirae_sendsms(_):
            return "/mpos-cloud-api/api/Mirae/mpos_FRT_SP_mirae_sendsms"
        case .mpos_FRT_SP_SK_viewdetail_all(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_SK_viewdetail_all"
        case .mpos_FRT_SP_SK_viewdetail_Rcheck(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_SK_viewdetail_Rcheck"
        case .mpos_FRT_SP_SK_load_header(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_SK_load_header"
        case .mpos_FRT_SP_SK_Rcheck_insert(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_SK_Rcheck_insert"
        case .mpos_FRT_SP_SK_confirm_rcheck(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_SK_Rcheck_insert"
        case .mpos_FRT_Image_SKTelink(_):
            return "/mpos-cloud-api/api/Upload/mpos_FRT_Image_SKTelink"
        case .mpos_FRT_SP_SK_header_complete_detail(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_SK_header_complete_detail"
        case .mpos_FRT_SP_SK_header_complete(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_SK_header_complete"
        case .mpos_FRT_SP_SK_confirm_book_order(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_SK_confirm_book_order"
        case .mpos_FRT_SP_SK_cance_order(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_SK_cance_order"
        case .mpos_FRT_SP_SK_view_detail_after_sale_rightphone(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_SK_view_detail_after_sale_rightphone"
        case .mpos_FRT_SP_SK_confirm_upanh_xacnhan(_):
            return "/mpos-cloud-api/api/product/mpos_FRT_SP_SK_confirm_upanh_xacnhan"
        case .mpos_FRT_SP_SK_view_image(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_SK_view_image"
        case .mpos_FRT_SP_SK_nganhang_type(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_SK_nganhang_type"
        case .mpos_FRT_SP_SK_Send_OTP(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_SK_Send_OTP"
        case .mpos_FRT_SP_SK_nganhang(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_SK_nganhang"
        case .mpos_FRT_SP_SK_load_tinh(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_SK_load_tinh"
        case .mpos_FRT_SP_SK_TaoPhieuRcheck(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_SK_TaoPhieuRcheck"
        case .mpos_FRT_SP_SK_Load_TienRcheck(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_SK_Load_TienRcheck"
        case .mpos_FRT_SP_SK_update_info(_):
            return "/mpos-cloud-api/api/product/mpos_FRT_SP_SK_update_info"
        case .Tintuc_detail_baiviet(_):
            return "/node/bai_viet"
        case .mpos_FRT_SP_list_PMHThayThePK_ecom(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_list_PMHThayThePK_ecom"
        case .checkpromotionfrtBaoHiem(_):
            return "/mpos-cloud-api/api/Insurance/checkpromotionfrt"
        case .mpos_CheckEmail_Vendor_SendOTP(_):
            return "/mpos-cloud-api/api/FFriend/mpos_CheckEmail_Vendor_SendOTP"
        case .getTinTuc_New(_):
            return "/mpos-cloud-api/api/Report/mpos_new_fptshop"
        case .mpos_FRT_MayCuEcom_UploadImage(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_MayCuEcom_UploadImage"
        case .mpos_FRT_MayCuEcom_GetHinhMau(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_MayCuEcom_GetHinhMau"
        case .CreateOrderForMobile(_):
            return "/mpos-cloud-api/api/SmartPay/CreateOrderForMobile"
        case .QueryOrderSmartPay(_):
            return "/mpos-cloud-api/api/SmartPay/QueryOrder"
        case .mpos_FRT_SP_SK_Load_default_imei(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_SP_SK_Load_default_imei"
        case .Products_Demo_Warranty_ListProduct(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_Products_Demo_Warranty_ListProduct"
        case .Products_Demo_Warrant_Product_Type_ImageAndError(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_Products_Demo_Warrant_Product_Type_ImageAndError"
        case .Products_Demo_Warranty_Update(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_Products_Demo_Warranty_Update"
        case .Products_Demo_Upload_Image_May_Demo(_):
            return "/mpos-cloud-api/api/Upload/mpos_FRT_Image_May_Demo"
        case .Products_Demo_Warranty_Product_GetDetailsItem(_):
            return "/mpos-cloud-api/api/Product/mpos_FRT_Products_Demo_Warranty_Product_GetDetailsItem"
        case .mpos_FRT_SP_check_VC_crm(_):
            return "/mpos-cloud-api/api/Order/mpos_FRT_SP_check_VC_crm"
        case .mpos_FRT_SP_check_otp_VC_CRM(_):
            return "/mpos-cloud-api/api/Order/mpos_FRT_SP_check_otp_VC_CRM"
        case .CustomerResult_HDItel(_):
            return "/mpos-cloud-api/api/ImgActiveSim/CustomerResult_HDItelecom"
            //sms banking
        case .mpos_FRT_SMS_Banking_GetSMS(_):
            return "/mpos-cloud-api/api/PaymentBank/mpos_FRT_SMS_Banking_GetSMS"
        case .mpos_FRT_SP_GetCode_QRcode_payment(_):
            return "/mpos-cloud-api/api/Order/mpos_FRT_SP_GetCode_QRcode_payment"
        case .mpos_FRT_SP_GetCode_QRcode_payment_Airpay:
            return "/api/airpay/CreateQRCode"
        case .mpos_FRT_SP_GetCode_QRcode_payment_AirpayStatus:
            return "/api/airpay/QRCodeStatus"
        case .mpos_FRT_SP_GetCode_QRcode_payment_Foxpay:
            return "/api/payment/CreateQRCode"
        case .mpos_FRT_SP_GetCode_QRcode_payment_FoxpayStatus:
            return "/api/payment/QRCodeStatus"
        case .mpos_FRT_SP_VC_get_list_voucher_by_phone(_):
            return "/mpos-cloud-api/api/order/mpos_FRT_SP_VC_get_list_voucher_by_phone"
        case .mpos_FRT_ActiveSim_VNM_Swap_Info_GetData(_):
            return "/mpos-cloud-api/api/Sim/mpos_FRT_ActiveSim_VNM_Swap_Info_GetData"
        case .mpos_sp_Order_getSOdetails(_):
            return "/mpos-cloud-api/api/order/mpos_sp_Order_getSOdetails"
        case .GetPayTeleChargeVTInfo(_):
            return "/mpos-cloud-api/api/viettelpay/GetPayTeleChargeVTInfo"
            //Viettel tra sau
        case .ViettelPay_RegisterAuthority(_):
            return "/mpos-cloud-api/api/ViettelPay/RegisterAuthority"
        case .ViettelPay_ConfirmAuthority(_):
            return "/mpos-cloud-api/api/ViettelPay/ConfirmAuthority"
        case .ViettelPay_GetPayTeleCharge(_):
            return "/mpos-cloud-api/api/ViettelPay/GetPayTeleCharge"
        case .ViettelPay_PayTeleCharge(_):
            return "/mpos-cloud-api/api/ViettelPay/PayTeleCharge"
            //thu ho smartpay
        case .THSmartPay_CheckInfo(_):
            return "/mpos-cloud-api/api/SmartNet/CheckInfo"
        case .THSmartPay_RepaymentForMobile(_):
            return "/mpos-cloud-api/api/SmartNet/RepaymentForMobile"
        case .sp_FRTCallLog_Web_BrowserPaymentRequest_GetOrganizationHierachies:
            return "/mpos-cloud-api/api/RequestPayment/sp_FRTCallLog_Web_BrowserPaymentRequest_GetOrganizationHierachies"
        case .sp_FRT_Web_BrowserPaymentRequest_GetThue:
            return "/mpos-cloud-api/api/RequestPayment/sp_FRT_Web_BrowserPaymentRequest_GetThue"
        case .getReceiptMasterData(_):
            return "/mpos-cloud-api/api/Product/GetReceiptMasterData"
        case .CreateInstallationReceipt(_):
            return "/mpos-cloud-api/api/Product/CreateInstallationReceiptVer2"
        case .GetInstallationReceiptList(_):
            return "/mpos-cloud-api/api/Product/GetInstallationReceiptList"
        case .GetInstallationReceiptDetailByReceiptId(_):
            return "/mpos-cloud-api/api/Product/GetInstallationReceiptDetailByReceiptId"
        case .checkBtsUploaded:
            return "/mpos-cloud-api/api/backtoschool/mdel_BackToSchool_Check_Voucher"
        case .updateBTSMdeli:
            return "/mpos-cloud-api/api/backtoschool/mdel_BackToSchool_UpdateHinhAnh"
        case .sendOTPForCustomer(_):
            return "/mpos-cloud-api/api/Product/SendOtpSmsToCustomer"
        case .deleteInstallatioReceipt(_):
            return "/mpos-cloud-api/api/Product/DeleteReceipt"
        case .confirmOTPReceipt(_):
            return "/mpos-cloud-api/api/Product/ConfirmOtp"
        case .returnDeviceReceipt(_):
            return "/mpos-cloud-api/api/Product/ReturnDeviceToCustomer"
        case .sp_mpos_FRT_SP_GetNotiSauChamCong(_):
            return "/mpos-cloud-api/api/Notification/mpos_oneapp_getNoti_SauChamCong"

        }
    }
    var method: Moya.Method {
        switch self {
        case .FRT_SP_mpos_loadSPTraGop,.getTonKhoShopGanNhat,.getListImeiBook,.getVendorInstallment,.loadDebitCustomer,.searchCustomersToshiba,.getToshibaPoint,.removeSO,.getListLoaiSimV2,.getListSimBookByShopV2,.huyBookSoV2,.GetDistricts,.GetPrecincts,.SearchNationality,.GetProvinces,.getListCustomersViettel,.checkGoiCuocVNMobile,.GetListSearchOldProduct,.getListOldProduct,.getOCRDFFriend,.mpos_sp_LichSuMuahang,.mpos_sp_CancelFormDKSingle_TraGopOnline,.mpos_sp_PrintPhieuDKPOS,.getVendorFFriend,.sp_mpos_CheckCreateCustomer,.mpos_sp_GetBank_CreditNoCard,.mpos_sp_GetLink_CMND_UQTN_Credit,.mpos_sp_getVendors_All,.mpos_sp_SearchVendor,.getTinhThanhFFriend,.getThongTinNganHangFFriend,.mpos_sp_LoadTinhThanhPho,.mpos_sp_LoadQuanHuyen,.mpos_sp_GetMoiLienHeVoiNguoiLL,.mpos_sp_PrintUQTNPOS,.getHinhThucGiaoHangFFriend,.sp_mpos_CheckAccount_SkipOTP_ShopApDung,.FRT_SP_CRM_DSNhaMang_bookSim,.getListGoiCuocBookSimV2,.getThongTinGiaHanSSD,.getListNhaThuoc,.getListNhanVienThuocLongChau,.getInfoActiveSimbyPhone,.BaoHiem_GetHangXe,.BaoHiem_GetLoaiXe,.BaoHiem_GetSP,.BaoHiem_GetPhuongXa,.BaoHiem_GetQuan,.BaoHiem_GetDungTich,.BaoHiem_getGiaBan_BHX,.BaoHiem_getGiaBanAll_BHX,.BaoHiem_GetTinhThanh,.GetSearchCustomers,.GetCheckVoucher,.GetTopUpList,.GetTopUpPrice,.GetPayCodeList,.GetPayCodePrice,.getThongTinDatCoc,.getPriceGoiBH,.VinaGame_GetListDH,.VinaGame_GetListDHIntalled,.getListNCC,.getListPOAll,.getHistoryNhapHang,.searchCNMD_subsidy,.loadInfoLockDevice,.GetBaoHanhPhuKien,.LayTinhTrangMay,.baoHanhPhuKien_LoadLoai,.GetCRMPaymentHistory,.getVendorCurator_Getvendor,.getVendorCurator_GetHead_PD,.getVendorCurator_GetCurator,.getInfo_Curator,.getEmployeeInfo, .getListVendors, .getHistoryCheckIn,.getTonKhoShop,.mpos_sp_UpdateTargetPD_GetPD,.mpos_sp_UpdateTargerPD_GetInfo,.mpos_sp_UpdateTargerPD_Delete,.sp_mpos_FRT_SP_SIM_loadDSGoiCuoc_ecom,.mpos_FRT_MD_SP_MPOS_PhanLoai,.mpos_FRT_MD_mpos_searchkeyword,.mpos_FRT_SP_LoadSO_mpos_pre,.sp_mpos_FRT_SP_comboPK_fix_Price,.sp_mpos_InstallCustInfo_CalllogCIC_CheckAndCreate,.sp_mpos_HuyCalllog_UQTN_HetHan, .VTGetSimInfoByPhoneNumber, .GetProvincesSim,.sp_mpos_Getinfo_SaoKeLuong,.sp_mpos_info_SaoKeLuong_Huy,.sp_mpos_Scoring_CheckDiemLietFRT,.sp_mpos_Scoring_CheckDiemLietFRT_ByCMND,.sp_mpos_Scoring_LoadKyHanTraGop,.sp_mpos_FRT_SP_GetFormNotiHome,.sp_mpos_FRT_SP_Camera_listShopByUser,.sp_mpos_FRT_SP_Camera_getLinkDetail_online,.sp_mpos_FRT_SP_Load_OutSide_Info,.sp_mpos_FRT_SP_OutSide_LS_ThuHo,.sp_mpos_FRT_SP_OutSide_LS_TheCao,.sp_mpos_FRT_SP_OutSide_ls_naptien,.mpos_sp_GetVendor_DuoiEmail,.mpos_sp_GetVendor_ChucVu,.mpos_sp_GetVendor_ChiNhanhDN,.getVendorFFriend_V2,.sp_mpos_CheckHanMucKH,.mpos_FRT_SP_Mirae_loadTypeDoc,.mpos_FRT_SP_Mirae_loadProvince,.mpos_FRT_SP_Mirae_loadPrecinct,.mpos_FRT_SP_Mirae_loadDistrict,.mpos_FRT_SP_mirae_loadDueDay,.mpos_FRT_SP_Mirae_laythongtinkhachhang_order,.mpos_FRT_SP_mirae_Getinfo_byContractNumber,.mpos_FRT_SP_mirae_history_order_byuser,.mpos_FRT_SP_mirae_history_order_byID,.mpos_FRT_SP_mirae_finish_hopdong,.mpos_ConfirmUploadComplete,.mpos_FRT_SP_Mirae_DS_sanpham, .Score_GetListObject, .Score_GetGroupItem, .Score_GetContentGroupItem, .BackToSchool_CheckSBD, .BackToSchool_LoadThongTinKHBySBD, .FRT_SP_linksendo,.mpos_FRT_SP_mirae_loadreasoncance, .PaymentOfFunds_GetList, .PaymentOfFunds_CallLogNopQuy,.sp_FRT_Web_BrowserPaymentRequest_GetBank,.sp_FRT_Web_BrowserPaymentRequest_GetTinhThanh,.sp_FRT_Web_BrowserPaymentRequest_GetLoaiKyHD,.sp_FRT_Web_BrowserPaymentRequest_GetDonVi,.sp_FRT_Web_BrowserPaymentRequest_GetKyHan,.mpos_FRT_SP_mirae_load_by_SOPOS, .sp_mpos_FRT_SP_Notify_Confirm,.inov_masterDataLyDoGiamGia,.inov_listTonKhoSanPham,.checkPromotionImeis,.sp_mpos_Get_PaymentType_From_POS, .SearchProductWithItemCode, .SearchProductWithPlace, .mpos_sp_GetImageWarrantyByDocEntry,.mpos_FRT_Mirae_getAll_Documents, .mpos_FRT_Mirae_LoadInfo_Send_Bill,.mpos_FRT_SP_Mirae_loadTienCTMayCu,.mpos_FRT_SP_ThuMuaMC_get_list_detail,.mpos_FRT_SP_ThuMuaMC_get_list_Loai,.mpos_FRT_SP_ThuMuaMC_get_list,.mpos_FRT_SP_ThuMuaMC_get_info,.mpos_GetPlayBackCamera, .mpos_FRT_Report_InstallApp,.mpos_FRT_SP_Mirae_noteforsale,.mpos_FRT_SP_mirae_history_order_byuser_HD_pending,.sp_mpos_FRT_SP_innovation_loadDS_nhanvien, .Maycu_Ecom_GetListProduct, .Maycu_Ecom_GetColor_Product,.getSODetailFF, .MayCuEcom_GetItemDetail, .Report_InstallApp_Utop,.mpos_FRT_SP_VNPT_loadinfoByCMND,.mpos_FRT_SP_VNPT_sendotp,.mpos_FRT_SP_VNPT_load_history,.mpos_FRT_SP_Ecom_FFriend_load_SOEcom, .mpos_FRT_SP_BH_history_thongtinKH,.mpos_FRT_Mirae_NotiAfterUploadImageComplete,.mpos_FRT_Mirae_CreateCalllog_DuyetHinhAnh,.mpos_FRT_SP_Mirae_history_order_byKeyword,.mpos_FRT_Flight_Tripi_GetHistory,.mpos_FRT_Flight_Tripi_GetDetailInfor,.mpos_FRT_SP_SK_viewdetail_all,.mpos_FRT_SP_SK_viewdetail_Rcheck,.mpos_FRT_SP_SK_load_header,.mpos_FRT_SP_SK_header_complete_detail,.mpos_FRT_SP_SK_header_complete,.mpos_FRT_SP_SK_view_detail_after_sale_rightphone,.mpos_FRT_SP_SK_view_image,.mpos_FRT_SP_SK_nganhang_type,.mpos_FRT_SP_SK_nganhang,.mpos_FRT_SP_SK_load_tinh,.mpos_FRT_SP_SK_Load_TienRcheck, .Tintuc_detail_baiviet,.mpos_FRT_SP_list_PMHThayThePK_ecom,.checkpromotionfrtBaoHiem, .getTinTuc_New, .mpos_FRT_MayCuEcom_GetHinhMau,.mpos_FRT_SP_SK_Load_default_imei, .Products_Demo_Warranty_ListProduct, .Products_Demo_Warrant_Product_Type_ImageAndError, .Products_Demo_Warranty_Product_GetDetailsItem, .mpos_FRT_SMS_Banking_GetSMS,.mpos_FRT_ActiveSim_VNM_Swap_Info_GetData, .mpos_sp_Order_getSOdetails,.getEmployeeSOHeaders, .backToSchool_TimKiem_ByKey, .backToSchool_TimKiem_ByUser, .backToSchool_LoadHistoryKHBySBD, .sp_FRTCallLog_Web_BrowserPaymentRequest_GetOrganizationHierachies, .sp_FRT_Web_BrowserPaymentRequest_GetThue,.getReceiptMasterData,.GetInstallationReceiptList,.GetInstallationReceiptDetailByReceiptId,.sp_mpos_FRT_SP_GetNotiSauChamCong,.thong_bao_tai_lieu:
            return .get
            
        case .updateDeviceInfo,.getAmortizationsDefinitions,.getAllAmortizationsProperties,.getAllAmortizationsPrePays,.getAllAmortizationsTerms,.getAmortizationsDefinitionsDetail,.checkInventory,.checkVoucherKMBookSim,.checkPromotionNew,.getImei,.saveOrder,.getSearchSimV2,.checkGoiCuocVaSim,.dangKyBookSoV2,.AutoCreateImageActiveSimViettelHD,.AutoCreateImageActiveSimVNPhone,.AutoCreateImageActiveSimMobiPhone,.AutoCreateImageActiveSimVietnamobile,.ActiveSim,.getEcomSOHeader,.getSODetails,.mpos_sp_calllog_UpdateImei_Ecom,.mpos_sp_UploadHinhAnhPDK,.mpos_sp_UploadChungTuHinhAnh,.mpos_sp_SaveImageFriend_ChungTuDoiTra,.AddCustomerFFriend,.sp_CreditNoneCard_UploadImage_RequestV2,.UploadImage_CreditNoCard,.mpos_sp_SaveImageFriend,.mpos_sp_SaveImageFriend_ChanDung,.mpos_sp_SendOTPCustomerFriend,.checkPromotionFF,.mpos_sp_insert_order_ffriend,.CheckAccount_SkipOTP,.getListLichSuKichHoat,.getListLichSuKichHoatSerial,.uploadHinhGiaHanSSD,.giaHanSSDResult,.getOTPGiaHanSSD,.insertThuHoLongChau,.SendOTPConvert4G,.changeSim4G,.SendOTPInfoActiveSim,.updateInfoVNM,.BaoHiem_GetToken,.BaoHiem_AddOrder,.GetProvidersNew,.GetAgumentFtel,.GetPaymentFtel,.GetBill,.GetListCustomer,.GetFtelLocations,.GetEncashAgribankResult,.GetEncashpayooResult,.GetPayooTopup,.GetPayooPayResult,.GetVietNamMobileTheCaoPayResult,.GetTopupVNM,.mpos_sp_GetInfoSubsidy,.GetPasscode_Form2Key,.sp_mpos_Get_SSD_GoiCuoc_for_MPOS,.mpos_sp_Get_ThongTinSSD_ChiTietGoiCuoc,.mpos_sp_Get_ThongTinSSD_from_itemcode_goicuoc,.sp_mpos_SSD_MSP_SIM_10_11_for_MPOS,.sp_mpos_GetList_ItemCodeSubSidy,.sp_mpos_FRT_SP_SSD_SoSanhGoiSSD_GoiThuong,.VinaGame_InsertInstallapp,.insertXMLNhapHang,.checkCICKhachHang,.uploadImageLockDevice,.hoantatLockDevice,.GoiPopupHang_Mobile,.TaoPhieuBH_AutoMailChoHang,.Checkimei_V2,.LayHinhThucBanGiaoChoBHV,.LoadHinhThucBanGiao,.TaoPhieuBH_NgayHenTra,.BaoHanhUploadImageNew,.TaoPhieuBH_UpLoadImage,.TaoPhieuBH_LuuPhieuBH,.GetImageBienBanBH,.TaoPhieuBH_Timsanpham,.LayThongTinHinhThucBH,.Checkimei_V2_More,.GetLoadThongTinPhieuTraKH,.GetLoadThongTinBBTraMay,.GetDongBoKnox,.baoHanhPhuKien_SearchLichSu,.checkpromotionActivedSim,.inMoMo,.getDanhSachPhieuMoMo,.Get_CardType_From_POS,.inRutTienMoMo,.LoadThongTinTimKiemThem_Mobile,.GetViettelPayResult,.UpLoadImageSingle_TaoPhieuBH,.getVendorCurator_Saveinfo,.vendorCurator_DeleteInfo , .register, .checkIn, .updateOffEmployee,.mpos_sp_CheckUpdateInfo_TraGop,.mpos_sp_UpdateTargerPD_Saveinfo,.sp_mpos_GetCRMCode_ByMail,.sp_mpos_FRT_SP_comboPK_calculator,.sp_mpos_FRT_SP_ESIM_getqrcode,.sp_mpos_FRT_SP_Esim_getSeri,.sp_mpos_FRT_SP_TraGop_LoadThongTin_LenDoiSP,.VTChangeSimErp, .VTGetListCustomerByIsdnErp, .VTGetReasonCodes, .VTGetChangeSimHistory,.getAllCompanyAmortizations,.sp_mpos_Update_ThongTinSaoKeLuong,.UploadImage_CalllogScoring,.sp_mpos_UploadImageScoring, .confirmPasswordUpdatePG,.sp_mpos_FRT_SP_combopk_searchsp,.mpos_UploadImage_CalllogInside,.mpos_FRT_SP_Calllog_createissue,.ViettelPayTopup,.getProvidersGrab,.payOfflineBillBE,.PayOfflineBillBEHistory_Grab,.mpos_FRT_SP_mirae_checkinfocustomer,.mpos_FRT_SP_Mirae_Insert_image_contract,.mpos_FRT_SP_Mirae_create_infoCustomer,.mpos_FRT_SP_Mirae_LoadKyHan,.UploadImage_Mirae,.saveOrderMirae,.mpos_FRT_SP_mirae_cance_hopdong,.mpos_Mirae_UpdateImei,.mpos_ReSubmitAplication,.BaoLoiNguoiDung__GetConv,.BaoLoiNguoiDung__PushConv, .VTCheckSim, .VTSendOTPErp, .Score_GetListScore, .Score_CreateObject, .Score_CreateGroupItem, .Score_CreateContentScore, .Score_SendRequestScoreToSM, .Score_InActiveOGC, .Score_GetImageListContent, .Score_UploadImage, .Score_CreateRequestScore, .Score_UpdateRequestScore, .Score_UpdateObject, .Score_UpdateGroupItem, .Score_UpdateContentScore, .BackToSchool_UploadImage, .BackToSchool_UpdateThongTinKhachHang, .BackToSchool_UpdateHinhAnh, .PaymentOfFunds_Update, .PaymentOfFunds_UploadImage,.sp_FRTCallLog_Web_BrowserPaymentRequest_GetWarehouseByType,.sp_FRT_Web_BrowserPaymentRequest_GetQuanHuyen,.sp_FRTCallLog_Web_CreateRequestPaymentHomeFromMobile,.Uploads_FileAttachs,.sp_FRT_Web_BrowserPaymentRequest_GetHistory,.mpos_FRT_RequestPaymentHome_UploadImage,.GetinfoCustomerByImageIDCard,.GenerateBirthdayOnMarchVoucher,.otpCashInVTPayEx,.getFeeEx,.makeTransfer,.getMakeTransferHeaders,.GetMakeTransferDetails,.partnerCancel,.editTransfer,.initTransfer,.getFeeCashInEx,.cashIn,.GetInitTransferHeaders,.GetInitTransferDetails,.confirmDelivery,.GetCashInHeaders,.GetCashInDetails,.getTransInfoEx,.resetReceiptCodeEx,.initTransferEx,.confirmCancel,.SaveSignatureOfCust,.CheckCustFeeBack,.mpos_DetectIDCard,.mpos_sp_zen_vocuher_pos,.mpos_verify_maxacthuc_point,.mpos_sp_verify_VC_mpos_innovation,.genQRCode,.checkTransactionQR,.FRT_SP_GetSMS_loyaty,.sp_mpos_FRT_SP_innovation_checkgiamgiatay,.sp_mpos_FRT_SP_innovation_check_IQcode, .mpos_FRT_UploadImage_Warranty,.mpos_FRT_Mirae_Check_Documents_Info,.mpos_FRT_Mirae_Update_WaybillNumber,.checkPromotionMirae,.getImeiFF, .mpos_FRT_Mirae_Send_Documents_Info, .MayCu_Ecom_Update, .Moca_CreateQRCodeMobile, .Moca_Inquiry,.mpos_FRT_SP_VNPT_create_info,.mpos_FRT_SP_VNPT_upload_anhKH,.mpos_FRT_Image_VNPT,.saveOrderVNPT,.checkPromotionVNPT,.mpos_FRT_sp_vnpt_update_image_KH, .mpos_FRT_SP_BH_insert_thongtinKH,.mpos_FRT_Flight_Tripi_InsertBooking,.mpos_FRT_Flight_Tripi_ConfirmBooking, .Flight_Tripi_CreateCalllog, .Flight_Tripi_GetConversation_CreateCalllog,.Get_Info_FF_From_QRCode,.mpos_FRT_SP_mirae_sendsms,.mpos_FRT_SP_SK_Rcheck_insert,.mpos_FRT_SP_SK_confirm_rcheck,.mpos_FRT_Image_SKTelink,.mpos_FRT_SP_SK_confirm_book_order,.mpos_FRT_SP_SK_cance_order,.mpos_FRT_SP_SK_Send_OTP,.mpos_FRT_SP_SK_TaoPhieuRcheck,.mpos_FRT_SP_SK_confirm_upanh_xacnhan,.mpos_FRT_SP_SK_update_info,.mpos_CheckEmail_Vendor_SendOTP,.mpos_FRT_SP_mirae_loadinfoByCMND, .mpos_FRT_MayCuEcom_UploadImage,.CreateOrderForMobile,.QueryOrderSmartPay, .Products_Demo_Warranty_Update, .Products_Demo_Upload_Image_May_Demo,.mpos_FRT_SP_check_VC_crm,.mpos_FRT_SP_check_otp_VC_CRM,.CustomerResult_HDItel,.mpos_FRT_SP_Mirae_loadscheme,.mpos_FRT_SP_GetCode_QRcode_payment,.mpos_FRT_SP_VC_get_list_voucher_by_phone, .backToSchool_InsertData_SinhVienFPT, .backToSchool_HuyVoucher, .GetPayTeleChargeVTInfo, .ViettelPay_RegisterAuthority, .ViettelPay_ConfirmAuthority, .ViettelPay_GetPayTeleCharge, .ViettelPay_PayTeleCharge, .THSmartPay_CheckInfo, .THSmartPay_RepaymentForMobile,.CreateInstallationReceipt,.sendOTPForCustomer,.confirmOTPReceipt,.returnDeviceReceipt,.updateBTSMdeli, .checkBtsUploaded, .mpos_FRT_SP_GetCode_QRcode_payment_Airpay, .mpos_FRT_SP_GetCode_QRcode_payment_AirpayStatus,.mpos_FRT_SP_mirae_tinhsotienchenhlech,.mpos_FRT_SP_GetCode_QRcode_payment_Foxpay, .mpos_FRT_SP_GetCode_QRcode_payment_FoxpayStatus, .getPriceDatCoc,.deleteInstallatioReceipt,.checkTransactionMocaByItemCode:

            return .post
        }
    }
    var task: Task {
        switch self {
        case .updateDeviceInfo:
            var deviceUUID: String = ""
            let deviceName = UIDevice.current.modelName
            let deviceModel = UIDevice.current.modelIdentifier
            let osName = UIDevice.current.systemVersion
            let appVersion = Bundle.versionNumber
            let appID = Bundle.main.bundleIdentifier&
            
            if let udidDevice: UUID = UIDevice.current.identifierForVendor {
                deviceUUID = udidDevice.uuidString
            } else {
                deviceUUID = "XXX-XXX"
            }
            
            let parameters: [String : Any] = ["uuid": deviceUUID,
                                              "osVersion": osName,
                                              "deviceName": deviceName,
                                              "deviceMode": deviceModel,
                                              "user": Cache.user!.UserName,
                                              "appVersion": appVersion,
                                              "appId": appID,
                                              "deviceType": "iOS"]
            print(parameters)
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .FRT_SP_mpos_loadSPTraGop(MaSP,DonGia):
            let shopcode = Cache.user!.ShopCode
            let userid = Cache.user!.UserName
            return .requestParameters(parameters: ["UserID": userid, "MaShop": shopcode,"MaSP":MaSP,"DonGia":DonGia], encoding: URLEncoding.queryString)
        case let .getAmortizationsDefinitions(itemCode,price):
            return .requestParameters(parameters: ["itemCode": itemCode, "price": price], encoding: JSONEncoding.default)
        case  .getAllAmortizationsProperties:
            return .requestPlain
        case  .getAllAmortizationsPrePays:
            return .requestPlain
        case  .getAllAmortizationsTerms:
            return .requestPlain
        case let .getAmortizationsDefinitionsDetail(itemCode,price,proID,prePayID,termID):
            return .requestParameters(parameters: ["itemCode": itemCode, "price": price,"proID":proID,"prePayID":prePayID,"termID":termID], encoding: JSONEncoding.default)
        case let .checkInventory(shopCode,itemCode):
            return .requestParameters(parameters: ["shopCode": shopCode, "itemCode": itemCode], encoding: JSONEncoding.default)
        case let .getTonKhoShopGanNhat(listsp,shopCode):
            return .requestParameters(parameters: ["listsp": listsp, "shopCode": shopCode], encoding: URLEncoding.queryString)
        case let .getListImeiBook(itemCode):
            let shopcode = Cache.user!.ShopCode
            let userid = Cache.user!.UserName
            return .requestParameters(parameters: ["ItemCode": itemCode, "UserID": userid,"MaShop":shopcode,], encoding: URLEncoding.queryString)
        case .getVendorInstallment:
            let shopcode = Cache.user!.ShopCode
            return .requestParameters(parameters: ["shopCode": shopcode], encoding: URLEncoding.queryString)
        case let .loadDebitCustomer(phone):
            return .requestParameters(parameters: ["phone": phone], encoding: URLEncoding.queryString)
        case let .checkVoucherKMBookSim(sdt,xmlvoucher):
            let shopcode = Cache.user!.ShopCode
            let userid = Cache.user!.UserName
            return .requestParameters(parameters: ["sdt": sdt, "xmlvoucher": xmlvoucher,"UserID":userid,"MaShop":shopcode], encoding: JSONEncoding.default)
        case let .checkPromotionNew(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .searchCustomersToshiba(phoneNumber):
            return .requestParameters(parameters: ["phoneOrTaxCode": phoneNumber], encoding: URLEncoding.queryString)
        case let .getToshibaPoint(idCardPoint):
            return .requestParameters(parameters: ["idCardPoint": idCardPoint], encoding: URLEncoding.queryString)
        case let .getImei(productCode,shopCode):
            let productCodeTemp = "\(productCode)".trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            return .requestParameters(parameters: ["productCode": productCodeTemp, "shopCode": shopCode], encoding: JSONEncoding.default)
        case let .removeSO(docEntry):
            let token = Cache.user!.Token
            let crm = MPOSAPIService._defaults.string(forKey: "CRMCode")!
            let userid = Cache.user!.UserName
            return .requestParameters(parameters: ["DocEntry": docEntry,"UserID":userid,"CRMCode":crm,"Token":token], encoding: URLEncoding.queryString)
        case let .saveOrder(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .getPriceDatCoc(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .getListLoaiSimV2(itemCode):
                return .requestParameters(parameters: ["ItemCode": itemCode,"ShopCode":Cache.user!.ShopCode,"UserCode":Cache.user!.UserName], encoding: URLEncoding.queryString)
        case let .getSearchSimV2(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .checkGoiCuocVaSim(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .dangKyBookSoV2(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .getListSimBookByShopV2(sdt):
            let shopcode = Cache.user!.ShopCode
            let userid = Cache.user!.UserName
            let token = Cache.user!.Token
            let crm = MPOSAPIService._defaults.string(forKey: "CRMCode")!
            return .requestParameters(parameters: ["ShopCode": shopcode,"UserID":userid,"SDT":sdt,"CRMCode":crm,"Token":token], encoding: URLEncoding.queryString)
        case let .huyBookSoV2(phoneNumber):
            let userid = Cache.user!.UserName
            return .requestParameters(parameters: ["PhoneNumber": phoneNumber,"UserID":userid], encoding: URLEncoding.queryString)
        case let .GetDistricts(MaCodeTinh,NhaMang):
            return .requestParameters(parameters: ["MaCodeTinh": MaCodeTinh,"NhaMang":NhaMang], encoding: URLEncoding.queryString)
        case let .GetPrecincts(MaCodeHUyen,MaCodeTinh,NhaMang):
            return .requestParameters(parameters: ["MaCodeTinh": MaCodeTinh,"MaCodeHUyen":MaCodeHUyen,"NhaMang":NhaMang], encoding: URLEncoding.queryString)
        case let .SearchNationality(Nhamang):
            return .requestParameters(parameters: ["Nhamang":Nhamang], encoding: URLEncoding.queryString)
        case let .GetProvinces(NhaMang):
            return .requestParameters(parameters: ["NhaMang":NhaMang], encoding: URLEncoding.queryString)
        case let .getListCustomersViettel(idNo):
            return .requestParameters(parameters: ["idNo":idNo], encoding: URLEncoding.queryString)
        case let .checkGoiCuocVNMobile(phoneNumber,cmnd,productCode,goiCuoc,userId,maShop,nhaMang):
            return .requestParameters(parameters: ["phoneNumber":phoneNumber,"cmnd":cmnd,"productCode":productCode,"goiCuoc":goiCuoc,"userId":userId,"maShop":maShop,"nhaMang":nhaMang], encoding: URLEncoding.queryString)
        case let .AutoCreateImageActiveSimViettelHD(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .AutoCreateImageActiveSimVNPhone(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .AutoCreateImageActiveSimMobiPhone(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .AutoCreateImageActiveSimVietnamobile(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .ActiveSim(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        case let .GetListSearchOldProduct(keySearch,shop,skip,top,type):
            let escapedString = keySearch.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            let key = MPOSAPIService._manager.KEY!
            return .requestParameters(parameters: ["keyword":escapedString!,"key":key,"shop":shop,"skip":skip,"top":top,"type":type], encoding: URLEncoding.queryString)
        case let .getListOldProduct(shop,skip,top,type):
            let key = MPOSAPIService._manager.KEY!
            return .requestParameters(parameters: ["key": key,"skip":skip,"top":top,"shop":shop,"type":type], encoding: URLEncoding.queryString)
        case let .getEmployeeSOHeaders(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .getEcomSOHeader(userCode,shopCode):
            return .requestParameters(parameters: ["userCode": userCode, "shopCode": shopCode], encoding: JSONEncoding.default)
        case let .getOCRDFFriend(cmnd,HinhThucMua,MaShop,isQrCode):
            let token = Cache.user!.Token
            let crm = MPOSAPIService._defaults.string(forKey: "CRMCode")
            let userid = Cache.user!.UserName
            return .requestParameters(parameters: ["cmnd": cmnd,"CRMCode":crm ?? "","UserID":userid,"Token":token,"HinhThucMua":HinhThucMua,"MaShop":MaShop,"isQrCode":isQrCode], encoding: URLEncoding.queryString)
        case let .mpos_sp_LichSuMuahang(IDCardCode):
            let token = Cache.user!.Token
            let crm = MPOSAPIService._defaults.string(forKey: "CRMCode")!
            let userid = Cache.user!.UserName
            return .requestParameters(parameters: ["IDCardCode": IDCardCode,"CRMCode":crm,"UserID":userid,"Token":token], encoding: URLEncoding.queryString)
        case let .mpos_sp_CancelFormDKSingle_TraGopOnline(IDFormDK,UserID):
            let token = Cache.user!.Token
            let crm = MPOSAPIService._defaults.string(forKey: "CRMCode")!
            return .requestParameters(parameters: ["IDFormDK": IDFormDK,"UserID":UserID,"DiviceType":2,"CRMCode":crm,"Token":token], encoding: URLEncoding.queryString)
        case let .getSODetails(docEntry):
            let token = Cache.user!.Token
            let crm = MPOSAPIService._defaults.string(forKey: "CRMCode")!
            let userid = Cache.user!.UserName
            return .requestParameters(parameters: ["docEntry": docEntry,"CRMCode":crm,"UserID":userid,"Token":token], encoding: JSONEncoding.default)
        case let .mpos_sp_calllog_UpdateImei_Ecom(UserID,Imei,Itemcode,IDFinal):
            return .requestParameters(parameters: ["UserID": UserID,"DiviceType":2,"Imei":Imei,"Itemcode":Itemcode,"IDFinal":IDFinal], encoding: JSONEncoding.default)
            
        case let .mpos_sp_PrintPhieuDKPOS(IDCardCode,UserID,ID_Final):
            return .requestParameters(parameters: ["IDCardCode": IDCardCode,"UserID":UserID,"ID_Final":ID_Final], encoding: URLEncoding.queryString)
            
        case let .mpos_sp_UploadHinhAnhPDK(IDFinal,ShopCode,UserID,ChuKy,DiviceType,str64_CMNDMT,str64_CMNDMS,str64_ChanDung):
            return .requestParameters(parameters: ["IDFinal": IDFinal,"ShopCode":ShopCode,"UserID":UserID,"ChuKy":ChuKy,"DiviceType":DiviceType,"str64_CMNDMT":str64_CMNDMT,"str64_CMNDMS":str64_CMNDMS,"str64_ChanDung":str64_ChanDung], encoding: JSONEncoding.default)
            
        case let .mpos_sp_UploadChungTuHinhAnh(IdCardCode,Link_UQTN_1,Link_UQTN_2,Link_UQTN_3,Link_CMNDMT,Link_CMNDMS,UserID):
            return .requestParameters(parameters: ["IdCardCode": IdCardCode,"Link_UQTN_1":Link_UQTN_1,"Link_UQTN_2":Link_UQTN_2,"Link_UQTN_3":Link_UQTN_3,"Link_CMNDMT":Link_CMNDMT,"Link_CMNDMS":Link_CMNDMS,"UserID":UserID,"DiviceType":2], encoding: JSONEncoding.default)
        case let . mpos_sp_SaveImageFriend_ChungTuDoiTra(insideCode,idFinal,base64_ChungTuDoiTra):
            return .requestParameters(parameters: ["InsideCode": insideCode,"IDFinal":idFinal,"base64_ChungTuDoiTra":base64_ChungTuDoiTra,"DiviceType":2], encoding: JSONEncoding.default)
        case let .getVendorFFriend(LoaiDN):
            return .requestParameters(parameters: ["LoaiDN": LoaiDN], encoding: URLEncoding.queryString)
        case let .sp_mpos_CheckCreateCustomer(VendorCode,LoaiKH):
            return .requestParameters(parameters: ["VendorCode": VendorCode,"LoaiKH":LoaiKH], encoding: URLEncoding.queryString)
        case let .AddCustomerFFriend(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .sp_CreditNoneCard_UploadImage_RequestV2(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .UploadImage_CreditNoCard(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case  .mpos_sp_GetBank_CreditNoCard:
            return .requestPlain
        case let .mpos_sp_GetLink_CMND_UQTN_Credit(CMND):
            return .requestParameters(parameters: ["CMND": CMND], encoding: URLEncoding.queryString)
        case  .mpos_sp_getVendors_All:
            return .requestPlain
        case let .mpos_sp_SearchVendor(vendor):
            return .requestParameters(parameters: ["vendor": vendor], encoding: URLEncoding.queryString)
        case let .mpos_sp_SaveImageFriend(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .mpos_sp_SaveImageFriend_ChanDung(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case  .getTinhThanhFFriend:
            return .requestPlain
        case let .getThongTinNganHangFFriend(Vendor,CNVendor):
            return .requestParameters(parameters: ["Vendor": Vendor,"CNVendor":CNVendor], encoding: URLEncoding.queryString)
        case  .mpos_sp_LoadTinhThanhPho:
            return .requestPlain
        case let .mpos_sp_LoadQuanHuyen(TinhThanh):
            return .requestParameters(parameters: ["TinhThanh": TinhThanh], encoding: URLEncoding.queryString)
        case  .mpos_sp_GetMoiLienHeVoiNguoiLL:
            return .requestPlain
        case let .mpos_sp_PrintUQTNPOS(IDCardCode,UserID):
            return .requestParameters(parameters: ["IDCardCode": IDCardCode,"UserID":UserID,"DiviceType":2], encoding: URLEncoding.queryString)
        case let .mpos_sp_SendOTPCustomerFriend(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .checkPromotionFF(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .mpos_sp_insert_order_ffriend(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case  .getHinhThucGiaoHangFFriend:
            return .requestPlain
        case  .sp_mpos_CheckAccount_SkipOTP_ShopApDung:
            let shopcode = Cache.user!.ShopCode
            return .requestParameters(parameters: ["Shopcode": shopcode], encoding: URLEncoding.queryString)
        case let .CheckAccount_SkipOTP(UserID,PassWord):
            let shopcode = Cache.user!.ShopCode
            let token = Cache.user!.Token
            let crm = MPOSAPIService._defaults.string(forKey: "CRMCode")!
            return .requestParameters(parameters: ["UserID":UserID,"PassWord":PassWord,"ShopCode":shopcode,"CRMCode":crm,"Token":token], encoding: JSONEncoding.default)
        case let .FRT_SP_CRM_DSNhaMang_bookSim(param):
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case let .getListGoiCuocBookSimV2(NhaMang):
            let token = Cache.user!.Token
            let crm = MPOSAPIService._defaults.string(forKey: "CRMCode")
            let userid = Cache.user!.UserName
            return .requestParameters(parameters: ["NhaMang":NhaMang,"Type":1,"CRMCode":crm ?? "","UserID":userid,"Token":token], encoding: URLEncoding.queryString)
        case let .getListLichSuKichHoat(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .getListLichSuKichHoatSerial(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .getThongTinGiaHanSSD(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .uploadHinhGiaHanSSD(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .giaHanSSDResult(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .getOTPGiaHanSSD(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
            
        case let .getListNhaThuoc(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .insertThuHoLongChau(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .getListNhanVienThuocLongChau(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .SendOTPConvert4G(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .changeSim4G(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .getInfoActiveSimbyPhone(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .SendOTPInfoActiveSim(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .updateInfoVNM(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .BaoHiem_GetHangXe(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .Get_CardType_From_POS(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .BaoHiem_GetLoaiXe(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .BaoHiem_GetSP(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .BaoHiem_GetPhuongXa(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .BaoHiem_GetQuan(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .BaoHiem_GetDungTich(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .BaoHiem_getGiaBan_BHX(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .BaoHiem_getGiaBanAll_BHX(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .BaoHiem_GetToken(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .BaoHiem_GetTinhThanh(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .BaoHiem_AddOrder(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetSearchCustomers(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .GetProvidersNew(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetAgumentFtel(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetPaymentFtel(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetBill(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetListCustomer(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetFtelLocations(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetEncashAgribankResult(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetEncashpayooResult(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetCheckVoucher(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .GetPayooTopup(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetPayooPayResult(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetVietNamMobileTheCaoPayResult(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetTopupVNM(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetTopUpList(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .GetTopUpPrice(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .GetPayCodeList(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .GetPayCodePrice(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .getThongTinDatCoc(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .getPriceGoiBH(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .mpos_sp_GetInfoSubsidy(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetPasscode_Form2Key(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .sp_mpos_Get_SSD_GoiCuoc_for_MPOS(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .mpos_sp_Get_ThongTinSSD_ChiTietGoiCuoc(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .mpos_sp_Get_ThongTinSSD_from_itemcode_goicuoc(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .sp_mpos_SSD_MSP_SIM_10_11_for_MPOS(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .sp_mpos_GetList_ItemCodeSubSidy(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .sp_mpos_FRT_SP_SSD_SoSanhGoiSSD_GoiThuong(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .VinaGame_InsertInstallapp(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .VinaGame_GetListDH(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .VinaGame_GetListDHIntalled(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .getListNCC(param):
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case let .getListPOAll(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .insertXMLNhapHang(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .getHistoryNhapHang(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .searchCNMD_subsidy(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .checkCICKhachHang(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .uploadImageLockDevice(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .hoantatLockDevice(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .loadInfoLockDevice(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .GoiPopupHang_Mobile(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .TaoPhieuBH_AutoMailChoHang(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .Checkimei_V2(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .LayHinhThucBanGiaoChoBHV(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .LoadHinhThucBanGiao(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .TaoPhieuBH_NgayHenTra(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .BaoHanhUploadImageNew(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .TaoPhieuBH_UpLoadImage(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case .GetBaoHanhPhuKien:
            return .requestPlain
        case let .TaoPhieuBH_LuuPhieuBH(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case .LayTinhTrangMay:
            return .requestPlain
        case let .GetImageBienBanBH(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .TaoPhieuBH_Timsanpham(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .LayThongTinHinhThucBH(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .Checkimei_V2_More(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetLoadThongTinPhieuTraKH(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetLoadThongTinBBTraMay(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetDongBoKnox(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .baoHanhPhuKien_SearchLichSu(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case .baoHanhPhuKien_LoadLoai:
            return .requestPlain
        case let .checkpromotionActivedSim(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .inMoMo(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .getDanhSachPhieuMoMo(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetCRMPaymentHistory(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
            
        case let .inRutTienMoMo(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .LoadThongTinTimKiemThem_Mobile(param):
            
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .GetViettelPayResult(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case .getVendorCurator_Getvendor:
            return .requestPlain
        case .getVendorCurator_GetHead_PD:
            return .requestPlain
        case .getVendorCurator_GetCurator:
            return .requestPlain
        case let .getInfo_Curator(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .getVendorCurator_Saveinfo(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .vendorCurator_DeleteInfo(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .UpLoadImageSingle_TaoPhieuBH(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .register(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .getEmployeeInfo(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .checkIn(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .updateOffEmployee(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .getListVendors:
            return .requestPlain
        case let .getHistoryCheckIn(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .getTonKhoShop(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .mpos_sp_UpdateTargetPD_GetPD:
            return .requestPlain
        case let .mpos_sp_UpdateTargerPD_GetInfo(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case  let .mpos_sp_UpdateTargerPD_Delete(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .mpos_sp_UpdateTargerPD_Saveinfo(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .mpos_sp_CheckUpdateInfo_TraGop(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .sp_mpos_FRT_SP_SIM_loadDSGoiCuoc_ecom(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .mpos_FRT_MD_SP_MPOS_PhanLoai(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .mpos_FRT_MD_mpos_searchkeyword(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .mpos_FRT_SP_LoadSO_mpos_pre(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
            
            
            
        case let .sp_mpos_GetCRMCode_ByMail(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
        case let .sp_mpos_FRT_SP_comboPK_fix_Price(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .sp_mpos_FRT_SP_comboPK_calculator(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .sp_mpos_InstallCustInfo_CalllogCIC_CheckAndCreate(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .sp_mpos_FRT_SP_ESIM_getqrcode(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .sp_mpos_FRT_SP_Esim_getSeri(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .sp_mpos_FRT_SP_TraGop_LoadThongTin_LenDoiSP(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .sp_mpos_Getinfo_SaoKeLuong(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .sp_mpos_info_SaoKeLuong_Huy(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .sp_mpos_Update_ThongTinSaoKeLuong(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .UploadImage_CalllogScoring(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .sp_mpos_UploadImageScoring(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .sp_mpos_Scoring_CheckDiemLietFRT(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .sp_mpos_Scoring_CheckDiemLietFRT_ByCMND(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .sp_mpos_Scoring_LoadKyHanTraGop(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case let .sp_mpos_HuyCalllog_UQTN_HetHan(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case .getAllCompanyAmortizations:
            return .requestPlain
        case let .sp_mpos_FRT_SP_OutSide_LS_ThuHo(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .sp_mpos_FRT_SP_OutSide_LS_TheCao(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .sp_mpos_FRT_SP_OutSide_ls_naptien(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .sp_mpos_FRT_SP_Load_OutSide_Info(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .ViettelPayTopup(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            ///thay sim
        case let .VTChangeSimErp(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .VTGetSimInfoByPhoneNumber(param):
            return .requestParameters(parameters: param, encoding:  URLEncoding.queryString)
        case let .VTGetListCustomerByIsdnErp(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .VTGetReasonCodes(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .VTGetChangeSimHistory(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .GetProvincesSim(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
            
        case let .confirmPasswordUpdatePG(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .thong_bao_tai_lieu:
            return .requestPlain
            
        case let .sp_mpos_FRT_SP_combopk_searchsp(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .sp_mpos_FRT_SP_GetFormNotiHome(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .sp_mpos_FRT_SP_Camera_listShopByUser(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .sp_mpos_FRT_SP_Camera_getLinkDetail_online(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_UploadImage_CalllogInside(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_Calllog_createissue(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_sp_GetVendor_DuoiEmail(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_sp_GetVendor_ChucVu(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_sp_GetVendor_ChiNhanhDN(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .getVendorFFriend_V2(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .sp_mpos_CheckHanMucKH(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .getProvidersGrab(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .payOfflineBillBE(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
        case let .PayOfflineBillBEHistory_Grab(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_mirae_checkinfocustomer(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_Mirae_loadTypeDoc(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_Mirae_loadProvince(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_Mirae_loadDistrict(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_Mirae_loadPrecinct(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_Mirae_Insert_image_contract(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_Mirae_create_infoCustomer(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_mirae_loadinfoByCMND(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_Mirae_loadscheme(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_mirae_loadDueDay(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_Mirae_laythongtinkhachhang_order(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_mirae_Getinfo_byContractNumber(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_Mirae_LoadKyHan(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .UploadImage_Mirae(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_mirae_history_order_byuser(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .saveOrderMirae(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_mirae_history_order_byID(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_mirae_cance_hopdong(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_mirae_finish_hopdong(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_Mirae_UpdateImei(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_ReSubmitAplication(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_ConfirmUploadComplete(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_Mirae_DS_sanpham(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_mirae_loadreasoncance(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .BaoLoiNguoiDung__GetConv(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .BaoLoiNguoiDung__PushConv(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .inov_masterDataLyDoGiamGia(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .inov_listTonKhoSanPham(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .checkPromotionImeis(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .mpos_sp_zen_vocuher_pos(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .sp_mpos_Get_PaymentType_From_POS(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .mpos_verify_maxacthuc_point(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .mpos_sp_verify_VC_mpos_innovation(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .genQRCode(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .checkTransactionQR(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .FRT_SP_GetSMS_loyaty(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
            //bo sung esim
        case let .VTCheckSim(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .VTSendOTPErp(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
            //cham diem
            
        case let .Score_GetListObject(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .Score_GetGroupItem(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .Score_GetContentGroupItem(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .Score_GetListScore(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Score_CreateObject(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Score_CreateGroupItem(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Score_CreateContentScore(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Score_SendRequestScoreToSM(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Score_InActiveOGC(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Score_GetImageListContent(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Score_UploadImage(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Score_CreateRequestScore(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Score_UpdateRequestScore(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Score_UpdateObject(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Score_UpdateGroupItem(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Score_UpdateContentScore(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
            
            //back to school
        case let .BackToSchool_CheckSBD(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .BackToSchool_UploadImage(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case .sp_FRT_Web_BrowserPaymentRequest_GetBank:
            return .requestPlain
        case let .sp_FRTCallLog_Web_BrowserPaymentRequest_GetWarehouseByType(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .BackToSchool_UpdateThongTinKhachHang(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
        case let .BackToSchool_UpdateHinhAnh(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
        case let .BackToSchool_LoadThongTinKHBySBD(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .backToSchool_InsertData_SinhVienFPT(params), let .checkBtsUploaded(params), let .updateBTSMdeli(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .backToSchool_TimKiem_ByKey(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case let .backToSchool_TimKiem_ByUser(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case let .backToSchool_HuyVoucher(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case let .backToSchool_LoadHistoryKHBySBD(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
            //Sendo
        case let .FRT_SP_linksendo(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
            //Nop quy NH
        case let .PaymentOfFunds_GetList(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .PaymentOfFunds_CallLogNopQuy(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .PaymentOfFunds_Update(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .PaymentOfFunds_UploadImage(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case .sp_FRT_Web_BrowserPaymentRequest_GetTinhThanh:
            return .requestPlain
        case let .sp_FRT_Web_BrowserPaymentRequest_GetQuanHuyen(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case .sp_FRT_Web_BrowserPaymentRequest_GetLoaiKyHD:
            return .requestPlain
        case .sp_FRT_Web_BrowserPaymentRequest_GetDonVi:
            return .requestPlain
        case .sp_FRT_Web_BrowserPaymentRequest_GetKyHan:
            return .requestPlain
        case let .sp_FRTCallLog_Web_CreateRequestPaymentHomeFromMobile(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Uploads_FileAttachs(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .sp_FRT_Web_BrowserPaymentRequest_GetHistory(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_RequestPaymentHome_UploadImage(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .GetinfoCustomerByImageIDCard(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            //viettelpay
        case let .GenerateBirthdayOnMarchVoucher(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .otpCashInVTPayEx(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .getFeeEx(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .makeTransfer(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
        case let .getMakeTransferHeaders(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .GetMakeTransferDetails(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .partnerCancel(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .editTransfer(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .initTransfer(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .getFeeCashInEx(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .cashIn(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .GetInitTransferHeaders(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .GetInitTransferDetails(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .confirmDelivery(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .GetCashInHeaders(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .GetCashInDetails(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .getTransInfoEx(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .resetReceiptCodeEx(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .initTransferEx(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .confirmCancel(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .SaveSignatureOfCust(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .CheckCustFeeBack(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_DetectIDCard(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_mirae_load_by_SOPOS(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
            
        case let .sp_mpos_FRT_SP_Notify_Confirm(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
            
            //Search MatKinh Dongho
        case let .SearchProductWithItemCode(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .SearchProductWithPlace(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
            
        case let .sp_mpos_FRT_SP_innovation_checkgiamgiatay(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .sp_mpos_FRT_SP_innovation_check_IQcode(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
            
        case let .mpos_FRT_UploadImage_Warranty(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
        case let .mpos_sp_GetImageWarrantyByDocEntry(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_Mirae_getAll_Documents(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_Mirae_Check_Documents_Info(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
        case let .mpos_FRT_Mirae_Update_WaybillNumber(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case .mpos_FRT_Mirae_LoadInfo_Send_Bill:
            return .requestPlain
        case let .mpos_FRT_SP_Mirae_loadTienCTMayCu(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_ThuMuaMC_get_list_detail(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_ThuMuaMC_get_list_Loai(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_ThuMuaMC_get_list(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_ThuMuaMC_get_info(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
            
        case let .checkPromotionMirae(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .getImeiFF(productCode,shopCode):
            let productCodeTemp = "\(productCode)".trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            return .requestParameters(parameters: ["productCode": productCodeTemp, "shopCode": shopCode], encoding: JSONEncoding.default)
        case let .mpos_FRT_SP_mirae_tinhsotienchenhlech(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_GetPlayBackCamera(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_Report_InstallApp(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_Mirae_Send_Documents_Info(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_Mirae_noteforsale(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_mirae_history_order_byuser_HD_pending(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .sp_mpos_FRT_SP_innovation_loadDS_nhanvien(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
            
            
            //may cũ Ecom
        case let .Maycu_Ecom_GetListProduct(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .Maycu_Ecom_GetColor_Product(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .MayCu_Ecom_Update(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
        case let .getSODetailFF(params):
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case let .Moca_CreateQRCodeMobile(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Moca_Inquiry(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .checkTransactionMocaByItemCode(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)

        case let .MayCuEcom_GetItemDetail(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .Report_InstallApp_Utop(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .mpos_FRT_SP_VNPT_loadinfoByCMND(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_VNPT_sendotp(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_VNPT_create_info(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_VNPT_upload_anhKH(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_Image_VNPT(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .saveOrderVNPT(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .checkPromotionVNPT(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .mpos_FRT_SP_VNPT_load_history(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_sp_vnpt_update_image_KH(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case let .mpos_FRT_SP_Ecom_FFriend_load_SOEcom(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
            
            //            bao hiem
        case let .mpos_FRT_SP_BH_insert_thongtinKH(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_BH_history_thongtinKH(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_Mirae_NotiAfterUploadImageComplete(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_Mirae_CreateCalllog_DuyetHinhAnh(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_Mirae_history_order_byKeyword(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_Flight_Tripi_InsertBooking(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_Flight_Tripi_ConfirmBooking(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_Flight_Tripi_GetHistory(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_Flight_Tripi_GetDetailInfor(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
            
            //Callog TRIPI
        case let .Flight_Tripi_CreateCalllog(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Flight_Tripi_GetConversation_CreateCalllog(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Get_Info_FF_From_QRCode(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_mirae_sendsms(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_SK_viewdetail_all(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_SK_viewdetail_Rcheck(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_SK_load_header(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_SK_Rcheck_insert(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_SK_confirm_rcheck(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_Image_SKTelink(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
        case let .mpos_FRT_SP_SK_header_complete_detail(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_SK_header_complete(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_SK_confirm_book_order(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_SK_cance_order(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_SK_view_detail_after_sale_rightphone(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_SK_view_image(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_SK_confirm_upanh_xacnhan(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_SK_nganhang_type(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_SK_Send_OTP(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_SK_nganhang(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_SK_load_tinh(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_SK_TaoPhieuRcheck(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_SK_Load_TienRcheck(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_SK_update_info(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
        case let .Tintuc_detail_baiviet(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_list_PMHThayThePK_ecom(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .checkpromotionfrtBaoHiem(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_CheckEmail_Vendor_SendOTP(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .getTinTuc_New(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_MayCuEcom_UploadImage(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_MayCuEcom_GetHinhMau(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .CreateOrderForMobile(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .QueryOrderSmartPay(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_SK_Load_default_imei(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
            //demo BH
        case let .Products_Demo_Warranty_ListProduct(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .Products_Demo_Warrant_Product_Type_ImageAndError(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .Products_Demo_Warranty_Product_GetDetailsItem(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .Products_Demo_Warranty_Update(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Products_Demo_Upload_Image_May_Demo(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_check_VC_crm(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_SP_check_otp_VC_CRM(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .CustomerResult_HDItel(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            //sms banking
        case let .mpos_FRT_SMS_Banking_GetSMS(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_GetCode_QRcode_payment(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case .mpos_FRT_SP_GetCode_QRcode_payment_Airpay(let params),.mpos_FRT_SP_GetCode_QRcode_payment_AirpayStatus(let params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case .mpos_FRT_SP_GetCode_QRcode_payment_Foxpay(let params), .mpos_FRT_SP_GetCode_QRcode_payment_FoxpayStatus(let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .mpos_FRT_SP_VC_get_list_voucher_by_phone(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_ActiveSim_VNM_Swap_Info_GetData(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_sp_Order_getSOdetails(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .GetPayTeleChargeVTInfo(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            //Viettel tra sau
        case let .ViettelPay_RegisterAuthority(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .ViettelPay_ConfirmAuthority(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .ViettelPay_GetPayTeleCharge(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .ViettelPay_PayTeleCharge(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .THSmartPay_CheckInfo(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .THSmartPay_RepaymentForMobile(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case .sp_FRTCallLog_Web_BrowserPaymentRequest_GetOrganizationHierachies:
            return .requestPlain
        case .sp_FRT_Web_BrowserPaymentRequest_GetThue:
            return .requestPlain
        case let .getReceiptMasterData(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .CreateInstallationReceipt(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .GetInstallationReceiptList(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .GetInstallationReceiptDetailByReceiptId(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .sendOTPForCustomer(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .confirmOTPReceipt(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .returnDeviceReceipt(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .deleteInstallatioReceipt(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .sp_mpos_FRT_SP_GetNotiSauChamCong(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)

        }
    }
    var headers: [String: String]? {
        var access_token = MPOSAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        
        switch self {
        case .GetListSearchOldProduct,.getListOldProduct:
            
            return  ["Content-type": "application/json","Authorization": MPOSAPIService._manager.AUTHORIZATION]
            
        case .Uploads_FileAttachs:
            
            return  ["Content-type": "application/json","Authorization": "Bearer \(access_token!)"]
            
        case .updateDeviceInfo, .updateBTSMdeli, .checkBtsUploaded:
            
            return  ["Content-type": "application/json","Authorization": "Bearer \(access_token!)"]
            
        case .GetPayCodeList,.GetTopUpList,.checkpromotionActivedSim,.GetCheckVoucher,.GetTopUpPrice,.GetPayooTopup,.GetPayCodePrice,.GetViettelPayResult,.GetPayooPayResult,.GetVietNamMobileTheCaoPayResult,.GetBill,.GetProvidersNew,.GetEncashpayooResult,.GetListCustomer,.GetFtelLocations,.GetAgumentFtel,.GetPaymentFtel,.sp_mpos_FRT_SP_Load_OutSide_Info,.sp_mpos_FRT_SP_OutSide_LS_ThuHo,.sp_mpos_FRT_SP_OutSide_LS_TheCao,.sp_mpos_FRT_SP_OutSide_ls_naptien,.Get_CardType_From_POS,.ViettelPayTopup,.sp_FRT_Web_BrowserPaymentRequest_GetHistory,.sp_FRT_Web_BrowserPaymentRequest_GetBank,.sp_FRTCallLog_Web_BrowserPaymentRequest_GetWarehouseByType,.sp_FRT_Web_BrowserPaymentRequest_GetTinhThanh,.sp_FRT_Web_BrowserPaymentRequest_GetQuanHuyen,.sp_FRT_Web_BrowserPaymentRequest_GetLoaiKyHD,.sp_FRT_Web_BrowserPaymentRequest_GetDonVi,.sp_FRT_Web_BrowserPaymentRequest_GetKyHan,.sp_FRTCallLog_Web_CreateRequestPaymentHomeFromMobile,.mpos_FRT_RequestPaymentHome_UploadImage,.getOCRDFFriend,.mpos_sp_LichSuMuahang,.sp_mpos_InstallCustInfo_CalllogCIC_CheckAndCreate,.sp_mpos_Scoring_CheckDiemLietFRT_ByCMND,.getVendorFFriend_V2,.mpos_sp_GetVendor_ChucVu,.mpos_sp_GetVendor_ChiNhanhDN,.getThongTinNganHangFFriend,.getTinhThanhFFriend,.mpos_sp_LoadTinhThanhPho,.mpos_sp_LoadQuanHuyen,.mpos_sp_GetMoiLienHeVoiNguoiLL,.sp_mpos_CheckCreateCustomer,.sp_mpos_UploadImageScoring,.AddCustomerFFriend,.mpos_sp_PrintUQTNPOS,.sp_mpos_Getinfo_SaoKeLuong,.sp_mpos_info_SaoKeLuong_Huy,.sp_mpos_Update_ThongTinSaoKeLuong,.mpos_sp_SendOTPCustomerFriend,.mpos_sp_insert_order_ffriend,.sp_mpos_HuyCalllog_UQTN_HetHan,.mpos_sp_PrintPhieuDKPOS,.checkPromotionFF,.sp_mpos_Scoring_LoadKyHanTraGop,.getHinhThucGiaoHangFFriend,.mpos_FRT_SP_Mirae_noteforsale,.mpos_sp_CheckUpdateInfo_TraGop,.getSODetailFF,.mpos_sp_CancelFormDKSingle_TraGopOnline,.Get_Info_FF_From_QRCode,.getListLoaiSimV2,.checkGoiCuocVaSim,.getSearchSimV2,.FRT_SP_CRM_DSNhaMang_bookSim,.sp_mpos_FRT_SP_SIM_loadDSGoiCuoc_ecom,.dangKyBookSoV2,.getListSimBookByShopV2,.huyBookSoV2,.ActiveSim,.GetDistricts,.GetPrecincts,.GetProvinces,.AutoCreateImageActiveSimViettelHD,.AutoCreateImageActiveSimVNPhone,.AutoCreateImageActiveSimMobiPhone,.AutoCreateImageActiveSimVietnamobile,.getListCustomersViettel,.SearchNationality,.checkGoiCuocVNMobile,.GetinfoCustomerByImageIDCard,.GenerateBirthdayOnMarchVoucher,.getListLichSuKichHoat,.sp_mpos_FRT_SP_ESIM_getqrcode,.getListGoiCuocBookSimV2,.mpos_sp_GetVendor_DuoiEmail,.FRT_SP_mpos_loadSPTraGop,.getTonKhoShopGanNhat,.getListImeiBook,.getVendorInstallment,.loadDebitCustomer,.checkVoucherKMBookSim,.checkPromotionNew,.searchCustomersToshiba,.getToshibaPoint,.removeSO,.saveOrder,.mpos_sp_calllog_UpdateImei_Ecom,.mpos_sp_SaveImageFriend_ChungTuDoiTra,.getVendorFFriend,.sp_CreditNoneCard_UploadImage_RequestV2,.UploadImage_CreditNoCard,.mpos_sp_GetBank_CreditNoCard,.mpos_sp_GetLink_CMND_UQTN_Credit,.mpos_sp_getVendors_All,.mpos_sp_SearchVendor,.mpos_sp_SaveImageFriend,.sp_mpos_CheckAccount_SkipOTP_ShopApDung,.CheckAccount_SkipOTP,.getThongTinGiaHanSSD,.uploadHinhGiaHanSSD,.giaHanSSDResult,.getOTPGiaHanSSD,.getListNhaThuoc,.getListNhanVienThuocLongChau,.insertThuHoLongChau,.SendOTPConvert4G,.changeSim4G,.getInfoActiveSimbyPhone,.SendOTPInfoActiveSim,.updateInfoVNM,.BaoHiem_GetHangXe,.BaoHiem_GetLoaiXe,.BaoHiem_GetSP,.BaoHiem_GetPhuongXa,.BaoHiem_GetQuan,.BaoHiem_GetDungTich,.BaoHiem_getGiaBan_BHX,.BaoHiem_getGiaBanAll_BHX,.BaoHiem_GetToken,.BaoHiem_GetTinhThanh,.BaoHiem_AddOrder,.GetSearchCustomers,.GetEncashAgribankResult,.getThongTinDatCoc,.sp_mpos_FRT_SP_SSD_SoSanhGoiSSD_GoiThuong,.VinaGame_InsertInstallapp,.VinaGame_GetListDH,.VinaGame_GetListDHIntalled,.getListNCC,.getListPOAll,.insertXMLNhapHang,.getHistoryNhapHang,.searchCNMD_subsidy,.uploadImageLockDevice,.hoantatLockDevice,.loadInfoLockDevice,.checkCICKhachHang,.GoiPopupHang_Mobile,.TaoPhieuBH_AutoMailChoHang,.Checkimei_V2,.LayHinhThucBanGiaoChoBHV,.LoadHinhThucBanGiao,.TaoPhieuBH_NgayHenTra,.BaoHanhUploadImageNew,.TaoPhieuBH_UpLoadImage,.GetBaoHanhPhuKien,.TaoPhieuBH_LuuPhieuBH,.LayTinhTrangMay,.GetImageBienBanBH,.TaoPhieuBH_Timsanpham,.LayThongTinHinhThucBH,.Checkimei_V2_More,.GetLoadThongTinPhieuTraKH,.GetLoadThongTinBBTraMay,.GetDongBoKnox,.baoHanhPhuKien_SearchLichSu,.baoHanhPhuKien_LoadLoai,.inMoMo,.getDanhSachPhieuMoMo,.GetCRMPaymentHistory,.inRutTienMoMo,.LoadThongTinTimKiemThem_Mobile,.getVendorCurator_Getvendor,.getVendorCurator_GetHead_PD,.getVendorCurator_GetCurator,.getInfo_Curator,.getVendorCurator_Saveinfo,.vendorCurator_DeleteInfo, .register, .getEmployeeInfo, .checkIn, .updateOffEmployee, .getListVendors, .getHistoryCheckIn,.getTonKhoShop,.mpos_sp_UpdateTargetPD_GetPD,.mpos_sp_UpdateTargerPD_GetInfo,.mpos_sp_UpdateTargerPD_Delete,.mpos_sp_UpdateTargerPD_Saveinfo,.mpos_FRT_MD_SP_MPOS_PhanLoai,.mpos_FRT_MD_mpos_searchkeyword,.mpos_FRT_SP_LoadSO_mpos_pre,.sp_mpos_GetCRMCode_ByMail,.sp_mpos_FRT_SP_comboPK_calculator,.sp_mpos_FRT_SP_comboPK_fix_Price,.sp_mpos_FRT_SP_Esim_getSeri,.sp_mpos_FRT_SP_TraGop_LoadThongTin_LenDoiSP,.VTChangeSimErp, .VTGetSimInfoByPhoneNumber, .VTGetListCustomerByIsdnErp, .VTGetReasonCodes, .VTGetChangeSimHistory, .GetProvincesSim,.sp_mpos_Scoring_CheckDiemLietFRT, .confirmPasswordUpdatePG,.sp_mpos_FRT_SP_combopk_searchsp,.sp_mpos_FRT_SP_GetFormNotiHome,.sp_mpos_FRT_SP_Camera_listShopByUser,.sp_mpos_FRT_SP_Camera_getLinkDetail_online,.mpos_UploadImage_CalllogInside,.mpos_FRT_SP_Calllog_createissue,.sp_mpos_CheckHanMucKH,.getProvidersGrab,.payOfflineBillBE,.PayOfflineBillBEHistory_Grab,.mpos_FRT_SP_mirae_checkinfocustomer,.mpos_FRT_SP_Mirae_loadTypeDoc,.mpos_FRT_SP_Mirae_loadProvince,.mpos_FRT_SP_Mirae_loadDistrict,.mpos_FRT_SP_Mirae_loadPrecinct,.mpos_FRT_SP_Mirae_Insert_image_contract,.mpos_FRT_SP_Mirae_create_infoCustomer,.mpos_FRT_SP_mirae_loadinfoByCMND,.mpos_FRT_SP_Mirae_loadscheme,.mpos_FRT_SP_mirae_loadDueDay,.mpos_FRT_SP_Mirae_laythongtinkhachhang_order,.mpos_FRT_SP_mirae_Getinfo_byContractNumber,.mpos_FRT_SP_Mirae_LoadKyHan,.UploadImage_Mirae,.mpos_FRT_SP_mirae_history_order_byuser,.saveOrderMirae,.mpos_FRT_SP_mirae_history_order_byID,.mpos_FRT_SP_mirae_cance_hopdong,.mpos_FRT_SP_mirae_finish_hopdong,.mpos_Mirae_UpdateImei,.mpos_ReSubmitAplication,.mpos_ConfirmUploadComplete,.mpos_FRT_SP_Mirae_DS_sanpham, .Score_GetListObject, .Score_GetGroupItem, .Score_GetContentGroupItem, .Score_GetListScore, .Score_CreateObject, .Score_CreateGroupItem, .Score_CreateContentScore, .Score_SendRequestScoreToSM, .Score_InActiveOGC, .Score_GetImageListContent, .Score_UploadImage, .Score_CreateRequestScore, .Score_UpdateRequestScore, .Score_UpdateObject, .Score_UpdateGroupItem, .Score_UpdateContentScore,.mpos_FRT_SP_mirae_loadreasoncance,.otpCashInVTPayEx,.getFeeEx,.makeTransfer,.getMakeTransferHeaders,.GetMakeTransferDetails,.partnerCancel,.editTransfer,.initTransfer,.getFeeCashInEx,.cashIn,.GetInitTransferHeaders,.GetInitTransferDetails,.confirmDelivery,.GetCashInHeaders,.GetCashInDetails,.getTransInfoEx,.resetReceiptCodeEx,.initTransferEx,.confirmCancel,.SaveSignatureOfCust,.CheckCustFeeBack,.mpos_DetectIDCard,.mpos_FRT_SP_mirae_load_by_SOPOS,.inov_masterDataLyDoGiamGia,.inov_listTonKhoSanPham,.checkPromotionImeis,.sp_mpos_Get_PaymentType_From_POS,.genQRCode,.checkTransactionQR,.sp_mpos_FRT_SP_innovation_checkgiamgiatay,.sp_mpos_FRT_SP_innovation_check_IQcode,.mpos_FRT_Mirae_getAll_Documents,.mpos_FRT_Mirae_Send_Documents_Info,.mpos_FRT_SP_Mirae_loadTienCTMayCu,.mpos_FRT_SP_ThuMuaMC_get_list_detail,.mpos_FRT_SP_ThuMuaMC_get_list_Loai,.mpos_FRT_SP_ThuMuaMC_get_list,.mpos_FRT_SP_ThuMuaMC_get_info,.checkPromotionMirae,.mpos_FRT_SP_mirae_tinhsotienchenhlech,.mpos_FRT_Mirae_Check_Documents_Info,.mpos_FRT_SP_mirae_history_order_byuser_HD_pending,.sp_mpos_FRT_SP_innovation_loadDS_nhanvien,.mpos_FRT_SP_VNPT_loadinfoByCMND,.mpos_FRT_SP_VNPT_sendotp,.mpos_FRT_SP_VNPT_create_info,.mpos_FRT_SP_VNPT_upload_anhKH,.mpos_FRT_Image_VNPT,.saveOrderVNPT,.checkPromotionVNPT,.mpos_FRT_SP_VNPT_load_history,.mpos_FRT_sp_vnpt_update_image_KH,.mpos_FRT_SP_Ecom_FFriend_load_SOEcom,.mpos_FRT_Mirae_NotiAfterUploadImageComplete,.mpos_FRT_Mirae_CreateCalllog_DuyetHinhAnh,.mpos_FRT_SP_Mirae_history_order_byKeyword,.mpos_FRT_Flight_Tripi_InsertBooking,.mpos_FRT_Flight_Tripi_ConfirmBooking,.mpos_FRT_Flight_Tripi_GetHistory,.mpos_FRT_Flight_Tripi_GetDetailInfor,.mpos_FRT_SP_mirae_sendsms,.mpos_FRT_SP_SK_viewdetail_all,.mpos_FRT_SP_SK_viewdetail_Rcheck,.mpos_FRT_SP_SK_load_header,.mpos_FRT_SP_SK_Rcheck_insert,.mpos_FRT_SP_SK_confirm_rcheck,.mpos_FRT_Image_SKTelink,.mpos_FRT_SP_SK_header_complete_detail,.mpos_FRT_SP_SK_header_complete,.mpos_FRT_SP_SK_confirm_book_order,.mpos_FRT_SP_SK_cance_order,.mpos_FRT_SP_SK_view_detail_after_sale_rightphone,.mpos_FRT_SP_SK_confirm_upanh_xacnhan,.mpos_FRT_SP_SK_view_image,.mpos_FRT_SP_SK_nganhang_type,.mpos_FRT_SP_SK_Send_OTP,.mpos_FRT_SP_SK_nganhang,.mpos_FRT_SP_SK_load_tinh,.mpos_FRT_SP_SK_TaoPhieuRcheck,.mpos_FRT_SP_SK_Load_TienRcheck,.mpos_FRT_SP_SK_update_info,.mpos_FRT_SP_list_PMHThayThePK_ecom,.checkpromotionfrtBaoHiem,.mpos_CheckEmail_Vendor_SendOTP,.CreateOrderForMobile,.QueryOrderSmartPay,.Report_InstallApp_Utop,.mpos_FRT_SP_SK_Load_default_imei,.UpLoadImageSingle_TaoPhieuBH,.getAmortizationsDefinitions,.getAllAmortizationsProperties,.getAllAmortizationsPrePays,.getAllAmortizationsTerms,.getAmortizationsDefinitionsDetail,.checkInventory,.getImei,.getEcomSOHeader,.getSODetails,.mpos_sp_GetInfoSubsidy,.GetPasscode_Form2Key,.sp_mpos_Get_SSD_GoiCuoc_for_MPOS,.mpos_sp_Get_ThongTinSSD_ChiTietGoiCuoc,.mpos_sp_Get_ThongTinSSD_from_itemcode_goicuoc,.sp_mpos_SSD_MSP_SIM_10_11_for_MPOS,.sp_mpos_GetList_ItemCodeSubSidy,.getAllCompanyAmortizations,.mpos_sp_zen_vocuher_pos,.mpos_verify_maxacthuc_point,.mpos_sp_verify_VC_mpos_innovation,.FRT_SP_GetSMS_loyaty,.getImeiFF,.mpos_FRT_SP_check_VC_crm,.mpos_FRT_SP_check_otp_VC_CRM,.CustomerResult_HDItel,.mpos_FRT_SP_GetCode_QRcode_payment,.mpos_FRT_SP_GetCode_QRcode_payment_Airpay,.mpos_FRT_SP_GetCode_QRcode_payment_AirpayStatus,.mpos_FRT_SP_VC_get_list_voucher_by_phone,.mpos_FRT_ActiveSim_VNM_Swap_Info_GetData,.GetPayTeleChargeVTInfo,.CreateInstallationReceipt,.GetInstallationReceiptList,.GetInstallationReceiptDetailByReceiptId,.getReceiptMasterData, .mpos_FRT_SP_GetCode_QRcode_payment_Foxpay, .mpos_FRT_SP_GetCode_QRcode_payment_FoxpayStatus, .getPriceDatCoc,.sendOTPForCustomer,.deleteInstallatioReceipt,.confirmOTPReceipt,.returnDeviceReceipt,.getPriceGoiBH,.getListLichSuKichHoatSerial,.sp_mpos_FRT_SP_GetNotiSauChamCong,.thong_bao_tai_lieu:

            
            return  ["Content-type": "application/json","Authorization": "Bearer \(access_token!)"]
            
        case .GetTopupVNM:
            
            return  ["Content-type": "application/json","Authorization": "Bearer \(access_token!)"]
            
        case .mpos_sp_UploadHinhAnhPDK:
            
            return  ["Content-type": "application/json","Authorization": "Bearer \(access_token!)"]
            
        case .UploadImage_CalllogScoring,.mpos_sp_UploadChungTuHinhAnh,.mpos_sp_SaveImageFriend_ChanDung:
            
            return  ["Content-type": "application/json","Authorization": "Bearer \(access_token!)"]

        case .mpos_GetPlayBackCamera:
            
            return  ["Content-type": "application/json","Authorization": "Bearer \(access_token!)"]
            
        case .Tintuc_detail_baiviet, .getTinTuc_New, .mpos_FRT_MayCuEcom_UploadImage, .mpos_FRT_MayCuEcom_GetHinhMau, .Maycu_Ecom_GetListProduct, .Maycu_Ecom_GetColor_Product, .MayCu_Ecom_Update, .BackToSchool_CheckSBD, .BackToSchool_UploadImage, .BackToSchool_UpdateThongTinKhachHang, .BackToSchool_UpdateHinhAnh, .backToSchool_InsertData_SinhVienFPT, .BackToSchool_LoadThongTinKHBySBD, .backToSchool_TimKiem_ByKey, .backToSchool_TimKiem_ByUser, .backToSchool_HuyVoucher, .backToSchool_LoadHistoryKHBySBD, .PaymentOfFunds_GetList, .PaymentOfFunds_CallLogNopQuy, .PaymentOfFunds_Update, .PaymentOfFunds_UploadImage,.BaoLoiNguoiDung__GetConv,.BaoLoiNguoiDung__PushConv,.Flight_Tripi_CreateCalllog, .Flight_Tripi_GetConversation_CreateCalllog, .MayCuEcom_GetItemDetail, .Moca_CreateQRCodeMobile, .Moca_Inquiry, .FRT_SP_linksendo, .VTCheckSim, .VTSendOTPErp, .sp_mpos_FRT_SP_Notify_Confirm, .SearchProductWithItemCode, .SearchProductWithPlace, .mpos_FRT_UploadImage_Warranty, .mpos_sp_GetImageWarrantyByDocEntry, .mpos_FRT_Mirae_Update_WaybillNumber, .mpos_FRT_Mirae_LoadInfo_Send_Bill, .mpos_FRT_Report_InstallApp,.mpos_FRT_SP_BH_insert_thongtinKH, .mpos_FRT_SP_BH_history_thongtinKH,.Products_Demo_Warranty_ListProduct, .Products_Demo_Warrant_Product_Type_ImageAndError, .Products_Demo_Warranty_Update, .Products_Demo_Upload_Image_May_Demo, .Products_Demo_Warranty_Product_GetDetailsItem, .mpos_FRT_SMS_Banking_GetSMS, .mpos_sp_Order_getSOdetails,.getEmployeeSOHeaders, .ViettelPay_RegisterAuthority, .ViettelPay_ConfirmAuthority, .ViettelPay_GetPayTeleCharge, .ViettelPay_PayTeleCharge, .THSmartPay_CheckInfo, .THSmartPay_RepaymentForMobile, .sp_FRTCallLog_Web_BrowserPaymentRequest_GetOrganizationHierachies, .sp_FRT_Web_BrowserPaymentRequest_GetThue,.checkTransactionMocaByItemCode:
        
            return  ["Content-type": "application/json","Authorization": "Bearer \(access_token!)"]
        }
    }
    var sampleData: Data {
        return Data()
    }
}


