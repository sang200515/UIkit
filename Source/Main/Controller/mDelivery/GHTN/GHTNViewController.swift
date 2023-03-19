//
//  GHTNViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/26/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
//import EPSignature
import GoogleMaps
import CoreLocation
import PopupDialog
import Toaster
//import EPSignature
import SwiftyBeaver
class GHTNViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate  , UIGestureRecognizerDelegate,CLLocationManagerDelegate ,GMSMapViewDelegate,InputTextViewCantCallDelegate,InputTextViewChangeTimeDelegate,InputTextViewTraHangDelegate  ,UITextViewDelegate,UITextFieldDelegate,EPSignatureDelegate{
    
    func didClose(sender: InputTextViewCantCallDelegate, mInside: String, mPass: String, mString: String) {
        print("close didClose")
        let cryptoPass = PasswordEncrypter.encrypt(password: mPass)
        let formattedString = mString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        self.GetDataUnConfirmThuKho(docNum: "\((mObjectData?.ID)!)", userCode: "\(mInside)", password: "\(cryptoPass)",cantCallReason: "\(formattedString!)")
        
        self.viewInputCantCall.endEditing(true)
        self.viewInputCantCall.isHidden = true
    }
    
    
    
    
    func didClose(sender: InputTextViewTraHangDelegate, mString: String) {
        print("close InputTextViewTraHangDelegate")
        let formattedString = mString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        GetResultSetSOReturned(docNum: "\((mObjectData?.ID)!)", userCode:"\(Cache.user!.UserName)", reason:"\(formattedString!)",is_Returned:"0")
        self.viewInputTraHang.isHidden = true
        self.viewInputTraHang.edtNameProduct.text = ""
        self.viewInputTraHang.endEditing(true)
    }
    
