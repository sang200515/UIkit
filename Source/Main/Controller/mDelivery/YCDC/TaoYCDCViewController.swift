//
//  TaoYCDCViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 18/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import DropDown
import Toaster
class TaoYCDCViewController: UIViewController, UITextFieldDelegate,ProductWarehouseDelegate,ConfirmPopupDelegate {
    
    
    
    
    
    var headerView: UIView!
    var footerView: UIView!
    var bodyView: UIView!
    var parentNavigationController: UINavigationController?
    var tfProduct:UITextField!
//    var product: Product?
    var tfAmount,tfWhReCode:UITextField!
    var listItems: [ItemYCDC] = []
    var infoView: UIView!
    var lbShop,lbWarehouse, lbCountProduct:UILabel!
    var tableView: UITableView!
    var heightBody: CGFloat = 0
    var heightFooter: CGFloat = 0
    var dropDown = DropDown()
    var listWhs:[ItemWhs] = []
    var itemWhs: ItemWhs? = nil
    var isOldProduct: Bool = false
    var viewTFProduct: UIView!
    
    var itemCode: String = ""
//    var itemName: String = ""
//    var manSerNum: String = ""
    var checkboxOldProduct: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width/4))
        headerView.backgroundColor = .white
        self.view.addSubview(headerView)
        
        let lbTextOldProduct = UILabel(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s:10), width: self.view.frame.width/5, height: Common.Size(s:30)))
        lbTextOldProduct.textAlignment = .left
        lbTextOldProduct.textColor = UIColor.black
        lbTextOldProduct.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextOldProduct.text = "Tìm máy cũ: "
        headerView.addSubview(lbTextOldProduct)
        
        lbTextOldProduct.frame.origin.y = Common.Size(s:10) + Common.Size(s:30)/2 - lbTextOldProduct.frame.height/2
        
