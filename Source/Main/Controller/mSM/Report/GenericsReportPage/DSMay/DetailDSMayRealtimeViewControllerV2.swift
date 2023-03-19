//
//  DetailDSMayRealtimeViewController.swift
//  fptshop
//
//  Created by Apple on 4/10/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import MessageUI
import DropDown
import Presentr

class DetailDSMayRealtimeViewControllerV2: UIViewController ,MFMailComposeViewControllerDelegate, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var reportCollectionView: UICollectionView!;
    //    var type: Int = 0;
    
    var header: [String] = [];
    var cellData: [[String]] = [];
    var tempHeaderForSize: [String] = [];
    var reportSection: ReportCase!;
    var mailComposer = MFMailComposeViewController();
    var isDetailsOn: Bool = false;
    var btnSearch: UIBarButtonItem!
    var btnExport: UIBarButtonItem!
    var btnBack:UIBarButtonItem!
    var searchBarContainer:SearchBarContainerView!
    var listDSMay: [DoanhSoRealtimeSLMay] = []
    var listDSMayType: [DSMayType] = []
    
    let dropMenuLoai = DropDown();
    var lblChooseLoai: UILabel!
    var lblLoai: UILabel!
    var comboPKType = ""
    var listLoai = ["ALL","Đồng hồ_ĐTDĐ","ĐTDĐ-Apple","ĐTDĐ-ĐTDĐ","Máy tính_Apple","MT Bảng_MT Bảng","MT Bảng-Apple","MTXT-MT","Watch-Apple","MTXT nhập khẩu_MT"]
    let username = (Cache.user?.UserName)!;
    let token = (Cache.user?.Token)!
    var lockOrient = "portrait"
    var valueString = ""
    
    let presenter: Presentr = {
        let dynamicType = PresentationType.dynamic(center: ModalCenterPosition.center)
        let customPresenter = Presentr(presentationType: dynamicType)
        customPresenter.backgroundOpacity = 0.3
        customPresenter.roundCorners = true
        customPresenter.dismissOnSwipe = false
        customPresenter.dismissAnimated = false
        customPresenter.backgroundTap = .noAction
        return customPresenter
    }()
    
    func initListLoai(){
        self.listDSMayType = []
        for item in listLoai {
            let loai = DSMayType(textValue: item, isCheck: false)
            self.listDSMayType.append(loai)
        }
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
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent;
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .allButUpsideDown;
    }
    override var shouldAutorotate: Bool{
        return true;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.btnBack.isEnabled = false
        if (self.lblLoai != nil) || (self.lblChooseLoai != nil) {
            self.lblLoai.removeFromSuperview()
            self.lblChooseLoai.removeFromSuperview()
        }
        self.createMenuLoai()
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.reportSection.caseName == ReportCase.GetLuyKeSLMay.caseName { // luy ke sl may khong co MTXT nhập khẩu_MT
            listLoai = ["ALL","Đồng hồ_ĐTDĐ","ĐTDĐ-Apple","ĐTDĐ-ĐTDĐ","Máy tính_Apple","MT Bảng_MT Bảng","MT Bảng-Apple","MTXT-MT","Watch-Apple"]
        }
        self.navigationItem.title = reportSection.caseName;
        mailComposer.mailComposeDelegate = self;
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationItem.hidesBackButton = true
        self.initListLoai()
        
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        btnBack = UIBarButtonItem(customView: btBackIcon)
        
        self.navigationItem.leftBarButtonItem = btnBack
        
        
        //set up navigationbarItem
        
        btnExport = UIBarButtonItem(image: UIImage(named: "ic_export"), style: .plain, target: self, action: #selector(ExportFile))
        btnSearch = UIBarButtonItem(image: #imageLiteral(resourceName: "Search"), style: .plain, target: self, action: #selector(actionSearchAssets))
        self.navigationItem.rightBarButtonItems = [btnExport, btnSearch]
        
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
        
        self.createMenuLoai()
        self.SetupCollectionView()
        self.loadReport()
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
        self.navigationItem.setRightBarButtonItems([btnExport,btnSearch], animated: true)
        search(key: "")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        search(key: "\(searchBar.text!)")
        self.navigationItem.setRightBarButtonItems([btnExport,btnSearch], animated: true)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.titleView = nil
        }, completion: { finished in
            
        })
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(key: searchText)
    }
    
    func search(key:String){
        
        var list:[DoanhSoRealtimeSLMay] = []
        
        switch self.comboPKType{
        case "DSMayRealtimeVung":
            list.removeAll()
            if(key.count > 0) {
                for item in listDSMay {
                    if ((item.Vung.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateDSMayRealtimeVung(list)
                self.reportCollectionView.reloadData()
                
            } else {
                self.generateDSMayRealtimeVung(listDSMay)
                self.reportCollectionView.reloadData()
            }
            break
            
        case "DSMayRealtimeKhuVuc":
            
            list.removeAll()
            if(key.count > 0) {
                for item in listDSMay {
                    if ((item.ASM.lowercased().range(of: key.lowercased())) != nil || (item.KhuVuc.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateDSMayRealtimeKhuVuc(list)
                self.reportCollectionView.reloadData()
            } else {
                self.generateDSMayRealtimeKhuVuc(listDSMay)
                self.reportCollectionView.reloadData()
            }
            break
            
        case "DSMayRealtimeShop":
            list.removeAll()
            if(key.count > 0) {
                for item in listDSMay {
                    if ((item.TenShop.lowercased().range(of: key.lowercased())) != nil || (item.ASM.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateDSMayRealtimeShop(list)
                self.reportCollectionView.reloadData()
            } else {
                self.generateDSMayRealtimeShop(listDSMay)
                self.reportCollectionView.reloadData()
            }
            break
            
            /// LUY KE DS MAY
            
        case "LuyKeSLMayVung":
            list.removeAll()
            if(key.count > 0) {
                for item in listDSMay {
                    if ((item.Vung.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateLuyKeVung(list)
                self.reportCollectionView.reloadData()
                
            } else {
                self.generateLuyKeVung(listDSMay)
                self.reportCollectionView.reloadData()
            }
            break
            
        case "LuyKeSLMayKhuVuc":
            
            list.removeAll()
            if(key.count > 0) {
                for item in listDSMay {
                    if ((item.ASM.lowercased().range(of: key.lowercased())) != nil || (item.KhuVuc.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateLuyKeKhuVuc(list)
                self.reportCollectionView.reloadData()
            } else {
                self.generateLuyKeKhuVuc(listDSMay)
                self.reportCollectionView.reloadData()
            }
            break
            
        case "LuyKeSLMayShop":
            list.removeAll()
            if(key.count > 0) {
                for item in listDSMay {
                    if ((item.TenShop.lowercased().range(of: key.lowercased())) != nil || (item.ASM.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateLuyKeShop(list)
                self.reportCollectionView.reloadData()
            } else {
                self.generateLuyKeShop(listDSMay)
                self.reportCollectionView.reloadData()
            }
            break
            
        default:
            break
        }
        
    }
    
    
    func createMenuLoai() {
        
        lblLoai = UILabel(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 20), height: 20))
        lblLoai.text = "Chọn loại:"
        lblLoai.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(lblLoai)
        
        lblChooseLoai = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lblLoai.frame.origin.y + lblLoai.frame.height + Common.Size(s: 5), width: self.view.frame.width - Common.Size(s: 20), height: Common.Size(s: 20)))
        lblChooseLoai.text = "ALL"
        lblChooseLoai.textAlignment = .center
        lblChooseLoai.layer.cornerRadius = 3
        lblChooseLoai.layer.borderColor = UIColor.gray.cgColor
        lblChooseLoai.layer.borderWidth = 1
        lblChooseLoai.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(lblChooseLoai)
        self.btnBack.isEnabled = true
        self.view.bringSubviewToFront(lblChooseLoai)
        
        let tapShowMenuLoai = UITapGestureRecognizer(target: self, action: #selector(showMenuLoai))
        lblChooseLoai.isUserInteractionEnabled = true
        lblChooseLoai.addGestureRecognizer(tapShowMenuLoai)
    }
    
    @objc func showMenuLoai() {
        initListLoai()
        
        let popup = CheckListDSViewController()
        popup.modalPresentationStyle = .overCurrentContext
        popup.listDSMayType = self.listDSMayType
        popup.getreportType = { valueString in
            self.lblChooseLoai.text = valueString
            self.valueString = valueString
            
            self.lblChooseLoai.numberOfLines = 0
            let lblChooseLoaiHeight = self.lblChooseLoai.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : self.lblChooseLoai.optimalHeight
            self.lblChooseLoai.frame = CGRect(x: self.lblChooseLoai.frame.origin.x, y: self.lblChooseLoai.frame.origin.y, width: self.lblChooseLoai.frame.width, height: lblChooseLoaiHeight)
            
            self.reportCollectionView.frame = CGRect(x: self.reportCollectionView.frame.origin.x, y: self.lblChooseLoai.frame.origin.y + lblChooseLoaiHeight + Common.Size(s: 10), width: self.reportCollectionView.frame.width, height: self.view.frame.height - (self.lblChooseLoai.frame.origin.y + self.lblChooseLoai.frame.height + Common.Size(s: 10)))
            
            self.loadReport()
            AppUtility.lockOrientation(.allButUpsideDown)
            
        }
        popup.modalTransitionStyle = .crossDissolve
        self.present(popup, animated: true, completion: nil)
    }
    
    func loadReport(){
        self.reportCollectionView.removeFromSuperview()
        if self.reportSection.caseName == ReportCase.GetDSMayRealtime.caseName {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                switch self.comboPKType {
                case "DSMayRealtimeVung":
                    self.title = "BC Doanh số máy Realtime Vùng"
                    self.getDSMayRealtimeVung(username: self.username, loai: self.lblChooseLoai.text ?? "ALL", token: self.token)
                    break
                case "DSMayRealtimeKhuVuc" :
                    self.title = "BC Doanh số máy Realtime Khu vực"
                    self.getDSMayRealtimeKhuVuc(username: self.username, loai: self.lblChooseLoai.text ?? "ALL", token: self.token)
                    break
                case "DSMayRealtimeShop":
                    self.title = "BC Doanh số máy Realtime Shop"
                    self.getDSMayRealtimeShop(username: self.username, loai: self.lblChooseLoai.text ?? "ALL", token: self.token)
                    break
                default:
                    break
                }
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.SetupCollectionView()
                }
            }
            
        } else if self.reportSection.caseName == ReportCase.GetLuyKeSLMay.caseName{
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                switch self.comboPKType {
                case "LuyKeSLMayVung":
                    self.title = "Báo cáo lũy kế sl máy vùng"
                    self.getLuyKeDSMayVung(username: self.username, loai: self.lblChooseLoai.text ?? "ALL", token: self.token)
                    break
                case "LuyKeSLMayKhuVuc" :
                    self.title = "Báo cáo lũy kế sl máy khu vực"
                    self.getLuyKeDSMayKhuVuc(username: self.username, loai: self.lblChooseLoai.text ?? "ALL", token: self.token)
                    break
                case "LuyKeSLMayShop":
                    self.title = "Báo cáo lũy kế sl máy shop"
                    self.getLuyKeDSMayShop(username: self.username, loai: self.lblChooseLoai.text ?? "ALL", token: self.token)
                    break
                default:
                    break
                }
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.SetupCollectionView()
                }
            }
        } else {
            self.SetupCollectionView()
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
            case .portrait:
                self.lockOrient = "portrait"
            case .landscapeLeft,.landscapeRight :
                self.lockOrient = "landscape"
                
            default:
                print("Upside down, and that is not supported");
            }
            
            self.view.subviews.forEach({ $0.removeFromSuperview() });
            self.createMenuLoai()
            self.lblChooseLoai.text = self.valueString
            self.SetupCollectionView();
            
            self.lblChooseLoai.numberOfLines = 0
            let lblChooseLoaiHeight = self.lblChooseLoai.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : self.lblChooseLoai.optimalHeight
            self.lblChooseLoai.frame = CGRect(x: self.lblChooseLoai.frame.origin.x, y: self.lblChooseLoai.frame.origin.y, width: self.lblChooseLoai.frame.width, height: lblChooseLoaiHeight)
            
            self.reportCollectionView.frame = CGRect(x: self.reportCollectionView.frame.origin.x, y: self.lblChooseLoai.frame.origin.y + lblChooseLoaiHeight + Common.Size(s: 10), width: self.reportCollectionView.frame.width, height: self.view.frame.height - (self.lblChooseLoai.frame.origin.y + self.lblChooseLoai.frame.height + Common.Size(s: 10)))
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in})
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    
    
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
        
        let collectionViewLayout = ReportLayout();
        
        self.reportCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: self.lblChooseLoai.frame.origin.y + lblChooseLoai.frame.height + Common.Size(s: 20), width: self.view.frame.size.width, height: self.view.frame.height - (Common.Size(s: 44) + Common.Size(s: 20) + lblChooseLoai.frame.height + Common.Size(s: 40))), collectionViewLayout: collectionViewLayout);
        
        collectionViewLayout.numberOfColumns = header.count;
        collectionViewLayout.titleArray = self.tempHeaderForSize;
        collectionViewLayout.numberColumnFixed = 2
        
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
    
    ///GET DATA
    
    func getDSMayRealtimeVung(username: String, loai: String, token: String) {
        cellData = [[String]]()
        let data = mSMApiManager.getListDoanhSo_Realtime_SL_May_Vung(username: username, loai: loai, token: token).Data
        self.header = ["STT","Vùng", "SL Máy", "Doanh Thu Máy"]
        if data != nil {
            self.listDSMay = data ?? []
            self.generateDSMayRealtimeVung(listDSMay)
        } else {
            debugPrint("Không lấy được data!")
        }
        
    }
    
    func getDSMayRealtimeKhuVuc(username: String, loai: String, token: String) {
        cellData = [[String]]()
        let data = mSMApiManager.getListDoanhSo_Realtime_SL_May_Khuvuc(username: username, loai: loai, token: token).Data
        self.header =  ["STT", "Vùng","ASM", "Khu Vực", "SL Máy", "Doanh Thu Máy"]
        if data != nil {
            self.listDSMay = data ?? []
            self.generateDSMayRealtimeKhuVuc(listDSMay)
        } else {
            debugPrint("Không lấy được data!")
        }
        
    }
    
    func getDSMayRealtimeShop(username: String, loai: String, token: String) {
        cellData = [[String]]()
        let data = mSMApiManager.getListDoanhSo_Realtime_SL_May_Shop(username: username, loai: loai, token: token).Data
        self.header =  ["STT", "ASM","Shop", "SL Máy", "Doanh Thu Máy"]
        if data != nil {
            self.listDSMay = data ?? []
            self.generateDSMayRealtimeShop(listDSMay)
        } else {
            debugPrint("Không lấy được data!")
        }
        
    }
    ////LUY KE DS MAY
    func getLuyKeDSMayVung(username: String, loai: String, token: String) {
        cellData = [[String]]()
        let data = mSMApiManager.getLuyLe_SL_May_Vung(username: username, loai: loai, token: token).Data
        self.header = ["STT","Vùng", "SL Máy", "DT Máy", "SL Cùng Kỳ", "DT Cùng Kỳ", "+/- Doanh Thu", "% Tăng Giảm"]
        if data != nil {
            self.listDSMay = data ?? []
            self.generateLuyKeVung(listDSMay)
        } else {
            debugPrint("Không lấy được data!")
        }
        
    }
    
    func getLuyKeDSMayKhuVuc(username: String, loai: String, token: String) {
        cellData = [[String]]()
        let data = mSMApiManager.getLuyLe_SL_May_Khuvuc(username: username, loai: loai, token: token).Data
        self.header =  ["STT", "Vùng","ASM", "Khu Vực", "SL Máy", "DT Máy", "SL Cùng Kỳ", "DT Cùng Kỳ", "+/- Doanh Thu", "% Tăng Giảm"]
        if data != nil {
            self.listDSMay = data ?? []
            self.generateLuyKeKhuVuc(listDSMay)
        } else {
            debugPrint("Không lấy được data!")
        }
        
    }
    
    func getLuyKeDSMayShop(username: String, loai: String, token: String) {
        cellData = [[String]]()
        let data = mSMApiManager.getLuyLe_SL_May_Shop(username: username, loai: loai, token: token).Data
        self.header =  ["STT", "ASM","Shop", "SL Máy", "DT Máy", "SL Cùng Kỳ", "DT Cùng Kỳ", "+/- Doanh Thu", "% Tăng Giảm"]
        if data != nil {
            self.listDSMay = data ?? []
            self.generateLuyKeShop(listDSMay)
        } else {
            debugPrint("Không lấy được data!")
        }
        
    }
    
    
    ////GENERATE DATA DS may realtime
    //VUNG
    func generateDSMayRealtimeVung(_ data:[DoanhSoRealtimeSLMay]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.STT)",
                "\(item.Vung)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_May))",
                "\(Common.convertCurrencyDoubleV2(value: item.DoanhSo_May))"
                ]);
        }
    }
    
    //KHUVUC
    func generateDSMayRealtimeKhuVuc(_ data:[DoanhSoRealtimeSLMay]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.STT)",
                "\(item.Vung)",
                "\(item.ASM)",
                "\(item.KhuVuc)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_May))",
                "\(Common.convertCurrencyDoubleV2(value: item.DoanhSo_May))"
                ]);
            
        }
    }
    
    //SHOP
    func generateDSMayRealtimeShop(_ data:[DoanhSoRealtimeSLMay]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.STT)",
                "\(item.ASM)",
                "\(item.TenShop)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_May))",
                "\(Common.convertCurrencyDoubleV2(value: item.DoanhSo_May))"
                ]);
            
        }
    }
    
    ///--GENERATE DATA Luy Ke-----------------------
    //VUNG
    func generateLuyKeVung(_ data:[DoanhSoRealtimeSLMay]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.STT)",
                "\(item.Vung)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_May))",
                "\(Common.convertCurrencyDoubleV2(value: item.DoanhSo_May))",
                "\(Common.convertCurrencyV2(value: item.SL_CungKy))",
                "\(Common.convertCurrencyDoubleV2(value: item.DoanhSo_CungKy))",
                "\(Common.convertCurrencyDoubleV2(value: item.TangGiam))",
                "\(item.TyLe)"
                ]);
        }
    }
    
    //KHUVUC
    func generateLuyKeKhuVuc(_ data:[DoanhSoRealtimeSLMay]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.STT)",
                "\(item.Vung)",
                "\(item.ASM)",
                "\(item.KhuVuc)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_May))",
                "\(Common.convertCurrencyDoubleV2(value: item.DoanhSo_May))",
                "\(Common.convertCurrencyV2(value: item.SL_CungKy))",
                "\(Common.convertCurrencyDoubleV2(value: item.DoanhSo_CungKy))",
                "\(Common.convertCurrencyDoubleV2(value: item.TangGiam))",
                "\(item.TyLe)"
                ]);
            
        }
    }
    
    //SHOP
    func generateLuyKeShop(_ data:[DoanhSoRealtimeSLMay]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.STT)",
                "\(item.ASM)",
                "\(item.TenShop)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_May))",
                "\(Common.convertCurrencyDoubleV2(value: item.DoanhSo_May))",
                "\(Common.convertCurrencyV2(value: item.SL_CungKy))",
                "\(Common.convertCurrencyDoubleV2(value: item.DoanhSo_CungKy))",
                "\(Common.convertCurrencyDoubleV2(value: item.TangGiam))",
                "\(item.TyLe)"
                ]);
            
        }
    }
    
    @objc func ExportFile() {
        mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        switch self.comboPKType {
        case "DSMayRealtimeVung":
            self.exportReportDSMayVungRealtime(reportName: "DSMayVungRealtime")
            break
            
        case "DSMayRealtimeKhuVuc" :
            self.exportReportDSMayKhuVucRealtime(reportName: "DSMayKhuVucRealtime")
            break
            
        case "DSMayRealtimeShop" :
            self.exportReportDSMayShopRealtime(reportName: "DSMayShopRealtime")
            break
        ///LUY KE DS MAY
        case "LuyKeSLMayVung":
            self.exportReportLuyKeVung(reportName: "LuyKeSLMayVung")
            break
            
        case  "LuyKeSLMayKhuVuc":
            self.exportReportLuyKeKhuVuc(reportName: "LuyKeSLMayKhuVuc")
            break
            
        case "LuyKeSLMayShop":
            self.exportReportLuyKeShop(reportName: "LuyKeSLMayShop")
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
    
    
    ///------------EXPORT-------
    func exportReportDSMayVungRealtime(reportName: String){
        let path = NSTemporaryDirectory() + "\(reportName).csv"
        
        //generate contents of file
        let data = self.listDSMay
        let header = ["STT","Vùng", "SL Máy", "Doanh Thu Máy"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.STT)\t \(item.Vung)\t \(item.SoLuong_May)\t \(item.DoanhSo_May)"
        }
        self.writeFile(path: path, content: content, reportName: reportName)
    }
    
    func exportReportDSMayKhuVucRealtime(reportName: String){
        let path = NSTemporaryDirectory() + "\(reportName).csv"
        
        //generate contents of file
        let data = self.listDSMay
        let header =  ["STT", "Vùng","ASM", "Khu Vực", "SL Máy", "Doanh Thu Máy"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.STT)\t \(item.Vung)\t \(item.ASM)\t \(item.KhuVuc)\t \(item.SoLuong_May)\t \(item.DoanhSo_May)"
        }
        self.writeFile(path: path, content: content, reportName: reportName)
    }
    
    func exportReportDSMayShopRealtime(reportName: String){
        let path = NSTemporaryDirectory() + "\(reportName).csv"
        
        //generate contents of file
        let data = self.listDSMay
        let header =  ["STT", "ASM","Shop", "SL Máy", "Doanh Thu Máy"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.STT)\t \(item.ASM)\t \(item.TenShop)\t \(item.SoLuong_May)\t \(item.DoanhSo_May)"
            
        }
        self.writeFile(path: path, content: content, reportName: reportName)
    }
    
    func exportReportLuyKeVung(reportName: String){
        let path = NSTemporaryDirectory() + "\(reportName).csv"
        
        //generate contents of file
        let data = self.listDSMay
        let header = ["STT","Vùng", "SL Máy", "DT Máy", "SL Cùng Kỳ", "DT Cùng Kỳ", "+/- Doanh Thu", "% Tăng Giảm"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.STT)\t \(item.ASM)\t \(item.TenShop)\t \(item.SoLuong_May)\t \(item.DoanhSo_May)\t \(item.SL_CungKy)\t \(item.DoanhSo_CungKy)\t \(item.TangGiam)\t \(item.TyLe)"
            
        }
        self.writeFile(path: path, content: content, reportName: reportName)
    }
    
    func exportReportLuyKeKhuVuc(reportName: String){
        let path = NSTemporaryDirectory() + "\(reportName).csv"
        
        //generate contents of file
        let data = self.listDSMay
        let header =  ["STT", "Vùng","ASM", "Khu Vực", "SL Máy", "DT Máy", "SL Cùng Kỳ", "DT Cùng Kỳ", "+/- Doanh Thu", "% Tăng Giảm"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.STT)\t \(item.Vung)\t \(item.ASM)\t \(item.KhuVuc)\t \(item.SoLuong_May)\t \(item.DoanhSo_May)\t \(item.SL_CungKy)\t \(item.DoanhSo_CungKy)\t \(item.TangGiam)\t \(item.TyLe)"
            
        }
        self.writeFile(path: path, content: content, reportName: reportName)
    }
    
    func exportReportLuyKeShop(reportName: String){
        let path = NSTemporaryDirectory() + "\(reportName).csv"
        
        //generate contents of file
        let data = self.listDSMay
        let header =  ["STT", "ASM","Shop", "SL Máy", "DT Máy", "SL Cùng Kỳ", "DT Cùng Kỳ", "+/- Doanh Thu", "% Tăng Giảm"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.STT)\t \(item.ASM)\t \(item.TenShop)\t \(item.SoLuong_May)\t \(item.DoanhSo_May)\t \(item.SL_CungKy)\t \(item.DoanhSo_CungKy)\t \(item.TangGiam)\t \(item.TyLe)"
            
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
        
        if(header.count > 0 && cellData.count > 0 ){
            if(indexPath.section == 0){
                cell.setupHeader(item: header[indexPath.row]);
                cell.backgroundColor = UIColor.lightGray;
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = UIColor.darkGray.cgColor;
            }else{
                switch self.comboPKType {
                case "DSMayRealtimeVung":
                    if indexPath.row == 1 {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row]);
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    
                    break
                    
                case "DSMayRealtimeKhuVuc" :
                    if (indexPath.row == 1) || (indexPath.row == 2) {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row]);
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    break
                    
                case "DSMayRealtimeShop" :
                    if (indexPath.row == 1) || (indexPath.row == 2) {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row]);
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    break
                    
                    //LUY KE DS MAY
                    
                case "LuyKeSLMayVung":
                    if indexPath.row == 1 {
                        if (listDSMay[indexPath.section - 1].TyLe).hasPrefix("-"){
                            cell.setupLeftRed(item: cellData[indexPath.section - 1][indexPath.row])
                        }else {
                            cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row]);
                        }
                    } else {
                        if (listDSMay[indexPath.section - 1].TyLe).hasPrefix("-"){
                            cell.setupRed(item: cellData[indexPath.section - 1][indexPath.row])
                        }else {
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                        }
                    }
                    break
                    
                case "LuyKeSLMayKhuVuc" :
                    if indexPath.row == 1 || indexPath.row == 2 {
                        if (listDSMay[indexPath.section - 1].TyLe).hasPrefix("-"){
                            cell.setupLeftRed(item: cellData[indexPath.section - 1][indexPath.row])
                        }else {
                            cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row]);
                        }
                    } else {
                        if (listDSMay[indexPath.section - 1].TyLe).hasPrefix("-"){
                            cell.setupRed(item: cellData[indexPath.section - 1][indexPath.row])
                        }else {
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                        }
                    }
                    break
                    
                case "LuyKeSLMayShop" :
                    if indexPath.row == 1 || indexPath.row == 2 {
                        if (listDSMay[indexPath.section - 1].TyLe).hasPrefix("-"){
                            cell.setupLeftRed(item: cellData[indexPath.section - 1][indexPath.row])
                        }else {
                            cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row]);
                        }
                    } else {
                        if (listDSMay[indexPath.section - 1].TyLe).hasPrefix("-"){
                            cell.setupRed(item: cellData[indexPath.section - 1][indexPath.row])
                        }else {
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                        }
                    }
                    break
                default:
                    break
                }
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = UIColor.darkGray.cgColor;
            }
        }
        return cell;
    }
}

extension DetailDSMayRealtimeViewControllerV2: CheckListViewControllerDelegate{
    func getReportTypeString(valueString: String) {
        self.lblChooseLoai.text = valueString
        self.valueString = valueString
        
        self.lblChooseLoai.numberOfLines = 0
        let lblChooseLoaiHeight = self.lblChooseLoai.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : self.lblChooseLoai.optimalHeight
        self.lblChooseLoai.frame = CGRect(x: self.lblChooseLoai.frame.origin.x, y: self.lblChooseLoai.frame.origin.y, width: self.lblChooseLoai.frame.width, height: lblChooseLoaiHeight)
        
        self.reportCollectionView.frame = CGRect(x: self.reportCollectionView.frame.origin.x, y: self.lblChooseLoai.frame.origin.y + lblChooseLoaiHeight + Common.Size(s: 10), width: self.reportCollectionView.frame.width, height: self.view.frame.height - (self.lblChooseLoai.frame.origin.y + self.lblChooseLoai.frame.height + Common.Size(s: 10)))
        
        self.loadReport()
        AppUtility.lockOrientation(.allButUpsideDown)
    }
}




