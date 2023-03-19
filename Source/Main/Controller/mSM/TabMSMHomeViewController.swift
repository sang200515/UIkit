//
//  TabMSMHomeViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/17/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import Kingfisher
class TabMSMHomeViewController: UIViewController {
    
    var arrSection = [Section]()
    var tableView: UITableView!
    var viewHeader:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationBar()
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Báo cáo"
        //        initSections()
        initHeader()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.tabBarController?.tabBar.isHidden = false;
        
        if let isUpdateVersionRoot = UserDefaults.standard.getIsUpdateVersionRoot() {
            if isUpdateVersionRoot == true {
                let description = UserDefaults.standard.getUpdateDescription()
                let convertedDes = description?.htmlToString
                let descriptionText = String(convertedDes?.filter { !"\n\r".contains($0) } ?? "")

                let popup = PopupDialog(title: "Thông báo", message: "\(descriptionText)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    printLog(function: #function, json: "Completed")
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
                let buttonTwo = CancelButton(title: "Huỷ") {
                    
                }
                popup.addButtons([buttonOne,buttonTwo])
                self.present(popup, animated: true, completion: nil)
                return
            }
        }
        initTableView();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
        NotificationCenter.default.removeObserver(self, name: Notification.Name("pushNewView"), object: nil)
    }
    
    @objc func canRotate() -> Void{}
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.shared.statusBarOrientation;
            
            switch orient {
            case .portrait:
                if self.viewHeader != nil {
                    self.viewHeader.removeFromSuperview()
                }
                self.title = "Báo cáo"
                self.initHeader()
                
            case .landscapeLeft,
                 .landscapeRight:
                
                if self.viewHeader != nil {
                    self.viewHeader.removeFromSuperview()
                }
                self.title = "Báo cáo"
                self.initHeader()
            default:
                break;
            }
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
            
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    func initHeader(){
        viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44 + 20))
        self.view.addSubview(viewHeader)
        
        let imageAvatar = UIImageView(frame: CGRect(x: 5, y: 5, width: viewHeader.frame.size.height - 10, height: viewHeader.frame.size.height - 10))
        imageAvatar.image = UIImage(named: "avatar")
        imageAvatar.layer.borderWidth = 1
        imageAvatar.layer.masksToBounds = false
        imageAvatar.layer.borderColor = UIColor.white.cgColor
        imageAvatar.layer.cornerRadius = imageAvatar.frame.height/2
        imageAvatar.clipsToBounds = true
        imageAvatar.contentMode = .scaleAspectFill
        viewHeader.addSubview(imageAvatar)
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
        
        
        let lbName = UILabel(frame: CGRect(x: imageAvatar.frame.origin.x + imageAvatar.frame.size.width + Common.Size(s: 5), y: Common.Size(s: 5), width: viewHeader.frame.width - (imageAvatar.frame.origin.x + imageAvatar.frame.size.width + Common.Size(s: 5)), height: 20))
        lbName.text = "\(Cache.user?.UserName ?? "") - \(Cache.user?.EmployeeName ?? "")"
        lbName.font = UIFont.boldSystemFont(ofSize: 13)
        viewHeader.addSubview(lbName)
        
        let lbShop = UILabel(frame: CGRect(x: lbName.frame.origin.x, y: lbName.frame.origin.y + lbName.frame.size.height, width: viewHeader.frame.width * 2/3 - Common.Size(s: 10), height: 20))
        lbShop.text = "\(Cache.user?.ShopName ?? "")"
        lbShop.font = UIFont.systemFont(ofSize: 13)
        
        viewHeader.addSubview(lbShop)
        
        let viewHeaderLine = UIView(frame: CGRect(x: 0, y: viewHeader.frame.size.height - 0.5, width: viewHeader.frame.width, height: 0.5))
        viewHeaderLine.backgroundColor = UIColor(netHex: 0xEEEEEE)
        viewHeader.addSubview(viewHeaderLine)
    }
    
    
    @objc func tapUserInfo() {
        //        let newViewController = UserInfoViewController()
        //        self.navigationController?.pushViewController(newViewController, animated: true)
        let myInfoScreen = MyInfoScreen()
        let infoNav = UINavigationController(rootViewController: myInfoScreen)
        infoNav.modalPresentationStyle = .fullScreen
        self.navigationController?.present(infoNav, animated: true, completion: nil)
    }
    func initTableView(){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
            let msmReportTableVC = ReportItemMainViewController();
            
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                self.addChild(msmReportTableVC);
                self.view.addSubview(msmReportTableVC.view);
                msmReportTableVC.view.frame = CGRect(x: 0, y:  self.viewHeader.frame.origin.y + self.viewHeader.frame.size.height, width: self.view.frame.width, height:self.view.frame.height -
                    self.navigationController!.navigationBar.frame.size.height - UIApplication.shared.statusBarFrame.height - self.viewHeader.frame.size.height);
                msmReportTableVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                msmReportTableVC.didMove(toParent: self);
            }
        }
    }
}
