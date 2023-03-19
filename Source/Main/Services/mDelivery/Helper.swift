//
//  Helper.swift
//  Fpharmacy
//
//  Created by sumi on 6/6/17.
//  Copyright © 2017 sumi. All rights reserved.
// beta 1.1.6 real 1.1.9  HomeNewViewController

import UIKit

struct URLs
{
    
    static let MDELIVERY_SERVICE_ADDRESS_GATEWAY =  Config.manager.URL_GATEWAY + "/mpos-cloud-delivery"
    static let MDELIVERY_SERVICE_UPLOADIMAGE_Gateway = Config.manager.URL_GATEWAY + "/mpos-cloud-image"
    static let FPT_LOGIN_NEW = Config.manager.URL_GATEWAY + "/mpos-cloud-api/api/"
    
    //// Login new
    static let checkLogin = FPT_LOGIN_NEW + "Account/mpos_sp_inov_Authenticate"
    static let checkTOKEN_Gateway = FPT_LOGIN_NEW + "Order/sp_mpos_Check_Token"
    
    ///GET {p_User}
    static let getSOByUser_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/delivery/getSOByUserOneApp"
    
    ///GET {shopCode, jobtitle}
    static let getUserDelivery_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/delivery/getemployees"
    
    ///GET { docNum, userCode, password}
    static let getConfirmThuKho_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/delivery/setSOConfirmed_V2"
   // static let getConfirmThuKho = MDELIVERY_SERVICE_ADDRESS + "/api/delivery/setSOConfirmed"
    
    ///GET { docNum, userCode, password,cantCallReason}
    static let getUnConfirmThuKho_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/delivery/setSOUnconfirmed"
    
    
    
    
    ///POST { docNum, userCode, password}
    static let getmDel_UpAnh_GHTNResult_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/delivery/mDel_UpAnh_GHTN"
    
    //GET { docNum, userCode, password}
    static let getSetSOPaid_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/delivery/setSOPaid"
    
    //GET { docNum}
    static let getSODetails_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/delivery/getSODetails"
    
    //GET { docNum,userCode,reason}
    
    static let getSetSORejected_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/delivery/setSORejected"
    
    
    ///POST { docNum, userName, empName , bookDate, whConfirmed, whDate, rejectReason, rejectDate, paymentType, paymentAmount, paymentDistance , finishLatitude, finishLongitude , finishTime, paidConfirmed, paidDate, orderStatus, u_addDel, u_dateDe, u_paidMoney, rowVersion}
    static let getSetSOInfo_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/delivery/setSOInfo"
    
    
    //GET { docNum, userCode, empName}
    static let getSetSOBooked_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/delivery/setSOBooked"
    
    //GET { docNum, userCode, empName}
    static let getMposd_sp_ReportDeliveryHeader_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/delivery/mposd_sp_ReportDeliveryHeader"
    
    //GET { docNum, userCode, empName}
    static let getmDel_UpdateNotification_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/delivery/mDel_UpdateNotification"
    
    
    //GET { docNum, userCode, empName}
    static let getNotification_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/Notification/addDeviceToken"
    
    
    //GET { docNum,userCode,latitude,longitude,paymentType,paymentAmount,paymentDistance}
    static let getSetSODelivered_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/delivery/setSODelivered"
    
    //GET { docnum,reason,userCode,is_Returned =0 => o buoc dang giao = 1 => o buoc da giao}
    static let getSetSOReturned_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/delivery/setSOReturned"
    
    //GET { p_SoDonHangPOS}
    static let getReportDeliveryDetail_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/delivery/mposd_sp_ReportDeliveryDetail"
    
    
    //POST { SoSO,FileName,Base64String,UserID ,TypeTraGop,TypeImg}
    static let GetmDelUpAnhGHTG_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/delivery/mDel_UpAnh_GHTG"
    
    
    
