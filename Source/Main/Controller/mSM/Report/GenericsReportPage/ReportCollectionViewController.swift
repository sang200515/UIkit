//
//  CollectionViewController.swift
//  mSM
//
//  Created by Trần Thành Phương Đăng on 6/13/18.
//  Copyright © 2018 FPT. All rights reserved.
//

import UIKit;
import MessageUI
import DropDown
import Toaster

class ReportCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MFMailComposeViewControllerDelegate, UISearchBarDelegate{
    
    var reportCollectionView: UICollectionView!;
    var type: Int = 0;
    
    var header: [String] = [];
    var cellData: [[String]] = [];
    var tempHeaderForSize: [String] = [];
    var reportSection: ReportCase!;
    var reportId: String = "";
    public var navigationTitle: String = "";
    var mailComposer = MFMailComposeViewController();
    var isDetailsOn: Bool = false;
    var btnSearch: UIBarButtonItem!
    var exportButton: UIBarButtonItem!
    var detailsButton: UISwitch!
    var searchBarContainer:SearchBarContainerView!
    var listComboPkRealtime: [ComboPKRealtime] = []
    var comboPKType = ""
    let username = (Cache.user?.UserName)!;
    let token = (Cache.user?.Token)!

    var listCallogPending = [CallogPending]()
    var listTLCurrentMonth = [TLCurrentMonth]()
    var listTLPerMonth = [TLPerMonth]()
    var vendorCode:Int = 0
    var listDoanhNghiep = [DoanhNghiep]()
    var lblChooseVendor: UILabel!
    let dropMenuVendor = DropDown();
    var listDoanhNghiepName = [String]()
    var isHasVendorView:Bool = false
    var listDSShopRealtime:[ShopSales] = []
    var isBCKhaiThacCombo = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent;
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .allButUpsideDown;
    }
    override var shouldAutorotate: Bool{
        return true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.navigationItem.title = reportSection.caseName;
        mailComposer.mailComposeDelegate = self;
        self.view.backgroundColor = .white
        
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
        
        
        if self.reportSection.caseName == ReportCase.GetComboPKRealtime.caseName {
            switch self.comboPKType {
            case "ComboPKRealtimeVung":
                self.title = "BC CB PK Realtime Vùng"
                self.getComboPKRealtimeVung(username: self.username, token: self.token)
                
                break
            case "ComboPKRealtimeKhuVuc":
                self.title = "BC CB PK Realtime Khu vực"
                self.getComboPKRealtimeKhuVuc(username: self.username, token: self.token)
                break
            case "ComboPKRealtimeShop":
                self.title = "BC CB PK Realtime Shop"
                self.getComboPKRealtimeShop(username: self.username, token: self.token)
                break
            default:
                break
            }
        } else if self.reportSection.caseName == ReportCase.GetFFiends.caseName {
            switch self.comboPKType {
            case "FFriendCallogPending":
                self.title = "BC Callog Pending"
                self.getListCallogPending(username: self.username)
                
                break
            case "FFriendTLDuyetTrongThang":
                self.title = "BC Tỷ lệ duyệt trong tháng"
                self.getTyLeDuyetTrongThang(username: self.username)
                break
            case "FFriendTLDuyetTheoTungThang":
                self.title = "BC Tỷ lệ duyệt theo từng tháng"
                self.getTyLeDuyetTheoTungThang(username: self.username, vendorCode: self.vendorCode)
                break
            default:
                break
            }
        } else {
             self.SetupCollectionView()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        switch reportSection.unsafelyUnwrapped {
        case
             .GetAreaSalesRealtime,
             .GetShopSalesByArea,
             .GetShopSalesByShop,
             .GetShopSalesByZone,
             .GetSalemanReport,
             .GetG38ShopSalesMTD:
            let exportButton = UIBarButtonItem(image: UIImage(named: "ic_export"), style: .plain, target: self, action: #selector(self.ExportReport));
            let synchronizeButton = UIBarButtonItem(image: UIImage(named: "ic_sync"), style: .plain, target: self, action: #selector(self.ReloadData));
            detailsButton = UISwitch(frame: CGRect(x: 0, y: 0, width: 51, height: 31));
            
            detailsButton.isOn = false;
            detailsButton.setOn(false, animated: true)
            detailsButton.addTarget(self, action: #selector(self.ShowDetailsReport(sender:)), for: .valueChanged)
            
            self.navigationItem.rightBarButtonItems = [synchronizeButton, exportButton, UIBarButtonItem.init(customView: detailsButton)];
            self.ReloadData()
            
        case .GetShopSalesRealtime:
            
            self.listDSShopRealtime = mSMApiManager.GetShopSalesRealtime(username: username, token: token).Data ?? []
            
            detailsButton = UISwitch(frame: CGRect(x: 0, y: 0, width: 51, height: 31));
            exportButton = UIBarButtonItem(image: UIImage(named: "ic_export"), style: .plain, target: self, action: #selector(self.ExportReport));
            btnSearch = UIBarButtonItem(image: #imageLiteral(resourceName: "Search"), style: .plain, target: self, action: #selector(self.actionSearchAssets))
            
            detailsButton.isOn = false;
            detailsButton.setOn(false, animated: true)
            detailsButton.addTarget(self, action: #selector(self.ShowDetailsReport(sender:)), for: .valueChanged)
            
            self.navigationItem.rightBarButtonItems = [exportButton, btnSearch, UIBarButtonItem.init(customView: detailsButton)];
            self.ReloadData()
            
        case .GetComboPKRealtime:

            exportButton = UIBarButtonItem(image: UIImage(named: "ic_export"), style: .plain, target: self, action: #selector(self.ExportReport));
            btnSearch = UIBarButtonItem(image: #imageLiteral(resourceName: "Search"), style: .plain, target: self, action: #selector(self.actionSearchAssets))
            self.navigationItem.rightBarButtonItems = [exportButton, btnSearch]
            switch self.comboPKType {
            case "ComboPKRealtimeVung":
                self.title = "BC CB PK Realtime Vùng"
                self.getComboPKRealtimeVung(username: self.username, token: self.token)
                break
            case "ComboPKRealtimeKhuVuc":
                self.title = "BC CB PK Realtime Khu vực"
                self.getComboPKRealtimeKhuVuc(username: self.username, token: self.token)
                break
            case "ComboPKRealtimeShop":
                self.title = "BC CB PK Realtime Shop"
                self.getComboPKRealtimeShop(username: self.username, token: self.token)
                break
            default:
                break
            }
            
        case .GetFFiends:
            exportButton = UIBarButtonItem(image: UIImage(named: "ic_export"), style: .plain, target: self, action: #selector(self.ExportReport));
            self.navigationItem.rightBarButtonItem = exportButton
            
            switch self.comboPKType {
            case "FFriendCallogPending":
                self.title = "BC Callog Pending"
                self.getListCallogPending(username: self.username)
                break
            case "FFriendTLDuyetTrongThang":
                self.title = "BC Tỷ lệ duyệt trong tháng"
                self.getTyLeDuyetTrongThang(username: self.username)
                break
            case "FFriendTLDuyetTheoTungThang":
                self.title = "BC Tỷ lệ duyệt theo từng tháng"
                self.getTyLeDuyetTheoTungThang(username: self.username, vendorCode: self.vendorCode)
                break
            default:
                break
            }
        default:
            exportButton = UIBarButtonItem(image: UIImage(named: "ic_export"), style: .plain, target: self, action: #selector(self.ExportReport));
            let synchronizeButton = UIBarButtonItem(image: UIImage(named: "ic_sync"), style: .plain, target: self, action: #selector(self.ReloadData));
            
            self.navigationItem.rightBarButtonItems = [synchronizeButton, exportButton]
            self.ReloadData()
            break;
        }
    }
    
    func createVendorView() {
        
        let lblVendor = UILabel(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 20), height: Common.Size(s: 25)))
        lblVendor.text = "Chọn doanh nghiệp:"
        lblVendor.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(lblVendor)
        
        lblChooseVendor = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lblVendor.frame.origin.y + lblVendor.frame.height + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 20), height: Common.Size(s: 35)))
        lblChooseVendor.text = "Chọn doanh nghiệp"
        lblChooseVendor.textAlignment = .center
        lblChooseVendor.layer.cornerRadius = 3
        lblChooseVendor.layer.borderColor = UIColor.gray.cgColor
        lblChooseVendor.layer.borderWidth = 1
        lblChooseVendor.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(lblChooseVendor)
        
        let tapShowVendor = UITapGestureRecognizer(target: self, action: #selector(showListVendor))
        lblChooseVendor.isUserInteractionEnabled = true
        lblChooseVendor.addGestureRecognizer(tapShowVendor)
    }
    
    @objc func showListVendor() {
        if listDoanhNghiep.count > 0 {
            for ven in listDoanhNghiep {
                self.listDoanhNghiepName.append(ven.TenDN ?? "")
            }
            self.dropMenuVendor.dataSource = listDoanhNghiepName
            self.dropMenuVendor.show()
        } else {
            Toast.init(text: "Không có doanh nghiệp").show()
        }
        
        setupDropMenus()
    }
    
    func setupDropMenus() {
        DropDown.setupDefaultAppearance();
        
        dropMenuVendor.dismissMode = .onTap
        dropMenuVendor.direction = .any
        
        dropMenuVendor.anchorView = lblChooseVendor;
        DropDown.startListeningToKeyboard();
        
        //Setup datasources
        dropMenuVendor.dataSource = self.listDoanhNghiepName;
        dropMenuVendor.selectRow(0);
        
        
        dropMenuVendor.selectionAction = { [weak self] (index, item) in
            self?.listDoanhNghiep.forEach{
                if($0.TenDN == item){
                    self?.vendorCode = $0.MaDN ?? 0;
                }
            }
            
            self?.lblChooseVendor.text = item
            self?.lblChooseVendor.frame = CGRect(x: self!.lblChooseVendor.frame.origin.x, y: self!.lblChooseVendor.frame.origin.y, width: self!.lblChooseVendor.frame.width, height: self!.lblChooseVendor.optimalHeight)
            
            self?.lblChooseVendor.numberOfLines = 0
            //update collectionview frame
            
            self?.reportCollectionView.frame = CGRect(x: 0, y: self!.lblChooseVendor.frame.origin.y  + self!.lblChooseVendor.optimalHeight + Common.Size(s: 25), width: self!.view.frame.size.width, height: self!.view.frame.size.height - (self!.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height))
            
            self!.getTyLeDuyetTheoTungThang(username: (self?.username)!, vendorCode: (self?.vendorCode)!)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                self?.reportCollectionView.reloadData()

            })
        }
    }
    
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
        
        switch reportSection.unsafelyUnwrapped {
        case .GetShopSalesRealtime:
            self.navigationItem.rightBarButtonItems = [exportButton, btnSearch, UIBarButtonItem.init(customView: detailsButton)];
            break
        default:
            self.navigationItem.setRightBarButtonItems([exportButton,btnSearch], animated: true)
            break
        }
        
        search(key: "")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        search(key: "\(searchBar.text!)")
        self.navigationItem.setRightBarButtonItems([exportButton,btnSearch], animated: true)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.titleView = nil
        }, completion: { finished in
            
        })
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(key: searchText)
    }
    func search(key:String){
        
        switch reportSection.unsafelyUnwrapped {
        case .GetShopSalesRealtime:
            var list:[ShopSales] = []
            list.removeAll()
            if self.isDetailsOn {
                if(key.count > 0) {
                    for item in listDSShopRealtime {
                        if ((item.KhuVuc!.lowercased().range(of: key.lowercased())) != nil) || ((item.TenShop!.lowercased().range(of: key.lowercased())) != nil) {
                            list.append(item)
                        }
                    }
                    self.generateDetailDSShopRealtime(list)
                    self.reportCollectionView.reloadData()
                    
                } else {
                    self.generateDetailDSShopRealtime(listDSShopRealtime)
                    self.reportCollectionView.reloadData()
                }
            } else {
                if(key.count > 0) {
                    for item in listDSShopRealtime {
                        if ((item.KhuVuc!.lowercased().range(of: key.lowercased())) != nil) || ((item.TenShop!.lowercased().range(of: key.lowercased())) != nil) {
                            list.append(item)
                        }
                    }
                    self.generateDSShopRealtime(list)
                    self.reportCollectionView.reloadData()
                    
                } else {
                    self.generateDSShopRealtime(listDSShopRealtime)
                    self.reportCollectionView.reloadData()
                }
            }
            
            break
        case .GetComboPKRealtime:
            self.searchBCComboPK(key: key)
        default:
            break
        }
    }
    
    func searchBCComboPK(key:String) {
        var list:[ComboPKRealtime] = []
        if self.comboPKType == "ComboPKRealtimeVung" {
            list.removeAll()
            if(key.count > 0) {
                for item in listComboPkRealtime {
                    if ((item.Vung!.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateComboPKRealtimeVung(list)
                self.reportCollectionView.reloadData()
                
            } else {
                self.generateComboPKRealtimeVung(listComboPkRealtime)
                self.reportCollectionView.reloadData()
            }
            
            
        } else if self.comboPKType == "ComboPKRealtimeKhuVuc" {
            list.removeAll()
            if(key.count > 0) {
                for item in listComboPkRealtime {
                    if ((item.TenASM!.lowercased().range(of: key.lowercased())) != nil || (item.TenKhuVuc!.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateComboPKRealtimeKhuVuc(list)
                self.reportCollectionView.reloadData()
            } else {
                self.generateComboPKRealtimeKhuVuc(listComboPkRealtime)
                self.reportCollectionView.reloadData()
            }
            
        }
        else if self.comboPKType == "ComboPKRealtimeShop" {
            list.removeAll()
            if(key.count > 0) {
                for item in listComboPkRealtime {
                    if ((item.MaShop!.lowercased().range(of: key.lowercased())) != nil || (item.TenShop!.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateComboPKRealtimeShop(list)
                self.reportCollectionView.reloadData()
            } else {
                self.generateComboPKRealtimeShop(listComboPkRealtime)
                self.reportCollectionView.reloadData()
            }
            
        }
    }
    
    func generateDSShopRealtime(_ data:[ShopSales]) {
        cellData = [[String]]()
        for report in data {
            self.cellData.append([
                "\(report.STT!)",
                "\(report.TenShop!)",
                "\(Common.convertCurrencyDouble(value: report.DSPK!))",
                "\(report.PT!)",
                "\(Common.convertCurrencyDouble(value: report.Tong!))",
                ]);
        }
    }
    
    func generateDetailDSShopRealtime(_ data:[ShopSales]) {
        cellData = [[String]]()
        for report in data {
            self.cellData.append([
                "\(report.STT!)",
                "\(report.KhuVuc!)",
                "\(report.TenShop!)",
                "\(Common.convertCurrencyDouble(value: report.DoanhSoNgay!))",
                "\(Common.convertCurrencyDouble(value: report.DS_ECOM!))",
                "\(Common.convertCurrencyDouble(value: report.DSPK!))",
                "\(Common.convertCurrencyDouble(value: report.DSPKThuong!))",
                "\(Common.convertCurrencyDouble(value: report.DSPKNK!))",
                "\(report.PT!)",
                "\(Common.convertCurrencyDouble(value: report.Tong!))",
                ]);
        }
    }
    
    /////----ComboPKRealtime-------
    func getComboPKRealtimeVung(username: String, token: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.listComboPkRealtime = mSMApiManager.GetComboPKRealtimeVung(username: username, token: token).Data ?? []
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                self.header = ["STT","Vùng", "SL Combo10", "DS Combo10","SL Combo15", "DS Combo15","SL Combo20", "DS Combo20","Tổng SL Combo", "SL Máy","Tỉ trọng", "TB Bill Combo", "SL CB SDP + KCL", "Tỉ lệ SDP + KCL", "SL CB KCL + SDP + Cáp", "Tỉ lệ KCL + SDP + Cáp", "Total Combo", "Total Tỉ lệ"];
                if self.listComboPkRealtime.count > 0 {
                    self.generateComboPKRealtimeVung(self.listComboPkRealtime)
                } else {
                    self.cellData = [[String]]()
                    debugPrint("Không lấy được data!")
                }
                self.view.subviews.forEach({$0.removeFromSuperview()})
                self.SetupCollectionView()
            }
        }
    }
    
    func getComboPKRealtimeKhuVuc(username: String, token: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.listComboPkRealtime = mSMApiManager.GetComboPKRealtimeASM(username: username, token: token).Data ?? []
            
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                self.header =  ["STT", "Khu vực","ASM", "SL Combo10", "DS Combo10","SL Combo15", "DS Combo15","SL Combo20", "DS Combo20","Tổng SL Combo", "SL Máy","Tỉ trọng", "TB Bill Combo", "SL CB SDP + KCL", "Tỉ lệ SDP + KCL", "SL CB KCL + SDP + Cáp", "Tỉ lệ KCL + SDP + Cáp", "Total Combo", "Total Tỉ lệ"];
                
                if self.listComboPkRealtime.count > 0 {
                    self.generateComboPKRealtimeKhuVuc(self.listComboPkRealtime)
                } else {
                    self.cellData = [[String]]()
                    debugPrint("Không lấy được data!")
                }
                self.view.subviews.forEach({$0.removeFromSuperview()})
                self.SetupCollectionView()
            }
        }
        
    }
    
    func getComboPKRealtimeShop(username: String, token: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.listComboPkRealtime = mSMApiManager.GetComboPKRealtimeShop(username: username, token: token).Data ?? []
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                self.header = ["STT","Mã Shop", "Tên Shop", "SL Combo10", "DS Combo10","SL Combo15", "DS Combo15","SL Combo20", "DS Combo20","Tổng SL Combo", "SL Máy","Tỉ trọng", "TB Bill Combo", "SL CB SDP + KCL", "Tỉ lệ SDP + KCL", "SL CB KCL + SDP + Cáp", "Tỉ lệ KCL + SDP + Cáp", "Total Combo", "Total Tỉ lệ"];
                if self.listComboPkRealtime.count > 0 {
                    self.generateComboPKRealtimeShop(self.listComboPkRealtime)
                } else {
                    self.cellData = [[String]]()
                    debugPrint("Không lấy được data!")
                }
                self.view.subviews.forEach({$0.removeFromSuperview()})
                self.SetupCollectionView()
            }
        }
    }
    
    ///--GENERATE DATA-----------------------
    func generateComboPKRealtimeVung(_ data:[ComboPKRealtime]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.STT!)",
                "\(item.Vung!)",
                "\(Common.convertCurrencyInteger(value: item.SL_Combo10!))",
                "\(item.DSCombo10!)",
                "\(Common.convertCurrencyInteger(value: item.SL_Combo15!))",
                "\(item.DSCombo15!)",
                "\(Common.convertCurrencyInteger(value: item.SL_Combo20!))",
                "\(item.DSCombo20!)",
                "\(Common.convertCurrencyInteger(value: item.TongSL_Combo!))",
                "\(Common.convertCurrencyInteger(value: item.SoLuongMay!))",
                "\(item.TyTrong!)",
                "\(item.TBBillCombo!)",
                "\(Common.convertCurrencyInteger(value: item.SLCBSDP_KCL!))",
                "\(item.TiLe_SDP_KCL!)",
                "\(Common.convertCurrencyInteger(value: item.SLCBKCL_SDP_Cap!))",
                "\(item.Tile_KCL_SDP_Cap!)",
                "\(Common.convertCurrencyInteger(value: item.ToTalCombo!))",
                "\(item.ToTal_TiLe!)"
            ]);
        }
    }
    func generateComboPKRealtimeKhuVuc(_ data:[ComboPKRealtime]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.STT!)",
                "\(item.TenKhuVuc!)",
                "\(item.TenASM!)",
                "\(Common.convertCurrencyInteger(value: item.SL_Combo10!))",
                "\(item.DSCombo10!)",
                "\(Common.convertCurrencyInteger(value: item.SL_Combo15!))",
                "\(item.DSCombo15!)",
                "\(Common.convertCurrencyInteger(value: item.SL_Combo20!))",
                "\(item.DSCombo20!)",
                "\(Common.convertCurrencyInteger(value: item.TongSL_Combo!))",
                "\(Common.convertCurrencyInteger(value: item.SoLuongMay!))",
                "\(item.TyTrong!)",
                "\(item.TBBillCombo!)",
                "\(Common.convertCurrencyInteger(value: item.SLCBSDP_KCL!))",
                "\(item.TiLe_SDP_KCL!)",
                "\(Common.convertCurrencyInteger(value: item.SLCBKCL_SDP_Cap!))",
                "\(item.Tile_KCL_SDP_Cap!)",
                "\(Common.convertCurrencyInteger(value: item.ToTalCombo!))",
                "\(item.ToTal_TiLe!)"
            ]);
            
        }
    }
    func generateComboPKRealtimeShop(_ data:[ComboPKRealtime]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.STT!)",
                "\(item.MaShop!)",
                "\(item.TenShop!)",
                "\(Common.convertCurrencyInteger(value: item.SL_Combo10!))",
                "\(item.DSCombo10!)",
                "\(Common.convertCurrencyInteger(value: item.SL_Combo15!))",
                "\(item.DSCombo15!)",
                "\(Common.convertCurrencyInteger(value: item.SL_Combo20!))",
                "\(item.DSCombo20!)",
                "\(Common.convertCurrencyInteger(value: item.TongSL_Combo!))",
                "\(Common.convertCurrencyInteger(value: item.SoLuongMay!))",
                "\(item.TyTrong!)",
                "\(item.TBBillCombo!)",
                "\(Common.convertCurrencyInteger(value: item.SLCBSDP_KCL!))",
                "\(item.TiLe_SDP_KCL!)",
                "\(Common.convertCurrencyInteger(value: item.SLCBKCL_SDP_Cap!))",
                "\(item.Tile_KCL_SDP_Cap!)",
                "\(Common.convertCurrencyInteger(value: item.ToTalCombo!))",
                "\(item.ToTal_TiLe!)"
            ]);
            
        }
    }
    

    //FFriends-----------
    func getListCallogPending(username: String) {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            let data = mSMApiManager.getListCallogPending(username: username).Data
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                self.header = ["Tên DN","SL CL Sắp trễ hạn", "SL CL Đã trễ hạn"]
                if data != nil {
                    data!.forEach{ item in
                        self.cellData.append([
                            "\(item.TenDN!)",
                            "\(item.SL_CLSapTreHan!)",
                            "\(item.SL_CLDaTreHan!)"
                            ]);
                    }
                    self.listCallogPending = data ?? []
                } else {
                    debugPrint("Không lấy được data!")
                }
                self.view.subviews.forEach({$0.removeFromSuperview()})
                self.SetupCollectionView()
            }
        }
    }
    
    func getTyLeDuyetTrongThang(username: String) {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            let data = mSMApiManager.getTLDuyetTrongThang(username: username).Data
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                self.header =  ["Doanh nghiệp", "Tổng CL phát sinh", "Tỉ lệ duyệt trễ hạn"]
                if data != nil {
                    data!.forEach{ item in
                        self.cellData.append([
                            "\(item.TenDN!)",
                            "\(item.TongCLPhatSinh!)",
                            "\(item.TiLeDuyetTreHan!)"
                            ]);
                    }
                    self.listTLCurrentMonth = data ?? []
                } else {
                    debugPrint("Không lấy được data!")
                }
                self.view.subviews.forEach({$0.removeFromSuperview()})
                self.SetupCollectionView()
            }
        }
    }
    
    func getTyLeDuyetTheoTungThang(username: String, vendorCode: Int) {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            let data = mSMApiManager.getTLDuyetTheoTungThang(username: username, vendorCode: vendorCode).Data
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                self.header =  ["Tháng/Năm", "Tỉ lệ duyệt trễ hạn(%)"]
                if data != nil {
                    data!.forEach{ item in
                        self.cellData.append([
                            "\(item.ThangNam!)",
                            "\(item.TiLeDuyetTreHan!)"
                            ]);
                    }
                    self.listTLPerMonth = data ?? []
                } else {
                    debugPrint("Không lấy được data!")
                }
                self.view.subviews.forEach({$0.removeFromSuperview()})
                self.SetupCollectionView()
            }
        }
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
            case .portrait:
                self.view.subviews.forEach({ $0.removeFromSuperview() });
                self.SetupCollectionView();
            case .landscapeLeft,.landscapeRight :
                self.view.subviews.forEach({ $0.removeFromSuperview() });
                self.SetupCollectionView();
            default:
                print("Upside down, and that is not supported");
            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in})
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    //Setting up view to portrait when view disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        if (self.isMovingFromParent) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
        self.view.subviews.forEach({$0.removeFromSuperview()});
    }
    
    @objc func canRotate() -> Void{}
    
    func SetupCollectionView(){
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
        
        if self.reportSection.caseName == ReportCase.GetFFiends.caseName {
            let collectionViewLayout = ReportLayout();
            
            if isHasVendorView {
                self.createVendorView()
                
                let viewVendorHeight = lblChooseVendor.optimalHeight < Common.Size(s: 35) ? Common.Size(s: 35) : lblChooseVendor.optimalHeight
                self.reportCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: lblChooseVendor.frame.origin.y  + viewVendorHeight + Common.Size(s: 25), width: self.view.frame.size.width, height: self.view.frame.size.height - (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height)), collectionViewLayout: collectionViewLayout);
            } else {
                self.reportCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height)), collectionViewLayout: collectionViewLayout);
            }
            
            collectionViewLayout.numberOfColumns = header.count;
            collectionViewLayout.titleArray = self.tempHeaderForSize;
            collectionViewLayout.numberColumnFixed = 0
            
        } else if self.reportSection.caseName == ReportCase.GetComboPKRealtime.caseName {
            let collectionViewLayout = ReportLayout();
            self.reportCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height)), collectionViewLayout: collectionViewLayout );
            
            collectionViewLayout.numberOfColumns = header.count;
            collectionViewLayout.titleArray = self.tempHeaderForSize;
            
            switch self.comboPKType {
            case "ComboPKRealtimeVung":
                collectionViewLayout.numberColumnFixed = 2
                break
            case "ComboPKRealtimeKhuVuc":
                collectionViewLayout.numberColumnFixed = 2
                break
            case "ComboPKRealtimeShop":
                collectionViewLayout.numberColumnFixed = 3
                break
            default:
                collectionViewLayout.numberColumnFixed = 0
                break
            }
            
        } else {
            let collectionViewLayout = ReportLayout();
            self.reportCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height)), collectionViewLayout: collectionViewLayout );
            
            collectionViewLayout.numberOfColumns = header.count;
            collectionViewLayout.titleArray = self.tempHeaderForSize;
            collectionViewLayout.numberColumnFixed = 2
        }
        
        self.reportCollectionView.delegate = self;
        self.reportCollectionView.dataSource = self;
        self.reportCollectionView.showsHorizontalScrollIndicator = true;
        self.reportCollectionView.backgroundColor = UIColor.white;
        self.reportCollectionView.register(ReportDataCollectionViewCell.self, forCellWithReuseIdentifier: "cell");
        
        self.view.addSubview(reportCollectionView);
        self.view.bringSubviewToFront(reportCollectionView);
        
        if(cellData.count == 0){
            let emptyView = Bundle.main.loadNibNamed("EmptyDataView", owner: nil, options: nil)![0] as! UIView;
            emptyView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height);
            self.view.addSubview(emptyView);
        }
        
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
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
        
        if(header.count > 0 && cellData.count > 0 ){
            if(indexPath.section == 0){
                cell.setupHeader(item: header[indexPath.row]);
                cell.backgroundColor = UIColor.lightGray;
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = UIColor.darkGray.cgColor;
            }else{
                if(indexPath.section == 1){
                    cell.setupNameLeft(item: header[indexPath.row])
                    cell.layer.borderWidth = 0.5;
                    cell.layer.borderColor = UIColor.darkGray.cgColor;
                }
                    
                switch reportSection.unsafelyUnwrapped{
                case .GetHealthReport:
                    if self.isBCKhaiThacCombo {
                        if (indexPath.row == 1) || (indexPath.row == 3) {
                            cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row]);
                        } else {
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                        }
                        cell.layer.borderWidth = 0.5;
                        cell.layer.borderColor = UIColor.darkGray.cgColor;
                    } else {
                        if(self.cellData[indexPath.section - 1][header.count - 1] == "NOK"){
                            cell.setupRed(item: cellData[indexPath.section - 1][indexPath.row]);
                            cell.layer.borderWidth = 0.5;
                            cell.layer.borderColor = UIColor.darkGray.cgColor;
                        }
                        else if(self.cellData[indexPath.section - 1][header.count - 1] != "NOK"){
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                            cell.layer.borderWidth = 0.5;
                            cell.layer.borderColor = UIColor.darkGray.cgColor;
                        }
                        if(self.cellData[indexPath.section - 1][indexPath.row].range(of: "http:") != nil){
                            cell.setupLink(item: cellData[indexPath.section - 1][indexPath.row]);
                            cell.layer.borderWidth = 0.5;
                            cell.layer.borderColor = UIColor.darkGray.cgColor;
                        }
                    }
                    
                case .GetShopSalesByArea:
                    if indexPath.row == 1 {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row]);
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    
                    if self.isDetailsOn {
                        if(self.cellData[indexPath.section - 1][header.count - 16].hasPrefix("-")){
                            cell.setupRed(item: cellData[indexPath.section - 1][indexPath.row])
                        } else {
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row])
                        }
                    } else {
                        if(self.cellData[indexPath.section - 1][header.count - 1].hasPrefix("-")){
                            cell.setupRed(item: cellData[indexPath.section - 1][indexPath.row])
                        } else {
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row])
                        }
                    }
                    cell.layer.borderWidth = 0.5;
                    cell.layer.borderColor = UIColor.darkGray.cgColor;
                    
                case .GetShopSalesRealtime:
                    if (indexPath.row == 1) || (indexPath.row == 2) {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row]);
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    cell.layer.borderWidth = 0.5;
                    cell.layer.borderColor = UIColor.darkGray.cgColor;
                    
                case .GetShopSalesByShop:
                    if indexPath.row == 1 {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row]);
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    
                    if self.isDetailsOn {
                        if(self.cellData[indexPath.section - 1][header.count - 16].hasPrefix("-")){
                            cell.setupRed(item: cellData[indexPath.section - 1][indexPath.row])
                        } else {
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row])
                        }
                    } else {
                        if(self.cellData[indexPath.section - 1][header.count - 3].hasPrefix("-")){
                            cell.setupRed(item: cellData[indexPath.section - 1][indexPath.row])
                        } else {
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row])
                        }
                    }
                    cell.layer.borderWidth = 0.5;
                    cell.layer.borderColor = UIColor.darkGray.cgColor;
                    
                case .GetComboPKRealtime:
                    switch self.comboPKType {
                    case "ComboPKRealtimeVung":
                        if indexPath.row == 1 {
                            cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row]);
                        } else {
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                        }
                        
                        break
                        
                    case "ComboPKRealtimeKhuVuc" :
                        if (indexPath.row == 1) || (indexPath.row == 2) {
                            cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row]);
                        } else {
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                        }
                        break
                        
                    case "ComboPKRealtimeShop" :
                        if (indexPath.row == 1) || (indexPath.row == 2) {
                            cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row]);
                        } else {
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                        }
                        break
                    default:
                        break
                    }
                    cell.layer.borderWidth = 0.5;
                    cell.layer.borderColor = UIColor.darkGray.cgColor;
                default:
                    cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    cell.layer.borderWidth = 0.5;
                    cell.layer.borderColor = UIColor.darkGray.cgColor;
                    break;
                }
            }
        }
        return cell;
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil);
    }
    
    @objc fileprivate func ShowDetailsReport(sender: UISwitch){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
            self.header.removeAll();
            self.cellData.removeAll();
            if(sender.isOn){
                self.isDetailsOn = true;
                self.header = self.reportSection.unsafelyUnwrapped.reportDetailsHeader;
                self.tempHeaderForSize = self.header;
                self.cellData = self.reportSection.unsafelyUnwrapped.reportDetailsData;
            }
            else{
                self.isDetailsOn = false;
                self.header = self.reportSection.unsafelyUnwrapped.reportHeader;
                self.tempHeaderForSize = self.header;
                self.cellData = self.reportSection.unsafelyUnwrapped.reportData;
            }
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                self.view.subviews.forEach({$0.removeFromSuperview();});
                self.SetupCollectionView();
            }
        }
    }
    
    @objc fileprivate func ReloadData(){
        self.view.subviews.forEach({$0.removeFromSuperview()});
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
            if self.detailsButton != nil {
                if(self.isDetailsOn == false){
                    self.header = self.reportSection.unsafelyUnwrapped.reportHeader;
                    self.cellData = self.reportSection.unsafelyUnwrapped.reportData;
                }
                else{
                    self.header = self.reportSection.unsafelyUnwrapped.reportDetailsHeader;
                    self.cellData = self.reportSection.unsafelyUnwrapped.reportDetailsData;
                }
            }
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                self.SetupCollectionView();
            }
        }
    }
    
    func exportBCComboPKRealtime(data: [ComboPKRealtime]) -> String {
        var content = ""
        
        switch self.comboPKType {
        case "ComboPKRealtimeVung":
            content = ["STT","Vùng", "SL Combo10", "DS Combo10","SL Combo15", "DS Combo15","SL Combo20", "DS Combo20","Tổng SL Combo", "SL Máy","Tỉ trọng", "TB Bill Combo", "SL CB SDP + KCL", "Tỉ lệ SDP + KCL", "SL CB KCL + SDP + Cáp", "Tỉ lệ KCL + SDP + Cáp", "Total Combo", "Total Tỉ lệ"].joined(separator: "\t")
            for index in 0...data.count - 1 {
                let item = data[index]
                content += "\n\(item.STT!)\t \(item.Vung!)\t \(item.SL_Combo10!)\t \(item.DSCombo10!)\t \(item.SL_Combo15!)\t \(item.DSCombo15!)\t \(item.SL_Combo20!)\t \(item.DSCombo20!)\t \(item.TongSL_Combo!)\t \(item.SoLuongMay!)\t \(item.TyTrong!)\t \(item.TBBillCombo!)\t \(item.SLCBSDP_KCL!)\t \(item.TiLe_SDP_KCL!)\t \(item.SLCBKCL_SDP_Cap!)\t \(item.Tile_KCL_SDP_Cap!)\t \(item.ToTalCombo!)\t \(item.ToTal_TiLe!)"
            }
            
            
        case "ComboPKRealtimeKhuVuc":
            content = ["STT", "Khu vực","ASM", "SL Combo10", "DS Combo10","SL Combo15", "DS Combo15","SL Combo20", "DS Combo20","Tổng SL Combo", "SL Máy","Tỉ trọng", "TB Bill Combo", "SL CB SDP + KCL", "Tỉ lệ SDP + KCL", "SL CB KCL + SDP + Cáp", "Tỉ lệ KCL + SDP + Cáp", "Total Combo", "Total Tỉ lệ"].joined(separator: "\t")
            for index in 0...data.count - 1 {
                let item = data[index]
                content += "\n\(item.STT!)\t \(item.TenKhuVuc!)\t \(item.TenASM!)\t \(item.SL_Combo10!)\t \(item.DSCombo10!)\t \(item.SL_Combo15!)\t \(item.DSCombo15!)\t \(item.SL_Combo20!)\t \(item.DSCombo20!)\t \(item.TongSL_Combo!)\t \(item.SoLuongMay!)\t \(item.TyTrong!)\t \(item.TBBillCombo!)\t \(item.SLCBSDP_KCL!)\t \(item.TiLe_SDP_KCL!)\t \(item.SLCBKCL_SDP_Cap!)\t \(item.Tile_KCL_SDP_Cap!)\t \(item.ToTalCombo!)\t \(item.ToTal_TiLe!)"
            }
            
        case "ComboPKRealtimeShop":
            content = ["STT","Mã Shop", "Tên Shop", "SL Combo10", "DS Combo10","SL Combo15", "DS Combo15","SL Combo20", "DS Combo20","Tổng SL Combo", "SL Máy","Tỉ trọng", "TB Bill Combo", "SL CB SDP + KCL", "Tỉ lệ SDP + KCL", "SL CB KCL + SDP + Cáp", "Tỉ lệ KCL + SDP + Cáp", "Total Combo", "Total Tỉ lệ"].joined(separator: "\t")
            for index in 0...data.count - 1 {
                let item = data[index]
                content += "\n\(item.STT!)\t \(item.MaShop!)\t \(item.TenShop!)\t \(item.SL_Combo10!)\t \(item.DSCombo10!)\t \(item.SL_Combo15!)\t \(item.DSCombo15!)\t \(item.SL_Combo20!)\t \(item.DSCombo20!)\t \(item.TongSL_Combo!)\t \(item.SoLuongMay!)\t \(item.TyTrong!)\t \(item.TBBillCombo!)\t \(item.SLCBSDP_KCL!)\t \(item.TiLe_SDP_KCL!)\t \(item.SLCBKCL_SDP_Cap!)\t \(item.Tile_KCL_SDP_Cap!)\t \(item.ToTalCombo!)\t \(item.ToTal_TiLe!)"
            }
        default:
            break
        }
        
        return content
    }
    
    @objc fileprivate func ExportReport(){
        mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        var contentStr: String!;
        let filePath = NSTemporaryDirectory() + "\(reportSection.unsafelyUnwrapped)";
        
        switch reportSection.unsafelyUnwrapped {
        case .GetG38ShopSalesMTD,
             .GetShopSalesByArea,
             .GetShopSalesByShop,
             .GetShopSalesByZone,
             .GetShopSalesRealtime,
             .GetAreaSalesRealtime,
             .GetSalemanReport:
            
            contentStr = reportSection.unsafelyUnwrapped.reportDetailsHeader.joined(separator: "\t");
            reportSection.unsafelyUnwrapped.exportReportDetailsData.forEach{ item in
                contentStr += "\n" + item.joined(separator: "\t");
            };
            self.writeFile(path: filePath, content: contentStr, reportName: "\(reportSection.caseName)")
            break
            
        case .GetComboPKRealtime:
            switch self.comboPKType {
            case "ComboPKRealtimeVung":
                contentStr = self.exportBCComboPKRealtime(data: self.listComboPkRealtime)
                self.writeFile(path: filePath, content: contentStr, reportName: "\(reportSection.caseName)")
                break
                
            case "ComboPKRealtimeKhuVuc" :
                contentStr = self.exportBCComboPKRealtime(data: self.listComboPkRealtime)
                self.writeFile(path: filePath, content: contentStr, reportName: "\(reportSection.caseName)")
                break
                
            case "ComboPKRealtimeShop" :
                contentStr = self.exportBCComboPKRealtime(data: self.listComboPkRealtime)
                self.writeFile(path: filePath, content: contentStr, reportName: "\(reportSection.caseName)")
                break
            default:
                break
            }
            
        default:
            contentStr = reportSection.unsafelyUnwrapped.reportHeader.joined(separator: "\t");
            reportSection.unsafelyUnwrapped.exportReportData.forEach{ item in
                contentStr += "\n" + item.joined(separator: "\t");
            };
            self.writeFile(path: filePath, content: contentStr, reportName: "\(reportSection.caseName)")
            break
        }
    }
    
    func writeFile(path: String, content: String, reportName: String) {
        do {
            
            if #available(iOS 15.2, *) {
                let filName = "\(reportName).csv"
                let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(filName)
                try content.write(to: path!, atomically: true, encoding: .utf16)
                let exportSheet = UIActivityViewController(activityItems: [path!] as [Any], applicationActivities: nil)
                self.present(exportSheet, animated: true, completion: nil)
            } else {
                try content.write(toFile: path, atomically: false, encoding: String.Encoding.utf16)
                print("Nơi lưu file: \(path)")
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
                        }
                        else {
                            let alertVC = UIAlertController(title: "Thông báo", message: "Không thể nạp nội dung file báo cáo!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alertVC.addAction(action)
                            self.present(alertVC, animated: true, completion: nil)
                        }
                        self.present(self.mailComposer, animated: true, completion: nil)
                    }
                    else  {
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
}
