//
//  TabMDeliveryHomeViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/17/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import CoreLocation
class TabMDeliveryHomeViewController: UIViewController {
    
    var arrSection = [Section]()
    var tableView: UITableView!
    var viewHeader:UIView!
    var isLoadView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Giao hàng"
        initSections()
        initHeader()
        initTableView()
        self.navigationController?.navigationBar.isTranslucent = false
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor =  Constants.COLORS.sendo_color
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        }else{
            self.navigationController?.navigationBar.barTintColor = Constants.COLORS.sendo_color
            self.navigationController?.navigationBar.tintColor = Constants.COLORS.sendo_color
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func pushToNewViewController(_ id: String, type: String) {
        var checkModuleUpdate = false
        printLog(function: #function, json: "Open Tab Delivery")
        
        guard let listModule = UserDefaults.standard.getListUpdate() else {
            printLog(function: #function, json: "No have list module")
            self.gotoCheckRuleMenu(id: id, ruleType: type)
            return
        }
        
        let array = listModule.components(separatedBy: ",")
        let listArrayModule = array.map { String($0)}
        
        for module in listArrayModule {
            if module == type {
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
            self.gotoCheckRuleMenu(id: id, ruleType: type)
        }
    }
    
    
    private func gotoCheckRuleMenu(id: String, ruleType: String) {
        
        var check = false
        
        if !isLoadView {
            for item in Cache.ruleMenus {
                if (item.p_messagess == ruleType){
                    check = true
                    break
                }
            }
            if(check){
                if(id == "201"){
                    if CLLocationManager.locationServicesEnabled() {
                        switch CLLocationManager.authorizationStatus() {
                        case .notDetermined, .restricted, .denied:
                            let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa cấp quyền truy cập vị trí cho ứng dụng", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                self.showPermissionAlert()
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        case .authorizedAlways, .authorizedWhenInUse:
                            let newViewController = GHTNViewController()
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        @unknown default:
                            break
                        }
                    } else {
                        let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa cấp quyền truy cập vị trí cho ứng dụng", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            self.showPermissionAlert()
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                    
                } else if(id == "204"){
                    
                    if CLLocationManager.locationServicesEnabled() {
                        switch CLLocationManager.authorizationStatus() {
                        case .notDetermined, .restricted, .denied:
                            let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa cấp quyền truy cập vị trí cho ứng dụng", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                self.showPermissionAlert()
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        case .authorizedAlways, .authorizedWhenInUse:
                            let newViewController = BaoHanhMapController()
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        @unknown default:
                            break
                        }
                    } else {
                        let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa cấp quyền truy cập vị trí cho ứng dụng", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            self.showPermissionAlert()
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }else if(id == "205"){
                    let newViewController = BaoHanhDanhSachLoTrinhController()
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }else if(id == "206"){
                    let newViewController = BaoHanhLichSuGiaoNhanController()
                    self.navigationController?.pushViewController(newViewController, animated: true)
                } else if(id == "207"){
                    if CLLocationManager.locationServicesEnabled() {
                        switch CLLocationManager.authorizationStatus() {
                        case .notDetermined, .restricted, .denied:
                            let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa cấp quyền truy cập vị trí cho ứng dụng", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                self.showPermissionAlert()
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                            
                        case .authorizedAlways, .authorizedWhenInUse:
                            
                            let newViewController = GNNBV2MainViewController()
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        @unknown default:
                            break
                        }
                    } else {
                        let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa cấp quyền truy cập vị trí cho ứng dụng", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            self.showPermissionAlert()
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
                else if(id == "208"){
                    let newViewController = YCDCViewController()
                    self.navigationController?.pushViewController(newViewController, animated: true)
                } else if(id == "209"){
                    let newViewController = DuyetYCDCViewController()
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }else if(id == "210"){
                    let newViewController = VanDonViewController()
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
            } else {
                let popup = PopupDialog(title: "Thông báo", message: "Bạn không được cấp quyền sử dụng chức năng này. Vui lòng kiểm tra lại.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "OK") {
                    
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }
        }
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.isLoadView = false
        }
        
    }
    
    func initSections() {
        var sellItems = [ItemApp]()
        let sellItem1 = ItemApp(id: "201", name: "GH - Mdelivery", type: "26", icon: UIImage(named: "GHTN_MdliveryICON")!)
        sellItems.append(sellItem1)
        let sellSection = Section(name: "GIAO HÀNG", arrayItems: sellItems)
        self.arrSection.append(sellSection)
        //--
        var crmItems = [ItemApp]()
        //        let crmItem1 = ItemApp(id: "202", name: "Giao YCĐC", type: "27", icon: #imageLiteral(resourceName: "giaoycdc"))
        //        let crmItem2 = ItemApp(id: "203", name: "Nhận YCĐC", type: "28", icon: #imageLiteral(resourceName: "nhanycdc"))
        let crmItem3 = ItemApp(id: "207", name: "LCNB", type: "27", icon: #imageLiteral(resourceName: "nhanycdc"))
        let crmItem4 = ItemApp(id: "208", name: "YCĐC", type: "85", icon: #imageLiteral(resourceName: "nhanycdc"))
        let crmItem5 = ItemApp(id: "209", name: "Duyệt YCĐC", type: "86", icon: #imageLiteral(resourceName: "nhanycdc"))
        let crmItem6 = ItemApp(id: "210", name: "Duyệt Vận Đơn", type: "87", icon: #imageLiteral(resourceName: "nhanycdc"))
        
        //        crmItems.append(crmItem1)
        //        crmItems.append(crmItem2)
        crmItems.append(crmItem3)
        crmItems.append(crmItem4)
        crmItems.append(crmItem5)
        crmItems.append(crmItem6)
        let crmSection = Section(name: "YÊU CẦU LUÂN CHUYỂN NỘI BỘ", arrayItems: crmItems)
        self.arrSection.append(crmSection)
        //--
        var subsidyItems = [ItemApp]()
        let subsidyItem1 = ItemApp(id: "204", name: "Giao nhận BH", type: "29", icon: #imageLiteral(resourceName: "giaonhanbaohanh"))
        let subsidyItem2 = ItemApp(id: "205", name: "DS lộ trình", type: "30", icon: #imageLiteral(resourceName: "dslotrinh"))
        let subsidyItem3 = ItemApp(id: "206", name: "Lịch sử BH", type: "31", icon: #imageLiteral(resourceName: "lsbaohanh"))
        
        subsidyItems.append(subsidyItem1)
        subsidyItems.append(subsidyItem2)
        subsidyItems.append(subsidyItem3)
        let subsidySection = Section(name: "BẢO HÀNH", arrayItems: subsidyItems)
        self.arrSection.append(subsidySection)
        //--
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
    
    
    func initHeader(){
        viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height))
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
        
        
        let lbName = UILabel(frame: CGRect(x: imageAvatar.frame.origin.x + imageAvatar.frame.size.width + Common.Size(s: 5), y: Common.Size(s: 5), width: viewHeader.frame.width - (imageAvatar.frame.origin.x + imageAvatar.frame.size.width + Common.Size(s: 5)), height: Common.Size(s: 20)))
        lbName.text = "\(Cache.user!.UserName) - \(Cache.user!.EmployeeName)"
        lbName.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        viewHeader.addSubview(lbName)
        //        lbName.backgroundColor = .red
        
        let lbShop = UILabel(frame: CGRect(x: lbName.frame.origin.x, y: lbName.frame.origin.y + lbName.frame.size.height, width: viewHeader.frame.width * 2/3 - Common.Size(s: 10), height: Common.Size(s: 20)))
        lbShop.text = "\(Cache.user!.ShopName)"
        lbShop.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        
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
        tableView = UITableView(frame: CGRect(x: 0, y:  viewHeader.frame.origin.y + viewHeader.frame.size.height, width: self.view.frame.width, height:self.view.frame.height -
            self.navigationController!.navigationBar.frame.size.height - UIApplication.shared.statusBarFrame.height - viewHeader.frame.size.height), style: UITableView.Style.plain)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemSessionTableViewCell.self, forCellReuseIdentifier: "ItemSessionTableViewCell")
        tableView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
    }
    func showPermissionAlert(){
        let alertController = UIAlertController(title: "Location Permission Required", message: "Vui lòng vào cài đặt cho phép ứng dụng truy cập vị trí !", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Vào cài đặt", style: .default, handler: {(cAlertAction) in
            //Redirect to Settings app
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        alertController.addAction(cancelAction)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
extension TabMDeliveryHomeViewController: UITableViewDelegate, UITableViewDataSource {
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
        cell.setUpCollectionView()
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = Constants.COLORS.sendo_color
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

extension TabMDeliveryHomeViewController: ItemSessionTableViewCellDelegate {
    func pushTo(_ id: String, _ ruleType: String) {
        self.pushToNewViewController(id, type: ruleType)
    }
}
