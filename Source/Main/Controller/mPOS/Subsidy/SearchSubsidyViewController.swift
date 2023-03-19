//
//  SearchSubsidyViewController.swift
//  mPOS
//
//  Created by MinhDH on 1/6/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import PopupDialog

class SearchSubsidyViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate{
    var scrollView:UIScrollView!
    var tfCMND:UITextField!
    //    var tfStatus:UITextField!
    
    var tableView: UITableView  =   UITableView()
    var items: [SubsidyOrder] = []
    
    var lbValueHistory, lbTextHistory:UILabel!
    
    
    
    var btBaoMatMay:UIButton!
    
    var window: UIWindow?
    
    var btGuiYCCheck:UIButton!
    var btTimKiem:UIButton!
    var viewCheckCIC:UIView!
    
    
    var tfSoCallLogCheckCIC:UITextField!
    var tfTinhTrangDuyetCheckCIC:UITextField!
    var tfGhiChuCheckCIC:UITextView!
    
    
    var lbSoCallLogCheckCIC: UILabel!
    var lbTinhTrangDuyetCheckCIC: UILabel!
    var lbGhiChuCheckCIC: UILabel!
    var lbTextStatus: UILabel!
    var lbTrangThaiKHSubsidy: UILabel!
    
    var tfStatus:UITextField!
    var viewTrangThaiMuaHang: UIView!
    
    var infoCallLog:InfoCallLogSearchCMND = InfoCallLogSearchCMND(IDCallLog:0
        , GhiChu : ""
        , TrangThaiCallLog: "")
    
    

