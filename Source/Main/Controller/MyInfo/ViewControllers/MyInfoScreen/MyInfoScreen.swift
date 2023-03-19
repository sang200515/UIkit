//
//  MyInfoScreen.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/15/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Kingfisher
import PopupDialog

class MyInfoScreen: BaseController {
    
    let processImage = RoundCornerImageProcessor(cornerRadius: 20)
    private var urlAvatarImage: String = ""
    
    // MARK: - PROPERTIES
    
    let vMainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let vImageDismiss: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "close-1")
        return imageView
    }()
    
    let vDetailUserInfo: DetailUserInfoView = {
        let view = DetailUserInfoView()
        return view
    }()
    
    let vListFeatureListMyInfo: ListFeatureView = {
        let view = ListFeatureView()
        return view
    }()
    
    let vImageHeaderBackgound: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bg_main_myinfo"))
        return imageView
    }()
    
    lazy var vImageAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "ic_default_avatar")
        return imageView
    }()
    
    let vImagePunish: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ic_face_sad_relived"))
        return imageView
    }()
    
    let vImageNext: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ic_next_right"))
        return imageView
    }()
    
    let vImageCheckListWork: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ic_checkmark"))
        return imageView
    }()
    
    let lbFullName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.mediumCustomFont(ofSize: 18)
        label.textColor = Constants.COLORS.text_gray
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let lbAddress: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.mediumCustomFont(ofSize: 14)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let lbTitlePunish: UILabel = {
        let label = UILabel()
        label.text = "Phạt"
        label.font = UIFont.regularFontOfSize(ofSize: Constants.TextSizes.size_13)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let lbTitleListWork: UILabel = {
        let label = UILabel()
        label.text = "Danh sách công việc"
        label.font = UIFont.regularFontOfSize(ofSize: Constants.TextSizes.size_13)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let lbTitleLogout: UILabel = {
        let label = UILabel()
        label.text = "Đăng xuất"
        label.font = UIFont.italicSystemFont(ofSize: Constants.TextSizes.size_13)
        label.textAlignment = .left
        return label
    }()
    
    let lbTitleInfo: UILabel = {
        let label = UILabel()
        label.text = "My Information"
        label.textColor = .white
        label.font = UIFont.mediumCustomFont(ofSize: 20)
        return label
    }()
    
    let lbVersionApp: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: Constants.TextSizes.size_13)
        label.textAlignment = .left
        label.textColor = Constants.COLORS.text_gray
        return label
    }()
    
    let vContainerCheckListWork: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Constants.COLORS.text_gray.cgColor
        return view
    }()
    
    let vContainerPunish: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Constants.COLORS.text_gray.cgColor
        return view
    }()
    
    let vContainerLogoutAndVersion: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Constants.COLORS.text_gray.cgColor
        return view
    }()
    
    let vContainerLogoutFeature: UIView = {
        let view = UIView()
        return view
    }()
    
    let vImageLogout: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "ic_log_out")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //        vMainContainer.roundedCorners(top: true)
        vMainContainer.roundCorners([.topLeft, .topRight], radius: 30)
    }
    
    override func getData() {
        super.getData()
        getEmployeeInfo()
    }
    
    override func setupViews() {
        super.setupViews()
        self.view.subviews.forEach { $0.removeFromSuperview() }
        self.view.addSubview(vImageHeaderBackgound)
        vImageHeaderBackgound.myCustomAnchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 150)
        
        setupDismissAction()
        
        view.addSubview(vMainContainer)
        vMainContainer.myCustomAnchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 128, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vImageAvatar = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
        vImageAvatar.layer.masksToBounds = false
        vImageAvatar.layer.cornerRadius = vImageAvatar.frame.size.height/2
        vImageAvatar.layer.borderWidth = 0
        vImageAvatar.clipsToBounds = true
        
        view.addSubview(vImageAvatar)
        vImageAvatar.myCustomAnchor(top: vMainContainer.topAnchor, leading: nil, trailing: nil, bottom: nil, centerX: self.view.centerXAnchor, centerY: nil, width: nil, height: nil, topConstant: -28, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 90, heightConstant: 90)
        
        vMainContainer.addSubview(lbFullName)
        lbFullName.myCustomAnchor(top: vImageAvatar.bottomAnchor, leading: nil, trailing: nil, bottom: nil, centerX: self.vMainContainer.centerXAnchor, centerY: nil, width: nil, height: nil, topConstant: 8, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vMainContainer.addSubview(lbAddress)
        lbAddress.myCustomAnchor(top: lbFullName.bottomAnchor, leading: nil, trailing: nil, bottom: nil, centerX: lbFullName.centerXAnchor, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vMainContainer.addSubview(vDetailUserInfo)
        vDetailUserInfo.myCustomAnchor(top: lbAddress.bottomAnchor, leading: vMainContainer.leadingAnchor, trailing: vMainContainer.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 10, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vMainContainer.addSubview(vContainerPunish)
        vContainerPunish.myCustomAnchor(top: self.vDetailUserInfo.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 50)
        
        vContainerPunish.addSubview(vImagePunish)
        vImagePunish.myCustomAnchor(top: nil, leading: vContainerPunish.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: vContainerPunish.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 16, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 20, heightConstant: 20)
        
        vContainerPunish.addSubview(lbTitlePunish)
        lbTitlePunish.myCustomAnchor(top: nil, leading: vImagePunish.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: vContainerPunish.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 10, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        vContainerPunish.addTapGestureRecognizer {
            self.gotoViolationScreen()
        }
        
        vContainerPunish.addSubview(vImageNext)
        vImageNext.myCustomAnchor(top: nil, leading: lbTitlePunish.trailingAnchor, trailing: vContainerPunish.trailingAnchor, bottom: nil, centerX: nil, centerY: vContainerPunish.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 10, trailingConstant: 16, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 20, heightConstant: 20)
        
        vMainContainer.addSubview(vContainerCheckListWork)
        vContainerCheckListWork.myCustomAnchor(top: self.vContainerPunish.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 50)
        vContainerCheckListWork.isHidden = false
        vContainerCheckListWork.addTapGestureRecognizer {
            self.gotoPosmViewController()
        }
        
        vContainerCheckListWork.addSubview(vImageCheckListWork)
        vImageCheckListWork.myCustomAnchor(top: nil, leading: vContainerCheckListWork.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: vContainerCheckListWork.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 16, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 20, heightConstant: 20)
        
        vContainerCheckListWork.addSubview(lbTitleListWork)
        lbTitleListWork.myCustomAnchor(top: nil, leading: vImageCheckListWork.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: vContainerCheckListWork.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 10, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(vListFeatureListMyInfo)
        vListFeatureListMyInfo.myCustomAnchor(top: vContainerCheckListWork.bottomAnchor, leading: vMainContainer.leadingAnchor, trailing: vMainContainer.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        vListFeatureListMyInfo.listFeatureViewDelegate = self
        
        vMainContainer.addSubview(vContainerLogoutAndVersion)
        vContainerLogoutAndVersion.myCustomAnchor(top: vListFeatureListMyInfo.bottomAnchor, leading: vMainContainer.leadingAnchor, trailing: vMainContainer.trailingAnchor, bottom: vMainContainer.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 20, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vContainerLogoutAndVersion.addSubview(lbVersionApp)
        
        lbVersionApp.myCustomAnchor(top: nil, leading: vContainerLogoutAndVersion.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: vContainerLogoutAndVersion.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 16, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        let nsObject: AnyObject? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject?
//        let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        let versionApp = nsObject as? String ?? ""
        lbVersionApp.text = "Version App: \(versionApp)"
        
        vContainerLogoutAndVersion.addSubview(vContainerLogoutFeature)
        vContainerLogoutFeature.myCustomAnchor(top: nil, leading: nil, trailing: vContainerLogoutAndVersion.trailingAnchor, bottom: vMainContainer.bottomAnchor, centerX: nil, centerY: vContainerLogoutAndVersion.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 16, bottomConstant: 30, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 50)
        vContainerLogoutFeature.addConstraint(NSLayoutConstraint(item: vContainerLogoutFeature, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: vContainerLogoutFeature, attribute: .width, multiplier: 1, constant: 0))
        vContainerLogoutFeature.addSubview(lbTitleLogout)
        lbTitleLogout.myCustomAnchor(top: nil, leading: vContainerLogoutFeature.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: vContainerLogoutFeature.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 4, trailingConstant: 2, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vContainerLogoutFeature.addSubview(vImageLogout)
        vImageLogout.myCustomAnchor(top: nil, leading: lbTitleLogout.trailingAnchor, trailing: vContainerLogoutFeature.trailingAnchor, bottom: nil, centerX: nil, centerY: vContainerLogoutFeature.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 4, trailingConstant: 4, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 20, heightConstant: 20)
        vContainerLogoutFeature.addTapGestureRecognizer {
            self.actionCheckKMVC()
        }
    }
    
    private func actionCheckKMVC(){
        let popup = PopupDialog(title: "ĐĂNG XUẤT", message: "Bạn muốn đăng xuất tài khoản ra khỏi ứng dụng?", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            print("Completed")
        }
        let buttonOne = CancelButton(title: "Huỷ bỏ") {
            
        }
        let buttonTwo = DefaultButton(title: "Đăng xuất") {
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "Username")
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
        popup.addButtons([buttonOne, buttonTwo])
        present(popup, animated: true, completion: nil)
    }
    
    fileprivate func gotoViolationScreen() {
        let violationScreen = ViolationInfoScreen()
        self.navigationController?.pushViewController(violationScreen, animated: true)
    }
    
    fileprivate func gotoPosmViewController() {
        let posmViewController = PosmViewController()
        self.navigationController?.pushViewController(posmViewController, animated: true)
    }
    
    fileprivate func setupDismissAction() {
        view.addSubview(vImageDismiss)
        self.view.bringSubviewToFront(vImageDismiss)
        vImageDismiss.myCustomAnchor(top: self.view.topAnchor, leading: view.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 40, leadingConstant: 20, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 30, heightConstant: 30)
        
        view.addSubview(lbTitleInfo)
        self.view.bringSubviewToFront(lbTitleInfo)
        lbTitleInfo.myCustomAnchor(top: nil, leading: vImageDismiss.trailingAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: vImageDismiss.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 8, trailingConstant: 16, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        vImageDismiss.addTapGestureRecognizer {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    fileprivate func getEmployeeInfo() {
        if let userInside = UserDefaults.standard.getUsernameEmployee() {
            self.showLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                MyInfoAPIManager.shared.getEmployeeInfo(userInside) {[weak self] (result) in
                    guard let strongSelf = self else {return}
                    guard let employeeItem = result else { return }
                    guard let avatarImageUrl = employeeItem.avatarImageLink else {return}
                    strongSelf.lbAddress.text = employeeItem.boPhan
                    strongSelf.vDetailUserInfo.getData(employeeItem)
                    getImageWithURL(urlImage: "\(avatarImageUrl)", placeholderImage: UIImage.init(named: "ic_default_avatar"), imgView: strongSelf.vImageAvatar, shouldCache: true, contentMode: .scaleAspectFill)
                    printLog(function: #function, json: "\(avatarImageUrl)")
                } failure: { (error) in
                    if error == "Bạn cần đăng nhập lại tài khoản, token hết hiệu lực" {
                        self.showPopUp(error ?? "", "Thông báo My Info", buttonTitle: "Đồng ý") {
                            self.checkGotoLogin()
                        }
                    } else {
                        self.showPopUp(error ?? "", "Thông báo My Info", buttonTitle: "Đồng ý")
                    }
                }
                self.stopLoading()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    fileprivate func setuAttributeText() {
    }
    
    fileprivate func gotoScreenInListFeature(_ type: ListFeatureMyInfo) {
        switch type {
        case .todaySaleTarget:
            let sellTodayScreen = SellTodayScreen()
            self.navigationController?.pushViewController(sellTodayScreen, animated: true)
        case .news:
            let newsScreen = NewsViewController()
            self.navigationController?.pushViewController(newsScreen, animated: true)
        case .detailRewards:
            let totalRewards = TotalINCScreen()
            self.navigationController?.pushViewController(totalRewards, animated: true)
        case .workHour:
            let workHourScreen = TotalTimeTwoMonthsScreen()
            self.navigationController?.pushViewController(workHourScreen, animated: true)
        case .getToken:
            let getAccessTokenScreen = GetOTPViewController()
            self.navigationController?.pushViewController(getAccessTokenScreen, animated: true)
        }
    }
    
}

extension MyInfoScreen: ListFeatureViewDelegate {
    func gotoScreen(_ listFeatureScreen: ListFeatureView, type: ListFeatureMyInfo) {
        gotoScreenInListFeature(type)
    }
}
