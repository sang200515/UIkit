//
//  DetailReportSimViewController.swift
//  fptshop
//
//  Created by Apple on 4/11/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import MessageUI
import DropDown

class DetailReportSimViewController: UIViewController, MFMailComposeViewControllerDelegate, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

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
    var listSLSIM: [SLSIM] = []
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

        var list:[SLSIM] = []
        switch self.comboPKType {
            case "ReportSLSIMVung":
                list.removeAll()
                if(key.count > 0) {
                    for item in listSLSIM {
                        if ((item.Vung.lowercased().range(of: key.lowercased())) != nil) {
                            list.append(item)
                        }
                    }
                    self.generateDetailSLSimVung(list)
                    self.reportCollectionView.reloadData()

                } else {
                    self.generateDetailSLSimVung(listSLSIM)
                    self.reportCollectionView.reloadData()
                }

                break
            case "ReportSLSIMKhuvuc":

                list.removeAll()
                if(key.count > 0) {
                    for item in listSLSIM {
                        if ((item.ASM.lowercased().range(of: key.lowercased())) != nil || (item.KhuVuc.lowercased().range(of: key.lowercased())) != nil) {
                            list.append(item)
                        }
                    }
                    self.generateDetailSLSimKhuvuc(list)
                    self.reportCollectionView.reloadData()
                } else {
                    self.generateDetailSLSimKhuvuc(listSLSIM)
                    self.reportCollectionView.reloadData()
                }

                break
            case "ReportSLSIMShop":

                list.removeAll()
                if(key.count > 0) {
                    for item in listSLSIM {
                        if ((item.TenShop.lowercased().range(of: key.lowercased())) != nil || (item.ASM.lowercased().range(of: key.lowercased())) != nil || (item.TenVung.lowercased().range(of: key.lowercased())) != nil) {
                            list.append(item)
                        }
                    }
                    self.generateDetailSLSimShop(list)
                    self.reportCollectionView.reloadData()
                } else {
                    self.generateDetailSLSimShop(listSLSIM)
                    self.reportCollectionView.reloadData()
                }

                break
            case "TyLeSLSIMVung":
                list.removeAll()
                if(key.count > 0) {
                    for item in listSLSIM {
                        if ((item.Vung.lowercased().range(of: key.lowercased())) != nil) {
                            list.append(item)
                        }
                    }
                    self.generateDetailTyLeSimVung(list)
                    self.reportCollectionView.reloadData()

                } else {
                    self.generateDetailTyLeSimVung(self.listSLSIM)
                    self.reportCollectionView.reloadData()
                }
                break
            case "TyLeSLSIMKhuvuc":
                list.removeAll()
                if(key.count > 0) {
                    for item in listSLSIM {
                        if ((item.ASM.lowercased().range(of: key.lowercased())) != nil || (item.KhuVuc.lowercased().range(of: key.lowercased())) != nil) {
                            list.append(item)
                        }
                    }
                    self.generateDetailTyLeSimKhuvuc(list)
                    self.reportCollectionView.reloadData()
                } else {
                    self.generateDetailTyLeSimKhuvuc(self.listSLSIM)
                    self.reportCollectionView.reloadData()
                }
                break
            case "TyLeSLSIMShop":
                list.removeAll()
                if(key.count > 0) {
                    for item in listSLSIM {
                        if ((item.TenShop.lowercased().range(of: key.lowercased())) != nil || (item.ASM.lowercased().range(of: key.lowercased())) != nil) {
                            list.append(item)
                        }
                    }
                    self.generateDetailTyLeSimShop(list)
                    self.reportCollectionView.reloadData()
                } else {
                    self.generateDetailTyLeSimShop(self.listSLSIM)
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

        /////switch change
    @objc func setChange() {
        debugPrint("set change")

        if switchDetail.isOn == true{
            if self.reportSection.caseName == ReportCase.GetSLSim.caseName {
                    //show detail
                switch self.comboPKType {
                    case "ReportSLSIMVung":
                        self.title = "BC Số Lượng Sim Theo Vùng"
                        self.listSLSIM.removeAll()
                        self.header = ["Vùng", "SL Sim", "SL Máy","SL IPHONE","Sim/Máy","esim MBF/ Iphone","Tỉ lệ MBF/Máy",
                                       "MBF","eSim MBF", "ITEL", "VNMB", "Viettel","Vinaphone"]
                        self.switchDetail.isEnabled = false
                        self.getSlSimVung(username: self.username, token: self.token)
                        break

                    case "ReportSLSIMKhuvuc" :
                        self.title = "BC Số Lượng Sim Theo Khu Vực"
                        self.listSLSIM.removeAll()
                        self.header = ["ASM", "Khu Vực", "SL Sim", "SL Máy","SL IPHONE","Sim/Máy","esim MBF/ Iphone","Tỉ lệ MBF/Máy",
                                       "MBF","eSim MBF", "ITEL", "VNMB", "Viettel","Vinaphone"]
                        self.switchDetail.isEnabled = false
                        self.getSlSimKhuVuc(username: self.username, token: self.token)
                        break

                    case "ReportSLSIMShop" :
                        self.title = "BC Số Lượng Sim Theo Shop"
                        self.listSLSIM.removeAll()
                        self.header = [ "ASM", "Shop", "SL Sim", "SL Máy","SL IPHONE","Sim/Máy","esim MBF/ Iphone","Tỉ lệ MBF/Máy",
                                       "MBF","eSim MBF", "ITEL", "VNMB", "Viettel","Vinaphone"]
                        self.switchDetail.isEnabled = false
                        self.getSlSimShop(username: self.username, token: self.token)
                        break
                    default:
                        break
                }
            } else if self.reportSection.caseName == ReportCase.GetLuyKeSLSim.caseName {

                    //show detail
                switch self.comboPKType {
                            ///tyle sim
                    case "TyLeSLSIMVung":
                        self.title = "Báo cáo tỷ lệ sim theo vùng"
                        self.listSLSIM.removeAll()
                        self.header = ["Vùng", "SL Sim", "SL Máy","SL IPHONE","Sim/Máy","esim MBF/ Iphone","Tỉ lệ MBF/Máy",
                                       "MBF","eSim MBF", "ITEL", "VNMB", "Viettel","Vinaphone"]
                        self.switchDetail.isEnabled = false
                        self.getTyleSlSimVung(username: self.username, token: self.token)
                        break
                    case "TyLeSLSIMKhuvuc":
                        self.title = "Báo cáo tỷ lệ sim theo khu vực"
                        self.listSLSIM.removeAll()
                        self.header = ["ASM", "Khu Vực", "SL Sim", "SL Máy","SL IPHONE","Sim/Máy","esim MBF/ Iphone","Tỉ lệ MBF/Máy",
                                       "MBF","eSim MBF", "ITEL", "VNMB", "Viettel","Vinaphone"]
                        self.switchDetail.isEnabled = false
                        self.getTyleSlSimKhuVuc(username: self.username, token: self.token)
                        break
                    case "TyLeSLSIMShop":
                        self.title = "Báo cáo tỷ lệ sim theo shop"
                        self.listSLSIM.removeAll()
                        self.header = ["ASM", "Shop", "SL Sim", "SL Máy","SL IPHONE","Sim/Máy","esim MBF/ Iphone","Tỉ lệ MBF/Máy",
                                       "MBF","eSim MBF", "ITEL", "VNMB", "Viettel","Vinaphone"]
                        self.switchDetail.isEnabled = false
                        self.getTyleSlSimShop(username: self.username, token: self.token)
                        break

                    default:
                        break
                }
            }
        } else {
                //show short
            if self.reportSection.caseName == ReportCase.GetSLSim.caseName {
                switch self.comboPKType {
                    case "ReportSLSIMVung":
                        self.title = "BC Số Lượng Sim Theo Vùng"
                        self.listSLSIM.removeAll()
                        self.header = ["Vùng", "SL Sim", "SL Máy", "SL IPHONE"]
                        self.switchDetail.isEnabled = false
                        self.getSlSimVung(username: self.username, token: self.token)
                        break

                    case "ReportSLSIMKhuvuc" :
                        self.title = "BC Số Lượng Sim Theo Khu Vực"
                        self.listSLSIM.removeAll()
                        self.header = ["ASM", "Khu Vực", "SL Sim", "SL Máy", "SL IPHONE"]
                        self.switchDetail.isEnabled = false
                        self.getSlSimKhuVuc(username: self.username, token: self.token)
                        break

                    case "ReportSLSIMShop" :
                        self.title = "BC Số Lượng Sim Theo Shop"
                        self.listSLSIM.removeAll()
                        self.header = [ "ASM", "Shop", "SL Sim", "SL Máy", "SL IPHONE"]
                        self.switchDetail.isEnabled = false
                        self.getSlSimShop(username: self.username, token: self.token)
                        break

                    default:
                        break
                }

            } else if self.reportSection.caseName == ReportCase.GetLuyKeSLSim.caseName {

                switch self.comboPKType {

                            ///tyle sim
                    case "TyLeSLSIMVung":
                        self.title = "Báo cáo tỷ lệ sim theo vùng"
                        self.listSLSIM.removeAll()
                        self.header = ["Vùng", "SL Sim", "SL Máy", "SL IPHONE"]
                        self.switchDetail.isEnabled = false
                        self.getTyleSlSimVung(username: self.username, token: self.token)
                        break
                    case "TyLeSLSIMKhuvuc":
                        self.title = "Báo cáo tỷ lệ sim theo khu vực"
                        self.listSLSIM.removeAll()
                        self.header = ["ASM", "Khu Vực", "SL Sim", "SL Máy", "SL IPHONE"]
                        self.switchDetail.isEnabled = false
                        self.getTyleSlSimKhuVuc(username: self.username, token: self.token)
                        break
                    case "TyLeSLSIMShop":
                        self.title = "Báo cáo tỷ lệ sim theo shop"
                        self.listSLSIM.removeAll()
                        self.header = ["ASM", "Shop", "SL Sim", "SL Máy", "SL IPHONE"]
                        self.switchDetail.isEnabled = false
                        self.getTyleSlSimShop(username: self.username, token: self.token)
                        break
                    default:
                        break
                }
            }
        }
    }
        ///GET DATA

    func getSlSimVung(username: String, token: String) {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            let data = mSMApiManager.getSL_SIM_Vung(username: username, token: token).Data
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if data != nil {
                    self.listSLSIM = data ?? []
                    if self.listSLSIM.count > 0 {
                        if self.switchDetail.isOn {
                            self.generateDetailSLSimVung(self.listSLSIM)
                        } else {
                            self.generateSLSimVung(self.listSLSIM)
                        }
                        self.reportCollectionView.removeFromSuperview()
                        self.SetUpCollectionView()
                        self.switchDetail.isEnabled = true
                    }
                } else {
                    let alertVC = UIAlertController(title: "Thông báo", message: "Không lấy được data!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertVC.addAction(action)
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
    }

    func getSlSimKhuVuc(username: String, token: String) {
        cellData = [[String]]()
        let data = mSMApiManager.getSL_SIM_khuvuc(username: username, token: token).Data
        WaitingNetworkResponseAlert.DismissWaitingAlert {
            if data != nil {
                self.listSLSIM = data ?? []
                if self.listSLSIM.count > 0 {
                    if self.switchDetail.isOn{
                        self.generateDetailSLSimKhuvuc(self.listSLSIM)
                    } else {
                        self.generateSLSimKhuvuc(self.listSLSIM)
                    }
                    self.reportCollectionView.removeFromSuperview()
                    self.SetUpCollectionView()
                    self.switchDetail.isEnabled = true
                }
            } else {
                let alertVC = UIAlertController(title: "Thông báo", message: "Không lấy được data!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertVC.addAction(action)
                self.present(alertVC, animated: true, completion: nil)
            }

        }
    }

    func getSlSimShop(username: String, token: String) {
        cellData = [[String]]()
        let data = mSMApiManager.getSL_SIM_Shop(username: username, token: token).Data
        WaitingNetworkResponseAlert.DismissWaitingAlert {
            if data != nil {
                self.listSLSIM = data ?? []
                if self.listSLSIM.count > 0 {
                    if self.switchDetail.isOn{
                        self.generateDetailSLSimShop(self.listSLSIM)
                    } else {
                        self.generateSLSimShop(self.listSLSIM)
                    }
                    self.reportCollectionView.removeFromSuperview()
                    self.SetUpCollectionView()
                    self.switchDetail.isEnabled = true
                }
            } else {
                let alertVC = UIAlertController(title: "Thông báo", message: "Không lấy được data!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertVC.addAction(action)
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }

        /// TYLE SL SIM
    func getTyleSlSimVung(username: String, token: String) {
        cellData = [[String]]()
        let data = mSMApiManager.getTyLe_SIM_Vung(username: username, token: token).Data
        WaitingNetworkResponseAlert.DismissWaitingAlert {
            if data != nil {
                self.listSLSIM = data ?? []
                if self.listSLSIM.count > 0 {
                    if self.switchDetail.isOn{
                        self.generateDetailTyLeSimVung(self.listSLSIM )
                    } else {
                        self.generateTyLeSimVung(self.listSLSIM )
                    }
                    self.reportCollectionView.removeFromSuperview()
                    self.SetUpCollectionView()
                    self.switchDetail.isEnabled = true
                }
            } else {
                let alertVC = UIAlertController(title: "Thông báo", message: "Không lấy được data!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertVC.addAction(action)
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }

    func getTyleSlSimKhuVuc(username: String, token: String) {
        cellData = [[String]]()
        let data = mSMApiManager.getTyLe_SIM_Khuvuc(username: username, token: token).Data
        WaitingNetworkResponseAlert.DismissWaitingAlert {
            if data != nil {
                self.listSLSIM = data ?? []
                if self.listSLSIM.count > 0 {
                    if self.switchDetail.isOn{
                        self.generateDetailTyLeSimKhuvuc(self.listSLSIM)
                    } else {
                        self.generateTyLeSimKhuvuc(self.listSLSIM)
                    }
                    self.reportCollectionView.removeFromSuperview()
                    self.SetUpCollectionView()
                    self.switchDetail.isEnabled = true
                }
            } else {
                let alertVC = UIAlertController(title: "Thông báo", message: "Không lấy được data!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertVC.addAction(action)
                self.present(alertVC, animated: true, completion: nil)
            }

        }
    }

    func getTyleSlSimShop(username: String, token: String) {
        cellData = [[String]]()
        let data = mSMApiManager.getTyLe_SIM_Shop(username: username, token: token).Data
        WaitingNetworkResponseAlert.DismissWaitingAlert {
            if data != nil {
                self.listSLSIM = data ?? []
                if self.listSLSIM.count > 0 {
                    if self.switchDetail.isOn{
                        self.generateDetailTyLeSimShop(self.listSLSIM)
                    } else {
                        self.generateTyLeSimShop(self.listSLSIM)
                    }
                    self.reportCollectionView.removeFromSuperview()
                    self.SetUpCollectionView()
                    self.switchDetail.isEnabled = true
                }
            } else {
                let alertVC = UIAlertController(title: "Thông báo", message: "Không lấy được data!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertVC.addAction(action)
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }

    func generateSLSimVung(_ data:[SLSIM]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.Vung)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_SIM))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_DienThoai))",
                "\(item.SLMay_Iphone)"
            ]);
        }
    }

    func generateSLSimKhuvuc(_ data:[SLSIM]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.ASM)",
                "\(item.KhuVuc)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_SIM))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_DienThoai))",
                "\(item.SLMay_Iphone)"
            ]);
        }
    }

    func generateSLSimShop(_ data:[SLSIM]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.TenASM)",
                "\(item.TenShop)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_SIM))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_DienThoai))",
                "\(item.SLMay_Iphone)"
            ]);
        }
    }

    func generateTyLeSimVung(_ data:[SLSIM]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.Vung)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_SIM))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_DienThoai))",
                "\(item.SLMay_Iphone)"
            ]);
        }
    }

    func generateTyLeSimKhuvuc(_ data:[SLSIM]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.ASM)",
                "\(item.KhuVuc)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_SIM))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_DienThoai))",
                "\(item.SLMay_Iphone)"
            ]);
        }
    }

    func generateTyLeSimShop(_ data:[SLSIM]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.TenASM)",
                "\(item.TenShop)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_SIM))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_DienThoai))",
                "\(item.SLMay_Iphone)"
            ]);
        }
    }

        ///--GENERATE DETAIL DATA-----------------------
    func generateDetailSLSimVung(_ data:[SLSIM]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.Vung)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_SIM))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_DienThoai))",
                "\(Common.convertCurrencyV2(value: item.SLMay_Iphone))",
                "\(item.TyLe)",
                "\(item.TyLe_ESIM_MBF_RT)",
                "\(item.TyLe_MBF)",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Mobifone))",
                "\(Common.convertCurrencyV2(value: item.SL_ESIM_Mobifone))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_ITel))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Vietnamobile))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Viettel))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Vinaphone))",
            ]);
        }
    }

    func generateDetailSLSimKhuvuc(_ data:[SLSIM]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.ASM)",
                "\(item.KhuVuc)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_SIM))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_DienThoai))",
                "\(Common.convertCurrencyV2(value: item.SLMay_Iphone))",
                "\(item.TyLe)",
                "\(item.TyLe_ESIM_MBF_RT)",
                "\(item.TyLe_MBF)",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Mobifone))",
                "\(Common.convertCurrencyV2(value: item.SL_ESIM_Mobifone))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_ITel))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Vietnamobile))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Viettel))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Vinaphone))",
            ]);
        }
    }

    func generateDetailSLSimShop(_ data:[SLSIM]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.TenVung)",
                "\(item.TenASM)",
                "\(item.TenShop)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_SIM))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_DienThoai))",
                "\(Common.convertCurrencyV2(value: item.SLMay_Iphone))",
                "\(item.TyLe)",
                "\(item.TyLe_ESIM_MBF_RT)",
                "\(item.TyLe_MBF)",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Mobifone))",
                "\(Common.convertCurrencyV2(value: item.SL_ESIM_Mobifone))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_ITel))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Vietnamobile))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Viettel))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Vinaphone))",
            ]);
        }
    }

        // TYLE SL SIM
    func generateDetailTyLeSimVung(_ data:[SLSIM]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.Vung)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_SIM))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_DienThoai))",
                "\(Common.convertCurrencyV2(value: item.SLMay_Iphone))",
                "\(item.TyLe)",
                "\(item.TyLe_ESIM_MBF)",
                "\(item.TyLeCungKy)",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Mobifone))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_ESIM_Mobifone))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_ITel))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Vietnamobile))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Viettel))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Vinaphone))",
            ]);
        }
    }

    func generateDetailTyLeSimKhuvuc(_ data:[SLSIM]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.ASM)",
                "\(item.KhuVuc)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_SIM))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_DienThoai))",
                "\(Common.convertCurrencyV2(value: item.SLMay_Iphone))",
                "\(item.TyLe)",
                "\(item.TyLe_ESIM_MBF)",
                "\(item.TyLeCungKy)",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Mobifone))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_ESIM_Mobifone))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_ITel))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Vietnamobile))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Viettel))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Vinaphone))"
            ]);
        }
    }

    func generateDetailTyLeSimShop(_ data:[SLSIM]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.TenASM)",
                "\(item.TenShop)",
                "\(Common.convertCurrencyV2(value: item.SoLuong_SIM))",
                "\(Common.convertCurrencyV2(value: item.SoLuong_DienThoai))",
                "\(Common.convertCurrencyV2(value: item.SLMay_Iphone))",
                "\(item.TyLe)",
                "\(item.TyLe_ESIM_MBF)",
                "\(item.TyLeCungKy)",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Mobifone))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_ESIM_Mobifone))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_ITel))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Vietnamobile))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Viettel))",
                "\(Common.convertCurrencyV2(value: item.SLSIM_Vinaphone))",
            ]);
        }
        print(data)

    }

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
        collectionViewLayout.numberColumnFixed = 3

        self.reportCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height)), collectionViewLayout: collectionViewLayout);

        self.reportCollectionView.delegate = self;
        self.reportCollectionView.dataSource = self;
        self.reportCollectionView.showsHorizontalScrollIndicator = true;
        self.reportCollectionView.backgroundColor = UIColor.white;
        self.view.bringSubviewToFront(reportCollectionView);
        self.reportCollectionView.register(ReportDataCollectionViewCell.self, forCellWithReuseIdentifier: "cell");
        self.view.addSubview(self.reportCollectionView)

        if(cellData.count == 0){
            let emptyView = Bundle.main.loadNibNamed("EmptyDataView", owner: nil, options: nil)![0] as! UIView;
            emptyView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height);
            self.view.addSubview(emptyView);
        }
        self.navigationController?.navigationBar.isTranslucent = false;

    }
    @objc func ExportFile() {
        mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        switch self.comboPKType {
            case "ReportSLSIMVung":
                self.exportReportSLSIMVung(reportName: "ReportSLSIMVung")
                break

            case "ReportSLSIMKhuvuc" :
                self.exportReportSLSIMKhuvuc(reportName: "ReportSLSIMKhuvuc")
                break

            case "ReportSLSIMShop" :
                self.exportReportSLIMShop(reportName: "ReportSLSIMShop")
                break
                    ///LUY KE DS MAY
            case "TyLeSLSIMVung":
                self.exportReportTyLeSIMVung(reportName: "TyLeSLSIMVung")
                break

            case  "TyLeSLSIMKhuvuc":
                self.exportReportTyLeSIMKhuvuc(reportName: "TyLeSLSIMKhuvuc")
                break

            case "TyLeSLSIMShop":
                self.exportReportTyLeSIMShop(reportName: "TyLeSLSIMShop")
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
    func exportReportSLSIMVung(reportName: String){
        let path = NSTemporaryDirectory() + "\(reportName).csv"

            //generate contents of file
        let data = self.listSLSIM
        let header = ["STT",
                      "Vùng", "SL Sim", "SL Máy","SL IPHONE","Sim/Máy","esim MBF/ Iphone","Tỉ lệ MBF/Máy",
                      "MBF","eSim MBF", "ITEL", "VNMB", "Viettel","Vinaphone"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.STT)\t\(item.Vung)\t\(item.SoLuong_SIM)\t\(item.SoLuong_DienThoai)\t\(item.SLMay_Iphone)\t\(item.TyLe)\t\(item.TyLe_ESIM_MBF_RT)\t\(item.TyLe_MBF)\t\(item.SLSIM_Mobifone)\t\(item.SL_ESIM_Mobifone)\t\(item.SLSIM_ITel)\t\(item.SLSIM_Vietnamobile)\t\(item.SLSIM_Viettel)\t\(item.SLSIM_Vinaphone)"
        }
        self.writeFile(path: path, content: content, reportName: reportName)
    }

        ///KHU VUC
    func exportReportSLSIMKhuvuc(reportName: String){
        let path = NSTemporaryDirectory() + "\(reportName).csv"

            //generate contents of file
        let data = self.listSLSIM
        let header = ["STT",
                      "ASM", "Khu Vực",
                      "SL Sim", "SL Máy","SL IPHONE","Sim/Máy","esim MBF/ Iphone","Tỉ lệ MBF/Máy",
                      "MBF","eSim MBF", "ITEL", "VNMB", "Viettel","Vinaphone"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.STT)\t\(item.ASM)\t\(item.KhuVuc)\t\(item.SoLuong_SIM)\t\(item.SoLuong_DienThoai)\t\(item.SLMay_Iphone)\t\(item.TyLe)\t\(item.TyLe_ESIM_MBF_RT)\t\(item.TyLe_MBF)\t\(item.SLSIM_Mobifone)\t\(item.SL_ESIM_Mobifone)\t\(item.SLSIM_ITel)\t\(item.SLSIM_Vietnamobile)\t\(item.SLSIM_Viettel)\t\(item.SLSIM_Vinaphone)"

        }
        self.writeFile(path: path, content: content, reportName: reportName)
    }

        ///SHOP
    func exportReportSLIMShop(reportName: String){
        let path = NSTemporaryDirectory() + "\(reportName).csv"

            //generate contents of file
        let data = self.listSLSIM
        let header = ["STT", "ASM", "Shop", "SL Sim", "SL Máy","SL IPHONE","Sim/Máy","esim MBF/ Iphone","Tỉ lệ MBF/Máy",
                      "MBF","eSim MBF", "ITEL", "VNMB", "Viettel","Vinaphone"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.STT)\t\(item.TenASM)\t\(item.TenShop)\t\(item.SoLuong_SIM)\t\(item.SoLuong_DienThoai)\t\(item.SLMay_Iphone)\t\(item.TyLe)\t\(item.TyLe_ESIM_MBF_RT)\t\(item.TyLe_MBF)\t\(item.SLSIM_Mobifone)\t\(item.SL_ESIM_Mobifone)\t\(item.SLSIM_ITel)\t\(item.SLSIM_Vietnamobile)\t\(item.SLSIM_Viettel)\t\(item.SLSIM_Vinaphone)"
        }
        self.writeFile(path: path, content: content, reportName: reportName)
    }

        /// export tyle sim
        ///VUNG
    func exportReportTyLeSIMVung(reportName: String){
        let path = NSTemporaryDirectory() + "\(reportName).csv"

            //generate contents of file
        let data = self.listSLSIM
        let header = ["STT","Vùng", "SL Sim", "SL Máy","SL IPHONE","Sim/Máy","esim MBF/ Iphone","Tỉ lệ MBF/Máy",
         "MBF","eSim MBF", "ITEL", "VNMB", "Viettel","Vinaphone"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.STT)\t\(item.Vung)\t\(item.SoLuong_SIM)\t\(item.SoLuong_DienThoai)\t\(item.SLMay_Iphone)\t\(item.TyLe)\t\(item.TyLe_ESIM_MBF)\t\(item.TyLeCungKy)\t\(item.SLSIM_Mobifone)\t\(item.SLSIM_ESIM_Mobifone)\t\(item.SLSIM_ITel)\t\(item.SLSIM_Vietnamobile)\t\(item.SLSIM_Viettel)\t\(item.SLSIM_Vinaphone)"
        }
        self.writeFile(path: path, content: content, reportName: reportName)
    }

        ///KHU VUC
    func exportReportTyLeSIMKhuvuc(reportName: String){
        let path = NSTemporaryDirectory() + "\(reportName).csv"

            //generate contents of file
        let data = self.listSLSIM

        let header = ["STT","ASM", "Khu Vực", "SL Sim", "SL Máy","SL IPHONE","Sim/Máy","esim MBF/ Iphone","Tỉ lệ MBF/Máy",
                      "MBF","eSim MBF", "ITEL", "VNMB", "Viettel","Vinaphone"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.STT)\t\(item.ASM)\t\(item.KhuVuc)\t\(item.SoLuong_SIM)\t\(item.SoLuong_DienThoai)\t\(item.SLMay_Iphone)\t\(item.TyLe)\t\(item.TyLe_ESIM_MBF)\t\(item.TyLeCungKy)\t\(item.SLSIM_Mobifone)\t\(item.SLSIM_ESIM_Mobifone)\t\(item.SLSIM_ITel)\t\(item.SLSIM_Vietnamobile)\t\(item.SLSIM_Viettel)\t\(item.SLSIM_Vinaphone)"
        }
        self.writeFile(path: path, content: content, reportName: reportName)
    }

        ///SHOP
    func exportReportTyLeSIMShop(reportName: String){
        let path = NSTemporaryDirectory() + "\(reportName).csv"

            //generate contents of file
        let data = self.listSLSIM
        let header = ["STT", "ASM", "Shop", "SL Sim", "SL Máy","SL IPHONE","Sim/Máy","esim MBF/ Iphone","Tỉ lệ MBF/Máy",
                      "MBF","eSim MBF", "ITEL", "VNMB", "Viettel","Vinaphone"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.STT)\t\(item.TenASM)\t\(item.TenShop)\t\(item.SoLuong_SIM)\t\(item.SoLuong_DienThoai)\t\(item.SLMay_Iphone)\t\(item.TyLe)\t\(item.TyLe_ESIM_MBF)\t\(item.TyLeCungKy)\t\(item.SLSIM_Mobifone)\t\(item.SLSIM_ESIM_Mobifone)\t\(item.SLSIM_ITel)\t\(item.SLSIM_Vietnamobile)\t\(item.SLSIM_Viettel)\t\(item.SLSIM_Vinaphone)"
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
                switch self.comboPKType {
                    case "ReportSLSIMVung":
                        if indexPath.row == 0 {
                            cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                        } else {
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                        }

                        cell.layer.borderWidth = 0.5;
                        cell.layer.borderColor = UIColor.darkGray.cgColor;
                        break
                    case "ReportSLSIMKhuvuc" :
                        if indexPath.row == 0 || indexPath.row == 1 {
                            cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                        } else {
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                        }

                        cell.layer.borderWidth = 0.5;
                        cell.layer.borderColor = UIColor.darkGray.cgColor;
                        break

                    case "ReportSLSIMShop" :
                        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2{
                            cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                        } else {
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                        }

                        cell.layer.borderWidth = 0.5;
                        cell.layer.borderColor = UIColor.darkGray.cgColor;
                        break

                            //----

                    case "TyLeSLSIMVung":
                        if indexPath.row == 0 {
                            cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                        } else {
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                        }
                        cell.layer.borderWidth = 0.5;
                        cell.layer.borderColor = UIColor.darkGray.cgColor;
                        break

                    case "TyLeSLSIMKhuvuc":
                        if indexPath.row == 0 || indexPath.row == 1 {
                            cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                        } else {
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                        }
                        cell.layer.borderWidth = 0.5;
                        cell.layer.borderColor = UIColor.darkGray.cgColor;
                        break

                    case "TyLeSLSIMShop":
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
