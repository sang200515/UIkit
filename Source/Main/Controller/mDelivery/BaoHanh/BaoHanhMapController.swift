//
//  BaoHanhMapController.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import MapKit
//import EPSignature
import PopupDialog
import GoogleMaps
import CoreLocation

class BaoHanhMapController: UIViewController ,CLLocationManagerDelegate, MKMapViewDelegate ,EPSignatureDelegate , GMSMapViewDelegate,UITextFieldDelegate{
    
    var listChecking:[String] = []
    var mMaNoiGN:String = ""
    var mListGiao:String = ""
    var mListNhan:String = ""
    var mListGiaoNhan:String = ""
    //mpic one = ảnh đính kèm
    //mpic two = ảnh chu ki nv hang
    //mpic three = ảnh chu ki nv shop
    var mPicOne:Bool = false
    var mPicTwo:Bool = false
    var mPicThree:Bool = false
    var mNumPic = 2
    var mSLGiao:Int = 0
    var mSLNhan:Int = 0
    var mShortestLat:String = ""
    var mShortestLong:String = ""
    var mChoosenLat:String = ""
    var mChoosenLong:String = ""
    var userGlobal: UserDefaults!
    var slPhanCong:Int = 0
    var processView:ProcessView!
    
    var arrayDataOrigin:[AllNhanVienPhanCong_MobileResult] = [AllNhanVienPhanCong_MobileResult]()
    
    var arrayDiaChiByUser:[AllNhanVienPhanCong_MobileResult] = [AllNhanVienPhanCong_MobileResult]()
    var arrayDiaChiByUserShorted:[AllNhanVienPhanCong_MobileResult] = [AllNhanVienPhanCong_MobileResult]()
    var arrayDiaChiByUserShortedFromShop:[AllNhanVienPhanCong_MobileResult] = [AllNhanVienPhanCong_MobileResult]()
    var annotationArray:[CustomAnnocation] = [CustomAnnocation]()
    var locationManager = CLLocationManager()
    var baohanhMapView:BaoHanhMapView!
    var userLat:Double = 0
    var userLong:Double = 0
    var statedLat:String = "0"
    var statedLong:String = "0"
    var locManager = CLLocationManager()
    var numUPLoadImage:Int = 0
    var userName:String = ""
    var employeeName:String = ""
    var mLinkHinhAnh:String = ""
    var mLinkChuKy:String = ""
    var mLinkChuKyGiaoNhan:String = ""
    
    var isLoginNew:Bool = true
    var mDiemDauSave:String = ""
    
    var isHang:Bool = false
    
