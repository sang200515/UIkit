//
//  ThuHoLongChauViewController.swift
//  mPOS
//
//  Created by tan on 8/30/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class ThuHoLongChauViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    var scrollView:UIScrollView!
    var nccButton:SearchTextField!
    var nvButton:SearchTextField!
    var tfSoTienDaThu:UITextField!
    var tfNoiDung:UITextView!
    var btXacNhan:UIButton!
    var amountTypedString:String = ""
    var listNhaThuoc:[NhaThuoc] = []
    var listNhanVien:[NhanVienThuoc] = []
    var thongTinThuHo:ThongTinThuHo = ThongTinThuHo(soMpos: "", nhaThuoc: "", nvNopTien: "", sotien: 0, noiDung: "", nhaThuocCode: "", nvNopTienCode: "",sotienString: "",sophieucrm: "",sdtNhanVien: "",diaChiNhaThuoc: "",billID:"")
    var tfCrm:UITextField!
    var mCodecrm:String = ""
    

    override func viewDidLoad() {
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(ThuHoLongChauViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.title = "Thu Hộ"
        self.view.addSubview(scrollView)
        navigationController?.navigationBar.isTranslucent = false
        
        let lbTextThongTinKH = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbTextThongTinKH.textAlignment = .left
        lbTextThongTinKH.textColor = UIColor(netHex:0x47B054)
        lbTextThongTinKH.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        lbTextThongTinKH.text = "Thông tin khách hàng"
        scrollView.addSubview(lbTextThongTinKH)
        
        //input tinh thanh pho
        let lblTitleNCC =  UILabel(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: lbTextThongTinKH.frame.origin.y + lbTextThongTinKH.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTitleNCC.textAlignment = .left
        lblTitleNCC.textColor = UIColor.black
        lblTitleNCC.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTitleNCC.text = "Chọn nhà thuốc"
        scrollView.addSubview(lblTitleNCC)
        
        nccButton = SearchTextField(frame: CGRect(x: lblTitleNCC.frame.origin.x, y: lblTitleNCC.frame.origin.y + lblTitleNCC.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40) ));
        
        nccButton.placeholder = "Chọn nhà thuốc"
        nccButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        nccButton.borderStyle = UITextField.BorderStyle.roundedRect
        nccButton.autocorrectionType = UITextAutocorrectionType.no
        nccButton.keyboardType = UIKeyboardType.default
        nccButton.returnKeyType = UIReturnKeyType.done
        nccButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        nccButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        nccButton.delegate = self
        scrollView.addSubview(nccButton)
        
        // Start visible - Default: false
        nccButton.startVisible = true
        nccButton.theme.bgColor = UIColor.white
        nccButton.theme.fontColor = UIColor.black
        nccButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        nccButton.theme.cellHeight = Common.Size(s:40)
        nccButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        nccButton.leftViewMode = UITextField.ViewMode.always
        let imageButton = UIImageView(frame: CGRect(x: nccButton.frame.size.height/4, y: nccButton.frame.size.height/4, width: nccButton.frame.size.height/2, height: nccButton.frame.size.height/2))
        imageButton.image = UIImage(named: "City-50")
        imageButton.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewCityButton = UIView()
        leftViewCityButton.addSubview(imageButton)
        leftViewCityButton.frame = CGRect(x: 0, y: 0, width: nccButton.frame.size.height, height: nccButton.frame.size.height)
        nccButton.leftView = leftViewCityButton
        
        nccButton.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            self.nccButton.text = item.title
            
            let obj1 =  self.listNhaThuoc.filter{ $0.TenShop == "\(item.title)" }.first
            if let obj = obj1?.Mashop {
                self.thongTinThuHo.nhaThuocCode = "\(obj)"
                self.thongTinThuHo.nhaThuocString = item.title
                self.thongTinThuHo.diaChiNhaThuoc = obj1!.DiaChiShop
            }
            self.listNhanVien = []
            self.thongTinThuHo.nvNopTienCode = ""
            self.thongTinThuHo.nvNopTienString = ""
            self.nvButton.text = ""
            self.tfSoTienDaThu.text = ""
            self.thongTinThuHo.sdtNhanVien = ""
            self.loadListNhanVien()
        }
        
        let lblTitleNV =  UILabel(frame: CGRect(x: nccButton.frame.origin.x, y: nccButton.frame.origin.y + nccButton.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTitleNV.textAlignment = .left
        lblTitleNV.textColor = UIColor.black
        lblTitleNV.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTitleNV.text = "Nhân viên đi nộp"
        scrollView.addSubview(lblTitleNV)
        
        
        
        nvButton = SearchTextField(frame: CGRect(x: lblTitleNV.frame.origin.x, y: lblTitleNV.frame.origin.y + lblTitleNV.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40) ));
        
        
        nvButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        nvButton.borderStyle = UITextField.BorderStyle.roundedRect
        nvButton.autocorrectionType = UITextAutocorrectionType.no
        nvButton.keyboardType = UIKeyboardType.default
        nvButton.returnKeyType = UIReturnKeyType.done
        nvButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        nvButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        nvButton.delegate = self
        scrollView.addSubview(nvButton)
        
        // Start visible - Default: false
        nvButton.startVisible = true
        nvButton.theme.bgColor = UIColor.white
        nvButton.theme.fontColor = UIColor.black
        nvButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        nvButton.theme.cellHeight = Common.Size(s:40)
        nvButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        nvButton.leftViewMode = UITextField.ViewMode.always
        
        
        nvButton.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            self.nvButton.text = item.title
            
            let obj1 =  self.listNhanVien.filter{ "\($0.MaNV) - \($0.TenNv)" == "\(item.title)" }.first
            if let obj = obj1?.MaNV {
                self.thongTinThuHo.nvNopTienCode = "\(obj)"
                self.thongTinThuHo.nvNopTienString = item.title
                self.thongTinThuHo.sdtNhanVien = obj1!.Phone
            }
            
        }
        
        let lblTitleThongTinThanhToan = UILabel(frame: CGRect(x: Common.Size(s:15), y: nvButton.frame.origin.y + nvButton.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
        lblTitleThongTinThanhToan.textAlignment = .left
        lblTitleThongTinThanhToan.textColor = UIColor(netHex:0x47B054)
        lblTitleThongTinThanhToan.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        lblTitleThongTinThanhToan.text = "Thông tin thanh toán"
        scrollView.addSubview(lblTitleThongTinThanhToan)
        
        
        let lblTitleSoTienDaThu =  UILabel(frame: CGRect(x: lblTitleThongTinThanhToan.frame.origin.x, y: lblTitleThongTinThanhToan.frame.origin.y + lblTitleThongTinThanhToan.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTitleSoTienDaThu.textAlignment = .left
        lblTitleSoTienDaThu.textColor = UIColor.black
        lblTitleSoTienDaThu.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTitleSoTienDaThu.text = "Số tiền đã thu"
        scrollView.addSubview(lblTitleSoTienDaThu)
        
        
        tfSoTienDaThu = UITextField(frame: CGRect(x: lblTitleSoTienDaThu.frame.origin.x, y: lblTitleSoTienDaThu.frame.origin.y + lblTitleSoTienDaThu.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        
        
        tfSoTienDaThu.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSoTienDaThu.borderStyle = UITextField.BorderStyle.roundedRect
        tfSoTienDaThu.autocorrectionType = UITextAutocorrectionType.no
        tfSoTienDaThu.keyboardType = UIKeyboardType.numberPad
        tfSoTienDaThu.returnKeyType = UIReturnKeyType.done
        tfSoTienDaThu.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfSoTienDaThu.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSoTienDaThu.delegate = self
        scrollView.addSubview(tfSoTienDaThu)
        
        
        
        let lblTitleNoiDung = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfSoTienDaThu.frame.origin.y + tfSoTienDaThu.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
        lblTitleNoiDung.textAlignment = .left
        lblTitleNoiDung.textColor = UIColor.black
        lblTitleNoiDung.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTitleNoiDung.text = "Nội dung"
        scrollView.addSubview(lblTitleNoiDung)
        
        tfNoiDung = UITextView(frame: CGRect(x: lblTitleNoiDung.frame.origin.x , y: lblTitleNoiDung.frame.origin.y  + lblTitleNoiDung.frame.size.height + Common.Size(s:10), width: tfSoTienDaThu.frame.size.width, height: tfSoTienDaThu.frame.size.height * 2 ))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        tfNoiDung.layer.borderWidth = 0.5
        tfNoiDung.layer.borderColor = borderColor.cgColor
        tfNoiDung.layer.cornerRadius = 5.0
        tfNoiDung.delegate = self
        tfNoiDung.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        scrollView.addSubview(tfNoiDung)
        
        
        btXacNhan = UIButton()
        btXacNhan.frame = CGRect(x: Common.Size(s: 40), y: tfNoiDung.frame.origin.y + tfNoiDung.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:80),height: Common.Size(s: 40))
        btXacNhan.backgroundColor = UIColor(netHex:0x47B054)
        btXacNhan.setTitle("Xác nhận", for: .normal)
        btXacNhan.addTarget(self, action: #selector(actionXacNhan), for: .touchUpInside)
        btXacNhan.layer.borderWidth = 0.5
        btXacNhan.layer.borderColor = UIColor.white.cgColor
        btXacNhan.layer.cornerRadius = 3
        scrollView.addSubview(btXacNhan)
        btXacNhan.clipsToBounds = true
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btXacNhan.frame.origin.y + btXacNhan.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 60))
        
        self.loadNhaThuoc()
    }
    
    @objc func actionXacNhan(){
        self.nccButton.resignFirstResponder()
        self.nvButton.resignFirstResponder()
        self.tfSoTienDaThu.resignFirstResponder()
        self.tfNoiDung.resignFirstResponder()
        
        if(self.thongTinThuHo.nhaThuocCode == "" || self.nccButton.text == ""){
            self.showDialog(message: "Vui lòng chọn nhà thuốc")
            return
        }
        if(self.thongTinThuHo.nvNopTienCode == "" || self.nvButton.text == ""){
             self.showDialog(message: "Vui lòng chọn nhân viên")
            return
        }
        if(self.tfSoTienDaThu.text == ""){
            self.showDialog(message: "Vui lòng nhập số tiền đã thu")
            return
            
        }
        if(self.tfNoiDung.text == ""){
            self.showDialog(message: "Vui lòng nhập nội dung thu hộ")
            return
            
        }
        
        
        //Swiftiest solution
        let swiftyString = self.tfSoTienDaThu.text!.replacingOccurrences(of: ",", with: "")
        print(swiftyString)
        self.thongTinThuHo.sotienString = self.tfSoTienDaThu.text!
        let soTienDaThu = Int(swiftyString)
        self.thongTinThuHo.sotien = soTienDaThu ?? 0
        self.thongTinThuHo.noiDung = self.tfNoiDung.text
        checkPassCode()
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField == self.tfSoTienDaThu) {
            if ((string == "0" || string == "") && (textField.text! as NSString).range(of: ".").location < range.location) {
                return true
            }
            
            // First check whether the replacement string's numeric...
            let cs = NSCharacterSet(charactersIn: "0123456789.").inverted
            let filtered = string.components(separatedBy: cs)
            let component = filtered.joined(separator: "")
            let isNumeric = string == component
            
            // Then if the replacement string's numeric, or if it's
            // a backspace, or if it's a decimal point and the text
            // field doesn't already contain a decimal point,
            // reformat the new complete number using
            if isNumeric {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.maximumFractionDigits = 8
                // Combine the new text with the old; then remove any
                // commas from the textField before formatting
                let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                let numberWithOutCommas = newString.replacingOccurrences(of: ",", with: "")
                let number = formatter.number(from: numberWithOutCommas)
                if number != nil {
                    var formattedString = formatter.string(from: number!)
                    // If the last entry was a decimal or a zero after a decimal,
                    // re-add it here because the formatter will naturally remove
                    // it.
                    if string == "." && range.location == textField.text?.length {
                        formattedString = formattedString?.appending(".")
                    }
                    textField.text = formattedString
                } else {
                    textField.text = nil
                }
            }
            return false
        }
        
        return true
        
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if(textField == self.tfSoTienDaThu){
            amountTypedString = ""
            return true
        }
        
        
        return true
    }
    
    
    
    
    func checkPassCode(){
        showInputDialog(title: "Xác nhận nhân viên nộp tiền",
                        subtitle: "Vui lòng nhập mật khẩu",
                        actionTitle: "Xác nhận",
                        cancelTitle: "Cancel",
                        inputPlaceholder: "mật khẩu",
                        inputKeyboardType: UIKeyboardType.default, actionHandler:
                            { (input:String?) in
                                print("The pass input is \(input ?? "")")
                                // call api
                                //self.checkAPIPassCode(pass: input!)
                                if(input == ""){
                                    self.showDialog(message: "Vui lòng nhập password!")
                                    return
                                }
                                self.actionHoanTat(password: input!)
                            })
    }
    
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
            textField.isSecureTextEntry = true
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadNhaThuoc(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang load nhà thuốc..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.getListNhaThuoc() { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.listNhaThuoc = results
                    var listNhaThuocTemp:[String] = []
                    for item in results {
                        listNhaThuocTemp.append(item.TenShop)
                    }
                    self.nccButton.filterStrings(listNhaThuocTemp)
                }else{
                
                    self.showDialog(message: err)
                }
            }
        }
    }
    
    func loadListNhanVien(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang load danh sách nhân viên thuốc..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.getListNhanVienThuocLongChau(ShopCode_LC: self.thongTinThuHo.nhaThuocCode) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    
                    self.listNhanVien = results
                    var listNhanVienTemp:[String] = []
                    for item in results {
                        listNhanVienTemp.append("\(item.MaNV) - \(item.TenNv)")
                    }
                    self.nvButton.filterStrings(listNhanVienTemp)
                    
                }else{
              
                    self.showDialog(message: err)
                }
            }
        }
    }
    
    func actionHoanTat(password:String){
        
        mCodecrm =  UserDefaults.standard.string(forKey: "CRMCode")!
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lưu thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.insertThuHoLongChau(MaNV_LC: self.thongTinThuHo.nvNopTienCode, Password: password, ShopCode_LC: self.thongTinThuHo.nhaThuocCode, amount: self.thongTinThuHo.sotien,crmtokken: mCodecrm,Note:self.thongTinThuHo.noiDung) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(results.success == true){
                        if(results.Result != "0"){
                            let popup = PopupDialog(title: "Thông báo", message: results.message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
                                
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                self.thongTinThuHo.soMpos = results.docentry
                                self.thongTinThuHo.billID = results.IDBill
                                self.thongTinThuHo.sophieucrm = results.sophieucrm
                                let newViewController2 = ThongTinThuHoLongChauViewController()
                                
                                newViewController2.self.thongTinThuHo = self.thongTinThuHo
                                self.navigationController?.pushViewController(newViewController2, animated: true)
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }else{
                          
                            self.showDialog(message: results.message)
                        }
                    }else{
                   
                        self.showDialog(message: results.message)
                    }
                    
                    
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
