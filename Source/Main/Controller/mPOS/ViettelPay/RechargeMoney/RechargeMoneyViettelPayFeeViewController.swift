//
//  RechargeMoneyViettelPayFeeViewController.swift
//  fptshop
//
//  Created by tan on 7/9/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import DLRadioButton
import Presentr
import PopupDialog

class RechargeMoneyViettelPayFeeViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    var scrollView:UIScrollView!
    
    var viewChuTK:UIView!
    var viewNTT:UIView!
    var viewTTNT:UIView!
    var tfPhone: UITextField!
    var tfHoTenCTK:UITextField!
    var tfHoTenNTT:UITextField!
    var tfPhoneNguoiTT: UITextField!
    var tfMoney:UITextField!
 
    var tfGhiChu:UITextView!
    var btConfirm:UIButton!
    var lbHoTenCTK:UILabel!
    var lbHoTenNTT:UILabel!
    var tfFee:UITextField!
    //
    var phoneCTK = ""
    var hotenCTK = ""
    var phoneNTT = ""
    var hotenNTT = ""
    var money:Double = 0
    var fee:Double = 0
    var note = ""
    var isSwitch:Bool = false
    var otp = ""
    var keyotp = ""
    var itemViettelPaySOMInfo: ViettelPayNccInfo?
    var itemViettelPayNapTienResult: ViettelPayNapTien?
    var clock = 0
    var orderID_SOM = ""
    
    private var radCheck:DLRadioButton = {
        let radio = DLRadioButton()
        radio.titleLabel!.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        radio.setTitleColor(UIColor.black, for: UIControl.State())
        radio.iconColor = UIColor.black
        radio.indicatorColor = UIColor.black
        radio.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        radio.setTitle("Nạp cho chính mình", for: UIControl.State())
      
        return radio
    }()
    
    let presenter: Presentr = {
        let dynamicType = PresentationType.dynamic(center: ModalCenterPosition.center)
        let customPresenter = Presentr(presentationType: dynamicType)
        customPresenter.backgroundOpacity = 0.3
        customPresenter.roundCorners = true
        customPresenter.dismissOnSwipe = false
        customPresenter.dismissAnimated = false
        customPresenter.backgroundTap = .noAction
        return customPresenter
    }()
    
    override func viewDidLoad() {
        self.title = "Nạp Tiền ViettelPay"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(RechargeMoneyViettelPayFeeViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "THÔNG TIN CHỦ TÀI KHOẢN VIETTEL PAY"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        viewChuTK = UIView()
        viewChuTK.frame = CGRect(x: 0, y:label1.frame.origin.y + label1.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewChuTK.backgroundColor = UIColor.white
        viewChuTK.clipsToBounds = true
        scrollView.addSubview(viewChuTK)
        
        let lbTextPhone = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhone.textAlignment = .left
        lbTextPhone.textColor = UIColor.black
        lbTextPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhone.text = "Số điện thoại"
        viewChuTK.addSubview(lbTextPhone)
        
        tfPhone = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhone.frame.origin.y + lbTextPhone.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfPhone.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhone.autocorrectionType = UITextAutocorrectionType.no
        tfPhone.keyboardType = UIKeyboardType.numberPad
        tfPhone.returnKeyType = UIReturnKeyType.done
        tfPhone.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhone.delegate = self
        tfPhone.text = self.phoneCTK
        tfPhone.isEnabled = false
        viewChuTK.addSubview(tfPhone)
        
        lbHoTenCTK = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhone.frame.origin.y + tfPhone.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHoTenCTK.textAlignment = .left
        lbHoTenCTK.textColor = UIColor.black
        lbHoTenCTK.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHoTenCTK.text = "Họ tên"
        
        viewChuTK.addSubview(lbHoTenCTK)
        
        tfHoTenCTK = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbHoTenCTK.frame.origin.y + lbHoTenCTK.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfHoTenCTK.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfHoTenCTK.borderStyle = UITextField.BorderStyle.roundedRect
        tfHoTenCTK.autocorrectionType = UITextAutocorrectionType.no
        tfHoTenCTK.keyboardType = UIKeyboardType.numberPad
        tfHoTenCTK.returnKeyType = UIReturnKeyType.done
        tfHoTenCTK.clearButtonMode = UITextField.ViewMode.whileEditing
        tfHoTenCTK.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfHoTenCTK.delegate = self
        tfHoTenCTK.isEnabled = false
        tfHoTenCTK.text = self.hotenCTK
        viewChuTK.addSubview(tfHoTenCTK)
        
        
        
        radCheck.frame = CGRect(x: Common.Size(s:15), y: tfHoTenCTK.frame.size.height + tfHoTenCTK.frame.origin.y , width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 35))
        viewChuTK.addSubview(radCheck)
        if(self.isSwitch == true){
            radCheck.isSelected = true
        }else{
            radCheck.isSelected = false
        }
        radCheck.isUserInteractionEnabled = false
        
        viewChuTK.frame.size.height = radCheck.frame.origin.y + radCheck.frame.size.height +  Common.Size(s:10)
        
    
        
        let label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewChuTK.frame.origin.y + viewChuTK.frame.size.height , width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label2.text = "THÔNG TIN NGƯỜI THANH TOÁN"
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label2)
        
        
        viewNTT = UIView()
        viewNTT.frame = CGRect(x: 0, y:label2.frame.origin.y + label2.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewNTT.backgroundColor = UIColor.white
        scrollView.addSubview(viewNTT)
        
        let lbTextPhone2 = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhone2.textAlignment = .left
        lbTextPhone2.textColor = UIColor.black
        lbTextPhone2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhone2.text = "Số điện thoại"
        viewNTT.addSubview(lbTextPhone2)
        
        tfPhoneNguoiTT = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhone2.frame.origin.y + lbTextPhone2.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfPhoneNguoiTT.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhoneNguoiTT.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhoneNguoiTT.autocorrectionType = UITextAutocorrectionType.no
        tfPhoneNguoiTT.keyboardType = UIKeyboardType.numberPad
        tfPhoneNguoiTT.returnKeyType = UIReturnKeyType.done
        tfPhoneNguoiTT.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhoneNguoiTT.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhoneNguoiTT.delegate = self
        tfPhoneNguoiTT.isEnabled = false
        tfPhoneNguoiTT.text = self.phoneNTT
        viewNTT.addSubview(tfPhoneNguoiTT)
        
        lbHoTenNTT = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhoneNguoiTT.frame.origin.y + tfPhoneNguoiTT.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHoTenNTT.textAlignment = .left
        lbHoTenNTT.textColor = UIColor.black
        lbHoTenNTT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHoTenNTT.text = "Họ tên"
        viewNTT.addSubview(lbHoTenNTT)
        
        tfHoTenNTT = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbHoTenNTT.frame.origin.y + lbHoTenNTT.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfHoTenNTT.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfHoTenNTT.borderStyle = UITextField.BorderStyle.roundedRect
        tfHoTenNTT.autocorrectionType = UITextAutocorrectionType.no
        tfHoTenNTT.keyboardType = UIKeyboardType.numberPad
        tfHoTenNTT.returnKeyType = UIReturnKeyType.done
        tfHoTenNTT.clearButtonMode = UITextField.ViewMode.whileEditing
        tfHoTenNTT.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfHoTenNTT.delegate = self
        tfHoTenNTT.isEnabled = false
        tfHoTenNTT.text = self.hotenNTT
        viewNTT.addSubview(tfHoTenNTT)
        
        viewNTT.frame.size.height = tfHoTenNTT.frame.origin.y + tfHoTenNTT.frame.size.height +  Common.Size(s:10)
        
        let label3 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewNTT.frame.origin.y + viewNTT.frame.size.height , width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label3.text = "THÔNG TIN NẠP TIỀN"
        label3.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label3)
        
        
        viewTTNT = UIView()
        viewTTNT.frame = CGRect(x: 0, y:label3.frame.origin.y + label3.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewTTNT.backgroundColor = UIColor.white
        scrollView.addSubview(viewTTNT)
        
        
        let lbTextMoney = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextMoney.textAlignment = .left
        lbTextMoney.textColor = UIColor.black
        lbTextMoney.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextMoney.text = "Số tiền"
        viewTTNT.addSubview(lbTextMoney)
        
        tfMoney = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextMoney.frame.origin.y + lbTextMoney.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfMoney.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfMoney.borderStyle = UITextField.BorderStyle.roundedRect
        tfMoney.autocorrectionType = UITextAutocorrectionType.no
        tfMoney.keyboardType = UIKeyboardType.numberPad
        tfMoney.returnKeyType = UIReturnKeyType.done
        tfMoney.clearButtonMode = UITextField.ViewMode.whileEditing
        tfMoney.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfMoney.delegate = self
        tfMoney.text = "\(Common.convertCurrency(value: Int(self.money)))"
        tfMoney.isUserInteractionEnabled = false
       // tfMoney.addTarget(self, action: #selector(textFieldDidChangeMoney(_:)), for: .editingChanged)
        viewTTNT.addSubview(tfMoney)
        
        let lbTextFee = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfMoney.frame.origin.y + tfMoney.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextFee.textAlignment = .left
        lbTextFee.textColor = UIColor.black
        lbTextFee.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextFee.text = "Phí"
        viewTTNT.addSubview(lbTextFee)
        
        tfFee = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextFee.frame.origin.y + lbTextFee.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfFee.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfFee.borderStyle = UITextField.BorderStyle.roundedRect
        tfFee.autocorrectionType = UITextAutocorrectionType.no
        tfFee.keyboardType = UIKeyboardType.numberPad
        tfFee.returnKeyType = UIReturnKeyType.done
        tfFee.clearButtonMode = UITextField.ViewMode.whileEditing
        tfFee.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfFee.delegate = self
        tfFee.text = Common.convertCurrency(value: Int(self.fee))
        tfFee.isUserInteractionEnabled = false
        // tfMoney.addTarget(self, action: #selector(textFieldDidChangeMoney(_:)), for: .editingChanged)
        viewTTNT.addSubview(tfFee)
        
        let lbTextGhiChu = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfFee.frame.origin.y + tfFee.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextGhiChu.textAlignment = .left
        lbTextGhiChu.textColor = UIColor.black
        lbTextGhiChu.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextGhiChu.text = "Ghi chú"
        viewTTNT.addSubview(lbTextGhiChu)
        
        tfGhiChu = UITextView(frame: CGRect(x: lbTextGhiChu.frame.origin.x , y: lbTextGhiChu.frame.origin.y  + lbTextGhiChu.frame.size.height + Common.Size(s:10), width: tfMoney.frame.size.width, height: tfMoney.frame.size.height * 2 ))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        tfGhiChu.layer.borderWidth = 0.5
        tfGhiChu.layer.borderColor = borderColor.cgColor
        tfGhiChu.layer.cornerRadius = 5.0
        tfGhiChu.delegate = self
        tfGhiChu.text = self.note
        tfGhiChu.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        viewTTNT.addSubview(tfGhiChu)
        
        btConfirm = UIButton()
        btConfirm.frame = CGRect(x: tfGhiChu.frame.origin.x, y:tfGhiChu.frame.size.height + tfGhiChu.frame.origin.y + Common.Size(s:10), width: tfMoney.frame.size.width, height: tfMoney.frame.size.height * 1.2)
        btConfirm.backgroundColor = UIColor(netHex:0x00955E)
        btConfirm.setTitle("Xác Nhận", for: .normal)
        btConfirm.addTarget(self, action: #selector(ConfirmAndCreateSOMOrder), for: .touchUpInside)
        btConfirm.layer.borderWidth = 0.5
        btConfirm.layer.borderColor = UIColor.white.cgColor
        btConfirm.layer.cornerRadius = 3
        viewTTNT.addSubview(btConfirm)
        viewTTNT.frame.size.height = btConfirm.frame.size.height + btConfirm.frame.origin.y + Common.Size(s: 10)
        
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTTNT.frame.origin.y + viewTTNT.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:45))
        
        NotificationCenter.default.addObserver(self, selector: #selector(didfinishCheckViettelPayOrder_SOM(notification:)), name: NSNotification.Name("finishCheckViettelPayOrder_SOM"), object: nil)
    }
    
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func ConfirmAndCreateSOMOrder() {
        guard let ghiChuText = self.tfGhiChu.text, !ghiChuText.isEmpty else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập nội dung ghi chú!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let totalAmountIncludingFee = self.money + self.fee
        var categoryId = ""
        if (self.itemViettelPaySOMInfo?.categoryIds.count ?? 0) > 0 {
            categoryId = self.itemViettelPaySOMInfo?.categoryIds[0] ?? ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "vi_VN")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let strDate = dateFormatter.string(from: Date())
        debugPrint("strDate: \(strDate)Z")
        
        let popup = PopupDialog(title: "Thông báo", message: "Bạn có muốn thanh toán \(Common.convertCurrencyDoubleV2(value: totalAmountIncludingFee)) VNĐ vào số điện thoại \(phoneNTT) không?", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            print("Completed")
        }
        
        let buttonOne = CancelButton(title: "Huỷ bỏ") {
            
        }
        let buttonTwo = DefaultButton(title: "Đồng ý thanh toán"){
            WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang tạo order...") {
                CRMAPIManager.ViettelPay_SOM_CreateOrder(requestId: "\(self.itemViettelPayNapTienResult?.integrationInfo.requestId ?? "")", responseId: "\(self.itemViettelPayNapTienResult?.integrationInfo.responseId ?? "")", otp: "\(self.otp)", keyOtpFee: "\(self.keyotp)", senderName: "\(self.hotenNTT)", senderPhone: "\(self.phoneNTT)", receiveName: "\(self.hotenCTK)", receivePhone: "\(self.phoneCTK)", providerId: "\(self.itemViettelPaySOMInfo?.details.providerId ?? "")", productId: "\(self.itemViettelPaySOMInfo?.id ?? "")", price: "\(self.money)", totalAmount: "\(self.money)", totalAmountIncludingFee: "\(totalAmountIncludingFee)", totalFee: "\(self.fee)", creationTime: "\(strDate)Z", categoryId: "\(categoryId)", descriptionNote: "\(self.tfGhiChu.text ?? "")") { (orderID, customerID, err) in
                    
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if err.count <= 0 {
                            self.orderID_SOM = orderID
                            
                            //kiem tra trang thai order _ tat ca bill
                            let vc = CountSecondSOMVC()
                            vc.orderId = orderID
                            self.customPresentViewController(self.presenter, viewController: vc, animated: true)
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
        popup.addButtons([buttonOne,buttonTwo])
        self.present(popup, animated: true, completion: nil)
    }
    @objc func didfinishCheckViettelPayOrder_SOM(notification: Notification) {
        
        let info = notification.userInfo
        let orderStatus = info?["orderStatusID"] as? CreateOrderResultViettelPay_SOM
        if orderStatus == .FAILED   {
            let alert = UIAlertController(title: "Thông báo", message: "Giao dịch thất bại!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (_) in
                let vc = ResultRechargeMoneyViettelPayViewController()
                vc.orderID = self.orderID_SOM
                self.navigationController?.pushViewController(vc, animated: true)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else {
            let vc = ResultRechargeMoneyViettelPayViewController()
            vc.orderID = self.orderID_SOM
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

class CountSecondSOMVC: UIViewController {
    var orderId = ""
    var lbCountTime: UILabel!
    var viewCircle: CircularProgressView!
    
//    Tất cả các bill sau khi tạo xong sẽ kiểm tra trạng thái (setInterval 1s trong 5s đầu, 5s trong 25s sau(kể từ sau khi 5s đầu kết thúc))
    var secondsRemaining = 30
    var first5s = 5
    var next25s = 25
    
    var timer1: Timer?
    var timer2: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame.size = CGSize(width: UIScreen.main.bounds.width * 0.7, height: Common.Size(s: 150))
        self.view.layer.cornerRadius = 8
        self.view.backgroundColor = .white
        
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: Common.Size(s:40)))
        viewHeader.backgroundColor = .blue
        self.view.addSubview(viewHeader)
        
        let lbTextGhiChu = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: viewHeader.frame.size.width - Common.Size(s:30), height: viewHeader.frame.height))
        lbTextGhiChu.textAlignment = .center
        lbTextGhiChu.textColor = UIColor.white
        lbTextGhiChu.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTextGhiChu.text = "Đang thực hiện giao dịch..."
        viewHeader.addSubview(lbTextGhiChu)
        
        lbCountTime = UILabel(frame: CGRect(x: self.view.frame.width/2 - Common.Size(s: 25), y: viewHeader.frame.height + ((self.view.frame.height - viewHeader.frame.height)/2 - Common.Size(s: 25)), width: Common.Size(s: 50), height: Common.Size(s: 50)))
        lbCountTime.textAlignment = .center
        lbCountTime.textColor = UIColor.blue
        lbCountTime.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))
        lbCountTime.text = "\(secondsRemaining)"
        self.view.addSubview(lbCountTime)
        
        viewCircle = CircularProgressView(frame: CGRect(x: self.view.frame.width/2 - Common.Size(s: 25), y: viewHeader.frame.height + ((self.view.frame.height - viewHeader.frame.height)/2 - Common.Size(s: 25)), width: Common.Size(s: 50), height: Common.Size(s: 50)))
        viewCircle.trackColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        viewCircle.progressColor = UIColor.blue
        self.view.addSubview(viewCircle)
        
        self.setClock()
        self.seperateTimeCheckStatus(orderId: "\(orderId)")
    }
    
    func setClock() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (time) in
            if self.secondsRemaining > 0 {
                print ("\(self.secondsRemaining) seconds")
                self.secondsRemaining -= 1
                self.lbCountTime.text = "\(self.secondsRemaining)"
                self.viewCircle.setProgressWithAnimation(duration: 1.0, value: 1)
            } else {
                time.invalidate()
                self.lbCountTime.text = "0"
                print ("stop 30s")
            }
        }
    }
    
    func seperateTimeCheckStatus(orderId: String) {
        timer1 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (_) in
            if self.first5s > 0 {
//                self.first5s -= 1
                self.checkOrderStatusCountTime(orderId: "\(orderId)", timerType: "5s")
            } else {
                self.timer1?.invalidate()
                print ("stop 5s")
                //next 25s
                self.timer2 = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { (timer2) in
                    if self.next25s > 0 {
//                        self.next25s -= 1
                        self.checkOrderStatusCountTime(orderId: "\(orderId)", timerType: "25s")
                    } else {
                        self.timer2?.invalidate()
                        print ("stop 25s")
                    }
                }
            }
        }
    }
    
    func checkOrderStatusCountTime(orderId: String, timerType: String) {
        DispatchQueue.main.async {
            CRMAPIManager.ViettelPay_SOM_CheckOrderStatus(orderId: "\(orderId)") { (orderStatus, msg, err) in
                if err.count <= 0 {
                    let dict_orderStatus : [String:Any] = ["orderStatusID": orderStatus]
                    if orderStatus == .CREATE { //right == 1
                        if self.lbCountTime.text != "0" {
                            if timerType == "5s" {
                                self.first5s -= 1
                            } else if timerType == "25s"{
                                self.next25s -= 1
                            }
                        } else {
                            if timerType == "5s" {
                                self.timer1?.invalidate()
                            } else if timerType == "25s"{
                                self.timer2?.invalidate()
                            }
                            self.dismiss(animated: true) {
                                NotificationCenter.default.post(name: NSNotification.Name.init("finishCheckViettelPayOrder_SOM"), object: nil, userInfo: dict_orderStatus)
                            }
                        }
                    } else {
                        if timerType == "5s" {
                            self.timer1?.invalidate()
                        } else if timerType == "25s"{
                            self.timer2?.invalidate()
                        }
                        self.dismiss(animated: true) {
                            NotificationCenter.default.post(name: NSNotification.Name.init("finishCheckViettelPayOrder_SOM"), object: nil, userInfo: dict_orderStatus)
                        }
                    }
                } else {
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (_) in
                        self.dismiss(animated: true, completion: nil)
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
