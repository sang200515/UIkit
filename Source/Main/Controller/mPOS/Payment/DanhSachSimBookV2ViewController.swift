//
//  DanhSachSimBookV2ViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import Toaster
class DanhSachSimBookV2ViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate{
    
    
    var scrollView:UIScrollView!
    var viewTableListSim:UITableView  =   UITableView()
    var listSim:[SimBookByShopV2] = []
    var viewSim:UIView!
    var barSearchRight : UIBarButtonItem!
    var searchTextFeild:UITextField!
    override func viewDidLoad() {
        navigationController?.navigationBar.isTranslucent = false
        self.title = "Số đã đặt mua"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(DanhSachSimBookV2ViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        let SynsEcom = UIBarButtonItem(title: "Ecom", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.sysEcom(sender:)))
        

        self.navigationItem.rightBarButtonItem = SynsEcom
      
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        getlistData()
    }
    
    func getlistData() {
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy danh sách sim..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.getListSimBookByShopV2(sdt: "") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.listSim = results
                    
                    self.setupUI(list: self.listSim)
                    
                }else{
                    
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                  
                    })
                
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupUI(list: [SimBookByShopV2]){
        let width:CGFloat = UIScreen.main.bounds.size.width
        
        
        searchTextFeild = UITextField(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        searchTextFeild.placeholder = "Nhập số Ecom"
        searchTextFeild.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        searchTextFeild.borderStyle = UITextField.BorderStyle.roundedRect
        searchTextFeild.autocorrectionType = UITextAutocorrectionType.no
        searchTextFeild.keyboardType = UIKeyboardType.numberPad
        searchTextFeild.returnKeyType = UIReturnKeyType.done
        searchTextFeild.clearButtonMode = UITextField.ViewMode.whileEditing;
        searchTextFeild.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        searchTextFeild.delegate = self
        scrollView.addSubview(searchTextFeild)
        searchTextFeild.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        viewTableListSim.frame = CGRect(x: 0, y:searchTextFeild.frame.origin.y + searchTextFeild.frame.size.height  + Common.Size(s: 5), width: width, height: Common.Size(s: 450) )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        viewTableListSim.dataSource = self
        viewTableListSim.delegate = self
        viewTableListSim.register(ItemSimBookByShopV2TableViewCell.self, forCellReuseIdentifier: "ItemSimBookByShopV2TableViewCell")
        viewTableListSim.tableFooterView = UIView()
        viewTableListSim.backgroundColor = UIColor.white
        
        scrollView.addSubview(viewTableListSim)
        //navigationController?.navigationBar.isTranslucent = false
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTableListSim.frame.origin.y + viewTableListSim.frame.size.height + Common.Size(s: 20) + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    
    @objc func sysEcom(sender: UIBarButtonItem)
    {
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy danh sách sim..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.getListSimBookByShopV2(sdt: "0") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.listSim.removeAll()
                    self.listSim = results
                    self.viewTableListSim.reloadData()
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField == searchTextFeild){
            let key = textField.text!
            if(key.count > 0){
                
                let newViewController = LoadingViewController()
                newViewController.content = "Đang lấy danh sách sim..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                MPOSAPIManager.getListSimBookByShopV2(sdt: key) { (results, err) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            self.listSim.removeAll()
                            self.listSim = results
                            self.viewTableListSim.reloadData()
                            
                        }else{
                            let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                
                            })
                            
                            self.present(alert, animated: true)
                        }
                    }
                }
                
            }else{
                
                
                let newViewController = LoadingViewController()
                newViewController.content = "Đang lấy danh sách sim..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                MPOSAPIManager.getListSimBookByShopV2(sdt: "") { (results, err) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            self.listSim.removeAll()
                            self.listSim = results
                            self.viewTableListSim.reloadData()
                            
                        }else{
                            let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                
                            })
                            
                            self.present(alert, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSim.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemSimBookByShopV2TableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemSimBookByShopV2TableViewCell")
        let item:SimBookByShopV2 = self.listSim[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:150);
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item:SimBookByShopV2 = self.listSim[indexPath.row]
        let title = "Thông báo"
     
        
        let thongbao = "Vui lòng chọn loại sim bạn muốn kích hoạt ?"
        let popup = PopupDialog(title: title, message: thongbao, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            print("Completed")
        }
        
        let simActive:SimActive = SimActive(ID: 0,Provider: "",Status: "",Phonenumber: "",SeriSIM: "",FullName: "",Birthday: "",Gender: 0,Address: "",CMND: "",DateCreateCMND: "",PalaceCreateCMND: "",ProvinceCode: "",DistrictCode: "",PrecinctCode: "",URL_FileCMNDMatTruoc: "",URL_FileCMNDMatSau: "",URL_FilePhieuDKTT: "",URL_FileKH_TaiShop: "",Note: "",GoiCuoc: "",ProductName: "",ProductCode: "", TypeKichHoat: 0,POSSODocNum: "",Passport: "", DayGrantPassport: "",Nationality: "",LoaiGiayTo: 0,SoVisa: "",NoiCapPassport:"",TenShop: "",DiaChiShop: "",TenNhanVien:"",SSD:"")
        
        debugPrint("pakagetype = \(item.PackageType)")
        //  PackageType = 1 ==> sim thường, 2 ==> esim, 3 cả 2
        if item.Provider.lowercased() == "viettel" || item.Provider.lowercased() == "mobifone" {
            let buttonTwo = CancelButton(title: "Không"){ }
            let buttonOne = CancelButton(title: "Book sim") {
                self.activeSimThuong(item: item, simActive: simActive)
            }
            popup.addButtons([buttonOne,buttonTwo])
            self.present(popup, animated: true, completion: nil)
            return
        }

		if item.Provider.lowercased() == "vinaphone"  {
			let model:SimV2 = SimV2(STT: indexPath.row,
									ProductID: item.PhoneNumber,
									Provider: item.Provider.lowercased(),
									Gia: item.GiaSim,
									PriceSale: 0,
									SimTypeName: "\(item.type)",
									MSPdichvu: item.MaGoiCuoc,
									TenSPDichVu: item.TenGoiCuoc)
			let vc = CustomerBooksimVinaphoneVC()
			let cache:DataBookSimV2 = DataBookSimV2(CardName: "",
													GiaCuoc: item.GiaGoiCuocActive,
													IsSubsidy: item.GiaCuoc,
													MaGoiCuoc: item.MaGoiCuoc,
													Message: "",
													PackofData: "",
													PhoneNumber: item.PhoneNumber,
													Provider: item.Provider.lowercased(),
													Result: 0,
													ShopCode: "",
													SoEcom: "\(item.Ecomnum)",
													SoMpos: item.SoMpos,
													TenGoiCuoc: item.TenGoiCuoc,
													type: item.PackageType)
			Cache.packageBookSim = cache
			vc.typeBookSim = "3"
			vc.model = model
			self.navigationController?.pushViewController(vc, animated: true)
			return
		}else {
			if item.PackageType == 1 {
				let buttonTwo = CancelButton(title: "Không"){ }
				let buttonOne = CancelButton(title: "Sim Thường") {
					self.activeSimThuong(item: item, simActive: simActive)
				}
				popup.addButtons([buttonOne,buttonTwo])

			} else if item.PackageType == 2 {
				let buttonTwo = CancelButton(title: "Không"){ }
				let buttonThree = CancelButton(title: "Esim"){
					self.activeEsim(item: item, simActive: simActive)
				}
				popup.addButtons([buttonThree,buttonTwo])
			}

			if item.PackageType != 1 && item.PackageType != 2 {
				self.showAlert("Số thuê bao \(item.PhoneNumber) có PackageType = \(item.PackageType) nên không thể thao tác tiếp, vui lòng liên hệ DEV để được hỗ trợ, xin cảm ơn!")
			} else {
				self.present(popup, animated: true, completion: nil)
			}
		}
        

    }
    
    func activeSimThuong(item:SimBookByShopV2, simActive:SimActive) {
        let newViewController = DetailSimCRMViewControllerV2()
        simActive.POSSODocNum = "\(item.SoMpos)"
        simActive.GoiCuoc = item.PackofData
        simActive.ProductCode = item.MaGoiCuoc
        simActive.ProductName = item.TenGoiCuoc
        simActive.Provider = item.Provider
        simActive.FullName = item.CardName
        simActive.Phonenumber = item.PhoneNumber
        simActive.LoaiGiayTo = 1
        simActive.ID = item.SoMpos
        if(item.Provider.lowercased() == "viettel"){
            simActive.Nationality = "232"
            let alert = UIAlertController(title: "Thông báo", message: "Bạn vui lòng vào app Mbccs của Viettel kích SĐT: \(item.PhoneNumber) và quay lại xác nhận để phát sinh đơn hàng sau khi kích hoạt thành công!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { action in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        if(item.Provider == "Mobifone" || item.Provider == "mobifone"){
            simActive.Nationality = "VNM"
            
            let alert = UIAlertController(title: "Thông báo", message: "Bạn vui lòng vào app MSale của mobifone kích SDT: \(item.PhoneNumber) và quay lại xác nhận để phát sinh đơn hàng sau khi kích hoạt thành công!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { action in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        if(item.Provider == "Vinaphone" || item.Provider == "vinaphone"){
            simActive.Nationality = "232"
        }
        if(item.Provider == "vietnammobile" || item.Provider == "VietnamMobile" || item.Provider == "Vietnammobile"){
            simActive.Nationality = "232"
        }
        if(item.Provider.lowercased() == "itelecom"){
            simActive.Nationality = "232"
        }
        if(item.IsSubsidy == 0){
            simActive.SSD = "N"
        }else{
            simActive.SSD = "Y"
        }
        newViewController.simActive = simActive
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func activeEsim(item:SimBookByShopV2, simActive:SimActive) {
        let newViewController = DetailEsimViewController()
        simActive.POSSODocNum = "\(item.SoMpos)"
        simActive.GoiCuoc = item.PackofData
        simActive.ProductCode = item.MaGoiCuoc
        simActive.ProductName = item.TenGoiCuoc
        simActive.Provider = item.Provider
        simActive.FullName = item.CardName
        simActive.Phonenumber = item.PhoneNumber
        simActive.LoaiGiayTo = 1
        simActive.ID = item.SoMpos
        if(item.Provider == "Viettel" || item.Provider == "viettel"){
            simActive.Nationality = "232"
        }
        if(item.Provider == "Mobifone" || item.Provider == "mobifone"){
            simActive.Nationality = "VNM"
        }
        if(item.Provider == "Vinaphone" || item.Provider == "vinaphone"){
            simActive.Nationality = "232"
        }
        if(item.Provider == "vietnammobile" || item.Provider == "VietnamMobile" || item.Provider == "Vietnammobile"){
            simActive.Nationality = "232"
        }
        if(item.Provider.lowercased() == "itelecom"){
            simActive.Nationality = "232"
        }
        if(item.IsSubsidy == 0){
            simActive.SSD = "N"
        }else{
            simActive.SSD = "Y"
        }
        newViewController.simActive = simActive
        self.navigationController?.pushViewController(newViewController, animated: true)
    }

    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            
            let so:SimBookByShopV2 = self.listSim[indexPath.row]
            
            let alert = UIAlertController(title: "Huỷ book sim", message: "Bạn có chắc huỷ book sim này: \(so.PhoneNumber)?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                let newViewController = LoadingViewController()
                newViewController.content = "Đang huỷ book sim..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                MPOSAPIManager.huyBookSoV2(phoneNumber: so.PhoneNumber) { (results, err) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            
                            let alert = UIAlertController(title: "Thông báo", message: results!.Message, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                if(Cache.phoneNumberBookSim != ""){
                                    if(Cache.phoneNumberBookSim == so.PhoneNumber){
                                        Cache.phoneNumberBookSim = ""
                                        
                                        
                                        //remove khoi gio hang
                                        if(Cache.carts.count > 0){
                                            var isInetent:Bool = false
                                            for item in Cache.carts{
                                                if(item.sku == "00503355"){
                                                    Cache.carts.removeEqualItems(item: item)
                                                    isInetent = true
                                                    break
                                                }
                                            }
                                            if(isInetent == true){
                                                let newViewController = CartViewController()
                                                self.navigationController?.pushViewController(newViewController, animated: true)
                                            }
                                        }
                                    }
                                }
                                
                                let newViewController = LoadingViewController()
                                newViewController.content = "Đang lấy danh sách sim..."
                                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                                self.navigationController?.present(newViewController, animated: true, completion: nil)
                                let nc = NotificationCenter.default
                                
                                MPOSAPIManager.getListSimBookByShopV2(sdt: "") { (results, err) in
                                    let when = DispatchTime.now() + 0.5
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                        if(err.count <= 0){
                                            guard indexPath.row < self.listSim.count else { return }
                                            self.listSim.remove(at: indexPath.row)
                                            self.viewTableListSim.reloadData()
                                        }else{
                                            let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                                            
                                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                                
                                            })
                                            self.present(alert, animated: true)
                                        }
                                    }
                                }
                            })
                            
                            alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel) { _ in
                                
                            })
                            self.present(alert, animated: true)
                            
                            
                            
                        }else{
                            let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                               
                            })
                            self.present(alert, animated: true)
                        }
                    }
                }
            })
            
            alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
            
        }
    }
}


