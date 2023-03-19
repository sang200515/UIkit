//
//  TheNapSOMPaymentViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 23/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Presentr

class TheNapSOMPaymentViewController: UIViewController {
    
    @IBOutlet weak var lbCash: UILabel!
    @IBOutlet weak var tbvCard: UITableView!
    @IBOutlet weak var cstCard: NSLayoutConstraint!
    @IBOutlet weak var tbvVoucher: UITableView!
    @IBOutlet weak var cstVoucher: NSLayoutConstraint!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var imgExportInvoice: UIImageView!
    @IBOutlet weak var btnExportInvoice: UIButton!
    @IBOutlet weak var vOTP: UIView!
    @IBOutlet weak var tfOTP: UITextField!
    @IBOutlet weak var btnOTP: UIButton!
    
    var type: TheCaoSOMType = .TheNap
    var isVAS: Bool = false
    private var isExportInvoice: Bool = false
    private var tempOrderParam: TheNapSOMOrderDetail = TheNapSOMOrderDetail(JSON: [:])!
    private let presenter: Presentr = {
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
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadPaymentDetail()
    }
    
    private func setupUI() {
        title = "Hình Thức Thanh Toán"
        addBackButton()
        
        btnConfirm.roundCorners(.allCorners, radius: 5)
        btnOTP.roundCorners(.allCorners, radius: 5)
        vOTP.isHidden = !isVAS
        
        if TheCaoSOMDataManager.shared.selectedItem.name == "Vinaphone" {
            isExportInvoice = true
            imgExportInvoice.image = UIImage(named: "check-1")!
            btnExportInvoice.isEnabled = false
        }
    }
    
    private func loadPaymentDetail() {
        lbTotal.text = "\(Common.convertCurrencyV2(value: TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.totalAmountIncludingFee ?? 0)) VNĐ"
        
        let cash = TheCaoSOMDataManager.shared.orderDetail.payments.first(where: { $0.paymentType == "1" })
        lbCash.text = "\(Common.convertCurrencyV2(value: cash?.paymentValue ?? 0)) VNĐ"
        
        let card = TheCaoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == "2" }
        cstCard.constant = CGFloat(card.count * 165)
        tbvCard.reloadData()
        
