//
//  DiscountViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 2/28/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Toaster
protocol DiscountViewControllerDelegate: NSObjectProtocol {
    
    func discountSuccess(indx:Int,discount: Int,id: String,note:String,userapprove:String)
    
}

class DiscountViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate{
    
    weak var delegate: DiscountViewControllerDelegate?
    var scrollView:UIScrollView!
    var tfMoney:UITextField!
    var companyButton: SearchTextField!
    
    var listCompany:[LyDoGiamGia] = []
    var valueCode:Int = -1
    var taskNotes: UITextView!
    var placeholderLabel : UILabel!
    var total:Float = 0
    var indx:Int = -1
    var itemCart:Cart!
    var is_DH_DuAn:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Thông tin giảm giá"
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x47B054)
        
        let btDeleteIcon = UIButton.init(type: .custom)
        btDeleteIcon.setImage(#imageLiteral(resourceName: "Delete"), for: UIControl.State.normal)
        btDeleteIcon.imageView?.contentMode = .scaleAspectFit
        btDeleteIcon.addTarget(self, action: #selector(DiscountViewController.actionDelete), for: UIControl.Event.touchUpInside)
        btDeleteIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        let barDelete = UIBarButtonItem(customView: btDeleteIcon)
        
        self.navigationItem.rightBarButtonItems = [barDelete]
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        if(itemCart.sku == Common.skuKHTT){
            itemCart.whsCode = "\(Cache.user!.ShopCode)010"
        }
        
        let lbTextCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:15), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMND.textAlignment = .left
        lbTextCMND.textColor = UIColor.black
        lbTextCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMND.text = "Số tiền giảm giá (*)"
        scrollView.addSubview(lbTextCMND)
        
        tfMoney = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextCMND.frame.origin.y + lbTextCMND.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfMoney.placeholder = "Nhập vào số tiền"
        tfMoney.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfMoney.borderStyle = UITextField.BorderStyle.roundedRect
        tfMoney.autocorrectionType = UITextAutocorrectionType.no
        tfMoney.keyboardType = UIKeyboardType.numberPad
        tfMoney.returnKeyType = UIReturnKeyType.done
        tfMoney.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfMoney.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfMoney.delegate = self
        scrollView.addSubview(tfMoney)
        tfMoney.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        if(itemCart != nil){
            if(itemCart.discount > 0){
                var money = "\(itemCart.discount)"
                money = money.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
                if(money.isEmpty){
                    money = "0"
                }
                let characters = Array(money)
                if(characters.count > 0){
                    var str = ""
                    var count:Int = 0
                    for index in 0...(characters.count - 1) {
                        let s = characters[(characters.count - 1) - index]
                        if(count % 3 == 0 && count != 0){
                            str = "\(s),\(str)"
                        }else{
                            str = "\(s)\(str)"
                        }
                        count = count + 1
                    }
                    tfMoney.text = str
                }else{
                    tfMoney.text = ""
                }
            }
        }
        
        let lbTextCompany = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfMoney.frame.size.height + tfMoney.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCompany.textAlignment = .left
        lbTextCompany.textColor = UIColor.black
        lbTextCompany.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCompany.text = "Lý do giảm giá (*)"
        scrollView.addSubview(lbTextCompany)
        
        companyButton = SearchTextField(frame: CGRect(x: lbTextCompany.frame.origin.x, y: lbTextCompany.frame.origin.y + lbTextCompany.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        companyButton.placeholder = "Chọn lý do giảm giá"
        companyButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.borderStyle = UITextField.BorderStyle.roundedRect
        companyButton.autocorrectionType = UITextAutocorrectionType.no
        companyButton.keyboardType = UIKeyboardType.default
        companyButton.returnKeyType = UIReturnKeyType.done
        companyButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        companyButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        companyButton.delegate = self
        scrollView.addSubview(companyButton)
        
        companyButton.startVisible = true
        companyButton.theme.bgColor = UIColor.white
        companyButton.theme.fontColor = UIColor.black
        companyButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.theme.cellHeight = Common.Size(s:40)
        companyButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        let lbTextNote = UILabel(frame: CGRect(x: Common.Size(s:15), y: companyButton.frame.size.height + companyButton.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextNote.textAlignment = .left
        lbTextNote.textColor = UIColor.black
        lbTextNote.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextNote.text = "Ghi chú"
        scrollView.addSubview(lbTextNote)
        
        taskNotes = UITextView(frame: CGRect(x: lbTextNote.frame.origin.x , y: lbTextNote.frame.origin.y  + lbTextNote.frame.size.height + Common.Size(s:10), width: lbTextNote.frame.size.width, height: companyButton.frame.size.height * 2 ))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        taskNotes.layer.borderWidth = 0.5
        taskNotes.layer.borderColor = borderColor.cgColor
        taskNotes.layer.cornerRadius = 5.0
        taskNotes.delegate = self
        taskNotes.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        scrollView.addSubview(taskNotes)
        
        if(itemCart != nil){
            taskNotes.text = "\(itemCart.note)"
        }
        
        placeholderLabel = UILabel()
        placeholderLabel.text = "Nhập nội dung ghi chú (nếu có)"
        placeholderLabel.font = UIFont.systemFont(ofSize: (taskNotes.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        taskNotes.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (taskNotes.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !taskNotes.text.isEmpty
        
        let btPay = UIButton()
        btPay.frame = CGRect(x: taskNotes.frame.origin.x, y: taskNotes.frame.origin.y + taskNotes.frame.size.height + Common.Size(s:20), width: tfMoney.frame.size.width, height: tfMoney.frame.size.height * 1.2)
        btPay.backgroundColor = UIColor(netHex:0xEF4A40)
        btPay.setTitle("TIẾP TỤC", for: .normal)
        btPay.addTarget(self, action: #selector(actionPay), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        scrollView.addSubview(btPay)
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin giảm giá..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.inov_masterDataLyDoGiamGia { (results, err) in
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    var listCom: [String] = []
                    self.listCompany = results
                    for item in results {
                        listCom.append("\(item.Name)")
                        
                        if(self.itemCart != nil){
                            if(self.itemCart.reason == "\(item.Value)"){
                                self.valueCode = item.Value
                                self.companyButton.text = item.Name
                            }
                        }
                    }
                    self.companyButton.filterStrings(listCom)
                }else{
                    let alertController = UIAlertController(title: "Thông báo", message: "Không tìm thấy thông tin giảm giá!", preferredStyle: .alert)
                    let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                        _ = self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                    }
                    alertController.addAction(confirmAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        companyButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.companyButton.text = item.title
            let obj =  self.listCompany.filter{ $0.Name == "\(item.title)" }.first
            if let id = obj?.Value {
                self.valueCode = id
            }
        }
    }
    @objc private func textFieldDidChange(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s),\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
        }else{
            textField.text = ""
        }
        if(textField == tfMoney){
            var moneyString:String = textField.text!
            moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            if(moneyString.isEmpty){
                moneyString = "0"
            }
            if let moneyInt = Float(moneyString) {
                let money = moneyInt
                if(money <= 0){
                    tfMoney.text = ""
                }else{
                    let characters = Array("\(money.cleanValue)")
                    if(characters.count > 0){
                        var str = ""
                        var count:Int = 0
                        for index in 0...(characters.count - 1) {
                            let s = characters[(characters.count - 1) - index]
                            if(count % 3 == 0 && count != 0){
                                str = "\(s),\(str)"
                            }else{
                                str = "\(s)\(str)"
                            }
                            count = count + 1
                        }
                        tfMoney.text = str
                    }else{
                        tfMoney.text = ""
                    }
                }
            }
        }
    }
    @objc func actionDelete() {
        
        let alertController = UIAlertController(title: "Thông báo", message: "Bạn muốn xoá giảm giá của sản phẩm \(itemCart.product.name) ?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Xoá", style: .default) { (_) in
            self.delegate?.discountSuccess(indx: self.indx, discount: 0, id: "0", note: "",userapprove:"")
            
//            if(Cache.unconfirmationReasons.count > 0){
//                Cache.unconfirmationReasons.remove(at: self.indx)
//            }
            _ = self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
        let confirmClose = UIAlertAction(title: "Huỷ", style: .cancel) { (_) in
            
        }
        alertController.addAction(confirmClose)
        alertController.addAction(confirmAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    @objc func actionPay(sender: UIButton!) {
        var money = tfMoney.text!
        let note = taskNotes.text!
        money = money.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        if(money.isEmpty){
            money = "0"
        }
        if(money.count <= 0 || money == "0"){
            Toast(text: "Vui lòng nhập số tiền giảm giá!").show()
            return
        }
        if let mob = Float(money){
            if(mob > itemCart.price){
                if(itemCart.sku != Common.skuKHTT){
                    Toast(text: "Số tiền giảm giá không được lớn hơn giá sản phẩm!").show()
                    return
                }
            }
        }else{
            Toast(text: "Vui lòng nhập đúng số tiền giảm giá!").show()
            return
        }
        if let mob = Float(money){
            if(mob > total){
                Toast(text: "Số tiền giảm giá không được lớn hơn tổng đơn hàng!").show()
                return
            }
        }
        if let stringToInt = Int(money){
            if(self.valueCode == -1){
                Toast(text: "Vui lòng chọn lý do giảm giá!").show()
                return
            }
            
            if(itemCart.sku == Common.skuKHTT){
                if(Cache.unconfirmationReasons.count == 0){
                    let item1 = UnconfirmationReasons(ItemCode: "\(itemCart.sku)", imei: "", issuccess: 1, userapprove: "", Discount: stringToInt, Lydo_giamgia: self.valueCode,Note: note)
                    Cache.unconfirmationReasons.append(item1)
                    self.delegate?.discountSuccess(indx: self.indx, discount: stringToInt, id: "\(self.valueCode)", note: "\(note)",userapprove: "")
                    _ = self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }else{
                     let item1 = UnconfirmationReasons(ItemCode: "\(itemCart.sku)", imei: "", issuccess: 1, userapprove: "", Discount: stringToInt, Lydo_giamgia: self.valueCode,Note: note)
                    var count: Int = 0
                    var vlAdd: Bool = true
                    for item in Cache.unconfirmationReasons {
                        if(Common.skuKHTT == item.ItemCode){
                            Cache.unconfirmationReasons[count].Discount = stringToInt
                            Cache.unconfirmationReasons[count].Lydo_giamgia = self.valueCode
                            Cache.unconfirmationReasons[count].Note = note
                            vlAdd = false
                        }
                        count = count + 1
                    }
                    if(vlAdd){
                        Cache.unconfirmationReasons.append(item1)
                    }
                    self.delegate?.discountSuccess(indx: self.indx, discount: stringToInt, id: "\(self.valueCode)", note: "\(note)",userapprove:"")
                    _ = self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
                
            }else{
                print("stringToInt \(stringToInt)")
                let newViewController = LoadingViewController()
                newViewController.content = "Đang kiểm tra thông tin giảm giá..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                MPOSAPIManager.sp_mpos_FRT_SP_innovation_checkgiamgiatay(whscode: "\(itemCart.whsCode)", itemcode: "\(itemCart.sku)", p_price: "\(String(format: "%.6f", itemCart.price))", p_discount: money, imei: "\(itemCart.imei)", reasoncode: "\(self.valueCode)",Note: note,is_DH_DuAn:self.is_DH_DuAn) { (results, err) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            var notify:String = ""
                            for item1 in results{
                                if(item1.issuccess == 0){
                                    notify = "\(item1.ItemCode)"
                                }
                            }
                            if(notify != ""){
                                let when = DispatchTime.now() + 1
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    let alertController = UIAlertController(title: "Thông báo", message: "Mã sản phẩm \(notify) vi phạm nguyên tắc giảm giá. Vui lòng kiểm tra lại!", preferredStyle: .alert)
                                    
                                    let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                                    }
                                    alertController.addAction(confirmAction)
                                    
                                    self.present(alertController, animated: true, completion: nil)}
                                return
                            }
                            else{
//                                if(Cache.unconfirmationReasons.count == 0){
//                                    for item1 in results{
//                                        if(item1.issuccess == 1){
//                                            Cache.unconfirmationReasons.append(item1)
//                                        }
//                                    }
//                                }else{
//                                    for item1 in results{
//                                        if(item1.issuccess == 1){
//                                            var count: Int = 0
//                                            var vlAdd: Bool = true
//                                            for item in Cache.unconfirmationReasons {
//                                                if(item1.imei == item.imei && item1.ItemCode == item.ItemCode){
//                                                    Cache.unconfirmationReasons[count].Discount = item1.Discount
//                                                    Cache.unconfirmationReasons[count].Lydo_giamgia = item1.Lydo_giamgia
//                                                    Cache.unconfirmationReasons[count].userapprove = item1.userapprove
//                                                    vlAdd = false
//                                                }
//                                                count = count + 1
//                                            }
//                                            if(vlAdd){
//                                                Cache.unconfirmationReasons.append(item1)
//                                            }
//                                        }else{
//                                            var count: Int = 0
//                                            var ind:Int = -1
//                                            for item in Cache.unconfirmationReasons {
//                                                if(item1.imei == item.imei && item1.ItemCode == item.ItemCode){
//                                                    ind = count
//                                                    break
//                                                }
//                                                count = count + 1
//                                            }
//                                            Cache.unconfirmationReasons.remove(at: ind)
//                                        }
//                                    }
//                                }
                                if(results.count > 0){
                                    let when = DispatchTime.now() + 0.5
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    for item1 in results{
                                        self.delegate?.discountSuccess(indx: self.indx, discount: item1.Discount, id: "\(item1.Lydo_giamgia)", note: "\(note)",userapprove:item1.userapprove)
                                        _ = self.navigationController?.popViewController(animated: true)
                                        self.dismiss(animated: true, completion: nil)
                                        }
                                    }
                                }else{
                                    let when = DispatchTime.now() + 1
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                        let alertController = UIAlertController(title: "Thông báo", message: " i phạm nguyên tắc giảm giá. Vui lòng kiểm tra lại!", preferredStyle: .alert)
                                        
                                        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                                        }
                                        alertController.addAction(confirmAction)
                                        
                                        self.present(alertController, animated: true, completion: nil)}
                                    return
                                }
                                
                            }
                        }else{
                            let alertController = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                            let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                                
                            }
                            alertController.addAction(confirmAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
            }
        }else{
            Toast(text: "Số tiền giảm giá sai định dạng!").show()
            return
        }
    }
}

