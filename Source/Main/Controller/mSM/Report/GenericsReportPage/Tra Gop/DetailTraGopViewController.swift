//
//  DetailTraGopViewController.swift
//  fptshop
//
//  Created by Apple on 4/22/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import MessageUI

class DetailTraGopViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, MFMailComposeViewControllerDelegate, UICollectionViewDataSource{
    
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
    var listDSTraGop: [DSTraGop] = []
    var listDSTraGopRealtime: [DSTraGopRealtime] = []
    var comboPKType = ""
    var reportName = ""
    let username = (Cache.user?.UserName)!;
    let token = (Cache.user?.Token)!
    var isRealtime = false
   static var contentExport = ""
    
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
        
        //        setChange()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = reportName
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
            if self.isRealtime == false {
                //show detail
                switch self.comboPKType {
                case "TyLeTraGopVung":
                    self.title = "BC Luỹ Kế Trả Góp Theo Vùng"
                    self.listDSTraGop.removeAll()
                    self.header = ["Vùng","Doanh Thu TG", "DS Máy", "Tỉ trọng TG", "Trung Bình Bill", "Total", "SL_SVFC", "SL_FEC", "SL_HC", "SL_HDS", "SL_MAF","N.hàng"]
                    self.switchDetail.isEnabled = false
                    self.getTyLeTraGopVung(username: self.username, token: self.token)
                    break

                case "TyLeTraGopKhuvuc" :
                    self.title = "BC Luỹ Kế Trả Góp Theo Khu Vực"
                    self.listDSTraGop.removeAll()
                    self.header = ["ASM", "Khu Vực", "Doanh Thu TG", "DS Máy", "Tỉ trọng TG", "Trung Bình Bill", "Total", "SL_SVFC", "SL_FEC", "SL_HC", "SL_HDS", "SL_MAF","N.hàng"]
                    self.switchDetail.isEnabled = false
                    self.getTyLeTraGopKhuVuc(username: self.username, token: self.token)
                    break

                case "TyLeTraGopShop" :
                    self.title = "BC Luỹ Kế Trả Góp Theo Shop"
                    self.listDSTraGop.removeAll()
                    self.header = ["ASM", "Shop","Doanh Thu TG", "DS Máy", "Tỉ trọng TG", "Trung Bình Bill", "Total", "SL_SVFC", "SL_FEC", "SL_HC", "SL_HDS", "SL_MAF","N.hàng"]
                    self.switchDetail.isEnabled = false
                    self.getTyLeTraGopShop(username: self.username, token: self.token)
                    break


                default:
                    break
                }
            } else {
                switch self.comboPKType {
                case "TraGopRealtimeVung":
                    self.title = "BC Luỹ Kế Trả Góp Theo Vùng"
                    self.listDSTraGopRealtime.removeAll()
                    self.header = ["Vùng","Doanh Thu TG", "DS Máy","SL Máy", "Tỉ trọng TG", "Trung Bình Bill", "Total", "SL_SVFC", "SL_FEC", "SL_HC", "SL_HDS", "SL_MAF","N.hàng"]
                    self.switchDetail.isEnabled = false
                    self.getTraGopRealtimeVung(username: self.username, token: self.token)
                    break

                case "TraGopRealtimeKhuvuc" :
                    self.title = "BC Luỹ Kế Trả Góp Theo Khu Vực"
                    self.listDSTraGopRealtime.removeAll()
                    self.header = ["ASM", "Khu Vực", "Doanh Thu TG", "DS Máy","SL Máy", "Tỉ trọng TG", "Trung Bình Bill", "Total", "SL_SVFC", "SL_FEC", "SL_HC", "SL_HDS", "SL_MAF","N.hàng"]
                    self.switchDetail.isEnabled = false
                    self.getTraGopRealtimeKhuVuc(username: self.username, token: self.token)
                    break

                case "TraGopRealtimeShop" :
                    self.title = "BC Luỹ Kế Trả Góp Theo Shop"
                    self.listDSTraGopRealtime.removeAll()
                    self.header = ["ASM", "Shop","Doanh Thu TG", "DS Máy","SL Máy", "Tỉ trọng TG", "Trung Bình Bill", "Total", "SL_SVFC", "SL_FEC", "SL_HC", "SL_HDS", "SL_MAF","N.hàng"]
                    self.switchDetail.isEnabled = false
                    self.getTraGopRealtimeShop(username: self.username, token: self.token)
                    break


                default:
                    break
                }
            }
        } else {
            if self.isRealtime == false {
                //show short
                switch self.comboPKType {
                case "TyLeTraGopVung":
                    self.title = "BC Luỹ Kế Trả Góp Theo Vùng"
                    self.listDSTraGop.removeAll()
                    self.header = ["Vùng","Doanh Thu TG", "DS Máy", "Tỉ trọng TG", "Trung Bình Bill"]
                    self.switchDetail.isEnabled = false
                    self.getTyLeTraGopVung(username: self.username, token: self.token)
                    break
                case "TyLeTraGopKhuvuc" :
                    self.title = "BC Luỹ Kế Trả Góp Theo Khu Vực"
                    self.listDSTraGop.removeAll()
                    self.header = ["ASM", "Khu Vực", "Doanh Thu TG", "DS Máy", "Tỉ trọng TG", "Trung Bình Bill"]
                    self.switchDetail.isEnabled = false
                    self.getTyLeTraGopKhuVuc(username: self.username, token: self.token)
                    break

                case "TyLeTraGopShop" :
                    self.title = "BC Luỹ Kế Trả Góp Theo Shop"
                    self.listDSTraGop.removeAll()
                    self.header = ["ASM","Shop", "Doanh Thu TG", "DS Máy", "Tỉ trọng TG", "Trung Bình Bill"]
                    self.switchDetail.isEnabled = false
                    self.getTyLeTraGopShop(username: self.username, token: self.token)
                    break

                default:
                    break
                }
            } else {
                switch self.comboPKType {
                case "TraGopRealtimeVung":
                    self.title = "BC Luỹ Kế Trả Góp Theo Vùng"
                    self.listDSTraGopRealtime.removeAll()
                    self.header = ["Vùng","Doanh Thu TG", "DS Máy","SL Máy", "Tỉ trọng TG", "Trung Bình Bill"]
                    self.switchDetail.isEnabled = false
                    self.getTraGopRealtimeVung(username: self.username, token: self.token)
                    break

                case "TraGopRealtimeKhuvuc" :
                    self.title = "BC Luỹ Kế Trả Góp Theo Khu Vực"
                    self.listDSTraGopRealtime.removeAll()
                    self.header = ["ASM", "Khu Vực", "Doanh Thu TG", "DS Máy","SL Máy", "Tỉ trọng TG", "Trung Bình Bill"]
                    self.switchDetail.isEnabled = false
                    self.getTraGopRealtimeKhuVuc(username: self.username, token: self.token)
                    break

                case "TraGopRealtimeShop" :
                    self.title = "BC Luỹ Kế Trả Góp Theo Shop"
                    self.listDSTraGopRealtime.removeAll()
                    self.header = ["ASM","Shop", "Doanh Thu TG", "DS Máy","SL Máy", "Tỉ trọng TG", "Trung Bình Bill"]
                    self.switchDetail.isEnabled = false
                    self.getTraGopRealtimeShop(username: self.username, token: self.token)
                    break


                default:
                    break
                }
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
        
        var list:[DSTraGop] = []
        var listRealtime:[DSTraGopRealtime] = []
        
        switch self.comboPKType {
        case "TyLeTraGopVung":
            list.removeAll()
            if(key.count > 0) {
                for item in listDSTraGop {
                    if ((item.VungMien.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateTragopVung(list)
                self.reportCollectionView.reloadData()
                
            } else {
                self.generateTragopVung(listDSTraGop)
                self.reportCollectionView.reloadData()
            }
            break
        case "TyLeTraGopKhuvuc":
            list.removeAll()
            if(key.count > 0) {
                for item in listDSTraGop {
                    if ((item.ASM.lowercased().range(of: key.lowercased())) != nil || (item.KhuVuc.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateTragopKhuvuc(list)
                self.reportCollectionView.reloadData()
            } else {
                self.generateTragopKhuvuc(listDSTraGop)
                self.reportCollectionView.reloadData()
            }
            break
        case "TyLeTraGopShop":
            list.removeAll()
            if(key.count > 0) {
                for item in listDSTraGop {
                    if ((item.TenShop.lowercased().range(of: key.lowercased())) != nil || (item.ASM.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateTragopShop(list)
                self.reportCollectionView.reloadData()
            } else {
                self.generateTragopShop(listDSTraGop)
                self.reportCollectionView.reloadData()
            }
            break
        case "TraGopRealtimeVung":
            listRealtime.removeAll()
            if(key.count > 0) {
                for item in listDSTraGopRealtime {
                    if ((item.VungMien.lowercased().range(of: key.lowercased())) != nil) {
                        listRealtime.append(item)
                    }
                }
                self.generateTragopVungRealtime(listRealtime)
                self.reportCollectionView.reloadData()
                
            } else {
                self.generateTragopVungRealtime(listDSTraGopRealtime)
                self.reportCollectionView.reloadData()
            }
            break
        case "TraGopRealtimeKhuvuc":
            listRealtime.removeAll()
            if(key.count > 0) {
                for item in listDSTraGopRealtime {
                    if ((item.ASM.lowercased().range(of: key.lowercased())) != nil || (item.KhuVuc.lowercased().range(of: key.lowercased())) != nil) {
                        listRealtime.append(item)
                    }
                }
                self.generateTragopKhuvucRealtime(listRealtime)
                self.reportCollectionView.reloadData()
            } else {
                self.generateTragopKhuvucRealtime(listDSTraGopRealtime)
                self.reportCollectionView.reloadData()
            }
            break
        case "TraGopRealtimeShop":
            listRealtime.removeAll()
            if(key.count > 0) {
                for item in listDSTraGopRealtime {
                    if ((item.TenShop.lowercased().range(of: key.lowercased())) != nil || (item.ASM.lowercased().range(of: key.lowercased())) != nil) {
                        listRealtime.append(item)
                    }
                }
                self.generateTragopShopRealtime(listRealtime)
                self.reportCollectionView.reloadData()
            } else {
                self.generateTragopShopRealtime(listDSTraGopRealtime)
                self.reportCollectionView.reloadData()
            }
            break
        default:
            break
        }
        
        
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
        if self.switchDetail.isOn {
            collectionViewLayout.numberColumnFixed = 2
        } else {
            collectionViewLayout.numberColumnFixed = 0
        }
        
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
    
    
    ////-------GET DATA-----------------------
    
    
    func getTyLeTraGopVung(username: String, token: String) {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            let data = mSMApiManager.getTraGopVungMien_Team_PTNH_Vung(username: username, token: token).Data
            if data != nil {
                self.listDSTraGop = data ?? []
                if self.listDSTraGop.count > 0 {
                    if self.switchDetail.isOn{
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.generateTragopVung(self.listDSTraGop)
                            self.reportCollectionView.removeFromSuperview()
                        }
                        
                    } else {
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.generateShortTragopVung(self.listDSTraGop)
                            self.reportCollectionView.removeFromSuperview()
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.SetUpCollectionView()
                        self.switchDetail.isEnabled = true
                    }
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
    
    func getTyLeTraGopKhuVuc(username: String, token: String) {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            let data = mSMApiManager.getTraGopVungMien_Team_PTNH_KhuVuc(username: username, token: token).Data
            if data != nil {
                self.listDSTraGop = data ?? []
                if self.listDSTraGop.count > 0 {
                    if self.switchDetail.isOn{
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.generateTragopKhuvuc(self.listDSTraGop)
                            self.reportCollectionView.removeFromSuperview()
                        }
                    } else {
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.generateShortTragopKhuvuc(self.listDSTraGop)
                            self.reportCollectionView.removeFromSuperview()
                        }
                    }
                    DispatchQueue.main.async {
                        self.SetUpCollectionView()
                        self.switchDetail.isEnabled = true
                    }
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
    
    func getTyLeTraGopShop(username: String, token: String) {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            let data = mSMApiManager.getTraGopVungMien_Team_PTNH_Shop(username: username, token: token).Data
            if data != nil {
                self.listDSTraGop = data ?? []
                if self.listDSTraGop.count > 0 {
                    if self.switchDetail.isOn{
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.generateTragopShop(self.listDSTraGop)
                            self.reportCollectionView.removeFromSuperview()
                        }
                        
                    } else {
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.generateShortTragopShop(self.listDSTraGop)
                            self.reportCollectionView.removeFromSuperview()
                        }
                    }
                    DispatchQueue.main.async {
                        self.SetUpCollectionView()
                        self.switchDetail.isEnabled = true
                    }
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
    ////REALTIME
    func getTraGopRealtimeVung(username: String, token: String) {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            let data = mSMApiManager.TraGopVungMien_Realtime_Team_PTNH_Vung(username: username, token: token).Data
            if data != nil {
                self.listDSTraGopRealtime = data ?? []
                if self.listDSTraGopRealtime.count > 0 {
                    if self.switchDetail.isOn{
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.generateTragopVungRealtime(self.listDSTraGopRealtime)
                            self.reportCollectionView.removeFromSuperview()
                        }
                        
                    } else {
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.generateShortTragopVungRealtime(self.listDSTraGopRealtime)
                            self.reportCollectionView.removeFromSuperview()
                        }
                    }
                    DispatchQueue.main.async {
                        self.SetUpCollectionView()
                        self.switchDetail.isEnabled = true
                    }
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
    
    func getTraGopRealtimeKhuVuc(username: String, token: String) {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            let data = mSMApiManager.TraGopVungMien_Realtime_Team_PTNH_KhuVuc(username: username, token: token).Data
            if data != nil {
                self.listDSTraGopRealtime = data ?? []
                if self.listDSTraGopRealtime.count > 0 {
                    if self.switchDetail.isOn{
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.generateTragopKhuvucRealtime(self.listDSTraGopRealtime)
                            self.reportCollectionView.removeFromSuperview()
                        }
                        
                    } else {
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.generateShortTragopKhuvucRealtime(self.listDSTraGopRealtime)
                            self.reportCollectionView.removeFromSuperview()
                        }
                    }
                    DispatchQueue.main.async {
                        self.SetUpCollectionView()
                        self.switchDetail.isEnabled = true
                    }
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
    
    func getTraGopRealtimeShop(username: String, token: String) {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            let data = mSMApiManager.TraGopVungMien_Realtime_Team_PTNH_Shop(username: username, token: token).Data
            if data != nil {
                self.listDSTraGopRealtime = data ?? []
                if self.listDSTraGopRealtime.count > 0 {
                    if self.switchDetail.isOn{
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.generateTragopShopRealtime(self.listDSTraGopRealtime)
                            self.reportCollectionView.removeFromSuperview()
                        }
                        
                    } else {
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.generateShortTragopShopRealtime(self.listDSTraGopRealtime)
                            self.reportCollectionView.removeFromSuperview()
                        }
                    }
                    DispatchQueue.main.async {
                        self.SetUpCollectionView()
                        self.switchDetail.isEnabled = true
                    }
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
    
    ///--GENERATE SHORT DATA-----------------------
    
    //VUNG
    func generateShortTragopVung(_ data:[DSTraGop]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.VungMien)",
                "\(item.DoanhThuTraGop)",
                "\(item.DoanhSoMay)",
                "\(item.TyTrong)",
                "\(item.TrungBinh_Bill)"
                ]);
        }
    }
    //KHU VUC
    func generateShortTragopKhuvuc(_ data:[DSTraGop]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.ASM)",
                "\(item.KhuVuc)",
                "\(item.DoanhThuTraGop)",
                "\(item.DoanhSoMay)",
                "\(item.TyTrong)",
                "\(item.TrungBinh_Bill)"
                ]);
        }
    }
    
    //SHOP
    func generateShortTragopShop(_ data:[DSTraGop]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.ASM)",
                "\(item.TenShop)",
                "\(item.DoanhThuTraGop)",
                "\(item.DoanhSoMay)",
                "\(item.TyTrong)",
                "\(item.TrungBinh_Bill)"
                ]);
        }
    }
    //realtime
    //VUNG
    func generateShortTragopVungRealtime(_ data:[DSTraGopRealtime]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.VungMien)",
                "\(Common.convertCurrencyDouble(value: item.DoanhThuTraGop))",
                "\(Common.convertCurrencyDouble(value: item.DoanhSoMay))",
                "\(item.SLMay)",
                "\(item.TyTrong)",
                "\(Common.convertCurrencyDouble(value: item.TrungBinh_Bill))"
                ]);
        }
    }
    //KHU VUC
    func generateShortTragopKhuvucRealtime(_ data:[DSTraGopRealtime]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.ASM)",
                "\(item.KhuVuc)",
                "\(Common.convertCurrencyDouble(value: item.DoanhThuTraGop))",
                "\(Common.convertCurrencyDouble(value: item.DoanhSoMay))",
                "\(item.SLMay)",
                "\(item.TyTrong)",
                "\(Common.convertCurrencyDouble(value: item.TrungBinh_Bill))"
                ]);
        }
    }
    
    //SHOP
    func generateShortTragopShopRealtime(_ data:[DSTraGopRealtime]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.ASM)",
                "\(item.TenShop)",
                "\(Common.convertCurrencyDouble(value: item.DoanhThuTraGop))",
                "\(Common.convertCurrencyDouble(value: item.DoanhSoMay))",
                "\(item.SLMay)",
                "\(item.TyTrong)",
                "\(Common.convertCurrencyDouble(value: item.TrungBinh_Bill))"
                ]);
        }
    }
    
    ///--GENERATE DETAIL DATA-----------------------
    //VUNG
    func generateTragopVung(_ data:[DSTraGop]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.VungMien)",
                "\(item.DoanhThuTraGop)",
                "\(item.DoanhSoMay)",
                "\(item.TyTrong)",
                "\(item.TrungBinh_Bill)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_Tong))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_SVFC))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_FEC))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_HC))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_HDS))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_MAF))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_NganHang))"
                ]);
        }
    }
    //KHU VUC
    func generateTragopKhuvuc(_ data:[DSTraGop]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.ASM)",
                "\(item.KhuVuc)",
                "\(item.DoanhThuTraGop)",
                "\(item.DoanhSoMay)",
                "\(item.TyTrong)",
                "\(item.TrungBinh_Bill)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_Tong))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_SVFC))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_FEC))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_HC))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_HDS))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_MAF))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_NganHang))"
                ]);
        }
    }
    
    //SHOP
    func generateTragopShop(_ data:[DSTraGop]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.ASM)",
                "\(item.TenShop)",
                "\(item.DoanhThuTraGop)",
                "\(item.DoanhSoMay)",
                "\(item.TyTrong)",
                "\(item.TrungBinh_Bill)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_Tong))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_SVFC))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_FEC))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_HC))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_HDS))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_MAF))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_NganHang))"
                ]);
        }
    }
    
    //realtime
    func generateTragopVungRealtime(_ data:[DSTraGopRealtime]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.VungMien)",
                "\(Common.convertCurrencyDouble(value: item.DoanhThuTraGop))",
                "\(Common.convertCurrencyDouble(value: item.DoanhSoMay))",
                "\(item.SLMay)",
                "\(item.TyTrong)",
                "\(Common.convertCurrencyDouble(value: item.TrungBinh_Bill))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_Tong))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_SVFC))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_FEC))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_HC))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_HDS))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_MAF))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_NganHang))"
                ]);
        }
    }
    //KHU VUC
    func generateTragopKhuvucRealtime(_ data:[DSTraGopRealtime]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.ASM)",
                "\(item.KhuVuc)",
                "\(Common.convertCurrencyDouble(value: item.DoanhThuTraGop))",
                "\(Common.convertCurrencyDouble(value: item.DoanhSoMay))",
                "\(item.SLMay)",
                "\(item.TyTrong)",
                "\(Common.convertCurrencyDouble(value: item.TrungBinh_Bill))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_Tong))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_SVFC))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_FEC))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_HC))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_HDS))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_MAF))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_NganHang))"
                ]);
        }
    }
    
    //SHOP
    func generateTragopShopRealtime(_ data:[DSTraGopRealtime]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.ASM)",
                "\(item.TenShop)",
                "\(Common.convertCurrencyDouble(value: item.DoanhThuTraGop))",
                "\(Common.convertCurrencyDouble(value: item.DoanhSoMay))",
                "\(item.SLMay)",
                "\(item.TyTrong)",
                "\(Common.convertCurrencyDouble(value: item.TrungBinh_Bill))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_Tong))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_SVFC))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_FEC))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_HC))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_HDS))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_MAF))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_NganHang))"
                ]);
        }
    }
    
    ///export file
    @objc func ExportFile() {
        mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        switch self.comboPKType {
        case "TyLeTraGopVung":
            self.exportReportTraGopVung(reportName: "TyLeTraGopVung", isRealtime: false)
            break

        case "TyLeTraGopKhuvuc" :
            self.exportReportTraGopKhuvuc(reportName: "TyLeTraGopKhuvuc", isRealtime: false)
            break

        case "TyLeTraGopShop" :
            self.exportReportTraGopShop(reportName: "TyLeTraGopShop", isRealtime: false)
            break
            
            //-----
        case "TraGopRealtimeVung":
            self.exportReportTraGopVung(reportName: "TraGopRealtimeVung", isRealtime: true)
            break

        case  "TraGopRealtimeKhuvuc":
            self.exportReportTraGopKhuvuc(reportName: "TraGopRealtimeKhuvuc", isRealtime: true)
            break

        case "TraGopRealtimeShop":
            self.exportReportTraGopShop(reportName: "TraGopRealtimeShop", isRealtime: true)
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

    
    ///VUNG
    func exportReportTraGopVung(reportName: String, isRealtime: Bool){
        let path = NSTemporaryDirectory() + "\(reportName).csv"
        
        //generate contents of file
        var header = [String]()
        var content = ""
        
        if (isRealtime){
            header = ["STT","Vùng","Doanh Thu TG", "DS Máy","SL Máy", "Tỉ trọng TG", "Trung Bình Bill", "Total", "SL_SVFC", "SL_FEC", "SL_HC", "SL_HDS", "SL_MAF","N.hàng"]
            content = header.joined(separator: "\t")
            let data = self.listDSTraGopRealtime
            for index in 0...data.count - 1 {
                let item = data[index]
                content += "\n\(item.STT)\t\(item.VungMien)\t\(item.DoanhThuTraGop)\t\(item.DoanhSoMay)\t \(item.SLMay)\t \(item.TyTrong)\t\(item.TrungBinh_Bill)\t \(item.SoLuong_Tong)\t \(item.SoLuong_SVFC)\t\(item.SoLuong_FEC)\t \(item.SoLuong_HC)\t \(item.SoLuong_HDS)\t\(item.SoLuong_MAF)\t\(item.SoLuong_NganHang)"
            }
        }else{
            header = ["STT","Vùng","Doanh Thu TG", "DS Máy", "Tỉ trọng TG", "Trung Bình Bill", "Total", "SL_SVFC", "SL_FEC", "SL_HC", "SL_HDS", "SL_MAF","N.hàng"]
            content = header.joined(separator: "\t")
            let data = self.listDSTraGop
            for index in 0...data.count - 1 {
                let item = data[index]
                content += "\n\(item.STT)\t\(item.VungMien)\t\(item.DoanhThuTraGop)\t\(item.DoanhSoMay)\t \(item.TyTrong)\t\(item.TrungBinh_Bill)\t \(item.SoLuong_Tong)\t \(item.SoLuong_SVFC)\t\(item.SoLuong_FEC)\t \(item.SoLuong_HC)\t \(item.SoLuong_HDS)\t\(item.SoLuong_MAF)\t\(item.SoLuong_NganHang)"
            }
        }
        self.writeFile(path: path, content: content, reportName: reportName)
    }
    
    ///KHU VUC
    func exportReportTraGopKhuvuc(reportName: String, isRealtime: Bool){
        let path = NSTemporaryDirectory() + "\(reportName).csv"
        
        //generate contents of file
        var header = [String]()
        DetailTraGopViewController.contentExport = ""
        if isRealtime {
            header = ["STT", "ASM", "Khu Vực", "Doanh Thu TG", "DS Máy","SL Máy", "Tỉ trọng TG", "Trung Bình Bill", "Total", "SL_SVFC", "SL_FEC", "SL_HC", "SL_HDS", "SL_MAF","N.hàng"]
                DetailTraGopViewController.contentExport = header.joined(separator: "\t")
            let data = self.listDSTraGopRealtime
            for index in 0...data.count - 1 {
                let item = data[index]
                DetailTraGopViewController.contentExport += "\n\(item.STT)\t\(item.ASM)\t \(item.KhuVuc)\t\(item.DoanhThuTraGop)\t\(item.DoanhSoMay)\t \(item.SLMay)\t \(item.TyTrong)\t\(item.TrungBinh_Bill)\t \(item.SoLuong_Tong)\t \(item.SoLuong_SVFC)\t\(item.SoLuong_FEC)\t \(item.SoLuong_HC)\t \(item.SoLuong_HDS)\t\(item.SoLuong_MAF)\t\(item.SoLuong_NganHang)"
            }
        }else {
            let header = ["STT", "ASM", "Khu Vực", "Doanh Thu TG", "DS Máy", "Tỉ trọng TG", "Trung Bình Bill", "Total", "SL_SVFC", "SL_FEC", "SL_HC", "SL_HDS", "SL_MAF","N.hàng"]
             DetailTraGopViewController.contentExport = header.joined(separator: "\t")
            let data = self.listDSTraGop
            for index in 0...data.count - 1 {
                let item = data[index]
                DetailTraGopViewController.contentExport += "\n\(item.STT)\t\(item.ASM)\t \(item.KhuVuc)\t\(item.DoanhThuTraGop)\t\(item.DoanhSoMay)\t \(item.TyTrong)\t\(item.TrungBinh_Bill)\t \(item.SoLuong_Tong)\t \(item.SoLuong_SVFC)\t\(item.SoLuong_FEC)\t \(item.SoLuong_HC)\t \(item.SoLuong_HDS)\t\(item.SoLuong_MAF)\t\(item.SoLuong_NganHang)"
            }

        }
        self.writeFile(path: path, content: DetailTraGopViewController.contentExport, reportName: reportName)

    }
    
    ///SHOP
    func exportReportTraGopShop(reportName: String, isRealtime: Bool){
        let path = NSTemporaryDirectory() + "\(reportName).csv"
        
        //generate contents of file
        var header = [String]()
        var content = ""
        if isRealtime{
            header = ["STT","ASM", "Shop","Doanh Thu TG", "DS Máy","SL Máy", "Tỉ trọng TG", "Trung Bình Bill", "Total", "SL_SVFC", "SL_FEC", "SL_HC", "SL_HDS", "SL_MAF","N.hàng"]
            content = header.joined(separator: "\t")
            let data = self.listDSTraGopRealtime
            
            for index in 0...data.count - 1 {
                let item = data[index]
                content += "\n\(item.STT)\t \(item.TenShop)\t \(item.ASM)\t\(item.DoanhThuTraGop)\t\(item.DoanhSoMay)\t \(item.SLMay)\t \(item.TyTrong)\t\(item.TrungBinh_Bill)\t \(item.SoLuong_Tong)\t \(item.SoLuong_SVFC)\t\(item.SoLuong_FEC)\t \(item.SoLuong_HC)\t \(item.SoLuong_HDS)\t\(item.SoLuong_MAF)\t\(item.SoLuong_NganHang)"
            }
        }else {
            header = ["STT","ASM", "Shop","Doanh Thu TG", "DS Máy", "Tỉ trọng TG", "Trung Bình Bill", "Total", "SL_SVFC", "SL_FEC", "SL_HC", "SL_HDS", "SL_MAF","N.hàng"]
            content = header.joined(separator: "\t")
            let data = self.listDSTraGop
            
            for index in 0...data.count - 1 {
                let item = data[index]
                content += "\n\(item.STT)\t \(item.TenShop)\t \(item.ASM)\t\(item.DoanhThuTraGop)\t\(item.DoanhSoMay)\t \(item.TyTrong)\t\(item.TrungBinh_Bill)\t \(item.SoLuong_Tong)\t \(item.SoLuong_SVFC)\t\(item.SoLuong_FEC)\t \(item.SoLuong_HC)\t \(item.SoLuong_HDS)\t\(item.SoLuong_MAF)\t\(item.SoLuong_NganHang)"
            }
        }
        self.writeFile(path: path, content: content, reportName: reportName)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Swift.Error?) {
        print("Mail Compose controller didFinished");
        controller.dismiss(animated: true, completion: nil);
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
        
        if(header.count > 0 || cellData.count > 0 ){
            if(indexPath.section == 0){
                cell.setupHeader(item: header[indexPath.row]);
                cell.backgroundColor = UIColor.lightGray;
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = UIColor.darkGray.cgColor;
            }else{
//                cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
//                cell.layer.borderWidth = 0.5;
//                cell.layer.borderColor = UIColor.darkGray.cgColor;
                
                switch self.comboPKType {
                    
                case "TyLeTraGopVung":
                    if indexPath.row == 0 {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    
                    cell.layer.borderWidth = 0.5;
                    cell.layer.borderColor = UIColor.darkGray.cgColor;
                    break
                    
                case "TyLeTraGopKhuvuc" :
                    if indexPath.row == 0 || indexPath.row == 1 {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    
                    cell.layer.borderWidth = 0.5;
                    cell.layer.borderColor = UIColor.darkGray.cgColor;
                    break
                    
                case "TyLeTraGopShop" :
                    if indexPath.row == 0 || indexPath.row == 1 {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    
                    cell.layer.borderWidth = 0.5;
                    cell.layer.borderColor = UIColor.darkGray.cgColor;
                    break
                    
                    //---REALTIME
                case "TraGopRealtimeVung":
                    if indexPath.row == 0 {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    
                    cell.layer.borderWidth = 0.5;
                    cell.layer.borderColor = UIColor.darkGray.cgColor;
                    break
                    
                case "TraGopRealtimeKhuvuc" :
                    if indexPath.row == 0 || indexPath.row == 1 {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    
                    cell.layer.borderWidth = 0.5;
                    cell.layer.borderColor = UIColor.darkGray.cgColor;
                    break
                    
                case "TraGopRealtimeShop" :
                    if indexPath.row == 0 || indexPath.row == 1 {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    
                    cell.layer.borderWidth = 0.5;
                    cell.layer.borderColor = UIColor.darkGray.cgColor;
                    break
                default:
                    break
                }
            }
        }
        return cell;
    }
}
