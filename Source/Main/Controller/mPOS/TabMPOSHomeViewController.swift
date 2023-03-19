    //
    //  TabMPOSHomeViewController.swift
    //  fptshop
    //
    //  Created by Duong Hoang Minh on 12/17/18.
    //  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
    //

import Foundation
import UIKit
import MIBadgeButton_Swift
import PopupDialog
import KeychainSwift
import Kingfisher
import AVFoundation
import ImageSlideshow
import Kingfisher
import Flutter
import FlutterPluginRegistrant
class TabMPOSHomeViewController: BaseController,SearchDelegate,ActionHandleFilter, UIGestureRecognizerDelegate {
    var arrSection = [Section]()
    var tableView: UITableView!
    var viewHeader:UIView!
    var btCartIcon:MIBadgeButton!
    var btBackIcon:MIBadgeButton!
    var slideshow: ImageSlideshow!
    var window:UIWindow!
    private var channel: FlutterMethodChannel?

    var checkInOutBtn: UIButton!
    var isCheckIn = false
    var isCheckOut = false
    var shiftCode: String = ""
    var type: Int = 1
    var listKhaoSat = [ItemKhaoSatMienTrung]()
    var isloadview: Bool = false

    var listBanner = [Sumary_TinTuc]()
    var htmlContentNoti:String = ""
    var isReloadBtnInout = false
    var numberTypeCheck = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bán hàng"
        numberTypeCheck = 0
        self.isReloadBtnInout = false
        self.initNavigationBar()
        getUserKiemTraInOut()
        initSections()
        initHeader()
        loadHtmlContentNotiSauChamCong()
        initTableView()
        let width = UIScreen.main.bounds.size.width

            //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        btBackIcon = MIBadgeButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "notification"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(TabMPOSHomeViewController.actionNotification), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -5, y: 0, width: 30, height: 50)

        viewLeftNav.addSubview(btBackIcon)
            //---

        let searchField = UITextField(frame: CGRect(x: 30, y: 20, width: width, height: 35))
        searchField.placeholder = "Sản phẩm cần tìm?"
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 5

        searchField.leftViewMode = .always
        let searchImageViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let searchImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        let search = UIImage(named: "search", in: Bundle(for: YNSearch.self), compatibleWith: nil)
        searchImageView.image = search
        searchImageViewWrapper.addSubview(searchImageView)
        searchField.leftView = searchImageViewWrapper

