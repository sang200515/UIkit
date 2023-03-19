//
//  ChiTietDonHangViewController.swift
//  NewmDelivery
//
//  Created by sumi on 3/24/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import Toaster
import GoogleMaps
import CoreLocation
import PopupDialog
import NVActivityIndicatorView


class ChiTietDonHangViewController: UIViewController ,InputTextViewDelegate,InputViewXacNhanDelegate ,UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return mListSp.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return (Common.Size(s:60));
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemSPMuaTableViewCell", for: indexPath) as! ItemSPMuaTableViewCell
          
            cell.txtValueTenSP.text = "\(mListSp[indexPath.row].U_ItmName)"
            cell.txtValueImeiSP.text = "Imei :\(mListSp[indexPath.row].U_Imei)"
            cell.txtValueSLSP.text = "x\(mListSp[indexPath.row].U_Qutity)"
        
            let uMoney = Int(self.mListSp[indexPath.row].U_TMoney) ?? 0
            let money = "\(Common.convertCurrencyV2(value: uMoney)) đ"
            cell.txtValuePriceSP.text = money
        return cell
    }
    
    func didClose(sender: InputViewXacNhanDelegate,mUser:String,mPass:String) {
        print("close didClose")
        self.view.endEditing(true)
        self.showProcessView(mShow: true)
//        var cryptoPass = PasswordEncrypter.encrypt(password: mPass)
        self.GetDataConfirmThuKho(docNum: "\(mObjectData?.ID ?? "")", userCode: "\(mUser)", password: "\(mPass)")
      
     //   self.GetDataConfirmThuKho(docNum: "\((mObjectData?.ID)!)", userCode: "\(mUser)", password: "\(mPass)")
        self.viewXacNhan.edtNameProduct.text = ""
        self.viewXacNhan.edtNameProduct2.text = ""
    }
    
    func didCancel(sender: InputViewXacNhanDelegate) {
        print("cancel didCancel")
        print("cancel")
        self.viewXacNhan.isHidden = true
        self.viewXacNhan.edtNameProduct.text = ""
        self.viewXacNhan.edtNameProduct2.text = ""
        self.view.endEditing(true)
    }
    
    func didClose(sender: InputTextViewDelegate,mReason:String) {
        print("asdsad close")
        self.GetResultSetSORejected(docNum: "\(mObjectData?.ID ?? "")", userCode:"\(Cache.user!.UserName)", reason:"\(mReason)")
        self.viewInput.isHidden = true
        self.viewInput.edtNameProduct.text = ""
        self.view.endEditing(true)
    }
    
    func didCancel(sender: InputTextViewDelegate) {
        print("cancel")
        self.viewInput.isHidden = true
        self.viewInput.edtNameProduct.text = ""
        self.view.endEditing(true)
    }
    
    var viewProcess:ProcessView!
    var mTypePush:String?
    var mTimeLest:String?
    var userLat:Double = 0
    var userLong:Double = 0
    var locManager = CLLocationManager()
    var btnCall:UIButton!
    var mTongTien:Int = 0
    
    var mListSp = [getSODetailsResult]()
    var mObjectData:GetSOByUserResult?
    var tableViewSP: UITableView  =   UITableView()
    var viewNgMua:UIView!
    var viewNgNhan:UIView!
    var viewPhanCong:UIView!
    var viewThongTin:UIView!
    
    var labelNgMua:UILabel!
    var imageNgMua:UIImageView!
    var labelValueNameNgMua:UILabel!
    var labelValuePhoneNumNgMua:UILabel!
    var labelValueAddrNgMua:UILabel!
    
    
    var labelNgNhan:UILabel!
    var imageNgNhan:UIImageView!
    var labelValueNameNgNhan:UILabel!
    var labelValuePhoneNumNgNhan:UILabel!
    var labelValueAddrNgNhan:UILabel!
    
    var labelPhanCong:UILabel!
    var labelNV:UILabel!
    var labelThuKho:UILabel!
    var imagePhanCong:UIImageView!
    var labelValueNV:UITextField!
    
    
    var labelThongTinn:UILabel!
    var imageThongTin:UIImageView!
    var labelDH:UILabel!
    var labelValueDH:UILabel!
    var labelEcom:UILabel!
    var labelValueEcom:UILabel!
    var labelTime:UILabel!
    var labelValueTime:UILabel!
    var labelValueTimeLest:UILabel!
    var labelGhiChu:UILabel!
    var viewGhiChu:UIView!
    var txtValueGhiChu: UILabel!
    
    
    var viewItemDH:UIView!
    var labelItemDHName:UILabel!
    var labelItemDHImei:UILabel!
    var labelItemDHSL:UILabel!
    var labelItemDHGia:UILabel!
    
    var viewTongDH:UIView!
    var labelTongDHText:UILabel!
    var labelTienGiamText:UILabel!
    var labelDatCocText:UILabel!
    var labelPhaiThuText:UILabel!
    
    var labelTongDHValue:UILabel!
    var labelTienGiamValue:UILabel!
    var labelDatCocValue:UILabel!
    var labelPhaiThuValue:UILabel!
    
    var btnXacNhan:UIButton!
    
    var scrollView:UIScrollView!
    
    var viewLine1:UIView!
    var viewLine2:UIView!
    var viewLine3:UIView!
    
    var companyButton: SearchTextField!
    var companyButton2: SearchTextField!
    
    var arrGetEmPloyeesResult = [GetEmPloyeesResult]()
    
    var barSearchRight : UIBarButtonItem!
    
    
    var mViewOptionMenu:UIView!
    var mTitleMenu1:UILabel!
    var mViewLine1:UIView!
    var mTitleMenu2:UILabel!
    var viewInput:InputTextView!
    var viewXacNhan:InputViewXacNhan!
    var mJobtitle:String = ""
    
    //var labelThoiGianUocTinh:UILabel!
    var labelKhoangCachUocTinh:UILabel!
    var labelUocTinh:UILabel!
    
    let khachKhongNHButton:UIButton = {
        let button = UIButton()
        button.setTitle("Khách không nhận hàng", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(khachKhongNhanHangHandle), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        return button
    }()
    
    let khachNHButton:UIButton = {
        let button = UIButton()
        button.setTitle("Khách nhận hàng", for: .normal)
        button.backgroundColor = UIColor.mainGreen
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(khachNhanHangHandle), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor  = UIColor.white
        initView()
        ShowOptionMenu()
        
        GetDataUserDelivery(shopCode: "\(Cache.user!.ShopCode)", jobtitle:"\(Cache.user!.JobTitle)")
        GetDataSODetails(docNum: "\(mObjectData?.ID ?? "")")
        //mJobtitle = Helper.getJobTitle()!
        mJobtitle =  Cache.user!.JobTitle
        LoadThongTinData()
       
       
       
        
        self.companyButton2.text = "\(mObjectData?._WHConfirmed_MaTen ?? "")"
        
        
        self.viewInput.isHidden = true
        self.viewXacNhan.isHidden = true
        self.btnXacNhan.addTarget(self, action: #selector(self.ClickXacNhan), for: .touchUpInside)
        
        self.companyButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            
            
            self.view.endEditing(true)
            
            for i in 0 ..< self.arrGetEmPloyeesResult.count
            {
                if (item.title == "\(self.arrGetEmPloyeesResult[i].UserName)-\(self.arrGetEmPloyeesResult[i].EmployeeName)") {

                    let alertController = UIAlertController(title: "Thông báo", message: "Bạn có muốn đổi nhân viên \(item.title) làm nhân viên giao hàng không ?", preferredStyle: .alert)
                    // Create the actions
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        let formattedString = (self.arrGetEmPloyeesResult[i].EmployeeName).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                        self.companyButton.text = item.title
                        self.GetDataSetSOBooked(docNum: "\(self.mObjectData?.ID ?? "")", userCode:"\(self.arrGetEmPloyeesResult[i].UserName)",empName: "\(formattedString!)")
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                        NSLog("Cancel Pressed")
                    }
                    // Add the actions
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    // Present the controller
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                }
            }
            
            
        }
        
        self.companyButton2.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            
            self.companyButton2.text = item.title
            self.view.endEditing(true)
            
            for i in 0 ..< self.arrGetEmPloyeesResult.count
            {
                if(item.title == self.arrGetEmPloyeesResult[i].EmployeeName )
                {
                    print("provide id \(self.arrGetEmPloyeesResult[i].CompanyCode)")
                }
            }
            
        }
        
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        
        userLat = (locManager.location?.coordinate.latitude)!
        userLong = (locManager.location?.coordinate.longitude)!
        
        if("\(String(describing: mTimeLest))" != "nil")
        {
            self.labelValueTimeLest.text = "\(mTimeLest!)"
        }
        
        if("\(String(describing: mTypePush))" != "nil")
        {
            self.btnXacNhan.isHidden = true
            self.navigationItem.rightBarButtonItems = []
        }
        
        if("\((mObjectData?.U_AdrDel)!)" != "")
        {
            
            let formattedString = (mObjectData?.U_AdrDel)!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            CallGoogleApiToGetRouteByAddress(mLatUser:"\(self.userLat)",mLongUser:"\(self.userLong)",mAddress:"\(formattedString!)",SO: mObjectData!.DocEntry)
        }
        else
        {
            if("\((mObjectData?.FinishLatitude)!)" != "" && "\((mObjectData?.FinishLongitude)!)" != "")
            {
                CallGoogleApiToGetRoute(mLatUser:"\(self.userLat)",mLongUser:"\(self.userLong)",mLat:"\((mObjectData?.FinishLatitude)!)",mLong:"\((mObjectData?.FinishLongitude)!)",SO:"\((mObjectData?.DocEntry)!)")
            }
           
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func khachKhongNhanHangHandle(){
        let vc = PopUpKhachKhongNhanHangViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func khachNhanHangHandle(){
        
    }
    
    func ShowHuyDonHangView()
    {
       self.viewInput.isHidden = !self.viewInput.isHidden
        mViewOptionMenu.isHidden = true
    }

    
    
    func GetDataSetSOBooked(docNum: String, userCode:String,empName:String) {
        self.showProcessView(mShow: true)
        MDeliveryAPIService.GetSetSOBooked(docNum: docNum, userCode:userCode,empName:empName){ (error: Error?, success: Bool, result: ConfirmThuKhoResult!) in
            self.showProcessView(mShow: false)
            if success {
                if(result != nil) {
                    Toast(text: "\(result.Descriptionn)").show()
                }
            } else {
                Toast(text: "\(error?.localizedDescription ?? "")").show()
            }
        }
        
    }
    
    
    
    @objc func ClickOptionMenu()
    {
        mViewOptionMenu.isHidden = !mViewOptionMenu.isHidden
        
    }
    
    func ShowOptionMenu()
    {
    
        print("asdsadsa")
       
        mViewOptionMenu = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width / 2,y: 0 ,width:UIScreen.main.bounds.size.width / 2, height: Common.Size(s:60)  ))
        mViewOptionMenu.backgroundColor = UIColor(netHex:0xffffff)
        mViewOptionMenu.layer.borderWidth = 0.5
        mViewOptionMenu.layer.borderColor = UIColor.black.cgColor
        
        mTitleMenu1 = UILabel(frame: CGRect(x: 0, y: Common.Size(s: 5) , width: mViewOptionMenu.frame.size.width , height: Common.Size(s:13)))
        mTitleMenu1.textAlignment = .left
        mTitleMenu1.textColor = UIColor.black
        mTitleMenu1.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        mTitleMenu1.text = "  Cập nhật thông tin"
        
        mViewLine1 = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width / 2,y: mTitleMenu1.frame.size.height + mTitleMenu1.frame.origin.y + Common.Size(s: 10)  ,width:UIScreen.main.bounds.size.width / 2, height: 20  ))
        mViewLine1.backgroundColor = UIColor(netHex:0x000000)
        
        mTitleMenu2 = UILabel(frame: CGRect(x: 0, y: Common.Size(s: 20) + mTitleMenu1.frame.size.height , width: mViewOptionMenu.frame.size.width , height: Common.Size(s:13)))
        mTitleMenu2.textAlignment = .left
        mTitleMenu2.textColor = UIColor.black
        mTitleMenu2.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        mTitleMenu2.text = "  Hủy đơn hàng"
        
        self.view.addSubview(mViewOptionMenu)
        mViewOptionMenu.addSubview(mTitleMenu1)
        mViewOptionMenu.addSubview(mTitleMenu2)
        mViewOptionMenu.addSubview(mViewLine1)
        
        mViewOptionMenu.isHidden = true
        
        
        let tapTitleMenu1 = UITapGestureRecognizer(target: self, action: #selector(self.TapCapNhat))
        mTitleMenu1.isUserInteractionEnabled = true
        mTitleMenu1.addGestureRecognizer(tapTitleMenu1)
        
        let tapTitleMenu2 = UITapGestureRecognizer(target: self, action: #selector(self.TapHuyDon))
        mTitleMenu2.isUserInteractionEnabled = true
        mTitleMenu2.addGestureRecognizer(tapTitleMenu2)
    }
    
    @objc func TapCapNhat()
    {
        print("cap nhat thong tin")
        let newViewController = CapNhatThongTinGiaoHangViewController()
        newViewController.mTimeGiao = self.labelValueTime.text ?? ""
        newViewController.mObjectData = self.mObjectData
        self.mViewOptionMenu.isHidden = true
        self.viewXacNhan.isHidden = true
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func getDistanceDelivery() {
        ProgressView.shared.show()
        MDeliveryAPIService.GetDataGoogleAPIByAddressAndAddress(mLatUser:"\(self.mObjectData!.FinishLatitude)" , mLongUser:"\(self.mObjectData!.FinishLongitude)" ,mLat: "\(self.mObjectData!.U_AdrDel)",SO:"\(self.mObjectData!.DocEntry)"){ (error: Error? , success: Bool,result: String!,resultLat: String!,resultLong: String!,resultDistance: String!,resultDuration: String!) in
            ProgressView.shared.hide()
            if success
            {
                if(resultDistance != nil){
                    var distance:Double = 0
                    var lstDistanceStr = resultDistance.components(separatedBy: " ")
                    if(lstDistanceStr.count > 1){
                        if(lstDistanceStr[1] == "m"){
                            distance = Double(lstDistanceStr[0])!*0.001
                            
                        }else{
                            lstDistanceStr[0] = lstDistanceStr[0].replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
                            distance = Double(lstDistanceStr[0])!
                        }
                        
                    }
                   
                    //
                    if(distance > 20){
                        let title = "THÔNG BÁO"
                        let message = "Cảnh báo: Đơn hàng có khoảng cách giao dự kiến > 20Km. Vui lòng kiểm tra lại địa chỉ giao!"
                        
                        // Create the dialog
                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        
                        // Create first button
                        let buttonOne = CancelButton(title: "Huỷ") {
                            
                        }
                        let buttonTwo = DefaultButton(title: "Tiếp tục"){
                            let newViewController = GHTNViewController()
                            
                            newViewController.mTimeLest = self.labelValueTimeLest.text!
                            newViewController.typePush = 1
                            newViewController.mObjectData = self.mObjectData
                            newViewController.mCostPhaiThu = self.labelPhaiThuValue.text
                            if(!(self.mObjectData?.U_AdrDel.isEmpty)!)
                            {
                                newViewController.mAddress = self.mObjectData?.U_AdrDel
                            }
                            else
                            {
                                newViewController.mAddress = ""
                            }
                            if(!(self.mObjectData?.FinishLatitude.isEmpty)! && (self.mObjectData?.FinishLatitude != "0") && !(self.mObjectData?.FinishLongitude.isEmpty)! && (self.mObjectData?.FinishLongitude != "0"))
                            {
                                newViewController.mLat = self.mObjectData?.FinishLatitude
                                newViewController.mLong = self.mObjectData?.FinishLongitude
                            }
                            else
                            {
                                print("not have lat")
                                newViewController.mLat = "0"
                                newViewController.mLong = "0"
                            }
                            newViewController.mLat = self.mObjectData?.DocEntry
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }
                        // Add buttons to dialog
                        popup.addButtons([buttonOne,buttonTwo])
                        
                        // Present dialog
                        self.present(popup, animated: true, completion: nil)
                    }else{
                        let newViewController = GHTNViewController()
                        
                        newViewController.mTimeLest = self.labelValueTimeLest.text!
                        newViewController.typePush = 1
                        newViewController.mObjectData = self.mObjectData
                        newViewController.mCostPhaiThu = self.labelPhaiThuValue.text
                        if(!(self.mObjectData?.U_AdrDel.isEmpty)!)
                        {
                            newViewController.mAddress = self.mObjectData?.U_AdrDel
                        }
                        else
                        {
                            newViewController.mAddress = ""
                        }
                        if(!(self.mObjectData?.FinishLatitude.isEmpty)! && (self.mObjectData?.FinishLatitude != "0") && !(self.mObjectData?.FinishLongitude.isEmpty)! && (self.mObjectData?.FinishLongitude != "0"))
                        {
                            newViewController.mLat = self.mObjectData?.FinishLatitude
                            newViewController.mLong = self.mObjectData?.FinishLongitude
                        }
                        else
                        {
                            print("not have lat")
                            newViewController.mLat = "0"
                            newViewController.mLong = "0"
                        }
                        newViewController.mLat = self.mObjectData?.DocEntry
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }
                    
                    
                }
                else
                {
                    let newViewController = GHTNViewController()
                    
                    newViewController.mTimeLest = self.labelValueTimeLest.text!
                    newViewController.typePush = 1
                    newViewController.mObjectData = self.mObjectData
                    newViewController.mCostPhaiThu = self.labelPhaiThuValue.text
                    if(!(self.mObjectData?.U_AdrDel.isEmpty)!)
                    {
                        newViewController.mAddress = self.mObjectData?.U_AdrDel
                    }
                    else
                    {
                        newViewController.mAddress = ""
                    }
                    if(!(self.mObjectData?.FinishLatitude.isEmpty)! && (self.mObjectData?.FinishLatitude != "0") && !(self.mObjectData?.FinishLongitude.isEmpty)! && (self.mObjectData?.FinishLongitude != "0"))
                    {
                        newViewController.mLat = self.mObjectData?.FinishLatitude
                        newViewController.mLong = self.mObjectData?.FinishLongitude
                    }
                    else
                    {
                        print("not have lat")
                        newViewController.mLat = "0"
                        newViewController.mLong = "0"
                    }
                    newViewController.mLat = self.mObjectData?.DocEntry
                    self.navigationController?.pushViewController(newViewController, animated: true)
                    
                }
                
            }
            else
            {
                
                let newViewController = GHTNViewController()
                
                newViewController.mTimeLest = self.labelValueTimeLest.text!
                newViewController.typePush = 1
                newViewController.mObjectData = self.mObjectData
                newViewController.mCostPhaiThu = self.labelPhaiThuValue.text
                if(!(self.mObjectData?.U_AdrDel.isEmpty)!)
                {
                    newViewController.mAddress = self.mObjectData?.U_AdrDel
                }
                else
                {
                    newViewController.mAddress = ""
                }
                if(!(self.mObjectData?.FinishLatitude.isEmpty)! && (self.mObjectData?.FinishLatitude != "0") && !(self.mObjectData?.FinishLongitude.isEmpty)! && (self.mObjectData?.FinishLongitude != "0"))
                {
                    newViewController.mLat = self.mObjectData?.FinishLatitude
                    newViewController.mLong = self.mObjectData?.FinishLongitude
                }
                else
                {
                    print("not have lat")
                    newViewController.mLat = "0"
                    newViewController.mLong = "0"
                }
                newViewController.mLat = self.mObjectData?.DocEntry
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
        }
    }
    
    func actionBatdauGiao() {
        if self.mObjectData?.Partner_code.lowercased() == "grab"  {
            ProgressView.shared.show()
                GrabBookingApiManager.shared.getPlainningGrab(docEntry: self.mObjectData?.DocEntry ?? "", id: self.mObjectData?.ID ?? "") { [weak self] response, err in
                    guard let self = self else {return}
                    ProgressView.shared.hide()
                        if err != "" {
                            self.showPopup(with: err, completion: nil)
                        } else {
                            if response?.result == 0 {
                                self.showPopup(with: "\(response?.msg ?? "")", completion: nil)
                            } else {
                                let popup = GrabBookingPopup()
                                popup.modalTransitionStyle = .crossDissolve
                                popup.modalPresentationStyle = .overCurrentContext
                                popup.planningItem = response
                                popup.orderItem = self.mObjectData
                                popup.onBook = {
                                    guard let item = self.mObjectData, let planning = response else {return}
                                    ProgressView.shared.show()
                                    GrabBookingApiManager.shared.bookingGrab(item: item, planning: planning, partnerName: "GRAB") { [weak self] res, err in
                                            guard let self = self else {return}
                                            ProgressView.shared.hide()
                                                if err != "" {
                                                    self.showPopup(with: err, completion: nil)
                                                } else {
                                                    self.showPopup(with: res?.msg ?? "") {
                                                        if res?.result == 1 {
                                                            self.navigationController?.popViewController(animated: true)
                                                        }
                                                    }
                                                }
                                            
                                        }
                                    
                                }
                                popup.onFrtDelivery = {
//                                    guard let item = self.mObjectData else {return}
//                                    WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang đặt xe...") {
//                                        GrabBookingApiManager.shared.bookingFRT(item: item) { [weak self] res, err in
//                                            guard let self = self else {return}
//                                            WaitingNetworkResponseAlert.DismissWaitingAlert {
//                                                if err != "" {
//                                                    self.showPopup(with: err, completion: nil)
//                                                } else {
//                                                    self.showPopup(with: res?.msg ?? "") {
//                                                        if res?.result == 1 {
//                                                            self.navigationController?.popViewController(animated: true)
//                                                        }
//                                                    }
//                                                }
//                                            }
//                                        }
//                                    }
                                }
                                self.present(popup, animated: true, completion: nil)
                            }
                        }
                    
                }
            
            return
        } else {
                getDistanceDelivery()
        }
    }
    
    
    @objc func ClickXacNhan()
    {
        if self.btnXacNhan.title(for: .normal) == mObjectData?.btn_BatDauGiaoHang {
            let pass = UserDefaults.standard.string(forKey: "password")
            Provider.shared.ecomOrders.setSodelivering(docNum: "\(mObjectData?.ID ?? "")", user: Cache.user!.UserName, pass: pass ?? "") { [weak self] result in
                guard let self = self else {return}
                if result?.Result == 1 {
                    self.actionBatdauGiao()
                } else {
                    self.showPopup(with: result?.Description ?? "") {}
                }
            } failure: { [weak self] error in
                guard let self = self else {return}
                self.showAlert(error.localizedDescription)
            }

        } else {
            if(self.btnXacNhan.title(for: .normal) == mObjectData?.btn_XacNhanXuatKho ) {
                mViewOptionMenu.isHidden = true
                let mUserName = Cache.user!.UserName
                if mUserName == self.mObjectData?.UserName {
                    viewXacNhan.isHidden = false
                } else {
                    Toast(text: "Chỉ nhân viên \((self.mObjectData?.EmpName)!) mới được quyền xác nhận").show()
                }
                
            } else if self.btnXacNhan.title(for: .normal) == mObjectData?.btn_HuyGiaoHang {
                WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang hủy đơn hàng...") {
                    GrabBookingApiManager.shared.cancelGrab(item: self.mObjectData!) { [weak self] result, err in
                        guard let self = self else {return}
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            if err != "" {
                                self.showPopup(with: err, completion: nil)
                            } else {
                                self.showPopup(with: result?.msg ?? "") {
                                    if result?.result == 1 {
                                        self.navigationController?.popViewController(animated: true)
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                getDistanceDelivery()
            }
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
    
    @objc func TapHuyDon()
    {
        print("TapHuyDon")
        ShowHuyDonHangView()
    }
    
    
    func LoadThongTinData()
    {
        self.labelValueNameNgMua.text = self.mObjectData?.U_CrdName
        self.labelValuePhoneNumNgMua.text = self.mObjectData?.U_CPhone
        self.labelValueAddrNgMua.text = self.mObjectData?.U_CAddress
        self.labelValueNameNgNhan.text = self.mObjectData?.p_ThongTinNguoiNhan_Name
        self.labelValuePhoneNumNgNhan.text = self.mObjectData?.p_ThongTinNguoiNhan_SDT
        self.labelValueAddrNgNhan.text = self.mObjectData?.p_ThongTinNguoiNhan_Address
        self.txtValueGhiChu.text = self.mObjectData?.U_Desc
        
        self.labelValueDH.text = self.mObjectData?.DocEntry
        
      
        self.labelValueEcom.text = self.mObjectData?.U_NumEcom
//
        let newTime = self.mObjectData?.p_ThongTinNguoiNhan_Date
        
        self.labelValueTime.text = newTime ?? ""
        self.labelValueTimeLest.text = self.mObjectData?.RejectDate
        
        self.labelDatCocValue.text = Helper.FormatMoney(cost: Int((self.mObjectData?.SoTienTraTruoc)!)!)
        if(self.mObjectData?.U_PaidMoney.isEmpty == false)
        {
            self.labelPhaiThuValue.text = Helper.FormatMoney(cost: Int(self.mObjectData?.U_PaidMoney ?? "0") ?? 0)
            self.labelItemDHGia.text = Helper.FormatMoney(cost: Int(self.mObjectData?.U_PaidMoney ?? "0") ?? 0)
        }
        
        setBottomButton(object: mObjectData)
        
        print("mJobtitle \(self.mJobtitle)")
        
        if mJobtitle == JOBTITLE.JOB_TITLE_SM || mJobtitle == JOBTITLE.JOB_TITLE_DSM || mJobtitle == JOBTITLE.JOB_TITLE_TRUONG_CA || mJobtitle == JOBTITLE.JOB_TITLE_PHO_QUANLY_CUAHANG_APR || mJobtitle == JOBTITLE.JOB_TITLE_TRUONG_QUANLY_CUAHANG_APR {
            self.companyButton.isEnabled = true
            self.companyButton2.isEnabled = true
        } else {
            self.companyButton.isEnabled = false
            self.companyButton2.isEnabled = false
        }
        
        
        if (self.btnXacNhan.title(for: .normal) == mObjectData?.btn_XacNhanXuatKho) {
            self.labelThuKho.isHidden = true
            self.companyButton2.isHidden = true
//            self.navigationItem.rightBarButtonItems = []
        }
    }
    
    func setBottomButton(object: GetSOByUserResult?) {
        if object?.Partner_code.lowercased() == "grab" {
            self.khachNHButton.isHidden = true
            self.khachKhongNHButton.isHidden = true
            self.btnXacNhan.isHidden = false
            self.btnXacNhan.setTitle("Đặt Grab", for: .normal)
        }else {
            self.khachNHButton.isHidden = false
            self.khachNHButton.setTitle(object?.btn_KhachNhanHang, for: .normal)
            self.khachKhongNHButton.isHidden = false
            self.khachKhongNHButton.setTitle(object?.btn_KhachKhongNhanHang, for: .normal)
            self.btnXacNhan.isHidden = true
        }
        
        if object?.btn_BatDauGiaoHang == "" && object?.btn_HuyGiaoHang == "" && object?.btn_XacNhanXuatKho == "" {
            btnXacNhan.isHidden = true
        }
        if object?.btn_BatDauGiaoHang != "" {
            self.btnXacNhan.setTitle(object?.btn_BatDauGiaoHang, for: .normal)
//            self.navigationItem.rightBarButtonItems = []
            let btSearchIcon = UIButton.init(type: .custom)
            btSearchIcon.setImage(#imageLiteral(resourceName: "moreIC"), for: .normal)

            btSearchIcon.imageView?.contentMode = .scaleAspectFit
            btSearchIcon.addTarget(self, action: #selector(ChiTietDonHangViewController.ClickOptionMenu), for: UIControl.Event.touchUpInside)
            btSearchIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
            barSearchRight = UIBarButtonItem(customView: btSearchIcon)
            self.navigationItem.rightBarButtonItems = [barSearchRight]

        } else if object?.btn_HuyGiaoHang != "" {
            self.btnXacNhan.setTitle(object?.btn_HuyGiaoHang, for: .normal)
            self.navigationItem.rightBarButtonItems = []
        } else if object?.btn_XacNhanXuatKho != "" {
            self.btnXacNhan.setTitle(object?.btn_XacNhanXuatKho, for: .normal)
            self.labelThuKho.isHidden = true
            self.companyButton2.isHidden = true

            let btSearchIcon = UIButton.init(type: .custom)
            btSearchIcon.setImage(#imageLiteral(resourceName: "moreIC"), for: .normal)

            btSearchIcon.imageView?.contentMode = .scaleAspectFit
            btSearchIcon.addTarget(self, action: #selector(ChiTietDonHangViewController.ClickOptionMenu), for: UIControl.Event.touchUpInside)
            btSearchIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
            barSearchRight = UIBarButtonItem(customView: btSearchIcon)
            self.navigationItem.rightBarButtonItems = [barSearchRight]
        }
    }
   
    
    func showProcessView(mShow:Bool)
    {
        self.viewProcess.isHidden = !mShow
    }
    
    func getDataSOByUser(p_UserID:String)
    {
        MDeliveryAPIService.GetSOByUser(p_User: p_UserID){ (error: Error?, success: Bool, result: [GetSOByUserResult]) in
            if success
            {
                if(result.count > 0)
                {
                    for i in 0 ..< result.count
                    {
                        if(result[i].ID == "\(self.mObjectData?.ID ?? "")")
                        {
                            self.mObjectData = result[i]
                            if result[i].Partner_code.lowercased() == "grab" {
//                                self.btnXacNhan.setTitle(result[i].btn_BatDauGiaoHang, for: .normal)
                                self.btnXacNhan.setTitle("Đặt Grab", for: .normal)
                                self.viewXacNhan.isHidden = true
                                self.labelThuKho.isHidden = false
                                self.companyButton2.isHidden = false
                                self.companyButton2.text = "\((result[i]._WHConfirmed_MaTen))"
                            } else {
                                if result[i].btn_KhachNhanHang != "" && result[i].btn_KhachKhongNhanHang != ""{
                                    self.khachKhongNHButton.setTitle(result[i].btn_KhachKhongNhanHang, for: .normal)
                                    self.khachNHButton.setTitle(result[i].btn_KhachNhanHang, for: .normal)
                                    self.btnXacNhan.isHidden = true
                                }
                                if result[i].btn_HuyGiaoHang != "" {
                                    self.btnXacNhan.setTitle(result[i].btn_HuyGiaoHang, for: .normal)
                                    self.navigationItem.rightBarButtonItems = []
                                } else if result[i].btn_BatDauGiaoHang != "" {
                                    self.btnXacNhan.setTitle(result[i].btn_BatDauGiaoHang, for: .normal)
                                    self.viewXacNhan.isHidden = true
                                    self.labelThuKho.isHidden = false
                                    self.companyButton2.isHidden = false
                                    self.companyButton2.text = "\((result[i]._WHConfirmed_MaTen))"
                                    self.navigationItem.rightBarButtonItems = []
                                } else if result[i].btn_XacNhanXuatKho != "" {
                                    self.btnXacNhan.setTitle(result[i].btn_XacNhanXuatKho, for: .normal)
                                    self.labelThuKho.isHidden = true
                                    self.companyButton2.isHidden = true

                                    let btSearchIcon = UIButton.init(type: .custom)
                                    btSearchIcon.setImage(#imageLiteral(resourceName: "moreIC"), for: .normal)

                                    btSearchIcon.imageView?.contentMode = .scaleAspectFit
                                    btSearchIcon.addTarget(self, action: #selector(ChiTietDonHangViewController.ClickOptionMenu), for: UIControl.Event.touchUpInside)
                                    btSearchIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
                                    self.barSearchRight = UIBarButtonItem(customView: btSearchIcon)
                                    self.navigationItem.rightBarButtonItems = [self.barSearchRight]
                                }
                            }
                            return
                        }
                    }
                    
                }
            }
            else
            {
            }
        }
    }
    
    
    
    
    func GetDataConfirmThuKho(docNum: String, userCode:String, password:String)
    {
        MDeliveryAPIService.GetConfirmThuKho(docNum: docNum, userCode:userCode , password:password){ (error: Error?, success: Bool, result: ConfirmThuKhoResult?) in
            if success
            {
                self.showProcessView(mShow: false)
                if(result != nil)
                {
                    if(result?.Result == "1")
                    {
                     
                        
                        self.getDataSOByUser(p_UserID: "\(Cache.user!.UserName)")

                    }
                    else
                    {
                        Toast(text: "\(result?.Descriptionn ?? "")").show()
                    }
                    
                    
                }
                
            }
            else
            {
                self.showProcessView(mShow: false)
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
                        listCom.append("\(result[i].UserName)-\(result[i].EmployeeName)")
                       
                        
                    }
                    
                    self.companyButton.filterStrings(listCom)
                    self.companyButton.text = "\((self.mObjectData?.EmpName)!)"
                    
                    
                    
                   
                    
                }
                
            }
            else
            {
                
            }
        }
        
        
        
    }
    
    
    ///////////////
    
    func GetDataSODetails(docNum: String)
    {
        MDeliveryAPIService.GetSODetails(docNum: docNum){ (error: Error?, success: Bool, result: [getSODetailsResult]!) in
            if success
            {
                
                if(result != nil && result.count > 0)
                {
                    self.mListSp = result
                    self.tableViewSP.reloadData()
                }
                
                for i in 0 ..< result.count
                {
                    let number = Int(result[i].U_TMoney) ?? 0
                    self.mTongTien = self.mTongTien + number
                }
                
                //self.labelPhaiThuValue.text = Helper.FormatMoney(cost: self.mTongTien)
                
                let def = UserDefaults.standard ;
                def.setValue(Helper.FormatMoney(cost: self.mTongTien), forKey: "PhaiThuCost") ;
                
                self.labelTongDHValue.text = Helper.FormatMoney(cost: self.mTongTien)
                if self.mObjectData?.mType != "11" {                
                    let sotienTratrc = Int(self.mObjectData?.SoTienTraTruoc ?? "0") ?? 0
                    self.labelPhaiThuValue.text =  Helper.FormatMoney(cost: Int(self.mTongTien) - sotienTratrc)
                }
                
                //self.labelPhaiThuValue.text = "\((self.labelPhaiThuValue.text)!) đ"
                //self.labelTongDHValue.text = "\((self.labelTongDHValue.text)!) đ"
                
                
                
            }
            else
            {
                
            }
        }
        
        
        
    }
    
    
    //////////////
    
    
    func CallGoogleApiToGetRoute(mLatUser:String,mLongUser:String,mLat:String,mLong:String,SO:String)
    {
        
//        MDeliveryAPIService.GetDataGoogleAPIRoute(mLatUser: mLatUser, mLongUser: mLongUser, mLat: mLat,mLong: mLong,SO:SO){ (error: Error? , success: Bool,result: String!,resultDistance: String!,resultDuration: String!)  in
//            if success
//            {
//                if(result != nil && result != "" && result != "null" )
//                {
//                    //self.labelThoiGianUocTinh.text = "Thời gian : \(resultDuration)"
//                    self.labelKhoangCachUocTinh.text = "Khoảng cách : \(resultDistance!)"
//
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
        
//        MDeliveryAPIService.GetDataGoogleAPIByAddress(mLatUser: mLatUser, mLongUser: mLongUser, mAddress: mAddress,SO:SO){ (error: Error? , success: Bool,result: String!,resultLat: String!,resultLong: String!,resultDistance: String!,resultDuration: String!) in
//            if success
//            {
//                if(result != nil && result != "" && result != "null" )
//                {
//                    //self.labelThoiGianUocTinh.text = "Thời gian : \(resultDuration)"
//                    self.labelKhoangCachUocTinh.text = "Khoảng cách : \(resultDistance!)"
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
    
    
    
    func initView()
    {
     
        //scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView = UIScrollView(frame: CGRect(x: 0,y: 0 ,width:UIScreen.main.bounds.size.width , height:  UIScreen.main.bounds.size.height - Common.Size(s:70) - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height) ))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height + Common.Size(s:50))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
      
        
        
        viewNgMua = UIView(frame: CGRect(x: Common.Size(s: 20),y: 0 ,width:UIScreen.main.bounds.size.width - Common.Size(s: 40), height: Common.Size(s:20) * 5 ))
        viewNgMua.backgroundColor = UIColor(netHex:0xffffff)
        
        viewLine1 = UIView(frame: CGRect(x:0,y: viewNgMua.frame.origin.y + viewNgMua.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width, height: Common.Size(s:1) ))
        viewLine1.backgroundColor = UIColor(netHex:0xe8e8e8)
        
        imageNgMua = UIImageView(frame: CGRect(x: 0, y: Common.Size(s: 5) , width: Common.Size(s: 20) , height: Common.Size(s: 20) ));
        imageNgMua.image = UIImage(named:"ic-TTNM.png")
        imageNgMua.contentMode = UIView.ContentMode.scaleToFill
        
        let strTitleNgMua = "Thông tin người mua "
        labelNgMua = UILabel(frame: CGRect(x: imageNgMua.frame.size.width + Common.Size(s:5), y: Common.Size(s: 7) , width: viewNgMua.frame.size.width , height: Common.Size(s:13)))
        labelNgMua.textAlignment = .left
        labelNgMua.textColor = UIColor.black
        labelNgMua.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        labelNgMua.text = strTitleNgMua
        
        labelValueNameNgMua = UILabel(frame: CGRect(x: labelNgMua.frame.origin.x , y: imageNgMua.frame.origin.y + imageNgMua.frame.size.height +  Common.Size(s:5) , width: viewNgMua.frame.size.width / 2, height: Common.Size(s:13)))
        labelValueNameNgMua.textAlignment = .left
        labelValueNameNgMua.textColor = UIColor.gray
        labelValueNameNgMua.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelValueNameNgMua.text = "Ly Tam Hoan"
        
        labelValuePhoneNumNgMua = UILabel(frame: CGRect(x: labelNgMua.frame.origin.x , y: labelValueNameNgMua.frame.origin.y + labelValueNameNgMua.frame.size.height +  Common.Size(s:5) , width: viewNgMua.frame.size.width / 2, height: Common.Size(s:13)))
        labelValuePhoneNumNgMua.textAlignment = .left
        labelValuePhoneNumNgMua.textColor = UIColor.gray
        labelValuePhoneNumNgMua.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelValuePhoneNumNgMua.text = "01208885656"

        
        labelValueAddrNgMua = UILabel(frame: CGRect(x: labelNgMua.frame.origin.x , y: labelValuePhoneNumNgMua.frame.origin.y + labelValuePhoneNumNgMua.frame.size.height +  Common.Size(s:5) , width: viewNgMua.frame.size.width - Common.Size(s: 40), height: Common.Size(s:13)))
        labelValueAddrNgMua.textAlignment = .left
        labelValueAddrNgMua.numberOfLines = 2
        labelValueAddrNgMua.textColor = UIColor.gray
        labelValueAddrNgMua.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelValueAddrNgMua.text = "82 trương định p9 quận 1 tp.hcm"
       
        
        
        
        //////////
        viewNgNhan = UIView(frame: CGRect(x: Common.Size(s: 20),y: viewLine1.frame.origin.y + viewLine1.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width - Common.Size(s: 40), height: Common.Size(s:20) * 4 ))
        viewNgNhan.backgroundColor = UIColor(netHex:0xffffff)
        
        viewLine2 = UIView(frame: CGRect(x:0,y: viewNgNhan.frame.origin.y + viewNgNhan.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width, height: Common.Size(s:1) ))
        viewLine2.backgroundColor = UIColor(netHex:0xe8e8e8)
        
        imageNgNhan = UIImageView(frame: CGRect(x: 0, y: Common.Size(s: 5) , width: Common.Size(s: 20) , height: Common.Size(s: 20) ));
        imageNgNhan.image = UIImage(named:"ic-TTNN.png")
        imageNgNhan.contentMode = UIView.ContentMode.scaleToFill
        
        let strTitleNgNhan = "Thông tin người nhận "
        labelNgNhan = UILabel(frame: CGRect(x: imageNgNhan.frame.size.width + Common.Size(s:5), y: Common.Size(s: 7) , width: viewNgMua.frame.size.width / 2, height: Common.Size(s:13)))
        labelNgNhan.textAlignment = .left
        labelNgNhan.textColor = UIColor.black
        labelNgNhan.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        labelNgNhan.text = strTitleNgNhan
        
        
        btnCall = UIButton(frame: CGRect(x:labelNgNhan.frame.origin.x + labelNgNhan.frame.size.width + Common.Size(s:5) , y: labelNgNhan.frame.origin.y   , width: viewNgMua.frame.size.width / 3 , height: Common.Size(s:20)));
        btnCall.backgroundColor = UIColor(netHex:0x16b88b)
        btnCall.layer.cornerRadius = 10
        btnCall.layer.borderWidth = 1
        btnCall.layer.borderColor = UIColor.white.cgColor
        btnCall.setTitle("Gọi nhanh",for: .normal)
        btnCall.setTitleColor(UIColor(netHex:0xffffff), for: .normal)
        
        
        labelValueNameNgNhan = UILabel(frame: CGRect(x: labelNgNhan.frame.origin.x , y: labelNgNhan.frame.origin.y + labelNgNhan.frame.size.height +  Common.Size(s:5) , width: viewNgNhan.frame.size.width / 2, height: Common.Size(s:13)))
        labelValueNameNgNhan.textAlignment = .left
        labelValueNameNgNhan.textColor = UIColor.gray
        labelValueNameNgNhan.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelValueNameNgNhan.text = ""
        
        labelValuePhoneNumNgNhan = UILabel(frame: CGRect(x: labelNgMua.frame.origin.x , y: labelValueNameNgNhan.frame.origin.y + labelValueNameNgNhan.frame.size.height +  Common.Size(s:5) , width: viewNgMua.frame.size.width / 2, height: Common.Size(s:13)))
        labelValuePhoneNumNgNhan.textAlignment = .left
        labelValuePhoneNumNgNhan.textColor = UIColor.gray
        labelValuePhoneNumNgNhan.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelValuePhoneNumNgNhan.text = ""
        
        labelValueAddrNgNhan = UILabel(frame: CGRect(x: labelNgMua.frame.origin.x , y: labelValuePhoneNumNgNhan.frame.origin.y + labelValuePhoneNumNgNhan.frame.size.height +  Common.Size(s:5) , width: viewNgMua.frame.size.width - Common.Size(s: 40), height: Common.Size(s:13)))
        labelValueAddrNgNhan.textAlignment = .left
        labelValueAddrNgNhan.textColor = UIColor.gray
        labelValueAddrNgNhan.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelValueAddrNgNhan.text = "82 trương định p9 quận 1 tp.hcm"
        
        ///////////////////
        
        viewPhanCong = UIView(frame: CGRect(x: Common.Size(s: 20),y: viewLine2.frame.origin.y + viewLine2.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width - Common.Size(s: 40), height: Common.Size(s:80)))
        viewPhanCong.backgroundColor = UIColor(netHex:0xffffff)
        
        viewLine3 = UIView(frame: CGRect(x:0,y: viewPhanCong.frame.origin.y + viewPhanCong.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width, height: Common.Size(s:1) ))
        viewLine3.backgroundColor = UIColor(netHex:0xe8e8e8)
        
        imagePhanCong = UIImageView(frame: CGRect(x: 0, y: Common.Size(s: 5) , width: Common.Size(s: 20) , height: Common.Size(s: 20) ));
        imagePhanCong.image = UIImage(named:"ic-TTPC.png")
        imagePhanCong.contentMode = UIView.ContentMode.scaleToFill
        
        
        let strTitlePC = "Phân công "
        labelPhanCong = UILabel(frame: CGRect(x: imagePhanCong.frame.size.width + Common.Size(s:5), y: Common.Size(s: 7) , width: viewPhanCong.frame.size.width , height: Common.Size(s:13)))
        labelPhanCong.textAlignment = .left
        labelPhanCong.textColor = UIColor.black
        labelPhanCong.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        labelPhanCong.text = strTitlePC
        
        labelNV = UILabel(frame: CGRect(x: labelPhanCong.frame.origin.x , y: labelPhanCong.frame.origin.y + labelPhanCong.frame.size.height +  Common.Size(s:5) , width: viewNgMua.frame.size.width / 6, height: Common.Size(s:13)))
        labelNV.textAlignment = .left
        labelNV.textColor = UIColor.gray
        labelNV.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelNV.text = "NV Giao:"
        
        
        
        
        companyButton = SearchTextField(frame: CGRect(x: labelNV.frame.origin.x + labelNV.frame.size.width + Common.Size(s: 5), y: labelNV.frame.origin.y , width: viewNgMua.frame.size.width - Common.Size(s:20) -  viewNgMua.frame.size.width / 6  , height: Common.Size(s:20) ));
        
        //companyButton.placeholder = "5387-Phan Thi Ngoc Huyen"
        companyButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.borderStyle = UITextField.BorderStyle.roundedRect
        companyButton.autocorrectionType = UITextAutocorrectionType.no
        companyButton.keyboardType = UIKeyboardType.default
        companyButton.returnKeyType = UIReturnKeyType.done
        companyButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        companyButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        companyButton.startVisible = true
        companyButton.theme.bgColor = UIColor.white
        companyButton.theme.fontColor = UIColor.black
        companyButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.theme.cellHeight = Common.Size(s:40)
       
        labelThuKho = UILabel(frame: CGRect(x: labelNV.frame.origin.x , y: companyButton.frame.origin.y + companyButton.frame.size.height +  Common.Size(s:5) , width: viewNgMua.frame.size.width / 6, height: Common.Size(s:13)))
        labelThuKho.textAlignment = .left
        labelThuKho.textColor = UIColor.gray
        labelThuKho.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelThuKho.text = "NV TK:"
        
        
        companyButton2 = SearchTextField(frame: CGRect(x: labelNV.frame.origin.x + labelNV.frame.size.width + Common.Size(s: 5), y: labelThuKho.frame.origin.y , width: viewNgMua.frame.size.width - Common.Size(s:20) -  viewNgMua.frame.size.width / 6  , height: Common.Size(s:20) ));
        
        //companyButton2.placeholder = "5387-Phan Thi Ngoc Huyen"
        companyButton2.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton2.borderStyle = UITextField.BorderStyle.roundedRect
        companyButton2.autocorrectionType = UITextAutocorrectionType.no
        companyButton2.keyboardType = UIKeyboardType.default
        companyButton2.returnKeyType = UIReturnKeyType.done
        companyButton2.clearButtonMode = UITextField.ViewMode.whileEditing;
        companyButton2.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        companyButton2.startVisible = true
        companyButton2.theme.bgColor = UIColor.white
        companyButton2.theme.fontColor = UIColor.black
        companyButton2.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton2.theme.cellHeight = Common.Size(s:40)
        
        
        ///////////////
        viewThongTin = UIView(frame: CGRect(x: Common.Size(s: 20),y: viewLine3.frame.origin.y + viewLine3.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width - Common.Size(s: 40), height: Common.Size(s:200)))
        viewThongTin.backgroundColor = UIColor(netHex:0xffffff)
        
        
        imageThongTin = UIImageView(frame: CGRect(x: 0, y: Common.Size(s: 5) , width: Common.Size(s: 20) , height: Common.Size(s: 20) ));
        imageThongTin.image = UIImage(named:"ic-TTDH")
        imageThongTin.contentMode = UIView.ContentMode.scaleToFill
        
        
        let strTitleDH = "Thông tin đơn hàng "
        labelThongTinn = UILabel(frame: CGRect(x: imageThongTin.frame.size.width + Common.Size(s:5), y: Common.Size(s: 7) , width: viewPhanCong.frame.size.width , height: Common.Size(s:13)))
        labelThongTinn.textAlignment = .left
        labelThongTinn.textColor = UIColor.black
        labelThongTinn.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        labelThongTinn.text = strTitleDH
        
        
        labelDH = UILabel(frame: CGRect(x: imageThongTin.frame.size.width + Common.Size(s:5), y: labelThongTinn.frame.origin.y + labelThongTinn.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width / 8 , height: Common.Size(s:13)))
        labelDH.textAlignment = .left
        labelDH.textColor = UIColor.gray
        labelDH.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelDH.text = "ĐH :"
        
        labelValueDH = UILabel(frame: CGRect(x: imageThongTin.frame.size.width + Common.Size(s:5) + viewPhanCong.frame.size.width / 8 , y: labelThongTinn.frame.origin.y + labelThongTinn.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width / 4  , height: Common.Size(s:13)))
        labelValueDH.textAlignment = .left
        labelValueDH.textColor = UIColor.black
        labelValueDH.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        labelValueDH.text = "1212323"
        
        labelEcom = UILabel(frame: CGRect(x: labelValueDH.frame.size.width + labelValueDH.frame.origin.x + Common.Size(s:5)  , y: labelThongTinn.frame.origin.y + labelThongTinn.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width / 7 , height: Common.Size(s:13)))
        labelEcom.textAlignment = .left
        labelEcom.textColor = UIColor.gray
        labelEcom.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelEcom.text = "Ecom:"
        
        labelValueEcom = UILabel(frame: CGRect(x: labelEcom.frame.size.width + Common.Size(s:5) + labelEcom.frame.origin.x , y: labelThongTinn.frame.origin.y + labelThongTinn.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width / 4  , height: Common.Size(s:13)))
        labelValueEcom.textAlignment = .left
        labelValueEcom.textColor = UIColor.black
        labelValueEcom.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        labelValueEcom.text = "1212323"
        
        labelTime = UILabel(frame: CGRect(x: imageThongTin.frame.size.width + Common.Size(s:5), y: labelValueEcom.frame.origin.y + labelValueEcom.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width / 2  , height: Common.Size(s:13)))
        labelTime.textAlignment = .left
        labelTime.textColor = UIColor.gray
        labelTime.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelTime.text = "Thời gian giao :"
        
        labelValueTime  = UILabel(frame: CGRect(x: labelTime.frame.size.width, y: labelValueEcom.frame.origin.y + labelValueEcom.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width / 2  , height: Common.Size(s:13)))
        labelValueTime.textAlignment = .left
        labelValueTime.textColor = UIColor.black
        labelValueTime.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        labelValueTime.text = "20/02/2019"
        
        labelValueTimeLest  = UILabel(frame: CGRect(x: labelTime.frame.origin.x, y: labelValueTime.frame.origin.y + labelValueTime.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width   , height: Common.Size(s:13)))
        labelValueTimeLest.textAlignment = .left
        labelValueTimeLest.textColor = UIColor(netHex:0x439b6e)
        labelValueTimeLest.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelValueTimeLest.text = "Thời gian còn lại 20/02/2019"
        
        
        labelUocTinh = UILabel(frame: CGRect(x: labelTime.frame.origin.x, y: labelValueTimeLest.frame.origin.y + labelValueTimeLest.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width   , height: Common.Size(s:13)))
        labelUocTinh.textAlignment = .left
        labelUocTinh.textColor = UIColor.black
        labelUocTinh.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelUocTinh.text = "Ước Tính"
        
//        labelThoiGianUocTinh = UILabel(frame: CGRect(x: labelTime.frame.origin.x, y: labelUocTinh.frame.origin.y + labelUocTinh.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width   , height: Common.Size(s:13)))
//        labelThoiGianUocTinh.textAlignment = .left
//        labelThoiGianUocTinh.textColor = UIColor(netHex:0x439b6e)
//        labelThoiGianUocTinh.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
//        labelThoiGianUocTinh.text = ""
        
        labelKhoangCachUocTinh = UILabel(frame: CGRect(x: labelTime.frame.origin.x, y: labelUocTinh.frame.origin.y + labelUocTinh.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width   , height: Common.Size(s:13)))
        labelKhoangCachUocTinh.textAlignment = .left
        labelKhoangCachUocTinh.textColor = UIColor(netHex:0x439b6e)
        labelKhoangCachUocTinh.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelKhoangCachUocTinh.text = "Khoảng cách:"
        
        
        labelGhiChu  = UILabel(frame: CGRect(x: labelValueTimeLest.frame.origin.x, y: labelKhoangCachUocTinh.frame.origin.y + labelKhoangCachUocTinh.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width / 2  , height: Common.Size(s:13)))
        labelGhiChu.textAlignment = .left
        labelGhiChu.textColor = UIColor.black
        labelGhiChu.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelGhiChu.text = "Ghi Chú"
        
        viewGhiChu =  UIView(frame: CGRect(x: Common.Size(s: 5) ,y: labelGhiChu.frame.origin.y + labelGhiChu.frame.size.height + Common.Size(s: 5) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 50), height: Common.Size(s:50)))
        viewGhiChu.backgroundColor = UIColor.white
        viewGhiChu.layer.borderWidth = 0.5
        viewGhiChu.layer.borderColor = UIColor.black.cgColor
        viewGhiChu.layer.cornerRadius = 5
        
        txtValueGhiChu = UILabel(frame: CGRect(x: 0 ,y: 0 ,width:viewGhiChu.frame.size.width, height: Common.Size(s:50)))
        txtValueGhiChu.contentMode = .scaleToFill
        txtValueGhiChu.numberOfLines = 0
        txtValueGhiChu.textColor = UIColor.gray
        txtValueGhiChu.text = ""
        txtValueGhiChu.textAlignment = .left
        txtValueGhiChu.font = UIFont.systemFont(ofSize: Common.Size(s:9))
        
        
        
        tableViewSP.frame = CGRect(x: 0 ,y: viewThongTin.frame.origin.y + viewThongTin.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width , height: Common.Size(s:100))
        tableViewSP.tableFooterView = UIView()
        tableViewSP.backgroundColor = UIColor.white
        
       
        
        viewItemDH =  UIView(frame: CGRect(x: 0 ,y: viewThongTin.frame.origin.y + viewThongTin.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width , height: Common.Size(s:100)))
        viewItemDH.backgroundColor = UIColor(netHex:0xf2f2f2)
        
        labelItemDHName = UILabel(frame: CGRect(x: Common.Size(s: 10) ,y: Common.Size(s: 10) ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelItemDHName.numberOfLines = 1
        labelItemDHName.text = "HuaWei P9 - Hong"
        labelItemDHName.textAlignment = .center
        labelItemDHName.textColor = UIColor.black
        labelItemDHName.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        labelItemDHImei = UILabel(frame: CGRect(x: Common.Size(s: 10) ,y: labelItemDHName.frame.origin.y +  labelItemDHName.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelItemDHImei.numberOfLines = 1
        labelItemDHImei.text = "02235234543534"
        labelItemDHImei.textAlignment = .center
        labelItemDHImei.textColor = UIColor.gray
        labelItemDHImei.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        
        labelItemDHSL = UILabel(frame: CGRect(x: labelItemDHName.frame.origin.x +  labelItemDHName.frame.size.width  ,y: Common.Size(s: 10) ,width:UIScreen.main.bounds.size.width  / 4, height: Common.Size(s:30)))
        labelItemDHSL.numberOfLines = 1
        labelItemDHSL.text = "x 2"
        labelItemDHSL.textAlignment = .center
        labelItemDHSL.textColor = UIColor.gray
        labelItemDHSL.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        
        labelItemDHGia = UILabel(frame: CGRect(x: labelItemDHSL.frame.origin.x +  labelItemDHSL.frame.size.width  ,y: Common.Size(s: 10) ,width:UIScreen.main.bounds.size.width  / 4, height: Common.Size(s:30)))
        labelItemDHGia.numberOfLines = 1
        labelItemDHGia.text = "20.0000"
        labelItemDHGia.textAlignment = .center
        labelItemDHGia.textColor = UIColor.red
        labelItemDHGia.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        viewTongDH =  UIView(frame: CGRect(x: 0 ,y: viewItemDH.frame.origin.y + viewItemDH.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width , height: Common.Size(s:60)))
        viewTongDH.backgroundColor = UIColor(netHex:0xffffff)
        
        labelTongDHText = UILabel(frame: CGRect(x: Common.Size(s:30)  ,y: Common.Size(s: 10) ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelTongDHText.numberOfLines = 1
        labelTongDHText.text = "Tổng đơn hàng :"
        labelTongDHText.textAlignment = .left
        labelTongDHText.textColor = UIColor.gray
        labelTongDHText.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        labelTienGiamText = UILabel(frame: CGRect(x: Common.Size(s:30)  ,y: labelTongDHText.frame.origin.y + labelTongDHText.frame.size.height ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelTienGiamText.numberOfLines = 1
        labelTienGiamText.text = "Tiền giảm :"
        labelTienGiamText.textAlignment = .left
        labelTienGiamText.textColor = UIColor.gray
        labelTienGiamText.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        labelDatCocText = UILabel(frame: CGRect(x: Common.Size(s:30)  ,y: labelTienGiamText.frame.origin.y + labelTienGiamText.frame.size.height ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelDatCocText.numberOfLines = 1
        labelDatCocText.text = "Đặt cọc :"
        labelDatCocText.textAlignment = .left
        labelDatCocText.textColor = UIColor.gray
        labelDatCocText.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        labelPhaiThuText = UILabel(frame: CGRect(x: Common.Size(s:30)  ,y: labelDatCocText.frame.origin.y + labelDatCocText.frame.size.height ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelPhaiThuText.numberOfLines = 1
        labelPhaiThuText.text = "Phải thu :"
        labelPhaiThuText.textAlignment = .left
        labelPhaiThuText.textColor = UIColor.gray
        labelPhaiThuText.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        
        labelTongDHValue = UILabel(frame: CGRect(x: labelTongDHText.frame.origin.x + labelTongDHText.frame.size.width   ,y: labelTongDHText.frame.origin.y ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelTongDHValue.numberOfLines = 1
        labelTongDHValue.text = "0 đ"
        labelTongDHValue.textAlignment = .left
        labelTongDHValue.textColor = UIColor.gray
        labelTongDHValue.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        labelTienGiamValue = UILabel(frame: CGRect(x: labelTienGiamText.frame.origin.x + labelTienGiamText.frame.size.width   ,y: labelTienGiamText.frame.origin.y  ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelTienGiamValue.numberOfLines = 1
        labelTienGiamValue.text = "0 đ"
        labelTienGiamValue.textAlignment = .left
        labelTienGiamValue.textColor = UIColor.gray
        labelTienGiamValue.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        labelDatCocValue = UILabel(frame: CGRect(x: labelDatCocText.frame.origin.x + labelDatCocText.frame.size.width   ,y: labelDatCocText.frame.origin.y  ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelDatCocValue.numberOfLines = 1
        labelDatCocValue.text = "0 đ"
        labelDatCocValue.textAlignment = .left
        labelDatCocValue.textColor = UIColor.gray
        labelDatCocValue.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        labelPhaiThuValue = UILabel(frame: CGRect(x: labelPhaiThuText.frame.origin.x + labelPhaiThuText.frame.size.width   ,y: labelPhaiThuText.frame.origin.y  ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelPhaiThuValue.numberOfLines = 1
        labelPhaiThuValue.text = "100.0000 đ"
        labelPhaiThuValue.textAlignment = .left
        labelPhaiThuValue.textColor = UIColor.red
        labelPhaiThuValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        
        
        
        btnXacNhan = UIButton(frame: CGRect(x: (UIScreen.main.bounds.size.width - (UIScreen.main.bounds.size.width * 6 / 7)) / 2, y: scrollView.frame.origin.y + scrollView.bounds.size.height + Common.Size(s: 5)  , width: UIScreen.main.bounds.size.width * 6 / 7 , height: Common.Size(s:40)));
//        btnXacNhan.backgroundColor = UIColor(netHex:0x107add)
//         btnXacNhan.backgroundColor = UIColor.red
        btnXacNhan.backgroundColor = UIColor.mainGreen
        btnXacNhan.layer.cornerRadius = 10
        btnXacNhan.layer.borderWidth = 1
        btnXacNhan.layer.borderColor = UIColor.white.cgColor
        btnXacNhan.setTitle("",for: .normal)
        btnXacNhan.setTitleColor(UIColor(netHex:0xffffff), for: .normal)
        
        viewInput = InputTextView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        viewInput.inputTextViewDelegate = self
        
        viewXacNhan = InputViewXacNhan.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        viewXacNhan.inputViewXacNhanDelegate = self
        
        viewProcess = ProcessView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        
        viewProcess.isHidden = true
        
        
        self.view.addSubview(scrollView)
        self.view.addSubview(btnXacNhan)
        self.view.addSubview(self.khachNHButton)
        self.view.addSubview(self.khachKhongNHButton)
        self.scrollView.addSubview(viewNgMua)
        self.viewNgMua.addSubview(imageNgMua)
        self.viewNgMua.addSubview(labelNgMua)
        self.viewNgMua.addSubview(labelValueNameNgMua)
        self.viewNgMua.addSubview(labelValueAddrNgMua)
        self.viewNgMua.addSubview(labelValuePhoneNumNgMua)
        self.scrollView.addSubview(viewLine1)
        self.scrollView.addSubview(viewLine2)
        self.scrollView.addSubview(viewNgNhan)
        self.scrollView.addSubview(viewPhanCong)
        
        self.viewNgNhan.addSubview(btnCall)
        self.viewNgNhan.addSubview(imageNgNhan)
        self.viewNgNhan.addSubview(labelNgNhan)
        self.viewNgNhan.addSubview(labelValueNameNgNhan)
        self.viewNgNhan.addSubview(labelValueAddrNgNhan)
        self.viewNgNhan.addSubview(labelValuePhoneNumNgNhan)
        
        
        self.viewPhanCong.addSubview(imagePhanCong)
        self.viewPhanCong.addSubview(labelPhanCong)
        self.viewPhanCong.addSubview(labelNV)
        self.viewPhanCong.addSubview(companyButton)
        self.viewPhanCong.addSubview(labelThuKho)
        self.viewPhanCong.addSubview(companyButton2)
        self.scrollView.addSubview(viewLine3)
        
        self.scrollView.addSubview(viewThongTin)
        
        self.viewThongTin.addSubview(labelUocTinh)
        self.viewThongTin.addSubview(labelThongTinn)
        self.viewThongTin.addSubview(imageThongTin)
        self.viewThongTin.addSubview(labelDH)
        self.viewThongTin.addSubview(labelValueDH)
        self.viewThongTin.addSubview(labelEcom)
        
        self.viewThongTin.addSubview(labelValueEcom)
        self.viewThongTin.addSubview(labelTime)
        self.viewThongTin.addSubview(labelValueTime)
        self.viewThongTin.addSubview(labelValueTimeLest)
        self.viewThongTin.addSubview(labelGhiChu)
        self.viewThongTin.addSubview(viewGhiChu)
        
       
        self.viewThongTin.addSubview(labelKhoangCachUocTinh)
        
        self.viewGhiChu.addSubview(txtValueGhiChu)
        
        
        
        
        //self.scrollView.addSubview(viewItemDH)
        self.viewItemDH.addSubview(labelItemDHName)
       
        self.viewItemDH.addSubview(labelItemDHImei)
        self.viewItemDH.addSubview(labelItemDHGia)
        self.viewItemDH.addSubview(labelItemDHSL)
        
        self.scrollView.addSubview(viewTongDH)
        self.viewTongDH.addSubview(labelPhaiThuText)
        self.viewTongDH.addSubview(labelDatCocText)
        self.viewTongDH.addSubview(labelTongDHText)
        self.viewTongDH.addSubview(labelTienGiamText)
        
        self.viewTongDH.addSubview(labelPhaiThuValue)
        self.viewTongDH.addSubview(labelDatCocValue)
        self.viewTongDH.addSubview(labelTongDHValue)
        self.viewTongDH.addSubview(labelTienGiamValue)
        
        self.view.addSubview(viewInput)
        self.view.addSubview(viewXacNhan)
        
        self.scrollView.addSubview(tableViewSP)
        
        
        
        self.tableViewSP.register(ItemSPMuaTableViewCell.self, forCellReuseIdentifier: "ItemSPMuaTableViewCell")
        self.tableViewSP.dataSource = self
        self.tableViewSP.delegate = self
        
         self.btnCall.addTarget(self, action: #selector(self.ClickCall), for: .touchUpInside)
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTongDH.frame.origin.y + viewTongDH.frame.size.height + 100 )
        
        self.view.addSubview(viewProcess)
        
        self.khachKhongNHButton.snp.makeConstraints { make in
            make.leading.equalTo(self.btnXacNhan).offset(-10)
            make.height.equalTo(40)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.trailing.equalTo(self.view.snp.centerX).offset(-5)
        }
        self.khachNHButton.snp.makeConstraints { make in
            make.leading.equalTo(self.view.snp.centerX).offset(5)
            make.height.equalTo(40)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.width.equalTo((self.btnXacNhan.frame.width / 2) - 1)
        }
        
    }
    
    
    
   @objc func ClickCall()
    {
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
    
    
    
    func GetResultSetSORejected(docNum: String, userCode:String, reason:String)
    {
        MDeliveryAPIService.GetDataSetSORejected(docNum: docNum, userCode:userCode, reason:reason){ (error: Error?, success: Bool, result: ConfirmThuKhoResult!) in
            if success
            {
                if(result != nil )
                {
                 
                    _ = self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                    Toast(text: "\(result.Descriptionn)").show()
                }
                
                
                
            }
            else
            {
                
            }
        }
        
        
        
    }
    
    
}

extension ChiTietDonHangViewController : PopUpKhachKhongNhanHangViewControllerDelegate {
    func xacNhanHandle(content: String) {
        
    }

}


class ItemSPMuaTableViewCell: UITableViewCell {
    
    
    
    var txtValueTenSP: UILabel!
    var txtValueImeiSP: UILabel!
    var txtValueSLSP: UILabel!
    var txtValuePriceSP: UILabel!
    
   
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(netHex:0xededee)
        
        txtValueTenSP = UILabel()
        txtValueTenSP.textColor = UIColor(netHex:0x000000)
        txtValueTenSP.numberOfLines = 2
        txtValueTenSP.textAlignment =  .left
        txtValueTenSP.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(txtValueTenSP)
        
        txtValueImeiSP = UILabel()
        txtValueImeiSP.textColor = UIColor.gray
        txtValueImeiSP.numberOfLines = 1
        txtValueImeiSP.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        txtValueImeiSP.textAlignment =  .left
        contentView.addSubview(txtValueImeiSP)
        
        txtValueSLSP = UILabel()
        txtValueSLSP.textColor = UIColor.gray
        txtValueSLSP.numberOfLines = 1
        txtValueSLSP.textAlignment =  .center
        txtValueSLSP.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(txtValueSLSP)
        
        
        txtValuePriceSP = UILabel()
        txtValuePriceSP.textColor = UIColor.red
        txtValuePriceSP.numberOfLines = 1
        txtValuePriceSP.textAlignment =  .right
        txtValuePriceSP.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(txtValuePriceSP)
        
        
        
        
        
        txtValueTenSP.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width / 2 ,height: Common.Size(s:30))
        
        
        txtValueImeiSP.frame = CGRect(x:Common.Size(s:10) ,y: txtValueTenSP.frame.origin.y + txtValueTenSP.frame.size.height + Common.Size(s:5)  ,width: txtValueTenSP.frame.size.width ,height: Common.Size(s:13))
        
        
        txtValueSLSP.frame = CGRect(x:UIScreen.main.bounds.size.width / 2 + Common.Size(s:10)  ,y: txtValueTenSP.frame.origin.y + txtValueTenSP.frame.size.height / 2 ,width: UIScreen.main.bounds.size.width / 4 ,height: Common.Size(s:13))
        
        txtValuePriceSP.frame = CGRect(x:UIScreen.main.bounds.size.width / 3 + UIScreen.main.bounds.size.width / 4 + Common.Size(s:10)  ,y: txtValueTenSP.frame.origin.y + txtValueTenSP.frame.size.height / 2 ,width: UIScreen.main.bounds.size.width / 3 ,height: Common.Size(s:13))
        
        
        
    }
    
    
   
    
}

