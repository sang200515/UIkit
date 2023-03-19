//
//  ChooseSoGioHangViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/31/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class ChooseSoGioHangViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate {
    var scrollView:UIScrollView!
    var goiCuoc:GoiCuocBookSimV2?
    var nhaMang:String?
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
    override func viewDidLoad() {
        navigationController?.navigationBar.isTranslucent = false
        self.title = "Chọn số"
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y:0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        //        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        //        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        //        scrollView.backgroundColor = UIColor.white
        //        scrollView.showsVerticalScrollIndicator = false
        //        scrollView.showsHorizontalScrollIndicator = false
        //        self.view.addSubview(scrollView)
        //navigationController?.navigationBar.isTranslucent = false
        
        
        
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

		MPOSAPIManager.getListLoaiSimV2(itemCode:itemCode) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.listLoaiSim.removeAll()
                    self.listLoaiSim = results
                    
                    self.setupUI()
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
        
        
        
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
        
        let tapUpdate = UITapGestureRecognizer(target: self, action: #selector(ChooseSoGioHangViewController.timKiem))
        btTimkiem.isUserInteractionEnabled = true
        btTimkiem.addGestureRecognizer(tapUpdate)
        
        //        btChonNgauNhien = UILabel(frame: CGRect(x: btTimkiem.frame.origin.x + btTimkiem.frame.size.width + Common.Size(s: 10), y: tfInputPhone.frame.origin.y + tfInputPhone.frame.size.height + Common.Size(s:10), width: Common.Size(s: 100), height: scrollView.frame.size.width/9))
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
        
        let tabGetListRandomSim = UITapGestureRecognizer(target: self, action: #selector(ChooseSoGioHangViewController.bookSimRandom))
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
        
        
        let tapGetListSimBook = UITapGestureRecognizer(target: self, action: #selector(ChooseSoGioHangViewController.getListSimBookByShop))
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
        viewTableSim.register(ItemSimGioHangV2TableViewCell.self, forCellReuseIdentifier: "ItemSimGioHangV2TableViewCell")
        viewTableSim.tableFooterView = UIView()
        viewTableSim.backgroundColor = UIColor.white
        
        viewSim.addSubview(viewTableSim)
        //        navigationController?.navigationBar.isTranslucent = false
        
        viewSim.frame.size.height = viewTableSim.frame.size.height + viewTableSim.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewSim.frame.origin.y + viewSim.frame.size.height + Common.Size(s: 15))
        
        
        
        
        
        var list:[String] = []
        for item in self.listLoaiSim {
            list.append(item.TypeName)
        }
        self.tfLoaiSim.filterStrings(list)
        self.tfLoaiSim.becomeFirstResponder()
        //        self.tfLoaiSim.text = self.listLoaiSim[0].TypeName
        //        self.selectLoaiSim = self.listLoaiSim[0].ID
        //
        //        self.timKiem()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listSimV2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemSimGioHangV2TableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemSimGioHangV2TableViewCell")
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
        
        
        self.CheckGoiCuocVaSim(phoneNumber: item.ProductID,giaSim: item.PriceSale)
        //        let title = "Thông báo"
        //        let popup = PopupDialog(title: title, message: "Bạn muốn book số: \(item.ProductID)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, gestureDismissal: false) {
        //            print("Completed")
        //        }
        //        let buttonTwo = CancelButton(title: "Không"){
        //
        //        }
        //        let buttonOne = DefaultButton(title: "Có") {
        //            self.CheckGoiCuocVaSim(phoneNumber: item.ProductID,giaSim: item.PriceSale)
        //        }
        //        popup.addButtons([buttonOne,buttonTwo])
        //        self.present(popup, animated: true, completion: nil)
        
        
        //        let newViewController = ChonSoV2ViewController()
        //        newViewController.telecom = self.telecom
        //        newViewController.goiCuoc = item
        //        self.navigationController?.pushViewController(newViewController, animated: true)
        
        
    }
    
    @objc func getListSimBookByShop(){
        let newViewController = DanhSachSimBookV2ViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func timKiem(){
        if(self.tfLoaiSim.text == "" || self.selectLoaiSim == nil){
            //TODO
            //            Toast(text: "Vui lòng chọn loại sim").show()
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
        
        if(self.nhaMang == "Vietnammobile" || self.nhaMang == "vietnammobile" || self.nhaMang == "Vietnamobile"){
            self.nhaMang = "VietnamMobile"
        }
        var listProductCode:[String] = []
        for item in Cache.carts{
            listProductCode.append(item.sku)
        }
        let productCode:String = listProductCode.joined(separator:",")
        MPOSAPIManager.getSearchSimV2(NhaMang: (self.nhaMang)!, ProductID: swiftyString, SimType: "\(self.selectLoaiSim!)",Random: "0",ProductCode: productCode) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.listSimV2.removeAll()
                    self.listSimV2 = results
                    self.viewTableSim.reloadData()
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc func bookSimRandom(){
        
        
        if(self.tfLoaiSim.text == "" || self.selectLoaiSim == nil){
            //TODO
            //            Toast(text: "Vui lòng chọn loại sim").show()
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
        
        if(self.nhaMang == "Vietnammobile" || self.nhaMang == "vietnammobile" || self.nhaMang == "Vietnamobile"){
            self.nhaMang = "VietnamMobile"
        }
        
        var listProductCode:[String] = []
        for item in Cache.carts{
            listProductCode.append(item.sku)
        }
        let productCode:String = listProductCode.joined(separator:",")
        MPOSAPIManager.getSearchSimV2(NhaMang: (self.nhaMang)!, ProductID: swiftyString, SimType: "\(self.selectLoaiSim!)",Random: "1",ProductCode: productCode) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.listSimV2.removeAll()
                    self.listSimV2 = [results[0]]
                    self.viewTableSim.reloadData()
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func CheckGoiCuocVaSim(phoneNumber:String,giaSim:Int){
        
        
        let rDR1 = parseXMLProduct().toBase64()
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin sim..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.checkGoiCuocVaSim(ProductCode: (self.goiCuoc?.MaSP)!, PhoneNumber: phoneNumber,xmlrdr1: rDR1) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                //nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    //Toast(text: "\(results[0].Result )").show()
                    if(results[0].Result == 0){
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        let alert = UIAlertController(title: "Thông báo", message: results[0].Message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }else{
                        //self.bookSim(phoneNumber: phoneNumber, giaSim: giaSim)
                        self.addGioHang(phoneNumber: phoneNumber, giaSim: giaSim)
                        
                        //                        MPOSAPIManager.getProductBySku(sku: "00503355",handler: { (success , error) in
                        //                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        //                            if(success != nil){
                        //                                var product1:ProductBySku!
                        //                                product1 = success!
                        //                                let sku = product1.product.sku
                        //                                let colorProduct = product1.variant[0].colorValue
                        //                                let priceBeforeTax = product1.variant[0].priceBeforeTax
                        //                                // let price = product1.variant[0].price
                        //                                let price = Float(giaSim)
                        //                                let product = product1.product.copy() as! Product
                        //
                        //                                product.sku = sku
                        //                                product.price = price
                        //                                product.priceBeforeTax = priceBeforeTax
                        //
                        //                                let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "N/A",price: price, priceBT: priceBeforeTax, whsCode: "")
                        //                                Cache.carts.append(cart)
                        //                                Cache.itemsPromotion.removeAll()
                        //
                        //
                        //
                        //                                let newViewController = CartViewController()
                        //                                self.navigationController?.pushViewController(newViewController, animated: true)
                        //
                        //                            }else{
                        //
                        //                            }
                        //
                        //                        })
                    }
                    
                }else{
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let alert = UIAlertController(title: "Thông báo", message: results[0].Message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func addGioHang(phoneNumber:String,giaSim:Int){
//        if(Cache.phoneNumberBookSim != ""){
            self.tfInputPhone.resignFirstResponder()
            self.tfLoaiSim.resignFirstResponder()
            //TODO
            //            Toast(text: "Bạn đã book số không được book thêm !").show()
//            return
//        }
        let nc = NotificationCenter.default
        let alert = UIAlertController(title: "Thông báo", message: "Bạn có muốn thêm số \(phoneNumber) vào giỏ hàng?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
            
            
            if(Cache.phoneNumberBookSim != ""){
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let newViewController = CartViewController()
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
                Cache.phoneNumberBookSim = phoneNumber
                return
            }
            Cache.phoneNumberBookSim = phoneNumber
            let newViewController = LoadingViewController()
            newViewController.content = "Đang thêm vào giỏ hàng..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            
            
            
            ProductAPIManager.product_detais_by_sku(sku: "00503355",handler: { (success , error) in
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(success.count > 0){
                    var product1:ProductBySku!
                    product1 = success[0]
                    let sku = product1.product.sku
                    let colorProduct = product1.product.ecomColorName
                    let priceBeforeTax = product1.product.priceBeforeTax
                    // let price = product1.variant[0].price
                    let price = Float(giaSim)
                    let product = product1.product.copy() as! Product
                    
                    product.sku = sku
                    product.price = price
                    product.priceBeforeTax = priceBeforeTax
                    
                    let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "N/A",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                    Cache.carts.append(cart)
                    Cache.itemsPromotion.removeAll()
                    
                    
                    
                    let newViewController = CartViewController()
                    self.navigationController?.pushViewController(newViewController, animated: true)
                    
                }else{
                    
                }
                
            })
        })
        
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
        
    }
    
    
    func bookSim(phoneNumber:String,giaSim:Int){
        if(Cache.phoneNumberBookSim != ""){
            self.tfInputPhone.resignFirstResponder()
            self.tfLoaiSim.resignFirstResponder()
            //TODO
            //            Toast(text: "Bạn đã book số không được book thêm !").show()
            return
        }
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang book sim..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.dangKyBookSoV2(tenKH: (self.goiCuoc?.tenKH)!, NhaMang: self.nhaMang!, phoneNumber: phoneNumber, maGoiCuoc: (self.goiCuoc?.MaSP)!, tenGoiCuoc: (self.goiCuoc?.TenSP)!, giaGoiCuoc: (self.goiCuoc?.GiaCuoc)!, giaSim: giaSim) { (results,IsLogin,p_Status, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                // nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(IsLogin == "1"){
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
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
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let title = "Thông báo"
                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
 
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    return
                    
                }
                if(err.count <= 0){
                    if(results.Success == true){
                        if(results.Result == "1"){
                            Cache.phoneNumberBookSim = phoneNumber
                            let title = "Thông báo"
                            let popup = PopupDialog(title: title, message: results.Message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                                
                                
                                
                            }
                            let buttonOne = CancelButton(title: "OK") {

                                ProductAPIManager.product_detais_by_sku(sku: "00503355",handler: { (success , error) in
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    if(success.count > 0){
                                        var product1:ProductBySku!
                                        product1 = success[0]
                                        let sku = product1.product.sku
                                        let colorProduct = product1.variant[0].colorValue
                                        let priceBeforeTax = product1.variant[0].priceBeforeTax
                                        // let price = product1.variant[0].price
                                        let price = Float(giaSim)
                                        let product = product1.product.copy() as! Product
                                        
                                        product.sku = sku
                                        product.price = price
                                        product.priceBeforeTax = priceBeforeTax
                                        
                                        let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "N/A",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                        Cache.carts.append(cart)
                                        Cache.itemsPromotion.removeAll()
      
                                        let newViewController = CartViewController()
                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                        
                                    }else{
                                        
                                    }
                                    
                                })
                                
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }else{
                            let title = "Thông báo"
                            let popup = PopupDialog(title: title, message: results.Message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                        
                        
                        
                    }else{
                        let title = "Thông báo"
                        let popup = PopupDialog(title: title, message: results.Message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                    
                    
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
        }
    }
    
    
    func parseXMLProduct()->String{
        var rs:String = "<line>"
        for item in Cache.carts {
            var name = item.product.name
            name = name.replace(target: "&", withString:"&#38;")
            name = name.replace(target: "<", withString:"&#60;")
            name = name.replace(target: ">", withString:"&#62;")
            name = name.replace(target: "\"", withString:"&#34;")
            name = name.replace(target: "'", withString:"&#39;")
            
            if(item.imei == "N/A"){
                item.imei = ""
            }
            
            item.imei = item.imei.replace(target: "&", withString:"&#38;")
            item.imei = item.imei.replace(target: "<", withString:"&#60;")
            item.imei = item.imei.replace(target: ">", withString:"&#62;")
            item.imei = item.imei.replace(target: "\"", withString:"&#34;")
            item.imei = item.imei.replace(target: "'", withString:"&#39;")
            
            rs = rs + "<item PhoneNumber=\"\(Cache.phoneNumberBookSim)\" U_ItmCod=\"\(item.product.sku)\" U_Imei=\"\(item.imei)\" U_Quantity=\"\(item.quantity)\"  U_Price=\"\(String(format: "%.6f", item.product.price))\" U_WhsCod=\"\(Cache.user!.ShopCode)010\" U_ItmName=\"\(name)\"/>"
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
}

class ItemSimGioHangV2TableViewCell: UITableViewCell {
    
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

