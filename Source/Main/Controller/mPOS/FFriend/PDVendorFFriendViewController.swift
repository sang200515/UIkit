//
//  PDVendorFFriendViewController.swift
//  fptshop
//
//  Created by tan on 1/7/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import  PopupDialog
class PDVendorFFriendViewController:  UIViewController,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate{

    
    var lblVendorName:UILabel!
    var lblPhuTrachVendor:UILabel!
    var lblHeadPD:UILabel!
    var lblLyDoCapNhat: UILabel!
    
    var tfVendor:SearchTextField!
    var tfPhuTrachVendor:SearchTextField!
    var tfHeadPD:SearchTextField!
    var tfLyDoCapNhat:UITextField!
    var scrollView:UIView!
    
    var btSearch:UIButton!
    var btSave:UIButton!
    var lstVendorCurator:[VendorCuratorGetvendor] = []
    var lstVendorCuratorGetHeadPD:[VendorCuratorGetHeadPD] = []
    var lstPhuTrachVendor:[VendorCuratorGetCurator] = []
    var lstInfoCurator:[InfoCurator] = []
    
    var vendorCode:String = ""
    var curatorCode:String = ""
    var head_PDCode:String = ""
    
    var viewTable:UITableView  =   UITableView()
     var barSearchRight : UIBarButtonItem!
    

    override func viewDidLoad() {
//        scrollView = UIScrollView(frame: UIScreen.main.bounds)
//        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
//        scrollView.backgroundColor = UIColor.white
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.showsHorizontalScrollIndicator = false
//        self.view.addSubview(scrollView)
        self.title = "PD Của FFriend"
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x47B054)
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        let btSearchIcon = UIButton.init(type: .custom)
        
        btSearchIcon.setImage(#imageLiteral(resourceName: "ReloadPO"), for: UIControl.State.normal)
        btSearchIcon.imageView?.contentMode = .scaleAspectFit
        btSearchIcon.addTarget(self, action: #selector(refeshButton), for: UIControl.Event.touchUpInside)
        btSearchIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barSearchRight = UIBarButtonItem(customView: btSearchIcon)
        
        
        
        
        
        self.navigationItem.rightBarButtonItems = [barSearchRight]
        
        scrollView  = UIView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - 44-(UIApplication.shared.statusBarFrame.height + 0.0)))
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        