        let voucher = TheCaoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == "4" }
        cstVoucher.constant = CGFloat(voucher.count * 120)
        tbvVoucher.reloadData()
    }
    
    private func setupTableView() {
        tbvCard.registerTableCell(ThuHoSOMPaymentTableViewCell.self)
        tbvVoucher.registerTableCell(TheNapSOMVoucherTableViewCell.self)
        tbvCard.estimatedRowHeight = 100
        tbvVoucher.estimatedRowHeight = 100
        tbvCard.rowHeight = UITableView.automaticDimension
        tbvVoucher.rowHeight = UITableView.automaticDimension
    }
    
    private func prepareRemoveParam(item: TheNapSOMPayment) {
        tempOrderParam.orderStatus = TheCaoSOMDataManager.shared.orderDetail.orderStatus
        tempOrderParam.warehouseCode = TheCaoSOMDataManager.shared.orderDetail.warehouseCode
        tempOrderParam.warehouseAddress = TheCaoSOMDataManager.shared.orderDetail.warehouseAddress
        tempOrderParam.creationBy = TheCaoSOMDataManager.shared.orderDetail.creationBy
        tempOrderParam.creationTime = TheCaoSOMDataManager.shared.orderDetail.creationTime
        tempOrderParam.referenceSystem = TheCaoSOMDataManager.shared.orderDetail.referenceSystem
        tempOrderParam.orderTransactionDtos = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos
        tempOrderParam.payments = TheCaoSOMDataManager.shared.orderDetail.payments
        
        let index = tempOrderParam.payments.firstIndex(where: { $0.paymentType == item.paymentType &&
                                                        $0.paymentCode == item.paymentCode &&
                                                        $0.paymentCodeDescription == item.paymentCodeDescription &&
                                                        $0.paymentAccountNumber == item.paymentAccountNumber &&
                                                        $0.paymentValue == item.paymentValue &&
                                                        $0.bankType == item.bankType &&
                                                        $0.bankTypeDescription == item.bankTypeDescription &&
                                                        $0.cardType == item.cardType &&
                                                        $0.cardTypeDescription == item.cardTypeDescription &&
                                                        $0.isCardOnline == item.isCardOnline &&
                                                        $0.paymentExtraFee == item.paymentExtraFee &&
                                                        $0.paymentPercentFee == item.paymentPercentFee })
        
        guard let i = index else { return }
        tempOrderParam.payments.remove(at: i)
    }
    
    private func removePayment(item: TheNapSOMPayment, completion: @escaping (Bool) -> ()) {
        prepareRemoveParam(item: item)
        
        Provider.shared.thecaoSOMAPIService.removePayment(param: tempOrderParam, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            TheCaoSOMDataManager.shared.orderDetail = data
            
            DispatchQueue.main.async {
                self.loadPaymentDetail()
            }
            completion(true)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            completion(false)
        })
    }
    
    private func getOrderDetail() {
        Provider.shared.thecaoSOMAPIService.getOrderDetail(orderId: TheCaoSOMDataManager.shared.order.id, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            TheCaoSOMDataManager.shared.orderDetail = data
            
            let vc = TheNapSOMOrderSummaryViewController()
            vc.type = self.type
            self.navigationController?.pushViewController(vc, animated: true)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    private func validateInputs() -> Bool {
        if isVAS {
            guard let otp = tfOTP.text, !otp.isEmpty else {
                showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập OTP", titleButton: "OK")
                return false
            }
            
            guard otp.count == 6 else {
                showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập OTP 6 chữ số", titleButton: "OK")
                return false
            }
        }
        
        return true
    }
    
    @IBAction func addCardButtonPressed(_ sender: Any) {
        let vc = TheNapSOMAddPaymentViewController()
        vc.didChangePayment = {
            DispatchQueue.main.async {
                self.loadPaymentDetail()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addVoucherButtonPressed(_ sender: Any) {
        let vc = TheNapSOMAddVoucherViewController()
        vc.didChangePayment = {
            DispatchQueue.main.async {
                self.loadPaymentDetail()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func exportInvoicePressed(_ sender: Any) {
        let check = UIImage(named: "check-1")!
        let uncheck = UIImage(named: "check-2")!
        isExportInvoice = !isExportInvoice
        
        imgExportInvoice.image = isExportInvoice ? check : uncheck
    }
    
    @IBAction func otpButtonPressed(_ sender: Any) {
        let providerID = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.providerID ?? ""
        let customerID = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.productCustomerPhoneNumber ?? ""
        
        if TheCaoSOMDataManager.shared.selectedItem.name == "Vinaphone" {
            Provider.shared.thecaoSOMAPIService.sendVinaOTP(providerID: providerID, customerID: customerID, serviceCode: "3TVD149", processID: "kttsH-ImP0enc5XeQ93RKQ", success: { [weak self] result in
                guard let self = self, let data = result else { return }
//                if data.integrationInfo.returnedCode == "200" {
                    self.showAlertOneButton(title: "Thông báo", with: "Lấy OTP thành công", titleButton: "OK", handleOk: {
                        self.btnOTP.isEnabled = false
                        TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first!.extraProperties.referenceIntegrationInfo.requestID = data.integrationInfo.requestID
                        TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first!.extraProperties.referenceIntegrationInfo.responseID = data.integrationInfo.responseID
                    })
//                }
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        } else {
            let productType = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.extraProperties.type ?? ""
            let productCode = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.integratedProductCode ?? ""
            
            Provider.shared.thecaoSOMAPIService.sendViettelOTP(providerID: providerID, customerID: customerID, productType: productType, productCode: productCode, success: { [weak self] result in
                guard let self = self, let data = result else { return }
                if data.integrationInfo.returnedCode == "200" {
                    self.showAlertOneButton(title: "Thông báo", with: "Lấy OTP thành công", titleButton: "OK", handleOk: {
                        self.btnOTP.isEnabled = false
                        TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first!.extraProperties.referenceIntegrationInfo.requestID = data.integrationInfo.requestID
                        TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first!.extraProperties.referenceIntegrationInfo.responseID = data.integrationInfo.responseID
                    })
                }
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        }
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        guard validateInputs() else { return }
        showAlertTwoButton(title: "Thông báo", with: "Giao dịch không được phép hủy. Vui lòng kiểm tra với khách hàng trước khi thanh toán", titleButtonOne: "Tiếp tục", titleButtonTwo: "Huỷ", handleButtonOne: {
            self.btnConfirm.isEnabled = false
            TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first!.extraProperties.otp = self.tfOTP.text ?? ""
            TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first!.isExportInvoice = self.isExportInvoice
            Provider.shared.thecaoSOMAPIService.makeOrder(param: TheCaoSOMDataManager.shared.orderDetail, success: { [weak self] result in
                guard let self = self, let data = result else { return }
                TheCaoSOMDataManager.shared.order = data

                let vc = CountSecondTheNapSOMPaymentViewController()
                vc.orderId = data.id
                vc.didFinishCheckStatus = {
                    self.getOrderDetail()
                }
                self.customPresentViewController(self.presenter, viewController: vc, animated: true)
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.btnConfirm.isEnabled = true
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        })
    }
}

extension TheNapSOMPaymentViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
            
        return range.location < 6 && allowedCharacters.isSuperset(of: characterSet)
    }
}

extension TheNapSOMPaymentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tbvCard:
            return TheCaoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == "2" }.count
        default:
            return TheCaoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == "4" }.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case tbvCard:
            let cell = tableView.dequeueTableCell(ThuHoSOMPaymentTableViewCell.self)
            let payment = TheCaoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == "2" }[indexPath.row]
            cell.setupCell(payment: payment)
            
            return cell
        default:
            let cell = tableView.dequeueTableCell(TheNapSOMVoucherTableViewCell.self)
            let payment = TheCaoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == "4" }[indexPath.row]
            cell.setupCell(payment: payment)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Xoá") { (action, sourceView, completionHandler) in
            var item = TheNapSOMPayment(JSON: [:])!
            self.showAlertTwoButton(title: "Thông báo", with: "Bạn có chắc đang muốn huỷ giao dịch này.", titleButtonOne: "Xác nhận", titleButtonTwo: "Huỷ", handleButtonOne: {
                switch tableView {
                case self.tbvCard:
                    item = TheCaoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == "2" }[indexPath.row]
                default:
                    item = TheCaoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == "4" }[indexPath.row]
                }
                self.removePayment(item: item, completion: { result in
                    DispatchQueue.main.async {
                        completionHandler(result)
                    }
                })
            }, handleButtonTwo: {
                DispatchQueue.main.async {
                    completionHandler(false)
                }
            })
        }
        
        delete.backgroundColor = .red
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = true
        return swipeActionConfig
    }
}

class CountSecondTheNapSOMPaymentViewController: UIViewController {
    var orderId = ""
    var lbCountTime: UILabel!
    var viewCircle: CircularProgressView!
    
    var secondsRemaining = 30
    var first5s = 5
    var next25s = 25
    
    var timer1: Timer?
    var timer2: Timer?
    
    var didFinishCheckStatus: (() -> Void)?
    
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
                self.secondsRemaining -= 1
                self.lbCountTime.text = "\(self.secondsRemaining)"
                self.viewCircle.setProgressWithAnimation(duration: 1.0, value: 1)
            } else {
                time.invalidate()
                self.lbCountTime.text = "0"
            }
        }
    }
    
    func seperateTimeCheckStatus(orderId: String) {
        timer1 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (_) in
            if self.first5s > 0 {
                self.checkOrderStatusCountTime(orderId: "\(orderId)", timerType: "5s")
            } else {
                self.timer1?.invalidate()
                self.timer2 = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { (timer2) in
                    if self.next25s > 0 {
                        self.checkOrderStatusCountTime(orderId: "\(orderId)", timerType: "25s")
                    } else {
                        self.timer2?.invalidate()
                    }
                }
            }
        }
    }
    
    func checkOrderStatusCountTime(orderId: String, timerType: String) {
        DispatchQueue.main.async {
            Provider.shared.thecaoSOMAPIService.getOrderStatus(orderId: TheCaoSOMDataManager.shared.order.id, groupCode: TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.integratedGroupCode ?? "", success: { result in
                if let data = result {
                    TheCaoSOMDataManager.shared.status = data
                    
                    if data.orderStatus == 1 {
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
                            self.didFinishCheckStatus?()
                            self.dismiss(animated: true, completion: nil)
                        }
                    } else {
                        if timerType == "5s" {
                            self.timer1?.invalidate()
                        } else if timerType == "25s"{
                            self.timer2?.invalidate()
                        }
                        self.didFinishCheckStatus?()
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    self.showAlertOneButton(title: "Thông báo", with: "Không tìm thấy order code tương ứng", titleButton: "OK", handleOk: {
                        self.dismiss(animated: true, completion: nil)
                    })
                }
            }, failure: { error in
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK", handleOk: {
                    self.dismiss(animated: true, completion: nil)
                })
            })
        }
    }
}
