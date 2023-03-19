//
//  DetailVisitorReportVC2.swift
//  fptshop
//
//  Created by Apple on 7/31/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Foundation
import DLRadioButton
import ActionSheetPicker_3_0
import Presentr

class DetailVisitorReportVC2: UIViewController, UISearchBarDelegate {
    
    static var TypeView:String = ""
    var TypeReport:String = "1"
    var btnSearch: UIBarButtonItem!
    var searchBarContainer:SearchBarContainerView!
    
    var radioVung:DLRadioButton!
    var radioKhuVuc:DLRadioButton!
    var radioShop:DLRadioButton!
    
    var tfFromDate:UITextField!
    var tfToDate:UITextField!
    static var valueToDate:String = ""
    static var valueFromDate:String = ""
    var shop: Shop?
    var chooseTfDate = ""
    
    var imgCheckCungKyThangTruoc: UIImageView!
    var imgCheckCungKyNamTruoc: UIImageView!
    static var isCheckCungKyThangTruoc : Bool = true
    static var isCheckCungKyNamTruoc : Bool = false
    
    var listVisitorV2: [Visitor_Report_V2] = []
    var reportCollectionView: UICollectionView!
    var cellData: [[String]] = [];
    var tempHeaderForSize: [String] = [];
    
    var headerVungNamTruoc = [String]()
    var headerVungThangTruoc = [String]()
    
    var headerKVNamTruoc = [String]()
    var headerKVThangTruoc = [String]()
    
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
    
//Vùng
//    Trafic Hiện Tại    Trafic Cùng kỳ tháng trước    TrafficCùng kỳ năm trước    Traffic10 ngày trước đó
//    SO hiện tại    CRM hiện tại
//    SO cùng kỳ tháng trước    SO cùng kỳ năm trước
//    CRM cùng kỳ tháng trước    CRM cùng kỳ năm trước
//    SO 10 ngày trước    CRM 10 ngày trước
//    Tỷ lệ Hiện tại    Tỷ lệ Cùng kỳ tháng trước    Tỷ lệ Cùng kỳ năm trước    Tỷ lệ 10 ngày trước
    
    
    //tong hợp
    var headerVungFull = ["Vùng","Traffic\nHiện Tại", "Traffic\nTrung bình","Traffic Cùng kỳ\ntháng trước","Traffic Cùng kỳ\nnăm trước","Traffic\n10 ngày trước","SO hiện tại", "SO Trung bình","CRM hiện tại", "CRM Trung bình","SO cùng kỳ\ntháng trước","SO cùng kỳ\nnăm trước","CRM cùng kỳ\ntháng trước","CRM cùng kỳ\nnăm trước","SO\n10 ngày trước","CRM\n10 ngày trước", "Tỷ lệ\nHiện tại", "Tỷ lệ Cùng kỳ\ntháng trước", "Tỷ lệ Cùng kỳ \nnăm trước", "Tỷ lệ\n10 ngày trước"]
    
    var headerKhuVucFull = ["KhuVực","Traffic\nHiện Tại", "Traffic\nTrung bình","Traffic Cùng kỳ\ntháng trước","Traffic Cùng kỳ\nnăm trước","Traffic\n10 ngày trước","SO hiện tại", "SO Trung bình","CRM hiện tại", "CRM Trung bình","SO cùng kỳ\ntháng trước","SO cùng kỳ\nnăm trước","CRM cùng kỳ\ntháng trước","CRM cùng kỳ\nnăm trước","SO\n10 ngày trước","CRM\n10 ngày trước", "Tỷ lệ\nHiện tại", "Tỷ lệ Cùng kỳ\ntháng trước", "Tỷ lệ Cùng kỳ \nnăm trước", "Tỷ lệ\n10 ngày trước"]
    
    var headerShopFull = ["Shop","Traffic\nHiện Tại","Traffic Cùng kỳ\ntháng trước","Traffic Cùng kỳ\nnăm trước","Traffic\n10 ngày trước","SO hiện tại","CRM hiện tại","SO cùng kỳ\ntháng trước","SO cùng kỳ\nnăm trước","CRM cùng kỳ\ntháng trước","CRM cùng kỳ\nnăm trước","SO\n10 ngày trước","CRM\n10 ngày trước", "Tỷ lệ\nHiện tại", "Tỷ lệ Cùng kỳ\ntháng trước", "Tỷ lệ Cùng kỳ \nnăm trước", "Tỷ lệ\n10 ngày trước"]
    