    func didCancel(sender: InputTextViewTraHangDelegate) {
        print("cancel InputTextViewTraHangDelegate")
        self.viewInputTraHang.isHidden = true
        self.viewInputTraHang.edtNameProduct.text = ""
        self.viewInputTraHang.endEditing(true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getDataSOByUser(p_UserID: "\(Cache.user!.UserName)")
    }
    func didClose(sender: InputTextViewChangeTimeDelegate, mTime: String, mReasonChangeTime: String) {
        if(self.typePush == nil || self.typePush == 0)
        {
            
        }
        else
        {
            
            let formattedString2 = Cache.user!.EmployeeName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let formattedString3 = mTime.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let formattedString = (mObjectData?.U_AdrDel)!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let formattedString4 = mReasonChangeTime.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            
            self.getDataSetSO_Info(docNum :"\((mObjectData?.ID)!)", userName :"\(Cache.user!.UserName)", empName : "\((formattedString2)!)" , bookDate :"\((mObjectData?.BookDate)!)", whConfirmed :"\((mObjectData?.WHConfirmed)!)", whDate :"\((mObjectData?.WHDate)!)", rejectReason :"\((mObjectData?.RejectReason)!)", rejectDate :"\((mObjectData?.RejectDate)!)", paymentType :"\((mObjectData?.PaymentType)!)", paymentAmount :"\((mObjectData?.U_PaidMoney)!)", paymentDistance :"" , finishLatitude :"\((mObjectData?.FinishLatitude)!)", finishLongitude :"\((mObjectData?.FinishLongitude)!)", finishTime :"\((mObjectData?.FinishTime)!)", paidConfirmed :"\((mObjectData?.PaidConfirmed)!)", paidDate :"\((mObjectData?.PaidDate)!)", orderStatus :"\((mObjectData?.OrderStatus)!)", u_addDel :"\((formattedString)!)", u_dateDe :"\(formattedString3!)", u_paidMoney :"\((mObjectData?.U_PaidMoney)!)", rowVersion :"\((mObjectData?.RowVersion)!)", Is_PushSMS: "0",U_AdrDel_New_Reason:"", U_DateDe_New_Reason:"\(formattedString4!)")
            
            self.viewInputChangeTime.isHidden = true
        }
        
        self.viewInputChangeTime.endEditing(true)
    }
    
    
    func didCancel(sender: InputTextViewChangeTimeDelegate) {
        print("cancel didCancel")
        self.viewInputChangeTime.isHidden = true
        self.viewInputChangeTime.edtNameProduct.text = ""
        self.viewInputChangeTime.endEditing(true)
    }
    
    
    
    func didCancel(sender: InputTextViewCantCallDelegate) {
        print("cancel didCancel")
        print("cancel")
        self.viewInputCantCall.isHidden = true
        self.viewInputCantCall.edtNameProduct.text = ""
        self.viewInputCantCall.endEditing(true)
    }
    
    
    
    var strBase64Signed:String = ""
    var mKyThuatChuKyView:KyThuatChuKyView!
    var canChange:Bool = true
    var mListThongke = [ReportDeliveryHeaderOrderListResult]()
    
    var mTimeLest:String?
    var viewInputTraHang:InputTextViewTraHang!
    var viewInputCantCall:InputTextViewCantCall!
    var viewInputChangeTime:InputTextViewChangeTime!
    
    var mObjectData:GetSOByUserResult?
    
    var mPic1:Bool = false
    var mPic2:Bool = false
    var mPic21:Bool = false
    var mPic3:Bool = false
    
    var mSONum:String?
    var mAddedImage:Int = 0
    var typePush:Int?
    
    var userLat:Double = 0
    var userLong:Double = 0
    var lineViewThongTin:UIView!
//    var lineViewPhuKien:UIView!
    var lineViewMoTaLoi:UIView!
    var lineViewThongKe:UIView!
    
    var viewContent:UIView!
    var viewThongTin:UIView!
    
    var viewThongKe:UIView!
//    var viewPhuKien:UIView!
    var viewMoTaLoi:UIView!
    var lbThongTin:UILabel!
//    var lbPhuKien:UILabel!
    var lbMoTaLoi:UILabel!
    var lbThongKe:UILabel!
    var scrollView:UIScrollView!
    
    var viewProcess:ProcessView!
    var viewTabDaNhan:ViewTabDaNhan!
    var viewTabDangGiao:ViewTabDangGiao!
    var viewTabDaGiao:ViewTabDaGiao!
    var viewTabThongKe:ViewTabThongKe!
    var mListGetSOByUserResult = [GetSOByUserResult]()
    var locManager = CLLocationManager()
    
    var mLat:String?
    var mLong:String?
    var mAddress:String?
    var mCostPhaiThu:String?
    var orderDetail: InstallmentOrderData?
    var mListGetSOByUserDisplay = [GetSOByUserResult]()
    var mListDaGiaoGetSOByUserDisplay = [GetSOByUserResult]()
    
    var arrGetEmPloyeesResult = [GetEmPloyeesResult]()
    let log = SwiftyBeaver.self
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        self.title = "GH Tại nhà"
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(GHTNViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        viewProcess = ProcessView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        
        //        let navigationHeight:CGFloat = (self.navigationController?.navigationBar.frame.size.height)!
        mKyThuatChuKyView = KyThuatChuKyView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        let gestureViewChuKy = UITapGestureRecognizer(target: self, action: #selector(GHTNViewController.OnClickViewChuKy(gestureRecognizer:)))
        gestureViewChuKy.delegate = self
        
        mKyThuatChuKyView.mViewImage.addGestureRecognizer(gestureViewChuKy)

        // mKyThuatChuKyView.myButtonDone.addTarget(self, action: #selector(self.UploadChuKiKhachHang), for: .touchUpInside)

        mKyThuatChuKyView.myButtonDone.addTarget(self, action: #selector(self.actionInputOTP), for: .touchUpInside)
        
        AddTabDaNhanView()
        AddTabDangGiao()
        AddTabDaGiaoView()
        AddTabThongKe()
        
        
        self.view.addSubview(mKyThuatChuKyView)
        AddDialog()
        mKyThuatChuKyView.isHidden = true
        
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        
        
        
        userLat = locManager.location?.coordinate.latitude ?? 0
        userLong = locManager.location?.coordinate.longitude ?? 0
        log.info("Current location: \(userLat), \(userLong)")
        GetUserLocationToMap()
        
        
        if(self.typePush == nil || self.typePush == 0)
        {
            
        }
        else
        {
            if(self.typePush == 1)
            {
                self.thisIsTheFunctionWeAreCalling()
                self.mPic1 = true
                lineViewMoTaLoi.isHidden = true
                lineViewThongTin.isHidden = true
                self.viewTabDaNhan.isHidden = true
                
                
                self.viewTabDangGiao.isHidden = true
//                lineViewPhuKien.isHidden = false
                self.viewTabDangGiao.lbName.text = "\((mObjectData?.U_CrdName) ?? "")-ĐH:\((mObjectData?.DocEntry) ?? "")"
                self.viewTabDangGiao.lbValuePhaiThu.text = self.mCostPhaiThu!
                self.viewTabDangGiao.lbValueGhiChu.text = "\((mObjectData?.U_Desc) ?? "")"
                let fullString = mObjectData!.U_DateDe.components(separatedBy: "T")
                let firstString: String = fullString[0]
                
                let fullStringTime: String = fullString[1]
                let mTime = fullStringTime.components(separatedBy: ":")
                
                self.viewTabDangGiao.lbTime.text = "\(firstString) \(mTime[0]):\(mTime[1]) "
                
                if(mAddress != "")
                {
                    
                    let formattedString = mAddress!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                    DrawPoliRouteByAddress(mAddress: "\(formattedString!)",SO: "\(mObjectData!.DocEntry)")
                }
                else
                {
                    if(mLat != "0" && mLong != "0")
                    {
                        print("havelatlong \(mLat!)-\(mLong!)")
                        DrawPoliRoute(mPointBLat: Double(mLat!)!, mPointBLong: Double(mLong!)!,SO:"\(mObjectData!.DocEntry)")
                    }
                    else
                    {
                        //self.viewTabDangGiao.mapView.clear();
                    }
                }
            }
            else if (typePush == 2)
            {
                lineViewMoTaLoi.isHidden = false
                lineViewThongTin.isHidden = true
//                lineViewPhuKien.isHidden = true
                self.viewTabDaNhan.isHidden = true
                self.viewTabDangGiao.isHidden = true
                self.viewTabDaGiao.isHidden = false
                self.navigationItem.hidesBackButton = false
            }
            
            
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var params = [String: Any]()
        params["shopCode"] = Cache.user?.ShopCode
        params["filterKey"] = "4"
        params["filterValue"] = mObjectData?.DocEntry
        params["isDetail"] = true
        InstallmentApiManager.shared.getInstallmentHistory(params: params) {[weak self] (_, detailHistory, error) in
            self?.orderDetail = detailHistory?.data.first
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var isLoading:Bool = false
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < -100 {
            if (isLoading == false){
                isLoading = true
                print("yes")
                
                self.getDataSOByUser(p_UserID: "\(Cache.user!.UserName)")
            }
            
        }
    }
    
    @objc func tapCallClick(sender:UITapGestureRecognizer) {
        
        if let phoneCallURL = URL(string: "tel://\((mObjectData?.U_Phone)!)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
    
    
    @objc func XemLaiDonHangClick()
    {
        let newViewController = ChiTietDonHangViewController()
        newViewController.mObjectData = self.mObjectData
        newViewController.mTypePush = "0"
        newViewController.mTimeLest = self.mTimeLest
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    func initView()
    {
        self.view.backgroundColor = .white
        
        //viewThongTin = UIView(frame: CGRect(x:0,y: 0,width:UIScreen.main.bounds.size.width / 4, height: 50 ))
        viewThongTin = UIView(frame: CGRect(x:0,y: 0,width:UIScreen.main.bounds.size.width / 2, height: 50 ))
        viewThongTin.backgroundColor = UIColor(netHex:0xe8e8e8)
        
        
        
        let strTitle = "Chờ giao "
        let sizeStrTitle: CGSize = strTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Common.Size(s:13))])
        lbThongTin = UILabel(frame: CGRect(x: 0, y: (viewThongTin.frame.size.height - sizeStrTitle.height) / 2 , width: viewThongTin.frame.size.width , height: Common.Size(s:13)))
        lbThongTin.textAlignment = .center
        lbThongTin.textColor = UIColor.black
        lbThongTin.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbThongTin.text = strTitle
        
        //        lineViewThongTin = UIView(frame: CGRect(x:0,y: viewThongTin.frame.size.height + viewThongTin.frame.origin.y - Common.Size(s: 3) ,width:UIScreen.main.bounds.size.width / 4, height: Common.Size(s: 3) ))
        lineViewThongTin = UIView(frame: CGRect(x:0,y: viewThongTin.frame.size.height + viewThongTin.frame.origin.y - Common.Size(s: 3) ,width:UIScreen.main.bounds.size.width / 2, height: Common.Size(s: 3) ))
        lineViewThongTin.backgroundColor = UIColor(netHex:0x0585b6)
        
        viewThongTin.addSubview(lbThongTin)
        
        
        //        viewPhuKien = UIView(frame: CGRect(x:viewThongTin.frame.origin.x + viewThongTin.frame.size.width,y: viewThongTin.frame.origin.y ,width:UIScreen.main.bounds.size.width / 4, height: 50 ))
//        viewPhuKien = UIView(frame: CGRect(x:viewThongTin.frame.origin.x + viewThongTin.frame.size.width,y: viewThongTin.frame.origin.y ,width:UIScreen.main.bounds.size.width / 3, height: 50 ))
//        viewPhuKien.backgroundColor = UIColor(netHex:0xe8e8e8)
        
        //        lineViewPhuKien = UIView(frame: CGRect(x:viewPhuKien.frame.origin.x,y: viewPhuKien.frame.size.height + viewPhuKien.frame.origin.y - Common.Size(s: 3) ,width:UIScreen.main.bounds.size.width / 4, height: Common.Size(s: 3) ))
//        lineViewPhuKien = UIView(frame: CGRect(x:viewPhuKien.frame.origin.x,y: viewPhuKien.frame.size.height + viewPhuKien.frame.origin.y - Common.Size(s: 3) ,width:UIScreen.main.bounds.size.width / 3, height: Common.Size(s: 3) ))
//        lineViewPhuKien.backgroundColor = UIColor(netHex:0x0585b6)
        
        
        
//        lbPhuKien = UILabel(frame: CGRect(x: 0, y: (viewThongTin.frame.size.height - sizeStrTitle.height) / 2 , width: viewThongTin.frame.size.width , height: Common.Size(s:13)))
//        lbPhuKien.textAlignment = .center
//        lbPhuKien.textColor = UIColor.black
//        lbPhuKien.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
//        lbPhuKien.text = "Đang giao"
//
//        viewPhuKien.addSubview(lbPhuKien)
        
        
        //        viewMoTaLoi = UIView(frame: CGRect(x:viewPhuKien.frame.origin.x + viewPhuKien.frame.size.width,y: viewThongTin.frame.origin.y ,width:UIScreen.main.bounds.size.width / 4, height: 50 ))
        viewMoTaLoi = UIView(frame: CGRect(x:viewThongTin.frame.origin.x + viewThongTin.frame.size.width,y: viewThongTin.frame.origin.y ,width:UIScreen.main.bounds.size.width / 2, height: 50 ))
        viewMoTaLoi.backgroundColor = UIColor(netHex:0xe8e8e8)
        
        //        lineViewMoTaLoi = UIView(frame: CGRect(x:viewMoTaLoi.frame.origin.x,y: viewMoTaLoi.frame.size.height + viewMoTaLoi.frame.origin.y - Common.Size(s: 3) ,width:UIScreen.main.bounds.size.width / 4, height: Common.Size(s: 3) ))
        lineViewMoTaLoi = UIView(frame: CGRect(x:viewMoTaLoi.frame.origin.x,y: viewMoTaLoi.frame.size.height + viewMoTaLoi.frame.origin.y - Common.Size(s: 3) ,width:UIScreen.main.bounds.size.width / 2, height: Common.Size(s: 3) ))
        lineViewMoTaLoi.backgroundColor = UIColor(netHex:0x0585b6)
        
        lbMoTaLoi = UILabel(frame: CGRect(x: 0, y: (viewThongTin.frame.size.height - sizeStrTitle.height) / 2 , width: viewThongTin.frame.size.width , height: Common.Size(s:13)))
        lbMoTaLoi.textAlignment = .center
        lbMoTaLoi.textColor = UIColor.black
        lbMoTaLoi.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbMoTaLoi.text = "Đã giao"
        
        viewMoTaLoi.addSubview(lbMoTaLoi)
        
        
        //        viewThongKe = UIView(frame: CGRect(x:viewMoTaLoi.frame.origin.x + viewMoTaLoi.frame.size.width,y: viewThongTin.frame.origin.y ,width:UIScreen.main.bounds.size.width / 4, height: 50 ))
        viewThongKe = UIView(frame: CGRect(x:viewMoTaLoi.frame.origin.x + viewMoTaLoi.frame.size.width,y: viewThongTin.frame.origin.y ,width:0, height: 50 ))
        viewThongKe.backgroundColor = UIColor(netHex:0xe8e8e8)
        
        //        lineViewThongKe = UIView(frame: CGRect(x:viewThongKe.frame.origin.x,y: viewThongKe.frame.size.height + viewThongKe.frame.origin.y - Common.Size(s: 3) ,width:UIScreen.main.bounds.size.width / 4, height: Common.Size(s: 3) ))
        lineViewThongKe = UIView(frame: CGRect(x:viewThongKe.frame.origin.x,y: viewThongKe.frame.size.height + viewThongKe.frame.origin.y - Common.Size(s: 3) ,width:0, height: Common.Size(s: 3) ))
        lineViewThongKe.backgroundColor = UIColor(netHex:0x0585b6)
        
        //        lbThongKe = UILabel(frame: CGRect(x: 0, y: (viewThongTin.frame.size.height - sizeStrTitle.height) / 2 , width: viewThongTin.frame.size.width , height: Common.Size(s:13)))
        lbThongKe = UILabel(frame: CGRect(x: 0, y: (viewThongTin.frame.size.height - sizeStrTitle.height) / 2 , width: 0 , height: Common.Size(s:13)))
        lbThongKe.textAlignment = .center
        lbThongKe.textColor = UIColor.black
        lbThongKe.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbThongKe.text = "Thống kê"
        
        viewThongKe.addSubview(lbThongKe)
        
        
        
        
        self.view.addSubview(viewThongKe)
        self.view.addSubview(viewThongTin)
//        self.view.addSubview(viewPhuKien)
        self.view.addSubview(viewMoTaLoi)
        
        self.view.addSubview(lineViewMoTaLoi)
        self.view.addSubview(lineViewThongTin)
//        self.view.addSubview(lineViewPhuKien)
        self.view.addSubview(lineViewThongKe)
        
        
        lineViewMoTaLoi.isHidden = true
        lineViewThongTin.isHidden = false
//        lineViewPhuKien.isHidden = true
        lineViewThongKe.isHidden = true
        /////
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GHTNViewController.OnClickViewDaNhan(gestureRecognizer:)))
        gestureRecognizer.delegate = self
        viewThongTin.addGestureRecognizer(gestureRecognizer)
        
//        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(GHTNViewController.OnClickViewDangGiao(gestureRecognizer:)))
//        gestureRecognizer2.delegate = self
//        viewPhuKien.addGestureRecognizer(gestureRecognizer2)
        
        
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(GHTNViewController.OnClickViewDaGiao(gestureRecognizer:)))
        gestureRecognizer3.delegate = self
        viewMoTaLoi.addGestureRecognizer(gestureRecognizer3)
        
        
        
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(GHTNViewController.OnClickViewThongKe(gestureRecognizer:)))
        gestureRecognizer4.delegate = self
        viewThongKe.addGestureRecognizer(gestureRecognizer4)
        
        
        
    }
    
    
    
    
    
    
    /***************************************************** func tab 2 *************************************************/
    
    func getDataSetSO_Info(docNum :String, userName :String, empName :String , bookDate :String, whConfirmed :String, whDate :String, rejectReason :String, rejectDate :String, paymentType :String, paymentAmount :String, paymentDistance :String , finishLatitude :String, finishLongitude :String, finishTime :String, paidConfirmed :String, paidDate :String, orderStatus :String, u_addDel :String, u_dateDe :String, u_paidMoney :String, rowVersion :String,Is_PushSMS:String,U_AdrDel_New_Reason:String, U_DateDe_New_Reason:String)
    {
        self.showProcessView(mShow: true)
        MDeliveryAPIService.GetDataSetSOInfo(docNum :docNum, userName :userName, empName :empName , bookDate :bookDate, whConfirmed :whConfirmed, whDate :whDate, rejectReason :rejectReason, rejectDate :rejectDate, paymentType :paymentType, paymentAmount :paymentAmount, paymentDistance :paymentDistance , finishLatitude :finishLatitude, finishLongitude :finishLongitude, finishTime :finishTime, paidConfirmed :paidConfirmed, paidDate :paidDate, orderStatus :orderStatus, u_addDel :u_addDel, u_dateDe :u_dateDe, u_paidMoney :u_paidMoney, rowVersion :rowVersion,Is_PushSMS:Is_PushSMS,U_AdrDel_New_Reason:U_AdrDel_New_Reason, U_DateDe_New_Reason:U_DateDe_New_Reason){ (error: Error?, success: Bool, result: ConfirmThuKhoResult!) in
            if success
            {
                if(result != nil )
                {
                    self.showProcessView(mShow: false)
                    Toast(text: "\(result.Descriptionn)").show()
                    
                    
                    self.lineViewMoTaLoi.isHidden = true
                    self.lineViewThongTin.isHidden = false
//                    self.lineViewPhuKien.isHidden = true
                    self.lineViewThongKe.isHidden = true
                    
                    self.viewTabDaGiao.isHidden = true
                    self.viewTabDaNhan.isHidden = false
                    self.viewTabDangGiao.isHidden = true
                    self.viewTabThongKe.isHidden = true
                    
                    self.getDataSOByUser(p_UserID: "\(Cache.user!.UserName)")
                }
                
            }
            else
            {
                
            }
        }
    }
    
    
    func GetDataUnConfirmThuKho(docNum: String, userCode:String, password:String,cantCallReason:String)
    {
        self.showProcessView(mShow: true)
        MDeliveryAPIService.GetUnConfirmThuKho(docNum: docNum, userCode:userCode , password:password,cantCallReason:cantCallReason){ (error: Error?, success: Bool, result: ConfirmThuKhoResult!) in
            if success
            {
                if(result != nil)
                {
                    self.showProcessView(mShow: false)
                    Toast(text: "\(result.Descriptionn)").show()
                    
                    self.lineViewMoTaLoi.isHidden = true
                    self.lineViewThongTin.isHidden = false
//                    self.lineViewPhuKien.isHidden = true
                    self.lineViewThongKe.isHidden = true
                    
                    self.viewTabDaGiao.isHidden = true
                    self.viewTabDaNhan.isHidden = false
                    self.viewTabDangGiao.isHidden = true
                    self.viewTabThongKe.isHidden = true
                    self.getDataSOByUser(p_UserID: "\(Cache.user!.UserName)")
                    self.typePush = 0
                }
                
            }
            else
            {
                
            }
        }
        
    }
    
    
    func GetResultSetSOReturned(docNum: String, userCode:String, reason:String,is_Returned:String)
    {
        self.showProcessView(mShow: true)
        MDeliveryAPIService.GetDataSetSOReturned(docNum: docNum, userCode:userCode, reason:reason, is_Returned:is_Returned){ (error: Error?, success: Bool, result: ConfirmThuKhoResult!) in
            if success
            {
                if(result != nil )
                {
                    self.showProcessView(mShow: false)
                    Toast(text: "\(result.Descriptionn)").show()
                    if(result.Result == "1")
                    {
                        print("clickccc OnClickViewDaNhan")
                        self.lineViewMoTaLoi.isHidden = false
                        self.lineViewThongTin.isHidden = true
//                        self.lineViewPhuKien.isHidden = true
                        self.lineViewThongKe.isHidden = true
                        
                        self.viewTabDaGiao.isHidden = false
                        self.viewTabDaNhan.isHidden = true
                        self.viewTabDangGiao.isHidden = true
                        self.viewTabThongKe.isHidden = true
                        
                        self.getDataSOByUser(p_UserID: "\(Cache.user!.UserName)")
                        self.navigationItem.hidesBackButton = false
                        self.typePush = 0
                    }
                }
                
                
                
            }
            else
            {
                
            }
        }
    }
    
    
    func GetUserLocationToMap()
    {
        
//        let markerA = GMSMarker()
//        markerA.position = CLLocationCoordinate2D(latitude: userLat, longitude: userLong)
//        markerA.map =  viewTabDangGiao.mapView
//
//        let mCamera = GMSCameraPosition.camera(withLatitude: userLat, longitude: userLong, zoom: 13.0)
//        viewTabDangGiao.mapView.camera = mCamera
//        let marker = GMSMarker()
//        marker.map =  viewTabDangGiao.mapView
    }
    
    func DrawPoliRouteByAddress(mAddress:String,SO:String)
    {
        CallGoogleApiToGetRouteByAddress(mLatUser:"\(userLat)",mLongUser:"\(userLong)",mAddress:"\(mAddress)",SO:SO)
        
        
    }
    
    
    func DrawPoliRoute(mPointBLat:Double,mPointBLong:Double,SO:String)
    {
        CallGoogleApiToGetRoute(mLatUser:"\(userLat)",mLongUser:"\(userLong)",mLat:"\(mPointBLat)",mLong:"\(mPointBLong)",SO:SO)
        //let mCamera = GMSCameraPosition.camera(withLatitude: userLat, longitude: userLong, zoom: 13.0)
        //viewTabDangGiao.mapView.camera = mCamera
        
        let markerA = GMSMarker()
        markerA.position = CLLocationCoordinate2D(latitude: userLat, longitude: userLong)
       // markerA.map =  viewTabDangGiao.mapView
        
        let markerB = GMSMarker()
        markerB.position = CLLocationCoordinate2D(latitude: mPointBLat, longitude: mPointBLong)
       // markerB.map =  viewTabDangGiao.mapView
        
    }
    
    
    func CallGoogleApiToGetRoute(mLatUser:String,mLongUser:String,mLat:String,mLong:String,SO:String)
    {
        
//        MDeliveryAPIService.GetDataGoogleAPIRoute(mLatUser: mLatUser, mLongUser: mLongUser, mLat: mLat,mLong: mLong,SO:SO){ (error: Error? , success: Bool,result: String!,resultDistance: String!,resultDuration: String!) in
//            if success
//            {
//                if(result != nil && result != "" && result != "null" )
//                {
//
//                    //self.ShowDialog(mMess: "\(result)")
//                    DispatchQueue.main.async {
//                        let path = GMSPath(fromEncodedPath: result)
//                        let polyline = GMSPolyline(path: path)
//                        polyline.strokeWidth = 3.0
//                        polyline.strokeColor = UIColor.red
//                        //polyline.map = self.viewTabDangGiao.mapView
//                        print("google map ok")
//
//
//                    }
//
//                }
//                else
//                {
//
//                }
//
//            }
//            else
//            {
//
//
//            }
//
//
//
//        }
        
    }
    
    
    
    func CallGoogleApiToGetRouteByAddress(mLatUser:String,mLongUser:String,mAddress:String,SO:String)
    {
        
        MDeliveryAPIService.GetDataGoogleAPIByAddress(mLatUser: mLatUser, mLongUser: mLongUser, mAddress: mAddress,SO:SO){ (error: Error? , success: Bool,result: String!,resultLat: String!,resultLong: String!,resultDistance: String!,resultDuration: String!) in
            if success
            {
                if(result != nil && result != "" && result != "null" )
                {
                    
                    //self.ShowDialog(mMess: "\(result)")
                    DispatchQueue.main.async {
                        let path = GMSPath(fromEncodedPath: result)
                        let polyline = GMSPolyline(path: path)
                        polyline.strokeWidth = 3.0
                        polyline.strokeColor = UIColor.red
                        polyline.map = self.viewTabDangGiao.mapView
                        print("google map ok")
                        
                        //let mCamera = GMSCameraPosition.camera(withLatitude: self.userLat, longitude: self.userLong, zoom: 13.0)
                        //self.viewTabDangGiao.mapView.camera = mCamera
                        
                        let markerA = GMSMarker()
                        markerA.position = CLLocationCoordinate2D(latitude: self.userLat, longitude: self.userLong)
                       // markerA.map =  self.viewTabDangGiao.mapView
                        
                        let markerB = GMSMarker()
                        markerB.position = CLLocationCoordinate2D(latitude: Double(resultLat)!, longitude: Double(resultLong)!)
                      //  markerB.map =  self.viewTabDangGiao.mapView
                    }
                    
                }
                else
                {
                    
                }
                
            }
            else
            {
                
                
            }
            
            
            
        }
        
    }
    /***************************************************************************************************************/
    
    /********************************************************** func main *********************************/
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n")
        {
            self.view.endEditing(true)
            return false
        }
        else
        {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func OnClickViewChuKy(gestureRecognizer: UIGestureRecognizer)
    {
        tapSigning()
    }
    
    
    @objc func OnClickViewDaNhan(gestureRecognizer: UIGestureRecognizer)
    {
        
        
        if let viewControllers = navigationController?.viewControllers {
            for viewController in viewControllers {
                if viewController.isKind(of: GHTNViewController.self){
                    print("clickccc OnClickViewDaNhan")
                    
                    //                    if(self.canChange == true)
                    //                    {
                    //                        self.navigationController!.popToRootViewController(animated: true)
                    //                    }
                    
                    lineViewThongKe.isHidden = true
                    lineViewMoTaLoi.isHidden = true
                    lineViewThongTin.isHidden = false
//                    lineViewPhuKien.isHidden = true
                    
                    self.viewTabThongKe.isHidden = true
                    self.viewTabDaGiao.isHidden = true
                    self.viewTabDaNhan.isHidden = false
                    self.viewTabDangGiao.isHidden = true
                    
                }
                
            }
        }
        
        
        
        
        
        
        
        
    }
    
    @objc func OnClickViewThongKe(gestureRecognizer: UIGestureRecognizer)
    {
        
        lineViewThongKe.isHidden = false
        lineViewMoTaLoi.isHidden = true
        lineViewThongTin.isHidden = true
//        lineViewPhuKien.isHidden = true
        
        self.viewTabThongKe.isHidden = false
        self.viewTabDaNhan.isHidden = true
        self.viewTabDangGiao.isHidden = true
        self.viewTabDaGiao.isHidden = true
        
        self.navigationItem.hidesBackButton = true
        
        
        
    }
    
    
    @objc func OnClickViewDaGiao(gestureRecognizer: UIGestureRecognizer)
    {
        
        lineViewThongKe.isHidden = true
        lineViewMoTaLoi.isHidden = false
        lineViewThongTin.isHidden = true
//        lineViewPhuKien.isHidden = true
        
        self.viewTabThongKe.isHidden = true
        self.viewTabDaNhan.isHidden = true
        self.viewTabDangGiao.isHidden = true
        self.viewTabDaGiao.isHidden = false
        
        self.navigationItem.hidesBackButton = true
        if(self.typePush == 2 )
        {
            self.navigationItem.hidesBackButton = true
        }
        
        
    }
    
    
    @objc func OnClickViewDangGiao(gestureRecognizer: UIGestureRecognizer)
    {
        if(self.typePush == nil || self.typePush == 0)
        {
            print("clickccc OnClickViewDangGiao")
            lineViewMoTaLoi.isHidden = true
            lineViewThongKe.isHidden = true
            lineViewThongTin.isHidden = true
//            lineViewPhuKien.isHidden = false
            
            self.viewTabThongKe.isHidden = true
            self.viewTabDaGiao.isHidden = true
            self.viewTabDaNhan.isHidden = true
        }
        else
        {
            print("clickccc OnClickViewDangGiao null")
            lineViewThongKe.isHidden = true
            lineViewMoTaLoi.isHidden = true
            lineViewThongTin.isHidden = true
//            lineViewPhuKien.isHidden = false
            
            self.viewTabThongKe.isHidden = true
            self.viewTabDaGiao.isHidden = true
            self.viewTabDaNhan.isHidden = true
            self.viewTabDangGiao.isHidden = false
            
            self.navigationItem.hidesBackButton = true
        }
    }
    
    
    func AddDialog()
    {
        viewInputCantCall = InputTextViewCantCall.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        viewInputCantCall.inputTextViewCantCallDelegate = self
        self.view.addSubview(viewInputCantCall)
        viewInputCantCall.isHidden = true
        
        viewInputCantCall.edtNamePasst.delegate = self
        viewInputCantCall.edtNameInside.delegate = self
        viewInputCantCall.edtNameProduct.delegate = self
        
        
        
        viewInputChangeTime = InputTextViewChangeTime.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        viewInputChangeTime.inputTextViewChangeTimeDelegate = self
        self.view.addSubview(viewInputChangeTime)
        viewInputChangeTime.isHidden = true
        
        
        
        viewInputTraHang = InputTextViewTraHang.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        viewInputTraHang.inputTextViewTraHangDelegate = self
        self.view.addSubview(viewInputTraHang)
        viewInputTraHang.isHidden = true
        
        
        self.view.addSubview(viewProcess)
        viewProcess.isHidden = true
        
    }
    
    
    
    func showProcessView(mShow:Bool)
    {
        self.viewProcess.isHidden = !mShow
    }
    
    func AddTabDaNhanView()
    {
        let navigationHeight:CGFloat = (self.navigationController?.navigationBar.frame.size.height)!
        viewTabDaNhan = ViewTabDaNhan.init(frame: CGRect(x: 0, y: viewThongTin.frame.origin.y + viewThongTin.frame.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height  ))
        self.view.addSubview(viewTabDaNhan)
        
        self.viewTabDaNhan.tableViewMainDaNhan.register(ItemHomeTabDaNhanTableViewCell.self, forCellReuseIdentifier: "ItemHomeTabDaNhanTableViewCell")
        self.viewTabDaNhan.tableViewMainDaNhan.register(UINib(nibName: "WaitForDeliveryCell", bundle: nil), forCellReuseIdentifier: "WaitForDeliveryCell")
        
        self.viewTabDaNhan.tableViewMainDaNhan.dataSource = self
        self.viewTabDaNhan.tableViewMainDaNhan.delegate = self
        self.viewTabDaNhan.tableViewMainDaNhan.frame.size.height = UIScreen.main.bounds.size.height - navigationHeight * 2.5
        
        self.viewTabDaNhan.tableViewMainDaNhan.separatorColor = UIColor.black
        /* get data SO for show*/
        self.getDataSOByUser(p_UserID: "\(Cache.user!.UserName)")
    }
    
    func AddTabDaGiaoView()
    {
        let navigationHeight:CGFloat = (self.navigationController?.navigationBar.frame.size.height)!
        viewTabDaGiao = ViewTabDaGiao.init(frame: CGRect(x: 0, y: viewThongTin.frame.origin.y + viewThongTin.frame.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height  ))
        self.view.addSubview(viewTabDaGiao)
        self.viewTabDaGiao.isHidden = true
        self.viewTabDaGiao.tableViewMainDaGiao.register(UINib(nibName: "WaitForDeliveryCell", bundle: nil), forCellReuseIdentifier: "WaitForDeliveryCell")
        self.viewTabDaGiao.tableViewMainDaGiao.dataSource = self
        self.viewTabDaGiao.tableViewMainDaGiao.delegate = self
        self.viewTabDaGiao.tableViewMainDaGiao.frame.size.height = UIScreen.main.bounds.size.height - navigationHeight * 2.5
        self.viewTabDangGiao.btnXemLaiDonHang.addTarget(self, action: #selector(self.XemLaiDonHangClick), for: .touchUpInside)
        
    }
    
    
    func AddTabThongKe()
    {
        viewTabThongKe = ViewTabThongKe.init(frame: CGRect(x: 0, y: viewThongTin.frame.origin.y + viewThongTin.frame.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height  ))
        self.view.addSubview(viewTabThongKe)
        self.viewTabThongKe.isHidden = true
        
        self.getDataReportDeliveryHeader(p_MaNV: "\(Cache.user!.UserName)", p_TinhTrangSO:"Tất cả",p_SoDHPOS:"")
        self.GetDataUserDelivery(shopCode: "\(Cache.user!.ShopCode)", jobtitle:"\(Cache.user!.JobTitle)")
        
        self.viewTabThongKe.companyButton2.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            
            self.viewTabThongKe.companyButton2.text = item.title
            self.view.endEditing(true)
            
            for i in 0 ..< self.arrGetEmPloyeesResult.count
            {
                if(item.title == self.arrGetEmPloyeesResult[i].EmployeeName )
                {
                    print("provide id \(self.arrGetEmPloyeesResult[i].CompanyCode)")
                }
            }
            
        }
        
//        self.viewTabThongKe.spinnerLoai.options = ["Tất cả", "Thành công", "Hủy"]
//        self.viewTabThongKe.spinnerLoai.didSelect { (option, index) in
//            print("You just select: \(option) at index: \(index)")
//            self.viewTabThongKe.spinnerLoai.placeholder = option
//            self.getDataReportDeliveryHeader(p_MaNV: "\(Cache.user!.UserName)", p_TinhTrangSO:"\(option)",p_SoDHPOS:"")
//
//        }
        self.viewTabThongKe.tableViewMainThongKe.register(ItemTabThongKeTableViewCell.self, forCellReuseIdentifier: "ItemTabThongKeTableViewCell")
        self.viewTabThongKe.tableViewMainThongKe.delegate = self
        self.viewTabThongKe.tableViewMainThongKe.dataSource = self
        
    }
    
    
    func AddTabDangGiao()
    {
        viewTabDangGiao = ViewTabDangGiao.init(frame: CGRect(x: 0, y: viewThongTin.frame.origin.y + viewThongTin.frame.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.view.addSubview(viewTabDangGiao)
        self.viewTabDangGiao.isHidden = true
        
        let tapChoosenPic = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImagePick1))
        viewTabDangGiao.viewImagePic.isUserInteractionEnabled = true
        viewTabDangGiao.viewImagePic.addGestureRecognizer(tapChoosenPic)
        
        let tapChoosenPic2 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImagePick2))
        viewTabDangGiao.viewImagePic2.isUserInteractionEnabled = true
        viewTabDangGiao.viewImagePic2.addGestureRecognizer(tapChoosenPic2)
        
        let tapChoosenPic21 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImagePick21))
        viewTabDangGiao.viewImagePic21.isUserInteractionEnabled = true
        viewTabDangGiao.viewImagePic21.addGestureRecognizer(tapChoosenPic21)
        
        let tapChoosenPic3 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImagePick3))
        viewTabDangGiao.viewImagePic3.isUserInteractionEnabled = true
        viewTabDangGiao.viewImagePic3.addGestureRecognizer(tapChoosenPic3)
        
        viewTabDangGiao.btnXacNhan.addTarget(self, action: #selector(self.ClickXacNhan), for: .touchUpInside)
        
        
        let tapCall = UITapGestureRecognizer(target: self, action: #selector(self.tapCallClick))
        viewTabDangGiao.imageViewCall.isUserInteractionEnabled = true
        viewTabDangGiao.imageViewCall.addGestureRecognizer(tapCall)
        
        
        
//        self.viewTabDangGiao.mapView?.isMyLocationEnabled = true
//        self.viewTabDangGiao.mapView.settings.myLocationButton = true
//        self.viewTabDangGiao.mapView.settings.compassButton = true
//        self.viewTabDangGiao.mapView.settings.zoomGestures = true
        
        
        viewTabDangGiao.btnKGoiDuoc.addTarget(self, action: #selector(self.ClickGoiKhongDuoc), for: .touchUpInside)
        viewTabDangGiao.btnKhachTraHang.addTarget(self, action: #selector(self.ClickKhachTraHang), for: .touchUpInside)
        viewTabDangGiao.btnKhachDoiGio.addTarget(self, action: #selector(self.ClickKhachDoiGio), for: .touchUpInside)
        
        
        viewTabDangGiao.viewImagePic2.isHidden = true
        viewTabDangGiao.lbHinhAnh2.isHidden = true
        viewTabDangGiao.lbHinhAnh3.isHidden = true
        viewTabDangGiao.lbHinhAnh4.isHidden = true
        viewTabDangGiao.viewImagePic21.isHidden = true
        viewTabDangGiao.viewImagePic3.isHidden = true
        
    }
    
    /********************************************************************************************************/
    /*****************************************************func tab 4****************************************************/
    
    
    
    
    func getDataReportDeliveryHeader(p_MaNV: String, p_TinhTrangSO:String,p_SoDHPOS:String)
    {
        MDeliveryAPIService.GetReportDeliveryHeader(p_MaNV: p_MaNV , p_TinhTrangSO: p_TinhTrangSO , p_SoDHPOS: p_SoDHPOS){ (error: Error?, success: Bool, result: ReportDeliveryHeaderGeneralResult!, result2: [ReportDeliveryHeaderOrderListResult]!) in
            if success
            {
                if(result != nil )
                {
                    self.viewTabThongKe.labelValueSoDHPhanCong.text = "\(result.SoDHDuocPhanCong)"
                    self.viewTabThongKe.labelValueSoDHKhongDung.text = "\(result.SoDHKhongDungMDelivery)"
                    self.viewTabThongKe.labelValueSoDHTre.text = "\(result.SoDHTreHen)"
                    self.viewTabThongKe.labelValueTongINC.text = "\(result.TongINC)"
                    self.viewTabThongKe.labelValueTongPhat.text = "\(result.TongPhat)"
                }
                if(result2.count > 0)
                {
                    print("vao day result2 \(result2.count)")
                    self.mListThongke = result2
                    self.viewTabThongKe.tableViewMainThongKe.reloadData()
                }
            }
            else
            {
                
            }
        }
    }
    
    
    
    /** func GetDataUserDelivery **/
    func GetDataUserDelivery(shopCode: String, jobtitle:String)
    {
        MDeliveryAPIService.GetUserDelivery(shopCode: shopCode, jobtitle:jobtitle){ (error: Error?, success: Bool, result: [GetEmPloyeesResult]!) in
            if success
            {
                if(result != nil && result.count > 0)
                {
                    print("get data GetDataUserDelivery is ok")
                    self.arrGetEmPloyeesResult = result
                    var listCom: [String] = []
                    print("ok")
                    for i in 0 ..< result.count
                    {
                        listCom.append("\(result[i].EmployeeName)")
                        
                        
                    }
                    self.viewTabThongKe.companyButton2.filterStrings(listCom)
                    self.viewTabThongKe.companyButton2.text = "\(Cache.user!.EmployeeName)"
                    
                }
                
            }
            else
            {
                
            }
        }
        
        
        
    }
    
    
    
    /********************************************************************************************************/
    /*****************************************************func tab 3****************************************************/
    @objc func ClickKhachDoiGio()
    {
        viewInputChangeTime.isHidden = false
    }
    
    @objc func ClickGoiKhongDuoc()
    {
        viewInputCantCall.isHidden = false
    }
    
    @objc func ClickKhachTraHang()
    {
        viewInputTraHang.isHidden = false
    }
    
    @objc func ClickXacNhan()
    {
        
        if(viewTabDangGiao.btnXacNhan.title(for: .normal) == "Thu Tiền KH")
        {
            
            self.GetDataGetPayment(docNum: "\((mObjectData?.ID)!)", userCode:"\(Cache.user!.UserName)", latitude:"\((mObjectData?.DocEntry)!)", longitude:"\((mObjectData?.DocEntry)!)", paymentType:"\((mObjectData?.DocEntry)!)", paymentAmount:"\((mObjectData?.DocEntry)!)", paymentDistance:"\((mObjectData?.DocEntry)!)")
        }
        else if(viewTabDangGiao.btnXacNhan.title(for: .normal) == "Giao Hàng Cho Khách")
        {
            mPic2 = true
            self.thisIsTheFunctionWeAreCalling()
        } else if  (viewTabDangGiao.btnXacNhan.title(for: .normal)?.lowercased() == "Chụp Ảnh khách Hàng".lowercased()) {
            mPic21 = true
            self.thisIsTheFunctionWeAreCalling()
        } else if viewTabDangGiao.btnXacNhan.title(for: .normal)?.lowercased() == "XÁC THỰC BACK TO SCHOOL".lowercased() {
            WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: " ") {
                MPOSAPIManager.checkImageUploaded(idcard: self.mObjectData?.CMND ?? "", voudcher: self.mObjectData?.ContentWork ?? "", phone: self.mObjectData?.U_Phone ?? "", sopos: Int(self.mObjectData?.DocEntry ?? "0") ?? 0) { [weak self] (respone, error) in
                    guard let self = self else {return}
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if error != "" {
                            self.showAlertOneButton(title: "Thông báo", with: error, titleButton: "Đồng ý")
                        } else {
                            guard let res = respone else {
                                print("can not parse data")
                                return
                            }
                            if res.BtsData.result == 0 {
                                self.showAlertOneButton(title: "Thông báo", with: res.BtsData.messages, titleButton: "Đồng ý")
                            } else if res.BtsData.result == 1 {
                                if res.BtsData.isUpload {
                                    self.viewTabDangGiao.btnXacNhan.setTitle("Chữ ký khách hàng", for: .normal)
                                } else {
                                    let vc = GHTNBacktoSchool()
                                    vc.btsID = res.BtsData.ID_BTS
                                    vc.onSuccess = {
                                        self.viewTabDangGiao.btnXacNhan.setTitle("Chữ ký khách hàng", for: .normal)
                                    }
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                            } else {
                                print("nothing")
                            }
                        }
                    }
                    
                }
            }
            
        } else if(viewTabDangGiao.btnXacNhan.title(for: .normal) == "Chữ ký khách hàng")
        {
            self.mKyThuatChuKyView.isHidden = false
        }
        
        
    }
    
    func showPopup(with error: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: "Thông Báo", message: error, preferredStyle: .alert)
        let okaction = UIAlertAction(title: "Đồng ý", style: .default) { (action) in
            if let back = completion {
                back()
            }
        }
        alert.addAction(okaction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func GetDataGetPayment(docNum: String, userCode:String, latitude:String, longitude:String, paymentType:String, paymentAmount:String, paymentDistance:String)
    {
        self.showProcessView(mShow: true)
        MDeliveryAPIService.GetSetSODelivered(docNum: docNum, userCode:userCode , latitude:latitude, longitude:longitude, paymentType:paymentType, paymentAmount:paymentAmount, paymentDistance:paymentDistance){ (error: Error?, success: Bool, result: ConfirmThuKhoResult!) in
            if success
            {
                if(result != nil)
                {
                    self.showProcessView(mShow: false)
                    Toast(text: "\(result.Descriptionn)").show()
                    if(result.Result == "1")
                    {
                        
                        self.lineViewMoTaLoi.isHidden = false
                        self.lineViewThongTin.isHidden = true
//                        self.lineViewPhuKien.isHidden = true
                        self.viewTabDaNhan.isHidden = true
                        self.viewTabDangGiao.isHidden = true
                        self.viewTabDaGiao.isHidden = false
                        self.navigationItem.hidesBackButton = true
                        self.typePush = 0
                        self.canChange = true
                    }
                }
            }
            else
            {
            }
        }
    }
    @objc func tapShowImagePick1(sender:UITapGestureRecognizer) {
        
        mPic1 = true
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc func tapShowImagePick2(sender:UITapGestureRecognizer) {
        
        mPic2 = true
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc func tapShowImagePick21(sender:UITapGestureRecognizer) {
        
        mPic21 = true
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc func tapShowImagePick3(sender:UITapGestureRecognizer) {
        
        mPic3 = true
        self.thisIsTheFunctionWeAreCalling()
    }
    
    func getDataUpAnh_GHTNResul(SoSO: String,FileName: String,Base64String: String,UserID: String,KH_Latitude: String,KH_Longitude: String,Type: String)
    {
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Uploading...") {
            MDeliveryAPIService.GetDatamDel_UpAnh_GHTNResult(SoSO: SoSO , FileName: FileName , Base64String: Base64String,UserID: UserID,KH_Latitude: "\(self.userLat)",KH_Longitude: "\(self.userLong)",Type: Type){ [weak self] (error: Error?, success: Bool, result: mDel_UpAnh_GHTNResult!) in
                guard let self = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if self.mPic1 {
                        self.mPic1 = false
                    }
                    if success
                    {
                        if(result != nil )
                        {
                            self.canChange = false
                            if self.mPic2 {
                                self.mPic2 = false
                                if self.mObjectData?.mType == "12" {
                                    self.viewTabDangGiao.btnXacNhan.setTitle("XÁC THỰC BACK TO SCHOOL", for: .normal)
                                }
                            }
                            self.showPopup(with: result.Msg, completion: nil)
                        } else {
                            self.showPopup(with: error?.localizedDescription ?? "", completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    
    /****************************************** table view **************************************************************/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == self.viewTabDaNhan.tableViewMainDaNhan)
        {
            guard indexPath.row < mListGetSOByUserResult.count else { return }
//            let vc = ChiTietDonHangViewController()
//            vc.mObjectData = mListGetSOByUserResult[indexPath.row]
//            vc.mTimeLest = GetTime(mObject: mListGetSOByUserResult[indexPath.row])
            let model = mListGetSOByUserResult[indexPath.row]
            let vc = GHTNChiTietChoGiaoRouter().configureVIPERGHTNChiTietChoGiao()
            vc.presenter?.mObjectData = mListGetSOByUserResult[indexPath.row]
            vc.presenter?.model = GHTNChiTietChoGiaoEntity.GHTNModel(id: Int(model.ID),
                                                                     code: model.Code,
                                                                     userName: model.UserName,
                                                                     empName: model.EmpName,
                                                                     bookDate: model.BookDate,
                                                                     whConfirmed: model.WHConfirmed,
                                                                     whDate: model.WHDate,
                                                                     rejectReason: model.RejectReason,
                                                                     rejectDate: model.RejectDate,
                                                                     paymentType: Int(model.PaymentType),
                                                                     finishLatitude: Double(model.FinishLatitude),
                                                                     finishLongitude: Double(model.FinishLongitude),
                                                                     finishTime: model.FinishTime,
                                                                     paidConfirmed: model.PaidConfirmed,
                                                                     paidDate: model.PaidDate,
                                                                     orderStatus: Int(model.OrderStatus),
                                                                     docEntry: Int(model.DocEntry),
                                                                     uNuBill: model.U_NuBill,
                                                                     uReveRe: model.U_ReveRe,
                                                                     uCrdName: model.U_CrdName,
                                                                     uCAddress: model.U_CAddress,
                                                                     uCPhone: model.U_CPhone,
                                                                     uSyBill: model.U_SyBill,
                                                                     uCRDate: model.U_CrDate,
                                                                     uDesc: model.U_Desc,
                                                                     uTMonPR: Int(model.U_TMonPr),
                                                                     uMonPer: Int(model.U_MonPer),
                                                                     uTMonTx: Int(model.U_TMonTx),
                                                                     uDownPay: Int(model.U_DownPay),
                                                                     uTMonBI: Int(model.U_TMonBi),
                                                                     uReceive: model.U_Receive,
                                                                     uAdrDel: model.U_AdrDel,
                                                                     uPhone: model.U_Phone,
                                                                     uDateDe: model.U_DateDe,
                                                                     uNumEcom: Int(model.U_NumEcom),
                                                                     uShpCode: model.U_ShpCode,
                                                                     uDeposit: Int(model.U_Deposit),
                                                                     uPaidMoney: Int(model.U_PaidMoney),
                                                                     sourceType: Int(model.SourceType),
                                                                     rowVersion: Int(model.RowVersion),
                                                                     type: Int(model.mType),
                                                                     isCN: model.Is_CN,
                                                                     htttFf: model.HTTT_FF,
                                                                     imgURLPDKMatTruocCMND: model.ImgUrl_PDK_MatTruocCMND,
                                                                     imgURLPDKMatSauCMND: model.ImgUrl_PDK_MatSauCMND,
                                                                     imgURLGiayUyQuyenMatSauCMND: model.ImgUrl_GiayUyQuyen_MatSauCMND,
                                                                     imgURLGiayThayDoiChuKy: model.ImgUrl_GiayThayDoiChuKy,
                                                                     cmnd: model.CMND,
                                                                     tenDN: model.Ten_DN,
                                                                     smChiuTrachNhiem: model.SM_ChiuTrachNhiem,
                                                                     imgURLTGH: model.ImgUrl_TGH,
                                                                     imgURLNKH: model.ImgUrl_NKH,
                                                                     imgURLPGH: model.ImgUrl_PGH,
                                                                     isUploadTGH: Int(model.Is_Upload_TGH),
                                                                     isUploadNKH: Int(model.Is_Upload_NKH),
                                                                     isUploadPGH: Int(model.Is_Upload_PGH),
                                                                     whConfirmedMaTen: model._WHConfirmed_MaTen,
                                                                     returnReason: model.ReturnReason,
                                                                     cantCallReason: "",
                                                                     imgURLTTD: model.ImgUrl_TTD,
                                                                     imgURLHDTC1: model.ImgUrl_HDTC1,
                                                                     imgURLHDTC2: "",
                                                                     imgURLHDTC3: "",
                                                                     soTienTraTruoc: Double(model.SoTienTraTruoc),
                                                                     createType: Double(model.mCreateType),
                                                                     installLocation: model.InstallLocation,
                                                                     contentWork: model.ContentWork,
                                                                     userBookCode: model.UserBookCode,
                                                                     userBookName: model.UserBookName,
                                                                     sdtUserBook: "",
                                                                     uShopName: model.U_ShopName,
                                                                     imgUploadTime: model.ImgUploadTime,
                                                                     imgURLXNGH: model.ImgUrl_XNGH,
                                                                     maHD: model.Ma_HD,
                                                                     uAdrDelNew: model.U_AdrDel_New,
                                                                     isFado: Bool(model.is_fado),
                                                                     otpFado: "",
                                                                     createDateTime: model.CreateDateTime,
                                                                     partnerCode: model.Partner_code,
                                                                     partnerName: model.Partner_name,
                                                                     maShopNhoGiaoHang: model.MaShopNhoGiaoHang,
                                                                     deliveryDateTime: model.DeliveryDateTime,
                                                                     pTabName: model.p_TabName,
                                                                     pLoaiDonHang: model.p_LoaiDonHang,
                                                                     pShopXuat: model.p_ShopXuat,
                                                                     pShopGiaoHo: model.p_ShopGiaoHo,
                                                                     pNguoiGiao: model.p_NguoiGiao,
                                                                     pTrangThaiGiaoHang: model.p_TrangThaiGiaoHang,
                                                                     pTrangThaiDonHang: model.p_TrangThaiDonHang,
                                                                     pThongTinNCCTransactionCode: model.p_ThongTinNCC_TransactionCode,
                                                                     pThongTinNCCTaiXeTen: model.p_ThongTinNCC_TaiXe_Ten,
                                                                     pThongTinNCCTaiXeSDT: model.p_ThongTinNCC_TaiXe_SDT,
                                                                     pThongTinNCCTaiXeThoiGianDenShop: model.p_ThongTinNCC_TaiXe_ThoiGianDenShop,
                                                                     pThongTinNCCURLTracking: model.p_ThongTinNCC_URLTracking,
                                                                     btnXacNhanXuatKho: model.btn_XacNhanXuatKho,
                                                                     btnBatDauGiaoHang: model.btn_BatDauGiaoHang,
                                                                     btnFRTGiao: model.btn_FRTGiao,
                                                                     btnHuyGiaoHang: model.btn_HuyGiaoHang,
                                                                     btnKhachNhanHang: model.btn_KhachNhanHang,
                                                                     btnKhachKhongNhanHang: model.btn_KhachKhongNhanHang,
                                                                     btnXacNhanNhapKho: model.btn_XacNhanNhapKho,
                                                                     pThongTinNguoiNhanName: model.p_ThongTinNguoiNhan_Name,
                                                                     pThongTinNguoiNhanSDT: model.p_ThongTinNguoiNhan_SDT,
                                                                     pThongTinNguoiNhanAddress: model.p_ThongTinNguoiNhan_Address,
                                                                     pThongTinNguoiNhanDate: model.p_ThongTinNguoiNhan_Date)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if(tableView == self.viewTabDaGiao.tableViewMainDaGiao)
        {
            guard indexPath.row < mListDaGiaoGetSOByUserDisplay.count else { return }
            let newViewController = ChiTietDonHangTabDaGiaoViewController()
            newViewController.mObjectData = mListDaGiaoGetSOByUserDisplay[indexPath.row]
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        if(tableView == self.viewTabThongKe.tableViewMainThongKe)
        {
            guard indexPath.row < mListThongke.count else { return }
            let newViewController = ChiTietThongKeController()
            newViewController.mListThongke = mListThongke[indexPath.row]
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.viewTabDaNhan.tableViewMainDaNhan)
        {
            return mListGetSOByUserResult.count
        }
        if(tableView == self.viewTabDaGiao.tableViewMainDaGiao)
        {
            return mListDaGiaoGetSOByUserDisplay.count
        }
        if(tableView == self.viewTabThongKe.tableViewMainThongKe)
        {
            print("tableView == self.viewTabThongKe.tableViewMainThongKe")
            return mListThongke.count
        }
        else
        {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellMainThongKe: ItemTabThongKeTableViewCell?
        cellMainThongKe = ItemTabThongKeTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemTabThongKeTableViewCell")
        
        
        if(tableView == self.viewTabDaNhan.tableViewMainDaNhan) {
            guard indexPath.row < mListGetSOByUserResult.count else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: "WaitForDeliveryCell", for: indexPath) as! WaitForDeliveryCell
            let item = mListGetSOByUserResult[indexPath.row]
            cell.bindCell(item: item, timeExpct: self.GetTime(mObject: (item)))
            cell.onOpenLink = {
                if let url = URL(string: "\(self.mListGetSOByUserResult[indexPath.row].p_ThongTinNCC_URLTracking)") {
                    UIApplication.shared.open(url)
                }
            }
            return cell
        }
        if(tableView == self.viewTabDaGiao.tableViewMainDaGiao) {
            guard indexPath.row < mListDaGiaoGetSOByUserDisplay.count else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: "WaitForDeliveryCell", for: indexPath) as! WaitForDeliveryCell
            let item = mListDaGiaoGetSOByUserDisplay[indexPath.row]
            cell.bindCellDagiao(item: item)
            cell.onOpenLink = {
                if let url = URL(string: "\(self.mListDaGiaoGetSOByUserDisplay[indexPath.row].p_ThongTinNCC_URLTracking)") {
                    UIApplication.shared.open(url)
                }
            }
            return cell
        }
        if(tableView == self.viewTabThongKe.tableViewMainThongKe) {
            guard indexPath.row < mListThongke.count else { return UITableViewCell() }
            cellMainThongKe?.cellTenSP.text = "\(mListThongke[indexPath.row].SoDHEcom)";
            cellMainThongKe?.cellDVT.text = "\(mListThongke[indexPath.row].TinhDungHen)";
            cellMainThongKe?.cellSLPO.text = "\(mListThongke[indexPath.row].TinhTrangSDmDelivery)";
            cellMainThongKe?.cellSLNhap.text = "\(mListThongke[indexPath.row].INC)";
            
            return cellMainThongKe!
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(tableView == self.viewTabThongKe.tableViewMainThongKe) {
            return Common.Size(s: 16) + 30;
        } else {
            return UITableView.automaticDimension
        }
        
    }
    
    
    
    /***********************************************************************************************************/
    
    
    
    /**************************** func tab 1 ****************************/
    func GetTime(mObject:GetSOByUserResult)->String
    {
        
        
        
        if (mObject.OrderStatus != "5" && mObject.OrderStatus != "6" && mObject.OrderStatus != "4" && mObject.OrderStatus != "8"){
            let dateFormatter = DateFormatter()
            if(mObject.U_DateDe.count > 0){
                var mStr = "\(mObject.DeliveryDateTime)"
                if(mStr.count > 19)
                {
                    let index = mStr.index(mStr.startIndex, offsetBy: 19)
                    //mStr = mStr.substring(to: index)
                    mStr = String(mStr[..<index])
                }
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                dateFormatter.timeZone = TimeZone(identifier: "UTC")
                let date = dateFormatter.date(from: "\(mStr)")
                
                var now = Date()
                var nowComponents = DateComponents()
                let calendar = Calendar.current
                nowComponents.year = Calendar.current.component(.year, from: now)
                nowComponents.month = Calendar.current.component(.month, from: now)
                nowComponents.day = Calendar.current.component(.day, from: now)
                nowComponents.hour = Calendar.current.component(.hour, from: now)
                nowComponents.minute = Calendar.current.component(.minute, from: now)
                nowComponents.second = Calendar.current.component(.second, from: now)
                nowComponents.timeZone = TimeZone(abbreviation: "GMT")!
                now = calendar.date(from: nowComponents)!
                let myString = dateFormatter.string(from: now)
                let date2 = dateFormatter.date(from: "\(myString)")// create date from string
                print("mDatewrong \(date2!) \(myString) \(now) ")
                if date2 != nil && date != nil {
                    var interval = date2!.timeIntervalSince(date!)
                    if (interval < 0)
                    {
                        interval = abs(interval)
                        return "Còn lại: \(interval.minuteSecondMS)"
                    }
                    else
                    {
                        return "Trễ: \(interval.minuteSecondMS)"
                    }
                }else{
                    return ""
                }
             
            }else{
                return ""
            }
    
        }
        else
        {
            return ""
        }
        
    }
    
    
    func getDataSOByUser(p_UserID:String) {
        if !mPic1 && !mPic2 && !mPic3 && !mPic21 {
            self.showProcessView(mShow: true)
        }
        MDeliveryAPIService.GetSOByUser(p_User: p_UserID){ (error: Error?, success: Bool, result: [GetSOByUserResult]!) in
            self.showProcessView(mShow: false)
            if success {
                self.mListDaGiaoGetSOByUserDisplay.removeAll()
                self.mListGetSOByUserResult.removeAll()
                if(result != nil && result.count > 0) {
                    self.showProcessView(mShow: false)
                    
                    for i in 0 ..< result.count {
                        if result[i].p_TabName == "ChoGiao" {
                            self.mListGetSOByUserResult.append(result[i])
                        } else if result[i].p_TabName == "DaGiao" {
                            self.mListDaGiaoGetSOByUserDisplay.append(result[i])
                        }
                    }
                    self.viewTabDaNhan.tableViewMainDaNhan.reloadData()
                    self.viewTabDaGiao.tableViewMainDaGiao.reloadData()
                    self.viewTabThongKe.tableViewMainThongKe.reloadData()
                    self.isLoading = false
                }
            } else {
                self.mListDaGiaoGetSOByUserDisplay.removeAll()
                self.mListGetSOByUserResult.removeAll()
                self.viewTabDaNhan.tableViewMainDaNhan.reloadData()
                self.viewTabDaGiao.tableViewMainDaGiao.reloadData()
                self.viewTabThongKe.tableViewMainThongKe.reloadData()
                self.isLoading = false
            }
        }
    }
    
    
}


class ItemHomeTabDaNhanTableViewCell: UITableViewCell {
    var txtDonHang: UILabel!
    var txtEcom: UILabel!
    var txtTime: UILabel!
    var viewLine1: UIView!
    
    var txtTenKhachHang: UILabel!
    var txtDiaChi: UILabel!
    var txtLoaiDH: UILabel!
    var txtNhanVienGiao: UILabel!
    var txtSM: UILabel!
    var txtGhiChu: UILabel!
    
    
    var txtValueTenKhachHang: UILabel!
    var txtValueDiaChi: UILabel!
    var txtValueLoaiDH: UILabel!
    var txtValueNhanVienGiao: UILabel!
    var txtValueSM: UILabel!
    
    
    var viewGhiChu:UIView!
    var txtValueGhiChu: UILabel!
    var viewLine2:UIView!
    
    var txtTimeExpect: UILabel!
    var btnNote: UIButton!
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        txtDonHang = UILabel()
        txtDonHang.textColor = UIColor(netHex:0x007ADF)
        txtDonHang.numberOfLines = 1
        txtDonHang.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(txtDonHang)
        
        txtEcom = UILabel()
        txtEcom.textColor = UIColor(netHex:0x007ADF)
        txtEcom.numberOfLines = 1
        txtEcom.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        txtEcom.textAlignment =  .center
        contentView.addSubview(txtEcom)
        
        txtTime = UILabel()
        txtTime.textColor = UIColor.black
        txtTime.numberOfLines = 1
        txtTime.textAlignment =  .right
        txtTime.font = UIFont.systemFont(ofSize: Common.Size(s:8))
        contentView.addSubview(txtTime)
        
        
        viewLine1 = UIView()
        viewLine1.backgroundColor = UIColor.gray
        contentView.addSubview(viewLine1)
        
        txtTenKhachHang = UILabel()
        txtTenKhachHang.textColor = UIColor.gray
        txtTenKhachHang.numberOfLines = 1
        txtTenKhachHang.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        txtTenKhachHang.text = "Tên Khách Hàng :"
        contentView.addSubview(txtTenKhachHang)
        
        
        
        txtDiaChi = UILabel()
        txtDiaChi.textColor = UIColor.gray
        txtDiaChi.numberOfLines = 1
        txtDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        txtDiaChi.text = "Địa Chỉ Khách Hàng :"
        contentView.addSubview(txtDiaChi)
        
        txtLoaiDH = UILabel()
        txtLoaiDH.textColor = UIColor.gray
        txtLoaiDH.numberOfLines = 1
        txtLoaiDH.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        txtLoaiDH.text = "Loại DH :"
        contentView.addSubview(txtLoaiDH)
        
        
        txtNhanVienGiao = UILabel()
        txtNhanVienGiao.textColor = UIColor.gray
        txtNhanVienGiao.numberOfLines = 1
        txtNhanVienGiao.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        txtNhanVienGiao.text = "Nhân viên giao :"
        contentView.addSubview(txtNhanVienGiao)
        
        
        txtSM = UILabel()
        txtSM.textColor = UIColor.gray
        txtSM.numberOfLines = 1
        txtSM.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        txtSM.text = "SM :"
        contentView.addSubview(txtSM)
        
        txtGhiChu = UILabel()
        txtGhiChu.textColor = UIColor.gray
        txtGhiChu.numberOfLines = 1
        txtGhiChu.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        txtGhiChu.text = "Ghi chú :"
        contentView.addSubview(txtGhiChu)
        
        txtValueTenKhachHang = UILabel()
        txtValueTenKhachHang.textColor = UIColor.black
        txtValueTenKhachHang.numberOfLines = 1
        txtValueTenKhachHang.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(txtValueTenKhachHang)
        
        txtValueDiaChi = UILabel()
        txtValueDiaChi.textColor = UIColor.black
        txtValueDiaChi.numberOfLines = 0
        txtValueDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(txtValueDiaChi)
        
        txtValueLoaiDH = UILabel()
        txtValueLoaiDH.textColor = UIColor.black
        txtValueLoaiDH.numberOfLines = 0
        txtValueLoaiDH.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(txtValueLoaiDH)
        
        txtValueNhanVienGiao = UILabel()
        txtValueNhanVienGiao.textColor = UIColor.black
        txtValueNhanVienGiao.numberOfLines = 1
        txtValueNhanVienGiao.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(txtValueNhanVienGiao)
        
        txtValueSM = UILabel()
        txtValueSM.textColor = UIColor.black
        txtValueSM.numberOfLines = 1
        txtValueSM.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(txtValueSM)
        
        
        
        
        txtTimeExpect = UILabel()
        txtTimeExpect.numberOfLines = 1
        txtTimeExpect.textColor = UIColor(netHex:0x00b16f)
        txtTimeExpect.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(txtTimeExpect)
        
        viewGhiChu = UIView()
        viewGhiChu.backgroundColor = UIColor(netHex:0xececec)
        viewGhiChu.layer.borderWidth = 0.5
        viewGhiChu.layer.borderColor = UIColor.black.cgColor
        viewGhiChu.layer.cornerRadius = 5
        contentView.addSubview(viewGhiChu)
        
        txtValueGhiChu = UILabel()
        txtValueGhiChu.contentMode = .scaleToFill
        txtValueGhiChu.numberOfLines = 0
        
        txtValueGhiChu.textColor = UIColor.black
        txtValueGhiChu.font = UIFont.systemFont(ofSize: Common.Size(s:9))
        
        
        viewLine2 = UIView()
        viewLine2.backgroundColor = UIColor.gray
        contentView.addSubview(viewLine2)
        
        
        btnNote = UIButton()
        btnNote.backgroundColor = UIColor(netHex:0xe73131)
        btnNote.layer.cornerRadius = 10
        
        btnNote.setTitle("Chưa xác nhận",for: .normal)
        contentView.addSubview(btnNote)
        
        
        
        txtDonHang.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width / 4 ,height: Common.Size(s:16))
        
        
        txtEcom.frame = CGRect(x:UIScreen.main.bounds.size.width / 3  +  Common.Size(s:5) ,y: txtDonHang.frame.origin.y ,width: txtDonHang.frame.size.width + Common.Size(s:20),height: Common.Size(s:16))
        
        
        txtTime.frame = CGRect(x:UIScreen.main.bounds.size.width / 3 * 2  ,y: txtEcom.frame.origin.y ,width: txtEcom.frame.size.width ,height: Common.Size(s:16))
        
        viewLine1.frame = CGRect(x: 0   ,y: txtTime.frame.origin.y + txtTime.frame.size.height +  Common.Size(s:5) ,width: UIScreen.main.bounds.size.width ,height: Common.Size(s:0.5))
        
        
        txtTenKhachHang.frame = CGRect(x:Common.Size(s:10)  ,y: viewLine1.frame.origin.y + viewLine1.frame.size.height + Common.Size(s:5) ,width: UIScreen.main.bounds.size.width / 2  ,height: Common.Size(s:13))
        
        
        txtDiaChi.frame = CGRect(x:Common.Size(s:10)  ,y: txtTenKhachHang.frame.origin.y +  txtTenKhachHang.frame.size.height + Common.Size(s:5) ,width: UIScreen.main.bounds.size.width / 3  ,height: Common.Size(s:13))
        txtValueDiaChi.frame = CGRect(x: UIScreen.main.bounds.size.width / 3 + Common.Size(s:5)  ,y: txtDiaChi.frame.origin.y ,width: UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width / 3 - Common.Size(s:15)  ,height: Common.Size(s:14))
        
        txtLoaiDH.frame = CGRect(x:Common.Size(s:10)  ,y: txtValueDiaChi.frame.origin.y +  txtValueDiaChi.frame.size.height + Common.Size(s:5) ,width: UIScreen.main.bounds.size.width / 3  ,height: Common.Size(s:13))
        
        txtNhanVienGiao.frame = CGRect(x:Common.Size(s:10)  ,y: txtLoaiDH.frame.origin.y +  txtLoaiDH.frame.size.height + Common.Size(s:5) ,width: UIScreen.main.bounds.size.width / 3  ,height: Common.Size(s:13))
        
        txtSM.frame = CGRect(x:Common.Size(s:10)  ,y: txtNhanVienGiao.frame.origin.y +  txtNhanVienGiao.frame.size.height + Common.Size(s:5) ,width: UIScreen.main.bounds.size.width / 3  ,height: Common.Size(s:13))
        
        txtGhiChu.frame = CGRect(x:Common.Size(s:10)  ,y: txtSM.frame.origin.y +  txtSM.frame.size.height + Common.Size(s:5) ,width: UIScreen.main.bounds.size.width / 3  ,height: Common.Size(s:13))
        
        txtValueTenKhachHang.frame = CGRect(x: UIScreen.main.bounds.size.width / 3 + Common.Size(s:5)  ,y: txtTenKhachHang.frame.origin.y ,width: UIScreen.main.bounds.size.width / 2  ,height: Common.Size(s:13))

        txtValueLoaiDH.frame = CGRect(x: UIScreen.main.bounds.size.width / 3 + Common.Size(s:5)  ,y: txtLoaiDH.frame.origin.y ,width: UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width / 3 - Common.Size(s:15)  ,height: Common.Size(s:14))
        
        txtValueNhanVienGiao.frame = CGRect(x: UIScreen.main.bounds.size.width / 3 + Common.Size(s:5)  ,y: txtNhanVienGiao.frame.origin.y ,width: UIScreen.main.bounds.size.width   ,height: Common.Size(s:13))
        
        txtValueSM.frame = CGRect(x: UIScreen.main.bounds.size.width / 3 + Common.Size(s:5)  ,y: txtSM.frame.origin.y ,width: UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width / 3 - Common.Size(s:15)  ,height: Common.Size(s:13))
        
        
        
        viewGhiChu.frame = CGRect(x: Common.Size(s:20)  ,y: txtGhiChu.frame.origin.y + txtGhiChu.frame.size.height + Common.Size(s:5) ,width: UIScreen.main.bounds.size.width - Common.Size(s:40)  ,height: Common.Size(s:50))
        
        txtValueGhiChu.frame = CGRect(x: Common.Size(s:5)  ,y: Common.Size(s:3) ,width: UIScreen.main.bounds.size.width - Common.Size(s:50)  ,height: Common.Size(s:50))
        viewGhiChu.addSubview(txtValueGhiChu)
        
        
        viewLine2.frame = CGRect(x: 0   ,y: viewGhiChu.frame.origin.y + viewGhiChu.frame.size.height +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width ,height: Common.Size(s:0.2))
        
        
        txtTimeExpect.frame = CGRect(x: Common.Size(s:10)  ,y: viewLine2.frame.origin.y +  viewLine2.frame.size.height + Common.Size(s:5) ,width: UIScreen.main.bounds.size.width / 2  ,height: Common.Size(s:13))
        
        btnNote.frame = CGRect(x: UIScreen.main.bounds.size.width / 2 + Common.Size(s:5)  ,y: txtTimeExpect.frame.origin.y  ,width: UIScreen.main.bounds.size.width / 2 - Common.Size(s:10)   ,height: Common.Size(s:25))
        
        
        
        
    }
    
    
    
}


extension GHTNViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
        let camera = DSCameraHandler(delegate_: self)
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let takePhoto = UIAlertAction(title: "Chụp ảnh", style: .default) { (alert : UIAlertAction!) in
            camera.getCameraOn(self, canEdit: false)
        }
        let sharePhoto = UIAlertAction(title: "Chọn ảnh có sẵn", style: .default) { (alert : UIAlertAction!) in
            camera.getPhotoLibraryOn(self, canEdit: false)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
            if let viewControllers = self.navigationController?.viewControllers {
                for viewController in viewControllers {
                    if viewController.isKind(of: GHTNViewController.self){
                        print("clickccc OnClickViewDaNhan")
                        
                        self.navigationController?.popToRootViewController(animated: true)
                        self.lineViewThongKe.isHidden = true
                        self.lineViewMoTaLoi.isHidden = true
                        self.lineViewThongTin.isHidden = false
//                        self.lineViewPhuKien.isHidden = true
                        
                        self.viewTabThongKe.isHidden = true
                        self.viewTabDaGiao.isHidden = true
                        self.viewTabDaNhan.isHidden = false
                        self.viewTabDangGiao.isHidden = true
                        
                    }
                    
                }
            }
        }
        optionMenu.addAction(takePhoto)
        if !mPic21 {
            optionMenu.addAction(sharePhoto)
        }
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        let imageData:NSData = image.jpegData(compressionQuality: 0.5)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
        
        if(self.mPic1 == true)
        {
            self.viewTabDangGiao.viewCMNDTruocButton3.frame.origin.x = self.viewTabDangGiao.viewImagePic.frame.width / 4
            self.viewTabDangGiao.viewCMNDTruocButton3.frame.size.width =  self.viewTabDangGiao.viewImagePic.frame.width / 2
            self.viewTabDangGiao.viewCMNDTruocButton3.frame.size.height = self.viewTabDangGiao.viewImagePic.frame.height
            self.viewTabDangGiao.viewCMNDTruocButton3.contentMode = UIView.ContentMode.scaleToFill

            self.viewTabDangGiao.viewCMNDTruocButton3.image = image
            self.viewTabDangGiao.btnXacNhan.setTitle("Giao Hàng Cho Khách", for: .normal)
            
            ////upload Image
            
            let imageDataPic1:NSData = self.viewTabDangGiao.viewCMNDTruocButton3.image!.jpegData(compressionQuality: Helper.resizeImageValueFF)! as NSData
            let strBase64Pic1 = imageDataPic1.base64EncodedString(options: .endLineWithLineFeed)
            self.getDataUpAnh_GHTNResul(SoSO: "\((mObjectData?.DocEntry)!)",FileName: "_ios.jpg",Base64String: "\(strBase64Pic1)",UserID: "\((Helper.getUserName()!))",KH_Latitude: "\((mObjectData?.FinishLatitude)!)",KH_Longitude: "\((mObjectData?.FinishLongitude)!)",Type: "1")
            
            if(self.viewTabDangGiao.isHidden == true)
            {
                self.viewTabDangGiao.isHidden = false
            }
        }
        if(self.mPic2 == true)
        {
            self.viewTabDangGiao.viewCMNDTruocButton4.frame.origin.x = self.viewTabDangGiao.viewImagePic2.frame.width / 4
            self.viewTabDangGiao.viewCMNDTruocButton4.frame.size.width =  self.viewTabDangGiao.viewImagePic2.frame.width / 2
            self.viewTabDangGiao.viewCMNDTruocButton4.frame.size.height = self.viewTabDangGiao.viewImagePic2.frame.height
            self.viewTabDangGiao.viewCMNDTruocButton4.contentMode = UIView.ContentMode.scaleToFill

            self.viewTabDangGiao.viewCMNDTruocButton4.image = image
            if self.orderDetail?.Buttons.HomeEkycBtn ?? false {
                self.viewTabDangGiao.btnXacNhan.setTitle("Chụp Ảnh khách hàng", for: .normal)
            } else {
                self.viewTabDangGiao.btnXacNhan.setTitle("Chữ ký khách hàng", for: .normal)
            }
            self.viewTabDangGiao.viewImagePic2.isHidden = false
            self.viewTabDangGiao.lbHinhAnh2.isHidden = false
            ////upload Image
            
            ////update 5/9
            let imageDataPic1:NSData = self.viewTabDangGiao.viewCMNDTruocButton4.image!.jpegData(compressionQuality: Helper.resizeImageValueFF)! as NSData
            let strBase64Pic1 = imageDataPic1.base64EncodedString(options: .endLineWithLineFeed)
            self.getDataUpAnh_GHTNResul(SoSO: "\((mObjectData?.DocEntry)!)",FileName: "_ios.jpg",Base64String: "\(strBase64Pic1)",UserID: "\((Helper.getUserName()!))",KH_Latitude: "\((mObjectData?.FinishLatitude)!)",KH_Longitude: "\((mObjectData?.FinishLongitude)!)",Type: "2")
            
          
            
            //
            
        }
        
        if(self.mPic21 == true)
        {
            self.viewTabDangGiao.viewCMNDTruocButton41.frame.origin.x = self.viewTabDangGiao.viewImagePic21.frame.width / 4
            self.viewTabDangGiao.viewCMNDTruocButton41.frame.size.width =  self.viewTabDangGiao.viewImagePic21.frame.width / 2
            self.viewTabDangGiao.viewCMNDTruocButton41.frame.size.height = self.viewTabDangGiao.viewImagePic21.frame.height
            self.viewTabDangGiao.viewCMNDTruocButton41.contentMode = UIView.ContentMode.scaleToFill
            
            self.viewTabDangGiao.viewCMNDTruocButton41.image = image
            self.viewTabDangGiao.viewImagePic21.isHidden = false
            self.viewTabDangGiao.lbHinhAnh3.isHidden = false
            self.viewTabDangGiao.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.viewTabDangGiao.viewImagePic.frame.origin.y + self.viewTabDangGiao.viewImagePic.frame.size.height + 400 + self.viewTabDangGiao.viewImagePic21.frame.size.height)
            ////upload Image
            
            ////update 5/9
            var params = [String: Any]()
            params["shopCode"] = Cache.user?.ShopCode
            params["filterKey"] = "4"
            params["filterValue"] = mObjectData?.DocEntry
            params["isDetail"] = true
            InstallmentApiManager.shared.getInstallmentHistory(params: params) {[weak self] (_, detailHistory, error) in
                guard let self = self else { return }
                self.orderDetail = detailHistory?.data.first
                var params: [String: Any] = [:]
                params["employeeCode"] = Cache.user!.UserName
                params["shopCode"] = Cache.user!.ShopCode
                params["nationalId"] = self.orderDetail?.customer.cMND
                params["realSelfie"] = strBase64
                params["applicationId"] = self.orderDetail?.otherInfos.applicationId
                params["docEntry"] = self.orderDetail?.otherInfos.docEntry
                WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang xác minh ảnh khách hàng...") {
                    InstallmentApiManager.shared.checkInfordelivery(params: params) { [weak self] (response, error) in
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            guard let self = self else { return }
                            if error != "" {
                                self.showPopup(with: error, completion: nil)
                            } else {
                                self.canChange = false
                                if response?.isSuccess ?? false {
                                    if(self.mPic21 == true) {
                                        self.mPic21 = false
                                        self.viewTabDangGiao.btnXacNhan.setTitle("Chữ ký khách hàng", for: .normal)
                                    }
                                } else {
                                    self.viewTabDangGiao.viewCMNDTruocButton41.image = UIImage(named: "AddImage51")
                                }
                                if let res = response {
                                    self.showPopup(with: res.message, completion: nil)
                                }
                            }
                        }
                    }
                }
            }
           
        }
        
        if(self.mPic3 == true)
        {
            self.viewTabDangGiao.viewCMNDTruocButton5.frame.origin.x = self.viewTabDangGiao.viewImagePic3.frame.width / 4
            self.viewTabDangGiao.viewCMNDTruocButton5.frame.size.width =  self.viewTabDangGiao.viewImagePic3.frame.width / 2
            self.viewTabDangGiao.viewCMNDTruocButton5.frame.size.height = self.viewTabDangGiao.viewImagePic3.frame.height
            self.viewTabDangGiao.viewCMNDTruocButton5.contentMode = UIView.ContentMode.scaleToFill

            self.viewTabDangGiao.viewCMNDTruocButton5.image = image
            //self.viewTabDangGiao.btnXacNhan.setTitle("Thu Tiền KH", for: .normal)
            self.viewTabDangGiao.btnXacNhan.setTitle("Chữ ký khách hàng", for: .normal)
            ////upload Image
            let imageDataPic1:NSData = self.viewTabDangGiao.viewCMNDTruocButton5.image!.jpegData(compressionQuality: Helper.resizeImageValueFF)! as NSData
            let strBase64Pic1 = imageDataPic1.base64EncodedString(options: .endLineWithLineFeed)
            self.getDataUpAnh_GHTNResul(SoSO: "\((mObjectData?.DocEntry)!)",FileName: "_ios.jpg",Base64String: "\(strBase64Pic1)",UserID: "\((Helper.getUserName()!))",KH_Latitude: "\((mObjectData?.FinishLatitude)!)",KH_Longitude: "\((mObjectData?.FinishLongitude)!)",Type: "3")
            
            self.mPic3 = false
        }
        // image is our desired image
        
        
        
        
        picker.dismiss(animated: true, completion: nil)
        if(self.mAddedImage < 3)
        {
            self.mAddedImage += 1
        }
        
    }
    
    
    func tapSigning() {
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
//        let nav = UINavigationController(rootViewController: signatureVC)
//        present(nav, animated: true, completion: nil)
         self.navigationController?.pushViewController(signatureVC, animated: true)
    }
    
    
    func epSignature(_: EPSignatureViewController, didCancel error : NSError) {
        print("User canceled")
        
        _ = self.navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
    }
    
    func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect) {
        
        let width = mKyThuatChuKyView.mViewImage.frame.size.width - Common.Size(s:10)
        let mHeight = mKyThuatChuKyView.mViewImage.frame.size.height
        
        mKyThuatChuKyView.mViewImage.subviews.forEach { $0.removeFromSuperview() }
        mKyThuatChuKyView.mImageSign  = UIImageView(frame: CGRect(x:  Common.Size(s:5), y: Common.Size(s:5), width: width, height: mHeight))
        //        imgViewSignature.backgroundColor = .red
        mKyThuatChuKyView.mImageSign.contentMode = .scaleAspectFit
        mKyThuatChuKyView.mViewImage.addSubview(mKyThuatChuKyView.mImageSign)
        mKyThuatChuKyView.mImageSign.image = cropImage(image: signatureImage, toRect: boundingRect)
        
        mKyThuatChuKyView.mViewImage.frame.size.height =  mKyThuatChuKyView.mImageSign.frame.size.height + mKyThuatChuKyView.mImageSign.frame.origin.y + Common.Size(s:5)
        mKyThuatChuKyView.mViewImage.frame.size.height =  mKyThuatChuKyView.mImageSign.frame.origin.y + mKyThuatChuKyView.mImageSign.frame.size.height
        
        let imageDataPic1:NSData = self.mKyThuatChuKyView.mImageSign.image!.jpegData(compressionQuality: Helper.resizeImageValueFF)! as NSData
        
        
        
        strBase64Signed = imageDataPic1.base64EncodedString(options: .endLineWithLineFeed)
        
        _ = self.navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
        
        
    }
    
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
    
    
    @objc func UploadChuKiKhachHang()
    {
        if(strBase64Signed == "")
        {
            Toast.init(text: "Vui lòng kí tên trước khi hoàn tất").show()
            return
        }
        else
        {
            //            GetDataUploadChuKi(Docentry: "\((mObjectData?.DocEntry)!)",DiviceType:"2",CustomerSignature:"\(strBase64Signed)",Deliverer:"\(Helper.getUserName()!) - \(Helper.getEmployeeName()!)",Stockkeeper:"" ,Accountant:"")
            
            GetDataUploadChuKi(Docentry: "\((mObjectData?.DocEntry)!)",DiviceType:"2",CustomerSignature:"\(strBase64Signed)",Deliverer:"\(Cache.user!.UserName) - \(Cache.user!.EmployeeName)",Stockkeeper:"" ,Accountant:"")
        }
        
    }
    @objc func actionInputOTP(){
        if(mObjectData!.is_fado == "true"){
            showInputDialog(title: "Nhập mã OTP !",
                            subtitle: "Vui lòng nhập mã OTP",
                            actionTitle: "Xác nhận",
                            cancelTitle: "Cancel",
                            inputPlaceholder: " Vui lòng nhập mã OTP",
                            inputKeyboardType: UIKeyboardType.default, actionHandler:
                                { (input:String?) in
                                    print("The pass input is \(input ?? "")")
                                    // call api
                                    //self.checkAPIPassCode(pass: input!)
                                    if(input == ""){
                                        //self.showInputDialog(message: "Vui lòng nhập mã OTP!")
                                        Toast.init(text: "Vui lòng nhập mã OTP!").show()
                                        
                                        return
                                    }
                                    if(self.mObjectData!.otp_fado == input){
                                        self.UploadChuKiKhachHang()
                                    }else{
                                        //  self.showInputDialog(message: "Mã OTP không hợp lệ!")
                                        Toast.init(text: "Mã OTP không hợp lệ!").show()
                                        
                                        return
                                    }
                                    
                                })
        }else{
            self.UploadChuKiKhachHang()
        }
        
    }

//    @objc func actionInputOTP(){
//        if(mObjectData!.is_fado == "true"){
//            showInputDialog(title: "Nhập mã OTP !",
//                            subtitle: "Vui lòng nhập mã OTP",
//                            actionTitle: "Xác nhận",
//                            cancelTitle: "Cancel",
//                            inputPlaceholder: " Vui lòng nhập mã OTP",
//                            inputKeyboardType: UIKeyboardType.default)
//            { (input:String?) in
//                print("The pass input is \(input ?? "")")
//                // call api
//                //self.checkAPIPassCode(pass: input!)
//                if(input == ""){
//                    //self.showInputDialog(message: "Vui lòng nhập mã OTP!")
//                      Toast.init(text: "Vui lòng nhập mã OTP!").show()
//
//                    return
//                }
//                if(self.mObjectData!.otp_fado == input){
//                    self.UploadChuKiKhachHang()
//                }else{
//                  //  self.showInputDialog(message: "Mã OTP không hợp lệ!")
//                       Toast.init(text: "Mã OTP không hợp lệ!").show()
//
//                    return
//                }
//
//            }
//        }else{
//            self.UploadChuKiKhachHang()
//        }
//
//    }

    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
            textField.isSecureTextEntry = false
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /** func UPloadHinh **/
    
    func GetDataUploadChuKi(Docentry: String,DiviceType:String,CustomerSignature:String,Deliverer:String,Stockkeeper:String ,Accountant:String)
    {
        self.showProcessView(mShow: true)
        //
        MDeliveryAPIService.GetDataGoogleAPIRoute(mLatUser: "\(self.mObjectData!.FinishLatitude)", mLongUser: "\(self.mObjectData!.FinishLongitude)", mLat: "\(self.userLat)",mLong: "\(self.userLong)",SO:"\(mObjectData!.DocEntry)"){ (error: Error? , success: Bool,result: String!,resultDistance: String!,resultDuration: String!)  in
            if success
            {
                if(resultDistance != nil && resultDistance != "" && resultDistance != "null" )
                {
               
                    MDeliveryAPIService.GiaoNhan_CallUpHinhChuKi(Docentry: Docentry,DiviceType:DiviceType,CustomerSignature:CustomerSignature,Deliverer:Deliverer,Stockkeeper:Stockkeeper ,Accountant:Accountant,KH_Latitude:"\(self.userLat)",KH_Longitude:"\(self.userLong)",khoangcach:"\(resultDistance!)"){ (error: Error? , success: Bool,result: GenImage_Confirm_DeliverResult!) in
                          self.showProcessView(mShow: false)
                          if success
                          {
                              
                              if(result != nil  )
                              {
                                self.lineViewMoTaLoi.isHidden = false
                                self.lineViewThongTin.isHidden = true
//                                self.lineViewPhuKien.isHidden = true
                                self.viewTabDaNhan.isHidden = true
                                self.viewTabDangGiao.isHidden = true
                                self.viewTabDaGiao.isHidden = false
                                self.navigationItem.hidesBackButton = true
                                self.typePush = 0
                                self.canChange = true
                                self.mKyThuatChuKyView.isHidden = true
                                self.getDataSOByUser(p_UserID: "\(Cache.user!.UserName)")
                                  Toast.init(text: "\(result.Message)").show()
                              }
                              else
                              {
                                  print("Không tìm thấy kết quả trả về")
                                  Toast(text: "Không tìm thấy kết quả trả về code : GenImage_Confirm_Deliver ").show()
                              }
                          }
                          else
                          {
                              Toast(text: "Kết nối vs API thất bại code : GenImage_Confirm_Deliver").show()
                              print("kết nối vs API thất bại")
                          }
                          
                          
                          
                      }
                    
                    
                }
                else
                {
                    MDeliveryAPIService.GiaoNhan_CallUpHinhChuKi(Docentry: Docentry,DiviceType:DiviceType,CustomerSignature:CustomerSignature,Deliverer:Deliverer,Stockkeeper:Stockkeeper ,Accountant:Accountant,KH_Latitude:"\(self.userLat)",KH_Longitude:"\(self.userLong)",khoangcach:"0"){ (error: Error? , success: Bool,result: GenImage_Confirm_DeliverResult!) in
                          self.showProcessView(mShow: false)
                          if success
                          {
                              
                              if(result != nil  )
                              {
                                  self.lineViewMoTaLoi.isHidden = false
                                  self.lineViewThongTin.isHidden = true
//                                  self.lineViewPhuKien.isHidden = true
                                  self.viewTabDaNhan.isHidden = true
                                  self.viewTabDangGiao.isHidden = true
                                  self.viewTabDaGiao.isHidden = false
                                  self.navigationItem.hidesBackButton = true
                                  self.typePush = 0
                                  self.canChange = true
                                  self.mKyThuatChuKyView.isHidden = true
                                 self.getDataSOByUser(p_UserID: "\(Cache.user!.UserName)")
                                  Toast.init(text: "\(result.Message)").show()
                              }
                              else
                              {
                                  print("Không tìm thấy kết quả trả về")
                                  Toast(text: "Không tìm thấy kết quả trả về code : GenImage_Confirm_Deliver ").show()
                              }
                          }
                          else
                          {
                              Toast(text: "Kết nối vs API thất bại code : GenImage_Confirm_Deliver").show()
                              print("kết nối vs API thất bại")
                          }
                          
                          
                          
                      }
                    
                }
                
            }
            else
            {
                MDeliveryAPIService.GiaoNhan_CallUpHinhChuKi(Docentry: Docentry,DiviceType:DiviceType,CustomerSignature:CustomerSignature,Deliverer:Deliverer,Stockkeeper:Stockkeeper ,Accountant:Accountant,KH_Latitude:"\(self.userLat)",KH_Longitude:"\(self.userLong)",khoangcach:"0"){ (error: Error? , success: Bool,result: GenImage_Confirm_DeliverResult!) in
                      self.showProcessView(mShow: false)
                      if success
                      {
                          
                          if(result != nil  )
                          {
                              self.lineViewMoTaLoi.isHidden = false
                              self.lineViewThongTin.isHidden = true
//                              self.lineViewPhuKien.isHidden = true
                              self.viewTabDaNhan.isHidden = true
                              self.viewTabDangGiao.isHidden = true
                              self.viewTabDaGiao.isHidden = false
                              self.navigationItem.hidesBackButton = true
                              self.typePush = 0
                              self.canChange = true
                              self.mKyThuatChuKyView.isHidden = true
                              Toast.init(text: "\(result.Message)").show()
                          }
                          else
                          {
                              print("Không tìm thấy kết quả trả về")
                              Toast(text: "Không tìm thấy kết quả trả về code : GenImage_Confirm_Deliver ").show()
                          }
                      }
                      else
                      {
                          Toast(text: "Kết nối vs API thất bại code : GenImage_Confirm_Deliver").show()
                          print("kết nối vs API thất bại")
                      }
                      
                      
                      
                  }
                
                
            }
            
            
            
        }
        //
  
        
    }
    
}