    override func viewDidLoad() {
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(SearchSubsidyViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = ""
        navigationController?.navigationBar.isTranslucent = false
        
        //        let lbUserInfo = UILabel(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:20)))
        //        lbUserInfo.textAlignment = .center
        //        lbUserInfo.textColor = UIColor(netHex:0x47B054)
        //        lbUserInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        //        lbUserInfo.text = "TRA CỨU KH SUBSIDY"
        //        scrollView.addSubview(lbUserInfo)
        
        let lbTextCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMND.textAlignment = .left
        lbTextCMND.textColor = UIColor.black
        lbTextCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMND.text = "SĐT hoặc CMND (*)"
        scrollView.addSubview(lbTextCMND)
        
        tfCMND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextCMND.frame.origin.y + lbTextCMND.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:40)));
        tfCMND.placeholder = "Nhập SĐT hoặc CMND khách hàng"
        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMND.autocorrectionType = UITextAutocorrectionType.no
        tfCMND.keyboardType = UIKeyboardType.numberPad
        tfCMND.returnKeyType = UIReturnKeyType.done
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMND.delegate = self
        scrollView.addSubview(tfCMND)
        tfCMND.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        
        btTimKiem = UIButton()
        btTimKiem.frame = CGRect(x: tfCMND.frame.origin.x, y: tfCMND.frame.origin.y + tfCMND.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30),height: Common.Size(s: 40) )
        btTimKiem.backgroundColor = UIColor(netHex:0x47B054)
        btTimKiem.setTitle("Tìm Kiếm", for: .normal)
        btTimKiem.addTarget(self, action: #selector(actionBaoMatMay), for: .touchUpInside)
        btTimKiem.layer.borderWidth = 0.5
        btTimKiem.layer.borderColor = UIColor.white.cgColor
        btTimKiem.layer.cornerRadius = 3
        scrollView.addSubview(btTimKiem)
        btTimKiem.clipsToBounds = true
        
        btBaoMatMay = UIButton()
        btBaoMatMay.frame = CGRect(x: tfCMND.frame.origin.x, y: btTimKiem.frame.origin.y + btTimKiem.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30),height: Common.Size(s: 40) )
        btBaoMatMay.backgroundColor = UIColor(netHex:0x47B054)
        btBaoMatMay.setTitle("Khóa máy theo yêu cầu của KH", for: .normal)
        btBaoMatMay.addTarget(self, action: #selector(actionBaoMatMay), for: .touchUpInside)
        btBaoMatMay.layer.borderWidth = 0.5
        btBaoMatMay.layer.borderColor = UIColor.white.cgColor
        btBaoMatMay.layer.cornerRadius = 3
        scrollView.addSubview(btBaoMatMay)
        btBaoMatMay.clipsToBounds = true
        
        btGuiYCCheck = UIButton()
        btGuiYCCheck.frame = CGRect(x: tfCMND.frame.origin.x, y: btBaoMatMay.frame.origin.y + btBaoMatMay.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30),height: 0)
        btGuiYCCheck.backgroundColor = UIColor(netHex: 0x3366CC)
        btGuiYCCheck.setTitle("Gửi YC Check CIC ", for: .normal)
        btGuiYCCheck.addTarget(self, action: #selector(actionGuiYCCIC), for: .touchUpInside)
        btGuiYCCheck.layer.borderWidth = 0.5
        btGuiYCCheck.layer.borderColor = UIColor.white.cgColor
        btGuiYCCheck.layer.cornerRadius = 3
        scrollView.addSubview(btGuiYCCheck)
        btGuiYCCheck.clipsToBounds = true
        
        
        
        
        viewCheckCIC = UIView(frame: CGRect(x: Common.Size(s:15), y: btGuiYCCheck.frame.size.height + btGuiYCCheck.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: 0))
        viewCheckCIC.backgroundColor = UIColor(netHex:0xf4f4f4)
        viewCheckCIC.layer.borderWidth = Common.Size(s: 0.35)
        viewCheckCIC.layer.borderColor = UIColor.lightGray.cgColor
        viewCheckCIC.layer.cornerRadius = Common.Size(s: 4)
        scrollView.addSubview(viewCheckCIC)
        
        
        lbTrangThaiKHSubsidy = UILabel(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: 0))
        lbTrangThaiKHSubsidy.textAlignment = .left
        lbTrangThaiKHSubsidy.textColor = UIColor(netHex: 0x00CC99)
        lbTrangThaiKHSubsidy.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTrangThaiKHSubsidy.text = "Trạng thái khách hàng Subsidy"
        viewCheckCIC.addSubview(lbTrangThaiKHSubsidy)
        
        
        
        lbSoCallLogCheckCIC = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lbTrangThaiKHSubsidy.frame.origin.y + lbTrangThaiKHSubsidy.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:40), height: 0))
        lbSoCallLogCheckCIC.textAlignment = .left
        lbSoCallLogCheckCIC.textColor = UIColor.black
        lbSoCallLogCheckCIC.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoCallLogCheckCIC.text = "Số CallLog"
        viewCheckCIC.addSubview(lbSoCallLogCheckCIC)
        
        tfSoCallLogCheckCIC = UITextField(frame: CGRect(x: Common.Size(s: 5), y: lbSoCallLogCheckCIC.frame.origin.y + lbSoCallLogCheckCIC.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:40), height: 0));
        tfSoCallLogCheckCIC.placeholder = ""
        tfSoCallLogCheckCIC.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        tfSoCallLogCheckCIC.borderStyle = UITextField.BorderStyle.roundedRect
        tfSoCallLogCheckCIC.autocorrectionType = UITextAutocorrectionType.no
        tfSoCallLogCheckCIC.keyboardType = UIKeyboardType.numberPad
        tfSoCallLogCheckCIC.returnKeyType = UIReturnKeyType.done
        tfSoCallLogCheckCIC.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfSoCallLogCheckCIC.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSoCallLogCheckCIC.delegate = self
        tfSoCallLogCheckCIC.isEnabled = false
        tfSoCallLogCheckCIC.isUserInteractionEnabled = false
        viewCheckCIC.addSubview(tfSoCallLogCheckCIC)
        
        lbTinhTrangDuyetCheckCIC = UILabel(frame: CGRect(x: Common.Size(s: 5), y: tfSoCallLogCheckCIC.frame.origin.y + tfSoCallLogCheckCIC.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:40), height: 0))
        lbTinhTrangDuyetCheckCIC.textAlignment = .left
        lbTinhTrangDuyetCheckCIC.textColor = UIColor.black
        lbTinhTrangDuyetCheckCIC.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTinhTrangDuyetCheckCIC.text = "Tình trạng duyệt"
        viewCheckCIC.addSubview(lbTinhTrangDuyetCheckCIC)
        
        tfTinhTrangDuyetCheckCIC = UITextField(frame: CGRect(x: Common.Size(s: 5), y: lbTinhTrangDuyetCheckCIC.frame.origin.y + lbTinhTrangDuyetCheckCIC.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:40), height: 0));
        tfTinhTrangDuyetCheckCIC.placeholder = ""
        tfTinhTrangDuyetCheckCIC.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        tfTinhTrangDuyetCheckCIC.borderStyle = UITextField.BorderStyle.roundedRect
        tfTinhTrangDuyetCheckCIC.autocorrectionType = UITextAutocorrectionType.no
        tfTinhTrangDuyetCheckCIC.keyboardType = UIKeyboardType.numberPad
        tfTinhTrangDuyetCheckCIC.returnKeyType = UIReturnKeyType.done
        tfTinhTrangDuyetCheckCIC.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfTinhTrangDuyetCheckCIC.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTinhTrangDuyetCheckCIC.delegate = self
        tfTinhTrangDuyetCheckCIC.isEnabled = false
        tfTinhTrangDuyetCheckCIC.isUserInteractionEnabled = false
        tfTinhTrangDuyetCheckCIC.textColor = UIColor.blue
        viewCheckCIC.addSubview(tfTinhTrangDuyetCheckCIC)
        
        lbGhiChuCheckCIC = UILabel(frame: CGRect(x: Common.Size(s: 5), y: tfTinhTrangDuyetCheckCIC.frame.origin.y + tfTinhTrangDuyetCheckCIC.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:40), height: 0))
        lbGhiChuCheckCIC.textAlignment = .left
        lbGhiChuCheckCIC.textColor = UIColor.black
        lbGhiChuCheckCIC.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbGhiChuCheckCIC.text = "Ghi chú"
        viewCheckCIC.addSubview(lbGhiChuCheckCIC)
        
        tfGhiChuCheckCIC = UITextView(frame: CGRect(x: Common.Size(s: 5), y: lbGhiChuCheckCIC.frame.origin.y + lbGhiChuCheckCIC.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:40), height: 0));
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        tfGhiChuCheckCIC.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        tfGhiChuCheckCIC.layer.borderWidth = 0.5
        tfGhiChuCheckCIC.layer.borderColor = borderColor.cgColor
        tfGhiChuCheckCIC.layer.cornerRadius = 5.0
        tfGhiChuCheckCIC.autocorrectionType = UITextAutocorrectionType.no
        tfGhiChuCheckCIC.keyboardType = UIKeyboardType.numberPad
        tfGhiChuCheckCIC.returnKeyType = UIReturnKeyType.done
        
        
        tfGhiChuCheckCIC.isUserInteractionEnabled = false
        viewCheckCIC.addSubview(tfGhiChuCheckCIC)
        
        
        
        
        
        
        
        
        
        //        viewStatus = UIView(frame: CGRect(x: Common.Size(s:15), y: lbTextStatus.frame.size.height + lbTextStatus.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        //        viewStatus.backgroundColor = UIColor(netHex:0xf4f4f4)
        //        viewStatus.layer.borderWidth = Common.Size(s: 0.35)
        //        viewStatus.layer.borderColor = UIColor.lightGray.cgColor
        //        viewStatus.layer.cornerRadius = Common.Size(s: 4)
        //        scrollView.addSubview(viewStatus)
        //
        //        lbStatus = UILabel(frame: CGRect(x: Common.Size(s:3), y: Common.Size(s:8), width: viewStatus.frame.size.width - Common.Size(s:6), height: Common.Size(s:40)))
        //        lbStatus.textAlignment = .center
        //        lbStatus.textColor = UIColor.blue
        //        lbStatus.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        //        lbStatus.numberOfLines = 5
        //        viewStatus.addSubview(lbStatus)
        
        
        
        
        viewTrangThaiMuaHang = UIView(frame: CGRect(x: Common.Size(s:15), y: btBaoMatMay.frame.size.height + btBaoMatMay.frame.origin.y + Common.Size(s:15), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s: 75)))
        viewTrangThaiMuaHang.backgroundColor = UIColor(netHex:0xf4f4f4)
        viewTrangThaiMuaHang.layer.borderWidth = Common.Size(s: 0.35)
        viewTrangThaiMuaHang.layer.borderColor = UIColor.lightGray.cgColor
        viewTrangThaiMuaHang.layer.cornerRadius = Common.Size(s: 4)
        scrollView.addSubview(viewTrangThaiMuaHang)
        
        
        
        lbTextStatus = UILabel(frame: CGRect(x: Common.Size(s:5), y:  Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextStatus.textAlignment = .left
        lbTextStatus.textColor =  UIColor(netHex: 0x00CC99)
        lbTextStatus.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextStatus.text = "Trạng thái mua hàng Subsidy"
        viewTrangThaiMuaHang.addSubview(lbTextStatus)
        
        tfStatus = UITextField(frame: CGRect(x: Common.Size(s:5), y: lbTextStatus.frame.size.height + lbTextStatus.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:40) , height: Common.Size(s:40)))
        tfStatus.placeholder = ""
        tfStatus.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        tfStatus.borderStyle = UITextField.BorderStyle.roundedRect
        tfStatus.autocorrectionType = UITextAutocorrectionType.no
        tfStatus.keyboardType = UIKeyboardType.default
        tfStatus.returnKeyType = UIReturnKeyType.done
        tfStatus.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfStatus.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfStatus.delegate = self
        tfStatus.textAlignment = .center
        tfStatus.isUserInteractionEnabled = false
        tfStatus.autocapitalizationType = .words
        viewTrangThaiMuaHang.addSubview(tfStatus)
        
        tfStatus.isEnabled = false
        tfStatus.textColor = .blue
        
        
        
        lbTextHistory = UILabel(frame: CGRect(x: Common.Size(s:5), y: tfStatus.frame.origin.y + tfStatus.frame.size.height + Common.Size(s:8), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextHistory.textAlignment = .left
        lbTextHistory.textColor = UIColor.black
        lbTextHistory.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextHistory.text = "Lịch sử mua hàng của KH:"
        lbTextHistory.sizeToFit()
        viewTrangThaiMuaHang.addSubview(lbTextHistory)
        lbTextHistory.isHidden = true
        
        lbValueHistory = UILabel(frame: CGRect(x: lbTextHistory.frame.size.width + lbTextHistory.frame.origin.x + Common.Size(s: 5), y: lbTextHistory.frame.origin.y + lbTextHistory.frame.size.height/2 - Common.Size(s:16)/2, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:16)))
        lbValueHistory.textAlignment = .left
        lbValueHistory.textColor = UIColor.black
        lbValueHistory.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbValueHistory.text = "... đơn hàng"
        viewTrangThaiMuaHang.addSubview(lbValueHistory)
        lbValueHistory.isHidden = true
        
        
        
        
        
        tableView.frame = CGRect(x: 0, y:viewTrangThaiMuaHang.frame.size.height + viewTrangThaiMuaHang.frame.origin.y + Common.Size(s: 10), width: self.view.frame.size.width, height: self.view.frame.size.height - (lbValueHistory.frame.size.height + lbValueHistory.frame.origin.y + Common.Size(s: 10)) - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemSubsidyTableViewCell.self, forCellReuseIdentifier: "ItemSubsidyTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Common.Size(s:110)
        scrollView.addSubview(tableView)
        
        self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.tableView.frame.origin.y + self.tableView.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 60))
        
    }
    @objc func actionBaoMatMay(){
        tfCMND.resignFirstResponder()
        if (tfCMND.text == "") {
           
             self.showDialog(message: "Vui lòng nhập cmnd khách hàng")
            return
        }
        let newViewController = BaoMatMayViewController()
        newViewController.cmnd = self.tfCMND.text
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    @objc func actionBack() {
        self.tfCMND.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)
    }
    func actionTimKiem(){
        let sdt = self.tfCMND.text!
        if(sdt.count > 0){
            
            
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra thông tin khách hàng..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            
            MPOSAPIManager.searchCNMD_subsidy(cmnd: "\(sdt)", usercode: "\(Cache.user!.UserName)") { (results,IsLogin,p_Status, message,Flag_CreateCallLog,infoCallLogSearchCMND, err) in
                
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(IsLogin == "1"){
                    let title = "Thông báo"
                    
                    
                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
                        defaults.removeObject(forKey: "CRMCodeLogin")
                        defaults.synchronize()
                        //  APIService.removeDeviceToken()
                        // Initialize the window
                        self.window = UIWindow.init(frame: UIScreen.main.bounds)
                        
                        // Set Background Color of window
                        self.window?.backgroundColor = UIColor.white
                        
                        // Allocate memory for an instance of the 'MainViewController' class
                        let mainViewController = LoginViewController()
                        
                        // Set the root view controller of the app's window
                        self.window!.rootViewController = mainViewController
                        
                        // Make the window visible
                        self.window!.makeKeyAndVisible()
                        
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                    return
                }
                
                
                if(p_Status == "0"){
                    let title = "Thông báo"
                    
                    
                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    
                    let buttonOne = CancelButton(title: "OK") {
                        
                        
                        
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    return
                    
                }
                
                
                if(err.count <= 0){
                    self.infoCallLog  = infoCallLogSearchCMND
                    self.statusText(message: message,Flag_CreateCallLog: Flag_CreateCallLog,infoCallLogSearchCMND:self.infoCallLog);
                    self.lbTextHistory.isHidden = false
                    self.lbValueHistory.isHidden = false
                    self.lbValueHistory.text = "\(results.count) đơn hàng"
                    self.items = results
                    self.tableView.reloadData()
                    
                    // self.btBaoMatMay.frame.size.height = Common.Size(s: 40) * 1.2
                }else{
                    self.statusText(message: "",Flag_CreateCallLog:Flag_CreateCallLog,infoCallLogSearchCMND:self.infoCallLog);
                    self.lbTextHistory.isHidden = true
                    self.lbValueHistory.isHidden = true
                    self.items = []
                    self.tableView.reloadData()
                    self.lbValueHistory.text = "... đơn hàng"
                    //  self.btBaoMatMay.frame.size.height = 0
                }
                
            }
        }else{
            self.statusText(message: "",Flag_CreateCallLog:0,infoCallLogSearchCMND:self.infoCallLog);
            self.lbTextHistory.isHidden = true
            self.lbValueHistory.isHidden = true
            self.items = []
            self.tableView.reloadData()
            self.lbValueHistory.text = "... đơn hàng"
            // self.btBaoMatMay.frame.size.height = 0
        }
    }
    @objc func actionGuiYCCIC(){
        
        if (tfCMND.text == "") {
   
            self.showDialog(message: "Vui lòng nhập cmnd khách hàng")
            return
        }
        if (tfCMND.text!.count == 9 || tfCMND.text!.count == 12){
            
        }else{
          
               self.showDialog(message: "Mời bạn nhập số CMND 9 hoặc 12 số để check CIC")
            return
        }
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang gởi yêu cầu kiểm tra CIC..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.checkCICKhachHang(CMNDKH: self.tfCMND.text!) { (results,message, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    
                    
                    
                    
                    self.tfSoCallLogCheckCIC.text = "\(results[0].IDCallLog)"
                    
                    self.tfTinhTrangDuyetCheckCIC.text = results[0].TrangThaiCallLog
                    
                    
                    self.tfGhiChuCheckCIC.text = results[0].GhiChu
                    
                    self.btGuiYCCheck.frame.size.height = 0
                    
                }else{
                    
                    
                    
                    self.tfSoCallLogCheckCIC.text = ""
                    
                    self.tfTinhTrangDuyetCheckCIC.text = ""
                    
                    self.tfGhiChuCheckCIC.text = ""
                    
                    
                    
                    
                    
                    
                    let title = "Thông báo"
                 
                    
                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let sdt = textField.text!
        if(sdt.count > 0){
            
            
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra thông tin khách hàng..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            
            MPOSAPIManager.searchCNMD_subsidy(cmnd: "\(sdt)", usercode: "\(Cache.user!.UserName)") { (results,IsLogin,p_Status, message,Flag_CreateCallLog,infoCallLogSearchCMND, err) in
                
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(IsLogin == "1"){
                    let title = "Thông báo"
                
                    
                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
                        defaults.removeObject(forKey: "CRMCodeLogin")
                        defaults.synchronize()
                      //  APIService.removeDeviceToken()
                        // Initialize the window
                        self.window = UIWindow.init(frame: UIScreen.main.bounds)
                        
                        // Set Background Color of window
                        self.window?.backgroundColor = UIColor.white
                        
                        // Allocate memory for an instance of the 'MainViewController' class
                        let mainViewController = LoginViewController()
                        
                        // Set the root view controller of the app's window
                        self.window!.rootViewController = mainViewController
                        
                        // Make the window visible
                        self.window!.makeKeyAndVisible()
                        
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                    return
                }
                
                
                if(p_Status == "0"){
                    let title = "Thông báo"
                 
                    
                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    
                    let buttonOne = CancelButton(title: "OK") {
                        
                        
                        
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    return
                    
                }
                
                
                if(err.count <= 0){
                    self.infoCallLog  = infoCallLogSearchCMND
                    self.statusText(message: message,Flag_CreateCallLog: Flag_CreateCallLog,infoCallLogSearchCMND:self.infoCallLog);
                    self.lbTextHistory.isHidden = false
                    self.lbValueHistory.isHidden = false
                    self.lbValueHistory.text = "\(results.count) đơn hàng"
                    self.items = results
                    self.tableView.reloadData()
                    
                    // self.btBaoMatMay.frame.size.height = Common.Size(s: 40) * 1.2
                }else{
                    self.statusText(message: "",Flag_CreateCallLog:Flag_CreateCallLog,infoCallLogSearchCMND:self.infoCallLog);
                    self.lbTextHistory.isHidden = true
                    self.lbValueHistory.isHidden = true
                    self.items = []
                    self.tableView.reloadData()
                    self.lbValueHistory.text = "... đơn hàng"
                    //  self.btBaoMatMay.frame.size.height = 0
                }
                
            }
        }else{
            self.statusText(message: "",Flag_CreateCallLog:0,infoCallLogSearchCMND:self.infoCallLog);
            self.lbTextHistory.isHidden = true
            self.lbValueHistory.isHidden = true
            self.items = []
            self.tableView.reloadData()
            self.lbValueHistory.text = "... đơn hàng"
            // self.btBaoMatMay.frame.size.height = 0
        }
    }
    func statusText(message: String,Flag_CreateCallLog:Int,infoCallLogSearchCMND:InfoCallLogSearchCMND){
        
        
        if(Flag_CreateCallLog == 1){
            self.btGuiYCCheck.frame.size.height = Common.Size(s: 40)
            self.viewCheckCIC.frame.size.height = Common.Size(s: 230)
            
            viewCheckCIC.frame.origin.y = self.btGuiYCCheck.frame.origin.y + self.btGuiYCCheck.frame.size.height + Common.Size(s:10)
            
        }else{
            self.btGuiYCCheck.frame.size.height = 0
            
            self.viewCheckCIC.frame.size.height = Common.Size(s: 230)
            viewCheckCIC.frame.origin.y = self.btGuiYCCheck.frame.origin.y + self.btGuiYCCheck.frame.size.height + Common.Size(s:10)
            
        }
//        if(infoCallLogSearchCMND != nil){
//
//            self.lbTrangThaiKHSubsidy.frame.size.height = Common.Size(s: 14)
//
//            self.lbSoCallLogCheckCIC.frame.origin.y = self.lbTrangThaiKHSubsidy.frame.origin.y + self.lbTrangThaiKHSubsidy.frame.size.height + Common.Size(s:5)
//            self.lbSoCallLogCheckCIC.frame.size.height = Common.Size(s: 14)
//
//            self.tfSoCallLogCheckCIC.frame.origin.y = self.lbSoCallLogCheckCIC.frame.origin.y + self.lbSoCallLogCheckCIC.frame.size.height + Common.Size(s:5)
//            self.tfSoCallLogCheckCIC.frame.size.height = Common.Size(s: 40)
//            self.tfSoCallLogCheckCIC.text = "\(infoCallLogSearchCMND.IDCallLog)"
//
//            self.lbTinhTrangDuyetCheckCIC.frame.origin.y = self.tfSoCallLogCheckCIC.frame.origin.y + self.tfSoCallLogCheckCIC.frame.size.height + Common.Size(s:5)
//            self.lbTinhTrangDuyetCheckCIC.frame.size.height = Common.Size(s: 14)
//
//            self.tfTinhTrangDuyetCheckCIC.frame.origin.y = self.lbTinhTrangDuyetCheckCIC.frame.origin.y + self.lbTinhTrangDuyetCheckCIC.frame.size.height + Common.Size(s:5)
//            self.tfTinhTrangDuyetCheckCIC.frame.size.height = Common.Size(s: 40)
//            self.tfTinhTrangDuyetCheckCIC.text = infoCallLogSearchCMND.TrangThaiCallLog
//
//            self.lbGhiChuCheckCIC.frame.origin.y = self.tfTinhTrangDuyetCheckCIC.frame.origin.y + self.tfTinhTrangDuyetCheckCIC.frame.size.height + Common.Size(s:5)
//            self.lbGhiChuCheckCIC.frame.size.height = Common.Size(s: 14)
//
//
//            self.tfGhiChuCheckCIC.frame.origin.y = self.lbGhiChuCheckCIC.frame.origin.y + self.lbGhiChuCheckCIC.frame.size.height + Common.Size(s:5)
//            self.tfGhiChuCheckCIC.frame.size.height = Common.Size(s: 50)
//            self.tfGhiChuCheckCIC.text = infoCallLogSearchCMND.GhiChu
//
//
//
//
//        }else{
//            self.tfSoCallLogCheckCIC.text = "\(0)"
//            self.tfTinhTrangDuyetCheckCIC.text = ""
//            self.tfGhiChuCheckCIC.text = ""
//        }
        self.lbTrangThaiKHSubsidy.frame.size.height = Common.Size(s: 14)
        
        self.lbSoCallLogCheckCIC.frame.origin.y = self.lbTrangThaiKHSubsidy.frame.origin.y + self.lbTrangThaiKHSubsidy.frame.size.height + Common.Size(s:5)
        self.lbSoCallLogCheckCIC.frame.size.height = Common.Size(s: 14)
        
        self.tfSoCallLogCheckCIC.frame.origin.y = self.lbSoCallLogCheckCIC.frame.origin.y + self.lbSoCallLogCheckCIC.frame.size.height + Common.Size(s:5)
        self.tfSoCallLogCheckCIC.frame.size.height = Common.Size(s: 40)
        self.tfSoCallLogCheckCIC.text = "\(infoCallLogSearchCMND.IDCallLog)"
        
        self.lbTinhTrangDuyetCheckCIC.frame.origin.y = self.tfSoCallLogCheckCIC.frame.origin.y + self.tfSoCallLogCheckCIC.frame.size.height + Common.Size(s:5)
        self.lbTinhTrangDuyetCheckCIC.frame.size.height = Common.Size(s: 14)
        
        self.tfTinhTrangDuyetCheckCIC.frame.origin.y = self.lbTinhTrangDuyetCheckCIC.frame.origin.y + self.lbTinhTrangDuyetCheckCIC.frame.size.height + Common.Size(s:5)
        self.tfTinhTrangDuyetCheckCIC.frame.size.height = Common.Size(s: 40)
        self.tfTinhTrangDuyetCheckCIC.text = infoCallLogSearchCMND.TrangThaiCallLog
        
        self.lbGhiChuCheckCIC.frame.origin.y = self.tfTinhTrangDuyetCheckCIC.frame.origin.y + self.tfTinhTrangDuyetCheckCIC.frame.size.height + Common.Size(s:5)
        self.lbGhiChuCheckCIC.frame.size.height = Common.Size(s: 14)
        
        
        self.tfGhiChuCheckCIC.frame.origin.y = self.lbGhiChuCheckCIC.frame.origin.y + self.lbGhiChuCheckCIC.frame.size.height + Common.Size(s:5)
        self.tfGhiChuCheckCIC.frame.size.height = Common.Size(s: 50)
        self.tfGhiChuCheckCIC.text = infoCallLogSearchCMND.GhiChu
        
        viewTrangThaiMuaHang.frame.size.height  = Common.Size(s: 105)
        viewTrangThaiMuaHang.frame.origin.y = viewCheckCIC.frame.size.height + viewCheckCIC.frame.origin.y + Common.Size(s:15)
        //        viewStatus.frame.origin.y = lbTextStatus.frame.size.height + lbTextStatus.frame.origin.y + Common.Size(s:5)
        //        let sizeStatus = message.height(withConstrainedWidth: viewStatus.frame.size.width - Common.Size(s:6), font: UIFont.systemFont(ofSize: Common.Size(s:13)))
        //        lbStatus.frame.size.height = sizeStatus
        //        lbStatus.text = message
        //        tfStatus.frame.origin.y = lbTextStatus.frame.size.height + lbTextStatus.frame.origin.y + Common.Size(s:5)
        //        tfStatus.text = message
        //        viewStatus.frame.size.height = tfStatus.frame.size.height + tfStatus.frame.origin.y + Common.Size(s:8)
        //        if (viewStatus.frame.size.height < Common.Size(s:40)){
        //            lbStatus.frame.size.height = Common.Size(s:40) - Common.Size(s:16)
        //            viewStatus.frame.size.height = Common.Size(s:40)
        //        }
        //        lbTextHistory.frame.origin.y = viewStatus.frame.origin.y + viewStatus.frame.size.height + Common.Size(s:15)
        //        lbValueHistory.frame.origin.y = lbTextHistory.frame.origin.y + lbTextHistory.frame.size.height/2 - Common.Size(s:16)/2
        tfStatus.text = message
        tableView.frame.origin.y = viewTrangThaiMuaHang.frame.size.height + viewTrangThaiMuaHang.frame.origin.y + Common.Size(s: 10)
        tableView.frame.size.height = self.view.frame.size.height - (lbValueHistory.frame.size.height + lbValueHistory.frame.origin.y + Common.Size(s: 10))
        
        
        self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: tableView.frame.origin.y + tableView.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 60))
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemSubsidyTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemSubsidyTableViewCell")
        let item:SubsidyOrder = items[indexPath.row]
        cell.cardName.text = "\(item.CardName)"
        cell.address.text = "\(item.DiaChi)"
        if(item.CreateDate != ""){
            //            let dateFormatter = DateFormatter()
            //            let tempLocale = dateFormatter.locale
            //            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            //            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //.SSS
            //            let date = dateFormatter.date(from: "\(item.CreateDate)")!
            //            dateFormatter.dateFormat = "dd/MM/YYYY hh:ss"
            //            dateFormatter.locale = tempLocale
            //            let dateString = dateFormatter.string(from: date)
            //            cell.soTime.text = "\(dateString)"
            
            cell.soTime.text = item.CreateDate
        }else{
            cell.soTime.text = "Không xác định"
        }
        if(item.SDTSubsidy != ""){
            cell.package.text = "Gói cước: \(item.GoiCuoc)"
            cell.soType.text = "\(item.LoaiDonHang)"
            cell.phoneSubsidy.text = "SĐT kích hoạt: \(item.SDTSubsidy)"
            cell.provider.text = "\(item.Provider)"
            cell.viewSubsidy.frame.size.height =  cell.provider.frame.size.height + cell.provider.frame.origin.y + Common.Size(s:5)
        }else{
            cell.viewSubsidy.frame.size.height = 0
            cell.viewSO.frame.origin.y =  cell.viewSubsidy.frame.size.height + cell.viewSubsidy.frame.origin.y
            cell.viewBottom.heightAnchor.constraint(equalToConstant: cell.viewSO.frame.size.height + cell.viewSO.frame.origin.y).isActive = true
        }
        cell.soMPOS.text = "mPOS: \(item.SOMPOS)"
        cell.soPOS.text = "POS: \(item.SO_POS)"
        cell.status.text = "\(item.TTDH)"
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
}
class ItemSubsidyTableViewCell: UITableViewCell {
    
    var package = UILabel()
    var viewBottom = UIView()
    var viewSubsidy = UIView()
    var viewSO = UIView()
    
    var soType = UILabel()
    var phoneSubsidy = UILabel()
    var provider = UILabel()
    
    let cardName = UILabel()
    let address = UILabel()
    let soTime = UILabel()
    var iconPhone = UIImageView()
    
    var soMPOS = UILabel()
    var soPOS = UILabel()
    var status = UILabel()
    
    var line1 = UIView()
    var line2 = UIView()
    var line3 = UIView()
    var line4 = UIView()
    var line5 = UIView()
    var line6 = UIView()
    var line7 = UIView()
    
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(cardName)
        cardName.translatesAutoresizingMaskIntoConstraints = false
        cardName.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        cardName.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        cardName.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        cardName.numberOfLines = 0
        cardName.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        
        // configure authorLabel
        contentView.addSubview(address)
        address.translatesAutoresizingMaskIntoConstraints = false
        address.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        //        product.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        address.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        address.topAnchor.constraint(equalTo: cardName.bottomAnchor, constant: Common.Size(s:3)).isActive = true
        address.numberOfLines = 0
        address.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        address.textColor = UIColor.darkGray
        
        contentView.addSubview(soTime)
        soTime.translatesAutoresizingMaskIntoConstraints = false
        soTime.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        soTime.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        soTime.topAnchor.constraint(equalTo: address.bottomAnchor, constant: Common.Size(s:3)).isActive = true
        soTime.numberOfLines = 0
        soTime.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        soTime.textColor = UIColor.darkGray
        
        contentView.addSubview(viewBottom)
        viewBottom.translatesAutoresizingMaskIntoConstraints = false
        viewBottom.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        viewBottom.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        viewBottom.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        viewBottom.topAnchor.constraint(equalTo: soTime.bottomAnchor, constant: Common.Size(s:5)).isActive = true
        
        viewSubsidy.frame = CGRect(x: 0, y:0, width: UIScreen.main.bounds.size.width - Common.Size(s:28), height: Common.Size(s:50))
        viewSubsidy.clipsToBounds = true
        viewBottom.addSubview(viewSubsidy)
        
        line1.frame = CGRect(x: Common.Size(s:1), y:Common.Size(s:5), width: Common.Size(s:1), height: Common.Size(s:16))
        line1.backgroundColor = UIColor(netHex:0x47B054)
        viewSubsidy.addSubview(line1)
        
        line2.frame = CGRect(x: viewSubsidy.frame.size.width * 2/3 , y:line1.frame.origin.y, width: line1.frame.size.width, height: Common.Size(s:16))
        line2.backgroundColor = UIColor(netHex:0x47B054)
        viewSubsidy.addSubview(line2)
        
        viewSubsidy.addSubview(package)
        package.frame = CGRect(x: line1.frame.origin.x + line1.frame.size.width + Common.Size(s: 3),y: line1.frame.origin.y,width: viewSubsidy.frame.size.width * 2/3 ,height: line1.frame.size.height)
        package.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        package.textColor = UIColor.black
        
        viewSubsidy.addSubview(soType)
        soType.frame = CGRect(x: line2.frame.origin.x + line2.frame.size.width + Common.Size(s: 3),y: line2.frame.origin.y,width: viewSubsidy.frame.size.width/3 ,height: line2.frame.size.height)
        soType.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        soType.textColor = UIColor(netHex:0x47B054)
        
        line3.frame = CGRect(x: line1.frame.origin.x, y: line1.frame.size.height + line1.frame.origin.y + Common.Size(s:5), width: Common.Size(s:1), height: Common.Size(s:16))
        line3.backgroundColor = UIColor(netHex:0x47B054)
        viewSubsidy.addSubview(line3)
        
        line4.frame = CGRect(x: line2.frame.origin.x, y:line3.frame.origin.y, width: Common.Size(s:1), height: Common.Size(s:16))
        line4.backgroundColor = UIColor(netHex:0x47B054)
        viewSubsidy.addSubview(line4)
        
        viewSubsidy.addSubview(phoneSubsidy)
        phoneSubsidy.frame = CGRect(x: line3.frame.origin.x + line3.frame.size.width + Common.Size(s: 3),y: line3.frame.origin.y,width: viewSubsidy.frame.size.width * 2/3 ,height: line2.frame.size.height)
        phoneSubsidy.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        phoneSubsidy.textColor = UIColor.black
        
        viewSubsidy.addSubview(provider)
        provider.frame = CGRect(x: line4.frame.origin.x + line4.frame.size.width + Common.Size(s: 3),y: line4.frame.origin.y,width: viewSubsidy.frame.size.width/3 ,height: line2.frame.size.height)
        provider.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        provider.textColor = UIColor.black
        
        viewSubsidy.frame.size.height = provider.frame.size.height + provider.frame.origin.y + Common.Size(s:5)
        
        viewSO.frame = CGRect(x: 0, y:viewSubsidy.frame.size.height + viewSubsidy.frame.origin.y, width: viewSubsidy.frame.size.width, height: Common.Size(s:50))
        viewBottom.addSubview(viewSO)
        
        line5.frame = CGRect(x: Common.Size(s:1), y:0, width: Common.Size(s:1), height: Common.Size(s:16))
        line5.backgroundColor = UIColor(netHex:0x47B054)
        viewSO.addSubview(line5)
        
        viewSO.addSubview(soMPOS)
        soMPOS.frame = CGRect(x: line5.frame.origin.x + line5.frame.size.width + Common.Size(s: 3),y: line5.frame.origin.y,width: viewSubsidy.frame.size.width/3 ,height: line5.frame.size.height)
        soMPOS.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        soMPOS.textColor = UIColor.darkGray
        
        line6.frame = CGRect(x: viewSO.frame.width/3 + Common.Size(s:1), y:0, width: Common.Size(s:1), height: Common.Size(s:16))
        line6.backgroundColor = UIColor(netHex:0x47B054)
        viewSO.addSubview(line6)
        
        viewSO.addSubview(soPOS)
        soPOS.frame = CGRect(x: line6.frame.origin.x + line6.frame.size.width + Common.Size(s: 3),y: line6.frame.origin.y,width: viewSubsidy.frame.size.width/3 ,height: line6.frame.size.height)
        soPOS.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        soPOS.textColor = UIColor.darkGray
        
        line7.frame = CGRect(x: viewSO.frame.width * 2/3, y:0, width: Common.Size(s:1), height: Common.Size(s:16))
        line7.backgroundColor = UIColor(netHex:0x47B054)
        viewSO.addSubview(line7)
        
        viewSO.addSubview(status)
        status.frame = CGRect(x: line7.frame.origin.x + line7.frame.size.width + Common.Size(s: 3),y: line7.frame.origin.y,width: viewSubsidy.frame.size.width/3 ,height: line7.frame.size.height)
        status.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        status.textColor = UIColor.darkGray
        
        viewSO.frame.size.height = line5.frame.size.height + line5.frame.origin.y
        viewBottom.heightAnchor.constraint(equalToConstant: viewSO.frame.size.height + viewSO.frame.origin.y).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



