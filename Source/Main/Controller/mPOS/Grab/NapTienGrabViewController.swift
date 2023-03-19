//
//  NapTienGrabViewController.swift
//  fptshop
//
//  Created by tan on 5/10/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
import PopupDialog
class NapTienGrabViewController: UIViewController,UITextFieldDelegate,LoaiTheThanhToanGrabViewControllerDelegate {
    
    var scrollView:UIScrollView!
    var viewInfo:UIView!
    var tfSDT:SkyFloatingLabelTextFieldWithIcon!
    var tfTenKH:SkyFloatingLabelTextFieldWithIcon!
    var tfSoHD:SkyFloatingLabelTextFieldWithIcon!
    var tfBienSo:SkyFloatingLabelTextFieldWithIcon!
    var tfTienCuoc:SkyFloatingLabelTextFieldWithIcon!
    var tfLoaiThe:SkyFloatingLabelTextFieldWithIcon!
    
    var tfTienMat:SkyFloatingLabelTextFieldWithIcon!
    var tfTienThe:SkyFloatingLabelTextFieldWithIcon!
    var viewHTTT:UIView!
    var provider:Providers?
    var switchTienMat:UISwitch!
    var switchThe:UISwitch!
    var btPay:UIButton!
    
    var viewTongTien:UIView!
    
    var lblTienMat:UILabel!
    var lblThe:UILabel!