class ItemSimBookByShopV2TableViewCell: UITableViewCell {
    var sothuebao: UILabel!
    var topStackView: UIStackView!
    var copyImage: UIImageView!
    var tenGoiCuoc:UILabel!
    var sompos: UILabel!
    var tenkhachhang: UILabel!
    var tongtien:UILabel!
    var EcomNum:UILabel!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        sothuebao = UILabel()
        sothuebao.textColor = UIColor.black
        sothuebao.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        sothuebao.numberOfLines = 1
        topStackView = UIStackView()
        topStackView.spacing = 10
        contentView.addSubview(topStackView)
        copyImage = UIImageView()
        let newuiview = UIView()
        newuiview.backgroundColor = .white
        topStackView.addArrangedSubview(sothuebao)
        topStackView.addArrangedSubview(copyImage)
        copyImage.image = UIImage(named: "Copy")
        copyImage.translatesAutoresizingMaskIntoConstraints = false
        copyImage.widthAnchor.constraint(equalToConstant: Common.Size(s: 20)).isActive = true
        copyImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onCopy))
        copyImage.addGestureRecognizer(gesture)
        topStackView.addArrangedSubview(newuiview)
        
        
        tenGoiCuoc = UILabel()
        tenGoiCuoc.textColor = UIColor.black
        
        
        tenGoiCuoc.numberOfLines = 0
        tenGoiCuoc.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        tenGoiCuoc.minimumScaleFactor = 0.8
        
        
        tenGoiCuoc.font = tenGoiCuoc.font.withSize(13)
        contentView.addSubview(tenGoiCuoc)
        
        sompos = UILabel()
        sompos.textColor = UIColor.black
        sompos.numberOfLines = 1
        sompos.font = sompos.font.withSize(13)
        contentView.addSubview(sompos)
        
        EcomNum = UILabel()
        EcomNum.textColor = UIColor.black
        EcomNum.numberOfLines = 1
        EcomNum.font = sompos.font.withSize(13)
        contentView.addSubview(EcomNum)
        
        tenkhachhang = UILabel()
        tenkhachhang.textColor = UIColor.black
        tenkhachhang.numberOfLines = 1
        tenkhachhang.font = tenkhachhang.font.withSize(13)
        contentView.addSubview(tenkhachhang)
        
        tongtien = UILabel()
        tongtien.textColor = UIColor.red
        tongtien.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        tongtien.numberOfLines = 1
        contentView.addSubview(tongtien)
        
        
        
        
    }
    var so1:SimBookByShopV2?
    func setup(so:SimBookByShopV2){
        so1 = so
        
        if(so.type == 1){
            topStackView.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:20))
            sothuebao.text = "Số thuê bao:    \(so.PhoneNumber)"
            
            tenGoiCuoc.frame = CGRect(x: Common.Size(s:10),y: topStackView.frame.origin.y + topStackView.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:30))
            tenGoiCuoc.text = "Tên gói cước:    \(so.TenGoiCuoc)"
            
            tongtien.frame = CGRect(x: Common.Size(s:10),y: tenGoiCuoc.frame.origin.y + tenGoiCuoc.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
            let tongTien = Common.convertCurrencyV2(value: so.GiaCuoc)
            tongtien.text = "Tổng tiền:    \(tongTien) VNĐ"
        }else{
            
            topStackView.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:20))
            sothuebao.text = "Số thuê bao:    \(so.PhoneNumber)"
            
            sompos.frame = CGRect(x: Common.Size(s:10),y: topStackView.frame.origin.y + topStackView.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
            if(so.SoMpos < 0){
                sompos.text = "Số mpos:    \(0)"
            }else{
                sompos.text = "Số mpos:    \(so.SoMpos)"
            }
            
            
            if(so.Ecomnum > 0){
                EcomNum.frame = CGRect(x: Common.Size(s:10),y: sompos.frame.origin.y + sompos.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
                EcomNum.text = "Số Ecom:    \(so.Ecomnum)"
                
                
                tenkhachhang.frame = CGRect(x: Common.Size(s:10),y: EcomNum.frame.origin.y + EcomNum.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
                tenkhachhang.text = "Tên KH:    \(so.CardName)"
                
                tongtien.frame = CGRect(x: Common.Size(s:10),y: tenkhachhang.frame.origin.y + tenkhachhang.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
                let tongTien = Common.convertCurrencyV2(value: so.GiaCuoc)
                tongtien.text = "Tổng tiền:    \(tongTien) VNĐ"
            }else{
                tenkhachhang.frame = CGRect(x: Common.Size(s:10),y: sompos.frame.origin.y + sompos.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
                tenkhachhang.text = "Tên KH:    \(so.CardName)"
                
                tongtien.frame = CGRect(x: Common.Size(s:10),y: tenkhachhang.frame.origin.y + tenkhachhang.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
                let tongTien = Common.convertCurrencyV2(value: so.GiaCuoc)
                tongtien.text = "Tổng tiền:    \(tongTien) VNĐ"
            }
            
            
            
            
        }
        
    }
    
    @objc func onCopy() {
        UIPasteboard.general.string = so1?.PhoneNumber
        Toast.init(text: "copy thành công").show()
    }
    
    
}
extension Array where Element: Equatable {
    
    mutating func removeEqualItems(item: Element) {
        self = self.filter { (currentItem: Element) -> Bool in
            return currentItem != item
        }
    }
    
    
}
