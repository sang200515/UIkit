//
//  ThuHoFTelViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 1/7/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
import Toaster
import PopupDialog
import WebKit
class ThuHoFTelViewController: UIViewController,UITextFieldDelegate,CriteriaViewControllerDelegate,RegionsViewControllerDelegate{
    
    var scrollView:UIScrollView!
    var tfContractCode:SkyFloatingLabelTextFieldWithIcon!
    var tfTransactionType:SkyFloatingLabelTextFieldWithIcon!
    var tfSupplier:SkyFloatingLabelTextFieldWithIcon!
    
    var listThuHoProvider:[ThuHoProvider] = []
    
    var ProvinceCode:Int = 0
    var searchType:Int = 0
    var webView:WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.initNavigationBar()
        self.title = "Thu hộ FPT Telecom"
        self.view.backgroundColor = .white

        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(ThuHoViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        //
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        

        
        
        tfTransactionType = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:15), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)), iconType: .image);
        tfTransactionType.placeholder = "Chọn Vùng/Miền"
        tfTransactionType.title = "Vùng/Miền"
        tfTransactionType.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTransactionType.keyboardType = UIKeyboardType.default
        tfTransactionType.returnKeyType = UIReturnKeyType.done
        tfTransactionType.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTransactionType.delegate = self
        tfTransactionType.tintColor = UIColor(netHex:0x00955E)
        tfTransactionType.textColor = .black
        tfTransactionType.lineColor = .gray
        tfTransactionType.selectedTitleColor = UIColor(netHex:0x00955E)
        tfTransactionType.selectedLineColor = .gray
        tfTransactionType.lineHeight = 1.0
        tfTransactionType.selectedLineHeight = 1.0
        scrollView.addSubview(tfTransactionType)
        tfTransactionType.iconImage = UIImage(named: "LoaiGD")
        
        let viewFocusTransactionType = UIView(frame: tfTransactionType.frame);
        scrollView.addSubview(viewFocusTransactionType)
        
        let gestureTransactionType = UITapGestureRecognizer(target: self, action:  #selector(self.actionTransactionType))
        viewFocusTransactionType.addGestureRecognizer(gestureTransactionType)
        
        
        tfSupplier = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:15), y: tfTransactionType.frame.origin.y + tfTransactionType.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)), iconType: .image);
        tfSupplier.placeholder = "Chọn tiêu chí"
        tfSupplier.title = "Tiêu chí"
        tfSupplier.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSupplier.keyboardType = UIKeyboardType.default
        tfSupplier.returnKeyType = UIReturnKeyType.done
        tfSupplier.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSupplier.delegate = self
        tfSupplier.tintColor = UIColor(netHex:0x00955E)
        tfSupplier.textColor = .black
        tfSupplier.lineColor = .gray
        tfSupplier.selectedTitleColor = UIColor(netHex:0x00955E)
        tfSupplier.selectedLineColor = .gray
        tfSupplier.lineHeight = 1.0
        tfSupplier.selectedLineHeight = 1.0
        scrollView.addSubview(tfSupplier)
        tfSupplier.iconImage = UIImage(named: "NCC")
        
        let viewFocusSupplier = UIView(frame: tfSupplier.frame);
        scrollView.addSubview(viewFocusSupplier)
        
        let gestureSupplier = UITapGestureRecognizer(target: self, action:  #selector(self.actionSupplier))
        viewFocusSupplier.addGestureRecognizer(gestureSupplier)
        
        tfContractCode = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:15), y: tfSupplier.frame.origin.y + tfSupplier.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)), iconType: .image);
        tfContractCode.placeholder = "Nhập thông tin cần tìm"
        tfContractCode.title = "Thông tin"
        tfContractCode.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfContractCode.keyboardType = UIKeyboardType.default
        tfContractCode.returnKeyType = UIReturnKeyType.done
        tfContractCode.clearButtonMode = UITextField.ViewMode.whileEditing
        tfContractCode.delegate = self
        tfContractCode.tintColor = UIColor(netHex:0x00955E)
        tfContractCode.textColor = .black
        tfContractCode.lineColor = .gray
        tfContractCode.selectedTitleColor = UIColor(netHex:0x00955E)
        tfContractCode.selectedLineColor = .gray
        tfContractCode.lineHeight = 1.0
        tfContractCode.selectedLineHeight = 1.0
        scrollView.addSubview(tfContractCode)
        tfContractCode.iconImage = UIImage(named: "MaGD")
        
        
        let btPay = UIButton()
        btPay.frame = CGRect(x: Common.Size(s:15), y: tfContractCode.frame.origin.y + tfContractCode.frame.size.height + Common.Size(s:30), width: tfSupplier.frame.size.width, height: tfSupplier.frame.size.height * 1.1)
        btPay.backgroundColor = UIColor(netHex:0x00955E)
        btPay.setTitle("TRA CỨU HOÁ ĐƠN", for: .normal)
        btPay.addTarget(self, action: #selector(actionCheckKMVC), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        
        scrollView.addSubview(btPay)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btPay.frame.origin.y + btPay.frame.size.height + Common.Size(s: 10))
        MPOSAPIManager.mpos_FRT_SP_Mirae_noteforsale(type:"3") { (result, err) in
            
            if(result.count > 0){
                self.webView = WKWebView(frame: CGRect(x: 0 , y: btPay.frame.size.height + btPay.frame.origin.y + Common.Size(s: 15) , width: self.view.frame.size.width , height: self.view.frame.size.height - (btPay.frame.size.height + btPay.frame.origin.y + Common.Size(s: 15))))
                self.webView.loadHTMLString(Common.shared.headerString + result, baseURL: nil)

                self.webView.backgroundColor = .white
                self.view.addSubview(self.webView)
            }
        }
    }
    @objc func actionCheckKMVC(sender: UIButton!){
        if(ProvinceCode == 0){
           Toast.init(text: "Bạn phải chọn Vùng/Miền.").show()
            return
        }
        if(searchType == 0){
            Toast.init(text: "Bạn phải chọn loại tiêu chí.").show()
            return
        }
        let keySearch = tfContractCode.text!
        if(keySearch.isEmpty){
            Toast.init(text: "Bạn nhập thông tin tìm kiếm.").show()
            return
        }
        let newViewController = LoadingViewController()
        newViewController.content = "Đang tìm thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.GetListCustomerV2(SearchValue: "\(keySearch)", Type: "\(searchType)", Province: "\(ProvinceCode)") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    let vc = ListCustomerFtelViewController()
                    vc.items = results
                    vc.province = self.ProvinceCode
            
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
    @objc func actionSupplier(sender : UITapGestureRecognizer) {
        let myVC = CriteriaViewController()
        myVC.delegate = self
        myVC.ind = 0
        let navController = UINavigationController(rootViewController: myVC)
        self.navigationController?.present(navController, animated:false, completion: nil)
    }
    @objc func actionTransactionType(sender : UITapGestureRecognizer) {
        let myVC = RegionsViewController()
        myVC.delegate = self
        myVC.ind = 0
        let navController = UINavigationController(rootViewController: myVC)
        self.navigationController?.present(navController, animated:false, completion: nil)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    func returnCriteria(item: String, ind: Int) {
        tfSupplier.text = item
        searchType = ind + 1
    }
    func returnLocation(item: GetFtelLocationsResult, ind: Int) {
        tfTransactionType.text = item.ProvinceName
        self.ProvinceCode = item.ProvinceCode
    }
}