//        let switchCheckStock = UISwitch(frame: CGRect(x:  lbTextOldProduct.frame.origin.x + lbTextOldProduct.frame.size.width + Common.Size(s:5), y: Common.Size(s:10), width: Common.Size(s:30), height: Common.Size(s:30)))
//
//        switchCheckStock.onTintColor = UIColor(netHex:0x00955E)
//        switchCheckStock.isOn = false // or false
//        switchCheckStock.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
//        headerView.addSubview(switchCheckStock)
        
        checkboxOldProduct = UIImageView(frame: CGRect(x: lbTextOldProduct.frame.origin.x + lbTextOldProduct.frame.size.width + Common.Size(s:5), y: Common.Size(s:10), width: Common.Size(s:20), height: Common.Size(s:30)))
        checkboxOldProduct.image = #imageLiteral(resourceName: "ic-checkbox")
        checkboxOldProduct.contentMode = .scaleAspectFit
        headerView.addSubview(checkboxOldProduct)
        lbTextOldProduct.frame.size.height = checkboxOldProduct.frame.size.height
        isOldProduct = false
        let tapCheckOldProduct = UITapGestureRecognizer(target: self, action: #selector(self.tapCheckOldProduct))
        checkboxOldProduct.addGestureRecognizer(tapCheckOldProduct)
        checkboxOldProduct.isUserInteractionEnabled = true
        
        
        let lbTextCMND = UILabel(frame: CGRect(x: Common.Size(s:10), y:  checkboxOldProduct.frame.origin.y + checkboxOldProduct.frame.size.height + Common.Size(s:10), width: self.view.frame.width/5, height: Common.Size(s:30)))
        lbTextCMND.textAlignment = .left
        lbTextCMND.textColor = UIColor.black
        lbTextCMND.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextCMND.text = "Sản phẩm: "
        lbTextCMND.sizeToFit()
        headerView.addSubview(lbTextCMND)
        
        lbTextCMND.frame.origin.y = (checkboxOldProduct.frame.origin.y + checkboxOldProduct.frame.size.height + Common.Size(s:10)) + Common.Size(s:30)/2 - lbTextCMND.frame.height/2
        
        tfProduct = UITextField(frame: CGRect(x: lbTextCMND.frame.origin.x + lbTextCMND.frame.size.width + Common.Size(s:5), y:   checkboxOldProduct.frame.origin.y + checkboxOldProduct.frame.size.height + Common.Size(s:10) , width: self.view.frame.width - ( lbTextCMND.frame.origin.x + lbTextCMND.frame.size.width + Common.Size(s:5) + Common.Size(s:45)) , height: Common.Size(s:30)));
        tfProduct.placeholder = "Tìm kiếm sản phẩm"
        tfProduct.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        tfProduct.borderStyle = UITextField.BorderStyle.roundedRect
        tfProduct.autocorrectionType = UITextAutocorrectionType.no
        tfProduct.keyboardType = UIKeyboardType.default
        tfProduct.returnKeyType = UIReturnKeyType.done
        tfProduct.clearButtonMode = UITextField.ViewMode.whileEditing
        tfProduct.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        headerView.addSubview(tfProduct)
        tfProduct.delegate = self
        
        viewTFProduct = UIView(frame: tfProduct.frame)
        viewTFProduct.clipsToBounds = true
        headerView.addSubview(viewTFProduct)
        
        let tapSearchProduct = UITapGestureRecognizer(target: self, action: #selector(self.searchProduct))
        viewTFProduct.addGestureRecognizer(tapSearchProduct)
        viewTFProduct.isUserInteractionEnabled = true
        
        
        let icBarcode = UIImageView(frame: CGRect(x: tfProduct.frame.origin.x + tfProduct.frame.size.width + Common.Size(s:10), y: tfProduct.frame.origin.y, width: tfProduct.frame.size.height - Common.Size(s:5), height: tfProduct.frame.size.height))
        icBarcode.image = #imageLiteral(resourceName: "barcode")
        icBarcode.contentMode = .scaleAspectFit
        headerView.addSubview(icBarcode)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.scanBarcode))
        icBarcode.addGestureRecognizer(tap)
        icBarcode.isUserInteractionEnabled = true
        
        
        let lbTextAmount = UILabel(frame: CGRect(x: Common.Size(s:10), y: tfProduct.frame.origin.y + tfProduct.frame.size.height + Common.Size(s:10), width: self.view.frame.width/5, height: Common.Size(s:30)))
        lbTextAmount.textAlignment = .left
        lbTextAmount.textColor = UIColor.black
        lbTextAmount.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextAmount.text = "Số lượng: "
        lbTextAmount.sizeToFit()
        headerView.addSubview(lbTextAmount)
        lbTextAmount.frame.origin.y = tfProduct.frame.origin.y + tfProduct.frame.size.height + Common.Size(s:10) + Common.Size(s:30)/2 - lbTextAmount.frame.height/2
        
        tfAmount = UITextField(frame: CGRect(x: tfProduct.frame.origin.x, y:  tfProduct.frame.origin.y + tfProduct.frame.size.height + Common.Size(s:10) , width: tfProduct.frame.width/2, height: Common.Size(s:30)));
        tfAmount.placeholder = "Nhập số lượng"
        tfAmount.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        tfAmount.borderStyle = UITextField.BorderStyle.roundedRect
        tfAmount.autocorrectionType = UITextAutocorrectionType.no
        tfAmount.keyboardType = UIKeyboardType.numberPad
        tfAmount.returnKeyType = UIReturnKeyType.done
        tfAmount.clearButtonMode = UITextField.ViewMode.whileEditing
        tfAmount.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        headerView.addSubview(tfAmount)
        
        let btnSearch = UIButton(frame: CGRect(x: tfAmount.frame.origin.x + tfAmount.frame.size.width + Common.Size(s:10), y: tfAmount.frame.origin.y, width: self.view.frame.width - (tfAmount.frame.origin.x + tfAmount.frame.size.width + Common.Size(s:20)), height: tfAmount.frame.size.height))
        btnSearch.setTitle("TÌM KIẾM", for: .normal)
        btnSearch.backgroundColor = UIColor(netHex:0x00955E)
        btnSearch.setTitleColor(.white, for: .normal)
        btnSearch.layer.cornerRadius = 10
        headerView.addSubview(btnSearch)
        
        let tapSearch = UITapGestureRecognizer(target: self, action: #selector(self.search))
        btnSearch.addGestureRecognizer(tapSearch)
        btnSearch.isUserInteractionEnabled = true
        
        let lineHeader = UIView(frame: CGRect(x: 0, y: tfAmount.frame.origin.y + tfAmount.frame.size.height + Common.Size(s:10), width: self.view.frame.width, height: 0.5))
        lineHeader.backgroundColor = .lightGray
        headerView.addSubview(lineHeader)
        headerView.frame.size.height = lineHeader.frame.origin.y + lineHeader.frame.size.height
        
        //footer
        footerView = UIView(frame: CGRect(x: 0, y: self.view.frame.height - headerView.frame.size.height - self.view.frame.width/5, width: self.view.frame.width, height: self.view.frame.width/6))
        footerView.backgroundColor = .white
        self.view.addSubview(footerView)
        footerView.clipsToBounds = true
        heightFooter = footerView.frame.size.height
        
        
        //        let btnCancel = btnWithImage(image: #imageLiteral(resourceName: "Delete"), title: "Hủy", color: UIColor(netHex:0xd9534f))
        //        btnCancel.frame.origin.x = footerView.frame.size.width/2 + footerView.frame.size.width/4 - btnCancel.frame.size.width/2
        //        footerView.addSubview(btnCancel)
        
        
        let btnSend = btnWithImage(image: #imageLiteral(resourceName: "ic-send"), title: "Gửi YC", color: UIColor(netHex:0x00955E))
        btnSend.frame.origin.x = footerView.frame.size.width/2 - btnSend.frame.size.width/2
        footerView.addSubview(btnSend)
        let tapSendRequest = UITapGestureRecognizer(target: self, action: #selector(self.sendRequest))
        btnSend.addGestureRecognizer(tapSendRequest)
        btnSend.isUserInteractionEnabled = true
        
        
        bodyView = UIView(frame: CGRect(x: 0, y: headerView.frame.origin.y + headerView.frame.size.height, width: headerView.frame.size.width, height: footerView.frame.origin.y - (headerView.frame.origin.y + headerView.frame.size.height)))
        bodyView.backgroundColor = .red
        self.view.addSubview(bodyView)
        
        infoView = UIView(frame: CGRect(x: 0, y: 0, width: bodyView.frame.size.width, height: 100))
        infoView.backgroundColor = .white
        bodyView.addSubview(infoView)
        
        let lbWhRe = UILabel(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s:5), width: self.view.frame.width/5, height: Common.Size(s:20)))
        lbWhRe.textAlignment = .left
        lbWhRe.textColor = UIColor.black
        lbWhRe.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbWhRe.text = "Kho nhận: "
        lbWhRe.sizeToFit()
        infoView.addSubview(lbWhRe)
        lbWhRe.frame.origin.y = Common.Size(s:5) + Common.Size(s:20)/2 - lbWhRe.frame.height/2
        
        
        tfWhReCode = UITextField(frame: CGRect(x: lbWhRe.frame.origin.x + lbWhRe.frame.size.width + Common.Size(s:5), y:  Common.Size(s:5), width: infoView.frame.width - (lbWhRe.frame.origin.x + lbWhRe.frame.size.width + Common.Size(s: 15)), height: Common.Size(s:20)));
        tfWhReCode.placeholder = "Kho hàng nhận"
        tfWhReCode.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
//        tfWhReCode.borderStyle = UITextField.BorderStyle.roundedRect
        tfWhReCode.autocorrectionType = UITextAutocorrectionType.no
        tfWhReCode.keyboardType = UIKeyboardType.numberPad
        tfWhReCode.returnKeyType = UIReturnKeyType.done
        tfWhReCode.clearButtonMode = UITextField.ViewMode.whileEditing
        tfWhReCode.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        infoView.addSubview(tfWhReCode)
        
        DropDown.setupDefaultAppearance()
        dropDown.anchorView = tfWhReCode
        infoView.addSubview(dropDown)
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            tfWhReCode.text = item
            for it in self.listWhs {
                if(it.whsName == item){
                    itemWhs = it
                    break
                }
            }
        }
        
