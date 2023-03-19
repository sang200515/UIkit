//
//  ShopVisitorDetailViewController.swift
//  fptshop
//
//  Created by Apple on 8/2/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import Presentr

class ShopVisitorDetailViewController: UIViewController, UISearchBarDelegate {
    
    var lbShopName: UILabel!
    var tfFromDate:UITextField!
    var tfToDate:UITextField!
    static var valueToDate:String = ""
    static var valueFromDate:String = ""
    var shop: Shop?
    var chooseTfDate = ""
    
    var btnSearch: UIBarButtonItem!
    var searchBarContainer:SearchBarContainerView!
    
    var imgCheckCungKyThangTruoc: UIImageView!
    var imgCheckCungKyNamTruoc: UIImageView!
    static var isCheckCungKyThangTruoc : Bool = true
    static var isCheckCungKyNamTruoc : Bool = false
    
    var listVisitorV2: [Visitor_Report_V2] = []
    var reportCollectionView: UICollectionView!
    var cellData: [[String]] = [];
    var tempHeaderForSize: [String] = [];
    var headerShopNamTruoc = [String]()
    var headerShopThangTruoc = [String]()
    
    let presenter: Presentr = {
        let dynamicType = PresentationType.dynamic(center: ModalCenterPosition.center)
        let customPresenter = Presentr(presentationType: dynamicType)
        customPresenter.backgroundOpacity = 0.3
        customPresenter.roundCorners = true
        customPresenter.dismissOnSwipe = false
        customPresenter.dismissAnimated = false
        //        customPresenter.backgroundTap = .noAction
        return customPresenter
    }()
    
    var headerShopFull = ["Shop","Traffic\nHiện Tại","Traffic Cùng kỳ\ntháng trước","Traffic Cùng kỳ\nnăm trước","Traffic\n10 ngày trước","SO hiện tại","CRM hiện tại","SO cùng kỳ\ntháng trước","SO cùng kỳ\nnăm trước","CRM cùng kỳ\ntháng trước","CRM cùng kỳ\nnăm trước","SO\n10 ngày trước","CRM\n10 ngày trước", "Tỷ lệ\nHiện tại", "Tỷ lệ Cùng kỳ\ntháng trước", "Tỷ lệ Cùng kỳ \nnăm trước", "Tỷ lệ\n10 ngày trước"]
    
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
            case .portrait:
                self.view.subviews.forEach({ $0.removeFromSuperview() });
                //                self.SetUpCollectionView();
                self.setUpView()
                self.tfFromDate.text = ShopVisitorDetailViewController.valueFromDate
                self.tfToDate.text = ShopVisitorDetailViewController.valueToDate
                