    //POST { SoSO,UserID,ImgUrl_TTD,ImgUrl_CMNDMT ,ImgUrl_HDTC1,ImgUrl_HDTC2,ImgUrl_HDTC3,TypeTraGop}
    static let GetmDelSaveAnhGHTG_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/delivery/mDel_SaveAnh_GHTG"
    
    
    //POST { SoSO,FileName,Base64String,TypeImg}
    static let GetmDelUpAnhMC_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/Delivery/mDel_UpAnh_DHMC"
    
    
    //POST { SoSO,UserID,ImgUrl_Receiver,ImgUrl_Touch ,ImgUrl_Red,ImgUrl_MSM,ImgUrl_MTM,ImgUrl_Imei}
    static let GetmDelSaveAnhMC_Gateway = MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/Delivery/mDel_SaveAnh_HDMC"
    
    
    
    
    ////bao hanh
    ////set Giaonhan - get location by user
    static let GIAONHAN_GETLOCATIONBYUSER_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/mposd_sp_Warranty_GiaoNhan_AllNhanVienPhanCong_Mobile"
    
    
    ////get mDel_ReportNotification by user code
    static let GIAONHAN_REPORTNOTIFICATION_Gateway  = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/mDel_ReportNotification"
    
    ////set Giaonhan - get LoadChiTietPhieuNhan
    static let GIAONHAN_GETLOADCHITIETPHIEUNHAN_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/mposd_sp_Warranty_GiaoNhan_LoadChiTietPhieuNhan_Mobile"
    
    ////set Giaonhan - get LoadChiTietPhieuNhanHang
    static let GIAONHAN_GETLOADCHITIETPHIEUNHAN_HANG_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/mposd_sp_Warranty_GiaoNhan_LoadChiTietPhieu_Hang"
    
    ////set Giaonhan - get LoadChiTietPhieuGiao
    static let GIAONHAN_GETLOADCHITIETPHIEUGIAO_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/mposd_sp_Warranty_GiaoNhan_LoadChiTietPhieuGiao_Mobile"
    ////set GiaoNhan - get So Phieu Giao Nhan
    static let GIAONHAN_GETSOPHIEUGIAONHAN_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/mposd_sp_Warranty_GiaoNhan_LoadSLPhieuGiaoNhan_Mobile"
    ////set GiaoNhan - get Lich Su Giao Nhan
    static let GIAONHAN_GETLICHSUGIAONHAN_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/mposd_sp_Warranty_GiaoNhan_LichSuGiaoNhan"
    ////set GiaoNhan - get Danh Sach Lo Trinh
    static let GIAONHAN_GETDSLOTRINH_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/mposd_sp_Warranty_GiaoNhan_DanhSachLoTrinhGiaoNhan"
    
    
    ////set GiaoNhan - LoadChiTietPhieu
    static let GIAONHAN_LOADCHITIETPHIEU_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/mposd_sp_Warranty_GiaoNhan_LoadChiTietPhieu"
    
    ////set GiaoNhan - LoadChiTietPhieu
    static let GIAONHAN_GETLOADCHITIETPHIEUNHAN_HANG_LICHSU_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/mposd_sp_Warranty_GiaoNhan_LichSu_LoadChiTietPhieu_Hang"
    
    ////set GiaoNhan - LoadChiTietPhieuLichSu_KhongPhaiHang
    static let GIAONHAN_GETLOADCHITIETPHIEUNHAN_HANG_LICHSU_NOT_HANG_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/mposd_sp_Warranty_GiaoNhan_LichSu_LoadChiTietPhieu"
    
    ////set GiaoNhan - UPLOAD CHU KI
    static let GIAONHAN_UPLOAD_CHUKI_GATEWAY = "\(MDELIVERY_SERVICE_UPLOADIMAGE_Gateway)/api/Mdel/GenImage_Confirm_Deliver"
    
    
    
    //set GiaoNhan - UpHinh
    static let GIAONHAN_UPHINH_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/mposd_sp_Warranty_GiaoNhan_UpLoadImage"
    //set GiaoNhan - Checkin
    static let GIAONHAN_CHECKIN_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/mposd_sp_Warranty_GiaoNhan_LuuThongTinGiaoNhan"
    //set GiaoNhan - CheckUserShop
    static let GIAONHAN_CHECKUSERSHOP_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/mDel_CheckUserShop"
    
    
    
