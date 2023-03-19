//
//  NapTienMoMoViewController.swift
//  mPOS
//
//  Created by tan on 12/7/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import AVFoundation
import Presentr

class NapTienMoMoViewController: UIViewController,UITextFieldDelegate {
    // MARK: - Properties
    
    private var scrollView:UIScrollView = {
        let scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private var tfPhone:UITextField!
    
    private var tfTenKH:UITextField!
    private var tfPhone2:UITextField!
    private var tfEmail:UITextField!
    private var tfMoney:UITextField!
    private var tfNoiDung:UITextField!
    private var tfTongSoTien:UITextField!
    private var btCheckOut:UIButton!
    private var btInPhieu:UIButton!
    private var btPending:UIButton!
    private var tfNguoiTT:UITextField!
    private var tfPhoneNTT:UITextField!
    
    var docentry:String = ""
    var transCode:String = ""
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
    var orderId = ""
    
    var isScan: Bool = false
    var configInput: MoMoInputOptions? {
        didSet {
            checkPermisson()
        }
    }
    private var configAction: MoMoActionConfiguration
    private lazy var viewModel = MoMoViewModel(configAction: configAction)
    var infoCustomer: InfoCustomerMoMo?
    var infoProviderSOM: InfoSOM?
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        configureUI()
        NotificationCenter.default.addObserver(self, selector: #selector(didfinishCheckStatusMomoSOM(notification:)), name: NSNotification.Name("finishCheckStatusMOMO_SOM"), object: nil)
    }
    init(configInput: MoMoInputOptions,infoProviderPOSM:InfoSOM){
        self.configInput = configInput
        self.configAction = .create
        self.infoProviderSOM = infoProviderPOSM
        super.init(nibName: nil, bundle:nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didfinishCheckStatusMomoSOM(notification: Notification) {
        let info = notification.userInfo
        let orderStatusID = info?["orderStatusID"] as? CreateOrderResultViettelPay_SOM
        
        self.fetchInfoOrderSomAPI(orderID: "\(self.orderId)", orderStastusID: orderStatusID ?? .FAILED)
    }
    
    // MARK: - API
    
    func fetchCheckInfoAPI(phone: String,with amount:Double = 0, configInput: MoMoInputOptions){
        
        guard let infoSOMs = self.infoProviderSOM?.configArr,infoSOMs.count > 0 else {
            return
        }
        ProgressView.shared.show()
            SOMAPIManager.shared.getInfoCustomerSOM(providerId: infoSOMs.first?.providerID ?? "",
                                                    productId: self.infoProviderSOM?.id ?? "",
                                                    phone: phone,
                                                    integrationGroupCode: infoSOMs.first?.integratedGroupCode ?? "",
                                                    integrationProductCode: infoSOMs.first?.integratedProductCode ?? "") {[weak self] result in
                guard let self = self else {return}
                ProgressView.shared.hide()
                    switch result {
                    case .success(let infoCustomer):
                        self.infoCustomer = infoCustomer
                        if amount != 0 {
                            self.infoCustomer?.amount = amount
                        }
                        self.populateCustomerData(configInput: configInput)
                    case .failure(let error):
                        self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
                        
                    }
                
            }
        
    }
    
    func fetchCreateOrderAPI(){
        guard let infoCustomer = infoCustomer else {return}
        guard let subject = infoCustomer.subject else {return}
        guard let infoProviderSOM = infoProviderSOM else {return}
        
        guard let configs = infoProviderSOM.configArr, configs.count > 0 else {return}
        guard let categoryIds = infoProviderSOM.categoryIDS,categoryIds.count > 0 else {return}
        guard let nameNTT = tfNguoiTT.text else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập tên người thanh toán!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        guard let phoneNTT = tfPhoneNTT.text else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập sđt người thanh toán!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        if !isScan {
            guard phoneNTT.count == 10 else {
                let alert = UIAlertController(title: "Thông báo", message: "Số điện thoại người thanh toán không hợp lệ!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (_) in
                }
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "vi_VN")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let strDate = dateFormatter.string(from: Date())
        debugPrint("strDate: \(strDate)Z")
        
        let referenceIntegrationInfo:Any = [
            "requestId": infoCustomer.integrationInfo?.requestId ?? "",
            "responseId": infoCustomer.integrationInfo?.requestId ?? ""
        ]
        
        let orderTransactionDtos:[Any] = [
            
            [
                "productId": "\(infoProviderSOM.id ?? "")",
                "providerId": "\(configs.first?.providerID ?? "")",
                "providerName": "MoMo",
                "productName": "Nạp tiền MoMo",
                "price": "\(infoCustomer.amount ?? 0)",
                "quantity": 1,
                "totalAmount": "\(infoCustomer.amount ?? 0)",
                "totalAmountIncludingFee": "\(infoCustomer.amount ?? 0)",
                "creationTime": "\(strDate)Z",
                "creationBy": Cache.user?.UserName ?? "",
                "integratedGroupCode": "\(configs.first?.integratedGroupCode ?? "")",
                "integratedGroupName": "",
                "integratedProductCode": "\(configs.first?.integratedProductCode ?? "")",
                "integratedProductName": "",
                "isOfflineTransaction": false,
                "referenceCode": "",
                "minFee": 0,
                "maxFee": 0,
                "percentFee": 0,
                "constantFee": 0,
                "paymentFeeType": 0,
                "paymentRule": 0,
                "productCustomerCode": "\(self.tfPhone.text ?? "")",
                "productCustomerName": "\(self.tfTenKH.text ?? "")",
                "productCustomerPhoneNumber": "\(self.tfPhone.text ?? "")",//CTK
                "productCustomerAddress": "\(subject.address ?? "")",
                "productCustomerEmailAddress": "",
                "description": "\(self.tfNoiDung.text ?? "")",
                "vehicleNumber": "",
                "categoryId": categoryIds[0],
                "isExportInvoice": false,
                "id": "",
                "extraProperties": [
                    "referenceIntegrationInfo":referenceIntegrationInfo
                ],
                "sender": [
                    "fullname": "\(nameNTT)",//NTT
                    "phonenumber": "\(phoneNTT)"
                ],
                "receiver": [
                    "fullname": "\(subject.name ?? "")", //CTK
                    "phonenumber": "\(self.tfPhone.text ?? "")"
                ]
                
            ]
            
        ]
        
        let payments:[Any] = [
            [
                "paymentType": "1",
                "paymentValue": "\(infoCustomer.amount ?? 0)",
                "paymentExtraFee": 0,
                "paymentPercentFee": 0
            ]
        ]
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            SOMAPIManager.shared.createOrderSOM(customerName: nameNTT,customerPhoneNumber: phoneNTT,subject: subject, orderTransactionDtos: orderTransactionDtos, payments: payments, creationTime: "\(strDate)Z") {[weak self] result in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    guard let self = self else {return}
                    switch result {
                    case .success(let order):
                        self.orderId = order.id ?? ""
                        
                        let vc = CountSecond_MomoSOMViewController()
                        vc.orderId = order.id ?? ""
                        debugPrint("orderMOMOID = \(order.id ?? "")")
                        self.customPresentViewController(self.presenter, viewController: vc, animated: true)
                        
                    case .failure(let error):
                        
                        self.showDialog(message: error.description)
                        
                    }
                }
            }
            
        }
    }
    func fetchInfoOrderSomAPI(orderID: String, orderStastusID: CreateOrderResultViettelPay_SOM){
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            SOMAPIManager.shared.getInfoOrderSOM(id: "\(orderID)") { result in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    switch result {
                    case .success(let infoOrderSOM):
                        if orderStastusID == .FAILED {
                            let alert = UIAlertController(title: "Thông báo", message: "Giao dịch thất bại!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default) { (_) in
                            
                                let newViewController = MoMoResultViewController()
                                newViewController.infoOrderSOM = infoOrderSOM
                                newViewController.orderID = orderID
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        } else {
                            let newViewController = MoMoResultViewController()
                            newViewController.infoOrderSOM = infoOrderSOM
                            newViewController.orderID = orderID
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }
                    case .failure(let error):
                        self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
                        
                    }
                }
            }
        }
    }
    // MARK: - Selectors
    
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
            self.tfTongSoTien.text = str
        }else{
            textField.text = ""
            self.tfTongSoTien.text = ""
        }
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let sdt = self.tfPhone.text, !sdt.isEmpty else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập số điện thoại!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (_) in
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if !isScan {
            guard sdt.count == 10 else {
                let alert = UIAlertController(title: "Thông báo", message: "Số điện thoại không hợp lệ!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (_) in
                }
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
        
        self.fetchCheckInfoAPI(phone: sdt, configInput: .all)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfPhone || textField == tfPhoneNTT {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            
            return range.location < 10 && allowedCharacters.isSuperset(of: characterSet)
        }
        
        return true
    }
    
    
    @objc func handlePayment(){
        guard let sdt = self.tfPhone.text, !sdt.isEmpty else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập số điện thoại!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (_) in
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if !isScan {
            guard sdt.count == 10 else {
                let alert = UIAlertController(title: "Thông báo", message: "Số điện thoại không hợp lệ! (10 số)", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (_) in
                }
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
        
        guard let note = tfNoiDung.text, !note.isEmpty else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập nội dung!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        var money = tfMoney.text!
        money = money.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        money = money.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        money = money.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        if(money.isEmpty || money == "0"){
            self.showDialog(message: "Vui lòng nhập số tiền !")
            return
        }
        infoCustomer?.amount = Double(money) ?? 0
        
        let popup = PopupDialog(title: "Thông báo", message: "Bạn có muốn thanh toán \(Common.convertCurrencyDoubleV2(value: infoCustomer?.amount ?? 0)) VNĐ vào số ví \(self.tfPhone.text!) không?", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            print("Completed")
        }
        
        let buttonOne = CancelButton(title: "Huỷ bỏ") {
            
        }
        let buttonTwo = DefaultButton(title: "Đồng ý thanh toán"){
            self.fetchCreateOrderAPI()
        }
        popup.addButtons([buttonOne,buttonTwo])
        self.present(popup, animated: true, completion: nil)
    }
    
    
    
    @objc func actionScan(_: UITapGestureRecognizer){
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { code in
			let trimmingCode:String  = code
			if let index = trimmingCode.index(of: "||transfer_myqr") {
				let substring = trimmingCode[..<index]
				let string = String(substring)
				print(string)
				let amount = Double(string.components(separatedBy: "|").last ?? "0") ?? 0
				self.fetchCheckInfoAPI(phone: substring + "||",with: amount, configInput: .scan("\(substring + "||" )"))
			}


        }
        self.present(viewController, animated: false, completion: nil)
    }
    
    
    
    @objc func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
    // MARK: - Helpers
    func configureUI(){
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height )
        
        self.title = "Nạp tiền MoMo"
        
        let lbTitleThongTinTK = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTitleThongTinTK.textAlignment = .left
        lbTitleThongTinTK.textColor = .mainGreen
        lbTitleThongTinTK.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        lbTitleThongTinTK.text = "Thông tin tài khoản"
        scrollView.addSubview(lbTitleThongTinTK)
        
        
        let lbTextPhone = Common.tileLabel(x: Common.Size(s:15), y: lbTitleThongTinTK.frame.origin.y + lbTitleThongTinTK.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Số điện thoại ví momo")
        scrollView.addSubview(lbTextPhone)
        
        
        tfPhone = Common.inputTextTextField(x: Common.Size(s:15), y: lbTextPhone.frame.origin.y + lbTextPhone.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:50), height: Common.Size(s: 40), fontSize: 15, isNumber: true)
        scrollView.addSubview(tfPhone)
        tfPhone.delegate  = self
        tfPhone.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        let btnScan = UIImageView(frame:CGRect(x: tfPhone.frame.size.width + tfPhone.frame.origin.x + Common.Size(s: 5) , y:  tfPhone.frame.origin.y, width: Common.Size(s:25), height: tfPhone.frame.size.height));
        btnScan.image = #imageLiteral(resourceName: "scan_barcode_1")
        btnScan.contentMode = .scaleAspectFit
        scrollView.addSubview(btnScan)
        
        let tapScan = UITapGestureRecognizer(target: self, action: #selector(actionScan(_:)))
        btnScan.isUserInteractionEnabled = true
        btnScan.addGestureRecognizer(tapScan)
        
        
        
        let lbTitleTenKH = Common.tileLabel(x: Common.Size(s:15), y: tfPhone.frame.origin.y + tfPhone.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Tên khách hàng")
        scrollView.addSubview(lbTitleTenKH)
        
        
        tfTenKH = Common.inputTextTextField(x: Common.Size(s:15), y: lbTitleTenKH.frame.origin.y + lbTitleTenKH.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 40), fontSize: 15)
        tfTenKH.isUserInteractionEnabled = false
        scrollView.addSubview(tfTenKH)
        
        
        let lbTextPhone2 = Common.tileLabel(x: Common.Size(s:15), y: tfTenKH.frame.origin.y + tfTenKH.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Số điện thoại")
        scrollView.addSubview(lbTextPhone2)
        
        
        tfPhone2 = Common.inputTextTextField(x: Common.Size(s:15), y: lbTextPhone2.frame.origin.y + lbTextPhone2.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 40), fontSize: 15)
        tfPhone2.isEnabled = false
        
        scrollView.addSubview(tfPhone2)
        
        
        let lbTitleEmail = Common.tileLabel(x: Common.Size(s:15), y: tfPhone2.frame.origin.y + tfPhone2.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Email")
        scrollView.addSubview(lbTitleEmail)
        
        
        
        tfEmail = Common.inputTextTextField(x: Common.Size(s:15), y: lbTitleEmail.frame.origin.y + lbTitleEmail.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 40), fontSize: 15)
        tfEmail.isUserInteractionEnabled = false
        scrollView.addSubview(tfEmail)
        
        let lbTitleThongTinNTT = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfEmail.frame.size.height + tfEmail.frame.origin.y + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTitleThongTinNTT.textAlignment = .left
        lbTitleThongTinNTT.textColor = .mainGreen
        lbTitleThongTinNTT.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        lbTitleThongTinNTT.text = "Thông tin người thanh toán"
        scrollView.addSubview(lbTitleThongTinNTT)
        
        let lbTenKHNTT = Common.tileLabel(x: Common.Size(s:15), y: lbTitleThongTinNTT.frame.origin.y + lbTitleThongTinNTT.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Tên khách hàng")
        scrollView.addSubview(lbTenKHNTT)
        
        
        tfNguoiTT = Common.inputTextTextField(x: Common.Size(s:15), y: lbTenKHNTT.frame.origin.y + lbTenKHNTT.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 40), fontSize: 15)
        
        scrollView.addSubview(tfNguoiTT)
        
        
        let lbPhoneNTT = Common.tileLabel(x: Common.Size(s:15), y: tfNguoiTT.frame.origin.y + tfNguoiTT.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Số điện thoại")
        scrollView.addSubview(lbPhoneNTT)
        
        
        tfPhoneNTT = Common.inputTextTextField(x: Common.Size(s:15), y: lbPhoneNTT.frame.origin.y + lbPhoneNTT.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 40), fontSize: 15,isNumber:true)
        tfPhoneNTT.delegate = self
        scrollView.addSubview(tfPhoneNTT)
        
        
        let lbTitleSoTienCanNap = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfPhoneNTT.frame.origin.y + tfPhoneNTT.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTitleSoTienCanNap.textAlignment = .left
        lbTitleSoTienCanNap.textColor = .mainGreen
        lbTitleSoTienCanNap.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        lbTitleSoTienCanNap.text = "THÔNG TIN NẠP TIỀN"
        scrollView.addSubview(lbTitleSoTienCanNap)
        
        
        let lbTitleTien = Common.tileLabel(x: Common.Size(s:15), y: lbTitleSoTienCanNap.frame.origin.y + lbTitleSoTienCanNap.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Tiền")
        scrollView.addSubview(lbTitleTien)
        
        
        
        tfMoney = Common.inputTextTextField(x: Common.Size(s:15), y: lbTitleTien.frame.origin.y + lbTitleTien.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 40), fontSize: 15, isNumber: true)
        tfMoney.delegate = self
        tfMoney.addTarget(self, action: #selector(textFieldDidChangeMoney(_:)), for: .editingChanged)
        scrollView.addSubview(tfMoney)
        
        
        
        
        let lbTitleNoiDung = Common.tileLabel(x: Common.Size(s:15), y: tfMoney.frame.origin.y + tfMoney.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Nội Dung")
        scrollView.addSubview(lbTitleNoiDung)
        
        
        
        tfNoiDung = Common.inputTextTextField(x: Common.Size(s:15), y: lbTitleNoiDung.frame.origin.y + lbTitleNoiDung.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 40), fontSize: 15)
        
        scrollView.addSubview(tfNoiDung)
        
        
        
        
        let lbTitleThanhToan = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfNoiDung.frame.origin.y + tfNoiDung.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTitleThanhToan.textAlignment = .left
        lbTitleThanhToan.textColor = .mainGreen
        lbTitleThanhToan.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        lbTitleThanhToan.text = "THANH TOÁN"
        scrollView.addSubview(lbTitleThanhToan)
        
        
        let lbTitleTongSoTien = Common.tileLabel(x: Common.Size(s:15), y: lbTitleThanhToan.frame.origin.y + lbTitleThanhToan.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Tổng số tiền")
        scrollView.addSubview(lbTitleTongSoTien)
        
        
        
        tfTongSoTien = Common.inputTextTextField(x: Common.Size(s: 15), y: lbTitleTongSoTien.frame.origin.y + lbTitleTongSoTien.frame.size.height + Common.Size(s:5), width:  scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:40),fontSize: 15)
        tfTongSoTien.isUserInteractionEnabled = false
        scrollView.addSubview(tfTongSoTien)
        
        
        let imageCheckTienMat = UIImageView(frame: CGRect(x: tfTongSoTien.frame.origin.x  , y: tfTongSoTien.frame.origin.y + tfTongSoTien.frame.size.height + Common.Size(s:5), width: 20 , height: 20))
        imageCheckTienMat.image = #imageLiteral(resourceName: "iconcheck")
        imageCheckTienMat.contentMode = UIView.ContentMode.scaleAspectFit
        
        
        scrollView.addSubview(imageCheckTienMat)
        
        
        let lbTienMat = Common.tileLabel(x: imageCheckTienMat.frame.origin.x + imageCheckTienMat.frame.size.width + Common.Size(s: 3), y: imageCheckTienMat.frame.origin.y, width: scrollView.frame.size.width / 3, height: Common.Size(s:14), title: "Tiền mặt")
        scrollView.addSubview(lbTienMat)
        
        btCheckOut = Common.buttonAction(x: tfTongSoTien.frame.origin.x, y: lbTienMat.frame.origin.y + lbTienMat.frame.size.height + Common.Size(s:20) , width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 40), title: "Thanh Toán")
        btCheckOut.addTarget(self, action: #selector(handlePayment), for: .touchUpInside)
        scrollView.addSubview(btCheckOut)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btCheckOut.frame.origin.y + btCheckOut.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 60))
    }
    
    func checkPermisson(){
        switch configInput {
        case .all:
            tfPhone.isUserInteractionEnabled = true
            isScan = false
        case .scan(let message):
            tfPhone.isUserInteractionEnabled = false
            isScan = true
        case .none:
            print("Error")
        }
    }
    func populateCustomerData(configInput: MoMoInputOptions){
        
        guard let infoCustomer = infoCustomer else {return}
        guard let subject = infoCustomer.subject else {return}
        switch configInput {
        case .all:
            self.tfTenKH.text = subject.name
            self.tfPhone2.text = self.tfPhone.text ?? ""
            self.tfNguoiTT.text = subject.name
            self.tfPhoneNTT.text = self.tfPhone.text ?? ""
            self.tfEmail.text = subject.emailAddress
            self.tfMoney.text = Common.convertCurrencyDoubleV2(value: infoCustomer.amount ?? 0)
            
            self.tfPhone.isEnabled = false
            self.tfTenKH.isEnabled = false
            self.tfPhone2.isEnabled = false
            self.tfEmail.isEnabled = false
            
            self.configInput = .all
        case .scan(let code):
            self.tfTenKH.text = subject.name
            self.tfPhone.text = subject.phoneNumber
            self.tfPhone2.text = subject.phoneNumber
            self.tfNguoiTT.text = subject.name
            self.tfPhoneNTT.text = subject.phoneNumber
            self.tfEmail.text = subject.emailAddress
            
            self.tfTongSoTien.text = Common.convertCurrencyDoubleV2(value: infoCustomer.amount ?? 0)
            self.tfMoney.text = Common.convertCurrencyDoubleV2(value: infoCustomer.amount ?? 0)
            
            self.tfPhone.isEnabled = false
            self.tfTenKH.isEnabled = false
            self.tfPhone2.isEnabled = false
            self.tfEmail.isEnabled = false
            self.tfMoney.isEnabled = false
            self.tfTongSoTien.isEnabled = false
            
            self.configInput = .scan(code)
        }
        
    }
    
    
}

class CountSecond_MomoSOMViewController: UIViewController {
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
        viewHeader.backgroundColor = Constants.COLORS.bold_green
        self.view.addSubview(viewHeader)
        
        let lbTextGhiChu = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: viewHeader.frame.size.width - Common.Size(s:30), height: viewHeader.frame.height))
        lbTextGhiChu.textAlignment = .center
        lbTextGhiChu.textColor = UIColor.white
        lbTextGhiChu.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTextGhiChu.text = "Đang thực hiện giao dịch..."
        viewHeader.addSubview(lbTextGhiChu)
        
