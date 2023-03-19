//
//  mSMApiManager.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 07/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import Moya;
import SwiftyJSON;

class mSMApiManager{
    public static func GetContactList(keyword: String) -> Response<[Contact]>{
        let returnedData = Response<[Contact]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetContactByKeyword(keyword: keyword), keyPath: "searchContactsResult", mappingObj: Contact.self){ (data, err) in
                let checkingResult = data as? [Contact];
                
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetReportSections(userCode: String, token: String) -> Response<[ReportSections]>{
        let returnedData = Response<[ReportSections]>();
        let dispatchGroup = DispatchGroup();
        
        dispatchGroup.enter();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetReportSections(userCode: userCode, token: token), keyPath: "masm_sp_getPosition_ByUserCodeResult", mappingObj: ReportSections.self) { (data, err) in
                let checkingResult = data as? [ReportSections];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func GetUserCheckinV2Result(userID: String) -> Response<[CheckinResultV2]>{
        let returnedData = Response<[CheckinResultV2]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetUserCheckinV2Result(userID: userID), keyPath: "checkUserCheckInV2Result", mappingObj: CheckinResultV2.self) { (data, err) in
                let checkingResult = data as? [CheckinResultV2];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetUserCheckinResult(userID: String) -> Response<[CheckinResult]>{
        let returnedData = Response<[CheckinResult]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetUserCheckinResult(userID: userID), keyPath: "checkUserCheckInV2Result", mappingObj: CheckinResult.self) { (data, err) in
                let checkingResult = data as? [CheckinResult];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetUserCheckoutResult(userID: String) -> Response<[CheckoutResult]>{
        let returnedData = Response<[CheckoutResult]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetUserCheckoutResult(userID: userID), keyPath: "checkUserCheckOutResult", mappingObj: CheckoutResult.self) { (data, err) in
                let checkingResult = data as? [CheckoutResult];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func GetUserShiftList(userID: String) -> Response<[UserShift]>{
        let returnedData = Response<[UserShift]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetUserShiftList(userID: userID), keyPath: "getListShiftDateResult", mappingObj: UserShift.self) { (data, err) in
                let checkingResult = data as? [UserShift];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func PostCheckinRequest(userID: String, shiftCode: String, type: String) -> Response<[IPCheckingResult]>{
        let returnedData = Response<[IPCheckingResult]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .SendUserCheckinRequest(userID: userID, shiftCode: shiftCode, type: type), keyPath: "insertCheckInResult", mappingObj: IPCheckingResult.self) { (data, err) in
                let checkingResult = data as? [IPCheckingResult];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData
    }
    
    public static func PostCheckoutRequestV2(userID: String, shiftCode: String, type: String) -> Response<[CheckoutResultV2]>{
        let returnedData = Response<[CheckoutResultV2]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .SendUserCheckoutRequest(userID: userID, shiftCode: shiftCode, type: type), keyPath: "insertCheckOutResult", mappingObj: CheckoutResultV2.self) { (data, err) in
                let checkingResult = data as? [CheckoutResultV2];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData
    }
    
    public static func PostCheckoutRequest(userID: String, shiftCode: String, type: String) -> Response<[IPCheckingResult]>{
        let returnedData = Response<[IPCheckingResult]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .SendUserCheckoutRequest(userID: userID, shiftCode: shiftCode, type: type), keyPath: "insertCheckOutResult", mappingObj: IPCheckingResult.self) { (data, err) in
                let checkingResult = data as? [IPCheckingResult];
                returnedData.Data = checkingResult;
                
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData
    }
    
    public static func GetNotification(username: String) -> Response<[CallLog]>{
        let returnedData = Response<[CallLog]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetNotification(username: username), keyPath: "getUserCallLogThongBaoResult", mappingObj: CallLog.self) { (data, err) in
                let checkingResult = data as? [CallLog];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetShopByUser(username: String) -> Response<[Shop]>{
        let returnedData = Response<[Shop]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetShopByUser(username: username), keyPath: "mSM_sp_GetShop_ByUserResult", mappingObj: Shop.self) { (data, err) in
                let checkingResult = data as? [Shop];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetDiscountLoanReport(shopCode: String) -> Response<[DiscountLoan]>{
        let returnedData = Response<[DiscountLoan]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetDiscountLoanReport(shopCode: shopCode), keyPath: "getReportV2BaoCaoNoKhuyenMaiResult", mappingObj: DiscountLoan.self) { (data, err) in
                let checkingResult = data as? [DiscountLoan];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetDiscountFundReport(username: String) -> Response<[DisCountFundNew]>{
        let returnedData = Response<[DisCountFundNew]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse2(target: .GetDiscountFundReport(username: username)) { (data, err) in
                var myErr = err
                if data != nil {
                    do {
                        let json = try JSON(data: data!)
                        let rs = DisCountFundNew.parseObjfromArray(array: json["msm_sp_getDuyetGiamGiaResult"].arrayValue)
                        returnedData.Data = rs
                    } catch let error {
                        myErr = error.localizedDescription
                        returnedData.Data = []
                    }
                }
                returnedData.Error = myErr;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetFFriendInstallReport(username: String) -> Response<[FFriendsInstall]>{
        let returnedData = Response<[FFriendsInstall]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetFFriendInstallReport(username: username), keyPath: "getCaiDatFFriendsResult", mappingObj: FFriendsInstall.self) { (data, err) in
                let checkingResult = data as? [FFriendsInstall];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetPendingRequestReport(username: String) -> Response<[PendingOrder]> {
        let returnedData = Response<[PendingOrder]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetPendingRequestReport(username: username), keyPath: "msm_sp_CallLog_GetDonHangPendingResult", mappingObj: PendingOrder.self) { (data, err) in
                let checkingResult = data as? [PendingOrder];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetNotBoughtCompanyReport(username: String) -> Response<[NotBoughtCompany]>{
        let returnedData = Response<[NotBoughtCompany]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetNotBoughtCompanyReport(username: username), keyPath: "msm_sp_CallLog_GetDoanhNghiepChuaMuaHangResult", mappingObj: NotBoughtCompany.self) { (data, err) in
                let checkingResult = data as? [NotBoughtCompany];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetTotalLoanByShop(username: String) -> Response<[TotalLoanByShop]>{
        let returnedData = Response<[TotalLoanByShop]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetTotalLoanByShop(username: username), keyPath: "msm_sp_CallLog_GetTongNoTheoShopResult", mappingObj: TotalLoanByShop.self) { (data, err) in
                let checkingResult = data as? [TotalLoanByShop];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetFFriendsOrder(username: String) -> Response<[FFriendsOrder]>{
        let returnedData = Response<[FFriendsOrder]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetFFriendsOrder(username: username), keyPath: "msm_sp_CallLog_GetDoanhSoDonHangFFResult", mappingObj: FFriendsOrder.self) { (data, err) in
                let checkingResult = data as? [FFriendsOrder];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetVoucherImg(username: String) -> Response<[VoucherImg]>{
        let returnedData = Response<[VoucherImg]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetVoucherImg(username: username), keyPath: "msm_sp_getBaoCao_TheoDoi_CallLog_HinhAnh_ChungTu_DonHang_FFriendsResult", mappingObj: VoucherImg.self) { (data, err) in
                let checkingResult = data as? [VoucherImg];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetOrderImg(username: String) -> Response<[OrderImg]>{
        let returnedData = Response<[OrderImg]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetOrderImg(username: username), keyPath: "msm_sp_getBaoCao_TheoDoi_CallLog_HinhAnh_DonHang_FFriendsResult", mappingObj: OrderImg.self) { (data, err) in
                let checkingResult = data as? [OrderImg];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetAPRSales(username: String) -> Response<[APRSales]>{
        let returnedData = Response<[APRSales]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetAPRSales(username: username), keyPath: "mSM_sp_Get_DoanhSoShop_APR_TheoShopResult", mappingObj: APRSales.self) { (data, err) in
                let checkingResult = data as? [APRSales];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetConfidentFund(username: String) -> Response<[ConfidentFund]>{
        let returnedData = Response<[ConfidentFund]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetConfidentFund(username: username), keyPath: "msm_sp_get_BaoCaoChiTietQuyTuTinResult", mappingObj: ConfidentFund.self) { (data, err) in
                let checkingResult = data as? [ConfidentFund];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetOverDateWarranty(username: String, shopCode: String) -> Response<[OverDateWarranty]>{
        
        let returnedData = Response<[OverDateWarranty]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetOverDateWarranty(username: username, shopCode: shopCode), keyPath: "getReportV2BaoHanhQuaHanResult", mappingObj: OverDateWarranty.self) { (data, err) in
                let checkingResult = data as? [OverDateWarranty];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetOverProduct(username: String, shopCode: String) -> Response<[OverProduct]>{
        let returnedData = Response<[OverProduct]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetOverProduct(username: username, shopCode: shopCode), keyPath: "getHangOverBanResult", mappingObj: OverProduct.self) { (data, err) in
                let checkingResult = data as? [OverProduct];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetCameraReport(username: String) -> Response<[CameraError]>{
        let returnedData = Response<[CameraError]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetCameraReport(username: username), keyPath: "msm_sp_get_BaoCaoLoiCameraResult", mappingObj: CameraError.self) { (data, err) in
                let checkingResult = data as? [CameraError];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetTargetCustomerCare(username: String) -> Response<[TargetCustomerCare]>{
        let returnedData = Response<[TargetCustomerCare]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetTargetCustomerCare(username: username), keyPath: "msm_sp_get_DiemCSKHWELoveFPTShop2Result", mappingObj: TargetCustomerCare.self) { (data, err) in
                let checkingResult = data as? [TargetCustomerCare];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetRemainOldDevice60Report(username: String, shopCode: String) -> Response<[RemainOldDevice60]>{
        let returnedData = Response<[RemainOldDevice60]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetRemainOldDevice60Report(username: username, shopCode: shopCode), keyPath: "getReportV2TonKhoMayCuOver60Result", mappingObj: RemainOldDevice60.self) { (data, err) in
                let checkingResult = data as? [RemainOldDevice60];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetOverDeviceReport(username: String, shopCode: String) -> Response<[OverDevice]>{
        let returnedData = Response<[OverDevice]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetOverDeviceReport(username: username, shopCode: shopCode), keyPath: "getReportV2HangOverResult", mappingObj: OverDevice.self) { (data, err) in
                let checkingResult = data as? [OverDevice];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetRemainDeviceByCategory(username: String, shopCode: String) -> Response<[RemainDeviceByCategory]>{
        let returnedData = Response<[RemainDeviceByCategory]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetRemainDeviceByCategory(username: username, shopCode: shopCode), keyPath: "getReportV2TonKhoResult", mappingObj: RemainDeviceByCategory.self) { (data, err) in
                let checkingResult = data as? [RemainDeviceByCategory];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetAccessoryRealtimeReport(username: String) -> Response<[AccessoryRealtime]>{
        let returnedData = Response<[AccessoryRealtime]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetAccessoryRealtimeReport(username: username), keyPath: "sp_mSM_Report_DoanhSo_PK_RealtimeResult", mappingObj: AccessoryRealtime.self) { (data, err) in
                let checkingResult = data as? [AccessoryRealtime];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetAccessoryRealtimeByZone(username: String) -> Response<[AccessoryRealtime]>{
        let returnedData = Response<[AccessoryRealtime]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetAccessoryRealtimeByZone(username: username), keyPath: "sp_mSM_Report_DoanhSo_PK_Realtime_VungResult", mappingObj: AccessoryRealtime.self) { (data, err) in
                let checkingResult = data as? [AccessoryRealtime];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetAccessoryRealtimeByArea(username: String) -> Response<[AccessoryRealtime]>{
        let returnedData = Response<[AccessoryRealtime]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetAccessoryRealtimeByArea(username: username), keyPath: "sp_mSM_Report_DoanhSo_PK_Realtime_KhuVucResult", mappingObj: AccessoryRealtime.self) { (data, err) in
                let checkingResult = data as? [AccessoryRealtime];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetAccessoryRealtimeByShop(username: String) -> Response<[AccessoryRealtime]> {
        let returnedData = Response<[AccessoryRealtime]>();
        let dispatchGroup = DispatchGroup();
        
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetAccessoryRealtimeByShop(username: username), keyPath: "sp_mSM_Report_DoanhSo_PK_Realtime_ShopResult", mappingObj: AccessoryRealtime.self) { (data, err) in
                let checkingResult = data as? [AccessoryRealtime];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetSalemanReport(username: String, shopCode: String, token: String) -> Response<[Saleman]>{
        let returnedData = Response<[Saleman]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            
            self.GetServerResponse(target: .GetSalemanReport(username: username, shopCode: shopCode, token: token), keyPath: "mSM_sp_Get_DoanhSo_TheoSalemanResult", mappingObj: Saleman.self) { (data, err) in
                let checkingResult = data as? [Saleman];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetOpenedAccountPending(day: String, month: String, year: String, username: String, type: String) -> Response<[OpenedAccount]>{
        let returnedData = Response<[OpenedAccount]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetOpenedAccountPending(username: username, reportDate: day, reportMonth: month, reportYear: year, type: type), keyPath: "sp_MSM_Report_OpenCreditCard_PendingResult", mappingObj: OpenedAccount.self) { (data, err) in
                let checkingResult = data as? [OpenedAccount];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetOpenedAccountCompleted(day: String, month: String, year: String, username: String, type: String) -> Response<[OpenedAccount]>{
        let returnedData = Response<[OpenedAccount]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetOpenedAccountCompleted(username: username, reportDate: day, reportMonth: month, reportYear: year, type: type), keyPath: "sp_MSM_Report_OpenCreditCard_CompleteResult", mappingObj: OpenedAccount.self) { (data, err) in
                let checkingResult = data as? [OpenedAccount];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetOpenedAccountPendingDetails(reportDate: String, reportMonth: String, reportYear: String, shopCode: String) -> Response<[OpenedAccount]>{
        let returnedData = Response<[OpenedAccount]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetOpenedAccountPendingDetails(reportDate: reportDate, reportMonth: reportMonth, reportYear: reportYear, shopCode: shopCode), keyPath: "sp_MSM_Report_OpenCreditCard_Pending_DetailResult", mappingObj: OpenedAccount.self) { (data, err) in
                let checkingResult = data as? [OpenedAccount];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetOpenedAccountCompletedDetails(reportDate: String, reportMonth: String, reportYear: String, shopCode: String) -> Response<[OpenedAccount]>{
        let returnedData = Response<[OpenedAccount]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetOpenedAccountCompletedDetails(reportDate: reportDate, reportMonth: reportMonth, reportYear: reportYear, shopCode: shopCode), keyPath: "sp_MSM_Report_OpenCreditCard_Complete_DetailResult", mappingObj: OpenedAccount.self) { (data, err) in
                let checkingResult = data as? [OpenedAccount];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetShopSalesByShop(username: String, token: String) -> Response<[ShopSales]>{
        let returnedData = Response<[ShopSales]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetShopSalesByShop(username: username, token: token), keyPath: "mSM_sp_Get_DoanhSoShop_TheoShopResult", mappingObj: ShopSales.self) { (data, err) in
                let checkingResult = data as? [ShopSales];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetShopSalesByZone(username: String, token: String) -> Response<[ShopSales]>{
        let returnedData = Response<[ShopSales]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetShopSalesByZone(username: username, token: token), keyPath: "mSM_sp_Get_DoanhSoShop_TheoVungResult", mappingObj: ShopSales.self) { (data, err) in
                let checkingResult = data as? [ShopSales];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetShopSalesByArea(username: String, token: String) -> Response<[ShopSales]>{
        let returnedData = Response<[ShopSales]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetShopSalesByArea(username: username, token: token), keyPath: "mSM_sp_Get_DoanhSoShop_TheoKhuVucResult", mappingObj: ShopSales.self) { (data, err) in
                let checkingResult = data as? [ShopSales];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func GetShopSalesRealtime(username: String, token: String) -> Response<[ShopSales]>{
        let returnedData = Response<[ShopSales]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetShopSalesRealtime(username: username, token: token), keyPath: "mSM_sp_Get_DoanhSoShopRealTimeResult", mappingObj: ShopSales.self) { (data, err) in
                let checkingResult = data as? [ShopSales];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetLoanRealtimeByShop(username: String, token: String) -> Response<[LoanRealtime]>{
        let returnedData = Response<[LoanRealtime]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetLoanRealtimeByShop(username: username, token: token), keyPath: "sp_mSM_TraGop_VungMien_ShopResult", mappingObj: LoanRealtime.self) { (data, err) in
                let checkingResult = data as? [LoanRealtime];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetLoanRealtimeByZone(username: String, token: String) -> Response<[LoanRealtime]>{
        let returnedData = Response<[LoanRealtime]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetLoanRealtimeByZone(username: username, token: token), keyPath: "sp_mSM_TraGop_VungMien_KhuVucResult", mappingObj: LoanRealtime.self) { (data, err) in
                let checkingResult = data as? [LoanRealtime];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetLoanRealtime(username: String, token: String) -> Response<[LoanRealtime]>{
        let returnedData = Response<[LoanRealtime]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetLoanRealtime(username: username, token: token), keyPath: "sp_mSM_Report_NganhHangTraGopResult", mappingObj: LoanRealtime.self) { (data, err) in
                let checkingResult = data as? [LoanRealtime];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetTargetReport(username: String, year: String, month: String, token: String, shopCode: String) -> Response<[TargetReport]>{
        let returnedData = Response<[TargetReport]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetTargetReport(shopCode: shopCode, month: month, year: year, username: username, token: token), keyPath: "mSM_NhapChiTieuDoanhSo_ReportResult", mappingObj: TargetReport.self) { (data, err) in
                let checkingResult = data as? [TargetReport];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetHealthReport(shopCode: String, type: String, level: String, id: String) -> Response<[ReportHealth]>{
        let returnedData = Response<[ReportHealth]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetHealthReport(id: id, level: level, shopCode: shopCode, type: type), keyPath: "mSM_sp_ChiSoDoLuong_Shop_GetResult", mappingObj: ReportHealth.self) { (data, err) in
                let checkingResult = data as? [ReportHealth];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func GetAreaSalesRealtime(username: String, token: String) -> Response<[RealtimeReport]>{
        let returnedData = Response<[RealtimeReport]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetAreaSalesRealtime(username: username, token: token), keyPath: "mSM_sp_Get_DoanhSoKhuVucRealTimeResult", mappingObj: RealtimeReport.self) { (data, err) in
                let checkingResult = data as? [RealtimeReport];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func GetZoneSalesRealtime(username: String, token: String) -> Response<[RealtimeReport]>{
        let returnedData = Response<[RealtimeReport]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetZoneSalesRealtime(username: username, token: token), keyPath: "mSM_sp_Get_DoanhSoVungRealTimeResult", mappingObj: RealtimeReport.self) { (data, err) in
                let checkingResult = data as? [RealtimeReport];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetG100Realtime(username: String, token: String) -> Response<[G100Realtime]>{
        let returnedData = Response<[G100Realtime]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetG38ShopSalesRealtime(username: username, token: token), keyPath: "sp_MSM_DoanhSoShop_G38_PK_ViewResult", mappingObj: G100Realtime.self) { (data, err) in
                let checkingResult = data as? [G100Realtime];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetG100MTD(username: String, token: String) -> Response<[G100MTD]>{
        let returnedData = Response<[G100MTD]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetG38ShopSalesMTD(username: username, token: token), keyPath: "sp_MSM_DoanhSoShop_G38_ViewResult", mappingObj: G100MTD.self) { (data, err) in
                let checkingResult = data as? [G100MTD];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetShopSalesByCategory(username: String, shopCode: String, token: String) -> Response<[ShopSales]>{
        let returnedData = Response<[ShopSales]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetShopSalesByCategory(username: username, shopCode: shopCode, token: token), keyPath: "getReportV2DoanhSoShopResult", mappingObj: ShopSales.self) { (data, err) in
                let checkingResult = data as? [ShopSales];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetASMAgreement(username: String, reportDate: String) -> Response<[ASMAgreement]>{
        let returnedData = Response<[ASMAgreement]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetASMAgreementReport(username: username, reportDate: reportDate), keyPath: "sp_MSM_Report_XacNhan_NhacNho_ASMResult", mappingObj: ASMAgreement.self) { (data, err) in
                let checkingResult = data as? [ASMAgreement];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetInstallmentRate(username: String, type: String) -> Response<[InstallmentRate]>{
        let returnedData = Response<[InstallmentRate]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            if(type == "2"){
                self.GetServerResponse(target: .GetInstallmentRateByShop(username: username), keyPath: "sp_MSM_TyLeDuyetShop_ViewResult", mappingObj: InstallmentRate.self) { (data, err) in
                    let checkingResult = data as? [InstallmentRate];
                    returnedData.Data = checkingResult;
                    returnedData.Error = err;
                    dispatchGroup.leave();
                }
            }
            if(type == "1"){
                self.GetServerResponse(target: .GetInstallmentRateByZone(username: username), keyPath: "sp_MSM_TyLeDuyetVung_ViewResult", mappingObj: InstallmentRate.self) { (data, err) in
                    let checkingResult = data as? [InstallmentRate];
                    returnedData.Data = checkingResult;
                    returnedData.Error = err;
                    dispatchGroup.leave();
                }
            }
            if(type == "3"){
                self.GetServerResponse(target: .GetInstallmentRateByLender(username: username), keyPath: "sp_MSM_TyLeDuyetNhaTraGop_ViewResult", mappingObj: InstallmentRate.self) { (data, err) in
                    let checkingResult = data as? [InstallmentRate];
                    returnedData.Data = checkingResult;
                    returnedData.Error = err;
                    dispatchGroup.leave();
                }
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetDeviceNotSold(username: String) -> Response<[DeviceNotSold]>{
        let returnedData = Response<[DeviceNotSold]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetDeviceNotSold(username: username), keyPath: "sp_MSM_BaoCao_UyQuyenShop_MayTren50TRResult", mappingObj: DeviceNotSold.self) { (data, err) in
                let checkingResult = data as? [DeviceNotSold];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetTrafficReport(username: String, type: String) -> Response<[Traffic]>{
        let returnedData = Response<[Traffic]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetTrafficReport(username: username, type: type), keyPath: "TrafficResult", mappingObj: Traffic.self) { (data, err) in
                let checkingResult = data as? [Traffic];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetDiscountLoan(shopCode: String) -> Response<[DiscountLoan]>{
        let returnedData = Response<[DiscountLoan]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetDiscountLoanReport(shopCode: shopCode), keyPath: "getReportV2BaoCaoNoKhuyenMaiResult", mappingObj: DiscountLoan.self) { (data, err) in
                let checkingResult = data as? [DiscountLoan];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetUpgradeLoan(shopCode: String) -> Response<[UpgradeLoan]>{
        let returnedData = Response<[UpgradeLoan]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetUpgradeLoan(shopCode: shopCode), keyPath: "sp_MSM_LenDoi_TraGop_Shop_ViewResult", mappingObj: UpgradeLoan.self) { (data, err) in
                let checkingResult = data as? [UpgradeLoan];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetViolationMember(userCode: String) -> Response<[ViolateEmployee]>{
        let returnedData = Response<[ViolateEmployee]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetViolationMember(employeeCode: userCode), keyPath: "sp_MSM_GetListViolationReportResult", mappingObj: ViolateEmployee.self) { (data, err) in
                let checkingResult = data as? [ViolateEmployee];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetUnpaidLoan(shopCode: String) -> Response<[UnpaidLoan]>{
        let returnedData = Response<[UnpaidLoan]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetUnpaidLoan(shopCode: shopCode), keyPath: "sp_MSM_BaoCao_SoNoResult", mappingObj: UnpaidLoan.self) { (data, err) in
                let checkingResult = data as? [UnpaidLoan];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    private static func GetServerResponse(target: mSMApiService, keyPath: String?, mappingObj: Jsonable.Type, handler: @escaping(_ success: Any, _ error: String) -> Void){
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        let apiProvider = MoyaProvider<mSMApiService>(plugins: [VerbosePlugin(verbose: true)]);
        
        apiProvider.request(target, callbackQueue: .global(qos: .background)){ result in
            var response: Any!;
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data;
                let json = try? JSON(data: data);
                
                if(json != nil){
                    var object: Any?;
                    if(keyPath == nil){
                        object = json!.to(type: mappingObj)
                    }
                    else{
                        object = json![keyPath!].to(type: mappingObj);
                    }
                    
                    if let obj = object {
                        DispatchQueue.main.async {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                        response = obj;
                        handler(response as Any,"")
                    }
                    else{
                        DispatchQueue.main.async {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                        handler(response as Any, "Load API ERRO")
                    }
                }
                else{
                    handler(response as Any, "Load API ERRO")
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                handler(response as Any, error.localizedDescription)
            }
        }
    }
    
    private static func GetServerResponse2(target: mSMApiService, handler: @escaping(_ success: Data?, _ error: String) -> Void){
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        let apiProvider = MoyaProvider<mSMApiService>(plugins: [VerbosePlugin(verbose: true)]);
        
        apiProvider.request(target, callbackQueue: .global(qos: .background)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                handler(data,"")
            case let .failure(error):
                handler(nil,error.localizedDescription)
            }
        }
    }
    public static func GetComboPKRealtimeVung(username: String, token: String) -> Response<[ComboPKRealtime]>{
        let returnedData = Response<[ComboPKRealtime]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetComboPKRealtimeVung(username: username, token: token), keyPath: "FRT_SP_MSM_TyLeComboPhuKien_Realtime_Vung_ViewResult", mappingObj: ComboPKRealtime.self) { (data, err) in
                let result = data as? [ComboPKRealtime];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func GetComboPKRealtimeASM(username: String, token: String) -> Response<[ComboPKRealtime]>{
        let returnedData = Response<[ComboPKRealtime]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetComboPKRealtimeASM(username: username, token: token), keyPath: "FRT_SP_MSM_TyLeComboPhuKien_Realtime_KhuVuc_ViewResult", mappingObj: ComboPKRealtime.self) { (data, err) in
                let result = data as? [ComboPKRealtime];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func GetComboPKRealtimeShop(username: String, token: String) -> Response<[ComboPKRealtime]>{
        let returnedData = Response<[ComboPKRealtime]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .GetComboPKRealtimeShop(username: username, token: token), keyPath: "FRT_SP_MSM_TyLeComboPhuKien_Realtime_Shop_ViewResult", mappingObj: ComboPKRealtime.self) { (data, err) in
                let result = data as? [ComboPKRealtime];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    class func GiaTriCotLoi(handler: @escaping (_ SLTraGop:String,_ DSPK:String,_ SLSim:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mSMApiService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.GiaTriCotLoi){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print("GiaTriCotLoi: \(json)")
                if let data1 = json["FRT_SP_GiaTriCotLoiResult"].array {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if(data1.count > 0){
                        var SLTraGop = data1[0]["SLTraGop"].string
                        var DSPK = data1[0]["DSPK"].string
                        var SLSim = data1[0]["SLSim"].string
                        
                        SLTraGop = SLTraGop == nil ? "" : SLTraGop
                        DSPK = DSPK == nil ? "" : DSPK
                        SLSim = SLSim == nil ? "" : SLSim
                        
                        handler(SLTraGop!,DSPK!,SLSim!,"")
                    }else{
                        handler("","","","")
                    }
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                debugPrint(error.localizedDescription)
                handler("","","",error.localizedDescription)
            }
        }
    }
    public static func getListDoanhNghiep(username: String) -> Response<[DoanhNghiep]>{
        let returnedData = Response<[DoanhNghiep]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .getListDoanhNghiep(username: username), keyPath: "sp__mSM__Report__CustReq__GetVendResult", mappingObj: DoanhNghiep.self) { (data, err) in
                let result = data as? [DoanhNghiep];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func getListCallogPending(username: String) -> Response<[CallogPending]>{
        let returnedData = Response<[CallogPending]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .getListCallogPending(username: username), keyPath: "sp__mSM__Report__CustReq__PendingResult", mappingObj: CallogPending.self) { (data, err) in
                let result = data as? [CallogPending];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func getTLDuyetTrongThang(username: String) -> Response<[TLCurrentMonth]>{
        let returnedData = Response<[TLCurrentMonth]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .getTLDuyetTrongThang(username: username), keyPath: "sp__mSM__Report__CustReq__Rat__CurrMonthResult", mappingObj: TLCurrentMonth.self) { (data, err) in
                let result = data as? [TLCurrentMonth];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func getTLDuyetTheoTungThang(username: String, vendorCode: Int) -> Response<[TLPerMonth]>{
        let returnedData = Response<[TLPerMonth]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.getTLDuyetTheoTungThang(username: username, vendorCode: vendorCode), keyPath: "sp__mSM__Report__CustReq__Rat__PerMonthResult", mappingObj: TLPerMonth.self) { (data, err) in
                let result = data as? [TLPerMonth];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func getListDoanhSo_Realtime_SL_May_Vung(username: String, loai:String, token:String) -> Response<[DoanhSoRealtimeSLMay]>{
        let returnedData = Response<[DoanhSoRealtimeSLMay]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.getListDoanhSo_Realtime_SL_May_Vung(username: username, loai:loai, token: token), keyPath: "SP_MSM_ListDoanhSo_Realtime_SL_May_Vung_View_FinalResult", mappingObj: DoanhSoRealtimeSLMay.self) { (data, err) in
                let result = data as? [DoanhSoRealtimeSLMay];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func getListDoanhSo_Realtime_SL_May_Khuvuc(username: String, loai:String, token:String) -> Response<[DoanhSoRealtimeSLMay]>{
        let returnedData = Response<[DoanhSoRealtimeSLMay]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.getListDoanhSo_Realtime_SL_May_Khuvuc(username: username, loai:loai, token: token), keyPath: "SP_MSM_ListDoanhSo_Realtime_SL_May_KhuVuc_View_FinalResult", mappingObj: DoanhSoRealtimeSLMay.self) { (data, err) in
                let result = data as? [DoanhSoRealtimeSLMay];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func getListDoanhSo_Realtime_SL_May_Shop(username: String, loai:String, token:String) -> Response<[DoanhSoRealtimeSLMay]>{
        let returnedData = Response<[DoanhSoRealtimeSLMay]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.getListDoanhSo_Realtime_SL_May_Shop(username: username, loai:loai, token: token), keyPath: "SP_MSM_ListDoanhSo_Realtime_SL_May_Shop_View_FinalResult", mappingObj: DoanhSoRealtimeSLMay.self) { (data, err) in
                let result = data as? [DoanhSoRealtimeSLMay];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func getLuyLe_SL_May_Vung(username: String, loai:String, token:String) -> Response<[DoanhSoRealtimeSLMay]>{
        let returnedData = Response<[DoanhSoRealtimeSLMay]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.getLuyLe_SL_May_Vung(username: username, loai:loai, token: token), keyPath: "SP_MSM_LuyKe_SL_May_Vung_View_FinalResult", mappingObj: DoanhSoRealtimeSLMay.self) { (data, err) in
                let result = data as? [DoanhSoRealtimeSLMay];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func getLuyLe_SL_May_Khuvuc(username: String, loai:String, token:String) -> Response<[DoanhSoRealtimeSLMay]>{
        let returnedData = Response<[DoanhSoRealtimeSLMay]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.getLuyLe_SL_May_Khuvuc(username: username, loai:loai, token: token), keyPath: "SP_MSM_LuyKe_SL_May_KhuVuc_View_FinalResult", mappingObj: DoanhSoRealtimeSLMay.self) { (data, err) in
                let result = data as? [DoanhSoRealtimeSLMay];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func getLuyLe_SL_May_Shop(username: String, loai:String, token:String) -> Response<[DoanhSoRealtimeSLMay]>{
        let returnedData = Response<[DoanhSoRealtimeSLMay]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.getLuyLe_SL_May_Shop(username: username, loai:loai, token: token), keyPath: "SP_MSM_LuyKe_SL_May_Shop_View_FinalResult", mappingObj: DoanhSoRealtimeSLMay.self) { (data, err) in
                let result = data as? [DoanhSoRealtimeSLMay];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func getSL_SIM_Vung(username: String, token: String) -> Response<[SLSIM]>{
        let returnedData = Response<[SLSIM]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.getSL_SIM_Vung(username: username, token: token), keyPath: "FRT_SP_MSM_ListDoanhSo_Realtime_SL_SIM_Vung_View_FinalResult", mappingObj: SLSIM.self) { (data, err) in
                let result = data as? [SLSIM];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func getSL_SIM_khuvuc(username: String, token: String) -> Response<[SLSIM]>{
        let returnedData = Response<[SLSIM]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.getSL_SIM_khuvuc(username: username, token: token), keyPath: "FRT_SP_MSM_ListDoanhSo_Realtime_SL_SIM_khuvuc_View_FinalResult", mappingObj: SLSIM.self) { (data, err) in
                let result = data as? [SLSIM];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func getSL_SIM_Shop(username: String, token: String) -> Response<[SLSIM]>{
        let returnedData = Response<[SLSIM]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.getSL_SIM_Shop(username: username, token: token), keyPath: "FRT_SP_MSM_ListDoanhSo_Realtime_SL_SIM_Shop_View_FinalResult", mappingObj: SLSIM.self) { (data, err) in
                let result = data as? [SLSIM];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func getTyLe_SIM_Vung(username: String, token: String) -> Response<[SLSIM]>{
        let returnedData = Response<[SLSIM]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.getTyLe_SIM_Vung(username: username, token: token), keyPath: "SP_MSM_LuyKe_SL_SIM_Vung_View_FinalResult", mappingObj: SLSIM.self) { (data, err) in
                let result = data as? [SLSIM];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func getTyLe_SIM_Khuvuc(username: String, token: String) -> Response<[SLSIM]>{
        let returnedData = Response<[SLSIM]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.getTyLe_SIM_Khuvuc(username: username, token: token), keyPath: "SP_MSM_LuyKe_SL_SIM_KhuVuc_View_FinalResult", mappingObj: SLSIM.self) { (data, err) in
                let result = data as? [SLSIM];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func getTyLe_SIM_Shop(username: String, token: String) -> Response<[SLSIM]>{
        let returnedData = Response<[SLSIM]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.getTyLe_SIM_Shop(username: username, token: token), keyPath: "SP_MSM_LuyKe_SL_SIM_Shop_View_FinalResult", mappingObj: SLSIM.self) { (data, err) in
                let result = data as? [SLSIM];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func getTraGopVungMien_Team_PTNH_Vung(username: String, token: String) -> Response<[DSTraGop]>{
        let returnedData = Response<[DSTraGop]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.getTraGopVungMien_Team_PTNH_Vung(username: username, token: token), keyPath: "SP_FRT_MSM_TraGopVungMien_Team_PTNH_Vung_ViewResult", mappingObj: DSTraGop.self) { (data, err) in
                let result = data as? [DSTraGop];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func getTraGopVungMien_Team_PTNH_KhuVuc(username: String, token: String) -> Response<[DSTraGop]>{
        let returnedData = Response<[DSTraGop]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.getTraGopVungMien_Team_PTNH_KhuVuc(username: username, token: token), keyPath: "SP_FRT_MSM_TraGopVungMien_Team_PTNH_KhuVuc_ViewResult", mappingObj: DSTraGop.self) { (data, err) in
                let result = data as? [DSTraGop];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func getTraGopVungMien_Team_PTNH_Shop(username: String, token: String) -> Response<[DSTraGop]>{
        let returnedData = Response<[DSTraGop]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.getTraGopVungMien_Team_PTNH_Shop(username: username, token: token), keyPath: "SP_FRT_MSM_TraGopVungMien_Team_PTNH_Shop_ViewResult", mappingObj: DSTraGop.self) { (data, err) in
                let result = data as? [DSTraGop];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func TraGopVungMien_Realtime_Team_PTNH_Vung(username: String, token: String) -> Response<[DSTraGopRealtime]>{
        let returnedData = Response<[DSTraGopRealtime]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.TraGopVungMien_Realtime_Team_PTNH_Vung(username: username, token: token), keyPath: "SP_FRT_MSM_TraGopVungMien_Realtime_Team_PTNH_Vung_ViewResult", mappingObj: DSTraGopRealtime.self) { (data, err) in
                let result = data as? [DSTraGopRealtime];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func TraGopVungMien_Realtime_Team_PTNH_KhuVuc(username: String, token: String) -> Response<[DSTraGopRealtime]>{
        let returnedData = Response<[DSTraGopRealtime]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.TraGopVungMien_Realtime_Team_PTNH_KhuVuc(username: username, token: token), keyPath: "SP_FRT_MSM_TraGopVungMien_Realtime_Team_PTNH_KhuVuc_ViewResult", mappingObj: DSTraGopRealtime.self) { (data, err) in
                let result = data as? [DSTraGopRealtime];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func TraGopVungMien_Realtime_Team_PTNH_Shop(username: String, token: String) -> Response<[DSTraGopRealtime]>{
        let returnedData = Response<[DSTraGopRealtime]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.TraGopVungMien_Realtime_Team_PTNH_Shop(username: username, token: token), keyPath: "SP_FRT_MSM_TraGopVungMien_Realtime_Team_PTNH_Shop_ViewResult", mappingObj: DSTraGopRealtime.self) { (data, err) in
                let result = data as? [DSTraGopRealtime];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    class func getSoCoc(tableData: String, handler: @escaping (_ success:[SoCoc],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mSMApiService>(plugins: [NetworkLoggerPlugin()])
        var rs:[SoCoc] = []
        provider.request(.getSoCoc(username: "\(Cache.user!.UserName)")){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    debugPrint(json)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let traCocResult = json["sp_Baocao_MSM_tracocResult"]
                    debugPrint(json)
                    if let detailResult = traCocResult["\(tableData)"].array {
                        rs = SoCoc.BuildArrayFromJSON(detailResult)
                        handler(rs,"")
                    } else {
                        handler(rs,"LOAD API ERRO")
                    }
                } catch {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"LOAD API ERRO")
                }
                
            case .failure(_):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,"LOAD API ERRO")
            }
        }
    }
    
    public static func ThanhToanHoaDon_CRM001_Vung(username: String, token: String) -> Response<[SLLaiGopThuHo]>{
        let returnedData = Response<[SLLaiGopThuHo]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.ThanhToanHoaDon_CRM001_Vung(username: username, token: token), keyPath: "SP_MSM_ThanhToanHoaDon_CRM001_Vung_ViewResult", mappingObj: SLLaiGopThuHo.self) { (data, err) in
                let result = data as? [SLLaiGopThuHo];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func ThanhToanHoaDon_CRM001_KhuVuc(username: String, token: String) -> Response<[SLLaiGopThuHo]>{
        let returnedData = Response<[SLLaiGopThuHo]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.ThanhToanHoaDon_CRM001_KhuVuc(username: username, token: token), keyPath: "SP_MSM_ThanhToanHoaDon_CRM001_KhuVuc_ViewResult", mappingObj: SLLaiGopThuHo.self) { (data, err) in
                let result = data as? [SLLaiGopThuHo];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func ThanhToanHoaDon_CRM001_Shop(username: String, token: String) -> Response<[SLLaiGopThuHo]>{
        let returnedData = Response<[SLLaiGopThuHo]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.ThanhToanHoaDon_CRM001_Shop(username: username, token: token), keyPath: "SP_MSM_ThanhToanHoaDon_CRM001_Shop_ViewResult", mappingObj: SLLaiGopThuHo.self) { (data, err) in
                let result = data as? [SLLaiGopThuHo];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func KhaiThacKH_CRM_CTKM_Vung(username: String, token: String) -> Response<[KhaiThacKMCRM]>{
        let returnedData = Response<[KhaiThacKMCRM]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.KhaiThacKH_CRM_CTKM_Vung(username: username, token: token), keyPath: "sp_MSM_FRT_MSM_KhaiThacKH_CRM_CTKM_Shop_ViewResult", mappingObj: KhaiThacKMCRM.self) { (data, err) in
                let result = data as? [KhaiThacKMCRM];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func KhaiThacKH_CRM_CTKM_KhuVuc(username: String, token: String) -> Response<[KhaiThacKMCRM]>{
        let returnedData = Response<[KhaiThacKMCRM]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.KhaiThacKH_CRM_CTKM_KhuVuc(username: username, token: token), keyPath: "SP_FRT_MSM_KhaiThacKH_CRM_CTKM_KhuVuc_ViewResult", mappingObj: KhaiThacKMCRM.self) { (data, err) in
                let result = data as? [KhaiThacKMCRM];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func KhaiThacKH_CRM_CTKM_Shop(username: String, token: String) -> Response<[KhaiThacKMCRM]>{
        let returnedData = Response<[KhaiThacKMCRM]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.KhaiThacKH_CRM_CTKM_Shop(username: username, token: token), keyPath: "SP_FRT_MSM_KhaiThacKH_CRM_CTKM_Shop_ViewResult", mappingObj: KhaiThacKMCRM.self) { (data, err) in
                let result = data as? [KhaiThacKMCRM];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func NhapChiTieuDoanhSo_Report(p_Nam: String, p_Thang: String, p_MaShop: String) -> Response<[TargetReport]>{
        
        let params:[String:String] = [
            "p_UserCode":"\(Cache.user?.UserName ?? "")",
            "p_Nam":"\(p_Nam)",
            "p_Thang":"\(p_Thang)",
            "p_MaShop":"\(p_MaShop)",
            "p_Token":"\(Cache.user?.Token ?? "")"
        ]
        
        debugPrint(params)
        
        let returnedData = Response<[TargetReport]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.NhapChiTieuDoanhSo_Report(params: params), keyPath: "mSM_NhapChiTieuDoanhSo_ReportResult", mappingObj: TargetReport.self) { (data, err) in
                let result = data as? [TargetReport];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func NhapChiTieuDoanhSo_Save(p_Nam: String, p_Thang: String, p_Base64_XML_Data: String, p_MaShop: String) -> Response<[DSTargetResponse]>{
        let params:[String:String] = [
            "p_UserCode":"\(Cache.user?.UserName ?? "")",
            "p_Nam":"\(p_Nam)",
            "p_Thang":"\(p_Thang)",
            "p_MaShop":"\(p_MaShop)",
            "p_DeviceType":"2",
            "p_Base64_XML_Data":"\(p_Base64_XML_Data)"
        ]
        
        debugPrint(params)
        
        let returnedData = Response<[DSTargetResponse]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.NhapChiTieuDoanhSo_Save(params: params), keyPath: "mSM_NhapChiTieuDoanhSo_SaveResult", mappingObj: DSTargetResponse.self) { (data, err) in
                let result = data as? [DSTargetResponse];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func sp_mpos_Report_FRT_Visitor_Report(TypeReport: String, TypeView: String,FromDate: String,ToDate:String) -> Response<[VisitorReport]>{
        
        let parameters: [String: String] = [
            "TypeReport": TypeReport,
            "TypeView": TypeView,
            "FromDate": FromDate,
            "User": "\(Cache.user!.UserName)",
            "ToDate":ToDate
        ]
        let returnedData = Response<[VisitorReport]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.sp_mpos_Report_FRT_Visitor_Report(params:parameters), keyPath: "Data", mappingObj: VisitorReport.self) { (data, err) in
                let result = data as? [VisitorReport];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func Report_FRT_SP_Visitor_Report_V2(TypeReport: String, TypeView: String,FromDate: String,ToDate:String) -> Response<[Visitor_Report_V2]>{
        let parameters: [String: String] = [
            "FromDate":"\(FromDate)",
            "ToDate":"\(ToDate)",
            "TypeReport":"\(TypeReport)",
            "TypeView":"\(TypeView)",
            "User":"\(Cache.user!.UserName)"
        ]
        let returnedData = Response<[Visitor_Report_V2]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.Report_FRT_SP_Visitor_Report_V2(params:parameters), keyPath: "Data", mappingObj: Visitor_Report_V2.self) { (data, err) in
                let result = data as? [Visitor_Report_V2];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func Report_FRT_SP_Visitor_Report_TheoDoiShop(TypeReport: String, TypeView: String,FromDate: String,ToDate:String, MaShop:String) -> Response<[Visitor_Report_V2]>{
        
        let parameters: [String: String] = [
            "FromDate":"\(FromDate)",
            "ToDate":"\(ToDate)",
            "TypeReport":"\(TypeReport)",
            "TypeView":"\(TypeView)",
            "MaShop":"\(MaShop)",
            "User":"\(Cache.user!.UserName)"
        ]
        let returnedData = Response<[Visitor_Report_V2]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.Report_FRT_SP_Visitor_Report_TheoDoiShop(params:parameters), keyPath: "Data", mappingObj: Visitor_Report_V2.self) { (data, err) in
                let result = data as? [Visitor_Report_V2];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func LoadShopByASM() -> Response<[ShopByASM]>{
        
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        let returnedData = Response<[ShopByASM]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.LoadShopByASM(params:parameters), keyPath: "sp_FRT_SP_LoadShopByASMResult", mappingObj: ShopByASM.self) { (data, err) in
                let result = data as? [ShopByASM];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func CheckListShop_insert(p_List_shop: String, p_content1: String, p_content2: String, p_content3: String, p_content4: String) -> Response<[ShopASM_insertResult]>{
        
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)",
            "p_List_shop":"\(p_List_shop)",
            "p_content1":"\(p_content1)",
            "p_content2":"\(p_content2)",
            "p_content3":"\(p_content3)",
            "p_content4":"\(p_content4)"
        ]
        
        debugPrint(parameters)
        
        let returnedData = Response<[ShopASM_insertResult]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.CheckListShop_insert(params:parameters), keyPath: "sp_FRT_SP_CheckListShop_insertResult", mappingObj: ShopASM_insertResult.self) { (data, err) in
                let result = data as? [ShopASM_insertResult];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    class func Checklistshop_ASM_get(p_Shopcode: String, handler: @escaping (_ arrNoiDung:[Checklistshop_ASM_getNoiDung], _ arrDSTargetPK:[Checklistshop_ASM_getDSTargetPK], _ arrDSTargetTTTraGop:[Checklistshop_ASM_getDSTargetTyTrongTraGop], _ arrDSSPHotSale:[Checklistshop_ASM_getDSSPHotSale],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mSMApiService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Shopcode":"\(p_Shopcode)"
        ]
        
        debugPrint(parameters)
        provider.request(.Checklistshop_ASM_get(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let dataResult = json["FRT_SP_checklistshop_ASM_getResult"].dictionary {
//                    debugPrint(dataResult)
                    
                    let noiDungResult = dataResult["table1"]?.array ?? []
                    let rsNoiDung = Checklistshop_ASM_getNoiDung.parseObjfromArray(array: noiDungResult)
                    
                    let dsTargetPKResult = dataResult["table2"]?.array ?? []
                    let rsDSTargetPK = Checklistshop_ASM_getDSTargetPK.parseObjfromArray(array: dsTargetPKResult)
                    
                    let dsTargetTyTrongTraGopResult = dataResult["table3"]?.array ?? []
                    let rsDSTargetTTTraGop = Checklistshop_ASM_getDSTargetTyTrongTraGop.parseObjfromArray(array: dsTargetTyTrongTraGopResult)
                    
                    let dsTargetSPHotSaleResult = dataResult["table4"]?.array ?? []
                    let rsDSSPHotSale = Checklistshop_ASM_getDSSPHotSale.parseObjfromArray(array: dsTargetSPHotSaleResult)
                    
                    handler(rsNoiDung, rsDSTargetPK, rsDSTargetTTTraGop, rsDSSPHotSale, "")
                    
                } else {
                    handler([], [], [], [],"LOAD API ERRO")
                }
                
            case .failure(_):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], [], [], [],"LOAD API ERRO")
            }
        }
    }
    public static func Checklist_ASM_confirm() -> Response<[ShopASM_insertResult]>{
        
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[ShopASM_insertResult]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.Checklist_ASM_confirm(params:parameters), keyPath: "FRT_SP_checklist_ASM_confirmResult", mappingObj: ShopASM_insertResult.self) { (data, err) in
                let result = data as? [ShopASM_insertResult];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func KhaiThacCombo_LuyKe() -> Response<[KhaiThacCombo]>{
        
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[KhaiThacCombo]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.KhaiThacCombo_LuyKe(params:parameters), keyPath: "SP_FRT_MSM_KhaiThacCombo_LuyKe_ViewResult", mappingObj: KhaiThacCombo.self) { (data, err) in
                let result = data as? [KhaiThacCombo];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func KhaiThacCombo_HomQua() -> Response<[KhaiThacCombo]>{
        
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[KhaiThacCombo]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target:.KhaiThacCombo_HomQua(params:parameters), keyPath: "SP_FRT_MSM_KhaiThacCombo_HomQua_ViewResult", mappingObj: KhaiThacCombo.self) { (data, err) in
                let result = data as? [KhaiThacCombo];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListDoanhSo_Realtime_Vung_NotDA() -> Response<[RealtimeReport]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[RealtimeReport]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListDoanhSo_Realtime_Vung_NotDA(params:parameters), keyPath: "SP_MSM_ListDoanhSo_Realtime_Vung_NotDA_View_FinalResult", mappingObj: RealtimeReport.self) { (data, err) in
                let checkingResult = data as? [RealtimeReport];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func ListDoanhSo_MatKinh_Realtime_Shop_View_Final() -> Response<[DSRealtimeMatKinh]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[DSRealtimeMatKinh]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListDoanhSo_MatKinh_Realtime_Shop_View_Final(params:parameters), keyPath: "SP_FRT_SP_MSM_ListDoanhSo_MatKinh_Realtime_Shop_View_FinalResult", mappingObj: DSRealtimeMatKinh.self) { (data, err) in
                let checkingResult = data as? [DSRealtimeMatKinh];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListDoanhSo_Realtime_ShopMyPham() -> Response<[MyPhamRealtime]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[MyPhamRealtime]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListDoanhSo_Realtime_ShopMyPham(params:parameters), keyPath: "SP_MSM_ListDoanhSo_Realtime_ShopMyPham_View_FinalResult", mappingObj: MyPhamRealtime.self) { (data, err) in
                let checkingResult = data as? [MyPhamRealtime];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListDoanhSo_DongHo_Realtime_Shop() -> Response<[DSRealtimeDongHoShop]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[DSRealtimeDongHoShop]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListDoanhSo_DongHo_Realtime_Shop(params:parameters), keyPath: "SP_MSM_ListDoanhSo_DongHo_Realtime_Shop_View_FinalResult", mappingObj: DSRealtimeDongHoShop.self) { (data, err) in
                let checkingResult = data as? [DSRealtimeDongHoShop];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    public static func ListSP_Realtime_SLSP_Virus_ASM_View() -> Response<[Virus]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[Virus]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_Realtime_SLSP_Virus_ASM_View(params:parameters), keyPath: "SP_FRT_MSM_ListSP_Realtime_SLSP_Virus_ASM_ViewResult", mappingObj: Virus.self) { (data, err) in
                let checkingResult = data as? [Virus];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_Realtime_SLSP_Virus_Shop_View() -> Response<[Virus]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[Virus]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_Realtime_SLSP_Virus_Shop_View(params:parameters), keyPath: "SP_FRT_MSM_ListSP_Realtime_SLSP_Virus_Shop_ViewResult", mappingObj: Virus.self) { (data, err) in
                let checkingResult = data as? [Virus];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_Realtime_SLSP_Virus_Vung_View() -> Response<[Virus]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[Virus]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_Realtime_SLSP_Virus_Vung_View(params:parameters), keyPath: "SP_FRT_MSM_ListSP_Realtime_SLSP_Virus_Vung_ViewResult", mappingObj: Virus.self) { (data, err) in
                let checkingResult = data as? [Virus];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    public static func ListSP_Realtime_SLSP_BHMR_ASM_View() -> Response<[BHMR]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[BHMR]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_Realtime_SLSP_BHMR_ASM_View(params:parameters), keyPath: "SP_FRT_MSM_ListSP_Realtime_SLSP_BHMR_ASM_ViewResult", mappingObj: BHMR.self) { (data, err) in
                let checkingResult = data as? [BHMR];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_Realtime_SLSP_BHMR_Shop_View() -> Response<[BHMR]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[BHMR]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_Realtime_SLSP_BHMR_Shop_View(params:parameters), keyPath: "SP_FRT_MSM_ListSP_Realtime_SLSP_BHMR_Shop_ViewResult", mappingObj: BHMR.self) { (data, err) in
                let checkingResult = data as? [BHMR];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_Realtime_SLSP_BHMR_Vung_View() -> Response<[BHMR]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[BHMR]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_Realtime_SLSP_BHMR_Vung_View(params:parameters), keyPath: "SP_FRT_MSM_ListSP_Realtime_SLSP_BHMR_Vung_ViewResult", mappingObj: BHMR.self) { (data, err) in
                let checkingResult = data as? [BHMR];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    public static func ListSP_LuyKe_SLSP_Virus_ASM_View() -> Response<[Virus]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[Virus]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_LuyKe_SLSP_Virus_ASM_View(params:parameters), keyPath: "SP_FRT_MSM_ListSP_LuyKe_SLSP_Virus_ASM_ViewResult", mappingObj: Virus.self) { (data, err) in
                let checkingResult = data as? [Virus];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_LuyKe_SLSP_Virus_Shop_View() -> Response<[Virus]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[Virus]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_LuyKe_SLSP_Virus_Shop_View(params:parameters), keyPath: "SP_FRT_MSM_ListSP_LuyKe_SLSP_Virus_Shop_ViewResult", mappingObj: Virus.self) { (data, err) in
                let checkingResult = data as? [Virus];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_LuyKe_SLSP_Virus_Vung_View() -> Response<[Virus]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[Virus]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_LuyKe_SLSP_Virus_Vung_View(params:parameters), keyPath: "SP_FRT_MSM_ListSP_LuyKe_SLSP_Virus_Vung_ViewResult", mappingObj: Virus.self) { (data, err) in
                let checkingResult = data as? [Virus];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_LuyKe_SLSP_BHMR_ASM_View() -> Response<[BHMR]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[BHMR]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_LuyKe_SLSP_BHMR_ASM_View(params:parameters), keyPath: "SP_FRT_MSM_ListSP_LuyKe_SLSP_BHMR_ASM_ViewResult", mappingObj: BHMR.self) { (data, err) in
                let checkingResult = data as? [BHMR];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_LuyKe_SLSP_BHMR_Shop_View() -> Response<[BHMR]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[BHMR]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_LuyKe_SLSP_BHMR_Shop_View(params:parameters), keyPath: "SP_FRT_MSM_ListSP_LuyKe_SLSP_BHMR_Shop_ViewResult", mappingObj: BHMR.self) { (data, err) in
                let checkingResult = data as? [BHMR];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_LuyKe_SLSP_BHMR_Vung_View() -> Response<[BHMR]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[BHMR]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_LuyKe_SLSP_BHMR_Vung_View(params:parameters), keyPath: "SP_FRT_MSM_ListSP_LuyKe_SLSP_BHMR_Vung_ViewResult", mappingObj: BHMR.self) { (data, err) in
                let checkingResult = data as? [BHMR];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    public static func ListSP_LuyKe_VeMayBay_Shop_View() -> Response<[VeMayBayItem]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[VeMayBayItem]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_LuyKe_VeMayBay_Shop_View(params:parameters), keyPath: "SP_FRT_MSM_ListSP_LuyKe_VeMayBay_Shop_ViewResult", mappingObj: VeMayBayItem.self) { (data, err) in
                let checkingResult = data as? [VeMayBayItem];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_LuyKe_VeMayBay_ASM_View() -> Response<[VeMayBayItem]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[VeMayBayItem]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_LuyKe_VeMayBay_ASM_View(params:parameters), keyPath: "SP_FRT_MSM_ListSP_LuyKe_VeMayBay_ASM_ViewResult", mappingObj: VeMayBayItem.self) { (data, err) in
                let checkingResult = data as? [VeMayBayItem];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_LuyKe_VeMayBay_Vung_View() -> Response<[VeMayBayItem]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[VeMayBayItem]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_LuyKe_VeMayBay_Vung_View(params:parameters), keyPath: "SP_FRT_MSM_ListSP_LuyKe_VeMayBay_Vung_ViewResult", mappingObj: VeMayBayItem.self) { (data, err) in
                let checkingResult = data as? [VeMayBayItem];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_Realtime_VeMayBay_Shop_View() -> Response<[VeMayBayItem]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[VeMayBayItem]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_Realtime_VeMayBay_Shop_View(params:parameters), keyPath: "SP_FRT_MSM_ListSP_Realtime_VeMayBay_Shop_ViewResult", mappingObj: VeMayBayItem.self) { (data, err) in
                let checkingResult = data as? [VeMayBayItem];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_Realtime_VeMayBay_ASM_View() -> Response<[VeMayBayItem]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[VeMayBayItem]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_Realtime_VeMayBay_ASM_View(params:parameters), keyPath: "SP_FRT_MSM_ListSP_Realtime_VeMayBay_ASM_ViewResult", mappingObj: VeMayBayItem.self) { (data, err) in
                let checkingResult = data as? [VeMayBayItem];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_Realtime_VeMayBay_Vung_View() -> Response<[VeMayBayItem]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[VeMayBayItem]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_Realtime_VeMayBay_Vung_View(params:parameters), keyPath: "SP_FRT_MSM_ListSP_Realtime_VeMayBay_Vung_ViewResult", mappingObj: VeMayBayItem.self) { (data, err) in
                let checkingResult = data as? [VeMayBayItem];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    public static func ListDoanhSo_ShopMyPham_View_Final() -> Response<[ShopMyPhamItem]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[ShopMyPhamItem]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListDoanhSo_ShopMyPham_View_Final(params:parameters), keyPath: "SP_MSM_ListDoanhSo_ShopMyPham_View_FinalResult", mappingObj: ShopMyPhamItem.self) { (data, err) in
                let checkingResult = data as? [ShopMyPhamItem];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func DoanhSoShop_MyPhamSaleman_View() -> Response<[MyPhamSalemanItem2]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)",
            "p_ShopCode":""
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[MyPhamSalemanItem2]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse2(target: .DoanhSoShop_MyPhamSaleman_View(params:parameters)) { (data, err) in
                var myErr = err
                if data != nil {
                    do {
                        let json = try JSON(data: data!)
                        let rs = MyPhamSalemanItem2.parseObjfromArray(array: json["SP_FRT_MSM_DoanhSoShop_MyPhamSaleman_ViewResult"].arrayValue)
                        returnedData.Data = rs
                    } catch let error {
                        myErr = error.localizedDescription
                        returnedData.Data = []
                    }
                }
                returnedData.Error = myErr;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func getMyphameSaleMan_new() -> Response<[MyPhamSalemanNew]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)",
            "p_ShopCode":""
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[MyPhamSalemanNew]>()
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background)
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse2(target: .DoanhSoShop_MyPhamSaleman_View_New(params:parameters)) { (data, err) in
                var myErr = err
                if data != nil {
                    do {
                        let json = try JSON(data: data!)
                        let rs = MyPhamSalemanNew.parseObjfromArray(array: json["sp_FRT_MSM_DoanhSoShop_MyPhamSaleman_View_myphamResult"].arrayValue)
                        returnedData.Data = rs
                    } catch let error {
                        myErr = error.localizedDescription
                        returnedData.Data = []
                    }
                }
                returnedData.Error = myErr
                dispatchGroup.leave()
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func FRT_usp_RP_PRO1_FR_FR124() -> Response<[DSRealTimeDongHoVung]>{
        let parameters: [String: String] = [
            
            "p_UserCode":"\(Cache.user!.UserName)" ,
            "p_NameStore": "",
            "p_NameReport":"",
            "p_StrPar":"",
            "p_IPPub":"",
            "p_IPv4":"",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[DSRealTimeDongHoVung]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .FRT_usp_RP_PRO1_FR_FR124(params:parameters), keyPath: "SP_FRT_usp_RP_PRO1_FR_FR124Result", mappingObj: DSRealTimeDongHoVung.self) { (data, err) in
                let checkingResult = data as? [DSRealTimeDongHoVung];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    public static func ListSP_LuyKe_SLSP_BHMR_ASM_View_NewTest() -> Response<[BHMR_NewTest]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[BHMR_NewTest]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_LuyKe_SLSP_BHMR_ASM_View_NewTest(params:parameters), keyPath: "SP_FRT_MSM_ListSP_LuyKe_SLSP_BHMR_ASM_View_NewTestResult", mappingObj: BHMR_NewTest.self) { (data, err) in
                let checkingResult = data as? [BHMR_NewTest];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_LuyKe_SLSP_BHMR_Shop_View_NewTest() -> Response<[BHMR_NewTest]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[BHMR_NewTest]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_LuyKe_SLSP_BHMR_Shop_View_NewTest(params:parameters), keyPath: "SP_FRT_MSM_ListSP_LuyKe_SLSP_BHMR_Shop_View_NewTestResult", mappingObj: BHMR_NewTest.self) { (data, err) in
                let checkingResult = data as? [BHMR_NewTest];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_LuyKe_SLSP_BHMR_Vung_View_NewTest() -> Response<[BHMR_NewTest]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[BHMR_NewTest]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_LuyKe_SLSP_BHMR_Vung_View_NewTest(params:parameters), keyPath: "SP_FRT_MSM_ListSP_LuyKe_SLSP_BHMR_Vung_View_NewTestResult", mappingObj: BHMR_NewTest.self) { (data, err) in
                let checkingResult = data as? [BHMR_NewTest];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_Realtime_SLSP_BHMR_Shop_View_NewTest() -> Response<[BHMR_NewTest]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[BHMR_NewTest]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_Realtime_SLSP_BHMR_Shop_View_NewTest(params:parameters), keyPath: "SP_FRT_MSM_ListSP_Realtime_SLSP_BHMR_Shop_View_NewTestResult", mappingObj: BHMR_NewTest.self) { (data, err) in
                let checkingResult = data as? [BHMR_NewTest];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_Realtime_SLSP_BHMR_ASM_View_NewTest() -> Response<[BHMR_NewTest]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[BHMR_NewTest]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_Realtime_SLSP_BHMR_ASM_View_NewTest(params:parameters), keyPath: "SP_FRT_MSM_ListSP_Realtime_SLSP_BHMR_ASM_View_NewTestResult", mappingObj: BHMR_NewTest.self) { (data, err) in
                let checkingResult = data as? [BHMR_NewTest];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListSP_Realtime_SLSP_BHMR_Vung_View_NewTest() -> Response<[BHMR_NewTest]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        
        let returnedData = Response<[BHMR_NewTest]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListSP_Realtime_SLSP_BHMR_Vung_View_NewTest(params:parameters), keyPath: "SP_FRT_MSM_ListSP_Realtime_SLSP_BHMR_Vung_View_NewTestResult", mappingObj: BHMR_NewTest.self) { (data, err) in
                let checkingResult = data as? [BHMR_NewTest];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func msm_KhaiThacMayKemPK() -> Response<[KTMayKemPK]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        let returnedData = Response<[KTMayKemPK]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .msm_KhaiThacMayKemPK(params:parameters), keyPath: "SP_FRT_MSM_usp_RP_PRO1_FR_FR127_MobileResult", mappingObj: KTMayKemPK.self) { (data, err) in
                let checkingResult = data as? [KTMayKemPK];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func ListDoanhSo_Realtime_Vung_NotDA_CungKy_View_Final() -> Response<[RealtimeVungCungKyFinal]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        let returnedData = Response<[RealtimeVungCungKyFinal]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .ListDoanhSo_Realtime_Vung_NotDA_CungKy_View_Final(params:parameters), keyPath: "SP_MSM_ListDoanhSo_Realtime_Vung_NotDA_CungKy_View_FinalResult", mappingObj: RealtimeVungCungKyFinal.self) { (data, err) in
                let checkingResult = data as? [RealtimeVungCungKyFinal];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    public static func msm_RealtimeShopKhaiThacMayKemPK() -> Response<[KTMayKemPK]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        let returnedData = Response<[KTMayKemPK]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .msm_RealtimeShopKhaiThacMayKemPK(params:parameters), keyPath: "SP_FRT_SP_MSM_ListDoanhSo_Realtime_Shop_KhaiThac_May_PhuKien_ViewResult", mappingObj: KTMayKemPK.self) { (data, err) in
                let checkingResult = data as? [KTMayKemPK];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        
        dispatchGroup.wait();
        return returnedData;
    }
    
    class func GetIpCheckingResult(userID:String,handler: @escaping (_ success:Int,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mSMApiService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "userCode":"\(userID)"
        ]
        print(parameters)
        provider.request(.GetIPCheckingResult(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                if(success){
                    if let data = json["Data"].array {
                        let rs = data[0]
                        let rsCode = rs["KQ"].intValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rsCode,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0, error.localizedDescription)
            }
        }
    }
    
    class func GetShopInfo(handler: @escaping (_ success:[ShopInfo],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mSMApiService>(plugins: [NetworkLoggerPlugin()])
        
        provider.request(.GetShopInfo){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                if(success){
                    if let data = json["Data"].array {
                        let rs = ShopInfo.parseObjfromArray(array: data)
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
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], error.localizedDescription)
            }
        }
    }
    
    public static func DoanhSo_TyLePhuKien_Realtime_Vung_View() -> Response<[TyLePhuKien_Realtime]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        let returnedData = Response<[TyLePhuKien_Realtime]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .DoanhSo_TyLePhuKien_Realtime_Vung_View(params:parameters), keyPath: "SP_MSM_DoanhSo_TyLePhuKien_Realtime_Vung_ViewResult", mappingObj: TyLePhuKien_Realtime.self) { (data, err) in
                let checkingResult = data as? [TyLePhuKien_Realtime];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        dispatchGroup.wait();
        return returnedData;
    }
    public static func DoanhSo_TyLePhuKien_Realtime_KhuVuc_View() -> Response<[TyLePhuKien_Realtime]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        let returnedData = Response<[TyLePhuKien_Realtime]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .DoanhSo_TyLePhuKien_Realtime_KhuVuc_View(params:parameters), keyPath: "SP_MSM_DoanhSo_TyLePhuKien_Realtime_KhuVuc_ViewResult", mappingObj: TyLePhuKien_Realtime.self) { (data, err) in
                let checkingResult = data as? [TyLePhuKien_Realtime];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        dispatchGroup.wait();
        return returnedData;
    }
    public static func DoanhSo_PhuKien_Iphone_Realtime_Vung_View() -> Response<[PK_IPhoneRealtime]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        let returnedData = Response<[PK_IPhoneRealtime]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .DoanhSo_PhuKien_Iphone_Realtime_Vung_View(params:parameters), keyPath: "SP_MSM_DoanhSo_PhuKien_Iphone_Realtime_Vung_ViewResult", mappingObj: PK_IPhoneRealtime.self) { (data, err) in
                let checkingResult = data as? [PK_IPhoneRealtime];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        dispatchGroup.wait();
        return returnedData;
    }
    public static func DoanhSo_PhuKien_Iphone_Realtime_KhuVuc_View() -> Response<[PK_IPhoneRealtime]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user!.UserName)",
            "p_Token":"\(Cache.user!.Token)"
        ]
        debugPrint(parameters)
        let returnedData = Response<[PK_IPhoneRealtime]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .DoanhSo_PhuKien_Iphone_Realtime_KhuVuc_View(params:parameters), keyPath: "SP_MSM_DoanhSo_PhuKien_Iphone_Realtime_KhuVuc_ViewResult", mappingObj: PK_IPhoneRealtime.self) { (data, err) in
                let checkingResult = data as? [PK_IPhoneRealtime];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        dispatchGroup.wait();
        return returnedData;
    }
    
    ///APPLE
    public static func DoanhSo_Iphone_ComboPK_Realtime_GetData_Model() -> Response<[AppleRealtimePK]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user?.UserName ?? "")",
            "p_Token":"\(Cache.user?.Token ?? "")"
        ]
        debugPrint(parameters)
        let returnedData = Response<[AppleRealtimePK]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .DoanhSo_Iphone_ComboPK_Realtime_GetData_Model(params:parameters), keyPath: "FRT_SP_MSM_DoanhSo_Iphone_ComboPK_Realtime_GetData_ModelResult", mappingObj: AppleRealtimePK.self) { (data, err) in
                let checkingResult = data as? [AppleRealtimePK];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func DoanhSo_Iphone_ComboPK_Realtime_GetData_Vung() -> Response<[AppleRealtimePK]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user?.UserName ?? "")",
            "p_Token":"\(Cache.user?.Token ?? "")"
        ]
        debugPrint(parameters)
        let returnedData = Response<[AppleRealtimePK]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .DoanhSo_Iphone_ComboPK_Realtime_GetData_Vung(params:parameters), keyPath: "FRT_SP_MSM_DoanhSo_Iphone_ComboPK_Realtime_GetData_VungResult", mappingObj: AppleRealtimePK.self) { (data, err) in
                let checkingResult = data as? [AppleRealtimePK];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func DoanhSo_Iphone_ComboPK_Realtime_GetData_ASM() -> Response<[AppleRealtimePK]>{
        let parameters: [String: String] = [
            "p_UserCode":"\(Cache.user?.UserName ?? "")",
            "p_Token":"\(Cache.user?.Token ?? "")"
        ]
        debugPrint(parameters)
        let returnedData = Response<[AppleRealtimePK]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);
        
        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse(target: .DoanhSo_Iphone_ComboPK_Realtime_GetData_ASM(params:parameters), keyPath: "FRT_SP_MSM_DoanhSo_Iphone_ComboPK_Realtime_GetData_ASMResult", mappingObj: AppleRealtimePK.self) { (data, err) in
                let checkingResult = data as? [AppleRealtimePK];
                returnedData.Data = checkingResult;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });
        dispatchGroup.wait();
        return returnedData;
    }
    class func trackUserActivity(group:String,screen:String,handler: @escaping (_ success:Int,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mSMApiService>(plugins: [NetworkLoggerPlugin()])

        var deviceUUID: String = ""
        if let udidDevice: UUID = UIDevice.current.identifierForVendor {
            deviceUUID = udidDevice.uuidString
        } else {
            deviceUUID = "XXX-XXX"
        }
        
        let parameters: [String: String] = [
            "uuid": deviceUUID,
            "osType": "iOS",
            "user": Cache.user!.UserName,
            "group": group,
            "screen": screen
         ]
        
        provider.request(.trackUserActivity(params: parameters)){ result in
                switch result {
                case let .success(moyaResponse):
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let data = moyaResponse.data
                    let json = try! JSON(data: data)
                    let success = json["Success"].boolValue
                    
                    if(success){
                        print(json)
                        print("Saved track user activity \(parameters)")
                    } else {
                        handler(0,"Load API ERRO")
                    }
                case let .failure(error):
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0, error.localizedDescription)
                }
        }
    }
}