        lblVendorName = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s:2), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblVendorName.textAlignment = .left
        lblVendorName.textColor = UIColor.black
        lblVendorName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblVendorName.text = "Tên doanh nghiệp"
        scrollView.addSubview(lblVendorName)
        
        tfVendor = SearchTextField(frame: CGRect(x: lblVendorName.frame.origin.x, y: lblVendorName.frame.origin.y + lblVendorName.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        tfVendor.placeholder = "Chọn tên doanh nghiệp"
        tfVendor.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        tfVendor.borderStyle = UITextField.BorderStyle.roundedRect
        tfVendor.autocorrectionType = UITextAutocorrectionType.no
        tfVendor.keyboardType = UIKeyboardType.default
        tfVendor.returnKeyType = UIReturnKeyType.done
        tfVendor.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfVendor.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfVendor.delegate = self
        scrollView.addSubview(tfVendor)
        
        tfVendor.startVisible = true
        tfVendor.theme.bgColor = UIColor.white
        tfVendor.theme.fontColor = UIColor.black
        tfVendor.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfVendor.theme.cellHeight = Common.Size(s:40)
        tfVendor.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        lblPhuTrachVendor = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfVendor.frame.origin.y + tfVendor.frame.size.height + Common.Size(s: 5) , width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblPhuTrachVendor.textAlignment = .left
        lblPhuTrachVendor.textColor = UIColor.black
        lblPhuTrachVendor.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPhuTrachVendor.text = "Phụ trách DN"
        scrollView.addSubview(lblPhuTrachVendor)
        
        tfPhuTrachVendor = SearchTextField(frame: CGRect(x: lblPhuTrachVendor.frame.origin.x, y: lblPhuTrachVendor.frame.origin.y + lblPhuTrachVendor.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        tfPhuTrachVendor.placeholder = "Chọn user/tên cần cập nhật"
        tfPhuTrachVendor.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        tfPhuTrachVendor.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhuTrachVendor.autocorrectionType = UITextAutocorrectionType.no
        tfPhuTrachVendor.keyboardType = UIKeyboardType.default
        tfPhuTrachVendor.returnKeyType = UIReturnKeyType.done
        tfPhuTrachVendor.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPhuTrachVendor.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhuTrachVendor.delegate = self
        scrollView.addSubview(tfPhuTrachVendor)
        
        tfPhuTrachVendor.startVisible = true
        tfPhuTrachVendor.theme.bgColor = UIColor.white
        tfPhuTrachVendor.theme.fontColor = UIColor.black
        tfPhuTrachVendor.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhuTrachVendor.theme.cellHeight = Common.Size(s:40)
        tfPhuTrachVendor.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        
        lblHeadPD = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfPhuTrachVendor.frame.origin.y + tfPhuTrachVendor.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblHeadPD.textAlignment = .left
        lblHeadPD.textColor = UIColor.black
        lblHeadPD.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblHeadPD.text = "Head PD/RPD"
        scrollView.addSubview(lblHeadPD)
        
        tfHeadPD = SearchTextField(frame: CGRect(x: lblHeadPD.frame.origin.x, y: lblHeadPD.frame.origin.y + lblHeadPD.frame.size.height  + Common.Size(s: 5) , width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        tfHeadPD.placeholder = "Chọn user/tên cần cập nhật"
        tfHeadPD.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        tfHeadPD.borderStyle = UITextField.BorderStyle.roundedRect
        tfHeadPD.autocorrectionType = UITextAutocorrectionType.no
        tfHeadPD.keyboardType = UIKeyboardType.default
        tfHeadPD.returnKeyType = UIReturnKeyType.done
        tfHeadPD.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfHeadPD.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfHeadPD.delegate = self
        scrollView.addSubview(tfHeadPD)
        
        tfHeadPD.startVisible = true
        tfHeadPD.theme.bgColor = UIColor.white
        tfHeadPD.theme.fontColor = UIColor.black
        tfHeadPD.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfHeadPD.theme.cellHeight = Common.Size(s:40)
        tfHeadPD.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        lblLyDoCapNhat = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfHeadPD.frame.origin.y + tfHeadPD.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblLyDoCapNhat.textAlignment = .left
        lblLyDoCapNhat.textColor = UIColor.black
        lblLyDoCapNhat.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblLyDoCapNhat.text = "Lý do cập nhật"
        scrollView.addSubview(lblLyDoCapNhat)
        
        tfLyDoCapNhat = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblLyDoCapNhat.frame.origin.y + lblLyDoCapNhat.frame.size.height  + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfLyDoCapNhat.placeholder = ""
        tfLyDoCapNhat.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        tfLyDoCapNhat.borderStyle = UITextField.BorderStyle.roundedRect
        tfLyDoCapNhat.autocorrectionType = UITextAutocorrectionType.no
        tfLyDoCapNhat.keyboardType = UIKeyboardType.default
        tfLyDoCapNhat.returnKeyType = UIReturnKeyType.done
        tfLyDoCapNhat.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfLyDoCapNhat.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfLyDoCapNhat.delegate = self
        scrollView.addSubview(tfLyDoCapNhat)
        tfLyDoCapNhat.placeholder = ""
        
        btSearch = UIButton()
        btSearch.frame = CGRect(x: tfLyDoCapNhat.frame.origin.x, y: tfLyDoCapNhat.frame.origin.y + tfLyDoCapNhat.frame.size.height + Common.Size(s:10), width: Common.Size(s: 100), height: Common.Size(s: 30))
        btSearch.backgroundColor = UIColor(netHex:0x339966)
        btSearch.setTitle("Tìm kiếm", for: .normal)
        btSearch.addTarget(self, action: #selector(actionSearch), for: .touchUpInside)
        btSearch.layer.borderWidth = 0.5
        btSearch.layer.borderColor = UIColor.white.cgColor
        btSearch.layer.cornerRadius = 3
        scrollView.addSubview(btSearch)
        btSearch.clipsToBounds = true
        
        btSave = UIButton()
        btSave.frame = CGRect(x: btSearch.frame.origin.x + btSearch.frame.size.width + Common.Size(s: 80), y: tfLyDoCapNhat.frame.origin.y + tfLyDoCapNhat.frame.size.height + Common.Size(s:10), width: Common.Size(s: 100), height: Common.Size(s: 30))
        btSave.backgroundColor = UIColor(netHex:0xEF4A40)
        btSave.setTitle("Lưu", for: .normal)
        btSave.addTarget(self, action: #selector(actionSave), for: .touchUpInside)
        btSave.layer.borderWidth = 0.5
        btSave.layer.borderColor = UIColor.white.cgColor
        btSave.layer.cornerRadius = 3
        scrollView.addSubview(btSave)
        btSave.clipsToBounds = true
        
        viewTable.frame = CGRect(x: tfLyDoCapNhat.frame.origin.x, y:btSave.frame.origin.y + btSave.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: self.view.frame.size.height - 400)
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        viewTable.dataSource = self
        viewTable.delegate = self
//        viewTable.backgroundColor = UIColor.yellow
        viewTable.register(ItemVendorCusorTableViewCell.self, forCellReuseIdentifier: "ItemVendorCusorTableViewCell")
        viewTable.tableFooterView = UIView()
        viewTable.backgroundColor = UIColor.white
        
        scrollView.addSubview(viewTable)
        
        
        
        tfVendor.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            self.tfVendor.text = item.title
       
            let obj1 =  self.lstVendorCurator.filter{ "\($0.VendName)" == "\(item.title)" }.first
            if let obj = obj1?.VendCode {
                self.vendorCode = "\(obj)"
            }
            
         
        }
        tfPhuTrachVendor.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            self.tfPhuTrachVendor.text = item.title
            
            let obj1 =  self.lstPhuTrachVendor.filter{ "\($0.CuratorName)" == "\(item.title)" }.first
            if let obj = obj1?.CuratorCode {
                self.curatorCode = "\(obj)"
            }
            
            
        }
        tfHeadPD.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            self.tfHeadPD.text = item.title
            
            let obj1 =  self.lstVendorCuratorGetHeadPD.filter{ "\($0.Head_PDName)" == "\(item.title)" }.first
            if let obj = obj1?.Head_PDCode {
                self.head_PDCode = "\(obj)"
            }
            
            
        }
    
        
        getVendor()
        
        
    }
    
    @objc func backButton(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @objc func refeshButton(){
        
        self.tfVendor.text = ""
        self.tfPhuTrachVendor.text = ""
        self.tfHeadPD.text = ""
        self.tfLyDoCapNhat.text = ""
        
        self.vendorCode = ""
        self.curatorCode = ""
        self.head_PDCode = ""
        self.lstInfoCurator.removeAll()
        self.viewTable.reloadData()
    }
    
    
    @objc func actionSave(){
        if(self.tfVendor.text == "" || self.vendorCode == ""){
            
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập tên doanh nghiệp!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        if(self.tfPhuTrachVendor.text == "" || self.curatorCode == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập tên người phụ trách DN!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
//        if(self.tfHeadPD.text == "" || self.head_PDCode == ""){
//            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập tên Head PD/RPD!", preferredStyle: .alert)
//
//            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//            })
//            self.present(alert, animated: true)
//            return
//        }
        if(self.tfLyDoCapNhat.text == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập lý do cập nhật!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        self.saveInfo()
    }
    
    @objc func actionSearch(){
     
//        if(self.tfVendor.text == "" || self.vendorCode == ""){
//
//            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập tên doanh nghiệp!", preferredStyle: .alert)
//
//            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//            })
//            self.present(alert, animated: true)
//            return
//        }
//        if(self.tfPhuTrachVendor.text == "" || self.curatorCode == ""){
//            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập tên người phụ trách DN!", preferredStyle: .alert)
//
//            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//            })
//            self.present(alert, animated: true)
//            return
//        }
//        if(self.tfHeadPD.text == "" || self.head_PDCode == ""){
//            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập tên Head PD/RPD!", preferredStyle: .alert)
//
//            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//            })
//            self.present(alert, animated: true)
//            return
//        }
        self.getInfo_Curator(VendorCode: self.vendorCode, CuratorCode: self.curatorCode, Head_PDCode: self.head_PDCode)
    }
    
    func actionDelete(VendorCode:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang xoá thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.vendorCurator_Deleteinfo(VendorCode:VendorCode) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(results[0].Result == 1){
                        let alert = UIAlertController(title: "Thông báo", message: results[0].Message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            self.getInfo_Curator(VendorCode: self.vendorCode, CuratorCode: self.curatorCode, Head_PDCode: self.head_PDCode)
                        })
                        self.present(alert, animated: true)
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: results[0].Message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                    
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func saveInfo(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lưu thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.getVendorCurator_Saveinfo(VendorCode: self.vendorCode, CuratorCode: self.curatorCode, Head_PDCode: self.head_PDCode, Reason: self.tfLyDoCapNhat.text!) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(results[0].Result == 1){
                        let alert = UIAlertController(title: "Thông báo", message: results[0].Message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            self.getInfo_Curator(VendorCode: self.vendorCode, CuratorCode: self.curatorCode, Head_PDCode: self.head_PDCode)
                        })
                        self.present(alert, animated: true)
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: results[0].Message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                           
                        })
                        self.present(alert, animated: true)
                    }
              
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func getVendor(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy danh sách doanh nghiệp..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.getVendorCurator() { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.lstVendorCurator = results
                    var lstVendorCuratorTemp:[String] = []
                    for item in results {
                        lstVendorCuratorTemp.append(item.VendName)
                    }
                    self.tfVendor.filterStrings(lstVendorCuratorTemp)
                   
                    self.getVendorCurator_GetCurator()
             
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
        
    }
    
    func getVendorCurator_GetHead_PD(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy danh sách Head PD/RDP..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.getVendorCurator_GetHead_PD() { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.lstVendorCuratorGetHeadPD = results
                    var lstHeadPDStringTemp:[String] = []
                    for item in results {
                        lstHeadPDStringTemp.append(item.Head_PDName)
                    }
                    self.tfHeadPD.filterStrings(lstHeadPDStringTemp)
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func getVendorCurator_GetCurator(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy danh sách người phụ trách DN..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.getVendorCurator_GetCurator() { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.lstPhuTrachVendor = results
                    var lstCuratorTemp:[String] = []
                    for item in results {
                        lstCuratorTemp.append(item.CuratorName)
                    }
                    self.tfPhuTrachVendor.filterStrings(lstCuratorTemp)
                     self.getVendorCurator_GetHead_PD()
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func getInfo_Curator(VendorCode:String,CuratorCode:String,Head_PDCode:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang tìm kiếm thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.getInfo_Curator(VendorCode: VendorCode,CuratorCode:CuratorCode,Head_PDCode:Head_PDCode) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.lstInfoCurator.removeAll()
                    self.lstInfoCurator = results
                    
                    self.viewTable.reloadData()
                    self.tfVendor.resignFirstResponder()
                    self.tfPhuTrachVendor.resignFirstResponder()
                    self.tfHeadPD.resignFirstResponder()
                    self.tfLyDoCapNhat.resignFirstResponder()
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lstInfoCurator.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemVendorCusorTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemVendorCusorTableViewCell")
        let item:InfoCurator = self.lstInfoCurator[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:90);
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
  
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            
         
            
            
            let item:InfoCurator = self.lstInfoCurator[indexPath.row]
            print("\(indexPath.row)")
            
            let popup = PopupDialog(title: "Thông báo", message: "Bạn có muốn xoá mục này!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = DefaultButton(title: "Xoá") {
                self.actionDelete(VendorCode: "\(item.ID)")
            }
            let buttonTwo = CancelButton(title: "Không"){
                
            }
            popup.addButtons([buttonOne,buttonTwo])
            self.present(popup, animated: true, completion: nil)
        }
        
    }
    
    
}

class ItemVendorCusorTableViewCell: UITableViewCell {
    var vendor: UILabel!
    var nguoiphutrach:UILabel!
    var headpdrdp: UILabel!
     var deleteIC:UILabel!

   

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        vendor = UILabel()
        vendor.textColor = UIColor.red
        vendor.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
      
        
        
        vendor.numberOfLines = 0
        vendor.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        vendor.minimumScaleFactor = 0.8
        
      
        
        
        contentView.addSubview(vendor)
        
        
        nguoiphutrach = UILabel()
        nguoiphutrach.textColor = UIColor.black
        
        
        nguoiphutrach.numberOfLines = 0
        nguoiphutrach.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        nguoiphutrach.minimumScaleFactor = 0.8
        
        
        nguoiphutrach.font = nguoiphutrach.font.withSize(14)
        contentView.addSubview(nguoiphutrach)
        
        headpdrdp = UILabel()
        headpdrdp.textColor = UIColor.black
        headpdrdp.numberOfLines = 1
        headpdrdp.font = headpdrdp.font.withSize(14)
        contentView.addSubview(headpdrdp)
        
   
        
    
        
  
        
        
    }
    var so1:InfoCurator?
    func setup(so:InfoCurator){
        so1 = so
        
        vendor.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
        vendor.text = "DN: \(so.VendorName)"
        if(vendor.text!.count > 48){
            vendor.frame.size.height = Common.Size(s: 32)
        }
        
        
        
        
        nguoiphutrach.frame = CGRect(x: Common.Size(s:10),y: vendor.frame.origin.y + vendor.frame.size.height + Common.Size(s: 5) ,width: UIScreen.main.bounds.size.width,height: Common.Size(s:16))
       
        nguoiphutrach.text = "Người phụ trách: \(so.CuratorName)"
        
    
        
        
        headpdrdp.frame = CGRect(x: Common.Size(s:10),y: nguoiphutrach.frame.origin.y + nguoiphutrach.frame.size.height + Common.Size(s: 5),width: UIScreen.main.bounds.size.width ,height: Common.Size(s:16))
        headpdrdp.text = "Head PD/RPD: \(so.Head_PDName)"
        
      
  

        
    }
   
    
    
}