    var lblTongTien:UILabel!
    var idBank:String! = ""
    
    
    override func viewDidLoad() {
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Nạp tiền tài xế Grab"
        
        
        let lblInfoKH = UILabel(frame: CGRect(x:Common.Size(s:10), y: 0, width: scrollView.frame.size.width - Common.Size(s:20), height: Common.Size(s:35)))
        lblInfoKH.textAlignment = .left
        lblInfoKH.textColor = UIColor.black
        lblInfoKH.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        lblInfoKH.text = "Thông tin khách hàng"
        scrollView.addSubview(lblInfoKH)
        
        viewInfo = UIView(frame: CGRect(x:0, y: lblInfoKH.frame.origin.y + lblInfoKH.frame.size.height, width: scrollView.frame.size.width , height: Common.Size(s:300)))
        viewInfo.backgroundColor = UIColor.white
         scrollView.addSubview(viewInfo)
        
  
        
        tfSDT = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:15), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)), iconType: .image);
        tfSDT.placeholder = "Số điện thoại khách hàng"
        tfSDT.title = "Số điện thoại"
        tfSDT.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSDT.keyboardType = UIKeyboardType.numberPad
        tfSDT.returnKeyType = UIReturnKeyType.done
        tfSDT.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSDT.delegate = self
        tfSDT.tintColor = UIColor(netHex:0x00955E)
        tfSDT.textColor = .black
        tfSDT.lineColor = .gray
        tfSDT.selectedTitleColor = UIColor(netHex:0x00955E)
        tfSDT.selectedLineColor = .gray
        tfSDT.lineHeight = 1.0
        tfSDT.selectedLineHeight = 1.0
        viewInfo.addSubview(tfSDT)
        tfSDT.iconImage = UIImage(named: "ic-phone")
        //ic-phone
       

        
        tfTenKH = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:15), y: tfSDT.frame.origin.y + tfSDT.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)), iconType: .image);
        tfTenKH.placeholder = "Tên khách hàng"
        tfTenKH.title = "Tên khách hàng"
        tfTenKH.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTenKH.keyboardType = UIKeyboardType.default
        tfTenKH.returnKeyType = UIReturnKeyType.done
        tfTenKH.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTenKH.delegate = self
        tfTenKH.tintColor = UIColor(netHex:0x00955E)
        tfTenKH.textColor = .black
        tfTenKH.lineColor = .gray
        tfTenKH.selectedTitleColor = UIColor(netHex:0x00955E)
        tfTenKH.selectedLineColor = .gray
        tfTenKH.lineHeight = 1.0
        tfTenKH.selectedLineHeight = 1.0
        viewInfo.addSubview(tfTenKH)
        tfTenKH.iconImage = UIImage(named: "name")
        
        
      
        
        tfSoHD = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:15), y: tfTenKH.frame.origin.y + tfTenKH.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)), iconType: .image);
        tfSoHD.placeholder = "Mã Khách Hàng"
        tfSoHD.title = "Mã Khách Hàng"
        tfSoHD.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSoHD.keyboardType = UIKeyboardType.default
        tfSoHD.returnKeyType = UIReturnKeyType.done
        tfSoHD.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSoHD.delegate = self
        tfSoHD.tintColor = UIColor(netHex:0x00955E)
        tfSoHD.textColor = .black
        tfSoHD.lineColor = .gray
        tfSoHD.selectedTitleColor = UIColor(netHex:0x00955E)
        tfSoHD.selectedLineColor = .gray
        tfSoHD.lineHeight = 1.0
        tfSoHD.selectedLineHeight = 1.0
        viewInfo.addSubview(tfSoHD)
        //CapNhatThueBao
        tfSoHD.iconImage = UIImage(named: "CapNhatThueBao")
        
       
        
        tfBienSo = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:15), y: tfSoHD.frame.origin.y + tfSoHD.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)), iconType: .image);
        tfBienSo.placeholder = "Biển số xe"
        tfBienSo.title = "Biển số xe"
        tfBienSo.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfBienSo.keyboardType = UIKeyboardType.default
        tfBienSo.returnKeyType = UIReturnKeyType.done
        tfBienSo.clearButtonMode = UITextField.ViewMode.whileEditing
        tfBienSo.delegate = self
        tfBienSo.tintColor = UIColor(netHex:0x00955E)
        tfBienSo.textColor = .black
        tfBienSo.lineColor = .gray
        tfBienSo.selectedTitleColor = UIColor(netHex:0x00955E)
        tfBienSo.selectedLineColor = .gray
        tfBienSo.lineHeight = 1.0
        tfBienSo.selectedLineHeight = 1.0
        viewInfo.addSubview(tfBienSo)
        tfBienSo.iconImage = UIImage(named: "Counter-50")
        //Counter-50

        
        tfTienCuoc = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:15), y: tfBienSo.frame.origin.y + tfBienSo.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)), iconType: .image);
        tfTienCuoc.placeholder = "Tiền nạp"
        tfTienCuoc.title = "Tiền nạp"
        tfTienCuoc.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTienCuoc.keyboardType = UIKeyboardType.numberPad
        tfTienCuoc.returnKeyType = UIReturnKeyType.done
        tfTienCuoc.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTienCuoc.delegate = self
        tfTienCuoc.tintColor = UIColor(netHex:0x00955E)
        tfTienCuoc.textColor = .black
        tfTienCuoc.lineColor = .gray
        tfTienCuoc.selectedTitleColor = UIColor(netHex:0x00955E)
        tfTienCuoc.selectedLineColor = .gray
        tfTienCuoc.lineHeight = 1.0
        tfTienCuoc.selectedLineHeight = 1.0
        viewInfo.addSubview(tfTienCuoc)
        tfTienCuoc.addTarget(self, action: #selector(textFieldDidChangeMoney(_:)), for: .editingChanged)
        tfTienCuoc.iconImage = UIImage(named: "cash")
        
        viewInfo.frame.size.height = tfTienCuoc.frame.size.height + tfTienCuoc.frame.origin.y + Common.Size(s: 15)
        
        let lblHTTT = UILabel(frame: CGRect(x:Common.Size(s:10), y: viewInfo.frame.size.height + viewInfo.frame.origin.y + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:20), height: Common.Size(s:35)))
        lblHTTT.textAlignment = .left
        lblHTTT.textColor = UIColor.black
        lblHTTT.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        lblHTTT.text = "HÌNH THỨC THANH TOÁN"
        scrollView.addSubview(lblHTTT)
        
        viewHTTT = UIView(frame: CGRect(x:0, y: lblHTTT.frame.origin.y + lblHTTT.frame.size.height, width: scrollView.frame.size.width , height: Common.Size(s:300)))
        viewHTTT.backgroundColor = UIColor.white
        scrollView.addSubview(viewHTTT)
        
        
        let lblTienMatSwitch = UILabel(frame: CGRect(x:Common.Size(s:10), y: Common.Size(s:10), width: Common.Size(s:50), height: Common.Size(s:30)))
        lblTienMatSwitch.textAlignment = .left
        lblTienMatSwitch.textColor = UIColor.black
        lblTienMatSwitch.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTienMatSwitch.text = "Tiền mặt"
        viewHTTT.addSubview(lblTienMatSwitch)
        
        
        switchTienMat = UISwitch(frame:CGRect(x: lblTienMatSwitch.frame.origin.x + lblTienMatSwitch.frame.size.width + Common.Size(s: 5), y: Common.Size(s:10), width: 0, height: 0))
        switchTienMat.addTarget(self, action: #selector(NapTienGrabViewController.switchStateDidChange(_:)), for: .valueChanged)
        switchTienMat.setOn(true, animated: false)
        switchTienMat.onTintColor = UIColor(netHex:0x00955E)
        viewHTTT.addSubview(switchTienMat)
        
        let lblTheSwitch = UILabel(frame: CGRect(x: switchTienMat.frame.origin.x + switchTienMat.frame.size.width + Common.Size(s: 60), y: Common.Size(s:10), width: Common.Size(s:30), height: Common.Size(s:30)))
        lblTheSwitch.textAlignment = .left
        lblTheSwitch.textColor = UIColor.black
        lblTheSwitch.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTheSwitch.text = "Thẻ"
        viewHTTT.addSubview(lblTheSwitch)
        
        
        switchThe = UISwitch(frame:CGRect(x: lblTheSwitch.frame.origin.x + lblTheSwitch.frame.size.width + Common.Size(s: 3), y: Common.Size(s:10), width: 0, height: 0))
        switchThe.addTarget(self, action: #selector(NapTienGrabViewController.switchStateDidChange(_:)), for: .valueChanged)
        switchThe.setOn(false, animated: false)
        switchThe.onTintColor = UIColor(netHex:0x00955E)
        viewHTTT.addSubview(switchThe)
        
        
        tfTienMat = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:15), y: switchTienMat.frame.origin.y + switchTienMat.frame.size.height + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30) , height: 0), iconType: .image);
        tfTienMat.placeholder = ""
        tfTienMat.title = ""
        tfTienMat.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTienMat.keyboardType = UIKeyboardType.numberPad
        tfTienMat.returnKeyType = UIReturnKeyType.done
        tfTienMat.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTienMat.delegate = self
       tfTienMat.tintColor = UIColor(netHex:0x00955E)
        tfTienMat.textColor = .black
 //       tfTienMat.lineColor = .gray
        tfTienMat.lineColor = UIColor.white
       tfTienMat.selectedTitleColor =  UIColor(netHex:0x00955E)
        tfTienMat.selectedLineColor = .gray
        tfTienMat.lineHeight = 1.0
        tfTienMat.selectedLineHeight = 1.0
        viewHTTT.addSubview(tfTienMat)
         tfTienMat.addTarget(self, action: #selector(textFieldDidChangeMoneyTienMat(_:)), for: .editingChanged)
        
       
        
        tfTienThe = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:15), y: tfTienMat.frame.origin.y + tfTienMat.frame.size.height + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30) , height: 0), iconType: .image);
        tfTienThe.placeholder = ""
        tfTienThe.title = ""
        tfTienThe.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTienThe.keyboardType = UIKeyboardType.numberPad
        tfTienThe.returnKeyType = UIReturnKeyType.done
        tfTienThe.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTienThe.delegate = self
        tfTienThe.tintColor =  UIColor(netHex:0x00955E)
        tfTienThe.textColor = .black
        tfTienThe.lineColor = .white
        tfTienThe.selectedTitleColor = UIColor(netHex:0x00955E)
        tfTienThe.selectedLineColor = .gray
        tfTienThe.lineHeight = 1.0
        tfTienThe.selectedLineHeight = 1.0
        viewHTTT.addSubview(tfTienThe)
        tfTienThe.addTarget(self, action: #selector(textFieldDidChangeMoneyTienThe(_:)), for: .editingChanged)

        
        tfLoaiThe = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:15), y: tfTienThe.frame.origin.y + tfTienThe.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: 0), iconType: .image);
        tfLoaiThe.placeholder = ""
        tfLoaiThe.title = ""
        tfLoaiThe.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfLoaiThe.keyboardType = UIKeyboardType.default
        tfLoaiThe.returnKeyType = UIReturnKeyType.done
        tfLoaiThe.clearButtonMode = UITextField.ViewMode.whileEditing
        tfLoaiThe.delegate = self
        tfLoaiThe.tintColor = UIColor(netHex:0x00955E)
        tfLoaiThe.textColor = .black
        tfLoaiThe.lineColor = .white
        tfLoaiThe.selectedTitleColor =  UIColor(netHex:0x00955E)
        tfLoaiThe.selectedLineColor = .gray
        tfLoaiThe.lineHeight = 1.0
        tfLoaiThe.selectedLineHeight = 1.0
        viewHTTT.addSubview(tfLoaiThe)
        let gestureTransactionType = UITapGestureRecognizer(target: self, action:  #selector(self.actionChooseThe))
        tfLoaiThe.addGestureRecognizer(gestureTransactionType)
       // tfLoaiThe.iconImage = UIImage(named: "LoaiGD")
        
//        let viewFocusTransactionType = UIView(frame: tfLoaiThe.frame);
//        viewFocusTransactionType.backgroundColor = UIColor.red
//        viewHTTT.addSubview(viewFocusTransactionType)
//
//        let gestureTransactionType = UITapGestureRecognizer(target: self, action:  #selector(self.actionChooseThe))
//        viewFocusTransactionType.addGestureRecognizer(gestureTransactionType)
        
        
       viewHTTT.frame.size.height = tfLoaiThe.frame.origin.y + tfLoaiThe.frame.size.height + Common.Size(s: 5)
      
        
        viewTongTien = UIView(frame: CGRect(x:0, y: viewHTTT.frame.origin.y + viewHTTT.frame.size.height + Common.Size(s: 15), width: scrollView.frame.size.width , height: Common.Size(s:300)))
        viewTongTien.backgroundColor = UIColor.white
        scrollView.addSubview(viewTongTien)
        
        lblTienMat = UILabel(frame: CGRect(x:Common.Size(s:10), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: 0))
        lblTienMat.textAlignment = .right
        lblTienMat.textColor = UIColor.black
        lblTienMat.font = UIFont.systemFont(ofSize: Common.Size(s:12))
    
        viewTongTien.addSubview(lblTienMat)
        
        lblThe = UILabel(frame: CGRect(x:Common.Size(s:10), y: lblTienMat.frame.origin.y + lblTienMat.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: 0))
        lblThe.textAlignment = .right
        lblThe.textColor = UIColor.black
        lblThe.font = UIFont.systemFont(ofSize: Common.Size(s:12))
 
        viewTongTien.addSubview(lblThe)
        
        
        lblTongTien = UILabel(frame: CGRect(x:Common.Size(s:10), y: lblThe.frame.origin.y + lblThe.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:30)))
        lblTongTien.textAlignment = .right
        lblTongTien.textColor = UIColor.red
        lblTongTien.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
       
        viewTongTien.addSubview(lblTongTien)
        
        
        
        btPay = UIButton()
        btPay.frame = CGRect(x: Common.Size(s:15), y: lblTongTien.frame.origin.y + lblTongTien.frame.size.height + Common.Size(s:10), width: tfLoaiThe.frame.size.width, height: Common.Size(s: 40))

        btPay.backgroundColor = UIColor(netHex:0x00955E)
        btPay.setTitle("Thanh Toán", for: .normal)
        btPay.addTarget(self, action: #selector(actionConfirm), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        viewTongTien.addSubview(btPay)
        
    
        viewTongTien.frame.size.height = btPay.frame.origin.y + btPay.frame.size.height + Common.Size(s: 15)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTongTien.frame.origin.y + viewTongTien.frame.size.height + (UIApplication.shared.statusBarFrame.height) + Common.Size(s: 40))
        
     
        
        MPOSAPIManager.getProvidersGrab { (results, err) in
            if(err.count<=0){
                for item in results{
                    if(item.PaymentBillProviderName == "Grab"){
                        self.provider = item
                        break
                    }
                }
                
            }else{
                print("err: getProvidersGrab Error")
            }
        }
        
        

    }
    
    @objc func actionConfirm(){
        if(self.tfSDT.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập SĐT !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.tfSDT.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
        }
        let phone = tfSDT.text!
        if (phone.hasPrefix("01") && phone.count == 11){
            
        }else if (phone.hasPrefix("0") && !phone.hasPrefix("01") && phone.count == 10){
            
        }else{
            let alert = UIAlertController(title: "Thông báo", message: "Số điện thoại KH không hợp lệ!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.tfSDT.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
        }
        if(self.tfTenKH.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập tên KH !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.tfTenKH.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
        }
        if(self.tfBienSo.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập biển số xe !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.tfBienSo.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
        }
        if(self.tfTienCuoc.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập tiền cước !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.tfTienCuoc.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
        }
        if(self.tfSoHD.text!.count < 6){
            let alert = UIAlertController(title: "Thông báo", message: "Mã KH bắt buộc nhập từ 6 kí tự trở lên !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.tfSoHD.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
        }
        if(self.tfBienSo.text!.count < 4 || self.tfBienSo.text!.count > 5 ){
            let alert = UIAlertController(title: "Thông báo", message: "Biển số xe khi thanh toán Grab chỉ nhập 4 hoặc 5 số cuối !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.tfBienSo.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
            
        }
        if(Int((self.tfTienCuoc.text!.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)))! < 100000 ||
            Int((self.tfTienCuoc.text!.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)))! > 10000000 ){
            let alert = UIAlertController(title: "Thông báo", message: "Số tiền thanh toán tối thiểu là 100.000đ. Tối đa: 10 triệu ! ", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.tfBienSo.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
        }
        
        let title = "Xác nhận thanh toán"
        var message:String = ""
        if(self.switchTienMat.isOn == true && self.switchThe.isOn == false){
                 message = "Tổng Tiền: \(self.tfTienCuoc.text!)\r\n Hình thức thanh toán: Tiền Mặt"
//            if(self.tfTienMat.text != self.tfTienCuoc.text){
//                let alert = UIAlertController(title: "Thông báo", message: "Số tiền mặt phải bằng số tiền cước !", preferredStyle: .alert)
//                
//                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//                    self.tfBienSo.becomeFirstResponder()
//                })
//                self.present(alert, animated: true)
//                return
//            }
        }
        if(self.switchTienMat.isOn == false && self.switchThe.isOn == true){
                 message = "Tổng Tiền: \(self.tfTienCuoc.text!)\r\n Hình thức thanh toán: Tiền Thẻ"
            if(self.tfTienThe.text != self.tfTienCuoc.text){
                let alert = UIAlertController(title: "Thông báo", message: "Số tiền thẻ phải bằng số tiền cước !", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    self.tfBienSo.becomeFirstResponder()
                })
                self.present(alert, animated: true)
                return
            }
        }
        if(self.switchTienMat.isOn == true && self.switchThe.isOn == true){
                 message = "Tổng Tiền: \(self.tfTienCuoc.text!)\r\n Hình thức thanh toán: Tiền Mặt,Tiền Thẻ"
        }
    
        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
            print("Completed")
        }
        let buttonOne = CancelButton(title: "Không thanh toán") {
            
        }
        let buttonTwo = DefaultButton(title: "Đồng ý thanh toán"){
            self.actionPay()
        }
        popup.addButtons([buttonTwo,buttonOne])
        self.present(popup, animated: true, completion: nil)
    }
    func actionPay(){

        let newViewController = LoadingViewController()
        newViewController.content = "Đang lưu thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        

         let xml = self.parseXML()
        print(xml)
        let  moneyString = self.tfTienCuoc.text!.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        MPOSAPIManager.payOfflineBillBE(serviceCode:self.provider!.PaymentBillServiceCode,
                                        serviceName:self.provider!.PaymentBillServiceName,
                                        providerCode:self.provider!.PaymentBillProviderCode,
                                        providerName:self.provider!.PaymentBillProviderName,
                                        customerId:self.tfSoHD.text!,
                                        customerName:self.tfTenKH.text!,
                                        customerPhone:self.tfSDT.text!,
                                        customerAddress:"",
                                        contactAddress:"",
                                        contactName:"",
                                        contactPhoneNumber:"",
                                        moneyAmount:moneyString,
                                        xmlStringPay:"\(xml)",
            addingInput:"\(self.tfBienSo.text!)"
        ) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    //
                    if(results.ReturnCode == "-7" || results.ReturnCode == "-9" ){
                        let alert = UIAlertController(title: "Thông báo", message: "\(results.ReturnCodeDescription)", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            self.tfBienSo.becomeFirstResponder()
                        })
                        self.present(alert, animated: true)
                        return
                    }
                    //
                    let dateFormatter : DateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                    let date = Date()
                    let dateString = dateFormatter.string(from: date)
                    
           
                    let newViewController = PhieuGiaoDichGrabViewController()
                    newViewController.phone = self.tfSDT.text!
                    newViewController.tenKH = self.tfTenKH.text!
                    newViewController.ngaygiaodich = dateString
                    newViewController.soMpos = "\(results.DocEntry)"
                    newViewController.soPhieu = "\(results.MaGDFRT)"
                    newViewController.mafrt  = "\(results.MaGDFRT)"
                    newViewController.mapayoo = results.OrderNo
                    newViewController.tinhtrang = ""
                    newViewController.tongtien = "\(self.tfTienCuoc.text!)"
                    newViewController.maKH = "\(self.tfSoHD.text!)"
                    newViewController.biensoxe = "\(self.tfBienSo.text!)"
                    newViewController.nv = "\(Cache.user!.EmployeeName)"
                    newViewController.isNapTien = true
                    newViewController.maVoucher = "\(results.VCnum)"
                    newViewController.hanSuDung = "\(results.Den_ngay)"
                    if(self.switchTienMat.isOn == true && self.switchThe.isOn == false){
                          newViewController.hinhthuctt = "Tiền Mặt"
                    }
                    if(self.switchTienMat.isOn == false && self.switchThe.isOn == true){
                        newViewController.hinhthuctt = "Tiền Thẻ"
                    }
                    if(self.switchTienMat.isOn == true && self.switchThe.isOn == true){
                        newViewController.hinhthuctt = "Tiền Mặt, Tiền Thẻ"
                    }
                    self.tfTenKH.text = ""
                    self.tfSDT.text = ""
                    self.tfSoHD.text = ""
                    self.tfBienSo.text = ""
                    self.tfTienCuoc.text = ""
                    self.lblTongTien.text = ""
                    
                    
                    self.switchTienMat.isOn = true
                    self.switchThe.isOn = false
                    self.tfTienMat.frame.size.height = 0
                    self.tfTienMat.placeholder = ""
                    self.tfTienMat.title = ""
                    self.tfTienMat.lineColor = .white
                    
                    self.tfTienThe.frame.size.height = 0
                    self.tfTienThe.frame.origin.y = self.tfTienMat.frame.origin.y + self.tfTienMat.frame.size.height
                    self.tfTienThe.placeholder = ""
                    self.tfTienThe.title = ""
                    self.tfTienThe.lineColor = .white
                    
                    self.tfLoaiThe.frame.size.height = 0
                    self.tfLoaiThe.frame.origin.y = self.tfTienThe.frame.origin.y + self.tfTienThe.frame.size.height
                    self.tfLoaiThe.placeholder = ""
                    self.tfLoaiThe.title = ""
                    self.tfLoaiThe.lineColor = .white
                    self.viewHTTT.frame.size.height = self.tfLoaiThe.frame.origin.y + self.tfLoaiThe.frame.size.height + Common.Size(s: 5)
                    self.viewTongTien.frame.origin.y = self.viewHTTT.frame.origin.y + self.viewHTTT.frame.size.height + Common.Size(s: 15)
                    
                    
                    
                    self.lblTongTien.frame.origin.y = Common.Size(s: 5)
                    self.lblTongTien.frame.size.height = Common.Size(s: 30)
                    
                    self.btPay.frame.origin.y = self.lblTongTien.frame.origin.y + self.lblTongTien.frame.size.height + Common.Size(s:10)
                    
                    self.viewTongTien.frame.size.height = self.btPay.frame.size.height + self.btPay.frame.origin.y + Common.Size(s: 10)
                    
                    
                    
                    self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.viewTongTien.frame.origin.y + self.viewTongTien.frame.size.height + (UIApplication.shared.statusBarFrame.height) + Common.Size(s: 40))
                    self.navigationController?.pushViewController(newViewController, animated: true)
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    func parseXML()->String{
        var rs:String = "<line>"

        if(self.switchTienMat.isOn == true){
            var moneyString:String = self.tfTienCuoc.text!
            if(self.tfTienMat != nil){
                if(self.tfTienMat.text != ""){
                    moneyString = self.tfTienMat.text!
                }
          
            }
            moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
            moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            if(moneyString.isEmpty){
                moneyString = "0"
            }
            rs = rs + "<item Totalcash=\"\(moneyString)\"  Totalcardcredit=\"\("")\" Numcard=\"\("")\"  IDBankCard=\"\("")\" Numvoucher=\"\("")\" TotalVoucher=\"\("0")\" Namevoucher=\"\("")\"/>"
        
        }
        if(self.switchThe.isOn == true){
            var moneyString:String = self.tfTienCuoc.text!
            if(self.tfTienThe != nil){
                if(self.tfTienThe.text != ""){
                     moneyString = self.tfTienThe.text!
                }
               
            }
            moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
            moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            if(moneyString.isEmpty){
                moneyString = "0"
            }
            rs = rs + "<item Totalcash=\"\("")\"  Totalcardcredit=\"\(moneyString)\" Numcard=\"\("")\"  IDBankCard=\"\(idBank!)\" Numvoucher=\"\("")\" TotalVoucher=\"\("0")\" Namevoucher=\"\("")\"/>"
           
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
    
    @objc func actionChooseThe(sender : UITapGestureRecognizer) {
        let myVC = LoaiTheThanhToanGrabViewController()
        myVC.delegate = self
        myVC.ind = 0
        let navController = UINavigationController(rootViewController: myVC)
        self.navigationController?.present(navController, animated:false, completion: nil)
    }


    @objc func switchStateDidChange(_ sender:UISwitch){
        if(self.tfTienCuoc.text == ""){
            let title = "Thông báo"
            
            
            let popup = PopupDialog(title: title, message: "Vui lòng nhập số tiền cước !", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            switchThe.isOn = false
            switchTienMat.isOn = true
            return
        }
        if (switchTienMat.isOn == true && switchThe.isOn == false){
            tfTienMat.frame.size.height = 0
            tfTienMat.placeholder = ""
            tfTienMat.title = ""
            tfTienMat.lineColor = .white
            
            tfTienThe.frame.size.height = 0
            tfTienThe.frame.origin.y = tfTienMat.frame.origin.y + tfTienMat.frame.size.height
            tfTienThe.placeholder = ""
            tfTienThe.title = ""
            tfTienThe.lineColor = .white
            
            tfLoaiThe.frame.size.height = 0
              tfLoaiThe.frame.origin.y = tfTienThe.frame.origin.y + tfTienThe.frame.size.height
            tfLoaiThe.placeholder = ""
            tfLoaiThe.title = ""
            tfLoaiThe.lineColor = .white
            viewHTTT.frame.size.height = tfLoaiThe.frame.origin.y + tfLoaiThe.frame.size.height + Common.Size(s: 5)
            viewTongTien.frame.origin.y = viewHTTT.frame.origin.y + viewHTTT.frame.size.height + Common.Size(s: 15)
    
            
            
            lblTongTien.frame.origin.y = Common.Size(s: 5)
            lblTongTien.frame.size.height = Common.Size(s: 30)
            
            btPay.frame.origin.y = lblTongTien.frame.origin.y + lblTongTien.frame.size.height + Common.Size(s:10)
            
            viewTongTien.frame.size.height = btPay.frame.size.height + btPay.frame.origin.y + Common.Size(s: 10)
            
            
            
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTongTien.frame.origin.y + viewTongTien.frame.size.height + (UIApplication.shared.statusBarFrame.height) + Common.Size(s: 40))
            
        }
         if (switchThe.isOn == true && switchTienMat.isOn == false){
            tfTienMat.frame.size.height = 0
            tfTienMat.placeholder = ""
            tfTienMat.title = ""
            tfTienMat.text = ""
            tfTienMat.lineColor = .white
            
            tfTienThe.frame.size.height = Common.Size(s:40)
              tfTienThe.frame.origin.y = tfTienMat.frame.origin.y + tfTienMat.frame.size.height
            tfTienThe.placeholder = "Nhập số tiền thanh toán qua thẻ"
            tfTienThe.title = "Tiền thẻ"
            tfTienThe.text = "\(tfTienCuoc.text!)"
            tfTienThe.lineColor = .gray
            
            tfLoaiThe.frame.size.height = Common.Size(s: 40)
                tfLoaiThe.frame.origin.y = tfTienThe.frame.origin.y + tfTienThe.frame.size.height + Common.Size(s:10)
            tfLoaiThe.placeholder = "Chọn loại thẻ"
            tfLoaiThe.title = "Loại thẻ"
            tfLoaiThe.lineColor = .gray
            
            viewHTTT.frame.size.height = tfLoaiThe.frame.origin.y + tfLoaiThe.frame.size.height + Common.Size(s: 5)
            viewTongTien.frame.origin.y = viewHTTT.frame.origin.y + viewHTTT.frame.size.height + Common.Size(s: 15)
            
            lblThe.frame.origin.y = Common.Size(s: 5)
            lblThe.frame.size.height = Common.Size(s: 30)
            
            
            lblTongTien.frame.origin.y = lblThe.frame.origin.y + lblThe.frame.size.height + Common.Size(s: 10)
            lblTongTien.frame.size.height = Common.Size(s: 30)
            
            btPay.frame.origin.y = lblTongTien.frame.origin.y + lblTongTien.frame.size.height + Common.Size(s:10)
            
            viewTongTien.frame.size.height = btPay.frame.size.height + btPay.frame.origin.y + Common.Size(s: 10)
            
     
            
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTongTien.frame.origin.y + viewTongTien.frame.size.height + (UIApplication.shared.statusBarFrame.height) + Common.Size(s: 40))
        }
        if(switchTienMat.isOn == true && switchThe.isOn == true){
            tfTienMat.frame.size.height = Common.Size(s:40)
            tfTienMat.placeholder = "Nhập tiền mặt"
            tfTienMat.title = "Tiền mặt"
            tfTienMat.lineColor = .gray
            
            
            tfTienThe.frame.size.height = Common.Size(s:40)
            tfTienThe.frame.origin.y = tfTienMat.frame.origin.y + tfTienMat.frame.size.height + Common.Size(s:10)
            tfTienThe.placeholder = "Nhập số tiền thanh toán qua thẻ"
            tfTienThe.title = "Tiền thẻ"
             tfTienThe.lineColor = .gray
         
            
            tfLoaiThe.frame.size.height = Common.Size(s: 40)
            tfLoaiThe.frame.origin.y = tfTienThe.frame.origin.y + tfTienThe.frame.size.height + Common.Size(s:10)
            tfLoaiThe.placeholder = "Chọn loại thẻ"
            tfLoaiThe.title = "Loại thẻ"
            tfLoaiThe.lineColor = .gray
            
            viewHTTT.frame.size.height = tfLoaiThe.frame.origin.y + tfLoaiThe.frame.size.height + Common.Size(s: 5)
            viewTongTien.frame.origin.y = viewHTTT.frame.origin.y + viewHTTT.frame.size.height + Common.Size(s: 15)
            
            lblTienMat.frame.origin.y = Common.Size(s: 5)
            lblTienMat.frame.size.height = Common.Size(s: 30)
            
            lblThe.frame.origin.y = lblTienMat.frame.size.height + lblTienMat.frame.origin.y + Common.Size(s: 5)
            lblThe.frame.size.height = Common.Size(s: 30)
            
            lblTongTien.frame.origin.y = lblThe.frame.size.height + lblThe.frame.origin.y + Common.Size(s: 5)
            lblTongTien.frame.size.height = Common.Size(s: 30)
            
            btPay.frame.origin.y = lblTongTien.frame.origin.y + lblTongTien.frame.size.height + Common.Size(s:10)
            
            viewTongTien.frame.size.height = btPay.frame.size.height + btPay.frame.origin.y + Common.Size(s: 10)
            
            
            
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTongTien.frame.origin.y + viewTongTien.frame.size.height + (UIApplication.shared.statusBarFrame.height) + Common.Size(s: 40))
        }
        if(switchTienMat.isOn == false && switchThe.isOn == false){
            switchTienMat.isOn = true
            tfTienMat.frame.size.height = 0
            tfTienMat.placeholder = ""
            tfTienMat.title = ""
            tfTienMat.lineColor = .white
            
            tfTienThe.frame.size.height = 0
            tfTienThe.frame.origin.y = tfTienMat.frame.origin.y + tfTienMat.frame.size.height
            tfTienThe.placeholder = ""
            tfTienThe.title = ""
            tfTienThe.lineColor = .white
            
            tfLoaiThe.frame.size.height = 0
            tfLoaiThe.frame.origin.y = tfTienThe.frame.origin.y + tfTienThe.frame.size.height
            tfLoaiThe.placeholder = ""
            tfLoaiThe.title = ""
            tfLoaiThe.lineColor = .white
            viewHTTT.frame.size.height = tfLoaiThe.frame.origin.y + tfLoaiThe.frame.size.height + Common.Size(s: 5)
            viewTongTien.frame.origin.y = viewHTTT.frame.origin.y + viewHTTT.frame.size.height + Common.Size(s: 15)
            lblTongTien.frame.origin.y = Common.Size(s: 10)
            btPay.frame.origin.y =  lblTongTien.frame.origin.y + lblTongTien.frame.size.height + Common.Size(s: 5)
            viewHTTT.frame.size.height = btPay.frame.origin.y + btPay.frame.size.height + Common.Size(s: 5)
            
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewHTTT.frame.origin.y + viewHTTT.frame.size.height + (UIApplication.shared.statusBarFrame.height) + Common.Size(s: 40))
//            let title = "Thông báo"
//
//
//            let popup = PopupDialog(title: title, message: "Bạn bắt buộc phải chọn một hình thức thanh toán !", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
//                print("Completed")
//            }
//            let buttonOne = CancelButton(title: "OK") {
//
//
//            }
//            popup.addButtons([buttonOne])
//            self.present(popup, animated: true, completion: nil)
        }
    }
    func returnService(item:CardTypeFromPOSResult,ind:Int) {
                self.tfLoaiThe.text = item.Text
                self.idBank = "\(item.Value)"
             
    }

    @objc func textFieldDidChangeMoney(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s).\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
            self.tfTienCuoc.text = str
            self.lblTongTien.text = "Tổng tiền: \(str) VNĐ"
            self.tfTienMat.text = ""
            self.lblTienMat.text = ""
            self.tfTienThe.text = ""
            self.lblThe.text = ""
        }else{
            textField.text = ""
            self.tfTienCuoc.text = ""
            self.lblTongTien.text = ""
            self.tfTienMat.text = ""
            self.lblTienMat.text = ""
            self.tfTienThe.text = ""
            self.lblThe.text = ""
        }
        
    }
    
    @objc func textFieldDidChangeMoneyTienMat(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s).\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
            self.tfTienMat.text = str
            self.lblTienMat.text = "Tiền mặt: \(str)"
            if(switchThe.isOn == true){
                var money = tfTienCuoc.text!
                money = money.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                str = str.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                self.tfTienThe.text = Common.convertCurrencyV2(value: Int(money)! - Int(str)!)
                self.lblThe.text = "Tiền thẻ: \(Common.convertCurrencyV2(value: Int(money)! - Int(str)!))"
            }
    
        }else{
            textField.text = ""
            self.tfTienMat.text = ""
       
        }
        
    }
    @objc func textFieldDidChangeMoneyTienThe(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s).\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
            self.tfTienMat.text = str
            if(switchThe.isOn == true){
                var money = tfTienCuoc.text!
                money = money.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                  str = str.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                self.tfTienMat.text = Common.convertCurrencyV2(value: Int(money)! - Int(str)!)
            }
            
        }else{
            textField.text = ""
            self.tfTienMat.text = ""
            
        }
        
    }
}