    ///set FFriends
    static let FFRIENDS_UPHINH_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/delivery/mDel_UpAnh_FFriend"
    static let FFRIENDS_SAVEHINH_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/delivery/mDel_Subsidy_UpImg"
    
    static let CHECK_VERSION_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/delivery/mDel_CheckLastVersionApp"
    
    
    
    
    ////// ****** Ky Thuat ****** ///////
    static let KYTHUAT_GETEMPLOY_BYSHOP_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/sp_mDel_TechnicalEmpShop_Get"
    
    static let KYTHUAT_CREATE_DH_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/sp_mDel_TechnicalEmpShopBook"
    
    static let KYTHUAT_UPDATE_ORDER_STS_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/sp_mDel_TechnicalEmpShop_Approved"
    
    
    static let KYTHUAT_REQUEST_SMCHECK_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/sp_mDel_mSM_PushNotification"
    
    
    ////// ****** LCNB ****** ///////
    static let LCNB_GETDS_PHIEU_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/sp_mDel_LCNB_LoadDSPhieu"
    static let LCNB_XACNHAN_GIAONHAN_Gateway = "\(MDELIVERY_SERVICE_ADDRESS_GATEWAY)/api/Delivery/sp_mDel_LCNB_XacNhanGiaoNhan"
    
    
}

struct JOBTITLE
{
    static let JOB_TITLE_TRUONG_CA = "00671";
    static let JOB_TITLE_SM = "00004";
    static let JOB_TITLE_SMA = "00005";
    static let JOB_TITLE_SMD = "00407";
    static let JOB_TITLE_DSM = "00005";
    static let JOB_TITLE_QUANLYTHUCTAP = "00006";
    static let JOB_TITLE_TRUONG_QUANLY_CUAHANG_APR = "00447";
    static let JOB_TITLE_PHO_QUANLY_CUAHANG_APR = "00448";
    static let JOB_TITLE_SALE = "00013";
    static let JOB_TITLE_SALE_BK = "00293";
    static let JOB_TITLE_BANHANG_APR = "00446";
    static let JOB_TITLE_THUKHO = "00007";
    static let JOB_TITLE_THUKHO_CHINH_APR = "00449";
    static let JOB_TITLE_THUKHOQUAY = "00008";
    static let JOB_TITLE_KETOANCH = "00010";
    static let JOB_TITLE_KETOANCH_LOAID = "00408";
    static let JOB_TITLE_HOTROKT_LV2 = "00101";
    static let JOB_TITLE_HOTROKT_LOAID = "00409";
    static let JOB_TITLE_HOTROKT_LV1 = "00098";
    static let JOB_TITLE_HOTROKT_APR = "00445";
    static let JOB_TITLE_TIEPDONKH = "00458";
    static let JOB_TITLE_CHUYENDOANHPHUKIEN = "00088";
    static let JOB_TITLE_NHANVIENGIAONHAN = "00250";
    
    
    static let JOB_TITLE_BAOHANH_ADMIN = "00439"
    static let JOB_TITLE_BAOHANH_DIEUPHOI = "00355"
    static let JOB_TITLE_BAOHANH_TRABH = "00461"
    static let JOB_TITLE_BAOHANH_TESTBH = "00274"
    static let JOB_TITLE_BAOHANH_GIAONHAN = "00250"
    static let JOB_TITLE_BAOHANH_GIAONHAN2 = "00154"
    static let JOB_TITLE_BAOHANH_NHAN_BH = "00353"
    static let JOB_TITLE_BAOHANH_THUKHO = "00500"
    static let JOB_TITLE_BAOHANH_TRUONGNHOM_BH = "00352"
    static let JOB_TITLE_BAOHANH_TRUONGPHONG_BH = "00351"
    
    
    
    
    //Vinamilk
    static let JOB_TITLE_CHUYENDOANHVINAMILK = "00562"; //kiem ke toan, thu kho, giao hang
    static let JOB_TITLE_NHANVIENGIAONHANHANGVINAMILK = "00571"; //nhan vien giao hang vinamilk
}






