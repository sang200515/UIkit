//
//  MainViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/17/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift
import PopupDialog
import Kingfisher

class MainViewController:UITabBarController, UITabBarControllerDelegate,PopUpMessageViewDelegate {
    
    var viewInput:PopUpMessageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let tabHome = TabMPOSHomeViewController()
        let tabHomeBarItem = UITabBarItem(title: "Bán hàng", image: #imageLiteral(resourceName: "TabMPOS"), selectedImage: #imageLiteral(resourceName: "TabMPOS"))
        tabHome.tabBarItem = tabHomeBarItem
        
        let  tabNews = NewsViewController()
        let tabNewsBarItem = UITabBarItem(title: "Tin tức", image: #imageLiteral(resourceName: "Inside"), selectedImage:#imageLiteral(resourceName: "Inside"))
        tabNews.tabBarItem = tabNewsBarItem
        
        let tabActivity = TabMDeliveryHomeViewController()
        let tabActivityBarItem = UITabBarItem(title: "Giao hàng", image: #imageLiteral(resourceName: "TabMDELIVERY"), selectedImage: #imageLiteral(resourceName: "TabMDELIVERY"))
        tabActivity.tabBarItem = tabActivityBarItem
        
        let  tabConversation = TabMCallLogHomeViewController()
        let tabAssetsLowBarItem = UITabBarItem(title: "CallLog", image: #imageLiteral(resourceName: "TabMCALLLOG"), selectedImage:#imageLiteral(resourceName: "TabMCALLLOG"))
        tabConversation.tabBarItem = tabAssetsLowBarItem
        
        let  tabSchedule = TabMSMHomeViewController()
        let tabScheduleBarItem = UITabBarItem(title: "Báo cáo", image: #imageLiteral(resourceName: "TabMSM"), selectedImage:#imageLiteral(resourceName: "TabMSM"))
        tabSchedule.tabBarItem = tabScheduleBarItem
        
        let controllers = [UINavigationController(rootViewController: tabHome),UINavigationController(rootViewController: tabActivity),UINavigationController(rootViewController: tabConversation),UINavigationController(rootViewController: tabSchedule)]
        self.viewControllers = controllers
        
       
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(netHex:0x00955E)
            let tabBarItemAppearance = UITabBarItemAppearance()
            tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
            tabBarItemAppearance.normal.iconColor = .white
            tabBarItemAppearance.selected.iconColor = .orange
            appearance.stackedLayoutAppearance = tabBarItemAppearance
            self.tabBar.standardAppearance = appearance
           self.tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }else{
            self.tabBar.tintColor = UIColor(netHex:0x00955E)
        }
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(showVerifyVersion), name: Notification.Name("showVerifyVersion"), object: nil)
        
        MPOSAPIMangerV2.shared.updateDeviceInfo(completion: { result in })
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("showVerifyVersion"), object: nil)
        
    }
    
    @objc func showVerifyVersionOld(notification:Notification) -> Void {
        APIManager.checkVersion { (results, err) in
            if err.count <= 0 {
                if(results.count == 5){
                    Cache.versionApps = results
                    if(results[0].Version != Common.versionApp()){
                        let popup = PopupDialog(title: "Thông báo", message: "Có bản cập nhật mới (\(results[0].Version)).\r\nBạn vui lòng cập nhật lại ứng dụng để tiếp tục sử dụng.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = DefaultButton(title: "Cập nhật") {
                            guard let url = URL(string: "\(Config.manager.URL_UPDATE!)") else {
                                return
                            }
                            
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            } else {
                                UIApplication.shared.openURL(url)
                            }
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                        return
                    }
                }
            } else {
            }
        }
    }
    
     @objc func showVerifyVersion(notification:Notification) -> Void {
        let defaults = UserDefaults.standard
        defaults.removeListUpdateModule()
        defaults.removeIsUpdateVersionRoot()
        defaults.removeGetUpdateDescription()
        let versionApp = Common.myCustomVersionApp() ?? ""
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        let params: [String : Any] = [
            "Devicetype":2,
            "Version":versionApp,
            "Usercode": userCode
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            NewCheckVersionAPIManager.shared.newCheckVersion(params) {[weak self] (result, error) in
                guard let strongSelf = self else {return}
                if let item = result {
                    if item.version != versionApp {
                        guard let description = item.descriptions else {return}
                        UserDefaults.standard.setUpdateDescription(description)
                        if item.isUpdateApp == 1 {
                            UserDefaults.standard.setUpdateDescription(description)
                            UserDefaults.standard.setIsUpdateVersionRoot(isUpdate: true)
                            strongSelf.showPopUpCustom(title: "Thông báo", titleButtonOk: "Cập nhật", titleButtonCancel: nil, message: description, actionButtonOk: {
                                guard let url = URL(string: "\(Config.manager.URL_UPDATE!)") else {
                                    return
                                }
                                if #available(iOS 10.0, *) {
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                } else {
                                    UIApplication.shared.openURL(url)
                                }
                            }, actionButtonCancel: nil, isHideButtonOk: false, isHideButtonCancel: true)
                            return
                        }
                        
                        if item.isUpdateApp == 0 {
                            UserDefaults.standard.setIsUpdateVersionRoot(isUpdate: false)
                            if let listModule = item.listModule {
                                UserDefaults.standard.setListUpdateApp(list: listModule)
                                guard let description = item.descriptions else {return}
                                //                                let htmlData = Data(description.utf8)
                                //                                let alert = htmlData.html2String
                                //                                let descriptionText = String(alert.filter { !"\t\r".contains($0) })
                                strongSelf.showPopUpCustom(title: "Thông báo", titleButtonOk: "Chấp nhận", titleButtonCancel: "Huỷ", message: description, actionButtonOk: {
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
                            } else {
                                let popup = PopupDialog(title: "Thông báo", message: "Không có danh sách module cập nhật nào", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let buttonOne = DefaultButton(title: "ok", action: nil)
                                popup.addButtons([buttonOne])
                                strongSelf.present(popup, animated: true, completion: nil)
                                return
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func didClose(sender: PopUpMessageViewDelegate) {
        viewInput.removeFromSuperview()
    }
}
class ItemAppCell: UICollectionViewCell {
    var iconImage:UIImageView!
    var name: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    func setup(item:ItemApp){
        self.subviews.forEach { $0.removeFromSuperview() }
        iconImage = UIImageView(frame: CGRect(x: self.frame.size.width/4, y:  self.frame.size.width/6, width: self.frame.size.width/2, height:  self.frame.size.width/2))
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
        iconImage.image = item.icon
        
        name = UILabel(frame: CGRect(x: 0, y:  iconImage.frame.size.height + iconImage.frame.origin.y + Common.Size(s: 7), width: self.frame.size.width, height:  Common.Size(s:20)))
        name.textColor = UIColor.black
        name.numberOfLines = 1
        name.textAlignment = .center
        name.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        addSubview(name)
        name.text = "\(item.name)"
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