    //-----
    
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
                self.setUpView()
                self.tfFromDate.text = DetailVisitorReportVC2.valueFromDate
                self.tfToDate.text = DetailVisitorReportVC2.valueToDate
                self.loadVisitorReportV2()
            case .landscapeLeft,.landscapeRight :
                self.view.subviews.forEach({ $0.removeFromSuperview() });
                self.setUpView()
                self.tfFromDate.text = DetailVisitorReportVC2.valueFromDate
                self.tfToDate.text = DetailVisitorReportVC2.valueToDate
                self.loadVisitorReportV2()
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
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.subviews.forEach({ $0.removeFromSuperview() });
        self.setUpView()
        self.tfFromDate.text = DetailVisitorReportVC2.valueFromDate
        self.tfToDate.text = DetailVisitorReportVC2.valueToDate
        self.loadVisitorReportV2()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initNavigationBar()
        self.title = "Visitor"
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
        self.loadVisitorReportV2()
        
    }
    
    func setUpView() {
        headerVungNamTruoc.removeAll()
        headerVungThangTruoc.removeAll()
        headerKVNamTruoc.removeAll()
        headerKVThangTruoc.removeAll()
        headerShopNamTruoc.removeAll()
        headerShopThangTruoc.removeAll()
        
        //set headerVung
        for i in headerVungFull {
            if i.contains("năm trước") == false {
                headerVungThangTruoc.append(i)
            }
        }
        for i in headerVungFull {
            if i.contains("tháng trước") == false {
                headerVungNamTruoc.append(i)
            }
        }
        
        //set headerKhuVuc
        for i in headerKhuVucFull {
            if i.contains("năm trước") == false {
                headerKVThangTruoc.append(i)
            }
        }
        for i in headerKhuVucFull {
            if i.contains("tháng trước") == false {
                headerKVNamTruoc.append(i)
            }
        }
        
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
        
        radioVung = createRadioButtonGender(CGRect(x: 15, y: 15, width: (self.view.frame.size.width - 30)/3, height: 15), title: "Vùng", color: UIColor.black);
        radioVung.isSelected = true
        self.view.addSubview(radioVung)
        
        radioKhuVuc = createRadioButtonGender(CGRect(x: radioVung.frame.origin.x + radioVung.frame.size.width ,y: radioVung.frame.origin.y, width: radioVung.frame.size.width, height: radioVung.frame.size.height), title: "Khu Vực", color: UIColor.black);
        radioKhuVuc.isSelected = false
        self.view.addSubview(radioKhuVuc)
        
        radioShop = createRadioButtonGender(CGRect(x: radioKhuVuc.frame.origin.x + radioKhuVuc.frame.size.width ,y: radioKhuVuc.frame.origin.y, width: radioKhuVuc.frame.size.width, height: radioKhuVuc.frame.size.height), title: "Shop", color: UIColor.black);
        radioShop.isSelected = false
        self.view.addSubview(radioShop)
        
        let lbTextFromDate = UILabel(frame: CGRect(x: 15, y: radioShop.frame.origin.y + radioShop.frame.height + 10, width: (UIScreen.main.bounds.size.width - 45)/2, height: 15))
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
//        DetailVisitorReportVC2.valueFromDate = fromDateStr
        self.view.addSubview(tfFromDate)
        
        let viewFromDate: UIView = UIView(frame: tfFromDate.frame)
        self.view.addSubview(viewFromDate)
        
        let viewFromDateImage: UIImageView = UIImageView(frame: CGRect(x: viewFromDate.frame.size.width - viewFromDate.frame.size.height, y: viewFromDate.frame.size.height/4, width: viewFromDate.frame.size.height, height: viewFromDate.frame.size.height/2))
        viewFromDateImage.image = UIImage(named:"Calender2")
        viewFromDateImage.contentMode = .scaleAspectFit
        viewFromDate.addSubview(viewFromDateImage)
        
        let tapFromDate = UITapGestureRecognizer(target: self, action: #selector(self.handleTapFromDate(_:)))
        viewFromDate.addGestureRecognizer(tapFromDate)
        
        //--

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
//        DetailVisitorReportVC2.valueToDate = toDateStr
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
        lbCheckCungKyThangTruoc.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(lbCheckCungKyThangTruoc)
        
        imgCheckCungKyThangTruoc = UIImageView(frame: CGRect(x: 15, y: lbCheckCungKyThangTruoc.frame.origin.y, width: 25, height: 25))
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
        
        switch DetailVisitorReportVC2.TypeView {
            
        case "1":
            radioVung.isSelected = true
            radioKhuVuc.isSelected = false
            radioShop.isSelected = false
            break
        case "2":
            radioKhuVuc.isSelected = true
            radioVung.isSelected = false
            radioShop.isSelected = false
            break
        case "3":
            radioShop.isSelected = true
            radioVung.isSelected = false
            radioKhuVuc.isSelected = false
            break
        default:
            DetailVisitorReportVC2.TypeView = "1"
            radioVung.isSelected = true
            radioKhuVuc.isSelected = false
            radioShop.isSelected = false
            break
        }
        
        if DetailVisitorReportVC2.isCheckCungKyNamTruoc == true {
            imgCheckCungKyNamTruoc.image = UIImage(named: "checkedBox")
        } else {
            imgCheckCungKyNamTruoc.image = UIImage(named: "uncheck")
        }
        
        if DetailVisitorReportVC2.isCheckCungKyThangTruoc == true {
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
            
            if DetailVisitorReportVC2.isCheckCungKyThangTruoc && DetailVisitorReportVC2.isCheckCungKyNamTruoc {
                
                if DetailVisitorReportVC2.TypeView == "3" {
                    self.generateDataShopFull(data: list)
                } else {
                    self.generateDataTongHopFull(data: list)
                }
                
            } else if DetailVisitorReportVC2.isCheckCungKyNamTruoc {
                
                if DetailVisitorReportVC2.TypeView == "3" {
                    self.generateDataShopCungKyNAMTruoc(data: list)
                } else {
                    self.generateDataTongHopCungKyNAMTruoc(data: list)
                }
            } else {
                
                if DetailVisitorReportVC2.TypeView == "3" {
                    self.generateDataShopCungKyTHANGTruoc(data: list)
                } else {
                    self.generateDataTongHopCungKyTHANGTruoc(data: list)
                }
            }
            self.reportCollectionView.reloadData()
            
        } else {
            
            if DetailVisitorReportVC2.isCheckCungKyThangTruoc && DetailVisitorReportVC2.isCheckCungKyNamTruoc {
                
                if DetailVisitorReportVC2.TypeView == "3" {
                    self.generateDataShopFull(data: self.listVisitorV2)
                } else {
                    self.generateDataTongHopFull(data: self.listVisitorV2)
                }
            } else if DetailVisitorReportVC2.isCheckCungKyNamTruoc {
                
                if DetailVisitorReportVC2.TypeView == "3" {
                    self.generateDataShopCungKyNAMTruoc(data: self.listVisitorV2)
                } else {
                    self.generateDataTongHopCungKyNAMTruoc(data: self.listVisitorV2)
                }
            } else {
                
                if DetailVisitorReportVC2.TypeView == "3" {
                    self.generateDataShopCungKyTHANGTruoc(data: self.listVisitorV2)
                } else {
                    self.generateDataTongHopCungKyTHANGTruoc(data: self.listVisitorV2)
                }
            }
            
            self.reportCollectionView.reloadData()
        }

        
    }
    
    @objc func checkCungKyThangTruoc() {
        DetailVisitorReportVC2.isCheckCungKyThangTruoc = !DetailVisitorReportVC2.isCheckCungKyThangTruoc
        imgCheckCungKyThangTruoc.image = UIImage(named: DetailVisitorReportVC2.isCheckCungKyThangTruoc ? "checkedBox" : "uncheck")
        self.loadVisitorReportV2()
    }
    
    @objc func checkCungKyNamTruoc() {
        DetailVisitorReportVC2.isCheckCungKyNamTruoc = !DetailVisitorReportVC2.isCheckCungKyNamTruoc
        imgCheckCungKyNamTruoc.image = UIImage(named: DetailVisitorReportVC2.isCheckCungKyNamTruoc ? "checkedBox" : "uncheck")
        self.loadVisitorReportV2()
    }

    fileprivate func createRadioButtonGender(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: 13);
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(logSelectedButtonGender), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    @objc func handleTapToDate(_ sender: UITapGestureRecognizer? = nil) {
        self.chooseTfDate = "ToDate"
        let calendarVC = CalendarViewController()
        self.customPresentViewController(presenter, viewController: calendarVC, animated: true)
        calendarVC.delegate = self
    }
    
    
    @objc func handleTapFromDate(_ sender: UITapGestureRecognizer? = nil) {
        self.chooseTfDate = "FromDate"
        let calendarVC = CalendarViewController()
        self.customPresentViewController(presenter, viewController: calendarVC, animated: true)
        calendarVC.delegate = self
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func logSelectedButtonGender(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioVung.isSelected = false
            radioKhuVuc.isSelected = false
            radioShop.isSelected = false
            switch temp {
            case "Vùng":
                DetailVisitorReportVC2.TypeView = "1"
                radioVung.isSelected = true
                self.loadVisitorReportV2()
                break
            case "Khu Vực":
                DetailVisitorReportVC2.TypeView = "2"
                radioKhuVuc.isSelected = true
                self.loadVisitorReportV2()
                break
            case "Shop":
                DetailVisitorReportVC2.TypeView = "3"
                radioShop.isSelected = true
                self.loadVisitorReportV2()
                
                break
            default:
                break
            }
        }
    }

    func loadVisitorReportV2() {
        self.listVisitorV2.removeAll()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.listVisitorV2 = mSMApiManager.Report_FRT_SP_Visitor_Report_V2(TypeReport: self.TypeReport, TypeView: DetailVisitorReportVC2.TypeView, FromDate: self.tfFromDate.text ?? "", ToDate: self.tfToDate.text ?? "").Data ?? []
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if self.listVisitorV2.count > 0 {
                    if DetailVisitorReportVC2.isCheckCungKyThangTruoc && DetailVisitorReportVC2.isCheckCungKyNamTruoc {
                        
                        if DetailVisitorReportVC2.TypeView == "3" {
                            self.generateDataShopFull(data: self.listVisitorV2)
                        } else {
                            self.generateDataTongHopFull(data: self.listVisitorV2)
                        }
                    } else if DetailVisitorReportVC2.isCheckCungKyNamTruoc {
                        
                        if DetailVisitorReportVC2.TypeView == "3" {
                            self.generateDataShopCungKyNAMTruoc(data: self.listVisitorV2)
                        } else {
                            self.generateDataTongHopCungKyNAMTruoc(data: self.listVisitorV2)
                        }
                    } else {
                        
                        if DetailVisitorReportVC2.TypeView == "3" {
                            self.generateDataShopCungKyTHANGTruoc(data: self.listVisitorV2)
                        } else {
                            self.generateDataTongHopCungKyTHANGTruoc(data: self.listVisitorV2)
                        }
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
                "\(Common.convertCurrencyV2(value: item.TB_Visitor_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_Visitor_LastMonth ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_Visitor_LastYear ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_Visitor_LastTenDay ?? 0))",
                
                "\(Common.convertCurrencyV2(value: item.Count_SO_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.TB_Count_SO_Now ?? 0))",
                
                "\(Common.convertCurrencyV2(value: item.Count_ThuHo_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.TB_Count_ThuHo_Now ?? 0))",
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
                "\(Common.convertCurrencyV2(value: item.TB_Visitor_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_Visitor_LastMonth ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_Visitor_LastTenDay ?? 0))",
                
                "\(Common.convertCurrencyV2(value: item.Count_SO_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.TB_Count_SO_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_ThuHo_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.TB_Count_ThuHo_Now ?? 0))",
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
                "\(Common.convertCurrencyV2(value: item.TB_Visitor_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_Visitor_LastYear ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_Visitor_LastTenDay ?? 0))",
                
                "\(Common.convertCurrencyV2(value: item.Count_SO_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.TB_Count_SO_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.Count_ThuHo_Now ?? 0))",
                "\(Common.convertCurrencyV2(value: item.TB_Count_ThuHo_Now ?? 0))",
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
    
    func generateDataShopFull(data: [Visitor_Report_V2]) {
        
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
    
    func generateDataShopCungKyTHANGTruoc(data: [Visitor_Report_V2]) {
        
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
    
    func generateDataShopCungKyNAMTruoc(data: [Visitor_Report_V2]) {
        
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
        
        if DetailVisitorReportVC2.isCheckCungKyThangTruoc && DetailVisitorReportVC2.isCheckCungKyNamTruoc {
            switch DetailVisitorReportVC2.TypeView {
            case "1":
                self.tempHeaderForSize = self.headerVungFull
            case "2":
                self.tempHeaderForSize = self.headerKhuVucFull
            case "3":
                self.tempHeaderForSize = self.headerShopFull
            default:
                break
            }

        } else if DetailVisitorReportVC2.isCheckCungKyNamTruoc {
            switch DetailVisitorReportVC2.TypeView {
            case "1":
                self.tempHeaderForSize = self.headerVungNamTruoc
            case "2":
                self.tempHeaderForSize = self.headerKVNamTruoc
            case "3":
                self.tempHeaderForSize = self.headerShopNamTruoc
            default:
                break
            }

        } else {
            switch DetailVisitorReportVC2.TypeView {
            case "1":
                self.tempHeaderForSize = self.headerVungThangTruoc
            case "2":
                self.tempHeaderForSize = self.headerKVThangTruoc
            case "3":
                self.tempHeaderForSize = self.headerShopThangTruoc
            default:
                break
            }

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

extension DetailVisitorReportVC2: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cellData.count + 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        
        
        if DetailVisitorReportVC2.isCheckCungKyThangTruoc && DetailVisitorReportVC2.isCheckCungKyNamTruoc {
            switch DetailVisitorReportVC2.TypeView {
            case "1":
                return headerVungFull.count
            case "2":
                return headerKhuVucFull.count
            case "3":
                return headerShopFull.count
            default:
                return 0
            }
            
        } else if DetailVisitorReportVC2.isCheckCungKyNamTruoc {
            
            switch DetailVisitorReportVC2.TypeView {
            case "1":
                return headerVungNamTruoc.count
            case "2":
                return headerKVNamTruoc.count
            case "3":
                return headerShopNamTruoc.count
            default:
                return 0
            }
            
        } else {
            
            switch DetailVisitorReportVC2.TypeView {
            case "1":
                return headerVungThangTruoc.count
            case "2":
                return headerKVThangTruoc.count
            case "3":
                return headerShopThangTruoc.count
            default:
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ReportDataCollectionViewCell;
        

        if DetailVisitorReportVC2.isCheckCungKyThangTruoc && DetailVisitorReportVC2.isCheckCungKyNamTruoc {
            
            switch DetailVisitorReportVC2.TypeView {
            case "1":
                if headerVungFull[indexPath.row].hasPrefix("Traffic") {//cam
                    cell.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1)
                    
                } else if (headerVungFull[indexPath.row].hasPrefix("SO")) || (headerVungFull[indexPath.row].hasPrefix("CRM")) { //lục
                    cell.backgroundColor = UIColor(red: 46/255, green: 184/255, blue: 46/255, alpha: 1)
                    
                } else if (headerVungFull[indexPath.row].hasPrefix("Tỷ lệ")) { //duong
                    cell.backgroundColor = UIColor(red: 102/255, green: 179/255, blue: 255/255, alpha: 1)
                } else {
                    cell.backgroundColor = UIColor.white
                }
            case "2":
                
                if headerKhuVucFull[indexPath.row].hasPrefix("Traffic") {//cam
                    cell.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1)
                    
                } else if (headerKhuVucFull[indexPath.row].hasPrefix("SO")) || (headerKhuVucFull[indexPath.row].hasPrefix("CRM")) { //lục
                    cell.backgroundColor = UIColor(red: 46/255, green: 184/255, blue: 46/255, alpha: 1)
                    
                } else if (headerKhuVucFull[indexPath.row].hasPrefix("Tỷ lệ")) { //duong
                    cell.backgroundColor = UIColor(red: 102/255, green: 179/255, blue: 255/255, alpha: 1)
                } else {
                    cell.backgroundColor = UIColor.white
                }
            case "3":
                
                if headerShopFull[indexPath.row].hasPrefix("Traffic") {//cam
                    cell.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1)
                    
                } else if (headerShopFull[indexPath.row].hasPrefix("SO")) || (headerShopFull[indexPath.row].hasPrefix("CRM")) { //lục
                    cell.backgroundColor = UIColor(red: 46/255, green: 184/255, blue: 46/255, alpha: 1)
                    
                } else if (headerShopFull[indexPath.row].hasPrefix("Tỷ lệ")) { //duong
                    cell.backgroundColor = UIColor(red: 102/255, green: 179/255, blue: 255/255, alpha: 1)
                } else {
                    cell.backgroundColor = UIColor.white
                }
            default:
                break
            }
            
        } else if DetailVisitorReportVC2.isCheckCungKyNamTruoc {
            
            switch DetailVisitorReportVC2.TypeView {
            case "1":
                if headerVungNamTruoc[indexPath.row].hasPrefix("Traffic") {//cam
                    cell.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1)
                    
                } else if (headerVungNamTruoc[indexPath.row].hasPrefix("SO")) || (headerVungNamTruoc[indexPath.row].hasPrefix("CRM")) { //lục
                    cell.backgroundColor = UIColor(red: 46/255, green: 184/255, blue: 46/255, alpha: 1)
                    
                } else if (headerVungNamTruoc[indexPath.row].hasPrefix("Tỷ lệ")) { //duong
                    cell.backgroundColor = UIColor(red: 102/255, green: 179/255, blue: 255/255, alpha: 1)
                } else {
                    cell.backgroundColor = UIColor.white
                }
            case "2":
                
                if headerKVNamTruoc[indexPath.row].hasPrefix("Traffic") {//cam
                    cell.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1)
                    
                } else if (headerKVNamTruoc[indexPath.row].hasPrefix("SO")) || (headerKVNamTruoc[indexPath.row].hasPrefix("CRM")) { //lục
                    cell.backgroundColor = UIColor(red: 46/255, green: 184/255, blue: 46/255, alpha: 1)
                    
                } else if (headerKVNamTruoc[indexPath.row].hasPrefix("Tỷ lệ")) { //duong
                    cell.backgroundColor = UIColor(red: 102/255, green: 179/255, blue: 255/255, alpha: 1)
                } else {
                    cell.backgroundColor = UIColor.white
                }
            case "3":
                
                if headerShopNamTruoc[indexPath.row].hasPrefix("Traffic") {//cam
                    cell.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1)
                    
                } else if (headerShopNamTruoc[indexPath.row].hasPrefix("SO")) || (headerShopNamTruoc[indexPath.row].hasPrefix("CRM")) { //lục
                    cell.backgroundColor = UIColor(red: 46/255, green: 184/255, blue: 46/255, alpha: 1)
                    
                } else if (headerShopNamTruoc[indexPath.row].hasPrefix("Tỷ lệ")) { //duong
                    cell.backgroundColor = UIColor(red: 102/255, green: 179/255, blue: 255/255, alpha: 1)
                } else {
                    cell.backgroundColor = UIColor.white
                }
            default:
                break
            }
            
        } else {
            switch DetailVisitorReportVC2.TypeView {
            case "1":
                if headerVungThangTruoc[indexPath.row].hasPrefix("Traffic") {//cam
                    cell.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1)
                    
                } else if (headerVungThangTruoc[indexPath.row].hasPrefix("SO")) || (headerVungThangTruoc[indexPath.row].hasPrefix("CRM")) { //lục
                    cell.backgroundColor = UIColor(red: 46/255, green: 184/255, blue: 46/255, alpha: 1)
                    
                } else if (headerVungThangTruoc[indexPath.row].hasPrefix("Tỷ lệ")) { //duong
                    cell.backgroundColor = UIColor(red: 102/255, green: 179/255, blue: 255/255, alpha: 1)
                } else {
                    cell.backgroundColor = UIColor.white
                }
            case "2":
                
                if headerKVThangTruoc[indexPath.row].hasPrefix("Traffic") {//cam
                    cell.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1)
                    
                } else if (headerKVThangTruoc[indexPath.row].hasPrefix("SO")) || (headerKVThangTruoc[indexPath.row].hasPrefix("CRM")) { //lục
                    cell.backgroundColor = UIColor(red: 46/255, green: 184/255, blue: 46/255, alpha: 1)
                    
                } else if (headerKVThangTruoc[indexPath.row].hasPrefix("Tỷ lệ")) { //duong
                    cell.backgroundColor = UIColor(red: 102/255, green: 179/255, blue: 255/255, alpha: 1)
                } else {
                    cell.backgroundColor = UIColor.white
                }
            case "3":
                
                if headerShopThangTruoc[indexPath.row].hasPrefix("Traffic") {//cam
                    cell.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1)
                    
                } else if (headerShopThangTruoc[indexPath.row].hasPrefix("SO")) || (headerShopThangTruoc[indexPath.row].hasPrefix("CRM")) { //lục
                    cell.backgroundColor = UIColor(red: 46/255, green: 184/255, blue: 46/255, alpha: 1)
                    
                } else if (headerShopThangTruoc[indexPath.row].hasPrefix("Tỷ lệ")) { //duong
                    cell.backgroundColor = UIColor(red: 102/255, green: 179/255, blue: 255/255, alpha: 1)
                } else {
                    cell.backgroundColor = UIColor.white
                }
            default:
                break
            }
        }
        
        
        
        
        if(tempHeaderForSize.count > 0 || cellData.count > 0 ){
            if(indexPath.section == 0){
                //        @TypeView = 1 --Vùng , 2 : khu vực , 3 : Shop
                //        @TypeReport = 1 --  bc tổng hợp , 2 : bc theo giờ , 3 : bc theo Ngày , 4 : bc theo tuần , 5 : bc theo thứ
                if DetailVisitorReportVC2.isCheckCungKyThangTruoc && DetailVisitorReportVC2.isCheckCungKyNamTruoc {
                    switch DetailVisitorReportVC2.TypeView {
                    case "1":
                        cell.setupHeader(item: headerVungFull[indexPath.row]);
                    case "2":
                        cell.setupHeader(item: headerKhuVucFull[indexPath.row]);
                    case "3":
                        cell.setupHeader(item: headerShopFull[indexPath.row]);
                    default:
                        break
                    }
                    
                } else if DetailVisitorReportVC2.isCheckCungKyNamTruoc {
                    
                    switch DetailVisitorReportVC2.TypeView {
                    case "1":
                        cell.setupHeader(item: headerVungNamTruoc[indexPath.row]);
                    case "2":
                        cell.setupHeader(item: headerKVNamTruoc[indexPath.row]);
                    case "3":
                        cell.setupHeader(item: headerShopNamTruoc[indexPath.row]);
                    default:
                        break
                    }
                    
                } else {
                    
                    switch DetailVisitorReportVC2.TypeView {
                    case "1":
                        cell.setupHeader(item: headerVungThangTruoc[indexPath.row]);
                    case "2":
                        cell.setupHeader(item: headerKVThangTruoc[indexPath.row]);
                    case "3":
                        cell.setupHeader(item: headerShopThangTruoc[indexPath.row]);
                    default:
                        break
                    }
                }
                
//                cell.backgroundColor = UIColor.lightGray;
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = UIColor.darkGray.cgColor;
                
            }else{
                if indexPath.row == 0 {
                    cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row]);
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


extension DetailVisitorReportVC2:CalendarViewControllerDelegate {
    func getDate(dateString: String) {
        if self.chooseTfDate == "FromDate" {
            self.tfFromDate.text = "\(dateString)"
            DetailVisitorReportVC2.valueFromDate = "\(dateString)"
            self.loadVisitorReportV2()
        }
        
        if self.chooseTfDate == "ToDate" {
            self.tfToDate.text = "\(dateString)"
            DetailVisitorReportVC2.valueToDate = "\(dateString)"
            self.loadVisitorReportV2()
        }
    }
}


