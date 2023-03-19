//
//  PaymentViettelVASViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 3/17/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class PaymentViettelVASViewController: UIViewController {

    var imgTienMat: UIImageView!
    var imgThe: UIImageView!
    var tfTienMat1: UITextField!
    var tfThe1: UITextField!
    var lbTongTienText: UILabel!
    var isTienMat = true
    var isThe = false
    var otp = ""
    var sdt = ""
    var itemGoiCuocChoose: ViettelVASGoiCuoc_products?
    var listProductViettelVAS_MainInfo = [ViettelVAS_Product]()
    var integrationInfo: ViettelVASGoiCuoc_IntegrationInfo?
    var percentFeeThe: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Thanh toán"
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.view.backgroundColor = .white
        
        let btLeftIcon = Common.initBackButton()
        btLeftIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
        
        let viewHTTT = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Common.Size(s: 40)))
        viewHTTT.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        self.view.addSubview(viewHTTT)
        
        let lbHTTT = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewHTTT.frame.width - Common.Size(s: 30), height: viewHTTT.frame.height))
        lbHTTT.text = "HÌNH THỨC THANH TOÁN"
        lbHTTT.font = UIFont.boldSystemFont(ofSize: 14)
        lbHTTT.textColor = UIColor(netHex: 0x59B581)
        viewHTTT.addSubview(lbHTTT)
        
        imgTienMat = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: viewHTTT.frame.origin.y + viewHTTT.frame.height + Common.Size(s: 10), width: Common.Size(s: 20), height: Common.Size(s: 20)))
        imgTienMat.image = #imageLiteral(resourceName: "check-1-1")
        imgTienMat.contentMode = .scaleToFill
        imgTienMat.tag = 1
        self.view.addSubview(imgTienMat)
        
        let tapCheckTienMat = UITapGestureRecognizer(target: self, action: #selector(tapCheckTypePayment(sender:)))
        imgTienMat.isUserInteractionEnabled = true
        imgTienMat.addGestureRecognizer(tapCheckTienMat)
        
        let lbTienMat = UILabel(frame: CGRect(x: imgTienMat.frame.origin.x + imgTienMat.frame.width + Common.Size(s: 5), y:  imgTienMat.frame.origin.y, width: self.view.frame.width/2 - Common.Size(s: 35), height: Common.Size(s: 20)))
        lbTienMat.text = "Tiền mặt"
        lbTienMat.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lbTienMat)
        
        imgThe = UIImageView(frame: CGRect(x: lbTienMat.frame.origin.x + lbTienMat.frame.width, y: imgTienMat.frame.origin.y, width: Common.Size(s: 20), height: Common.Size(s: 20)))
        imgThe.image = #imageLiteral(resourceName: "check-2-1")
        imgThe.contentMode = .scaleToFill
        imgThe.tag = 2
        self.view.addSubview(imgThe)
        
        let tapCheckThe = UITapGestureRecognizer(target: self, action: #selector(tapCheckTypePayment(sender:)))
        imgThe.isUserInteractionEnabled = true
        imgThe.addGestureRecognizer(tapCheckThe)
        
        let lbThe = UILabel(frame: CGRect(x: imgThe.frame.origin.x + imgThe.frame.width + Common.Size(s: 5), y:  imgThe.frame.origin.y, width: lbTienMat.frame.width, height: Common.Size(s: 20)))
        lbThe.text = "Thẻ"
        lbThe.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lbThe)
        
        /////nhap tien mat
        let viewTienMat = UIView(frame: CGRect(x: Common.Size(s: 15), y: lbThe.frame.origin.y + lbThe.frame.height + Common.Size(s: 8), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        viewTienMat.backgroundColor = .white
        self.view.addSubview(viewTienMat)
        
        let lbTienMat1 = UILabel(frame: CGRect(x: 0, y: 0, width: viewTienMat.frame.width/3, height: Common.Size(s: 35)))
        lbTienMat1.text = "Tiền mặt"
        lbTienMat1.font = UIFont.systemFont(ofSize: 15)
        viewTienMat.addSubview(lbTienMat1)
        
        tfTienMat1 = UITextField(frame: CGRect(x: lbTienMat1.frame.origin.x + lbTienMat1.frame.width, y: lbTienMat1.frame.origin.y, width: viewTienMat.frame.width * 2/3, height: Common.Size(s: 35)))
        tfTienMat1.borderStyle = .roundedRect
        tfTienMat1.font = UIFont.systemFont(ofSize: 15)
        tfTienMat1.text = "\(Common.convertCurrencyDouble(value: itemGoiCuocChoose?.price ?? 0))"
        tfTienMat1.keyboardType = .numberPad
        tfTienMat1.textAlignment = .right
        tfTienMat1.isEnabled = false
        tfTienMat1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        viewTienMat.addSubview(tfTienMat1)
        
        ///view nhap the
        let viewThe = UIView(frame: CGRect(x: Common.Size(s: 15), y: viewTienMat.frame.origin.y + viewTienMat.frame.height + Common.Size(s: 5), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        viewThe.backgroundColor = .white
        self.view.addSubview(viewThe)
        
        let lbThe1 = UILabel(frame: CGRect(x: 0, y: 0, width: viewThe.frame.width/3, height: Common.Size(s: 35)))
        lbThe1.text = "Thẻ"
        lbThe1.font = UIFont.systemFont(ofSize: 15)
        viewThe.addSubview(lbThe1)
        
        tfThe1 = UITextField(frame: CGRect(x: lbThe1.frame.origin.x + lbThe1.frame.width, y: lbThe1.frame.origin.y, width: viewThe.frame.width * 2/3, height: Common.Size(s: 35)))
        tfThe1.borderStyle = .roundedRect
        tfThe1.font = UIFont.systemFont(ofSize: 15)
        tfThe1.text = "0"
        tfThe1.keyboardType = .numberPad
        tfThe1.textAlignment = .right
        tfThe1.isEnabled = false
        tfThe1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        viewThe.addSubview(tfThe1)
        
        let lbTongTien = UILabel(frame: CGRect(x: Common.Size(s: 15), y: self.view.frame.height - (self.self.navigationController?.navigationBar.frame.height ?? 0) - UIApplication.shared.statusBarFrame.height - Common.Size(s: 80), width: (self.view.frame.width - Common.Size(s: 30))/2, height: Common.Size(s: 20)))
        lbTongTien.text = "Tổng tiền thanh toán"
        lbTongTien.font = UIFont.boldSystemFont(ofSize: 15)
        self.view.addSubview(lbTongTien)
        
        lbTongTienText = UILabel(frame: CGRect(x: lbTongTien.frame.origin.x + lbTongTien.frame.width, y: lbTongTien.frame.origin.y, width: (self.view.frame.width - Common.Size(s: 30))/2, height: Common.Size(s: 20)))
        lbTongTienText.text = "\(Common.convertCurrencyDouble(value: itemGoiCuocChoose?.price ?? 0))đ"
        lbTongTienText.font = UIFont.boldSystemFont(ofSize: 15)
        lbTongTienText.textColor = .red
        lbTongTienText.textAlignment = .right
        self.view.addSubview(lbTongTienText)
        
        let btnPayment = UIButton(frame: CGRect(x: Common.Size(s: 15), y: lbTongTienText.frame.origin.y + lbTongTienText.frame.height + Common.Size(s: 8), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        btnPayment.setTitle("HOÀN TẤT", for: .normal)
        btnPayment.setTitleColor(UIColor.white, for: .normal)
        btnPayment.layer.cornerRadius = 8
        btnPayment.backgroundColor = UIColor(netHex: 0x59B581)
        btnPayment.addTarget(self, action: #selector(actionPayment), for: .touchUpInside)
        self.view.addSubview(btnPayment)
    }
    @objc func handleBack(){
        navigationController?.popViewController(animated: true)
    }
    @objc func tapCheckTypePayment(sender: UIGestureRecognizer) {
        let view = sender.view ?? UIView()
        if view.tag == 1 { //tien mat
            debugPrint("tien mat")
            isTienMat = !isTienMat
            self.imgTienMat.image = isTienMat ? #imageLiteral(resourceName: "check-1-1") : #imageLiteral(resourceName: "check-2-1")
        } else {
            debugPrint("thẻ")
            if !isThe {
                let vc = ListCardViewController()
                vc.delegate = self
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                isThe = false
                self.imgThe.image = #imageLiteral(resourceName: "check-2-1")
                self.tfThe1.isEnabled = false
                self.tfThe1.text = "0"
                self.tfTienMat1.text = "\(Common.convertCurrencyDouble(value: itemGoiCuocChoose?.price ?? 0))"
                self.updatePrice(cash: itemGoiCuocChoose?.price ?? 0, card: 0)
            }
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let total = NumberFormatter().number(from: "\(Int(self.itemGoiCuocChoose?.price ?? 0))")?.intValue ?? 0
        
        if textField == self.tfTienMat1 { //nhập tiền mặt
            let tienMatStr = self.tfTienMat1.text ?? "0"
            self.tfTienMat1.text = self.convertTypeMoneyString(number: "\(self.tfTienMat1.text ?? "0")")
            //tinh tien the
            var numTM = NumberFormatter().number(from: tienMatStr.replacingOccurrences(of: ",", with: "", options: .literal, range: nil))?.intValue ?? 0
            var tienThe = total - numTM
            if tienThe <= 0 {
                tienThe = 0
            }
            self.tfThe1.text = self.convertTypeMoneyString(number: "\(tienThe)")
            
            if numTM > total {
                numTM = total
            } else if numTM <= 0 {
                numTM = 0
            }
            self.tfTienMat1.text = self.convertTypeMoneyString(number: "\(numTM)")
            self.updatePrice(cash: Double(numTM), card: Double(tienThe))
            
        } else { //nhập thẻ
            let tienTheStr = self.tfThe1.text ?? "0"
            self.tfThe1.text = self.convertTypeMoneyString(number: "\(self.tfThe1.text ?? "0")")
            //tinh tien mat
            var numThe = NumberFormatter().number(from: tienTheStr.replacingOccurrences(of: ",", with: "", options: .literal, range: nil))?.intValue ?? 0
            var tienMat = total - numThe
            if tienMat <= 0 {
                tienMat = 0
            }
            self.tfTienMat1.text = self.convertTypeMoneyString(number: "\(tienMat)")
            
            if numThe > total {
                numThe = total
            } else if numThe <= 0 {
                numThe = 0
            }
            self.tfThe1.text = self.convertTypeMoneyString(number: "\(numThe)")
            self.updatePrice(cash: Double(tienMat), card: Double(numThe))
        }
    }
    
    func convertTypeMoneyString(number: String) -> String {
        var moneyString = number
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
            return str
        }else{
            return ""
        }
    }
    
    
    @objc func actionPayment() {
        
        self.showInputDialog(title: "Xác nhận", subtitle: "Nhập mã OTP gửi về máy khách hàng", actionTitle: "Xác nhận", inputPlaceholder: "Nhập OTP", inputKeyboardType: .default) { (otpString) in
            debugPrint("otp: \(otpString ?? "x")")
            guard let opt = otpString, !opt.isEmpty else {
                let alertVC = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập OTP xác nhận!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertVC.addAction(action)
                self.present(alertVC, animated: true, completion: nil)
                return
            }
            self.payment(integrationInfo: self.integrationInfo ?? ViettelVASGoiCuoc_IntegrationInfo(requestId: "", responseId: "", returnedCode: "", returnedMessage: ""))
        }
    }
    
    func payment(integrationInfo: ViettelVASGoiCuoc_IntegrationInfo) {
        _ = self.listProductViettelVAS_MainInfo.first(where: {($0.configs[0].integratedProductCode == self.itemGoiCuocChoose?.mCode ?? "") && ($0.price == self.itemGoiCuocChoose?.price ?? 0)})
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "vi_VN")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
//        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let strDate = dateFormatter.string(from: Date())
        debugPrint("strDate: \(strDate)Z")
        
//        let totalAmountFee = 0
        
//        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang thanh toán ...") {
//            CRMAPIManager.ViettelVAS_CreateOrder(providerId: "\(itemProductMain?.details.providerID ?? "")", sdt: self.sdt, creationTime: "\(strDate)Z", itemGoiCuocMain: itemProductMain!, itemGoiCuocSelect: self.itemGoiCuocChoose!, totalAmountFee: "\(totalAmountFee)", totalFee: "", categoryId: "\(itemProductMain?.categoryIds[0] ?? "")", integrationInfo: integrationInfo, otpString: self.otp) { (rsID, customerID, err) in
//                WaitingNetworkResponseAlert.DismissWaitingAlert {
//                    if err.count <= 0 {
//                        if !rsID.isEmpty {
//                            let alert = UIAlertController(title: "Thông báo", message: "Thanh toán thành công!", preferredStyle: .alert)
//                            let action = UIAlertAction(title: "OK", style: .default) { (action) in
//                                let vc = HistoryViettelPackageDetail()
//                                vc.idTransaction = rsID
//                                self.navigationController?.pushViewController(vc, animated: true)
//                            }
//                            alert.addAction(action)
//                            self.present(alert, animated: true, completion: nil)
//                        } else {
//                            let alert = UIAlertController(title: "Thông báo", message: "Thanh toán thất bại!", preferredStyle: .alert)
//                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                            alert.addAction(action)
//                            self.present(alert, animated: true, completion: nil)
//                        }
//                    } else {
//                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
//                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                        alert.addAction(action)
//                        self.present(alert, animated: true, completion: nil)
//                    }
//                }
//            }
//        }
    }
    
    func updatePrice(cash: Double, card: Double) {
        var totalAndFee:Double = 0
        if self.isThe {
            let cardAndFee = card + ((card * self.percentFeeThe) / 100)
            totalAndFee = cash + cardAndFee
        } else {
            self.percentFeeThe = 0
            totalAndFee = cash
        }
        self.lbTongTienText.text = "\(Common.convertCurrencyDouble(value: totalAndFee))đ"
    }
    
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
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

        self.present(alert, animated: true, completion: nil)
    }
}

extension PaymentViettelVASViewController: ListCardViewControllerDelegate {
    func returnClose() {
        
    }
    
    func returnCard(item: CardTypeFromPOSResult, ind: Int) {
        self.percentFeeThe = item.PercentFee
        self.isThe = true
        self.imgThe.image = #imageLiteral(resourceName: "check-1-1")
        self.tfThe1.isEnabled = true
        self.tfTienMat1.isEnabled = true
    }
}