class Helper: NSObject {
    class func FormatMoney(cost: Int) -> String?
    {
        let costt = NumberFormatter.localizedString(from: NSNumber(value: cost), number: NumberFormatter.Style.decimal)
        
        return costt
        
    }
    
    
    static  let resizeImageWith: CGFloat = 800
    static  let resizeImageValue: CGFloat = 0.2
    static  let resizeImageValueFF: CGFloat = 0.5
    
    class func versionApp() ->String{
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return "\(version)"
        }else{
            return "Version Error"
        }
    }
    
    ///save object like preference java
    class func saveUserName(token: String,password:String)
    {
        let def = UserDefaults.standard ;
        def.setValue(token, forKey: "UserName")
        def.setValue(password, forKey: "Password")
        def.synchronize() ;
        
    }
    
    class func saveEmployeeName(token: String)
    {
        let def = UserDefaults.standard ;
        def.setValue(token, forKey: "EmployeeName") ;
        def.synchronize() ;
        
    }
    
    
    
    
    
    
    
    
    class func saveJobTitle(token: String)
    {
        let def = UserDefaults.standard ;
        def.setValue(token, forKey: "JobTitle") ;
        def.synchronize() ;
        
    }
    
    class func getJobTitle() -> String?
    {
        let def = UserDefaults.standard
        return def.object(forKey: "JobTitle") as? String
        
    }
    
    
    
    
    class func getEmployeeName() -> String?
    {
        let def = UserDefaults.standard
        return def.object(forKey: "EmployeeName") as? String
        
    }
    
    class func saveShopCode(token: String)
    {
        let def = UserDefaults.standard ;
        def.setValue(token, forKey: "ShopCode") ;
        def.synchronize() ;
        
    }
    
    class func saveShopName(token: String)
    {
        let def = UserDefaults.standard ;
        def.setValue(token, forKey: "ShopName") ;
        def.synchronize() ;
        
    }
    
    class func saveNumNoti(token: Int)
    {
        let def = UserDefaults.standard ;
        def.setValue(token, forKey: "NumNoti") ;
        def.synchronize() ;
        
    }
    
    
    class func getShopCode() -> String?
    {
        return Cache.user!.ShopCode
        
    }
    
    class func getShopName() -> String?
    {
        return Cache.user!.ShopName
        
    }
    
    class func getNumNoti() -> Int?
    {
        let def = UserDefaults.standard
        return def.object(forKey: "NumNoti") as? Int
        
    }
    
    
    
    
    class func getUserName() -> String?
    {
        return Cache.user!.UserName
        
    }
    
    class func saveNavigationBarHeight(height: CGFloat)
    {
        let def = UserDefaults.standard ;
        def.setValue(height, forKey: "NavHeight") ;
        def.synchronize() ;
        
    }
    
    
    class func getNavigationBarHeight() -> CGFloat?
    {
        let def = UserDefaults.standard
        return def.object(forKey: "NavHeight") as? CGFloat
        
    }
    
}

extension TimeInterval {
    var minuteSecondMS: String {
        return String(format:"%dh%02d'",hours, minute)
    }
    
    var hours: Int {
        return Int(NSInteger(self)/3600)
    }
    var minute: Int {
        return Int(NSInteger(self)/60 % 60)
    }
    var second: Int {
        return Int(NSInteger(self) % 60)
    }
    var millisecond: Int {
        return Int(NSInteger(self)*1000 % 1000 )
    }
    func timeIntervalAsString(seconds : TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.year,.month,.weekday,.day,.hour,.minute,.second]
        formatter.unitsStyle = .full
        formatter.calendar?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
        let formattedString = formatter.string(from: TimeInterval(seconds))!
        return formattedString
    }
}
