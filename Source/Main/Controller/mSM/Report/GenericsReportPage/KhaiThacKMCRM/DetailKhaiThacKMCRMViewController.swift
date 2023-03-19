//
//  DetailKhaiThacKMCRMViewController.swift
//  fptshop
//
//  Created by Apple on 6/7/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import MessageUI

class DetailKhaiThacKMCRMViewController: UIViewController, MFMailComposeViewControllerDelegate, UISearchBarDelegate {

    var reportCollectionView: UICollectionView!;
    
    var header: [String] = [];
    var cellData: [[String]] = [];
    var tempHeaderForSize: [String] = [];
    var reportSection: ReportCase!;
    var mailComposer = MFMailComposeViewController();
    var isDetailsOn: Bool = false;
    var btnSearch: UIBarButtonItem!
    var btnExport: UIBarButtonItem!
    var switchDetail = UISwitch()
    var btnBack:UIBarButtonItem!
    var searchBarContainer:SearchBarContainerView!
    var listKhaiThacKMCRM: [KhaiThacKMCRM] = []
    var comboPKType = ""
    let username = (Cache.user?.UserName)!;
    let token = (Cache.user?.Token)!
    
    //Setting up view to portrait when view disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        if (self.isMovingFromParent) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
        self.view.subviews.forEach({$0.removeFromSuperview()});
    }
    
    @objc func canRotate() -> Void{}
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent;
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .allButUpsideDown;
    }
    override var shouldAutorotate: Bool{
        return true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //set up navigationbarItem
        
        btnExport = UIBarButtonItem(image: UIImage(named: "ic_export"), style: .plain, target: self, action: #selector(ExportFile))
        btnSearch = UIBarButtonItem(image: #imageLiteral(resourceName: "Search"), style: .plain, target: self, action: #selector(actionSearchAssets))
        switchDetail.addTarget(self, action: #selector(setChange), for: .valueChanged)
        self.navigationItem.rightBarButtonItems = [btnExport, btnSearch, UIBarButtonItem.init(customView: switchDetail)]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = reportSection.caseName;
        mailComposer.mailComposeDelegate = self;
        
        
        
        //search bar custom
        let searchBar = UISearchBar()
        searchBarContainer = SearchBarContainerView(customSearchBar: searchBar)
        searchBarContainer.searchBar.showsCancelButton = true
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        searchBarContainer.searchBar.delegate = self
        
        if #available(iOS 11.0, *) {
            searchBarContainer.searchBar.placeholder = "Nhập từ khoá cần tìm..."
        }else{
            searchBarContainer.searchBar.searchBarStyle = .minimal
            let textFieldInsideSearchBar = searchBarContainer.searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = .white
            
            let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            glassIconView?.tintColor = .white
            textFieldInsideSearchBar?.attributedPlaceholder = NSAttributedString(string: "Nhập từ khoá cần tìm...",
                                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            let clearButton = textFieldInsideSearchBar?.value(forKey: "clearButton") as? UIButton
            clearButton?.setImage(clearButton?.imageView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
            clearButton?.tintColor = .white
        }
        
        self.SetUpCollectionView()
        self.setChange()
    }
    
    @objc func setChange() {
        if switchDetail.isOn == true{
            switch self.comboPKType {
            case "ReportKhaiThacKMCRMVung":
                self.title = "Luỹ kế Khai thác KH Thu hộ - Theo Vùng"
                self.listKhaiThacKMCRM.removeAll()
                self.header = ["Vùng", "Số lượng", "Doanh số", "Lãi gộp", "% Lãi gộp", "SL Đơn Hàng", "SL Thu Hộ", "% Khai thác", "SL Sim", "SL PK", "Lãi gộp Sim", "Lãi gộp PK", "% Khai thác Sim", "% Khai thác PK"]
                self.getKhaiThacKH_CRM_CTKM_Vung(username: self.username, token: self.token)
                break
                
            case "ReportKhaiThacKMCRMKhuvuc" :
                self.title = "Luỹ kế Khai thác KH Thu hộ - Theo Khu Vực"
                self.listKhaiThacKMCRM.removeAll()
                self.header = ["Khu vực", "Số lượng", "Doanh số", "Lãi gộp", "% Lãi gộp", "SL Đơn Hàng", "SL Thu Hộ", "% Khai thác", "SL Sim", "SL PK", "Lãi gộp Sim", "Lãi gộp PK", "% Khai thác Sim", "% Khai thác PK"]
                self.getKhaiThacKH_CRM_CTKM_KhuVuc(username: self.username, token: self.token)
                break
                
            case "ReportKhaiThacKMCRMShop" :
                self.title = "Luỹ kế Khai thác KH Thu hộ - Theo Shop"
                self.listKhaiThacKMCRM.removeAll()
                self.header = ["Shop", "Số lượng", "Doanh số", "Lãi gộp", "% Lãi gộp", "SL Đơn Hàng", "SL Thu Hộ", "% Khai thác", "SL Sim", "SL PK", "Lãi gộp Sim", "Lãi gộp PK", "% Khai thác Sim", "% Khai thác PK"]
                self.getKhaiThacKH_CRM_CTKM_Shop(username: self.username, token: self.token)
                break
                
            default:
                break
            }
        } else {
            switch self.comboPKType {
            case "ReportKhaiThacKMCRMVung":
                self.title = "Luỹ kế Khai thác KH Thu hộ - Theo Vùng"
                self.listKhaiThacKMCRM.removeAll()
                self.header = ["Vùng", "Số lượng", "Doanh số", "Lãi gộp", "% Lãi gộp", "SL Đơn Hàng", "SL Thu Hộ", "% Khai thác"]
                self.getKhaiThacKH_CRM_CTKM_Vung(username: self.username, token: self.token)
                break
                
            case "ReportKhaiThacKMCRMKhuvuc" :
                self.title = "Luỹ kế Khai thác KH Thu hộ - Theo Khu Vực"
                self.listKhaiThacKMCRM.removeAll()
                self.header = ["Khu vực", "Số lượng", "Doanh số", "Lãi gộp", "% Lãi gộp", "SL Đơn Hàng", "SL Thu Hộ", "% Khai thác"]
                self.getKhaiThacKH_CRM_CTKM_KhuVuc(username: self.username, token: self.token)
                break
                
            case "ReportKhaiThacKMCRMShop" :
                self.title = "Luỹ kế Khai thác KH Thu hộ - Theo Shop"
                self.listKhaiThacKMCRM.removeAll()
                self.header = ["Shop", "Số lượng", "Doanh số", "Lãi gộp", "% Lãi gộp", "SL Đơn Hàng", "SL Thu Hộ", "% Khai thác"]
                self.getKhaiThacKH_CRM_CTKM_Shop(username: self.username, token: self.token)
                break
                
            default:
                break
            }
        }
    }
    
    /////------------SEARCH--------
    
    @objc func actionSearchAssets(){
        self.searchBarContainer.searchBar.text = ""
        navigationItem.titleView = searchBarContainer
        self.searchBarContainer.searchBar.alpha = 0
        navigationItem.setRightBarButtonItems(nil, animated: true)
        navigationItem.setLeftBarButtonItems(nil, animated: true)
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBarContainer.searchBar.alpha = 1
        }, completion: { finished in
            self.searchBarContainer.searchBar.becomeFirstResponder()
        })
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.titleView = nil
        }, completion: { finished in
            
        })
        self.navigationItem.setRightBarButtonItems([btnExport,btnSearch, UIBarButtonItem.init(customView: switchDetail)], animated: true)
        search(key: "")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        search(key: "\(searchBar.text!)")
        self.navigationItem.setRightBarButtonItems([btnExport,btnSearch, UIBarButtonItem.init(customView: switchDetail)], animated: true)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.titleView = nil
        }, completion: { finished in
            
        })
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(key: searchText)
    }
    //////////////////////////////////////////////
    func search(key:String){
        
        var list:[KhaiThacKMCRM] = []
        
        switch self.comboPKType {
        case "ReportKhaiThacKMCRMVung":
            list.removeAll()
            if(key.count > 0) {
                for item in listKhaiThacKMCRM {
                    if ((item.Vung.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateDetailKhaiThacKH_CRM_CTKM_Vung(list)
                self.reportCollectionView.reloadData()
                
            } else {
                self.generateDetailKhaiThacKH_CRM_CTKM_Vung(listKhaiThacKMCRM)
                self.reportCollectionView.reloadData()
            }
            break
        case "ReportKhaiThacKMCRMKhuvuc":
            list.removeAll()
            if(key.count > 0) {
                for item in listKhaiThacKMCRM {
                    if ((item.KhuVuc.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateDetailKhaiThacKH_CRM_CTKM_KhuVuc(list)
                self.reportCollectionView.reloadData()
            } else {
                self.generateDetailKhaiThacKH_CRM_CTKM_KhuVuc(listKhaiThacKMCRM)
                self.reportCollectionView.reloadData()
            }
            break
        case "ReportKhaiThacKMCRMShop":
            list.removeAll()
            if(key.count > 0) {
                for item in listKhaiThacKMCRM {
                    if ((item.TenShop.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateDetailKhaiThacKH_CRM_CTKM_Shop(list)
                self.reportCollectionView.reloadData()
            } else {
                self.generateDetailKhaiThacKH_CRM_CTKM_Shop(listKhaiThacKMCRM)
                self.reportCollectionView.reloadData()
            }
            break
            
        default:
            break
        }
        
        
    }
    
    ////-------GET DATA-----------------------
    
    func getKhaiThacKH_CRM_CTKM_Vung(username: String, token: String) {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            let data = mSMApiManager.KhaiThacKH_CRM_CTKM_Vung(username: username, token: token).Data
            if data != nil {
                self.listKhaiThacKMCRM = data ?? []
                if self.listKhaiThacKMCRM.count > 0 {
                    if self.switchDetail.isOn{
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.generateDetailKhaiThacKH_CRM_CTKM_Vung(self.listKhaiThacKMCRM)
                            self.reportCollectionView.removeFromSuperview()
                            
                        }
                    } else {
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.generateKhaiThacKH_CRM_CTKM_Vung(self.listKhaiThacKMCRM)
                            self.reportCollectionView.removeFromSuperview()
                            
                        }
                    }
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.SetUpCollectionView()
                    self.switchDetail.isEnabled = true
                }
            } else {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    debugPrint("Không lấy được data!")
                    self.SetUpCollectionView()
                    self.switchDetail.isEnabled = true
                }
            }
        }
    }
    
    func getKhaiThacKH_CRM_CTKM_KhuVuc(username: String, token: String) {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            let data = mSMApiManager.KhaiThacKH_CRM_CTKM_KhuVuc(username: username, token: token).Data
            if data != nil {
                self.listKhaiThacKMCRM = data ?? []
                if self.listKhaiThacKMCRM.count > 0 {
                    if self.switchDetail.isOn{
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.generateDetailKhaiThacKH_CRM_CTKM_KhuVuc(self.listKhaiThacKMCRM)
                            self.reportCollectionView.removeFromSuperview()
                            
                        }
                    } else {
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.generateKhaiThacKH_CRM_CTKM_KhuVuc(self.listKhaiThacKMCRM)
                            self.reportCollectionView.removeFromSuperview()
                            
                        }
                    }
                }
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.SetUpCollectionView()
                    self.switchDetail.isEnabled = true
                }
            } else {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    debugPrint("Không lấy được data!")
                    self.SetUpCollectionView()
                    self.switchDetail.isEnabled = true
                }
            }
        }
    }
    
    func getKhaiThacKH_CRM_CTKM_Shop(username: String, token: String) {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            let data = mSMApiManager.KhaiThacKH_CRM_CTKM_Shop(username: username, token: token).Data
            if data != nil {
                self.listKhaiThacKMCRM = data ?? []
                if self.listKhaiThacKMCRM.count > 0 {
                    if self.switchDetail.isOn{
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.generateDetailKhaiThacKH_CRM_CTKM_Shop(self.listKhaiThacKMCRM)
                            self.reportCollectionView.removeFromSuperview()
                            
                        }
                    } else {
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.generateKhaiThacKH_CRM_CTKM_Shop(self.listKhaiThacKMCRM)
                            self.reportCollectionView.removeFromSuperview()
                            
                        }
                    }
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.SetUpCollectionView()
                    self.switchDetail.isEnabled = true
                }
            } else {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    debugPrint("Không lấy được data!")
                    self.SetUpCollectionView()
                    self.switchDetail.isEnabled = true
                }
            }
        }
    }
    
    
    ///--GENERATE DATA-----------------------
    //VUNG
    func generateKhaiThacKH_CRM_CTKM_Vung(_ data:[KhaiThacKMCRM]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.Vung)",
                "\(Common.convertCurrencyV2(value: item.SoLuong))",
                "\(Common.convertCurrencyV2(value: item.DoanhSo))",
                "\(Common.convertCurrencyV2(value: item.LaiGop))",
                "\(Common.convertCurrencyDoubleV2(value: item.PTLaiGop))",
                "\(Common.convertCurrencyV2(value: item.SLDonHang))",
                "\(Common.convertCurrencyV2(value: item.SLThuHo))",
                "\(Common.convertCurrencyDoubleV2(value: item.PT_KhaiThac))"
                ]);
        }
    }
    
    //KHU VUC
    func generateKhaiThacKH_CRM_CTKM_KhuVuc(_ data:[KhaiThacKMCRM]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.KhuVuc)",
                "\(Common.convertCurrencyV2(value: item.SoLuong))",
                "\(Common.convertCurrencyV2(value: item.DoanhSo))",
                "\(Common.convertCurrencyV2(value: item.LaiGop))",
                "\(Common.convertCurrencyDoubleV2(value: item.PTLaiGop))",
                "\(Common.convertCurrencyV2(value: item.SLDonHang))",
                "\(Common.convertCurrencyV2(value: item.SLThuHo))",
                "\(Common.convertCurrencyDoubleV2(value: item.PT_KhaiThac))"
                ]);
        }
    }
    
    //SHOP
    func generateKhaiThacKH_CRM_CTKM_Shop(_ data:[KhaiThacKMCRM]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.TenShop)",
                "\(Common.convertCurrencyV2(value: item.SoLuong))",
                "\(Common.convertCurrencyV2(value: item.DoanhSo))",
                "\(Common.convertCurrencyV2(value: item.LaiGop))",
                "\(Common.convertCurrencyDoubleV2(value: item.PTLaiGop))",
                "\(Common.convertCurrencyV2(value: item.SLDonHang))",
                "\(Common.convertCurrencyV2(value: item.SLThuHo))",
                "\(Common.convertCurrencyDoubleV2(value: item.PT_KhaiThac))"
                ]);
        }
    }
    
    ///--GENERATE DETAIL DATA-----------------------
    //VUNG
    func generateDetailKhaiThacKH_CRM_CTKM_Vung(_ data:[KhaiThacKMCRM]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.Vung)",
                "\(Common.convertCurrencyV2(value: item.SoLuong))",
                "\(Common.convertCurrencyV2(value: item.DoanhSo))",
                "\(Common.convertCurrencyV2(value: item.LaiGop))",
                "\(Common.convertCurrencyDoubleV2(value: item.PTLaiGop))",
                "\(Common.convertCurrencyV2(value: item.SLDonHang))",
                "\(Common.convertCurrencyV2(value: item.SLThuHo))",
                "\(Common.convertCurrencyDoubleV2(value: item.PT_KhaiThac))",
                "\(Common.convertCurrencyV2(value: item.SoLuongSim))",
                "\(Common.convertCurrencyV2(value: item.SoLuongPK))",
                "\(Common.convertCurrencyV2(value: item.LaiGopSim))",
                "\(Common.convertCurrencyV2(value: item.LaiGopPK))",
                "\(Common.convertCurrencyDoubleV2(value: item.PTKhaiThacSIM))",
                "\(Common.convertCurrencyDoubleV2(value: item.PTKhaiThacPK))"
                ]);
        }
    }
    
    //KHU VUC
    func generateDetailKhaiThacKH_CRM_CTKM_KhuVuc(_ data:[KhaiThacKMCRM]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.KhuVuc)",
                "\(Common.convertCurrencyV2(value: item.SoLuong))",
                "\(Common.convertCurrencyV2(value: item.DoanhSo))",
                "\(Common.convertCurrencyV2(value: item.LaiGop))",
                "\(Common.convertCurrencyDoubleV2(value: item.PTLaiGop))",
                "\(Common.convertCurrencyV2(value: item.SLDonHang))",
                "\(Common.convertCurrencyV2(value: item.SLThuHo))",
                "\(Common.convertCurrencyDoubleV2(value: item.PT_KhaiThac))",
                "\(Common.convertCurrencyV2(value: item.SoLuongSim))",
                "\(Common.convertCurrencyV2(value: item.SoLuongPK))",
                "\(Common.convertCurrencyV2(value: item.LaiGopSim))",
                "\(Common.convertCurrencyV2(value: item.LaiGopPK))",
                "\(Common.convertCurrencyDoubleV2(value: item.PTKhaiThacSIM))",
                "\(Common.convertCurrencyDoubleV2(value: item.PTKhaiThacPK))"
                ]);
        }
    }
    
    //SHOP
    func generateDetailKhaiThacKH_CRM_CTKM_Shop(_ data:[KhaiThacKMCRM]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.TenShop)",
                "\(Common.convertCurrencyV2(value: item.SoLuong))",
                "\(Common.convertCurrencyV2(value: item.DoanhSo))",
                "\(Common.convertCurrencyV2(value: item.LaiGop))",
                "\(Common.convertCurrencyDoubleV2(value: item.PTLaiGop))",
                "\(Common.convertCurrencyV2(value: item.SLDonHang))",
                "\(Common.convertCurrencyV2(value: item.SLThuHo))",
                "\(Common.convertCurrencyDoubleV2(value: item.PT_KhaiThac))",
                "\(Common.convertCurrencyV2(value: item.SoLuongSim))",
                "\(Common.convertCurrencyV2(value: item.SoLuongPK))",
                "\(Common.convertCurrencyV2(value: item.LaiGopSim))",
                "\(Common.convertCurrencyV2(value: item.LaiGopPK))",
                "\(Common.convertCurrencyDoubleV2(value: item.PTKhaiThacSIM))",
                "\(Common.convertCurrencyDoubleV2(value: item.PTKhaiThacPK))"
                ]);
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Swift.Error?) {
        print("Mail Compose controller didFinished");
        controller.dismiss(animated: true, completion: nil);
    }
    
    ///export file
    @objc func ExportFile() {
        mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        switch self.comboPKType {
        case "ReportKhaiThacKMCRMVung":
            self.exportKhaiThacKH_CRM_CTKM_Vung()
            break
            
        case "ReportKhaiThacKMCRMKhuvuc" :
            self.exportKhaiThacKH_CRM_CTKM_KhuVuc()
            break
            
        case "ReportKhaiThacKMCRMShop" :
            self.exportKhaiThacKH_CRM_CTKM_Shop()
            break
        default:
            break
        }
    }
    
    func writeFile(path: String, content: String, reportName: String) {
        do {
            if #available(iOS 15.2, *) {
                let filName = "\(reportName).csv"
                let newPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(filName)
                try content.write(to: newPath!, atomically: true, encoding: .utf16)
                let exportSheet = UIActivityViewController(activityItems: [newPath!] as [Any], applicationActivities: nil)
                self.present(exportSheet, animated: true, completion: nil)
            } else {
                try content.write(toFile: path, atomically: false, encoding: String.Encoding.utf16)
                print("Nơi lưu file: \(path)")
                
                //Check to see the device can send email.
                let alertVC = UIAlertController(title: "Xuất báo cáo thành công!", message: "Nơi lưu file: \n" + path, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (_) in
                    //Check to see the device can send email.
                    if( MFMailComposeViewController.canSendMail() ) {
                        print("Can send email.")
                        //Set the subject and message of the email
                        let currentDate = Date()
                        let formater = DateFormatter()
                        formater.dateFormat = "dd-MM-yyyy_HH:mm"
                        let currentDateString = formater.string(from: currentDate)
                        
                        self.mailComposer.setSubject("mSM - Xuat bao cao \(reportName) \(currentDateString)")
                        self.mailComposer.setMessageBody("\(reportName) xuat tu ung dung mSM ngay \(currentDateString)", isHTML: false)
                        
                        if let fileData = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                            print("File data loaded.")
                            self.mailComposer.addAttachmentData(fileData, mimeType: "text/csv", fileName: "\(reportName) \(currentDateString).csv")
                        } else {
                            let alertVC = UIAlertController(title: "Thông báo", message: "Không thể nạp nội dung file báo cáo!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alertVC.addAction(action)
                            self.present(alertVC, animated: true, completion: nil)
                        }
                        self.present(self.mailComposer, animated: true, completion: nil)
                    } else {
                        let alertVC = UIAlertController(title: "Thông báo", message: "Vui lòng đăng nhập vào app Mail trên máy để xuất báo cáo qua mail!", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                }
                alertVC.addAction(action)
                self.present(alertVC, animated: true, completion: nil)
            }
        } catch let error as NSError{
            let alertVC = UIAlertController(title: "Xuất báo cáo không thành công!", message: error.localizedDescription, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            
            print("Failed to create file")
            print("\(error)")
        }

    }
    
    //Vung
    func exportKhaiThacKH_CRM_CTKM_Vung() {
        let path = NSTemporaryDirectory() + "ReportKhaiThacKH_CRM_CTKMVung.csv"
        
        //generate contents of file
        let data = self.listKhaiThacKMCRM
        let header = ["Vùng", "Số lượng", "Doanh số", "Lãi gộp", "% Lãi gộp", "SL Đơn Hàng", "SL Thu Hộ", "% Khai thác", "SL Sim", "SL PK", "Lãi gộp Sim", "Lãi gộp PK", "% Khai thác Sim", "% Khai thác PK"]
        
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.Vung)\t \(item.SoLuong)\t \(item.DoanhSo)\t \(item.LaiGop)\t \(item.PTLaiGop)\t \(item.SLDonHang)\t \(item.SLThuHo)\t \(item.PT_KhaiThac)\t \(item.SoLuongSim)\t \(item.SoLuongPK)\t \(item.LaiGopSim)\t \(item.LaiGopPK)\t \(item.PTKhaiThacSIM)\t \(item.PTKhaiThacPK)"
        }
        self.writeFile(path: path, content: content, reportName: "ReportKhaiThacKH_CRM_CTKMVung")
    }
    
    //khu vuc
    func exportKhaiThacKH_CRM_CTKM_KhuVuc() {
        let path = NSTemporaryDirectory() + "ReportKhaiThacKH_CRM_CTKMKhuVuc.csv"
        
        //generate contents of file
        let data = self.listKhaiThacKMCRM
        let header = ["Khu vực", "Số lượng", "Doanh số", "Lãi gộp", "% Lãi gộp", "SL Đơn Hàng", "SL Thu Hộ", "% Khai thác", "SL Sim", "SL PK", "Lãi gộp Sim", "Lãi gộp PK", "% Khai thác Sim", "% Khai thác PK"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.KhuVuc)\t \(item.SoLuong)\t \(item.DoanhSo)\t \(item.LaiGop)\t \(item.PTLaiGop)\t \(item.SLDonHang)\t \(item.SLThuHo)\t \(item.PT_KhaiThac)\t \(item.SoLuongSim)\t \(item.SoLuongPK)\t \(item.LaiGopSim)\t \(item.LaiGopPK)\t \(item.PTKhaiThacSIM)\t \(item.PTKhaiThacPK)"
        }
        self.writeFile(path: path, content: content, reportName: "ReportKhaiThacKH_CRM_CTKMKhuVuc")
        
    }
    
    //Shop
    func exportKhaiThacKH_CRM_CTKM_Shop() {
        let path = NSTemporaryDirectory() + "ReportKhaiThacKH_CRM_CTKMShop.csv"
        
        //generate contents of file
        let data = self.listKhaiThacKMCRM
        let header = ["Shop", "Số lượng", "Doanh số", "Lãi gộp", "% Lãi gộp", "SL Đơn Hàng", "SL Thu Hộ", "% Khai thác", "SL Sim", "SL PK", "Lãi gộp Sim", "Lãi gộp PK", "% Khai thác Sim", "% Khai thác PK"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.TenShop)\t \(item.SoLuong)\t \(item.DoanhSo)\t \(item.LaiGop)\t \(item.PTLaiGop)\t \(item.SLDonHang)\t \(item.SLThuHo)\t \(item.PT_KhaiThac)\t \(item.SoLuongSim)\t \(item.SoLuongPK)\t \(item.LaiGopSim)\t \(item.LaiGopPK)\t \(item.PTKhaiThacSIM)\t \(item.PTKhaiThacPK)"
        }
        self.writeFile(path: path, content: content, reportName: "ReportKhaiThacKH_CRM_CTKMShop")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
            case .portrait:
                self.view.subviews.forEach({ $0.removeFromSuperview() });
                self.SetUpCollectionView();
            case .landscapeLeft,.landscapeRight :
                self.view.subviews.forEach({ $0.removeFromSuperview() });
                self.SetUpCollectionView();
            default:
                print("Upside down, and that is not supported");
            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in})
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    ///-------setUpCollectionView-------
    func SetUpCollectionView(){
        self.navigationController?.navigationBar.isTranslucent = true;
        
        self.tempHeaderForSize = self.header;
        
        //Setup cell size
        for i in 0..<cellData.count{
            for j in 0..<tempHeaderForSize.count{
                if("\(self.tempHeaderForSize[j])".count < "\(cellData[i][j])".count){
                    self.tempHeaderForSize[j] = "\(cellData[i][j])";
                }
            }
        }
        
        let collectionViewLayout = ReportLayout();
        collectionViewLayout.numberOfColumns = header.count;
        collectionViewLayout.titleArray = self.tempHeaderForSize;
        collectionViewLayout.numberColumnFixed = 2
        
        self.reportCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height)), collectionViewLayout: collectionViewLayout);
        
        self.reportCollectionView.delegate = self;
        self.reportCollectionView.dataSource = self;
        self.reportCollectionView.showsHorizontalScrollIndicator = true;
        self.reportCollectionView.backgroundColor = UIColor.white;
        
        self.view.bringSubviewToFront(reportCollectionView);
        self.reportCollectionView.register(ReportDataCollectionViewCell.self, forCellWithReuseIdentifier: "cell");
        
        
        self.reportCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(self.reportCollectionView)
        
        if(cellData.count == 0){
            let emptyView = Bundle.main.loadNibNamed("EmptyDataView", owner: nil, options: nil)![0] as! UIView;
            emptyView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height);
            self.view.addSubview(emptyView);
        }
        self.navigationController?.navigationBar.isTranslucent = false;
        
    }

}


extension DetailKhaiThacKMCRMViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cellData.count + 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return header.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ReportDataCollectionViewCell;
        
        if indexPath.section % 2 == 0 {
            cell.backgroundColor = UIColor(white: 235/255.0, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        if(header.count > 0 || cellData.count > 0 ){
            if(indexPath.section == 0){
                cell.setupHeader(item: header[indexPath.row]);
                cell.backgroundColor = UIColor.lightGray;
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = UIColor.darkGray.cgColor;
            }else{
                if indexPath.row == 0 {
                    cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                } else {
                    cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                }
                
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = UIColor.darkGray.cgColor;
            }
        }
        return cell;
    }
}
