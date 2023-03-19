//
//  TabMCallLogHomeViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/17/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import Kingfisher
class TabMCallLogHomeViewController: UIViewController {
    
    var arrSection = [Section]()
    var tableView: UITableView!
    var viewHeader:UIView!
    var isLoadView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationBar()
        self.title = "CallLog"
        initSections()
        initHeader()
        initTableView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    func initSections() {
        var sellItems = [ItemApp]()
        let sellItem1 = ItemApp(id: "301", name: "YC ưu tiên", type: "32", icon: #imageLiteral(resourceName: "Duyetgiamgia"))
        let sellItem2 = ItemApp(id: "302", name: "YC không ưu tiên", type: "33", icon: #imageLiteral(resourceName: "duyetthammy"))
        let sellItem3 = ItemApp(id: "303", name: "Thông báo", type: "34", icon: #imageLiteral(resourceName: "YCDC"))
        let sellItem4 = ItemApp(id: "304", name: "We Love", type: "35", icon: #imageLiteral(resourceName: "welove"))
        let sellItem5 = ItemApp(id: "305", name: "Bill vận chuyển", type: "46", icon: #imageLiteral(resourceName: "Billvanchuyen"))
        sellItems.append(sellItem1)
        sellItems.append(sellItem2)
        sellItems.append(sellItem3)
        sellItems.append(sellItem4)
        sellItems.append(sellItem5)
        let sellSection = Section(name: "CALLLOG", arrayItems: sellItems)
        self.arrSection.append(sellSection)
        
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
}
extension TabMCallLogHomeViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    private func pushToNewViewController(_ id: String, ruleType: String) {
        var checkRuleMenu = false
        
        printLog(function: #function, json: "Open tab Callog")
        guard let listModule = UserDefaults.standard.getListUpdate() else {
            printLog(function: #function, json: "No hvae list module")
            self.checkRuleMenu(id: id, ruleType: ruleType)
            return
        }
        
        let array = listModule.components(separatedBy: ",")
        let listArrayModule = array.map { String($0)}
        
        for module in listArrayModule {
            if module == ruleType {
                checkRuleMenu = true
                break
            }
        }
        
        if checkRuleMenu {
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
            self.checkRuleMenu(id: id, ruleType: ruleType)
        }

    }
    
    func checkRuleMenu(id: String, ruleType: String) {
        
        var check = false
        
        if !isLoadView {
            isLoadView = true
            for item in Cache.ruleMenus {
                if item.p_messagess == ruleType {
                    check = true
                    break
                }
            }
            
            if(check){
                var newViewController: UIViewController!;
                switch id{
                case "301":
                    newViewController = CallLogTableViewController();
                    (newViewController as! CallLogTableViewController).callLogType = 0;
                    newViewController.navigationItem.title = "YC ưu tiên";
                    self.navigationController?.pushViewController(newViewController, animated: true);
                case "302":
                    newViewController = CallLogTableViewController();
                    (newViewController as! CallLogTableViewController).callLogType = 3;
                    newViewController.navigationItem.title = "YC không ưu tiên";
                    self.navigationController?.pushViewController(newViewController, animated: true);
                case "303":
                    newViewController = CallLogTableViewController();
                    (newViewController as! CallLogTableViewController).callLogType = 5;
                    newViewController.navigationItem.title = "Thông báo";
                    self.navigationController?.pushViewController(newViewController, animated: true);
                case "304":
                    WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
                        let permission = mCallLogApiManager.GetPermission(username: (Cache.user?.UserName)!, token: (Cache.user?.Token)!).Data;
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            if(permission != nil){
                                if(permission![0].Result! == 0){
                                    let alertVC = UIAlertController(title: "Thông báo", message: "\(permission![0].Message!)", preferredStyle: .alert);
                                    let okAction = UIAlertAction(title: "OK", style: .default, handler: {_ in
                                        alertVC.dismiss(animated: true, completion: nil);
                                    });
                                    alertVC.addAction(okAction);
                                    self.present(alertVC, animated: true, completion: nil);
                                }
                                else if(permission![0].Result! == 1){
                                    newViewController = WeLoveViewController();
                                    newViewController.navigationItem.title = "We love";
                                    self.navigationController?.pushViewController(newViewController, animated: true);
                                }
                            }
                        }
                    }
                    
                case "305":
                    newViewController = BillVCGeneralInfoViewController()
                    self.navigationController?.pushViewController(newViewController, animated: true);
                default:
                    newViewController = UIViewController();
                }
            }
        }
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.isLoadView = false
        }
    }
}

extension  TabMCallLogHomeViewController: ItemSessionTableViewCellDelegate {
    func pushTo(_ id: String, _ ruleType: String) {
        self.pushToNewViewController(id, ruleType: ruleType)
    }
}