    var mDoDai:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userGlobal = UserDefaults()
         self.navigationController?.navigationBar.tintColor  = UIColor.white
        //////
        let btLeftIcon = UIButton.init(type: .custom)
        btLeftIcon.setImage(UIImage(named:"report"), for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(BaoHanhMapController.actionRightButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.rightBarButtonItems = [barLeft]
        
        
        baohanhMapView = BaoHanhMapView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.view.addSubview(baohanhMapView)
        
        
        let TapXemBanDo = UITapGestureRecognizer(target: self, action: #selector(BaoHanhMapController.tapXemBanDo))
        baohanhMapView.txtXemBanDo.isUserInteractionEnabled = true
        baohanhMapView.txtXemBanDo.addGestureRecognizer(TapXemBanDo)
        // Do any additional setup after loading the view.
        
        
        let TapXemChiTietGiao = UITapGestureRecognizer(target: self, action: #selector(BaoHanhMapController.tapXemChiTietPBHGiao))
        baohanhMapView.txtChiTietPHBGiao.isUserInteractionEnabled = true
        baohanhMapView.txtChiTietPHBGiao.addGestureRecognizer(TapXemChiTietGiao)
        
        let TapXemChiTietNhan = UITapGestureRecognizer(target: self, action: #selector(tapXemChiTietPBHNhan))
        baohanhMapView.txtChiTietPHBNhan.isUserInteractionEnabled = true
        baohanhMapView.txtChiTietPHBNhan.addGestureRecognizer(TapXemChiTietNhan)
        
        
        baohanhMapView.mapKit.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        baohanhMapView.mapKit.showsUserLocation = true
        
        let userDefaults : UserDefaults = UserDefaults.standard
        if (userDefaults.object(forKey: "mDiemDau") != nil){
            
            mDiemDauSave = (UserDefaults.standard.object(forKey: "mDiemCuoi") as? String)!
        }
        
        userName = Cache.user!.UserName
        employeeName = Cache.user!.EmployeeName
        
        baohanhMapView.txtName.text = "\(userName)-\(employeeName)"
        let employeeShop = Cache.user!.ShopName
        baohanhMapView.txtShop.text = "\(employeeShop)"
        
        GetDataLocationByUser(p_User: "\(userName)",p_Loai : "-1")
        self.hideKeyboardWhenTappedAround()
        
        
        baohanhMapView.btnXacNhan.addTarget(self, action: #selector(self.ClickXacNhan), for: .touchUpInside)
        baohanhMapView.btnDoiLoTrinh.addTarget(self, action: #selector(self.DrawPoliRoute), for: .touchUpInside)
        
        
        let tapSigning = UITapGestureRecognizer(target: self, action: #selector(self.tapSigning))
        baohanhMapView.viewImageSign.isUserInteractionEnabled = true
        baohanhMapView.viewImageSign.addGestureRecognizer(tapSigning)
        
        let tapSigningThuKho = UITapGestureRecognizer(target: self, action: #selector(self.tapSigning))
        baohanhMapView.viewImageSignThuKho.isUserInteractionEnabled = true
        baohanhMapView.viewImageSignThuKho.addGestureRecognizer(tapSigningThuKho)
        
        
        let tapChoosenPic = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImagePick1))
        baohanhMapView.viewImagePic.isUserInteractionEnabled = true
        baohanhMapView.viewImagePic.addGestureRecognizer(tapChoosenPic)
        
        processView = ProcessView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height ))
        self.view.addSubview(processView)
        processView.isHidden = true
        
        
        userLat = (locManager.location?.coordinate.latitude)!
        userLong = (locManager.location?.coordinate.longitude)!
        
        GetUserLocationToMap()
        tapXemBanDo()
        
        
        
        baohanhMapView.companyButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.baohanhMapView.companyButton.text = item.title
            for i in 0 ..< self.arrayDataOrigin.count
            {
                if("\(self.arrayDataOrigin[i].Ten)" == item.title ||
                    "\(self.arrayDataOrigin[i].Ten)." == item.title)
                {
                    
                }
            }
            
            
        }
        
        
        baohanhMapView.company2Button.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.baohanhMapView.company2Button.text = item.title
            for i in 0 ..< self.arrayDataOrigin.count
            {
                if("\(self.arrayDataOrigin[i].Ten)" == item.title || "\(self.arrayDataOrigin[i].Ten)." == item.title)
                {
                    print("\(self.arrayDataOrigin[i].NoiPhanCong) \(self.arrayDataOrigin[i].mTimeExpected)")
                    
                    var mUserPhanCong = ""
                    if(self.arrayDataOrigin[i].NoiPhanCong == "5" || self.arrayDataOrigin[i].NoiPhanCong == "6" || self.arrayDataOrigin[i].NoiPhanCong == "7")
                    {
                        mUserPhanCong = "\(self.userName)"
                    }
                    self.GetSoPhieuGiaoNhan(p_MaNoiGN: self.arrayDataOrigin[i].NoiPhanCong, p_UserPhanCong: "\(mUserPhanCong)")
                    self.mMaNoiGN = "\(self.arrayDataOrigin[i].NoiPhanCong)"
                    if(self.arrayDataOrigin[i].MaPhanBiet == "H")
                    {
                        self.baohanhMapView.viewChuKy.isHidden = false
                        self.baohanhMapView.viewThuKho.isHidden = true
                        self.hideViewChuKi(mType: false)
                        self.hideViewThuKho(mType: true)
                       
                        self.mNumPic = 2
                        self.isHang = true
                        
                    }
                    else if(self.arrayDataOrigin[i].MaPhanBiet == "F")
                    {
                        self.baohanhMapView.viewChuKy.isHidden = true
                        self.baohanhMapView.viewThuKho.isHidden = true
                        self.hideViewChuKi(mType: true)
                        self.hideViewThuKho(mType: true)
                        
                        self.mNumPic = 0
                        self.isHang = false
                        
                    }
                    else
                    {
                        self.baohanhMapView.viewChuKy.isHidden = true
                        self.baohanhMapView.viewThuKho.isHidden = false
                        self.hideViewChuKi(mType: true)
                        self.hideViewThuKho(mType: false)
                        self.mNumPic = 1
                        self.isHang = false
                    }
                    
                    return
                }
            }
            
            
        }
        
        self.baohanhMapView.mapView.delegate = self
        self.baohanhMapView.edtGhiChu.delegate = self
        self.baohanhMapView.mapView?.isMyLocationEnabled = true
        self.baohanhMapView.mapView.settings.myLocationButton = true
        self.baohanhMapView.mapView.settings.compassButton = true
        self.baohanhMapView.mapView.settings.zoomGestures = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
            
        case 1:
            view.endEditing(true)
            
        default: break
        }
    }
    
    
    
    
    func hideViewChuKi(mType:Bool)
    {
        if(!mType)
        {
            self.baohanhMapView.viewChuKy.frame.size.height = 500
            print("height \(self.baohanhMapView.viewChuKy.frame.size.height)")
            self.baohanhMapView.txtGhiChu.frame.origin.y = self.baohanhMapView.viewChuKy.frame.origin.y +  self.baohanhMapView.viewChuKy.frame.size.height + Common.Size(s:5)
            self.baohanhMapView.edtGhiChu.frame.origin.y = self.baohanhMapView.txtGhiChu.frame.origin.y + self.baohanhMapView.txtGhiChu.frame.size.height + Common.Size(s:5)
            self.baohanhMapView.btnXacNhan.frame.origin.y = self.baohanhMapView.edtGhiChu.frame.size.height + self.baohanhMapView.edtGhiChu.frame.origin.y + Common.Size(s:10)
            
        }
        else
        {
            self.baohanhMapView.viewChuKy.frame.size.height = 0
            print("height \(self.baohanhMapView.viewChuKy.frame.size.height)")
            self.baohanhMapView.txtGhiChu.frame.origin.y = self.baohanhMapView.viewThuKho.frame.origin.y +  self.baohanhMapView.viewThuKho.frame.size.height + Common.Size(s:5)
            self.baohanhMapView.edtGhiChu.frame.origin.y = self.baohanhMapView.txtGhiChu.frame.origin.y + self.baohanhMapView.txtGhiChu.frame.size.height + Common.Size(s:5)
            self.baohanhMapView.btnXacNhan.frame.origin.y = self.baohanhMapView.edtGhiChu.frame.size.height + self.baohanhMapView.edtGhiChu.frame.origin.y + Common.Size(s:10)
        }
      
        
    }
    
    func hideViewThuKho(mType:Bool)
    {
        if(!mType)
        {
            self.baohanhMapView.viewThuKho.frame.size.height = 350
            print("height \(self.baohanhMapView.viewThuKho.frame.size.height)")
            self.baohanhMapView.txtGhiChu.frame.origin.y = self.baohanhMapView.viewThuKho.frame.origin.y +  self.baohanhMapView.viewThuKho.frame.size.height + Common.Size(s:5)
            self.baohanhMapView.edtGhiChu.frame.origin.y = self.baohanhMapView.txtGhiChu.frame.origin.y + self.baohanhMapView.txtGhiChu.frame.size.height + Common.Size(s:5)
            self.baohanhMapView.btnXacNhan.frame.origin.y = self.baohanhMapView.edtGhiChu.frame.size.height + self.baohanhMapView.edtGhiChu.frame.origin.y + Common.Size(s:10)
            
        }
        else
        {
            self.baohanhMapView.viewThuKho.frame.size.height = 0
            print("height \(self.baohanhMapView.viewThuKho.frame.size.height)")
            self.baohanhMapView.txtGhiChu.frame.origin.y = self.baohanhMapView.viewChuKy.frame.origin.y +  self.baohanhMapView.viewChuKy.frame.size.height + Common.Size(s:5)
            self.baohanhMapView.edtGhiChu.frame.origin.y = self.baohanhMapView.txtGhiChu.frame.origin.y + self.baohanhMapView.txtGhiChu.frame.size.height + Common.Size(s:5)
            self.baohanhMapView.btnXacNhan.frame.origin.y = self.baohanhMapView.edtGhiChu.frame.size.height + self.baohanhMapView.edtGhiChu.frame.origin.y + Common.Size(s:10)
        }
       
        
    }
    
    
    
    
    
    @objc func DrawPoliRoute()
    {
        self.baohanhMapView.mapView.clear()
        if(self.baohanhMapView.companyButton.text != "" && self.baohanhMapView.company2Button.text != "" )
        {
            var pointALat:Double = 0
            var pointALong:Double = 0
            var pointBLat:Double = 0
            var pointBLong:Double = 0
            ////tim duong
            for i in 0 ..< self.arrayDataOrigin.count
            {
                if("\(self.arrayDataOrigin[i].Ten)" == self.baohanhMapView.companyButton.text || "\(self.arrayDataOrigin[i].Ten)." == self.baohanhMapView.companyButton.text)
                {
                    pointALat = self.arrayDataOrigin[i].Latitude
                    pointALong = self.arrayDataOrigin[i].Longitude
                }
            }
            for i in 0 ..< self.arrayDataOrigin.count
            {
                if("\(self.arrayDataOrigin[i].Ten)" == self.baohanhMapView.company2Button.text || "\(self.arrayDataOrigin[i].Ten)." == self.baohanhMapView.company2Button.text)
                {
                    pointBLat = self.arrayDataOrigin[i].Latitude
                    pointBLong = self.arrayDataOrigin[i].Longitude
                }
            }
            CallGoogleApiToGetRoute(mLatUser: "\(pointALat)", mLongUser: "\(pointALong)", mLat: "\(pointBLat)", mLong: "\(pointBLong)", mIndex: 0,SO:"")
            
            
            let markerA = GMSMarker()
            markerA.position = CLLocationCoordinate2D(latitude: pointALat, longitude: pointALong)
            markerA.map =  baohanhMapView.mapView
            
            let markerB = GMSMarker()
            markerB.position = CLLocationCoordinate2D(latitude: pointBLat, longitude: pointBLong)
            markerB.map =  baohanhMapView.mapView
            
            let mCamera = GMSCameraPosition.camera(withLatitude: pointALat, longitude: pointALong, zoom: 13.0)
            baohanhMapView.mapView.camera = mCamera
            let marker = GMSMarker()
            marker.map =  baohanhMapView.mapView
        }
        
    }
    
    
    func AddListToSpinner1(mArray:[AllNhanVienPhanCong_MobileResult])
    {
        
        var listCom: [String] = []
        for item in mArray {
            if(item.DiemDanhDau == "1")
            {
                listCom.append("\(item.Ten).")
            }
            else
            {
                
            }
        }
        for item in mArray {
            if(item.DiemDanhDau == "1")
            {
                
            }
            else
            {
                if(item.Loai == "1")
                {
                    listCom.append("\(item.Ten).")
                }
                else
                {
                    listCom.append("\(item.Ten)")
                }
            }
        }
        
        
        self.baohanhMapView.companyButton.theme.font = UIFont.systemFont(ofSize: 15)
        self.baohanhMapView.companyButton.filterStrings(listCom)
        self.baohanhMapView.companyButton.text = listCom[0]
        
        if(self.mDiemDauSave != "" && self.isLoginNew == true)
        {
            self.baohanhMapView.companyButton.text = self.mDiemDauSave
        }
        
        
    }
    
    
    
    func AddListToSpinner2(mArray:[AllNhanVienPhanCong_MobileResult])
    {
        var listCom: [String] = []
        for item in mArray {
            if(item.Loai == "1" )
            {
                listCom.append("\(item.Ten).")
            }
            else
            {
                listCom.append("\(item.Ten)")
            }
        }
        
        
        
       
        outer:for item in mArray {
            if(item.Ten != self.baohanhMapView.companyButton.text && "\(item.Ten)." != self.baohanhMapView.companyButton.text)
            {
                
                if(item.Is_CheckIn == "0" && item.Loai == "1" )
                {
                    if(listChecking.count > 0)
                    {
                        outer2:for iItem in listChecking {
                            if("\(item.Ten)." != iItem && "\(item.Ten)" != iItem)
                            {
                                self.baohanhMapView.company2Button.text = "\(item.Ten)."
                                print("item.Tenset \(item.Ten) - \(iItem)")
                                break outer2
                            }
                            
                        }
                      
                       
                    }
                    else
                    {
                        self.baohanhMapView.company2Button.text = "\(item.Ten)."
                        break outer
                    }
                    break outer
                    
                }
                else
                {
                    
                }
            }
            
        }
        
        
        
        
        
        for i in 0 ..< mArray.count
        {
            print("vao aaaday\(mArray[i].Ten)")
            if("\(mArray[i].Ten)" == self.baohanhMapView.company2Button.text || "\(mArray[i].Ten)." == self.baohanhMapView.company2Button.text)
            {
                print("vao aaaday\(mArray[i].Ten)")
                var mUserPhanCong = ""
                if(mArray[i].NoiPhanCong == "5" || mArray[i].NoiPhanCong == "6" || mArray[i].NoiPhanCong == "7")
                {
                    mUserPhanCong = "\(self.userName)"
                }
                GetSoPhieuGiaoNhan(p_MaNoiGN: mArray[i].NoiPhanCong, p_UserPhanCong: "\(mUserPhanCong)")
                self.mMaNoiGN = "\(mArray[i].NoiPhanCong)"
                
                if(mArray[i].MaPhanBiet == "H")
                {
                    self.baohanhMapView.viewChuKy.isHidden = false
                    self.baohanhMapView.viewThuKho.isHidden = true
                    self.hideViewChuKi(mType: false)
                    self.hideViewThuKho(mType: true)
                    
                    self.mNumPic = 2
                    self.isHang = true
                    
                }
                else if(mArray[i].MaPhanBiet == "F")
                {
                    self.baohanhMapView.viewChuKy.isHidden = true
                    self.baohanhMapView.viewThuKho.isHidden = true
                    self.hideViewChuKi(mType: true)
                    self.hideViewThuKho(mType: true)
                    
                    self.mNumPic = 0
                    self.isHang = false
                    
                }
                else
                {
                    self.baohanhMapView.viewChuKy.isHidden = true
                    self.baohanhMapView.viewThuKho.isHidden = false
                    self.hideViewChuKi(mType: true)
                    self.hideViewThuKho(mType: false)
                    self.mNumPic = 1
                    self.isHang = false
                }
                
                
                break
                
            }
        }
        self.baohanhMapView.company2Button.theme.font = UIFont.systemFont(ofSize: 15)
        self.baohanhMapView.company2Button.filterStrings(listCom)
        
        self.baohanhMapView.company2Button.hideResultsList()
        
    }
    
    func CheckXacNhan()->Bool
    {
        if(baohanhMapView.company2Button.text == "" || baohanhMapView.txtGhiChu.text == "")
        {
            ShowDialog(mMess: "Vui Lòng Chọn Điểm Đến")
            self.baohanhMapView.btnXacNhan.isHidden = false
            return false
            
        }
        else if (baohanhMapView.edtGhiChu.text == "" && self.baohanhMapView.RADIO_CHOSSEN_KHAC == true)
        {
            ShowDialog(mMess: "Vui Lòng Nhập Ghi Chú")
            self.baohanhMapView.btnXacNhan.isHidden = false
            return false
        }
        else if (self.mSLGiao != 0 && self.baohanhMapView.RADIO_CHOSSEN_GIAO == false && self.baohanhMapView.RADIO_CHOSSEN_KHAC == false)
        {
            ShowDialog(mMess: "Vui Lòng Click Giao")
            self.baohanhMapView.btnXacNhan.isHidden = false
            return false
        }
        else if (self.mSLNhan != 0 && self.baohanhMapView.RADIO_CHOSSEN_NHAN == false && self.baohanhMapView.RADIO_CHOSSEN_KHAC == false)
        {
            ShowDialog(mMess: "Vui Lòng Click Nhận")
            self.baohanhMapView.btnXacNhan.isHidden = false
            return false
        }
        else if (self.mSLNhan == 0 && self.baohanhMapView.RADIO_CHOSSEN_NHAN == true )
        {
            ShowDialog(mMess: "Vui Lòng Bỏ Click Nhận")
            self.baohanhMapView.btnXacNhan.isHidden = false
            return false
        }
        else if (self.mSLGiao == 0 && self.baohanhMapView.RADIO_CHOSSEN_GIAO == true )
        {
            ShowDialog(mMess: "Vui Lòng Bỏ Click Giao")
            self.baohanhMapView.btnXacNhan.isHidden = false
            return false
        }
        else if (self.mSLNhan == 0 && self.mSLGiao == 0  && self.baohanhMapView.RADIO_CHOSSEN_KHAC == false)
        {
            ShowDialog(mMess: "Vui Lòng Click Khác")
            self.baohanhMapView.btnXacNhan.isHidden = false
            return false
        }
        else
        {
            return true
        }
        
    }
    
    
    @objc func ClickXacNhan()
    {
        let mCheck:Bool = CheckXacNhan()
        
        if(mCheck == false)
        {
            return
        }
        else
        {
            self.statedLat = "\((locManager.location?.coordinate.latitude)!)"
            self.statedLong = "\((locManager.location?.coordinate.longitude)!)"
            for i in 0 ..< self.arrayDataOrigin.count
            {
                if("\(self.arrayDataOrigin[i].Ten)" == self.baohanhMapView.company2Button.text
                    || "\(self.arrayDataOrigin[i].Ten)." == self.baohanhMapView.company2Button.text)
                {
                    self.mChoosenLat = "\(self.arrayDataOrigin[i].Latitude)"
                    self.mChoosenLong = "\(self.arrayDataOrigin[i].Longitude)"
                    if(self.baohanhMapView.company2Button.text?.contains(".") == false && self.baohanhMapView.RADIO_CHOSSEN_KHAC == false)
                    {
                        self.ShowDialog(mMess: "Địa điểm bạn chọn không nằm trong phân công, vui lòng chọn KHÁC")
                        return
                    }
                }
                
                if("\(self.arrayDataOrigin[i].Ten)" == self.baohanhMapView.companyButton.text
                    || "\(self.arrayDataOrigin[i].Ten)." == self.baohanhMapView.companyButton.text)
                {
//                    self.statedLat = "\(self.arrayDataOrigin[i].Latitude)"
//                    self.statedLong = "\(self.arrayDataOrigin[i].Longitude)"
                    
                }
                
                
            }
            self.baohanhMapView.btnXacNhan.isHidden = true
            self.CallGoogleApiToGetTimeChooseLocation(mLatUser: "\(self.statedLat)", mLongUser: "\(self.statedLong)", mLat:"\(self.mChoosenLat)",mLong:"\(self.mChoosenLong)",SO:"")
            
            
            
            
        }
        
    }
    
    
    func ClickDoiLoTrinh()
    {
        if(self.arrayDiaChiByUserShorted.count > 0)
        {
            self.AddListToSpinner1(mArray:self.arrayDiaChiByUserShorted)
        }
        if(self.arrayDiaChiByUserShortedFromShop.count > 0)
        {
            self.AddListToSpinner2(mArray:self.arrayDiaChiByUserShortedFromShop)
        }
        
        
    }
    
    
    func Checkin(p_DiemDen:String ,p_DiemBatDau:String ,p_DoDai:String,p_Note:String,p_ListGiao:String,p_ListNhan:String,p_SLGiao:String,p_SLNhan:String,p_Latitude:String,p_Longitude:String,p_UserCode:String,p_Action:String,p_TypeDevice:String,p_LinkHinhAnhXacNhan:String,p_LinkChuKy:String,p_Type:String,p_UserCode_XN:String,p_LinkHinhAnhChuKyGiaoNhan:String)
    {
        self.processView.isHidden = false
       // var mSubString:String = ""
        var mDouble:Double = 0.0
        var mString:String = ""
        if(p_DoDai != "")
        {
            
            mDouble = round(Double("\(p_DoDai)")!) / 1000
            mString = "\(mDouble)"
            print("dodaimString \(mString)")
            
//            let startIndex = mString.index(mString.startIndex, offsetBy: 0)
//            let endIndex = mString.index(mString.startIndex, offsetBy: 2)
         //   mSubString = String(mString[startIndex...endIndex])
            
            
        }
        
        
        
        MDeliveryAPIService.GiaoNhan_CallCheckin(p_DiemDen:p_DiemDen ,
                                     p_DiemBatDau:p_DiemBatDau ,
                                     p_DoDai:mString,
                                     p_Note:p_Note,
                                     p_ListGiao:p_ListGiao,
                                     p_ListNhan:p_ListNhan,
                                     p_SLGiao:p_SLGiao,
                                     p_SLNhan:p_SLNhan,
                                     p_Latitude:p_Latitude,
                                     p_Longitude:p_Longitude,
                                     p_UserCode:p_UserCode,
                                     p_Action:p_Action,
                                     p_TypeDevice:"2",
                                     p_LinkHinhAnhXacNhan: p_LinkHinhAnhXacNhan,
                                     p_LinkChuKy: p_LinkChuKy,
                                     p_Type:p_Type, p_LinkHinhAnhChuKyGiaoNhan: p_LinkHinhAnhChuKyGiaoNhan, p_UserCode_XN: p_UserCode_XN){ (error: Error? , success: Bool,result: [GiaoNhan_CheckInResult]!) in
                                        if success
                                        {
                                            self.baohanhMapView.btnXacNhan.isHidden = false
                                            self.processView.isHidden = false
                                            if(result != nil && result.count > 0)
                                            {
                                                self.ShowDialog(mMess: result[0].Message)
                                                if(result[0].Result == "1")
                                                {
                                                    self.listChecking.append(self.baohanhMapView.companyButton.text!)
                                                    self.isLoginNew = false
                                                    self.ClearAllData()
                                                    self.saveDataToUserDefault()
                                                    self.baohanhMapView.edtGhiChu.text = ""
                                                    self.baohanhMapView.companyButton.text = self.baohanhMapView.company2Button.text
                                                    
                                                    self.slPhanCong = self.slPhanCong - 1
                                                    
                                                    for i in 0 ..< self.arrayDataOrigin.count
                                                    {
                                                        if("\(self.arrayDataOrigin[i].Ten)" == self.baohanhMapView.companyButton.text
                                                            || "\(self.arrayDataOrigin[i].Ten)." == self.baohanhMapView.companyButton.text)
                                                        {
                                                            self.userLat = self.arrayDataOrigin[i].Latitude
                                                            self.userLong = self.arrayDataOrigin[i].Longitude
                                                            print("checkin ok \(self.arrayDataOrigin[i].Latitude)-\(self.arrayDataOrigin[i].Longitude) \( self.userLat) \(self.userLong)")
                                                        }
                                                    }
                                                    
                                                    for i in 0 ..< self.arrayDiaChiByUserShortedFromShop.count
                                                    {
                                                        if("\(self.arrayDiaChiByUserShortedFromShop[i].Ten)" == self.baohanhMapView.company2Button.text
                                                            || "\(self.arrayDiaChiByUserShortedFromShop[i].Ten)." == self.baohanhMapView.company2Button.text)
                                                        {
                                                            self.arrayDiaChiByUserShortedFromShop.remove(at: i)
                                                            break
                                                        }
                                                    }
                                                    for i in 0 ..< self.arrayDiaChiByUser.count
                                                    {
                                                        if("\(self.arrayDiaChiByUser[i].Ten)" == self.baohanhMapView.company2Button.text
                                                            || "\(self.arrayDiaChiByUser[i].Ten)." == self.baohanhMapView.company2Button.text)
                                                        {
                                                            self.arrayDiaChiByUser.remove(at: i)
                                                            break
                                                        }
                                                    }
                                                    
                                                    self.AddListToSpinner2(mArray: self.arrayDiaChiByUserShortedFromShop)
                                                    
                                                    for i in 0 ..< self.arrayDiaChiByUserShortedFromShop.count
                                                    {
                                                        
                                                        if(self.arrayDiaChiByUserShortedFromShop[i].Longitude != 0 && self.arrayDiaChiByUserShortedFromShop[i].Latitude  != 0 && self.arrayDiaChiByUserShortedFromShop[i].Loai == "1")
                                                        {
                                                            
                                                            for j in 0 ..< self.arrayDiaChiByUser.count
                                                            {
                                                                if(self.arrayDiaChiByUserShortedFromShop[i].Ten == self.arrayDiaChiByUser[j].Ten)
                                                                {
                                                                    print("search get time Google \(self.userLat) \(self.userLong)")
                                                                    self.CallGoogleApiToGetTime(mLatUser: "\(self.userLat)", mLongUser: "\(self.userLong)", mLat:"\(self.arrayDiaChiByUserShortedFromShop[i].Latitude)",mLong:"\(self.arrayDiaChiByUserShortedFromShop[i].Longitude)", mIndex: j,mType: 1, mArrayIndex: j,SO:"")
                                                                    usleep(200000)
                                                                }
                                                                
                                                            }
                                                            
                                                            
                                                        }
                                                    }
                                                    if(self.baohanhMapView.RADIO_CHOSSEN_NHAN == true)
                                                    {
                                                        self.baohanhMapView.radioCompany.isSelected = false
                                                    }
                                                    if(self.baohanhMapView.RADIO_CHOSSEN_GIAO == true)
                                                    {
                                                        self.baohanhMapView.radioMarket.isSelected = false
                                                    }
                                                    if(self.baohanhMapView.RADIO_CHOSSEN_KHAC == true)
                                                    {
                                                        self.baohanhMapView.radioKhac.isSelected = false
                                                    }
                                                    
                                                    self.baohanhMapView.RADIO_CHOSSEN_NHAN = false
                                                    self.baohanhMapView.RADIO_CHOSSEN_KHAC = false
                                                    self.baohanhMapView.RADIO_CHOSSEN_GIAO = false
                                                    
                                                    self.tapXemBanDo()
                                                    
                                                    
                                                   
                                                }
                                                
                                            }
                                            else
                                            {
                                                self.processView.isHidden = true
                                                self.baohanhMapView.btnXacNhan.isHidden = false
                                                self.ShowDialog(mMess: "Vui lòng thử lại , có lỗi xảy ra")
                                            }
                                            
                                        }
                                        else
                                        {
                                            self.processView.isHidden = true
                                            self.baohanhMapView.btnXacNhan.isHidden = false
                                            self.ShowDialog(mMess: "Vui lòng thử lại , có lỗi xảy ra")
                                        }
        }
    }
    
    func ClearAllData()
    {
        self.mListGiao = ""
        self.mListNhan = ""
        self.mSLGiao = 0
        self.mSLNhan = 0
        self.mListNhan = ""
        self.userLat = 0
        self.userLong = 0
        self.mPicOne = false
        self.mPicTwo = false
        self.mPicThree = false
        self.mLinkHinhAnh = ""
        self.mLinkChuKy = ""
        self.statedLat = ""
        self.statedLong = ""
        self.baohanhMapView.edtThuKhoCode.text = ""
        self.baohanhMapView.viewCMNDTruocButton3.image = nil
        if(self.baohanhMapView.imageSinging != nil)
        {
           self.baohanhMapView.imageSinging.image = nil
        }
        
        self.baohanhMapView.imageSingingThuKho.image = nil
    }
    
    func saveDataToUserDefault()
    {
        UserDefaults.standard.set(self.baohanhMapView.companyButton.text, forKey : "mDiemDau")
        UserDefaults.standard.set(self.baohanhMapView.company2Button.text, forKey : "mDiemCuoi")
    }
    
    
    @objc func actionRightButton()
    {
        self.processView.isHidden = false
        //self.ShowDialog(mMess: "step 1 -> checkin -> show the shortest location")
        if(self.arrayDiaChiByUser.count > 0)
        {
            self.findShortestWayByLatAndLongFromUser(mArray: self.arrayDiaChiByUser, mType: 0,SO:"")
        }
        else
        {
            self.ShowDialog(mMess: "Chưa lấy được danh sách phân công của user này")
        }
        
        
    }
    
    func GetUserLocationToMap()
    {
        
        let mCamera = GMSCameraPosition.camera(withLatitude: userLat, longitude: userLong, zoom: 13.0)
        baohanhMapView.mapView.camera = mCamera
        let marker = GMSMarker()
        marker.map =  baohanhMapView.mapView
        
        
        
    }
    
    func findShortestWayByLatAndLongFromUser(mArray:[AllNhanVienPhanCong_MobileResult],mType :Int,SO:String)
    {
        if(mArray.count > 0)
        {
            if(mType == 0)
            {
                var mIndexInLoop:Int = 0
                print("soluong \(mArray.count) \(mType) user \(userLat) \(userLong) ")
                for i in 0 ..< mArray.count
                {
                    if(mArray[i].Longitude != 0 && mArray[i].Latitude  != 0 && mArray[i].Loai == "1")
                    {
                        mIndexInLoop += 1
                        CallGoogleApiToGetTime(mLatUser: "\(userLat)", mLongUser: "\(userLong)", mLat:"\(mArray[i].Latitude)",mLong:"\(mArray[i].Longitude)", mIndex: mIndexInLoop,mType: 0,mArrayIndex:i,SO:SO)
                        usleep(200000)
                    }
                }
            }
            else
            {
                print("soluong \(mArray.count)  \(mType) mshort \(mShortestLat) \(mShortestLong) ")
                var mIndexInLoop:Int = 0
                for i in 0 ..< mArray.count
                {
                    if(mArray[i].Longitude != 0 && mArray[i].Latitude  != 0 && mArray[i].Loai == "1" )
                    {
                        mIndexInLoop += 1
                        CallGoogleApiToGetTime(mLatUser: "\(mShortestLat)", mLongUser: "\(mShortestLong)", mLat:"\(mArray[i].Latitude)",mLong:"\(mArray[i].Longitude)", mIndex: mIndexInLoop,mType: 1,mArrayIndex:i,SO:SO)
                        usleep(200000)
                    }
                }
            }
            
            
        }
    }
    
    
    
    
    func CallGoogleApiToGetTime(mLatUser:String,mLongUser:String,mLat:String,mLong:String,mIndex:Int,mType:Int,mArrayIndex:Int,SO:String)
    {
        print("mIndexInLoop \(mIndex) slphancong \(slPhanCong)")
        MDeliveryAPIService.GetDataGoogleAPITime(mLatUser: mLatUser, mLongUser: mLongUser, mLat: mLat,mLong: mLong,SO:SO){ (error: Error? , success: Bool,result: String!) in
            if success
            {
                if(result != nil && result != "" && result != "null" )
                {
                     self.arrayDiaChiByUser[mArrayIndex].mTimeExpected = Int(result)!
                    
                }
                else
                {
                    print("Không tìm thấy kết quả \(mLat) - \(mLong) - \(mIndex)")
                    self.ShowDialog(mMess: "Nơi phân công này k có data tọa độ")
                    self.arrayDiaChiByUser[mArrayIndex].mTimeExpected = 0
                }
            }
            else
            {
                print("Không tìm thấy kết quả \(mLat) - \(mLong) - \(mIndex)")
                self.ShowDialog(mMess: "Nơi phân công này k có data tọa độ")
                self.arrayDiaChiByUser[mArrayIndex].mTimeExpected = 0
                
            }
            
            
            if(mIndex == self.slPhanCong - 1 || mIndex == self.slPhanCong)
            {
                ////find shortest way from user
                if(mType == 0)
                {
                    self.arrayDiaChiByUserShorted  = self.arrayDiaChiByUser
                    
                    var arrKPhanCong:[AllNhanVienPhanCong_MobileResult] = [AllNhanVienPhanCong_MobileResult]()
                    var arrPhanCong:[AllNhanVienPhanCong_MobileResult] = [AllNhanVienPhanCong_MobileResult]()
                    
                    for i in 0 ..< self.arrayDiaChiByUser.count
                    {
                        if(self.arrayDiaChiByUser[i].Loai == "0")
                        {
                            arrKPhanCong.append(self.arrayDiaChiByUser[i])
                        }
                        
                    }
                    for i in 0 ..< self.arrayDiaChiByUser.count
                    {
                        if(self.arrayDiaChiByUser[i].Loai == "1")
                        {
                            arrPhanCong.append(self.arrayDiaChiByUser[i])
                        }
                        
                    }
                    arrPhanCong.sort(by: {$0.Is_CheckIn < $1.Is_CheckIn})
                    arrPhanCong.sort(by: {$0.mTimeExpected < $1.mTimeExpected})
                    
                    for i in 0 ..< arrPhanCong.count
                    {
                        print("shorted  \(arrPhanCong[i].Ten)  \(arrPhanCong[i].mTimeExpected)")
                        
                    }
                    
                    self.arrayDiaChiByUserShorted.removeAll()
                    self.arrayDiaChiByUserShorted = arrPhanCong
                    for i in 0 ..< self.arrayDiaChiByUserShorted.count
                    {
                        if(self.arrayDiaChiByUserShorted[i].DiemDanhDau == "1")
                        {
                            self.mShortestLat = "\(self.arrayDiaChiByUserShorted[i].Latitude)"
                            self.mShortestLong = "\(self.arrayDiaChiByUserShorted[i].Longitude)"
                        }
                        
                    }
                    
                    
                    if(self.mShortestLat == "" && self.mShortestLong == "")
                    {
                        self.mShortestLat = "\(self.arrayDiaChiByUserShorted[0].Latitude)"
                        self.mShortestLong = "\(self.arrayDiaChiByUserShorted[0].Longitude)"
                    }
                    
                    
                    self.findShortestWayByLatAndLongFromUser(mArray: self.arrayDiaChiByUser, mType: 1,SO:"")
                    self.ClickDoiLoTrinh()
                }
                    ////find shortest way from shop
                else
                {
                    
                    
                    self.arrayDiaChiByUserShortedFromShop  = self.arrayDiaChiByUser
                    
                    var arrKPhanCong:[AllNhanVienPhanCong_MobileResult] = [AllNhanVienPhanCong_MobileResult]()
                    var arrPhanCong:[AllNhanVienPhanCong_MobileResult] = [AllNhanVienPhanCong_MobileResult]()
                    
                    for i in 0 ..< self.arrayDiaChiByUserShortedFromShop.count
                    {
                       
                        if(self.arrayDiaChiByUserShortedFromShop[i].Loai == "0" )
                                
                        {
                            arrKPhanCong.append(self.arrayDiaChiByUserShortedFromShop[i])
                        }
                        
                       
                        
                    }
                    for i in 0 ..< self.arrayDiaChiByUserShortedFromShop.count
                    {

                        if(self.arrayDiaChiByUserShortedFromShop[i].Loai == "1" )
                        {
                            arrPhanCong.append(self.arrayDiaChiByUserShortedFromShop[i])
                        }
                        
                        
                        
                    }
                    arrPhanCong.sort(by: {$0.Is_CheckIn < $1.Is_CheckIn})
                    arrPhanCong.sort(by: {$0.mTimeExpected < $1.mTimeExpected})
                    for i in 0 ..< arrPhanCong.count
                    {
                        print("shorted  \(arrPhanCong[i].Ten)  \(arrPhanCong[i].mTimeExpected)")
                        
                    }
                    
                    
                    self.arrayDiaChiByUserShortedFromShop.removeAll()
                    self.arrayDiaChiByUserShortedFromShop = arrPhanCong
                    for i in 0 ..< arrKPhanCong.count
                    {
                        self.arrayDiaChiByUserShortedFromShop.append(arrKPhanCong[i])
                    }

                    
                    self.AddListToSpinner2(mArray:self.arrayDiaChiByUserShortedFromShop)
                }
                
                
                self.processView.isHidden = true
            }else{
                 self.processView.isHidden = true
            }
        }
        
    }
    
    
    
    
    /////
    func CallGoogleApiToGetRoute(mLatUser:String,mLongUser:String,mLat:String,mLong:String,mIndex:Int,SO:String)
    {
        
        MDeliveryAPIService.GetDataGoogleAPIRoute(mLatUser: mLatUser, mLongUser: mLongUser, mLat: mLat,mLong: mLong,SO:SO){ (error: Error? , success: Bool,result: String!, resultDistance: String?, resultDuration: String?) in
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
                        polyline.map = self.baohanhMapView.mapView
                        
                    }
                }
                else
                {
                    
                }
                
            }
            else
            {
                self.ShowDialog(mMess: "Không tìm thấy kết quả")
                
            }
            
            
            
        }
        
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    @objc func tapXemChiTietPBHGiao()
    {
        let newViewController = BaoHanhChiTietPhieuController()
        newViewController.isType = "1"
        if(self.baohanhMapView.company2Button.text != "")
        {
            newViewController.pMaNoiGN = self.mMaNoiGN
            newViewController.mNameLocation = self.baohanhMapView.company2Button.text
        }
        else
        {
            newViewController.mNameLocation = ""
            newViewController.pMaNoiGN = self.mMaNoiGN
        }
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func tapXemChiTietPBHNhan()
    {
        if(self.isHang == true)
        {
            let newViewController = BaoHanhChiTietPhieuHangController()
            newViewController.mIsViewPush = "main"
            newViewController.mIsHang = "true"
            newViewController.isType = "nhan"
            if(self.baohanhMapView.company2Button.text != "")
            {
                newViewController.mNameLocation = self.baohanhMapView.company2Button.text
                newViewController.pMaNoiGN = mMaNoiGN
                newViewController.mMaCheckin = mMaNoiGN
            }
            else
            {
                newViewController.mNameLocation = ""
                newViewController.pMaNoiGN = ""
            }
            print("mMaNoiGN \(mMaNoiGN)")
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        }else
        {
            
            let newViewController = BaoHanhChiTietPhieuController()
            
            newViewController.isType = "2"
            if(self.baohanhMapView.company2Button.text != "")
            {
                newViewController.mNameLocation = self.baohanhMapView.company2Button.text
                newViewController.pMaNoiGN = mMaNoiGN
            }
            else
            {
                newViewController.mNameLocation = ""
                newViewController.pMaNoiGN = ""
            }
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
    
    @objc func tapXemBanDo()
    {
        if(self.baohanhMapView.mapKit.frame.size.height > 0)
        {
            self.baohanhMapView.mapKit.frame.size.height = 0
        }
        else
        {
            self.baohanhMapView.mapKit.frame.size.height = 200
            DrawPoliRoute()
        }
        self.baohanhMapView.viewBottom.frame.origin.y = self.baohanhMapView.mapKit.frame.origin.y + self.baohanhMapView.mapKit.frame.size.height
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /////call API
    func GetDataLocationByUser(p_User: String,p_Loai: String)
    {
        
        MDeliveryAPIService.GetLocationByUser(p_User: p_User,p_Loai: p_Loai){ (error: Error? , success: Bool,result: [AllNhanVienPhanCong_MobileResult]!) in
            if success
            {
                if(result != nil && result.count > 0 )
                {
                    self.slPhanCong = 0
                    self.arrayDataOrigin = result
                    self.arrayDiaChiByUser = result
                    self.arrayDiaChiByUserShorted = result
                    if(self.arrayDiaChiByUserShorted.count > 0)
                    {
                        self.AddListToSpinner1(mArray:self.arrayDiaChiByUserShorted)
                        for i in 0 ..< self.arrayDiaChiByUserShorted.count
                        {
                            if(self.arrayDiaChiByUserShorted[i].Latitude != 0 &&
                                self.arrayDiaChiByUserShorted[i].Longitude != 0 &&
                                self.arrayDiaChiByUserShorted[i].Loai == "1" )
                              
                            {
                                self.slPhanCong += 1
                                print(".arrayDiaChiByUserShorted[i].Latitude \(self.arrayDiaChiByUserShorted[i].Latitude) ")
                            }
                        }
                        print("slphancong \(self.slPhanCong)")
                        
                    }
                    if(self.slPhanCong == 0)
                    {
                        self.ShowDialog(mMess: "User đã hết điểm phân công")
                        self.processView.isHidden = true
                        return
                    }
                    self.actionRightButton()
                    
                }
                else
                {
                    self.ShowDialog(mMess: "Không tìm thấy kết quả")
                }
                
                
            }
            else
            {
                self.ShowDialog(mMess: "Không tìm thấy kết quả")
                
            }
        }
    }
    
    
    
    func GetSoPhieuGiaoNhan(p_MaNoiGN:String,p_UserPhanCong:String)
    {
        MDeliveryAPIService.GetSoPhieuGiaoNhan(p_MaNoiGN: p_MaNoiGN, p_UserPhanCong: p_UserPhanCong){ (error: Error? , success: Bool,result: [GiaoNhan_LoadSoPhieuGiaoNhan]!) in
            if success
            {
                if(result.count > 0)
                {
                    self.baohanhMapView.txtTongPHBGiao.text = "Tổng số kiện giao    \(result[0].SoLuongGiao)"
                    self.baohanhMapView.txtTongPHBNhan.text = "Tổng số kiện nhận    \(result[0].SoLuongNhan)"
                    if(self.isHang == true)
                    {
                        self.baohanhMapView.txtTongPHBNhan.text = "Tổng số PBH nhận    \(result[0].SoLuongNhan)"
                    }
                    self.mSLGiao = Int(result[0].SoLuongGiao)!
                    self.mSLNhan = Int(result[0].SoLuongNhan)!
                    self.mListGiao = result[0].ListGiao
                    self.mListNhan = result[0].ListNhan
                    if(self.mListGiao != "" && self.mListNhan != "")
                    {
                        self.mListGiaoNhan = "\(self.mListGiao),\(self.mListGiaoNhan)"
                    }
                    else
                    {
                        if(self.mListGiao == "" && self.mListNhan != "")
                        {
                            self.mListGiaoNhan = "\(self.mListNhan)"
                        }
                        else if(self.mListNhan == "" && self.mListGiao != "")
                        {
                            self.mListGiaoNhan = "\(self.mListGiao)"
                        }
                        else
                        {
                            self.mListGiaoNhan = ""
                        }
                    }
                    
                    print("mListGiaoNhan \(self.mListGiaoNhan)")
                    
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
    
    
    
    func ShowDialog(mMess:String)
    {
        let title = "Thông Báo"
        let message = "\(mMess)"
        let image = UIImage(named: "pexels-photo-103290")
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image)
        
        let buttonTwo = DefaultButton(title: "OK") {
            print("OK click!")
            
            self.dismiss(animated: true, completion: nil)
        }
        
        popup.addButtons([buttonTwo])
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
        
    }
    
    
    
    func CallGoogleApiToGetTimeChooseLocation(mLatUser:String,mLongUser:String,mLat:String,mLong:String,SO:String)
    {
        
        MDeliveryAPIService.GetDataGoogleAPITime(mLatUser: mLatUser, mLongUser: mLongUser, mLat: mLat,mLong: mLong,SO:SO){ (error: Error? , success: Bool,result: String!) in
            if success
            {
                if(result != nil && result != "" && result != "null" )
                {
                    self.mDoDai = result
                    //self.ShowDialog(mMess: "\(result)")
                    if(Int(result)! < 800)
                    {
                        print("Nummmmmpic \(self.mNumPic)")
                        if(self.mNumPic > 0 )
                        {
                            self.CheckAndUploadImage()
                        }
                        else
                        {
                            var mDiemDen:String = ""
                            var mDiemDau:String = ""
                            var mAction:String = ""
                            if(self.baohanhMapView.RADIO_CHOSSEN_NHAN == true && self.baohanhMapView.RADIO_CHOSSEN_GIAO == false )
                            {
                                mAction = "1"
                            }
                            else if(self.baohanhMapView.RADIO_CHOSSEN_GIAO == true && self.baohanhMapView.RADIO_CHOSSEN_NHAN == false)
                            {
                                mAction = "2"
                            }
                            else if(self.baohanhMapView.RADIO_CHOSSEN_KHAC == true)
                            {
                                mAction = "0"
                            }
                            else if(self.baohanhMapView.RADIO_CHOSSEN_GIAO == true && self.baohanhMapView.RADIO_CHOSSEN_NHAN == true)
                            {
                                mAction = "3"
                            }
                            
                            for i in 0 ..< self.arrayDataOrigin.count
                            {
                                if("\(self.arrayDataOrigin[i].Ten)" == self.baohanhMapView.company2Button.text || "\(self.arrayDataOrigin[i].Ten)." == self.baohanhMapView.company2Button.text)
                                {
                                    mDiemDen = self.arrayDataOrigin[i].NoiPhanCong
                                    
                                }
                                if("\(self.arrayDataOrigin[i].Ten)" == self.baohanhMapView.companyButton.text || "\(self.arrayDataOrigin[i].Ten)." == self.baohanhMapView.companyButton.text)
                                {
                                    print("!!!ten phan cong diem den \(self.arrayDiaChiByUser[i].Ten)")
                                    
                                    mDiemDau = self.arrayDataOrigin[i].NoiPhanCong
                                    print("mDiemDau \(mDiemDau)")
                                    
                                }
                            }
                            
                            let mType = self.CheckHangWhenCheckin(mIsHang: self.isHang)
                            print("DoDai \(result!)")
                            //self.ShowDialog(mMess: "Cho Phép Checkin")
                            self.Checkin(p_DiemDen:mDiemDen ,
                                         p_DiemBatDau:mDiemDau ,
                                         p_DoDai:"\(result!)",
                                p_Note:self.baohanhMapView.edtGhiChu.text!,
                                p_ListGiao:"\(self.mListGiao)",
                                p_ListNhan:"\(self.mListNhan)",
                                p_SLGiao:"\(self.mSLGiao)",
                                p_SLNhan:"\(self.mSLNhan)",
                                p_Latitude:"\(self.userLat)",
                                p_Longitude:"\(self.userLong)",
                                p_UserCode:"\(self.userName)",
                                p_Action:"\(mAction)",
                                p_TypeDevice:"2",
                                p_LinkHinhAnhXacNhan: "\(self.mLinkHinhAnh)",
                                p_LinkChuKy: "\(self.mLinkChuKy)",
                                p_Type: "\(mType)",
                                p_UserCode_XN: "\(self.baohanhMapView.edtThuKhoCode.text!)",
                                p_LinkHinhAnhChuKyGiaoNhan: "\(self.mLinkChuKyGiaoNhan)")
                        }
                        
                        
                        
                    }
                    else
                    {
                        
                        
                        
                        print("Nummmmmpic \(self.mNumPic)")
                        if(self.mNumPic > 0 )
                        {
                            self.CheckAndUploadImage()
                        }
                        else
                        {
                            var mDiemDen:String = ""
                            var mDiemDau:String = ""
                            var mAction:String = ""
                            if(self.baohanhMapView.RADIO_CHOSSEN_NHAN == true && self.baohanhMapView.RADIO_CHOSSEN_GIAO == false )
                            {
                                mAction = "1"
                            }
                            else if(self.baohanhMapView.RADIO_CHOSSEN_GIAO == true && self.baohanhMapView.RADIO_CHOSSEN_NHAN == false)
                            {
                                mAction = "2"
                            }
                            else if(self.baohanhMapView.RADIO_CHOSSEN_KHAC == true)
                            {
                                mAction = "0"
                            }
                            else if(self.baohanhMapView.RADIO_CHOSSEN_GIAO == true && self.baohanhMapView.RADIO_CHOSSEN_NHAN == true)
                            {
                                mAction = "3"
                            }
                            
                            for i in 0 ..< self.arrayDataOrigin.count
                            {
                                if("\(self.arrayDataOrigin[i].Ten)" == self.baohanhMapView.company2Button.text || "\(self.arrayDataOrigin[i].Ten)." == self.baohanhMapView.company2Button.text)
                                {
                                    mDiemDen = self.arrayDataOrigin[i].NoiPhanCong
                                    
                                }
                                if("\(self.arrayDataOrigin[i].Ten)" == self.baohanhMapView.companyButton.text || "\(self.arrayDataOrigin[i].Ten)." == self.baohanhMapView.companyButton.text)
                                {
                                    print("!!!ten phan cong diem den \(self.arrayDiaChiByUser[i].Ten)")
                                    
                                    mDiemDau = self.arrayDataOrigin[i].NoiPhanCong
                                    print("mDiemDau \(mDiemDau)")
                                    
                                }
                            }
                            
                            let mType = self.CheckHangWhenCheckin(mIsHang: self.isHang)
                            print("DoDai \(result!)")
                            //self.ShowDialog(mMess: "Cho Phép Checkin")
                            self.Checkin(p_DiemDen:mDiemDen ,
                                         p_DiemBatDau:mDiemDau ,
                                         p_DoDai:"\(result!)",
                                p_Note:self.baohanhMapView.edtGhiChu.text!,
                                p_ListGiao:"\(self.mListGiao)",
                                p_ListNhan:"\(self.mListNhan)",
                                p_SLGiao:"\(self.mSLGiao)",
                                p_SLNhan:"\(self.mSLNhan)",
                                p_Latitude:"\(self.userLat)",
                                p_Longitude:"\(self.userLong)",
                                p_UserCode:"\(self.userName)",
                                p_Action:"\(mAction)",
                                p_TypeDevice:"2",
                                p_LinkHinhAnhXacNhan: "\(self.mLinkHinhAnh)",
                                p_LinkChuKy: "\(self.mLinkChuKy)",
                                p_Type: "\(mType)",
                                p_UserCode_XN: "\(self.baohanhMapView.edtThuKhoCode.text!)",
                                p_LinkHinhAnhChuKyGiaoNhan: "\(self.mLinkChuKyGiaoNhan)")
                        }
                        
//                        self.ShowDialog(mMess: "Bạn phải đến điểm chọn để checkin ,bạn đang ở \(mLatUser)-\(mLongUser) , vị trí bạn checkin \(mLat)-\(mLong)")
                        
                        
                        
                        
//                       self.baohanhMapView.btnXacNhan.isHidden = false
//                        print("Nummmmmpic \(self.mNumPic)")
//                        if(self.mNumPic > 0 )
//                        {
//                            self.CheckAndUploadImage()
//                        }
//                        else
//                        {
//                            var mDiemDen:String = ""
//                            var mDiemDau:String = ""
//                            var mAction:String = ""
//                            if(self.baohanhMapView.RADIO_CHOSSEN_NHAN == true && self.baohanhMapView.RADIO_CHOSSEN_GIAO == false )
//                            {
//                                mAction = "1"
//                            }
//                            else if(self.baohanhMapView.RADIO_CHOSSEN_GIAO == true && self.baohanhMapView.RADIO_CHOSSEN_NHAN == false)
//                            {
//                                mAction = "2"
//                            }
//                            else if(self.baohanhMapView.RADIO_CHOSSEN_KHAC == true)
//                            {
//                                mAction = "0"
//                            }
//                            else if(self.baohanhMapView.RADIO_CHOSSEN_GIAO == true && self.baohanhMapView.RADIO_CHOSSEN_NHAN == true)
//                            {
//                                mAction = "3"
//                            }
//
//                            for i in 0 ..< self.arrayDataOrigin.count
//                            {
//                                if("\(self.arrayDataOrigin[i].Ten)" == self.baohanhMapView.company2Button.text || "\(self.arrayDataOrigin[i].Ten)." == self.baohanhMapView.company2Button.text)
//                                {
//                                    mDiemDen = self.arrayDataOrigin[i].NoiPhanCong
//
//                                }
//                                if("\(self.arrayDataOrigin[i].Ten)" == self.baohanhMapView.companyButton.text || "\(self.arrayDataOrigin[i].Ten)." == self.baohanhMapView.companyButton.text)
//                                {
//                                    print("!!!ten phan cong diem den \(self.arrayDiaChiByUser[i].Ten)")
//
//                                    mDiemDau = self.arrayDataOrigin[i].NoiPhanCong
//                                    print("mDiemDau \(mDiemDau)")
//
//                                }
//                            }
//
//                            let mType = self.CheckHangWhenCheckin(mIsHang: self.isHang)
//                            //self.ShowDialog(mMess: "Cho Phép Checkin")
//                            self.Checkin(p_DiemDen:mDiemDen ,
//                                         p_DiemBatDau:mDiemDau ,
//                                         p_DoDai:"\(result!)",
//                                p_Note:self.baohanhMapView.edtGhiChu.text!,
//                                p_ListGiao:"\(self.mListGiao)",
//                                p_ListNhan:"\(self.mListNhan)",
//                                p_SLGiao:"\(self.mSLGiao)",
//                                p_SLNhan:"\(self.mSLNhan)",
//                                p_Latitude:"\(self.userLat)",
//                                p_Longitude:"\(self.userLong)",
//                                p_UserCode:"\(self.userName)",
//                                p_Action:"\(mAction)",
//                                p_TypeDevice:"2",
//                                p_LinkHinhAnhXacNhan: "\(self.mLinkHinhAnh)",
//                                p_LinkChuKy: "\(self.mLinkChuKy)",
//                                p_Type: "\(mType)",
//                                p_UserCode_XN: "\(self.baohanhMapView.edtThuKhoCode.text!)",
//                                p_LinkHinhAnhChuKyGiaoNhan: "\(self.mLinkChuKyGiaoNhan)")
//                        }

                        
                    }
                }
                else
                {
                    print("Không tìm thấy kết quả ")
                    self.ShowDialog(mMess: "Nơi phân công này k có data tọa độ")
                }
            }
            else
            {
                print("Không tìm thấy kết quả")
                
            }
            
            
            
        }
        
    }
    
    
    
    
    
    /** func UPloadHinh **/
    
    func GetDataUploadHinh(p_FileName:String,p_UserCode:String,p_UserName:String,p_Base64:String,ListGiaoNhan:String,TypeImg:String)
    {
        
        MDeliveryAPIService.GiaoNhan_CallUpHinh(p_FileName: p_FileName, p_UserCode: p_UserCode, p_UserName: p_UserName,p_Base64: p_Base64, ListGiaoNhan: ListGiaoNhan, TypeImg: TypeImg){ (error: Error? , success: Bool,result: [GiaoNhan_UploadHinh]!) in
            if success
            {
                if(result != nil  )
                {
        
                    if(result[0].LinkHinhAnhXacNhan != "")
                    {
                        self.mLinkHinhAnh = result[0].LinkHinhAnhXacNhan
                    }
                    if(result[0].LinkHinhAnhChuKy != "")
                    {
                        self.mLinkChuKy = result[0].LinkHinhAnhChuKy
                    }
                    if(result[0].LinkHinhAnhChuKyGiaoNhan != "")
                    {
                        self.mLinkChuKyGiaoNhan = result[0].LinkHinhAnhChuKyGiaoNhan
                    }
                    
                    
                    
                    if(self.mNumPic > 0)
                    {
                        self.mNumPic = self.mNumPic - 1
                        if(self.mNumPic == 0)
                        {
                            print("vaoaaaaaaa")
                            var mDiemDen:String = ""
                            var mDiemDau:String = ""
                            var mAction:String = ""
                            if(self.baohanhMapView.RADIO_CHOSSEN_NHAN == true && self.baohanhMapView.RADIO_CHOSSEN_GIAO == false )
                            {
                                mAction = "1"
                            }
                            else if(self.baohanhMapView.RADIO_CHOSSEN_GIAO == true && self.baohanhMapView.RADIO_CHOSSEN_NHAN == false)
                            {
                                mAction = "2"
                            }
                            else if(self.baohanhMapView.RADIO_CHOSSEN_KHAC == true)
                            {
                                mAction = "0"
                            }
                            else if(self.baohanhMapView.RADIO_CHOSSEN_GIAO == true && self.baohanhMapView.RADIO_CHOSSEN_NHAN == true)
                            {
                                mAction = "3"
                            }
                            
                            for i in 0 ..< self.arrayDataOrigin.count
                            {
                                if("\(self.arrayDataOrigin[i].Ten)" == self.baohanhMapView.company2Button.text || "\(self.arrayDataOrigin[i].Ten)." == self.baohanhMapView.company2Button.text)
                                {
                                    mDiemDen = self.arrayDataOrigin[i].NoiPhanCong
                                    
                                }
                                if("\(self.arrayDataOrigin[i].Ten)" == self.baohanhMapView.companyButton.text || "\(self.arrayDataOrigin[i].Ten)." == self.baohanhMapView.companyButton.text)
                                {
                                    print("!!!ten phan cong diem den \(self.arrayDataOrigin[i].Ten)")
                                    
                                    mDiemDau = self.arrayDataOrigin[i].NoiPhanCong
                                    print("mDiemDau \(mDiemDau)")
                                    
                                }
                            }
                            
                            let mType = self.CheckHangWhenCheckin(mIsHang: self.isHang)
                            
                            
                            //self.ShowDialog(mMess: "Cho Phép Checkin")
                            self.Checkin(p_DiemDen:mDiemDen ,
                                         p_DiemBatDau:mDiemDau ,
                                         p_DoDai:"\(self.mDoDai)",
                                p_Note:self.baohanhMapView.edtGhiChu.text!,
                                p_ListGiao:"\(self.mListGiao)",
                                p_ListNhan:"\(self.mListNhan)",
                                p_SLGiao:"\(self.mSLGiao)",
                                p_SLNhan:"\(self.mSLNhan)",
                                p_Latitude:"\(self.userLat)",
                                p_Longitude:"\(self.userLong)",
                                p_UserCode:"\(self.userName)",
                                p_Action:"\(mAction)",
                                p_TypeDevice:"2",
                                p_LinkHinhAnhXacNhan: "\(self.mLinkHinhAnh)",
                                p_LinkChuKy: "\(self.mLinkChuKy)",
                                p_Type: mType,
                                p_UserCode_XN: "\(self.baohanhMapView.edtThuKhoCode.text!)",
                                p_LinkHinhAnhChuKyGiaoNhan: "\(self.mLinkChuKyGiaoNhan)"
                            )
                        }
                    }
                }
                else
                {
                    print("Không tìm thấy kết quả ")
                }
            }
            else
            {
                print("Không tìm thấy kết quả")
            }
            
            
            
        }
        
    }
    
    
    func CheckHangWhenCheckin(mIsHang:Bool)->String
    {
        if(mIsHang == true)
        {
            return "2"
        }
        else
        {
            return "1"
        }
    }
    
    
    func CheckUserThuKhoShop(p_UserCode:String,p_ShopCode:String)
    {
        MDeliveryAPIService.GiaoNhan_CheckUserShop(p_UserCode: p_UserCode,p_ShopCode: p_ShopCode){ (error: Error? , success: Bool,result: String!) in
            if success
            {
                
                if(!self.mPicThree )
                {
                    self.ShowDialog(mMess: "Vui Lòng Đính Kèm Chữ Kí Thủ Kho Shop")
                    self.baohanhMapView.btnXacNhan.isHidden = false
                    return
                }
                else
                {
                    let imageDataPic3:NSData = self.baohanhMapView.imageSingingThuKho.image!.jpegData(compressionQuality:0.5)! as NSData
                    let strBase64Pic3 = imageDataPic3.base64EncodedString(options: .endLineWithLineFeed)
                    self.GetDataUploadHinh(p_FileName: "3.png", p_UserCode: self.userName, p_UserName: self.employeeName, p_Base64: strBase64Pic3, ListGiaoNhan: "\(self.mListGiaoNhan)", TypeImg: "3")
                   
                    
                   
                }
                
            }
            else
            {
                self.ShowDialog(mMess: "\(result!)")
                self.baohanhMapView.btnXacNhan.isHidden = false
                
            }
        }
    }
    
    func CheckAndUploadImage()
    {
        if(isHang == true)
        {
            
            if(!self.mPicOne || !self.mPicTwo)
            {
                self.ShowDialog(mMess: "Vui Lòng Đính Kèm Hình Ảnh Và Chữ Kí")
                self.baohanhMapView.btnXacNhan.isHidden = false
                return
            }
            else
            {
                if(self.mListGiao == "" && self.mListNhan == "")
                {
                    self.mListGiaoNhan = ""
                }
                if(self.mPicTwo)
                {
                    let imageDataPic1:NSData = self.baohanhMapView.imageSinging.image!.jpegData(compressionQuality:0.5)! as NSData
                    let strBase64Pic1 = imageDataPic1.base64EncodedString(options: .endLineWithLineFeed)
                    self.GetDataUploadHinh(p_FileName: "1.png", p_UserCode: userName, p_UserName: employeeName, p_Base64: strBase64Pic1, ListGiaoNhan: "\(self.mListGiaoNhan)", TypeImg: "2")
                    self.baohanhMapView.imageSinging.image = nil
                    
                }
                
                if(self.mPicOne)
                {
                    
                    let imageDataPic2:NSData = self.baohanhMapView.viewCMNDTruocButton3.image!.jpegData(compressionQuality:0.5)! as NSData
                    let strBase64Pic2 = imageDataPic2.base64EncodedString(options: .endLineWithLineFeed)
                    self.GetDataUploadHinh(p_FileName: "2.png", p_UserCode: userName, p_UserName: employeeName, p_Base64: strBase64Pic2, ListGiaoNhan: "\(self.mListGiaoNhan)", TypeImg: "1")
                    self.baohanhMapView.viewCMNDTruocButton3.image = nil
                    
                }
                
            }
        }
        else
        {
            if(baohanhMapView.edtThuKhoCode.text == "")
            {
                ShowDialog(mMess: "Vui lòng nhập mã inside")
                self.baohanhMapView.btnXacNhan.isHidden = false
                return
            }
            if(mMaNoiGN == "")
            {
                ShowDialog(mMess: "Không xác định được mã giao nhận của địa chỉ này")
                self.baohanhMapView.btnXacNhan.isHidden = false
                return
            }
           
            CheckUserThuKhoShop(p_UserCode:"\(baohanhMapView.edtThuKhoCode.text!)",p_ShopCode:"\(mMaNoiGN)")
        }
        
        
        
        
        
    }
    
    
    
    
    
    @objc func tapSigning(sender:UITapGestureRecognizer) {
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
        //let nav = UINavigationController(rootViewController: signatureVC)
        //present(nav, animated: true, completion: nil)
         self.navigationController?.pushViewController(signatureVC, animated: true)
    }
    
    
    
    
    
    func epSignature(_: EPSignatureViewController, didCancel error : NSError) {
        print("User canceled")
        _ = self.navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
    }
    
    func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect) {
        ///chu ki hang
        let width = baohanhMapView.viewImageSign.frame.size.width - Common.Size(s:10)
        let mHeight = baohanhMapView.viewImageSign.frame.size.height
   
        baohanhMapView.viewImageSign.subviews.forEach { $0.removeFromSuperview() }
        baohanhMapView.imageSinging  = UIImageView(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:5), width: width, height: mHeight))
        //        imgViewSignature.backgroundColor = .red
        baohanhMapView.imageSinging.contentMode = .scaleAspectFit
        baohanhMapView.viewImageSign.addSubview(baohanhMapView.imageSinging)
        baohanhMapView.imageSinging.image = cropImage(image: signatureImage, toRect: boundingRect)
        
        baohanhMapView.viewImageSign.frame.size.height =  baohanhMapView.imageSinging.frame.size.height + baohanhMapView.imageSinging.frame.origin.y + Common.Size(s:5)
        baohanhMapView.viewImageSign.frame.size.height =  baohanhMapView.imageSinging.frame.origin.y + baohanhMapView.imageSinging.frame.size.height
        self.mPicTwo = true
        //chu ki shop
        baohanhMapView.viewImageSignThuKho.subviews.forEach { $0.removeFromSuperview() }
        baohanhMapView.imageSingingThuKho  = UIImageView(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:5), width: width, height: mHeight))
        //        imgViewSignature.backgroundColor = .red
        baohanhMapView.imageSingingThuKho.contentMode = .scaleAspectFit
        baohanhMapView.viewImageSignThuKho.addSubview(baohanhMapView.imageSingingThuKho)
        baohanhMapView.imageSingingThuKho.image = cropImage(image: signatureImage, toRect: boundingRect)
        
        baohanhMapView.viewImageSignThuKho.frame.size.height =  baohanhMapView.imageSingingThuKho.frame.size.height + baohanhMapView.imageSingingThuKho.frame.origin.y + Common.Size(s:5)
        baohanhMapView.viewImageSignThuKho.frame.size.height =  baohanhMapView.imageSingingThuKho.frame.origin.y + baohanhMapView.imageSingingThuKho.frame.size.height
        self.mPicThree = true
        
        _ = self.navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
        
    }
    
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
    
    
    @objc func tapShowImagePick1(sender:UITapGestureRecognizer) {
        
        self.thisIsTheFunctionWeAreCalling()
    }
}


extension BaoHanhMapController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
        }
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(sharePhoto)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        // image is our desired image
        self.baohanhMapView.viewCMNDTruocButton3.frame.origin.x = self.baohanhMapView.viewImagePic.frame.width / 4
        self.baohanhMapView.viewCMNDTruocButton3.frame.size.width =  self.baohanhMapView.viewImagePic.frame.width / 2
        self.baohanhMapView.viewCMNDTruocButton3.frame.size.height = self.baohanhMapView.viewImagePic.frame.height
        self.baohanhMapView.viewCMNDTruocButton3.contentMode = UIView.ContentMode.scaleToFill
        let squared = image.squared
        self.baohanhMapView.viewCMNDTruocButton3.image = squared
        self.mPicOne = true
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}