                self.loadVisitorReportTheoDoiShop()
            case .landscapeLeft,.landscapeRight :
                self.view.subviews.forEach({ $0.removeFromSuperview() });
                //                self.SetUpCollectionView();
                self.setUpView()
                self.tfFromDate.text = ShopVisitorDetailViewController.valueFromDate
                self.tfToDate.text = ShopVisitorDetailViewController.valueToDate
                self.loadVisitorReportTheoDoiShop()
            default:
                print("Upside down, and that is not supported");
            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in})
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //set up navigationbarItem
        
        btnSearch = UIBarButtonItem(image: #imageLiteral(resourceName: "Search"), style: .plain, target: self, action: #selector(actionSearchAssets))
        
        self.navigationItem.rightBarButtonItem = btnSearch
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initNavigationBar()
        self.title = "BC Visitor theo shop"
        self.view.backgroundColor = .white
        //--
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
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
        
        
        self.setUpView()
        self.loadVisitorReportTheoDoiShop()

    }
    
    func setUpView() {
        headerShopNamTruoc.removeAll()
        headerShopThangTruoc.removeAll()
        
        //set headerShop
        for i in headerShopFull {
            if i.contains("năm trước") == false {
                headerShopThangTruoc.append(i)
            }
        }
        for i in headerShopFull {
            if i.contains("tháng trước") == false {
                headerShopNamTruoc.append(i)
            }
        }
        
        let lbTextFromDate = UILabel(frame: CGRect(x: 15, y: 15, width: (UIScreen.main.bounds.size.width - 45)/2, height: 15))
        lbTextFromDate.textAlignment = .left
        lbTextFromDate.textColor = UIColor.black
        lbTextFromDate.font = UIFont.systemFont(ofSize:13)
        lbTextFromDate.text = "Thời gian từ (*)"
        self.view.addSubview(lbTextFromDate)
        
        tfFromDate = UITextField(frame: CGRect(x: lbTextFromDate.frame.origin.x, y: lbTextFromDate.frame.origin.y + lbTextFromDate.frame.size.height + 5, width: lbTextFromDate.frame.size.width, height: 35))
        tfFromDate.placeholder = "Chọn ngày"
        tfFromDate.font = UIFont.systemFont(ofSize: 13)
        tfFromDate.borderStyle = UITextField.BorderStyle.roundedRect
        tfFromDate.autocorrectionType = UITextAutocorrectionType.no
        tfFromDate.keyboardType = UIKeyboardType.default
        tfFromDate.returnKeyType = UIReturnKeyType.done
        tfFromDate.clearButtonMode = UITextField.ViewMode.whileEditing
        tfFromDate.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        //        tfFromDate.delegate = self
        tfFromDate.isUserInteractionEnabled = false
        
        let fromdate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let fromDateStr = dateFormatter.string(from: fromdate)
        tfFromDate.text = fromDateStr
//        ShopVisitorDetailViewController.valueFromDate = fromDateStr
        self.view.addSubview(tfFromDate)
        
        let viewFromDate: UIView = UIView(frame: tfFromDate.frame)
        self.view.addSubview(viewFromDate)
        
        let viewFromDateImage: UIImageView = UIImageView(frame: CGRect(x: viewFromDate.frame.size.width - viewFromDate.frame.size.height, y: viewFromDate.frame.size.height/4, width: viewFromDate.frame.size.height, height: viewFromDate.frame.size.height/2))
        viewFromDateImage.image = UIImage(named:"Calender2")
        viewFromDateImage.contentMode = .scaleAspectFit
        viewFromDate.addSubview(viewFromDateImage)
        
        let tapFromDate = UITapGestureRecognizer(target: self, action: #selector(self.handleTapFromDate(_:)))
        viewFromDate.addGestureRecognizer(tapFromDate)
        
        let lbTextToDate = UILabel(frame: CGRect(x: lbTextFromDate.frame.size.width + lbTextFromDate.frame.origin.x + 15, y: lbTextFromDate.frame.origin.y, width: lbTextFromDate.frame.size.width, height: 15))
        lbTextToDate.textAlignment = .left
        lbTextToDate.textColor = UIColor.black
        lbTextToDate.font = UIFont.systemFont(ofSize: 13)
        lbTextToDate.text = "Thời gian đến (*)"
        self.view.addSubview(lbTextToDate)
        
        tfToDate = UITextField(frame: CGRect(x: lbTextToDate.frame.origin.x, y: lbTextToDate.frame.origin.y + lbTextToDate.frame.size.height + 5, width: lbTextToDate.frame.size.width, height: 35))
        tfToDate.placeholder = "Chọn ngày"
        tfToDate.font = UIFont.systemFont(ofSize: 13)
        tfToDate.borderStyle = UITextField.BorderStyle.roundedRect
        tfToDate.autocorrectionType = UITextAutocorrectionType.no
        tfToDate.keyboardType = UIKeyboardType.default
        tfToDate.returnKeyType = UIReturnKeyType.done
        tfToDate.clearButtonMode = UITextField.ViewMode.whileEditing
        tfToDate.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        //        tfToDate.delegate = self
        tfToDate.isUserInteractionEnabled = false
        
        let todate = Date()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let toDateStr = dateFormatter.string(from: todate)
        tfToDate.text = toDateStr
//        ShopVisitorDetailViewController.valueToDate = toDateStr
        self.view.addSubview(tfToDate)
        
        let viewToDate: UIView = UIView(frame: tfToDate.frame)
        self.view.addSubview(viewToDate)
        
        let viewToDateImage: UIImageView = UIImageView(frame: CGRect(x: viewFromDate.frame.size.width - viewFromDate.frame.size.height, y: viewFromDate.frame.size.height/4, width: viewFromDate.frame.size.height, height: viewFromDate.frame.size.height/2))
        viewToDateImage.image = UIImage(named:"Calender2")
        viewToDateImage.contentMode = .scaleAspectFit
        viewToDate.addSubview(viewToDateImage)
        
        let tapToDate = UITapGestureRecognizer(target: self, action: #selector(self.handleTapToDate(_:)))
        viewToDate.addGestureRecognizer(tapToDate)
        
        
        ///checkbox
        let lbCheckCungKyThangTruoc = UILabel(frame: CGRect(x: 45, y: tfToDate.frame.origin.y + tfToDate.frame.height + 10, width: self.view.frame.width - 45 - 15, height: 25))
        lbCheckCungKyThangTruoc.text = "Cùng kỳ tháng trước"
        //        lbCheckCungKyThangTruoc.font = UIFont(name:"Trebuchet MS",size:17)
        lbCheckCungKyThangTruoc.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(lbCheckCungKyThangTruoc)
        
        imgCheckCungKyThangTruoc = UIImageView(frame: CGRect(x: 15, y: lbCheckCungKyThangTruoc.frame.origin.y, width: 25, height:25))
        imgCheckCungKyThangTruoc.image = UIImage(named: "checkedBox")
        self.view.addSubview(imgCheckCungKyThangTruoc)
        
        let tapCheckCungKyThangTruoc = UITapGestureRecognizer(target: self, action: #selector(checkCungKyThangTruoc))
        imgCheckCungKyThangTruoc.isUserInteractionEnabled = true
        imgCheckCungKyThangTruoc.addGestureRecognizer(tapCheckCungKyThangTruoc)
        
        let lbCheckCungKyNamTruoc = UILabel(frame: CGRect(x: 45, y: lbCheckCungKyThangTruoc.frame.origin.y + lbCheckCungKyThangTruoc.frame.height + 10, width: lbCheckCungKyThangTruoc.frame.width, height: lbCheckCungKyThangTruoc.frame.height))
        lbCheckCungKyNamTruoc.text = "Cùng kỳ năm trước"
        lbCheckCungKyNamTruoc.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(lbCheckCungKyNamTruoc)
        
        imgCheckCungKyNamTruoc = UIImageView(frame: CGRect(x: 15, y: lbCheckCungKyNamTruoc.frame.origin.y, width: 25, height: 25))
        imgCheckCungKyNamTruoc.image = UIImage(named: "uncheck")
        self.view.addSubview(imgCheckCungKyNamTruoc)
        
        let tapCheckCungKyNamTruoc = UITapGestureRecognizer(target: self, action: #selector(checkCungKyNamTruoc))
        imgCheckCungKyNamTruoc.isUserInteractionEnabled = true
        imgCheckCungKyNamTruoc.addGestureRecognizer(tapCheckCungKyNamTruoc)
        
        if ShopVisitorDetailViewController.isCheckCungKyNamTruoc == true {
            imgCheckCungKyNamTruoc.image = UIImage(named: "checkedBox")
        } else {
            imgCheckCungKyNamTruoc.image = UIImage(named: "uncheck")
        }
        
        if ShopVisitorDetailViewController.isCheckCungKyThangTruoc == true {
            imgCheckCungKyThangTruoc.image = UIImage(named: "checkedBox")
        } else {
            imgCheckCungKyThangTruoc.image = UIImage(named: "uncheck")
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
        self.navigationItem.setRightBarButton(btnSearch, animated: true)
        search(key: "")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        search(key: "\(searchBar.text!)")
        self.navigationItem.setRightBarButton(btnSearch, animated: true)
        
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
        
        var list:[Visitor_Report_V2] = []
        list.removeAll()
        if(key.count > 0) {
            for item in self.listVisitorV2 {
                if ((item.Name?.lowercased().range(of: key.lowercased())) != nil) {
                    list.append(item)
                }
            }
            if ShopVisitorDetailViewController.isCheckCungKyThangTruoc && ShopVisitorDetailViewController.isCheckCungKyNamTruoc {
                self.generateDataTongHopFull(data: list)
            } else if ShopVisitorDetailViewController.isCheckCungKyNamTruoc {
                self.generateDataTongHopCungKyNAMTruoc(data: list)
            } else {
                self.generateDataTongHopCungKyTHANGTruoc(data: list)
            }
            
            self.reportCollectionView.reloadData()
            
        } else {
            if ShopVisitorDetailViewController.isCheckCungKyThangTruoc && ShopVisitorDetailViewController.isCheckCungKyNamTruoc {
                self.generateDataTongHopFull(data: self.listVisitorV2)
            } else if ShopVisitorDetailViewController.isCheckCungKyNamTruoc {
                self.generateDataTongHopCungKyNAMTruoc(data: self.listVisitorV2)
            } else {
                self.generateDataTongHopCungKyTHANGTruoc(data: self.listVisitorV2)
            }
            
            self.reportCollectionView.reloadData()
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.subviews.forEach({ $0.removeFromSuperview() });
        self.setUpView()
        self.tfFromDate.text = ShopVisitorDetailViewController.valueFromDate
        self.tfToDate.text = ShopVisitorDetailViewController.valueToDate
        self.loadVisitorReportTheoDoiShop()
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showShopList() {
        let newVC = ShowShopListVisitorViewController()
        newVC.delegate = self
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    
    @objc func checkCungKyThangTruoc() {
        ShopVisitorDetailViewController.isCheckCungKyThangTruoc = !ShopVisitorDetailViewController.isCheckCungKyThangTruoc
        imgCheckCungKyThangTruoc.image = UIImage(named: ShopVisitorDetailViewController.isCheckCungKyThangTruoc ? "checkedBox" : "uncheck")
        self.loadVisitorReportTheoDoiShop()
    }
    
    @objc func checkCungKyNamTruoc() {
        ShopVisitorDetailViewController.isCheckCungKyNamTruoc = !ShopVisitorDetailViewController.isCheckCungKyNamTruoc
        imgCheckCungKyNamTruoc.image = UIImage(named: ShopVisitorDetailViewController.isCheckCungKyNamTruoc ? "checkedBox" : "uncheck")
        self.loadVisitorReportTheoDoiShop()
    }
    
    
    @objc func handleTapToDate(_ sender: UITapGestureRecognizer? = nil) {

        self.chooseTfDate = "ToDate"
        let calendarVC = CalendarViewController()
        self.customPresentViewController(presenter, viewController: calendarVC, animated: true)
        calendarVC.delegate = self
//        self.present(calendarVC, animated: true, completion: nil)
    }
    
    
    @objc func handleTapFromDate(_ sender: UITapGestureRecognizer? = nil) {

        
        self.chooseTfDate = "FromDate"
        let calendarVC = CalendarViewController()
        self.customPresentViewController(presenter, viewController: calendarVC, animated: true)
        calendarVC.delegate = self
//        self.present(calendarVC, animated: true, completion: nil)
    }
    
    
        func loadVisitorReportTheoDoiShop() {
            self.listVisitorV2.removeAll()
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                self.listVisitorV2 = mSMApiManager.Report_FRT_SP_Visitor_Report_TheoDoiShop(TypeReport: "", TypeView: "", FromDate: self.tfFromDate.text ?? "", ToDate: self.tfToDate.text ?? "", MaShop: "\(self.shop?.ShopCode ?? "")").Data ?? []
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if self.listVisitorV2.count > 0 {
                        if ShopVisitorDetailViewController.isCheckCungKyThangTruoc && ShopVisitorDetailViewController.isCheckCungKyNamTruoc {
                            self.generateDataTongHopFull(data: self.listVisitorV2)
                        } else if ShopVisitorDetailViewController.isCheckCungKyNamTruoc {
                            self.generateDataTongHopCungKyNAMTruoc(data: self.listVisitorV2)
                        } else {
                            self.generateDataTongHopCungKyTHANGTruoc(data: self.listVisitorV2)
                        }
                    } else {
                        debugPrint("Không tìm thấy báo cáo.")
                    }
    
                    if self.reportCollectionView != nil {
                        self.reportCollectionView.removeFromSuperview()
                    }
                    self.SetUpCollectionView()
    
                }
            }
        }
    
    func generateDataTongHopFull(data: [Visitor_Report_V2]) {
        
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.Name ?? "")",
                "\(Common.convertCurrencyV2(value: item.Count_Visitor_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_Visitor_LastMonth ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_Visitor_LastYear ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_Visitor_LastTenDay ?? 0))",
                
                "\(Common.convertCurrencyV2(value: item.Count_SO_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_ThuHo_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_SO_LastMonth ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_SO_LastYear ?? 0))",
                
                "\(Common.convertCurrencyV2(value: item.Count_ThuHo_LastMonth ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_ThuHo_LastYear ?? 0))",
                
                "\(Common.convertCurrencyV2(value: item.Count_SO_LastTenDay ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_ThuHo_LastTenDay ?? 0))",
                
                "\(Common.convertCurrencyV2(value: item.TiLe_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.TiLe_LastMonth ?? 0))",
                "\(Common.convertCurrencyV2(value: item.TiLe_LastYear ?? 0))",
                "\(Common.convertCurrencyV2(value: item.TiLe_LastTenDay ?? 0))"
                ]);
        }
    }
    
    func generateDataTongHopCungKyTHANGTruoc(data: [Visitor_Report_V2]) {
        
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.Name ?? "")",
                "\(Common.convertCurrencyV2(value: item.Count_Visitor_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_Visitor_LastMonth ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_Visitor_LastTenDay ?? 0))",
                
                "\(Common.convertCurrencyV2(value: item.Count_SO_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_ThuHo_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_SO_LastMonth ?? 0))",
                
                "\(Common.convertCurrencyV2(value: item.Count_ThuHo_LastMonth ?? 0))",
                
                "\(Common.convertCurrencyV2(value: item.Count_SO_LastTenDay ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_ThuHo_LastTenDay ?? 0))",
                
                "\(Common.convertCurrencyV2(value: item.TiLe_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.TiLe_LastMonth ?? 0))",
                "\(Common.convertCurrencyV2(value: item.TiLe_LastTenDay ?? 0))"
                ]);
        }
    }
    
    func generateDataTongHopCungKyNAMTruoc(data: [Visitor_Report_V2]) {
        
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.Name ?? "")",
                "\(Common.convertCurrencyV2(value: item.Count_Visitor_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_Visitor_LastYear ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_Visitor_LastTenDay ?? 0))",
                
                "\(Common.convertCurrencyV2(value: item.Count_SO_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_ThuHo_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_SO_LastYear ?? 0))",
                
                "\(Common.convertCurrencyV2(value: item.Count_ThuHo_LastYear ?? 0))",
                
                "\(Common.convertCurrencyV2(value: item.Count_SO_LastTenDay ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_ThuHo_LastTenDay ?? 0))",
                
                "\(Common.convertCurrencyV2(value: item.TiLe_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.TiLe_LastYear ?? 0))",
                "\(Common.convertCurrencyV2(value: item.TiLe_LastTenDay ?? 0))"
                ]);
        }
    }
    
    func SetUpCollectionView(){
        self.navigationController?.navigationBar.isTranslucent = true
        
        if ShopVisitorDetailViewController.isCheckCungKyThangTruoc && ShopVisitorDetailViewController.isCheckCungKyNamTruoc {
            self.tempHeaderForSize = self.headerShopFull
        } else if ShopVisitorDetailViewController.isCheckCungKyNamTruoc {
            self.tempHeaderForSize = self.headerShopNamTruoc
        } else {
            self.tempHeaderForSize = self.headerShopThangTruoc
        }
        
        
        //Setup cell size
        for i in 0..<cellData.count{
            for j in 0..<tempHeaderForSize.count{
                if("\(self.tempHeaderForSize[j])".count < "\(cellData[i][j])".count){
                    self.tempHeaderForSize[j] = "\(cellData[i][j])";
                }
            }
        }
        let collectionViewLayout = ReportLayout()
        collectionViewLayout.numberOfColumns = tempHeaderForSize.count;
        collectionViewLayout.titleArray = self.tempHeaderForSize;
        collectionViewLayout.numberColumnFixed = 1
        
//        let collectionViewY: CGFloat = imgCheckCungKyNamTruoc.frame.origin.y + imgCheckCungKyNamTruoc.frame.height + Common.Size(s: 15)
        let collectionViewY: CGFloat = imgCheckCungKyNamTruoc.frame.origin.y + imgCheckCungKyNamTruoc.frame.height + 15
        self.reportCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: collectionViewY, width: self.view.frame.size.width, height: self.view.frame.size.height - collectionViewY - (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height)), collectionViewLayout: collectionViewLayout);
        
        self.reportCollectionView.delegate = self;
        self.reportCollectionView.dataSource = self;
        self.reportCollectionView.showsHorizontalScrollIndicator = false;
        self.reportCollectionView.backgroundColor = UIColor.white;
        
        self.view.bringSubviewToFront(reportCollectionView);
        self.reportCollectionView.register(ReportDataCollectionViewCell.self, forCellWithReuseIdentifier: "cell");
        
        
        self.reportCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(self.reportCollectionView)
        
        if(cellData.count == 0){
            let emptyView = Bundle.main.loadNibNamed("EmptyDataView", owner: nil, options: nil)![0] as! UIView;
            emptyView.frame = CGRect(x: 0, y: collectionViewY, width: self.view.frame.size.width, height: reportCollectionView.frame.size.height);
            self.view.addSubview(emptyView);
        }
        self.navigationController?.navigationBar.isTranslucent = false;
        
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}



