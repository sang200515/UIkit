//
//  ChonSoV2ViewController.swift
//  mPOS
//
//  Created by tan on 9/20/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class ChonSoV2ViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate {
    var scrollView:UIScrollView!
    var goiCuoc:GoiCuocBookSimV2?
    var telecom:ProviderName?
    var viewTimKiem: UIView!
    var tfInputPhone:UITextField!
    var tfLoaiSim:SearchTextField!
    
    var btTimkiem:UILabel!
    var btChonNgauNhien:UILabel!
    var btSoDaMua:UILabel!
    var viewTableSim:UITableView  =   UITableView()
    var viewSim:UIView!
    
    var listSimV2:[SimV2] = []
    var listLoaiSim:[LoaiSimV2] = []
    var selectLoaiSim:Int!
    var window: UIWindow?
    var itemGoiCuocEcom: GoiCuocEcom?

    var itemCode:String = ""
    override func viewDidLoad() {
        self.title = "Chọn số"
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        navigationController?.navigationBar.isTranslucent = false
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin gói cước..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
		var itemCode:String = ""
		for item in Cache.carts {
			if item.product.labelName == "Y" {
				itemCode = item.sku
				break 
			}else {
				itemCode = ""
			}
		}
		if self.itemCode != "" {
			itemCode = self.itemCode
		}
		MPOSAPIManager.getListLoaiSimV2(itemCode:itemCode ,handler: { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.listLoaiSim.removeAll()
                    self.listLoaiSim = results
                    
                    self.setupUI()
                    
                }else{
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
        })
    }
    
    func setupUI(){
        tfLoaiSim = SearchTextField(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:15), width: Common.Size(s: 95) , height: Common.Size(s:40) ));
        tfLoaiSim.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        tfLoaiSim.borderStyle = UITextField.BorderStyle.roundedRect
        tfLoaiSim.autocorrectionType = UITextAutocorrectionType.no
        tfLoaiSim.keyboardType = UIKeyboardType.default
        tfLoaiSim.returnKeyType = UIReturnKeyType.done
        tfLoaiSim.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfLoaiSim.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfLoaiSim.delegate = self
        tfLoaiSim.placeholder = "Chọn loại sim"
        scrollView.addSubview(tfLoaiSim)
        
        tfLoaiSim.startVisible = true
        tfLoaiSim.theme.bgColor = UIColor.white
        tfLoaiSim.theme.fontColor = UIColor.black
        tfLoaiSim.theme.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        tfLoaiSim.theme.cellHeight = Common.Size(s:40)
        tfLoaiSim.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:12))]
        
        
        tfLoaiSim.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.tfLoaiSim.text = item.title
            let obj =  self.listLoaiSim.filter{ $0.TypeName == "\(item.title)" }.first
            if let obj = obj?.ID {
                self.selectLoaiSim = obj
                
                
            }
        }
        
        tfInputPhone = UITextField(frame: CGRect(x: Common.Size(s: 100), y: tfLoaiSim.frame.origin.y, width: UIScreen.main.bounds.size.width - Common.Size(s:110) , height: Common.Size(s:40)));
        
        tfInputPhone.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfInputPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfInputPhone.autocorrectionType = UITextAutocorrectionType.no
        tfInputPhone.keyboardType = UIKeyboardType.default
        tfInputPhone.returnKeyType = UIReturnKeyType.done
        tfInputPhone.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfInputPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfInputPhone.placeholder = "Nhập số cần tìm"
        scrollView.addSubview(tfInputPhone)
        
        btTimkiem = UILabel(frame: CGRect(x: Common.Size(s: 10), y: tfInputPhone.frame.origin.y + tfInputPhone.frame.size.height + Common.Size(s:10), width: Common.Size(s: 90), height: scrollView.frame.size.width/9))
        btTimkiem.textAlignment = .center
        btTimkiem.textColor = UIColor(netHex:0x47B054)
        btTimkiem.layer.cornerRadius = 5
        btTimkiem.layer.borderColor = UIColor(netHex:0x47B054).cgColor
        btTimkiem.layer.borderWidth = 0.5
        btTimkiem.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        btTimkiem.text = "Tìm kiếm"
        btTimkiem.numberOfLines = 1
        scrollView.addSubview(btTimkiem)
        
        let tapUpdate = UITapGestureRecognizer(target: self, action: #selector(ChonSoV2ViewController.timKiem))
        btTimkiem.isUserInteractionEnabled = true
        btTimkiem.addGestureRecognizer(tapUpdate)

        btChonNgauNhien = UILabel(frame: CGRect(x: btTimkiem.frame.origin.x + btTimkiem.frame.size.width + Common.Size(s: 10), y: tfInputPhone.frame.origin.y + tfInputPhone.frame.size.height + Common.Size(s:10), width: Common.Size(s: 100), height: 0))
        btChonNgauNhien.textAlignment = .center
        btChonNgauNhien.textColor = UIColor(netHex:0x47B054)
        btChonNgauNhien.layer.cornerRadius = 5
        btChonNgauNhien.layer.borderColor = UIColor(netHex:0x47B054).cgColor
        btChonNgauNhien.layer.borderWidth = 0.5
        btChonNgauNhien.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        btChonNgauNhien.text = "Chọn ngẫu nhiên"
        btChonNgauNhien.numberOfLines = 1
        scrollView.addSubview(btChonNgauNhien)
        
        let tabGetListRandomSim = UITapGestureRecognizer(target: self, action: #selector(ChonSoV2ViewController.bookSimRandom))
        btChonNgauNhien.isUserInteractionEnabled = true
        btChonNgauNhien.addGestureRecognizer(tabGetListRandomSim)
        
        btSoDaMua = UILabel(frame: CGRect(x: btChonNgauNhien.frame.origin.x + btChonNgauNhien.frame.size.width + Common.Size(s: 10), y: tfInputPhone.frame.origin.y + tfInputPhone.frame.size.height + Common.Size(s:10), width: Common.Size(s: 90), height: scrollView.frame.size.width/9))
        btSoDaMua.textAlignment = .center
        btSoDaMua.textColor = UIColor(netHex:0x47B054)
        btSoDaMua.layer.cornerRadius = 5
        btSoDaMua.layer.borderColor = UIColor(netHex:0x47B054).cgColor
        btSoDaMua.layer.borderWidth = 0.5
        btSoDaMua.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        btSoDaMua.text = "Số đã đặt"
        btSoDaMua.numberOfLines = 1
        scrollView.addSubview(btSoDaMua)
        
        
        let tapGetListSimBook = UITapGestureRecognizer(target: self, action: #selector(ChonSoV2ViewController.getListSimBookByShop))
        btSoDaMua.isUserInteractionEnabled = true
        btSoDaMua.addGestureRecognizer(tapGetListSimBook)
        
        let lblLine = UILabel()
        lblLine.backgroundColor = UIColor(netHex:0xEEEEEE)
        lblLine.frame = CGRect(x: 0 ,y: btSoDaMua.frame.origin.y + btSoDaMua.frame.size.height + Common.Size(s: 10) ,width: UIScreen.main.bounds.size.width  ,height: Common.Size(s:5))
        scrollView.addSubview(lblLine)
        
        let lblTitleDanhSachSo = UILabel(frame: CGRect(x:Common.Size(s:10), y: lblLine.frame.origin.y + lblLine.frame.size.height + Common.Size(s: 10), width: Common.Size(s:90), height: Common.Size(s:16)))
        lblTitleDanhSachSo.textAlignment = .left
        lblTitleDanhSachSo.textColor = UIColor.black
        lblTitleDanhSachSo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lblTitleDanhSachSo.text = "Danh sách số:"
        scrollView.addSubview(lblTitleDanhSachSo)
        
        
        
        let lblTitleDanhSachSo2 = UILabel(frame: CGRect(x: Common.Size(s: 98), y: lblLine.frame.origin.y + lblLine.frame.size.height + Common.Size(s: 10), width:  Common.Size(s:170), height: Common.Size(s:16)))
        lblTitleDanhSachSo2.textAlignment = .left
        lblTitleDanhSachSo2.textColor =  UIColor.red
        
        lblTitleDanhSachSo2.font = UIFont.italicSystemFont(ofSize: 12.0)
        lblTitleDanhSachSo2.text = "(Giá chưa bao gồm giá gói cước)"
        scrollView.addSubview(lblTitleDanhSachSo2)
        
        
        viewSim = UIView(frame: CGRect(x:Common.Size(s: 5),y:lblTitleDanhSachSo2.frame.origin.y + lblTitleDanhSachSo2.frame.size.height ,width: scrollView.frame.size.width - Common.Size(s: 20),height: scrollView.frame.size.height))
        //        viewSearchSim.backgroundColor = .yellow
        scrollView.addSubview(viewSim)
        
        
        
        viewTableSim.frame = CGRect(x: 0, y: 0, width: viewSim.frame.size.width, height: Common.Size(s: 350) )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        viewTableSim.dataSource = self
        viewTableSim.delegate = self
        viewTableSim.register(ItemSimV2TableViewCell.self, forCellReuseIdentifier: "ItemSimV2TableViewCell")
        viewTableSim.tableFooterView = UIView()
        viewTableSim.backgroundColor = UIColor.white
        
        viewSim.addSubview(viewTableSim)
        navigationController?.navigationBar.isTranslucent = false
        
        viewSim.frame.size.height = viewTableSim.frame.size.height + viewTableSim.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewSim.frame.origin.y + viewSim.frame.size.height + (navigationController?.navigationBar.frame.size.height ?? 0) + UIApplication.shared.statusBarFrame.height)
        
        
        var list:[String] = []
        for item in self.listLoaiSim {
            list.append(item.TypeName)
        }
        self.tfLoaiSim.filterStrings(list)
        self.tfLoaiSim.becomeFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listSimV2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemSimV2TableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemSimV2TableViewCell")
        let item:SimV2 = self.listSimV2[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        //cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:40);
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let item:SimV2 = self.listSimV2[indexPath.row]
        print("\(indexPath.row)")
        let title = "Thông báo"
        let sum = item.PriceSale + (self.goiCuoc?.GiaCuoc)!
        
        let thongbao = "Bạn có muốn book số\r\n\(item.ProductID): \(Common.convertCurrencyV2(value: item.PriceSale))đ\r\n\((self.goiCuoc?.TenSP)!): \(Common.convertCurrencyV2(value: (self.goiCuoc?.GiaCuoc)!))đ\r\n Tổng Tiền: \(Common.convertCurrencyV2(value: sum))đ"
        let popup = PopupDialog(title: title, message: thongbao, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            print("Completed")
        }
  
        if self.telecom?.NhaMang.lowercased() == "viettel" {
            let buttonTwo = CancelButton(title: "Không"){ }
            let buttonOne = CancelButton(title: "Book sim") {
                self.bookSim(phoneNumber: item.ProductID,giaSim: item.PriceSale,telecom:"viettel",item:item)
            }
            popup.addButtons([buttonOne,buttonTwo])
            self.present(popup, animated: true, completion: nil)
            return
		}
		if self.telecom?.NhaMang.lowercased() == "vinaphone"	{
			let buttonTwo = CancelButton(title: "Không"){ }
			let buttonOne = CancelButton(title: "Book sim") {
				self.bookSim(phoneNumber: item.ProductID,giaSim: item.PriceSale,telecom:"vinaphone",item:item)
			}
			popup.addButtons([buttonOne,buttonTwo])
			self.present(popup, animated: true, completion: nil)
			return

		}
//        PackageType = 1 ==> sim thường, 2 ==> esim, 3 cả 2
        if self.itemGoiCuocEcom?.PackageType == 1 {
            let buttonTwo = CancelButton(title: "Không"){ }
            let buttonOne = CancelButton(title: "Sim Thường") {
                self.bookSim(phoneNumber: item.ProductID,giaSim: item.PriceSale,telecom:"Sim Thường",item:item)
            }
            popup.addButtons([buttonOne,buttonTwo])
            
        } else if self.itemGoiCuocEcom?.PackageType == 2 {
            let buttonTwo = CancelButton(title: "Không"){ }
            let buttonThree = CancelButton(title: "Esim"){
                self.bookESim(phoneNumber: item.ProductID,giaSim: item.PriceSale)
            }
            popup.addButtons([buttonThree,buttonTwo])
        }
        
        if self.itemGoiCuocEcom?.PackageType != 1 && self.itemGoiCuocEcom?.PackageType != 2 {
            self.showAlert("Số thuê bao \(item.ProductID) có PackageType = \(self.itemGoiCuocEcom?.PackageType ?? -99) nên không thể thao tác tiếp, vui lòng liên hệ DEV để được hỗ trợ, xin cảm ơn!")
        } else {
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    @objc func getListSimBookByShop(){
        let newViewController = DanhSachSimBookV2ViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    func bookESim(phoneNumber:String,giaSim:Int){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang book esim..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.dangKyBookSoV2(tenKH: (self.goiCuoc?.tenKH)!, NhaMang: (self.telecom?.NhaMang)!, phoneNumber: phoneNumber, maGoiCuoc: (self.goiCuoc?.MaSP)!, tenGoiCuoc: (self.goiCuoc?.TenSP)!, giaGoiCuoc: (self.goiCuoc?.GiaCuoc)!, giaSim: giaSim) { (results,IsLogin,p_Status, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
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
                        //                        APIService.removeDeviceToken()
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
                    let buttonOne = CancelButton(title: "OK") {}
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    return
                    
                }
                if(err.count <= 0){
                    if(results.Success == true){
                        
                        if(results.Result == "1"){
                            let simActive:SimActive = SimActive(ID: 0,Provider: "",Status: "",Phonenumber: "",SeriSIM: "",FullName: "",Birthday: "",Gender: 0,Address: "",CMND: "",DateCreateCMND: "",PalaceCreateCMND: "",ProvinceCode: "",DistrictCode: "",PrecinctCode: "",URL_FileCMNDMatTruoc: "",URL_FileCMNDMatSau: "",URL_FilePhieuDKTT: "",URL_FileKH_TaiShop: "",Note: "",GoiCuoc: "",ProductName: "",ProductCode: "", TypeKichHoat: 0,POSSODocNum: "",Passport: "", DayGrantPassport: "",Nationality: "",LoaiGiayTo: 0,SoVisa: "",NoiCapPassport:"",TenShop: "",DiaChiShop: "",TenNhanVien:"",SSD:"")
                            let newViewController = DetailEsimViewController()
                            simActive.POSSODocNum = "\(results.dataBookSimV2.SoMpos)"
                            simActive.GoiCuoc = results.dataBookSimV2.PackofData
                            simActive.ProductCode = results.dataBookSimV2.MaGoiCuoc
                            simActive.ProductName = results.dataBookSimV2.TenGoiCuoc
                            simActive.Provider = results.dataBookSimV2.Provider
                            simActive.FullName = results.dataBookSimV2.CardName
                            simActive.Phonenumber = results.dataBookSimV2.PhoneNumber
                            simActive.LoaiGiayTo = 1
                            simActive.ID = results.dataBookSimV2.SoMpos
                            if(results.dataBookSimV2.Provider == "Viettel" || results.dataBookSimV2.Provider == "viettel"){
                                simActive.Nationality = "232"
                                
                                let alert = UIAlertController(title: "Thông báo", message: "\(results.Message)\nBạn vui lòng vào app Mbccs của Viettel kích SĐT: \(results.dataBookSimV2.PhoneNumber) và quay lại xác nhận để phát sinh đơn hàng sau khi kích hoạt thành công!", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default) { action in
                                    self.navigationController?.popViewController(animated: true)
                                }
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                                return
                            }
                            if(results.dataBookSimV2.Provider == "Mobifone" || results.dataBookSimV2.Provider == "mobifone"){
                                simActive.Nationality = "VNM"
                                
                                let alert = UIAlertController(title: "Thông báo", message: "\(results.Message)\nBạn vui lòng vào app MSale của mobifone kích SDT: \(results.dataBookSimV2.PhoneNumber) và quay lại xác nhận để phát sinh đơn hàng sau khi kích hoạt thành công!", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default) { action in
                                    self.navigationController?.popViewController(animated: true)
                                }
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                                return
                            }
                            if(results.dataBookSimV2.Provider == "Vinaphone" || results.dataBookSimV2.Provider == "vinaphone"){
                                simActive.Nationality = "232"
                            }
                            if(results.dataBookSimV2.Provider == "vietnammobile" || results.dataBookSimV2.Provider == "VietnamMobile" || results.dataBookSimV2.Provider == "Vietnammobile"){
                                simActive.Nationality = "232"
                            }
                            if(results.dataBookSimV2.Provider.lowercased() == "itelecom"){
                                simActive.Nationality = "232"
                            }
                            if(results.dataBookSimV2.IsSubsidy == 0){
                                simActive.SSD = "N"
                            }else{
                                simActive.SSD = "Y"
                            }
                            newViewController.simActive = simActive
                            self.navigationController?.pushViewController(newViewController, animated: true)
                            
                        }else{
                            self.showDialog(message: results.Message)
                        }
                    }else{
                        self.showDialog(message: results.Message)
                    }
                }else{
                    self.showDialog(message: err)
                }
            }
        }
    }
    
    func bookSim(phoneNumber:String, giaSim:Int,telecom:String,item:SimV2){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang book sim..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.dangKyBookSoV2(tenKH: (self.goiCuoc?.tenKH)!, NhaMang: (self.telecom?.NhaMang)!, phoneNumber: phoneNumber, maGoiCuoc: (self.goiCuoc?.MaSP)!, tenGoiCuoc: (self.goiCuoc?.TenSP)!, giaGoiCuoc: (self.goiCuoc?.GiaCuoc)!, giaSim: giaSim) { (results,IsLogin,p_Status, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
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
//                        APIService.removeDeviceToken()
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
                    let buttonOne = CancelButton(title: "OK") {}
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    return
                    
                }
                if(err.count <= 0){
                    if(results.Success == true){
                        
                        if(results.Result == "1"){
                            let simActive:SimActive = SimActive(ID: 0,Provider: "",Status: "",Phonenumber: "",SeriSIM: "",FullName: "",Birthday: "",Gender: 0,Address: "",CMND: "",DateCreateCMND: "",PalaceCreateCMND: "",ProvinceCode: "",DistrictCode: "",PrecinctCode: "",URL_FileCMNDMatTruoc: "",URL_FileCMNDMatSau: "",URL_FilePhieuDKTT: "",URL_FileKH_TaiShop: "",Note: "",GoiCuoc: "",ProductName: "",ProductCode: "", TypeKichHoat: 0,POSSODocNum: "",Passport: "", DayGrantPassport: "",Nationality: "",LoaiGiayTo: 0,SoVisa: "",NoiCapPassport:"",TenShop: "",DiaChiShop: "",TenNhanVien:"",SSD:"")
                            let newViewController = DetailSimCRMViewControllerV2()
                            simActive.POSSODocNum = "\(results.dataBookSimV2.SoMpos)"
                            simActive.GoiCuoc = results.dataBookSimV2.PackofData
                            simActive.ProductCode = results.dataBookSimV2.MaGoiCuoc
                            simActive.ProductName = results.dataBookSimV2.TenGoiCuoc
                            simActive.Provider = results.dataBookSimV2.Provider
                            simActive.FullName = results.dataBookSimV2.CardName
                            simActive.Phonenumber = results.dataBookSimV2.PhoneNumber
                            simActive.LoaiGiayTo = 1
                            simActive.ID = results.dataBookSimV2.SoMpos
                            if(results.dataBookSimV2.Provider == "Viettel" || results.dataBookSimV2.Provider == "viettel"){
                                simActive.Nationality = "232"
                                
                                let alert = UIAlertController(title: "Thông báo", message: "\(results.Message)\nBạn vui lòng vào app Mbccs của Viettel kích SĐT: \(results.dataBookSimV2.PhoneNumber) và quay lại xác nhận để phát sinh đơn hàng sau khi kích hoạt thành công!", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default) { action in
                                    self.navigationController?.popViewController(animated: true)
                                }
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                                return
                            }
                            if(results.dataBookSimV2.Provider == "Mobifone" || results.dataBookSimV2.Provider == "mobifone"){
                                simActive.Nationality = "VNM"
                                
                                let alert = UIAlertController(title: "Thông báo", message: "\(results.Message)\nBạn vui lòng vào app MSale của mobifone kích SDT: \(results.dataBookSimV2.PhoneNumber) và quay lại xác nhận để phát sinh đơn hàng sau khi kích hoạt thành công!", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default) { action in
                                    self.navigationController?.popViewController(animated: true)
                                }
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                                return
							}
							if (results.dataBookSimV2.Provider == "Vinaphone" || results.dataBookSimV2.Provider == "vinaphone") {
								//luong book sim
								simActive.Nationality = "232"
								Cache.packageBookSim =  results.dataBookSimV2
								let sum = item.PriceSale + (results.dataBookSimV2.GiaCuoc )
								let vc = CustomerBooksimVinaphoneVC()
								vc.model = item
								vc.typeBookSim = "2"
								//results.dataBookSimV2.
								vc.tongTien = "\(Common.convertCurrencyV2(value: sum))đ"
								vc.giaGoiCuoc = "\(Common.convertCurrencyV2(value: (results.dataBookSimV2.GiaCuoc) ))đ"
								self.navigationController?.pushViewController(vc, animated: true)
								return
							}else {
								if(results.dataBookSimV2.Provider == "vietnammobile" || results.dataBookSimV2.Provider == "VietnamMobile" || results.dataBookSimV2.Provider == "Vietnammobile"){
									simActive.Nationality = "232"
								}
								if(results.dataBookSimV2.Provider.lowercased() == "itelecom"){
									simActive.Nationality = "232"
								}
								if(results.dataBookSimV2.IsSubsidy == 0){
									simActive.SSD = "N"
								}else{
									simActive.SSD = "Y"
								}

								newViewController.simActive = simActive
								self.navigationController?.pushViewController(newViewController, animated: true)
							}

                        }else{
                               self.showDialog(message: results.Message)
                        }
                    }else{
                        self.showDialog(message: results.Message)
                    }
                }else{
                    self.showDialog(message: err)
                }
            }
        }
    }
    
    
    @objc func bookSimRandom(){
        
        if(self.tfLoaiSim.text == "" || self.selectLoaiSim == nil){
             self.showDialog(message: "Vui lòng chọn loại sim")
            self.tfInputPhone.resignFirstResponder()
            self.tfLoaiSim.resignFirstResponder()
            return
        }
        
        let swiftyString = self.tfInputPhone.text!.replacingOccurrences(of: "*", with: "_")
        print(swiftyString)
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin gói cước..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.getSearchSimV2(NhaMang: (self.telecom?.NhaMang)!, ProductID: swiftyString, SimType: "\(self.selectLoaiSim!)",Random: "1",ProductCode: (self.goiCuoc?.MaSP)!) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.listSimV2.removeAll()
                    self.listSimV2 = [results[0]]
                    self.viewTableSim.reloadData()
                    
                }else{
                    
                    self.showDialog(message: err)
                }
            }
        }
    }
    
    
    @objc func timKiem(){
        if(self.tfLoaiSim.text == "" || self.selectLoaiSim == nil){
            self.showDialog(message: "Vui lòng chọn loại sim")
            self.tfInputPhone.resignFirstResponder()
            self.tfLoaiSim.resignFirstResponder()
            return
        }
        
        let swiftyString = self.tfInputPhone.text!.replacingOccurrences(of: "*", with: "_")
        print(swiftyString)
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin gói cước..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.getSearchSimV2(NhaMang: (self.telecom?.NhaMang)!, ProductID: swiftyString, SimType: "\(self.selectLoaiSim!)",Random: "0",ProductCode: (self.goiCuoc?.MaSP)!) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.listSimV2.removeAll()
                    self.listSimV2 = results
                    self.viewTableSim.reloadData()
                    
                }else{
                    
                    self.showDialog(message: err)
                }
            }
        }
    }
    
    @objc func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
}