//        let tapSelectWhRe = UITapGestureRecognizer(target: self, action: #selector(self.tapSelectWhRe))
//        tfWhReCode.addGestureRecognizer(tapSelectWhRe)
        tfWhReCode.isUserInteractionEnabled = false
        
        
        let lbTextShop = UILabel(frame: CGRect(x: Common.Size(s:10), y: tfWhReCode.frame.origin.y + tfWhReCode.frame.size.height, width: self.view.frame.width/5, height: Common.Size(s:30)))
        lbTextShop.textAlignment = .left
        lbTextShop.textColor = UIColor.black
        lbTextShop.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextShop.text = "Shop xuất: "
        lbTextShop.sizeToFit()
        infoView.addSubview(lbTextShop)
        lbTextShop.frame.origin.y = (tfWhReCode.frame.origin.y + tfWhReCode.frame.size.height) + Common.Size(s:20)/2 - lbTextShop.frame.height/2
        
        lbShop = UILabel(frame: CGRect(x: lbTextShop.frame.origin.x + lbTextShop.frame.size.width , y: tfWhReCode.frame.origin.y + tfWhReCode.frame.size.height, width: infoView.frame.width - (lbTextShop.frame.origin.x + lbTextShop.frame.size.width + Common.Size(s:10)), height: Common.Size(s:20)))
        lbShop.textAlignment = .left
        lbShop.textColor = UIColor.black
        lbShop.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbShop.text = ""
        infoView.addSubview(lbShop)
        
        
        let lbTextWarehouse = UILabel(frame: CGRect(x: Common.Size(s:10), y: lbShop.frame.origin.y + lbShop.frame.size.height, width: self.view.frame.width/5, height: Common.Size(s:30)))
        lbTextWarehouse.textAlignment = .left
        lbTextWarehouse.textColor = UIColor.black
        lbTextWarehouse.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextWarehouse.text = "Kho xuất: "
        lbTextWarehouse.sizeToFit()
        infoView.addSubview(lbTextWarehouse)
        lbTextWarehouse.frame.origin.y = (lbShop.frame.origin.y + lbShop.frame.size.height) + Common.Size(s:20)/2 - lbTextWarehouse.frame.height/2
        
        lbWarehouse = UILabel(frame: CGRect(x: lbShop.frame.origin.x, y: lbShop.frame.origin.y + lbShop.frame.size.height, width: lbShop.frame.size.width, height: Common.Size(s:20)))
        lbWarehouse.textAlignment = .left
        lbWarehouse.textColor = UIColor.black
        lbWarehouse.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbWarehouse.text = ""
        infoView.addSubview(lbWarehouse)
        
        lbCountProduct = UILabel(frame: CGRect(x: lbTextWarehouse.frame.origin.x, y: lbWarehouse.frame.origin.y + lbWarehouse.frame.size.height, width: lbShop.frame.size.width, height: Common.Size(s:20)))
        lbCountProduct.textAlignment = .left
        lbCountProduct.textColor = UIColor.red
        lbCountProduct.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbCountProduct.text = "Danh sách xin hàng: 0"
        infoView.addSubview(lbCountProduct)
        infoView.frame.size.height = lbCountProduct.frame.origin.y + lbCountProduct.frame.size.height + Common.Size(s:5)
        
        tableView = UITableView(frame: CGRect(x: 0, y: infoView.frame.origin.y + infoView.frame.size.height, width: bodyView.frame.size.width, height: bodyView.frame.size.height - (infoView.frame.origin.y + infoView.frame.size.height)))
        bodyView.addSubview(tableView)
        tableView.register(ProductWarehouseCell.self, forCellReuseIdentifier: "ProductWarehouseCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        heightBody = bodyView.frame.size.height
        bodyView.clipsToBounds = true
        bodyView.frame.size.height = 0
        footerView.frame.size.height = 0
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(refreshYCDC), name: Notification.Name("refreshYCDC"), object: nil)
        
        APIManager.masterdataWhs { result in
            if(result.count > 0){
                self.listWhs = result
                var rs: [String] = []
                for item in self.listWhs {
                    rs.append(item.whsName)
//                    if(self.itemWhs == nil){
//                        self.itemWhs = item
//                        self.tfWhReCode.text = item.whsName
//                    }
                }
                self.dropDown.dataSource = rs
            }
        }
    }
   
    @objc func tapCheckOldProduct() {
        if(!isOldProduct){
            checkboxOldProduct.image = #imageLiteral(resourceName: "ic-checkbox-seleted")
            isOldProduct = true
            viewTFProduct.frame.size.height = 0
            self.tfProduct.text = ""
            self.tfAmount.text = ""
            self.itemCode = ""
        }else{
            checkboxOldProduct.image = #imageLiteral(resourceName: "ic-checkbox")
            isOldProduct = false
            viewTFProduct.frame.size.height = tfProduct.frame.size.height
        }
    }
    @objc func refreshYCDC(notification:Notification) -> Void {
        if(tfProduct != nil && tfAmount != nil){
            self.listItems.removeAll()
            self.tfProduct.text = ""
            self.tfAmount.text = ""
            self.itemWhs = nil
            self.itemCode = ""
            self.updateUI()
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(tfWhReCode == textField){
            return false
        }
        if(!isOldProduct && tfProduct == textField){
            return false
        }
        return true
    }
    @objc func btnWithImage(image: UIImage, title: String, color: UIColor) -> UIView
    {
        let btnCancel = UIView(frame: CGRect(x: 10, y: 10, width: self.view.frame.width/3, height: Common.Size(s:30)))
        btnCancel.backgroundColor = color
        btnCancel.layer.cornerRadius = 10
        let icBtn = UIImageView(frame: CGRect(x: btnCancel.frame.size.height/4, y: btnCancel.frame.size.height/4, width: btnCancel.frame.size.height/2, height: btnCancel.frame.size.height/2))
        icBtn.image = image
        icBtn.contentMode = .scaleAspectFit
        icBtn.tintColor = .white
        btnCancel.addSubview(icBtn)
        
        let lbBtn = UILabel(frame: CGRect(x: icBtn.frame.size.width
                                            + icBtn.frame.origin.x, y: 0, width: btnCancel.frame.size.width - (icBtn.frame.size.width + icBtn.frame.origin.x + btnCancel.frame.size.height/4), height: btnCancel.frame.size.height))
        lbBtn.textAlignment = .center
        lbBtn.textColor = UIColor.white
        lbBtn.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbBtn.text = title
        btnCancel.addSubview(lbBtn)
        return btnCancel
    }
    @objc func searchProduct()
    {
        let newViewController = SearchProductViewController()
        newViewController.selectProduct = { [weak self] (result) in
            self?.tfProduct.text = result.name
            self?.itemCode = result.sku
        }
        self.parentNavigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func tapSelectWhRe()
    {
        dropDown.show()
    }
    
    @objc func scanBarcode()
    {
//        let vc = ConfirmPopupViewController()
//        vc.modalPresentationStyle = .overFullScreen
//        vc.modalTransitionStyle = .crossDissolve
//        vc.delegate = self
//        present(vc, animated: true)
        
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { text in
            if(!self.isOldProduct){
                ProductAPIManager.searchProduct(keyword: "\(text)",inventory: 0) { (results, err) in
                    if(results.count > 0){
                        let result = results[0]
                        self.tfProduct.text = result.name
                        self.itemCode = result.sku
                    }
                }
            }else{
                self.tfProduct.text = text
                self.itemCode = text
            }
        }
        self.parentNavigationController?.present(viewController, animated: false, completion: nil)
    }
    @objc func search()
    {
        if(isOldProduct && self.itemCode == ""){
            self.itemCode = tfProduct.text!
        }
        view.endEditing(true)
        let amount = self.tfAmount.text ?? "0"
        if(amount != "" && amount != "0"  && self.itemCode != ""){
            let quantity = Int("\(amount)") ?? 0
            let newViewController = CheckWarehouseViewController()
            newViewController.amount = quantity
            newViewController.sku = self.itemCode
            newViewController.selectWarehouse = { [weak self] (result) in
                self?.addWarehouse(warehouse: result,amount: quantity)
            }
            self.parentNavigationController?.pushViewController(newViewController, animated: true)
        }else{
            if(self.itemCode == ""){
                showAlert(message: "Bạn phải chọn sản phẩm!")
            }else{
                showAlert(message: "Bạn phải nhập số lượng!")
            }
        }
    }
    func addWarehouse(warehouse: ItemWarehouse,amount: Int){
        if(listItems.count > 0){
            var error = ""
            var isExist = false
            for i in 0..<listItems.count {
                if(listItems[i].warehouse.whsCode != warehouse.whsCode){
                    error = "Bạn phải chọn sản phẩm ở cùng Shop cùng Kho xuất!"
                    break
                }
                if(listItems[i].itemCode == self.itemCode){
                    listItems[i].amount = listItems[i].amount + amount
                    isExist = true
                }
            }
            if(error != ""){
                DispatchQueue.main.async {
                    self.showAlert(message: error)
                }
            }else if(!isExist){
                listItems.append(ItemYCDC(itemCode: warehouse.itemCode, itemName: warehouse.itemName, warehouse: warehouse, amount: amount, manSerNum: warehouse.manSerNum))
            }
        }else{
            listItems.append(ItemYCDC(itemCode: warehouse.itemCode, itemName: warehouse.itemName, warehouse: warehouse, amount: amount, manSerNum: warehouse.manSerNum))
            
            let index = warehouse.whsCode.index(warehouse.whsCode.endIndex, offsetBy: -3)
            let whsRec = "\(Cache.user!.ShopCode)\(warehouse.whsCode.suffix(from: index))"
            for item in listWhs {
                if(item.whsCode == whsRec){
                    self.itemWhs = item
                    self.tfWhReCode.text = item.whsName
                    break
                }
            }
        }
        updateUI()
    }
    func showAlert(message: String){
        let alert = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        let okaction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alert.addAction(okaction)
        self.present(alert, animated: true, completion: nil)
    }
    @objc func updateUI(){
        if(listItems.count > 0){
            bodyView.frame.size.height = heightBody
            footerView.frame.size.height = heightFooter
            lbShop.text = listItems[0].warehouse.shopName
            lbWarehouse.text = listItems[0].warehouse.whsName
            lbCountProduct.text = "Danh sách xin hàng: \(listItems.count)"
            tableView.reloadData()
        }else{
            tableView.reloadData()
            bodyView.frame.size.height = 0
            footerView.frame.size.height = 0
            self.itemWhs = nil
            self.tfWhReCode.text = ""
        }
    }
    @objc func handleSendRequest(note: String){
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.listItems.removeAll()
            self.tfProduct.text = ""
            self.tfAmount.text = ""
            self.itemCode = ""
            self.updateUI()
        }
    }
    @objc func sendRequest(){
        if(itemWhs != nil){
            if(listItems.count > 0){
                let warehouse = listItems[0].warehouse
                
                let whsRec = "\(itemWhs!.whsCode)"
                let distance =  Int(warehouse.distance) ?? 0
                let header = HeaderRequestYCDC(createBy: "\(Cache.user!.UserName)", u_ShpCod: "\(Cache.user!.ShopCode)", u_ShpRec: warehouse.shopCode, u_EmpNReq: "\(Cache.user!.EmployeeName)", u_EmpReq: "\(Cache.user!.UserName)", u_IPAdd: "", u_OS: "2", is5Km: distance < 5000 ? "1" : "0", remark: "")
                
                var arrayBody: [BodyRequestYCDC] = []
                for i in 0..<listItems.count {
                    let item = listItems[i]
                    let body = BodyRequestYCDC(u_ItemCode: item.itemCode, u_ItemName: item.itemName, u_Qutity: "\(item.amount)", u_WhsEx: item.warehouse.whsCode, u_WhsRec: whsRec, u_ShpRec_D: "\(Cache.user!.ShopCode)", u_ShpEx: item.warehouse.shopCode, lineID: "\(i+1)", u_OhanEx: "0", mansernum: item.manSerNum, is5KM_D: "", isOver: "")
                    arrayBody.append(body)
                }
                let param = RequestYCDC(user: "\(Cache.user!.UserName)", shopCode: "\(Cache.user!.ShopCode)", header: header, details: arrayBody)
                
                
                let newViewController = LoadingViewController();
                newViewController.content = "Đang tạo YCDC..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.parentNavigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                APIManager.createYCDC(param: param) { (reponse, msg) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(reponse != ""){
                            Toast.init(text: "\(msg)").show()
                            let vc = ConfirmPopupViewController()
                            vc.modalPresentationStyle = .overFullScreen
                            vc.modalTransitionStyle = .crossDissolve
                            vc.delegate = self
                            vc.ycdcNum = reponse
                            self.present(vc, animated: true)
                        }else{
                            self.showAlert(message: "Có lỗi xẩy ra trong quá trình tạo YCDC!")
                        }
                    }
                }
            }else{
                self.showAlert(message: "Bạn chưa chọn kho nhận!")
            }
        }else{
            self.showAlert(message: "Chưa có kho nhận!")
        }
        
        
        //        if(itemWhs != nil){
        //            let vc = ConfirmPopupViewController()
        //            vc.modalPresentationStyle = .overFullScreen
        //            vc.modalTransitionStyle = .crossDissolve
        //            vc.delegate = self
        //            present(vc, animated: true)
        //        }else{
        //            self.showAlert(message: "Bạn chưa chọn kho nhận!")
        //        }
    }
    func didDelete(index: Int) {
        if(listItems.count > 0){
            listItems.remove(at: index)
        }
        updateUI()
    }
}
extension TaoYCDCViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProductWarehouseCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ProductWarehouseCell")
        
        cell.setUpCell(item: listItems[indexPath.row], num: indexPath.row + 1)
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Common.Size(s: 55)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            
            if(self.listItems.count > 0){
                self.listItems.remove(at: indexPath.row)
            }
            self.updateUI()
            completionHandler(true)
        }
        deleteAction.image = #imageLiteral(resourceName: "Delete")
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    @objc
    func tapDelete(sender:UITapGestureRecognizer)
    {
        print("AAAA")
        
        //        guard let getTag = sender.view?.tag else { return }
        //        delegate?.didDelete(index: getTag)
    }
}
protocol ProductWarehouseDelegate: AnyObject {
    func didDelete(index: Int)
}
class ProductWarehouseCell: UITableViewCell {
    weak var delegate: ProductWarehouseDelegate?
    var lblNum = UILabel()
    var lblName = UILabel()
    var viewCell = UIView()
    var lblAmount = UILabel()
    //    var icDelete = UIImageView()
    func setUpCell(item: ItemYCDC, num: Int){
        
        self.subviews.forEach({$0.removeFromSuperview()})
        self.backgroundColor = .clear
        
        viewCell.frame =  CGRect(x: Common.Size(s: 5), y: Common.Size(s: 2.5), width: UIScreen.main.bounds.width - Common.Size(s: 10), height: Common.Size(s: 50))
        viewCell.backgroundColor = .white
        viewCell.layer.cornerRadius = 5
        self.addSubview(viewCell)
        
        lblNum.frame =  CGRect(x: Common.Size(s: 5), y: Common.Size(s: 50)/2 - Common.Size(s: 25)/2, width: Common.Size(s: 25), height: Common.Size(s: 25))
        lblNum.text = "\(num)"
        lblNum.textColor = .white
        lblNum.font = UIFont.boldSystemFont(ofSize: 20)
        lblNum.backgroundColor = UIColor(netHex:0x00955E)
        lblNum.numberOfLines = 1
        lblNum.textAlignment = .center
        lblNum.layer.cornerRadius = lblNum.frame.size.height/2
        lblNum.clipsToBounds = true
        viewCell.addSubview(lblNum)
        
        lblName.frame =  CGRect(x: lblNum.frame.origin.x + lblNum.frame.size.width + Common.Size(s: 5), y: Common.Size(s: 10), width: viewCell.frame.size.width - (lblNum.frame.origin.x + lblNum.frame.size.width + Common.Size(s: 15)), height: Common.Size(s: 15))
        lblName.text = "\(item.itemName.uppercased())"
        lblName.textColor = UIColor(netHex:0x00955E)
        lblName.font = UIFont.boldSystemFont(ofSize: 13)
        viewCell.addSubview(lblName)
        
        lblAmount.frame =  CGRect(x: lblName.frame.origin.x , y: lblName.frame.origin.y + lblName.frame.size.height, width: lblName.frame.size.width , height: Common.Size(s: 15))
        lblAmount.text = "Số lượng: \(item.amount)"
        lblAmount.textColor = .black
        lblAmount.font = UIFont.systemFont(ofSize: 13)
        viewCell.addSubview(lblAmount)
        
        
        
    }
    
}