extension ShopVisitorDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cellData.count + 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if ShopVisitorDetailViewController.isCheckCungKyThangTruoc && ShopVisitorDetailViewController.isCheckCungKyNamTruoc {
            return headerShopFull.count
        } else if ShopVisitorDetailViewController.isCheckCungKyNamTruoc {
            return headerShopNamTruoc.count
        } else {
            return headerShopThangTruoc.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ReportDataCollectionViewCell;

        
        if ShopVisitorDetailViewController.isCheckCungKyThangTruoc && ShopVisitorDetailViewController.isCheckCungKyNamTruoc {
            if headerShopFull[indexPath.row].hasPrefix("Traffic") { //rgb(255, 153, 0)//cam
                cell.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1)
            } else if (headerShopFull[indexPath.row].hasPrefix("SO")) || (headerShopFull[indexPath.row].hasPrefix("CRM")) { //rgb(46, 184, 46)//lục
                cell.backgroundColor = UIColor(red: 46/255, green: 184/255, blue: 46/255, alpha: 1)
            } else if (headerShopFull[indexPath.row].hasPrefix("Tỷ lệ")) { //rgb(102, 179, 255)//duong
                cell.backgroundColor = UIColor(red: 102/255, green: 179/255, blue: 255/255, alpha: 1)
            } else {
                cell.backgroundColor = UIColor.white
            }
        } else if ShopVisitorDetailViewController.isCheckCungKyNamTruoc {
            
            if headerShopNamTruoc[indexPath.row].hasPrefix("Traffic") { //rgb(255, 153, 0)//cam
                cell.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1)
            } else if (headerShopNamTruoc[indexPath.row].hasPrefix("SO")) || (headerShopNamTruoc[indexPath.row].hasPrefix("CRM")) { //rgb(46, 184, 46)//lục
                cell.backgroundColor = UIColor(red: 46/255, green: 184/255, blue: 46/255, alpha: 1)
            } else if (headerShopNamTruoc[indexPath.row].hasPrefix("Tỷ lệ")) { //duong
                cell.backgroundColor = UIColor(red: 102/255, green: 179/255, blue: 255/255, alpha: 1)
            } else {
                cell.backgroundColor = UIColor.white
            }
        } else {
            
            if headerShopThangTruoc[indexPath.row].hasPrefix("Traffic") { //rgb(255, 153, 0)//cam
                cell.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1)
            } else if (headerShopThangTruoc[indexPath.row].hasPrefix("SO")) || (headerShopThangTruoc[indexPath.row].hasPrefix("CRM")) { //rgb(46, 184, 46)//lục
                cell.backgroundColor = UIColor(red: 46/255, green: 184/255, blue: 46/255, alpha: 1)
            } else if (headerShopThangTruoc[indexPath.row].hasPrefix("Tỷ lệ")) { //duong
                cell.backgroundColor = UIColor(red: 102/255, green: 179/255, blue: 255/255, alpha: 1)
            } else {
                cell.backgroundColor = UIColor.white
            }
        }
        
        
        
        if(tempHeaderForSize.count > 0 || cellData.count > 0 ){
            if(indexPath.section == 0){
                
                if ShopVisitorDetailViewController.isCheckCungKyThangTruoc && ShopVisitorDetailViewController.isCheckCungKyNamTruoc {
                    cell.setupHeader(item: headerShopFull[indexPath.row]);
                } else if ShopVisitorDetailViewController.isCheckCungKyNamTruoc {
                    cell.setupHeader(item: headerShopNamTruoc[indexPath.row]);
                } else {
                    cell.setupHeader(item: headerShopThangTruoc[indexPath.row]);
                }
                
//                cell.backgroundColor = UIColor.lightGray;
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
        return cell
    }
}

extension ShopVisitorDetailViewController:CalendarViewControllerDelegate {
    func getDate(dateString: String) {
        if self.chooseTfDate == "FromDate" {
            self.tfFromDate.text = "\(dateString)"
            ShopVisitorDetailViewController.valueFromDate = "\(dateString)"
            self.loadVisitorReportTheoDoiShop()
        }
        
        if self.chooseTfDate == "ToDate" {
            self.tfToDate.text = "\(dateString)"
            ShopVisitorDetailViewController.valueToDate = "\(dateString)"
            self.loadVisitorReportTheoDoiShop()
        }
    }
}

extension ShopVisitorDetailViewController: ShowShopListVisitorViewControllerDelegate {
    func chooseShop(shop: Shop) {
        self.shop = shop
        self.lbShopName.text = "\(self.shop?.ShopCode ?? "") - \(self.shop?.ShopName ?? "")"
    }
}