class ItemSimV2TableViewCell: UITableViewCell {
    
    var stt: UILabel!
    var sdt: UILabel!
    var provider: UILabel!
    var giaTien: UILabel!
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        stt = UILabel()
        stt.textColor = UIColor.black
        stt.numberOfLines = 1
        stt.font = stt.font.withSize(12)
        contentView.addSubview(stt)
        
        sdt = UILabel()
        sdt.textColor = UIColor.black
        sdt.numberOfLines = 1
        sdt.font = sdt.font.withSize(12)
        contentView.addSubview(sdt)
        
        
        provider = UILabel()
        provider.textColor = UIColor.black
        provider.numberOfLines = 1
        provider.font = provider.font.withSize(12)
        //        provider.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        contentView.addSubview(provider)
        
        giaTien = UILabel()
        giaTien.textColor = UIColor.black
        giaTien.numberOfLines = 1
        giaTien.font = giaTien.font.withSize(12)
        contentView.addSubview(giaTien)
        
        
        
        
    }
    var so1:SimV2?
    func setup(so:SimV2){
        so1 = so
        
        stt.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: Common.Size(s: 80)  ,height: Common.Size(s:20))
        stt.text = "\(so.STT)."
        
        
        sdt.frame = CGRect(x:stt.frame.origin.x + stt.frame.size.width - Common.Size(s: 50) ,y: Common.Size(s:10),width: Common.Size(s: 100),height: Common.Size(s:16))
        sdt.text = "\(so.ProductID)"
        
        provider.frame = CGRect(x:sdt.frame.origin.x + sdt.frame.size.width - Common.Size(s: 20) ,y: Common.Size(s:10),width: Common.Size(s: 100),height: Common.Size(s:16))
        provider.text = "\(so.Provider)"
        
        
        
        giaTien.frame = CGRect(x:provider.frame.origin.x + provider.frame.size.width - Common.Size(s: 10) ,y: Common.Size(s:10),width: sdt.frame.size.width ,height: Common.Size(s:16))
        let gia = Common.convertCurrencyV2(value: so.PriceSale)
        giaTien.text = "\(gia) Đ"
        
    }
    
    
}