        lbCountTime = UILabel(frame: CGRect(x: self.view.frame.width/2 - Common.Size(s: 25), y: viewHeader.frame.height + ((self.view.frame.height - viewHeader.frame.height)/2 - Common.Size(s: 25)), width: Common.Size(s: 50), height: Common.Size(s: 50)))
        lbCountTime.textAlignment = .center
        lbCountTime.textColor = UIColor.black
        lbCountTime.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))
        lbCountTime.text = "\(secondsRemaining)"
        self.view.addSubview(lbCountTime)
        
        viewCircle = CircularProgressView(frame: CGRect(x: self.view.frame.width/2 - Common.Size(s: 25), y: viewHeader.frame.height + ((self.view.frame.height - viewHeader.frame.height)/2 - Common.Size(s: 25)), width: Common.Size(s: 50), height: Common.Size(s: 50)))
        viewCircle.trackColor = Constants.COLORS.bold_green
        viewCircle.progressColor = Constants.COLORS.bold_green
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
                self.fetchCheckStatusAPI_V2(with: "\(orderId)", timerType: "5s")
            } else {
                self.timer1?.invalidate()
                print ("stop 5s")
                //next 25s
                self.timer2 = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { (timer2) in
                    if self.next25s > 0 {
                        self.fetchCheckStatusAPI_V2(with: "\(orderId)", timerType: "25s")
                    } else {
                        self.timer2?.invalidate()
                        print ("stop 25s")
                    }
                }
            }
        }
    }
    
    func fetchCheckStatusAPI_V2(with orderID: String, timerType: String){
        DispatchQueue.main.async {
            SOMAPIManager.shared.checkStatusSOM(orderId: "\(orderID)", integratedGroupCode: "MOMO") {[weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let statusOrder):
                    if let orderCode = CreateOrderResultViettelPay_SOM(rawValue: statusOrder.orderStatus ?? 0) {
                        let dict_OrderStatus: [String: Any] = ["orderStatusID" : orderCode]
                        if orderCode == .CREATE { //right == 1
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
                                    NotificationCenter.default.post(name: NSNotification.Name.init("finishCheckStatusMOMO_SOM"), object: nil, userInfo: dict_OrderStatus)
                                }
                            }
                        } else {
                            if timerType == "5s" {
                                self.timer1?.invalidate()
                            } else if timerType == "25s"{
                                self.timer2?.invalidate()
                            }
                            self.dismiss(animated: true) {
                                NotificationCenter.default.post(name: NSNotification.Name.init("finishCheckStatusMOMO_SOM"), object: nil, userInfo: dict_OrderStatus)
                            }
                        }
                        
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "Không tìm thấy orderCode tương ứng", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default) { (_) in
                            self.dismiss(animated: true, completion: nil)
                        }
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                case .failure(let error):
                    let alert = UIAlertController(title: "Thông báo", message: "\(error)", preferredStyle: .alert)
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

extension StringProtocol {
	func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
		range(of: string, options: options)?.lowerBound
	}
}