        searchField.rightViewMode = .always
        let searchImageRight = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        let searchImageViewRight = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        let scan = UIImage(named: "scan_barcode")
        searchImageViewRight.image = scan
        searchImageRight.addSubview(searchImageViewRight)
        searchField.rightView = searchImageRight
        let gestureSearchImageRight = UITapGestureRecognizer(target: self, action:  #selector(self.actionScan))
        searchImageRight.addGestureRecognizer(gestureSearchImageRight)
        self.navigationItem.titleView = searchField
        searchField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
            //        searchField.isUserInteractionEnabled = false
            //---

            //---
        let viewFilter = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))

        let btFilterIcon = UIButton.init(type: .custom)
        btFilterIcon.setImage(#imageLiteral(resourceName: "Filter"), for: UIControl.State.normal)
        btFilterIcon.imageView?.contentMode = .scaleAspectFit
        btFilterIcon.addTarget(self, action: #selector(TabMPOSHomeViewController.actionFilter), for: UIControl.Event.touchUpInside)
        btFilterIcon.frame = CGRect(x: 5, y: 0, width: 30, height: 50)
        viewFilter.addSubview(btFilterIcon)
            //---

            //---
        let viewRightNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.rightBarButtonItems  = [UIBarButtonItem(customView: viewRightNav),UIBarButtonItem(customView: viewFilter)]
        btCartIcon = MIBadgeButton.init(type: .custom)
        btCartIcon.setImage(#imageLiteral(resourceName: "cart"), for: UIControl.State.normal)
        btCartIcon.imageView?.contentMode = .scaleAspectFit
        btCartIcon.addTarget(self, action: #selector(MPOSMainViewController.actionCart), for: UIControl.Event.touchUpInside)
        btCartIcon.frame = CGRect(x: -5, y: 0, width: 50, height: 45)
        viewRightNav.addSubview(btCartIcon)
            //---
        NotificationCenter.default.removeObserver(self, name: Notification.Name("showDetailSO"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("showDetailSOCardTopup"), object: nil)
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(showDetailSOCardTopup), name: Notification.Name("showDetailSOCardTopup"), object: nil)
        nc.addObserver(self, selector: #selector(showDetailSO), name: Notification.Name("showDetailSO"), object: nil)
        nc.addObserver(self, selector: #selector(self.autoLoadCMND), name: Notification.Name("AutoLoadCMND"), object: nil)
        nc.addObserver(self, selector: #selector(updateNumberNotification), name: Notification.Name("updateNumberNotification"), object: nil)
        nc.addObserver(self, selector: #selector(logoutNotification), name: Notification.Name("logoutNotification"), object: nil)
        nc.addObserver(self, selector: #selector(openNotification), name: Notification.Name("openNotification"), object: nil)
        nc.addObserver(self, selector: #selector(showSearchCMNDMirae), name: Notification.Name("SearchCMNDMirae"), object: nil)
        nc.addObserver(self, selector: #selector(showViettelPay), name: Notification.Name("viettelPayView"), object: nil)
        nc.addObserver(self, selector: #selector(cameraNotification), name: Notification.Name("cameraNotification"), object: nil)
        nc.addObserver(self, selector: #selector(miraeNotification), name: Notification.Name("miraeNotification"), object: nil)
        nc.addObserver(self, selector: #selector(showSearchCMNDMiraeHistory), name: Notification.Name("SearchCMNDMiraeHistory"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didCloseMienTrungSurvey(notification:)), name: NSNotification.Name.init("didCloseSurvey"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didClosePopUpMessageViewV2(notification:)), name: NSNotification.Name.init("didClosePopUpMessageViewV2"), object: nil)
        print("AAAAAAAA")

        MPOSAPIManager.getAllCompanyAmortizations { (results, err) in
            if(err.count <= 0){
                Cache.companyAmortizations = results
            }
        }
            //        self.showPopUp()

        MultipleChoiceApiManager.shared.getUserInfoExam { [weak self] item, error in
            guard let self = self else {return}
            if item?.IsExam ?? false{
                let vc = ExamVC()
                vc.examCode = item?.ExamCode ?? -1
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            } else {
                CRMAPIManager.GetSurveyQuestion { (rs, err) in
                    if err.count <= 0 {
                        if rs.count > 0 {
                            self.listKhaoSat = rs

                            let surveyMienTrungVC = UngHoMienTrungVC()
                            surveyMienTrungVC.listKhaoSat = self.listKhaoSat

                                //                            let navController = UINavigationController(rootViewController: surveyMienTrungVC)
                                //                            self.navigationController?.present(navController, animated:false, completion: nil)
                            self.navigationController?.pushViewController(surveyMienTrungVC, animated: false)
                        } else {
                            self.showPopUp()
                        }

                    } else {
                            //Error
                        self.showPopUp()
                    }
                }
            }
        }

        loadBanners()
    }

    @objc func slideshowDidTap() {
        guard slideshow.currentPage < listBanner.count else { return }
        let vc = NewsDetailViewController()
        vc.newsID = listBanner[slideshow.currentPage].id
        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func loadBanners() {
        MPOSAPIManager.getTinTuc_New(limit: "3") { (rs, err) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                NotificationCenter.default.post(name: Notification.Name("dismissLoading"), object: nil)
                if err.count <= 0 {
                    if rs.count > 0 {
                        self.listBanner = rs.first(where: { $0.idLoaiTin == "0355a87a-6854-4cb5-afec-57343b70e335" })?.listSummary ?? []
                        self.listBanner = self.listBanner.filter { !$0.imgBanner.isEmpty }
                        self.setUp3GiaTriCotLoi()
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "Không có dữ liệu tin tức!", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

    @objc func showSearchCMNDMiraeHistory(notification:Notification) -> Void {


        let newViewController = SearchLichSuMiraeViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func showViettelPay(notification:Notification) -> Void {


        let newViewController = ViettelPayMenuViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func miraeNotification(notification:Notification) -> Void {
        let newViewController = TabLichSuViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func showSearchCMNDMirae(notification:Notification) -> Void {


        let newViewController = MiraeMenuViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }

    @objc func cameraNotification(notification:Notification) -> Void {
        let dict = notification.object as! NSDictionary
        if let Message = dict["Message"] as? String{
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                let newViewController = CameraNotifyViewController()
                newViewController.noiDung = Message
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
        }
    }
    @objc func openNotification(){
        if let System_Name = Cache.dataNotificationOpen["System_Name"]{
            if("\(System_Name)" == "Inside"){
                if let Url = Cache.dataNotificationOpen["Url"] {
                    print("System_Name \(System_Name) \(Url)")
                    let nc = NotificationCenter.default
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        let myDict = ["INSIDE_URL": Url]
                        nc.post(name: Notification.Name("showTabInside"), object: myDict)
                    }
                }else{
                    let newViewController = MPOSNotificationViewController()
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
            }else if("\(System_Name)".prefix(4) == "MPOS"){
				guard let name:String = System_Name as? String else { return }
				let id:Int = Int(name.chopPrefix(5)) ?? 0
                if let Message = Cache.dataNotificationOpen["Message"] as? String{
					print("System_Name \(System_Name) \(Message)")
					let when = DispatchTime.now() + 0.5
					DispatchQueue.main.asyncAfter(deadline: when) {
						let vc = PopUpDanhGiaVC()
						vc.id = id
						vc.modalPresentationStyle = .overCurrentContext
						vc.modalTransitionStyle = .crossDissolve
						self.navigationController?.present(vc, animated: true)
					}
				}
			}else if("\(System_Name)" == "Camera"){
				if let Message = Cache.dataNotificationOpen["Message"] as? String{
					print("System_Name \(System_Name) \(Message)")

					let when = DispatchTime.now() + 0.5
					DispatchQueue.main.asyncAfter(deadline: when) {
						let newViewController = CameraNotifyViewController()
						newViewController.noiDung = Message
						self.navigationController?.pushViewController(newViewController, animated: true)
					}
				}
			} else if("\(System_Name)" == "CMS"){
                if let Url = Cache.dataNotificationOpen["Url"] as? String{
                    print("System_Name \(System_Name) \(Url)")
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        let newViewController = NewsDetailViewController()
                        newViewController.newsID = Url
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }
                }else{
                    let newViewController = MPOSNotificationViewController()
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
            } else{
                let newViewController = MPOSNotificationViewController()
                self.navigationController?.pushViewController(newViewController, animated: true)
            }

        }else{
            let newViewController = MPOSNotificationViewController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }

    func showPopUp() {
        if(Cache.user?.is_popup == "Y"){
            let myVC = PopUpMessageViewV2()
            myVC.onClose = {
                Provider.shared.listSmApiService.getData(success: { [weak self] result in
                    guard let self = self, let response = result else { return }
                    if response.success && (response.data?.template != "" && response.data?.template != nil) {
                        let vc = CheckListSMVC()
                        vc.onClosePage = {
                            self.checkTaiLieu()
                        }
                        vc.disPlayData = response.data
                        vc.modalTransitionStyle = .crossDissolve
                        vc.modalPresentationStyle = .overCurrentContext
                        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

                        if var topController = keyWindow?.rootViewController {
                            while let presentedViewController = topController.presentedViewController {
                                topController = presentedViewController
                            }

                            topController.present(vc, animated: true, completion: nil)
                        }
                    } else {
                        self.checkTaiLieu()
                    }

                }, failure: { [weak self] error in
                    self?.checkTaiLieu()
                })
            }
            let navController = UINavigationController(rootViewController: myVC)
            self.navigationController?.present(navController, animated:false, completion: nil)
        } else {

        }
    }

    func checkTaiLieu() {
        if Date().getDayOfWeek() == 3 ||
            Date().getDayOfWeek() == 4 ||
            Date().getDayOfWeek() == 6 ||
            Date().getDayOfWeek() == 7 {
            MPOSAPIManager.thong_bao_tai_lieu { (result, err) in
                if(err.count <= 0){
                    let vc = DocumentNoticeViewController()
                    vc.disPlayData = result

                    let navController = UINavigationController(rootViewController: vc)
                    self.navigationController?.present(navController, animated:false, completion: nil)
                } else {

                }
            }
        }
    }

    @objc func didCloseMienTrungSurvey(notification:Notification) -> Void {
        showPopUp()
    }

    @objc func didClosePopUpMessageViewV2(notification:Notification) -> Void {
        if self.checkShift() == true {
            if checkInOutBtn.tag == 0 { // chưa checkin
                debugPrint("let's auto Check-in")
                self.autoCheckInFirstLogin()
            } else {
                debugPrint("did Check-in")
            }
        }
    }

    @objc func logoutNotification(notification:Notification) -> Void {
        let dict = notification.object as! NSDictionary
        if let key_1 = dict["key_1"] as? String{
            if(key_1 == "logout"){
                let popup = PopupDialog(title: "Thông báo", message: "Có người đã đăng nhập tài khoản của bạn trên thiết bị khác. Vui lòng đăng nhập lại để tiếp tục sử dụng...", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "OK") {
                    let defaults = UserDefaults.standard
                    defaults.removeObject(forKey: "UserName")
                    defaults.removeObject(forKey: "Password")
                    defaults.removeObject(forKey: "mDate")
                    defaults.removeObject(forKey: "mCardNumber")
                    defaults.removeObject(forKey: "typePhone")
                    defaults.removeObject(forKey: "mPrice")
                    defaults.removeObject(forKey: "mPriceCardDisplay")
                    defaults.removeObject(forKey: "CRMCode")
                    defaults.synchronize()
                    APIManager.removeDeviceToken()
                    let mainViewController = LoginViewController()
                    UIApplication.shared.keyWindow?.rootViewController = mainViewController
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }

        }
    }
    @objc func updateNumberNotification(notification:Notification) -> Void {
        let dict = notification.object as! NSDictionary
        debugPrint(dict)
        if let badge = dict["badge"] as? Int{
            if(badge != 0){
                if(btBackIcon != nil){
                    btBackIcon.badgeString = "\(badge)"
                    btBackIcon.badgeTextColor = UIColor.white
                    btBackIcon.badgeEdgeInsets = UIEdgeInsets(top: 11, left: 0, bottom: 0, right: 5)
                }
            }else{
                if(btBackIcon != nil){
                    btBackIcon.badgeString = ""
                }
            }
        }
    }
    func pushViewFilter(_ sort: String, _ sortPriceFrom: Float, _ sortPriceTo: Float, _ sortGroupName: String, _ sortManafacture: String, _ u_ng_code:String, _ inventory:String) {
        let newViewController = ProductsFilterViewController()
        newViewController.sortBonus = "\(sort)"
        newViewController.sortPriceFrom = sortPriceFrom
        newViewController.sortPriceTo = sortPriceTo
        newViewController.sortGroup = "\(sortGroupName)"
        newViewController.sortManafacture = "\(sortManafacture)"
        newViewController.u_ng_code = u_ng_code
        newViewController.inventory = inventory
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func actionFilter() {
        let newViewController = FilterViewController()
        newViewController.handleFilterDelegate = self
        let nav1 = UINavigationController()
        nav1.viewControllers = [newViewController]
        self.present(nav1, animated: true, completion: nil)
    }
    @objc func actionNotification() {
        let newViewController = MPOSNotificationViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func autoLoadCMND(notification:Notification) -> Void {
        let dict = notification.object as! NSDictionary
        if let cmnd = dict["CMND"] as? String{
            let newViewController = FFriendViewController()
            newViewController.CMND = cmnd
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    @objc func showDetailSOCardTopup(notification:Notification) -> Void {
        let vc = ViewPaymentCardViewController()
        vc.promotionSimActive = Cache.itemPromotionActivedSim
        vc.itemPrice = Cache.itemPriceCardTopup
        vc.listVoucher = Cache.listVoucherCardTopup
        vc.typeCashPayment = Cache.typeCashPaymentCardTopup
        vc.typeCardPayment = Cache.typeCardPaymentCardTopup
        vc.ValuePromotion = Cache.ValuePromotionCardTopup
        vc.quantityValue = Cache.quantityValueCardTopup
        vc.phone = Cache.phoneCardTopup
        vc.type = Cache.typeCardTopup
        vc.cashValue = Cache.cashValueCardTopup
        vc.cardValue = Cache.cardValueCardTopup
        vc.payooPayCodeResult = Cache.payooPayCodeResult
        vc.payooPayCodeHeaderResult = Cache.payooPayCodeHeaderResult
        vc.theCaoVietNamMobile = Cache.theCaoVietNamMobile
        vc.theCaoVietNamMobileHeaders = Cache.theCaoVietNamMobileHeaders
        vc.payooTopupResult = Cache.payooTopupResultCardTopup
        vc.viettelPayCodeResult = Cache.viettelPayCodeResult
        vc.viettelTopup = Cache.viettelTopup
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated: true, completion: nil)
    }
    @objc func showDetailSO(notification:Notification) -> Void {
        let newViewController = ViewSODetailViewController()
        newViewController.carts = Cache.cartsTemp
        newViewController.itemsPromotion = Cache.itemsPromotionTemp
        newViewController.phone = Cache.phoneTemp
        newViewController.name = Cache.nameTemp
        newViewController.address = Cache.addressTemp
        newViewController.email = Cache.emailTemp
        newViewController.type = Cache.docTypeTemp
        newViewController.note = Cache.noteTemp
        newViewController.payment = Cache.payTypeTemp
        newViewController.docEntry = Cache.docEntry
        newViewController.orderPayType = Cache.orderPayTypeTemp
        newViewController.orderPayInstallment = Cache.orderPayInstallmentTemp
        newViewController.valueInterestRate = Cache.valueInterestRateTemp
        newViewController.valuePrepay = Cache.valuePrepayTemp
        newViewController.orderType = Cache.orderTypeTemp
        newViewController.debitCustomer = Cache.debitCustomerTemp
        newViewController.phoneNumberBookSim = Cache.phoneNumberBookSimTemp
        newViewController.gender = Cache.genderTemp
        newViewController.birthday = Cache.birthdayTemp
        let navController = UINavigationController(rootViewController: newViewController)
        self.present(navController, animated: true, completion: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ProgressView.shared.hide()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.isHidden = false
        let sum = Cache.carts.count
        if(sum > 0){
            btCartIcon.badgeString = "\(sum)"
            btCartIcon.badgeTextColor = UIColor.white
            btCartIcon.badgeEdgeInsets = UIEdgeInsets(top: 11, left: 0, bottom: 0, right: 12)
        }else{
            btCartIcon.badgeString = ""
        }
        Cache.INSIDE_URL = "https://insidenew.fptshop.com.vn"
        let keychain = KeychainSwift()
        if let isOpenNotification =  keychain.getBool("isOpenNotification"){
            if(isOpenNotification){
                keychain.delete("isOpenNotification")
                if let System_Name = Cache.dataNotificationOpen["System_Name"]{
                    if("\(System_Name)" == "Inside"){
                        if let Url = Cache.dataNotificationOpen["Url"] {
                            print("System_Name \(System_Name) \(Url)")
                            let nc = NotificationCenter.default
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                let myDict = ["INSIDE_URL": Url]
                                nc.post(name: Notification.Name("showTabInside"), object: myDict)
                            }
                        }else{
                            let newViewController = MPOSNotificationViewController()
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }
                    }else if("\(System_Name)" == "Camera"){
                        if let Message = Cache.dataNotificationOpen["Message"] as? String{
                            print("System_Name \(System_Name) \(Message)")
                                //                            let nc = NotificationCenter.default
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                let newViewController = CameraNotifyViewController()
                                newViewController.noiDung = Message
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }
                        }
                    } else if("\(System_Name)" == "CMS"){
                        if let Url = Cache.dataNotificationOpen["Url"] as? String{
                            print("System_Name \(System_Name) \(Url)")
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                let newViewController = NewsDetailViewController()
                                newViewController.newsID = Url
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }
                        }
                    } else {
                        let newViewController = MPOSNotificationViewController()
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }

                }else{
                    let newViewController = MPOSNotificationViewController()
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
                    //                    if let message = Cache.dataNotificationOpen["Message"] {

                    //                    }
                    //                }
            }
        }
        if(UIApplication.shared.applicationIconBadgeNumber > 0){
            btBackIcon.badgeString = "\(UIApplication.shared.applicationIconBadgeNumber)"
            btBackIcon.badgeTextColor = UIColor.white
            btBackIcon.badgeEdgeInsets = UIEdgeInsets(top: 11, left: 0, bottom: 0, right: 5)
        }else{
            btBackIcon.badgeString = ""
        }
            ////

        setUp3GiaTriCotLoi()
        if self.checkInOutBtn != nil && isReloadBtnInout == true {
            self.getUserKiemTraInOut()

        }else {
            isReloadBtnInout = true
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(showDetailSO), name: Notification.Name("showDetailSO"), object: nil)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true

        NotificationCenter.default.removeObserver(self, name: Notification.Name("pushNewView"), object: nil)
    }

    internal func pushToViewController(id: String, ruleType: String) {
        var checkModuleUpdate = false
        printLog(function: #function, json: "Opne Tab mPOS")

        guard let listModule = UserDefaults.standard.getListUpdate() else {
            printLog(function: #function, json: "No have list module")
            self.gotoModule(rule: ruleType, id: id)
            return
        }
        let array = listModule.components(separatedBy: ",")
        let listArrayModule = array.map { String($0)}

        for module in listArrayModule {
            if module == ruleType {
                checkModuleUpdate = true
                break
            }
        }

        if checkModuleUpdate {
            if let updateRootVersion = UserDefaults.standard.getIsUpdateVersionRoot() {
                if updateRootVersion {
                    guard let description = UserDefaults.standard.getUpdateDescription() else { return }
                    self.showPopUpCustom(title: "Thông báo", titleButtonOk: "Cập nhật", titleButtonCancel: nil, message: description, actionButtonOk: {
                        guard let url = URL(string: "\(Config.manager.URL_UPDATE!)") else {
                            return
                        }

                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }, actionButtonCancel: nil, isHideButtonOk: false, isHideButtonCancel: true)
                } else {
                    guard let description = UserDefaults.standard.getUpdateDescription() else { return }
                    self.showPopUpCustom(title: "Thông báo", titleButtonOk: "Cập nhật", titleButtonCancel: "Huỷ", message: description, actionButtonOk: {
                        guard let url = URL(string: "\(Config.manager.URL_UPDATE!)") else {
                            return
                        }

                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }, actionButtonCancel: {
                        return
                    }, isHideButtonOk: false, isHideButtonCancel: false)
                }
            }
        } else {
            self.gotoModule(rule: ruleType, id: id)
        }
    }

    private func gotoModule(rule: String, id: String) {
        var check = false

        if !isloadview {
            for item in Cache.ruleMenus {
                if item.p_messagess == rule {
                    check = true
                    break
                }
            }

            var newViewController: UIViewController!
            if(check){
                if(id == "101"){
                    newViewController = ProductBonusScopeViewController()
                }else if(id == "102"){
                    newViewController = OrdersViewController()
                    newViewController.modalPresentationStyle = .overFullScreen
                }else if(id == "103"){
                    let vc = ProductOldViewController()
                    vc.parentNavigationController = self.navigationController
                    newViewController = vc
                }else if(id == "104"){
                    let vc = DepositOrderViewController()
                    vc.parentNavigationController = self.navigationController
                    newViewController = vc
                }else if(id == "105"){
                    newViewController = FFriendViewController()
                }else if(id == "108"){
                    newViewController = TheCaoSOMMenuViewController()
                }else if(id == "109"){
                    newViewController = MenuBookSimViewController()
                }else if(id == "110"){
                    newViewController = ThuHoSOMMenuViewController()
                }else if(id == "111"){
                    newViewController = MenuUpdateSimViewController()
                }else if(id == "112"){
                    newViewController = ChonNhaMangThaySimViewController()
                }else if(id == "113"){
                    newViewController = BaoHiemMainViewController()
                }else if(id == "114"){
                    newViewController = ThuHoLongChauViewController()
                }else if(id == "115"){
                    newViewController = LichSuKichHoatV2ViewController()
                }else if(id == "116"){
                    newViewController = CheckInfoSubsidyViewController()
                }else if(id == "117"){
                    newViewController = IntroSubsidyViewController()
                }else if(id == "118"){
                    newViewController = GiaHanSSDViewController()
                }else if(id == "122"){
                    newViewController = VNGViewController()
                }else if(id == "124"){
                    newViewController = NhapHangViewController()
                }else if(id == "106"){
                    newViewController = SearchSubsidyViewController()
                }else if(id == "124"){
                    newViewController = NhapHangViewController()
                }else if(id == "106"){
                    newViewController = SearchSubsidyViewController()
                }else if(id == "125"){
                    newViewController = SearchContactViewControllerV2()
                }else if(id == "129"){
                    newViewController = CMNDViewController()
                }else if(id == "120"){
                    newViewController = SearchWarrantyViewController()
                }else if(id == "121"){
                    newViewController = TraMaySearchViewController()
                }else if(id == "119"){
                    newViewController = BaoHanhTaoPhieuMainController()
                }else if(id == "126"){
                    newViewController = MoMoMenuViewController()
                }else if(id == "127"){
                    newViewController = PDVendorFFriendViewController()
                }else if(id == "128"){
                    newViewController = FstudioViewController()
                }else if(id == "130"){
                    newViewController = UpdateTargetPDViewController()
                }else if(id == "107"){
                    newViewController = ComboPKViewControllerV2()
                }else if(id == "131"){
                    newViewController = BanHangOutsideViewController()
                }else if(id == "132"){
                    newViewController = CameraViewController()
                }else if(id == "133"){
                    newViewController = MenuGrabViewController()
                }else if(id == "134"){
                    newViewController = MiraeMenuViewController()
                        //                    newViewController = MenuMiraeViewController()
                    ShinhanData.resetShinhanData()
					Cache.soTienCocMirae = 0
                }else if(id == "135"){
                    newViewController = ChamDiemMainViewController()
                }else if(id == "140"){
                    let vc = HomeBackToSchoolScreen()
                    vc.showFull = false
                    vc.showFull = true
                    vc.isFromSearch = false
                    vc.isFromModule = true
                    newViewController = vc
                }else if(id == "136"){
                    WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                        MPOSAPIManager.FRT_SP_linksendo(handler: { (linkSendo, err) in
                            WaitingNetworkResponseAlert.DismissWaitingAlert {
                                if !err.isEmpty {
                                    let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        print("Completed")
                                    }
                                    let buttonOne = CancelButton(title: "OK") {

                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                    return
                                } else {
                                    guard let url = URL(string: "\(linkSendo)") else {
                                        return
                                    }

                                    if #available(iOS 10.0, *) {
                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                    } else {
                                        UIApplication.shared.openURL(url)
                                    }
                                    return
                                }
                            }
                        })
                    }
                }else if(id == "137"){
                    newViewController = NopQuyNHMainViewController()
                }else if(id == "138"){
                    newViewController = TenancyViewController()
                }else if(id == "139"){
                    newViewController = ViettelPayMenuViewController()
                }else if(id == "141"){
                    newViewController = DinhGiaMayCuViewController()
                }else if(id == "143"){
                    newViewController = InstallAppMainViewController()
                } else if(id == "144"){
                    newViewController = MayCuEcomMainViewController()
                }else if(id == "145"){
                    newViewController = VNPTInfoCustomerViewController()
                }else if(id == "146"){
                    newViewController = TVBaoHiemViewController()
                }else if(id == "151"){
                    newViewController = RightPhoneViewController()
                }else if(id == "152"){
                    newViewController = MayDemoBHMainViewController()
                }else if(id == "153"){
                    newViewController = SearchBankViewController()
                }else if(id == "154"){
                    newViewController = CallTuVanSanPhamMenuVC()
                }else if(id == "155") {
                    newViewController = HomeUserviceScreen()
                }else if(id == "156"){
                    newViewController = GalaxyPlayMainViewController()
                }else if(id == "157") {
                    newViewController = ListCustomerFollowZaloShopScreen()
                }else if(id == "158"){
                    newViewController = TraCocEcomMainViewController()
                }else if(id == "159"){
                    newViewController = LaptopBirthdayMainViewController()
                }else if(id == "160"){
                    newViewController = MenuInstallationRecordsViewController()
                } else if(id == "161"){
                    newViewController = AutoCompleteMenuGurantee()
                }else if(id == "89"){
                    newViewController = ZaloPayViewController()
                } else if(id == "162"){
                    if Cache.user!.ShopCode == "" || Cache.user?.ShopCode == "11000" {
                        newViewController = SelectShopVC()
                    } else {
                        newViewController = KiemkequyMenuVC()
                    }

                } else if (id == "163") {
                    newViewController = LapRapPCViewController()
                } else if (id == "165") {
                    newViewController = SearchDocumentViewController()

                    var info = [String:String]()
                    let access_token = UserDefaults.standard.string(forKey: "access_token")
                    let navController = self.navigationController!
                    let vc = SingleFlutterViewController(withEntrypoint: nil)
                    var deviceUUID: String = ""
                    if let udidDevice: UUID = UIDevice.current.identifierForVendor {
                        deviceUUID = udidDevice.uuidString
                    } else {
                        deviceUUID = "XXX-XXX"
                    }
                    info["user"] = Cache.user!.UserName
                    info["token"] = access_token
                    info["osType"] = "iOS"
                    info["uuid"] = deviceUUID
                    info["group"] = Common.shared.screenGroup
                    vc.info = info
                    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                    self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
                    navController.pushViewController(vc, animated: true)
                } else if (id == "164") {
                    newViewController = RaPCViewController()
                } else if (id == "166") {
                    newViewController = EcomOrdersVC()
                } else if id == "167" {
                    newViewController = MainBaoKimViewController()
                } else if (id == "168") {
                    newViewController = Menu_SoTay()
                } else if (id == "169") {
                    newViewController = CMSNHistoryViewController()
                } else if (id == "170") {
                    newViewController = ShinhanMenuVC()
                    ShinhanData.resetShinhanData()
                }else if (id == "171") {
					newViewController = MenuTraGopViewController()
				}else if (id == "201") {
					newViewController = MainMenuDanhGiaVC()
				}
            } else {
                if id == "-1" {
                    newViewController = MainBookingFlightViewController()
                } else {
                    let popup = PopupDialog(title: "Thông báo", message: "Bạn không được cấp quyền sử dụng chức năng này. Vui lòng kiểm tra lại.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {

                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    return
                }
            }
            if(newViewController != nil){
                mSMApiManager.trackUserActivity(group: Common.shared.screenGroup, screen: newViewController.className, handler: { _, _ in })
            }
                //ID:165(module Flutter)
            if id != "165" {
                if id == "168" {
                    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                    self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
                }
                if id == "102" {
                    self.present(newViewController, animated: true, completion: nil)
                } else {
                    self.navigationController?.interactivePopGestureRecognizer!.delegate = self
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
            }
        }

        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.isloadview = false
        }
    }

    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        Cache.searchOld = false
        textField.endEditing(true)
        let newViewController = SearchViewController()
        newViewController.delegateSearchView = self
        self.navigationController?.pushViewController(newViewController, animated: false)
    }
    @objc func actionCart() {
        let newViewController = CartViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func actionScan() {
            //        let viewController = BarcodeScannerViewController()
            //        viewController.metadata.removeAll()
            //        viewController.metadata.append(AVMetadataObject.ObjectType.code128)
            //        viewController.metadata.append(AVMetadataObject.ObjectType.qr)
            //        viewController.metadata.append(AVMetadataObject.ObjectType.code39)
            //        viewController.metadata.append(AVMetadataObject.ObjectType.ean13)
            //        viewController.headerViewController.titleLabel.text = "Quét mã"
            //        viewController.headerViewController.titleLabel.textColor = .white
            //        viewController.headerViewController.navigationBar.setBackgroundImage(imageLayerForGradientBackground(navigationBar: (self.navigationController?.navigationBar)!), for: UIBarMetrics.default)
            //
            //        viewController.headerViewController.closeButton.tintColor = .white
            //        viewController.headerViewController.closeButton.titleLabel?.text = "Đóng"
            //        viewController.codeDelegate = self
            //        viewController.errorDelegate = self
            //        viewController.dismissalDelegate = self
            //
            //        self.present(viewController, animated: false, completion: nil)
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { text in
            self.actionSearchProduct(sku: text)
        }

            //         self.navigationController?.pushViewController(viewController, animated: true)
        self.present(viewController, animated: false, completion: nil)

    }
    func pushView(_ product: Product) {
        Cache.sku = product.sku
        let newViewController = DetailProductViewController()
        newViewController.product = product
        newViewController.isCompare = false
        self.navigationController?.pushViewController(newViewController, animated: true)
    }

    func pushViewOld(_ product: ProductOld) {
        let newViewController = DetailOldProductViewController()
        newViewController.product = product
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func searchScanSuccess(text: String) {
        actionSearchProduct(sku: text)
    }

    func searchActionCart() {
        let newViewController = CartViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func actionSearchProduct(sku:String) {


        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            ProductAPIManager.product_detais_by_sku(sku: sku,handler: {[weak self] (productBySkus , error) in
                guard let self = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if(productBySkus.count > 0){
                        Cache.sku = productBySkus[0].product.sku
                        Cache.model_id = productBySkus[0].product.model_id
                        let newViewController = DetailProductViewController()
                        newViewController.isCompare = false
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }else{

                        self.showPopUp(error, "Thông báo", buttonTitle: "OK")
                    }

                }

            })

        }

    }
    func initSections() {
        var sellItems = [ItemApp]()
        let sellItem1 = ItemApp(id: "101", name: "Sản phẩm", type: "1", icon: #imageLiteral(resourceName: "Sanpham"))
        let sellItem2 = ItemApp(id: "102", name: "Đơn hàng", type: "2", icon: #imageLiteral(resourceName: "Donhang"))
        let sellItem3 = ItemApp(id: "103", name: "SP Đổi trả", type: "3", icon: #imageLiteral(resourceName: "SPDoitra"))
        let sellItem4 = ItemApp(id: "104", name: "DS Đặt cọc", type: "4", icon: #imageLiteral(resourceName: "DSdatcoc"))
        let sellItem5 = ItemApp(id: "105", name: "F.Friends", type: "5", icon: #imageLiteral(resourceName: "FFriend"))
        let sellItem6 = ItemApp(id: "106", name: "Tra cứu KH", type: "6", icon: #imageLiteral(resourceName: "TracuuKH"))
        let sellItem7 = ItemApp(id: "107", name: "Combo PK", type: "40", icon: #imageLiteral(resourceName: "ComboPKMenu"))
        let sellItem8 = ItemApp(id: "131", name: "Bán hàng outside", type: "44", icon: #imageLiteral(resourceName: "outsite"))
        let sellItem9 = ItemApp(id: "134", name: "Trả góp Mirae", type: "54", icon: #imageLiteral(resourceName: "miraeicon"))
            //let sellItem10 = ItemApp(id: "136", name: "Sendo", type: "58", icon: #imageLiteral(resourceName: "iconsendo"))
        let sellItem10 = ItemApp(id: "171", name: "Trả góp", type: "102", icon: UIImage.init(named: "ic_tragop")!)
        let sellItem11 = ItemApp(id: "141", name: "Thu mua máy cũ", type: "59", icon: #imageLiteral(resourceName: "MenuDinhGiaMC"))
        let sellItem12 = ItemApp(id: "144", name: "Cập nhật SP Cũ", type: "63", icon: #imageLiteral(resourceName: "icon_MayCuEcom"))
        let sellItem13 = ItemApp(id: "145", name: "VNPT", type: "64", icon: #imageLiteral(resourceName: "VNPTIcon"))
        let sellItem14 = ItemApp(id: "146", name: "Tư vấn bảo hiểm", type: "66", icon: #imageLiteral(resourceName: "ic_chubb"))
        let sellItem15 = ItemApp(id: "-1", name: "Vé máy bay", type: "-1", icon : #imageLiteral(resourceName: "VeMayBayIcon"))
        let sellItem16 = ItemApp(id: "151", name: "RightPhone", type: "68",icon : #imageLiteral(resourceName: "RightPhoneLogo"))
        let sellItem17 = ItemApp(id: "154", name: "Call chăm sóc khách hàng", type: "72",icon :  #imageLiteral(resourceName: "Call 1"))
        let sellItem18 = ItemApp(id: "158", name: "Tìm kiếm ĐH Ecom", type: "78", icon: #imageLiteral(resourceName: "tracuukh"))
        let sellItem19 = ItemApp(id: "166", name: "Nhận đơn đi giao", type: "99", icon: #imageLiteral(resourceName: "Ecom_orders_ic"))
        let sellItem20 = ItemApp(id: "167", name: "Vé xe Bảo Kim", type: "95", icon : #imageLiteral(resourceName: "VeBaoKimIcon"))

        let sellItem21 = ItemApp(id: "170", name: "Shinhan", type: "97", icon :UIImage.init(named: "Shinhan")!)

		let sellItem0 = ItemApp(id: "201", name: "ĐÁNH GIÁ NÂNG TẦM DỊCH VỤ", type: "103", icon: UIImage.init(named: "menu_danhgia")!)
		sellItems.append(sellItem0)
		sellItems.append(sellItem1)
		sellItems.append(sellItem2)
		sellItems.append(sellItem10)
		sellItems.append(sellItem9)
		sellItems.append(sellItem21)
		sellItems.append(sellItem4)
		sellItems.append(sellItem5)
		sellItems.append(sellItem6)
		sellItems.append(sellItem3)
		sellItems.append(sellItem7)
		sellItems.append(sellItem8)
		sellItems.append(sellItem11)
		sellItems.append(sellItem12)
        sellItems.append(sellItem13)
        sellItems.append(sellItem14)
        sellItems.append(sellItem15)
        sellItems.append(sellItem16)
        sellItems.append(sellItem17)
        sellItems.append(sellItem18)
        sellItems.append(sellItem19)
        sellItems.append(sellItem20)


            //        sellItems.append(sellItem7)
        let sellSection = Section(name: "BÁN HÀNG", arrayItems: sellItems)
        self.arrSection.append(sellSection)
            //--
        var crmItems = [ItemApp]()
        let crmItem1 = ItemApp(id: "108", name: "Thẻ cào-Bán gói cước", type: "7", icon: #imageLiteral(resourceName: "thecao"),rightIcon: UIImage(named: "icon_new"))
        let crmItem2 = ItemApp(id: "109", name: "Book sim", type: "8", icon: #imageLiteral(resourceName: "sim.,"),rightIcon: UIImage(named: "HOT"))
        let crmItem3 = ItemApp(id: "110", name: "Thu hộ", type: "9", icon: #imageLiteral(resourceName: "thuho"))
        let crmItem4 = ItemApp(id: "111", name: "Cập nhật thuê bao", type: "10", icon: #imageLiteral(resourceName: "capnhatthuebao"))
        let crmItem5 = ItemApp(id: "112", name: "Thay Sim", type: "11", icon: #imageLiteral(resourceName: "thaysim"))
            //        let crmItem6 = ItemApp(id: "113", name: "Bảo hiểm xe máy", type: "12", icon: #imageLiteral(resourceName: "baohiemxe"))
        let crmItem7 = ItemApp(id: "114", name: "Thu hộ LC", type: "13", icon: #imageLiteral(resourceName: "thuholc"))
        let crmItem8 = ItemApp(id: "115", name: "LS kích hoạt", type: "14", icon: #imageLiteral(resourceName: "lskichhoat"))
        let crmItem9 = ItemApp(id: "126", name: "MoMo", type: "15", icon: #imageLiteral(resourceName: "MoMoIcon"))
        let crmItem10 = ItemApp(id: "133", name: "Nạp tiền Grab", type: "45", icon: #imageLiteral(resourceName: "GrabMenu"))
        let crmItem11 = ItemApp(id: "137", name: "Nộp quỹ NH", type: "55", icon: #imageLiteral(resourceName: "Nopquynganhang"))
        let crmItem12 = ItemApp(id: "139", name: "ViettelPay", type: "52", icon: #imageLiteral(resourceName: "ViettelPayMenu"))
        let crmItem13 = ItemApp(id: "143", name: "Lịch sử cài app", type: "22", icon: #imageLiteral(resourceName: "Donhang"))
        let crmItem14 = ItemApp(id: "156", name: "Nạp Galaxy Play", type: "76", icon: #imageLiteral(resourceName: "GalaxyPay-Menu"))
        let crmItem15 = ItemApp(id: "89", name: "Nạp Zalo Pay", type: "89", icon: #imageLiteral(resourceName: "zalo_pay"))
            //        let crmItem16 = ItemApp(id: "164", name: "Bán gói cước KH đã có SIM", type: "94", icon: #imageLiteral(resourceName: "vas_icon_new"),rightIcon: UIImage(named: "icon_new"))

        crmItems.append(crmItem1)
        crmItems.append(crmItem2)
            //        crmItems.append(crmItem16)
        crmItems.append(crmItem3)
        crmItems.append(crmItem4)
        crmItems.append(crmItem5)
            //        crmItems.append(crmItem6)
        crmItems.append(crmItem7)
        crmItems.append(crmItem8)
        crmItems.append(crmItem9)
        crmItems.append(crmItem10)
        crmItems.append(crmItem11)
        crmItems.append(crmItem12)
        crmItems.append(crmItem13)
        crmItems.append(crmItem14)
        crmItems.append(crmItem15)
        let crmSection = Section(name: "CRM", arrayItems: crmItems)
        self.arrSection.append(crmSection)
            //--
        var subsidyItems = [ItemApp]()
        let subsidyItem1 = ItemApp(id: "116", name: "KT Fnox", type: "16", icon: #imageLiteral(resourceName: "FNOX"))
        let subsidyItem2 = ItemApp(id: "117", name: "Tư vấn Subsidy", type: "17", icon: #imageLiteral(resourceName: "TuvanSSD"))
        let subsidyItem3 = ItemApp(id: "118", name: "Gia hạn SSD", type: "18", icon: #imageLiteral(resourceName: "GiahanSSD"))

        subsidyItems.append(subsidyItem1)
        subsidyItems.append(subsidyItem2)
        subsidyItems.append(subsidyItem3)
        let subsidySection = Section(name: "SUBSIDY", arrayItems: subsidyItems)
        self.arrSection.append(subsidySection)
            //--
        var guaranteeItems = [ItemApp]()
        let guaranteeItem1 = ItemApp(id: "119", name: "Tạo phiếu", type: "19", icon: #imageLiteral(resourceName: "taophieu"))
        let guaranteeItem2 = ItemApp(id: "120", name: "Tra cứu BH", type: "20", icon: #imageLiteral(resourceName: "tracuu"))
        let guaranteeItem5 = ItemApp(id: "161", name: "Tìm phiếu test máy", type: "88", icon: #imageLiteral(resourceName: "search_ic_new"))
        let guaranteeItem3 = ItemApp(id: "121", name: "Trả máy BH", type: "21", icon: #imageLiteral(resourceName: "tramay"))
        let guaranteeItem4 = ItemApp(id: "152", name: "Máy Demo", type: "70",icon : #imageLiteral(resourceName: "Demo"))

        guaranteeItems.append(guaranteeItem1)
        guaranteeItems.append(guaranteeItem2)
        guaranteeItems.append(guaranteeItem5)
        guaranteeItems.append(guaranteeItem3)
        guaranteeItems.append(guaranteeItem4)
        let guaranteeSection = Section(name: "BẢO HÀNH", arrayItems: guaranteeItems)
        self.arrSection.append(guaranteeSection)
            //--
        var anotherItems = [ItemApp]()

        let anotherItem1 = ItemApp(id: "122", name: "Cài đặt VNG", type: "22", icon: #imageLiteral(resourceName: "vng"))

            //        let anotherItem2 = ItemApp(id: "23", name: "Giới thiệu Credict", type: "23", icon: #imageLiteral(resourceName: "credit"))
        let anotherItem3 = ItemApp(id: "124", name: "Nhập hàng", type: "23", icon: #imageLiteral(resourceName: "nhaphang"))

        let anotherItem4 = ItemApp(id: "125", name: "Tra cứu danh bạ", type: "24", icon: #imageLiteral(resourceName: "tracuudanhba"))



        let anotherItem6 = ItemApp(id: "127", name: "PD của FFriends", type: "36", icon: #imageLiteral(resourceName: "PDFFriend"))
        let anotherItem5 = ItemApp(id: "128", name: "Fstudio", type: "25", icon: #imageLiteral(resourceName: "fstudiomenu"))
		let anotherItem7 = ItemApp(id: "129", name: "Check in PG", type: "37", icon: #imageLiteral(resourceName: "checkinPG"))
        let anotherItem8 = ItemApp(id: "130", name: "Target PD FFriends", type: "39", icon: #imageLiteral(resourceName: "UpdateTargetPDMenu"))
        let anotherItem9 = ItemApp(id: "132", name: "Camera", type: "42", icon: #imageLiteral(resourceName: "Camera"))
        let anotherItem10 = ItemApp(id: "135", name: "Chấm điểm", type: "48", icon: #imageLiteral(resourceName: "ic-CR"))
        let anotherItem11 = ItemApp(id: "140", name: "Back To School", type: "53", icon: #imageLiteral(resourceName: "backtoschool"))
        let anotherItem12 = ItemApp(id: "138", name: "HĐ thuê nhà", type: "47", icon: #imageLiteral(resourceName: "tenancy"))
        let anotherItem13 = ItemApp(id: "153", name: "Tra cứu Bank", type: "71", icon: #imageLiteral(resourceName: "bank"))
        let anotherItem14 = ItemApp(id: "155", name: "Uservice", type: "74", icon: UIImage.init(named: "ic_uservice")!)
        let anotherItem15 = ItemApp(id: "157", name: "KH Follow Zalo", type: "77", icon: UIImage.init(named: "ic_zalo")!)
        let anotherItem16 = ItemApp(id: "159", name: "Laptop - chương trình sinh nhật", type: "79", icon: #imageLiteral(resourceName: "LaptopBirthday"))
        let anotherItem17 = ItemApp(id: "160", name: "Biên bản cài đặt", type: "81", icon: #imageLiteral(resourceName: "datcoc"))
        let anotherItem18 = ItemApp(id: "162", name: "Kiểm kê quỹ", type: "90", icon: #imageLiteral(resourceName: "home_menu_kk"))
        let anotherItem19 = ItemApp(id: "163", name: "Lắp ráp PC", type: "93", icon: UIImage.init(named: "ic_PC")!)
        let anotherItem20 = ItemApp(id: "165", name: "Tra cứu tài liệu", type: "98",  icon: UIImage.init(named: "ic_contentHub")!)
        let anotherItem21 = ItemApp(id: "164", name: "Rã PC", type: "96", icon: UIImage.init(named: "IC_raPC")!)
        let anotherItem22 = ItemApp(id: "168", name: "Sử Ký", type: "100", icon: UIImage.init(named: "Sotay")!)
        let anotherItem23 = ItemApp(id: "169", name: "Mừng sinh nhật khách hàng tháng 3", type: "101", icon: UIImage.init(named: "CMSN")!)
            // let anotherItem4 = ItemApp(id: "25", name: "Tra cứu danh bạ", type: "25", icon: #imageLiteral(resourceName: "tracuudanhba"))
        anotherItems.append(anotherItem19)
        anotherItems.append(anotherItem21)

        anotherItems.append(anotherItem1)
            //        anotherItems.append(anotherItem2)
        anotherItems.append(anotherItem3)
        anotherItems.append(anotherItem4)
        anotherItems.append(anotherItem5)
        anotherItems.append(anotherItem6)
        anotherItems.append(anotherItem7)
        anotherItems.append(anotherItem8)
        anotherItems.append(anotherItem9)
        anotherItems.append(anotherItem10)
        anotherItems.append(anotherItem11)
        anotherItems.append(anotherItem12)
        anotherItems.append(anotherItem13)
        anotherItems.append(anotherItem14)
        anotherItems.append(anotherItem15)
        anotherItems.append(anotherItem16)
        anotherItems.append(anotherItem17)
        anotherItems.append(anotherItem18)
        anotherItems.append(anotherItem20)
        anotherItems.append(anotherItem22)
        anotherItems.append(anotherItem23)
        let anotherSection = Section(name: "KHÁC", arrayItems: anotherItems)
        self.arrSection.append(anotherSection)

        for item in arrSection {
            if(item.arrayItems.count % 3 != 0){
                for _ in 0..<3 {
                    let another = ItemApp(id: "0", name: "0", type: "0", icon: #imageLiteral(resourceName: "tracuudanhba"))
                    item.arrayItems.append(another)
                    if(item.arrayItems.count % 3 == 0){
                        break
                    }
                }
            }
        }
    }

    func setUp3GiaTriCotLoi() {

        self.slideshow = ImageSlideshow(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: (self.view.frame.width / 4.5)))
        self.tableView.tableHeaderView = self.slideshow
        self.slideshow.slideshowInterval = 5.0
        self.slideshow.contentScaleMode = UIView.ContentMode.scaleToFill

        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.slideshow.pageIndicator = pageControl

            // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        self.slideshow.activityIndicator = DefaultActivityIndicator()
        self.slideshow.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .customBottom(padding: -5))

        var inputSources: [InputSource] = []
        for image in listBanner {
            if !image.imgBanner.isEmpty {
                let source = SDWebImageSource(urlString: "http://news.fptshop.com.vn" + image.imgBanner)!
                inputSources.append(source)
            }
        }
        self.slideshow.setImageInputs(inputSources)

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(slideshowDidTap))
        self.slideshow.addGestureRecognizer(gestureRecognizer)
    }

    func initHeader(){
        var sizeHeight = UIApplication.shared.statusBarFrame.height
        if(sizeHeight > 20){
            sizeHeight = sizeHeight/2
        }
        viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.navigationController!.navigationBar.frame.size.height + sizeHeight))
        self.view.addSubview(viewHeader)

        let imageAvatar = UIImageView(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:5), width: viewHeader.frame.size.height - Common.Size(s:10), height: viewHeader.frame.size.height - Common.Size(s:10)))
        imageAvatar.image = UIImage(named: "avatar")
        imageAvatar.layer.borderWidth = 1
        imageAvatar.layer.masksToBounds = false
        imageAvatar.layer.borderColor = UIColor.white.cgColor
        imageAvatar.layer.cornerRadius = imageAvatar.frame.height/2
        imageAvatar.clipsToBounds = true
        viewHeader.addSubview(imageAvatar)
        imageAvatar.contentMode = .scaleAspectFill
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)

        let url_avatar = "\(Cache.user!.AvatarImageLink)".replacingOccurrences(of: "~", with: "")
        if(url_avatar != ""){
            if let escapedString = "https://inside.fptshop.com.vn/\(url_avatar)".addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                print(escapedString)
                let url = URL(string: "\(escapedString)")!
                imageAvatar.kf.setImage(with: url,
                                        placeholder: nil,
                                        options: [.transition(.fade(1))],
                                        progressBlock: nil,
                                        completionHandler: nil)
            }
        }
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(TabMPOSHomeViewController.tapUserInfo))
        imageAvatar.isUserInteractionEnabled = true
        imageAvatar.addGestureRecognizer(singleTap)


        let lbName = UILabel(frame: CGRect(x: imageAvatar.frame.origin.x + imageAvatar.frame.size.width + Common.Size(s: 5), y: Common.Size(s: 5), width: viewHeader.frame.width - (imageAvatar.frame.origin.x + imageAvatar.frame.size.width + Common.Size(s: 5)) * 2, height: Common.Size(s: 20)))
        lbName.text = "\(Cache.user!.UserName) - \(Cache.user!.EmployeeName)"
        lbName.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        viewHeader.addSubview(lbName)

        let lbShop = UILabel(frame: CGRect(x: lbName.frame.origin.x, y: lbName.frame.origin.y + lbName.frame.size.height, width: lbName.frame.width, height: Common.Size(s: 20)))
        lbShop.text = "\(Cache.user!.ShopName)"
        lbShop.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewHeader.addSubview(lbShop)

            //------- cham cong btn--------
        checkInOutBtn = UIButton(frame: CGRect(x: lbShop.frame.origin.x + lbShop.frame.size.width + Common.Size(s:1), y: Common.Size(s:5), width: viewHeader.frame.size.height - Common.Size(s:10), height: viewHeader.frame.size.height - Common.Size(s:10)))
        checkInOutBtn.addTarget(self, action: #selector(checkIP(_:)), for: .touchUpInside)
        viewHeader.addSubview(checkInOutBtn)
            //-----------------------------
        let viewHeaderLine = UIView(frame: CGRect(x: 0, y: viewHeader.frame.size.height - 0.5, width: viewHeader.frame.width, height: 0.5))
        viewHeaderLine.backgroundColor = UIColor(netHex: 0xEEEEEE)
        viewHeader.addSubview(viewHeaderLine)
    }


    @objc func tapUserInfo() {
            //        let newViewController = UserInfoViewController()
        let myInfoScreen = MyInfoScreen()
        let infoNav = UINavigationController(rootViewController: myInfoScreen)
        infoNav.modalPresentationStyle = .fullScreen
        self.navigationController?.present(infoNav, animated: true, completion: nil)
            //        self.navigationController?.pushViewController(myInfoDetailScreen, animated: true)
    }

    func initTableView(){
        tableView = UITableView(frame: CGRect(x: 0, y: viewHeader.frame.origin.y + viewHeader.frame.size.height, width: self.view.frame.width, height:self.view.frame.height -
                                              self.navigationController!.navigationBar.frame.size.height - UIApplication.shared.statusBarFrame.height - viewHeader.frame.size.height), style: UITableView.Style.plain)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemSessionTableViewCell.self, forCellReuseIdentifier: "ItemSessionTableViewCell")
        tableView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        setUp3GiaTriCotLoi()
    }

    func autoCheckInFirstLogin() {
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Checkin first login...") {
            CRMAPIManager.CheckIn_FirstLogin { (rsCode, msg, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert { // rsCode = 0 : thất bại, 1 : thành công
                    if err.count <= 0 {
                        if rsCode == 1 {
                            let popup = PopupDialog(title: "Thông báo", message: "\(msg)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = DefaultButton(title: "OK") {
                                self.checkInOutBtn.tag = 1 //da check-in
                                self.checkInOutBtn.setImage(#imageLiteral(resourceName: "CheckOut"), for: .normal)
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        } else {
                            let popup = PopupDialog(title: "Thông báo", message: "\(msg)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = DefaultButton(title: "OK") {
                                self.checkInOutBtn.tag = 0
                                self.checkInOutBtn.setImage(#imageLiteral(resourceName: "CheckIn"), for: .normal)
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    } else {
                        let popup = PopupDialog(title: "Thông báo", message: "\(err)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = DefaultButton(title: "OK") {
                            self.checkInOutBtn.tag = 0
                            self.checkInOutBtn.setImage(#imageLiteral(resourceName: "CheckIn"), for: .normal)
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
            }
        }
    }

    @objc func checkIP(_ sender: UIButton){
        print("tapped btn cham cong status tag: \(sender.tag)")
        if sender.tag != 2 {
            mSMApiManager.GetIpCheckingResult(userID: "\(Cache.user?.Id ?? 0)") { (rsCode, err) in
                if err.count <= 0 {
                    if(rsCode == 1){
                        if(sender.tag == 0){
                            self.insertCheckin()
                        }else{
                            self.insertCheckout()
                        }
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: "Sai IP shop. Bạn vui lòng đến shop chấm công", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }

        } else {
            debugPrint("k du dieu kien cham cong...")
        }
    }
    private func loadHtmlContentNotiSauChamCong(){
        MPOSAPIManager.sp_mpos_FRT_SP_GetNotiSauChamCong() { (result, err) in

            if(err.count <= 0){
                self.htmlContentNoti = result
            }else {
                self.htmlContentNoti = ""
            }
        }
    }

    private func showPopupNotifi() {
        let vc = SauChamCongVC()
        vc.htmlString = self.htmlContentNoti
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            topController.present(vc, animated: true, completion: nil)
        }
    }
        //----Check show btn in out
    private func getUserKiemTraInOut() {
            //        checkInOutBtn.tag = 0 (chua check-in)
            //        checkInOutBtn.tag = 1 (chua check-out)
        Provider.shared.checkInOutService.getUserKiemTraInOut(p_UserCode: Cache.user!.UserName, success: { [weak self] (result) in
            guard let self = self,let response = result else {return}
            if response.UserKiemTraInOutResult?.show_CheckIn == 1 {
                self.checkInOutBtn.tag = 0
                self.checkInOutBtn.setImage(#imageLiteral(resourceName: "CheckIn"), for: .normal)
                self.numberTypeCheck = 1
            }else if response.UserKiemTraInOutResult?.show_CheckOut == 1{
                self.checkInOutBtn.tag = 1
                self.checkInOutBtn.setImage(#imageLiteral(resourceName: "CheckOut"), for: .normal)
                self.numberTypeCheck = 2
            }else {
                self.numberTypeCheck = 0
            }
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }

    private func getUserCheckInOut() {
        self.showLoading()
        Provider.shared.checkInOutService.getUserCheckInOut(p_UserCode: Cache.user!.UserName,p_CheckType:numberTypeCheck, success: { [weak self] (result) in
            self!.stopLoading()
            guard let self = self,let response = result else {return}
            if response.userCheckInOutResult?.result == 1 {
                let alert = UIAlertController(title: "Thông báo", message: response.userCheckInOutResult?.msg ?? "", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: { action in
                        //check out success
                    if self.numberTypeCheck == 2{
                        self.checkInOutBtn.isHidden = true
                    }
                    self.showPopupNotifi()
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }else {
                self.showAlertOneButton(title: "Thông báo", with: response.userCheckInOutResult?.msg ?? "", titleButton: "OK")
            }

        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    @objc func insertCheckin() {
        getUserCheckInOut()
    }
    @objc func insertCheckout() {
        getUserCheckInOut()
    }


        //    func GetUserCheckList() -> [UserShift] {
        //        let userID = (Cache.user?.Id ?? 0)
        //        let shiftList = mSMApiManager.GetUserShiftList(userID: "\(userID)").Data ?? []
        //        return shiftList
        //    }

        //-------NEW CHAM CONG-------
        //kiem tra ca lam
    func checkShift() -> Bool {
        let arrShift = Cache.arrShiftChamCong
        if arrShift.count > 0 {
            for item in arrShift {
                let timeBegin = self.convertDateChamCong(dateString: item.gioBatDauDuocChamIN).timeIntervalSince1970 * 1000
                let timeEnd = self.convertDateChamCong(dateString: item.gioKetThuc).timeIntervalSince1970 * 1000
                let currentDate = Date().timeIntervalSince1970 * 1000

                debugPrint("time begin mili = \(timeBegin)")
                debugPrint("time end mili = \(timeEnd)")
                debugPrint("time current mili = \(currentDate)")

                if (currentDate >= timeBegin) && (currentDate <= timeEnd) { //trong gio cham cong
                    return true
                }
            }
        } else { //k co ca lam => IN
            return false
        }
        return false
    }

    func checkStatusChamCongV2() {
            //        checkInOutBtn.tag = 0 (chua check-in)
            //        checkInOutBtn.tag = 1 (chua check-out)
            //        checkInOutBtn.tag = 2 (đã check-out (or k có ca làm), ẩn btnChamcong)

        if checkShift() == true { //đang trong ca
            let responseCheckinV2Results = mSMApiManager.GetUserCheckinV2Result(userID: "\(Cache.user?.Id ?? 0)")
            let checkInV2Array = responseCheckinV2Results.Data ?? []
            if checkInV2Array.count > 0 {
                if checkInV2Array[0].Result == false {
                        //chua check in
                    checkInOutBtn.tag = 0
                    self.checkInOutBtn.setImage(#imageLiteral(resourceName: "CheckIn"), for: .normal)
                } else {
                        //check in roi => ktra api check out
                    let responsecheckOutResults = mSMApiManager.GetUserCheckoutResult(userID: "\(Cache.user?.Id ?? 0)")
                    let checkOutArray = responsecheckOutResults.Data ?? []
                    if checkOutArray.count > 0 {
                        if checkOutArray[0].CheckoutDate?.isEmpty == true {
                                //chua check out
                            checkInOutBtn.tag = 1
                            self.checkInOutBtn.setImage(#imageLiteral(resourceName: "CheckOut"), for: .normal)
                        } else {
                                //check out roi
                            checkInOutBtn.tag = 2
                            self.checkInOutBtn.setImage(nil, for: .normal)
                        }
                    } else {
                        checkInOutBtn.tag = 2
                        self.checkInOutBtn.setImage(nil, for: .normal)
                    }
                }
            } else {
                checkInOutBtn.tag = 0
                self.checkInOutBtn.setImage(#imageLiteral(resourceName: "CheckIn"), for: .normal)
            }
        } else { // ngoài ca làm
            checkInOutBtn.tag = 0
            self.checkInOutBtn.setImage(#imageLiteral(resourceName: "CheckIn"), for: .normal)
        }
    }

    func convertDateChamCong(dateString: String) -> Date {
            //example date = "12/22/19 10:14:35 PM"
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "MM/dd/yy hh:mm:ss a"
        dateFormate.locale = Locale(identifier: "vi_VN")
            //        dateFormate.timeZone = TimeZone(identifier: "UTC")
        dateFormate.amSymbol = "AM"
        dateFormate.pmSymbol = "PM"

            // convert h_VN => h_UTC
        let date = dateFormate.date(from: dateString)
        debugPrint("date date UTC = \(date ?? Date())")

        return date ?? Date()
    }

}

extension TabMPOSHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrSection.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let coCellHeight = (self.view.frame.width / 3) * 0.7

            /// set estimateHeight
        var estimateHeight: CGFloat = 0
        let amoutItems = arrSection[indexPath.section].arrayItems.count
        if amoutItems % 3 == 0 {
            estimateHeight = CGFloat((amoutItems / 3)) * coCellHeight
        } else {
            estimateHeight = CGFloat(CGFloat(amoutItems / 3) * coCellHeight) + coCellHeight
        }
        tableView.estimatedRowHeight = estimateHeight
        return estimateHeight
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemSessionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ItemSessionTableViewCell", for: indexPath) as! ItemSessionTableViewCell
        cell.cellWidth = cell.frame.width
        cell.items = arrSection[indexPath.section].arrayItems
        Common.shared.screenGroup = arrSection[indexPath.section].sectionName
        cell.setUpCollectionView()
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = UIColor(netHex: 0xEEEEEE)
        let label = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label.text = arrSection[section].sectionName
        label.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        vw.addSubview(label)
        return vw
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return Common.Size(s: 35)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

extension TabMPOSHomeViewController: ItemSessionTableViewCellDelegate {
    func pushTo(_ id: String, _ ruleType: String) {
        self.pushToViewController(id: id, ruleType: ruleType)
    }
}

protocol ItemSessionTableViewCellDelegate: AnyObject {
    func pushTo(_ id: String,_ ruleType: String)
}

class ItemSessionTableViewCell: UITableViewCell {

    var collectionView: UICollectionView!
    var items = [ItemApp]()
    var cellWidth: CGFloat = 0
    var coCellWidth: CGFloat = 0
    var coCellHeight: CGFloat = 0
    var collectionViewHeightConstraint = NSLayoutConstraint()
    var whiteCoCellArray = [ItemApp]()

    weak var delegate: ItemSessionTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func setUpCollectionView() {
        self.subviews.forEach({ $0.removeFromSuperview() })
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
        layout.itemSize = CGSize(width: 111, height: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height), collectionViewLayout: layout)

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(ItemSessionCollectionViewCell.self, forCellWithReuseIdentifier: "ItemSessionCollectionViewCell")
        self.addSubview(collectionView)
        collectionView.isScrollEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension ItemSessionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let coCell: ItemSessionCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemSessionCollectionViewCell", for: indexPath) as! ItemSessionCollectionViewCell

        let item = items[indexPath.item]
        coCell.setUpCollectionViewCell(item: item)
        coCell.layer.borderWidth = 0.5
        coCell.layer.borderColor = UIColor(netHex: 0xEEEEEE).cgColor
        return coCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        delegate?.pushTo(item.id, item.type)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        coCellWidth = cellWidth/3.0
        coCellHeight = coCellWidth * 0.7
        let size = CGSize(width: coCellWidth, height: coCellHeight)
        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}
class ItemSessionCollectionViewCell: UICollectionViewCell {

    var icon: UIImageView!
    var itemLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func setUpCollectionViewCell(item: ItemApp) {
        contentView.backgroundColor = UIColor.white
        if(item.id != "0"){
            icon = UIImageView()


            if item.rightIcon != nil {
                let iconHeight:CGFloat = contentView.frame.height/2
                icon = UIImageView(frame: CGRect(x: contentView.frame.width/2 - (contentView.frame.height/2 - Common.Size(s: 10))/2, y: contentView.frame.height/2 - (contentView.frame.height/2 + Common.Size(s: 25))/2, width: iconHeight - Common.Size(s: 5), height: iconHeight))
                icon.image = item.icon
                icon.contentMode = .scaleAspectFit

                contentView.addSubview(icon)
                itemLabel = UILabel(frame: CGRect(x: 0, y: icon.frame.origin.y + icon.frame.size.height, width: self.contentView.frame.width, height: Common.Size(s: 35)))
                itemLabel.text = item.name
                itemLabel.textAlignment = .center
                itemLabel.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
                itemLabel.textColor = UIColor(netHex: 0x6C6B6B)
                itemLabel.numberOfLines = 0
                contentView.addSubview(itemLabel)
                let rightImage = UIImageView(frame: CGRect(x: icon.frame.origin.x + icon.frame.size.width - 5, y: icon.frame.origin.y - 4, width: 17.5, height: 17.5))
                rightImage.contentMode = .scaleAspectFit
                rightImage.image = item.rightIcon!
                contentView.addSubview(rightImage)
            } else {
                let iconHeight:CGFloat = contentView.frame.height/2
                icon = UIImageView(frame: CGRect(x: contentView.frame.width/2 - (contentView.frame.height/2 - Common.Size(s: 10))/2, y: contentView.frame.height/2 - (contentView.frame.height/2 + Common.Size(s: 25))/2, width: iconHeight - Common.Size(s: 5), height: iconHeight))
                icon.image = item.icon
                icon.contentMode = .scaleAspectFit

                contentView.addSubview(icon)
                itemLabel = UILabel(frame: CGRect(x: 0, y: icon.frame.origin.y + icon.frame.size.height, width: self.contentView.frame.width, height: Common.Size(s: 35)))
                itemLabel.text = item.name
                itemLabel.textAlignment = .center
                itemLabel.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
                itemLabel.textColor = UIColor(netHex: 0x6C6B6B)
                itemLabel.numberOfLines = 0
                itemLabel.lineBreakMode = .byWordWrapping
                contentView.addSubview(itemLabel)
				if item.name == "ĐÁNH GIÁ NÂNG TẦM DỊCH VỤ" {
					itemLabel.updateConstraints()
					itemLabel.text =  "Đánh giá\nNâng tầm dịch vụ"
					itemLabel.textColor = .black
					itemLabel.font = UIFont.systemFont(ofSize: Common.Size(s: 12), weight: .medium)
				}

            }
        }
    }

    public func setUpCollectionViewCellThuHoService(item: ItemAppThuHoService) {
        self.subviews.forEach({$0.removeFromSuperview()})
        self.backgroundColor = .white
        icon = UIImageView()
        icon = UIImageView(frame: CGRect(x: contentView.frame.width/2 - (contentView.frame.height/2 - Common.Size(s: 10))/2, y: contentView.frame.height/2 - (contentView.frame.height/2 + Common.Size(s: 25))/2, width: contentView.frame.height/2 - Common.Size(s: 10), height: contentView.frame.height/2))
        icon.image = item.icon
        icon.contentMode = .scaleAspectFit

        itemLabel = UILabel(frame: CGRect(x: 0, y: icon.frame.origin.y + icon.frame.size.height, width: self.contentView.frame.width, height: Common.Size(s: 35)))
        itemLabel.text = item.name
        itemLabel.textAlignment = .center
        itemLabel.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        itemLabel.textColor = UIColor(netHex: 0x6C6B6B)
        itemLabel.numberOfLines = 2
        self.addSubview(icon)
        self.addSubview(itemLabel)
    }

    public func setupCollectionViewCellThuHoSOM(item: ThuHoSOMItem) {
        self.subviews.forEach({$0.removeFromSuperview()})
        self.backgroundColor = .white
        icon = UIImageView()
        icon = UIImageView(frame: CGRect(x: contentView.frame.width/2 - (contentView.frame.height/2 - Common.Size(s: 10))/2, y: contentView.frame.height/2 - (contentView.frame.height/2 + Common.Size(s: 25))/2, width: contentView.frame.height/2 - Common.Size(s: 10), height: contentView.frame.height/2))
        icon.image = UIImage(named: item.name.replace("/", withString: "")) ?? UIImage(named: "Logo")
        icon.contentMode = .scaleAspectFit

        itemLabel = UILabel(frame: CGRect(x: 0, y: icon.frame.origin.y + icon.frame.size.height, width: self.contentView.frame.width, height: Common.Size(s: 35)))
        itemLabel.text = item.name
        itemLabel.textAlignment = .center
        itemLabel.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        itemLabel.textColor = UIColor(netHex: 0x6C6B6B)
        itemLabel.numberOfLines = 2
        self.addSubview(icon)
        self.addSubview(itemLabel)
    }

    public func setupCollectionViewCellTheCaoSOM(item: (name: String, image: String)) {
        self.subviews.forEach({$0.removeFromSuperview()})
        self.backgroundColor = .white
        icon = UIImageView()
        icon = UIImageView(frame: CGRect(x: contentView.frame.width/2 - (contentView.frame.height/2 - Common.Size(s: 10))/2, y: contentView.frame.height/2 - (contentView.frame.height/2 + Common.Size(s: 25))/2, width: contentView.frame.height/2 - Common.Size(s: 10), height: contentView.frame.height/2))
        icon.image = UIImage(named: item.image) ?? UIImage(named: "Logo")
        icon.contentMode = .scaleAspectFit

        itemLabel = UILabel(frame: CGRect(x: 0, y: icon.frame.origin.y + icon.frame.size.height, width: self.contentView.frame.width, height: Common.Size(s: 35)))
        itemLabel.text = item.name
        itemLabel.textAlignment = .center
        itemLabel.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        itemLabel.textColor = UIColor(netHex: 0x6C6B6B)
        itemLabel.numberOfLines = 2
        self.addSubview(icon)
        self.addSubview(itemLabel)
    }
}



