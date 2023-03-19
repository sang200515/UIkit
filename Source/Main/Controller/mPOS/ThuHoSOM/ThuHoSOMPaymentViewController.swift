//
//  ThuHoSOMPaymentViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 02/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Presentr

class ThuHoSOMPaymentViewController: UIViewController {
    
    @IBOutlet weak var lbCustomerName: UILabel!
    @IBOutlet weak var lbCustomerPayName: UILabel!
    @IBOutlet weak var lbCustomerPhone: UILabel!
    @IBOutlet weak var lbCode: UILabel!
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var lbProduct: UILabel!
    @IBOutlet weak var lbCash: UILabel!
    @IBOutlet weak var tbvCard: UITableView!
    @IBOutlet weak var cstCard: NSLayoutConstraint!
    @IBOutlet weak var tbvTransfer: UITableView!
    @IBOutlet weak var cstTransfer: NSLayoutConstraint!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var btnConfirm: UIButton!
    
    private var tempOrderParam: ThuHoSOMOrderParam = ThuHoSOMOrderParam(JSON: [:])!
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
        
        lbCustomerName.text = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.productCustomerName&
        lbCustomerPayName.text = ThuHoSOMDataManager.shared.orderDetail.customerName
        lbCustomerPhone.text = ThuHoSOMDataManager.shared.orderDetail.customerPhoneNumber
        lbCode.text = ThuHoSOMDataManager.shared.selectedCustomer.contractNo
        lbCategory.text = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.productName&
        lbProduct.text = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.providerName&
    }
    
    private func loadPaymentDetail() {
        lbTotal.text = "\(Common.convertCurrencyV2(value: ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.totalAmountIncludingFee ?? 0)) VNĐ"
        
        let cash = ThuHoSOMDataManager.shared.orderDetail.payments.first(where: { $0.paymentType == 1 })
        lbCash.text = "\(Common.convertCurrencyV2(value: cash?.paymentValue ?? 0)) VNĐ"
        
        let card = ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 2 }
        cstCard.constant = CGFloat(card.count * 165)
        tbvCard.reloadData()
        
        let transfer = ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 3 }
        cstTransfer.constant = CGFloat(transfer.count * 120)
        tbvTransfer.reloadData()
    }
    
    private func setupTableView() {
        tbvCard.registerTableCell(ThuHoSOMPaymentTableViewCell.self)
        tbvTransfer.registerTableCell(ThuHoSOMPaymentTableViewCell.self)
        tbvCard.estimatedRowHeight = 100
        tbvTransfer.estimatedRowHeight = 100
        tbvCard.rowHeight = UITableView.automaticDimension
        tbvTransfer.rowHeight = UITableView.automaticDimension
    }
    
    private func prepareRemoveParam(item: ThuHoSOMPaymentDetail) {
        tempOrderParam.orderStatusDisplay = ThuHoSOMDataManager.shared.orderParam.orderStatusDisplay
        tempOrderParam.billNo = ThuHoSOMDataManager.shared.orderParam.billNo
        tempOrderParam.customerId = ThuHoSOMDataManager.shared.orderParam.customerId
        tempOrderParam.customerName = ThuHoSOMDataManager.shared.orderParam.customerName
        tempOrderParam.customerPhoneNumber = ThuHoSOMDataManager.shared.orderParam.customerPhoneNumber
        tempOrderParam.warehouseCode = ThuHoSOMDataManager.shared.orderParam.warehouseCode
        tempOrderParam.regionCode = ThuHoSOMDataManager.shared.orderParam.regionCode
        tempOrderParam.creationBy = ThuHoSOMDataManager.shared.orderParam.creationBy
        tempOrderParam.creationTime = ThuHoSOMDataManager.shared.orderParam.creationTime
        tempOrderParam.referenceSystem = ThuHoSOMDataManager.shared.orderParam.referenceSystem
        tempOrderParam.referenceValue = ThuHoSOMDataManager.shared.orderParam.referenceValue
        tempOrderParam.orderTransactionDtos = ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos
        tempOrderParam.payments = ThuHoSOMDataManager.shared.orderParam.payments
        tempOrderParam.id = ThuHoSOMDataManager.shared.orderParam.id
        tempOrderParam.ip = ThuHoSOMDataManager.shared.orderParam.ip
        
        let index = tempOrderParam.payments.firstIndex(where: { $0.paymentPercentFee == item.paymentPercentFee &&
//                                                        $0.isChargeOnCash == item.isChargeOnCash &&
                                                        $0.isCardOnline == item.isCardOnline &&
                                                        $0.cardType == item.cardType &&
                                                        $0.paymentExtraFee == item.paymentExtraFee &&
                                                        $0.bankType == item.bankType &&
                                                        $0.paymentValue == item.paymentValue &&
                                                        $0.bankTypeDescription == item.bankTypeDescription &&
                                                        $0.paymentType == String(item.paymentType) &&
                                                        $0.cardTypeDescription == item.cardTypeDescription &&
                                                        $0.paymentCode == item.paymentCode })
        
        guard let i = index else { return }
        tempOrderParam.payments.remove(at: i)
    }
    
    private func updatePaymentParam(payments: [ThuHoSOMPaymentDetail]) {
        var paymentParams: [ThuHoSOMPaymentDetailParam] = []
        for payment in payments {
            let param = ThuHoSOMPaymentDetailParam(JSON: [:])!
            param.paymentType = String(payment.paymentType)
            param.paymentCode = payment.paymentCode
            param.paymentValue = payment.paymentValue
            param.bankType = payment.bankType
            param.cardType = payment.cardType
            param.paymentExtraFee = payment.paymentExtraFee
            param.paymentPercentFee = payment.paymentPercentFee
            param.cardTypeDescription = payment.cardTypeDescription
            param.bankTypeDescription = payment.bankTypeDescription
            param.isCardOnline = payment.isCardOnline
//            param.isChargeOnCash = payment.isChargeOnCash
            
            paymentParams.append(param)
        }
        
        ThuHoSOMDataManager.shared.orderParam.payments = paymentParams
    }
    
    private func validInvoices() -> Bool {
        let checkedInvoices = ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos.first!.invoices.filter { $0.isCheck }
        if checkedInvoices.count < 1 {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng quay lại chọn kỳ thanh toán", titleButton: "OK", handleOk: {
                self.navigationController?.popViewController(animated: true)
            })
            return false
        }
        
        return true
    }
    
    private func removePayment(item: ThuHoSOMPaymentDetail, completion: @escaping (Bool) -> ()) {
        prepareRemoveParam(item: item)
        
        Provider.shared.thuhoSOMAPIService.removePayment(param: tempOrderParam, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            var dtos: [ThuHoSOMOrderTransactionDtoParam] = []
            let dto = ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos.first!
            dto.totalAmount = data.orderTransactionDtos.first?.totalAmount
            dto.totalFee = data.orderTransactionDtos.first?.totalFee
            dto.totalAmountIncludingFee = data.orderTransactionDtos.first?.totalAmountIncludingFee ?? 0
            dtos.append(dto)
            
            ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos = dtos
            ThuHoSOMDataManager.shared.orderDetail = data
            self.updatePaymentParam(payments: data.payments)
            
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
        Provider.shared.thuhoSOMAPIService.getOrderDetail(orderId: ThuHoSOMDataManager.shared.order.id, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            ThuHoSOMDataManager.shared.orderDetail = data
            
            let vc = ThuHoSOMOrderSummaryViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    @IBAction func addCardButtonPressed(_ sender: Any) {
        let vc = ThuHoSOMAddPaymentViewController()
        vc.isTransfer = false
        vc.didChangePayment = {
            DispatchQueue.main.async {
                self.loadPaymentDetail()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addTransferButtonPressed(_ sender: Any) {
        let vc = ThuHoSOMAddPaymentViewController()
        vc.isTransfer = true
        vc.didChangePayment = {
            DispatchQueue.main.async {
                self.loadPaymentDetail()
            }
        }
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        guard validInvoices() else { return }
        showAlertTwoButton(title: "Thông báo", with: "Bạn vui lòng kiểm tra lại thông tin trước khi xác nhận", titleButtonOne: "Tiếp tục", titleButtonTwo: "Huỷ", handleButtonOne: {
            self.btnConfirm.isEnabled = false
            Provider.shared.thuhoSOMAPIService.makeOrder(param: ThuHoSOMDataManager.shared.orderParam, success: { [weak self] result in
                guard let self = self, let data = result else { return }
                ThuHoSOMDataManager.shared.order = data
                
                let vc = CountSecondThuHoSOMViewController()
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

extension ThuHoSOMPaymentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tbvCard:
            return ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 2 }.count
        default:
            return ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 3 }.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(ThuHoSOMPaymentTableViewCell.self)
        switch tableView {
        case tbvCard:
            let payment = ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 2 }[indexPath.row]
            cell.setupCell(payment: payment)
        default:
            let payment = ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 3 }[indexPath.row]
            cell.setupCell(payment: payment)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Xoá") { (action, sourceView, completionHandler) in
            var item = ThuHoSOMPaymentDetail(JSON: [:])!
            self.showAlertTwoButton(title: "Thông báo", with: "Bạn có chắc đang muốn huỷ giao dịch này.", titleButtonOne: "Xác nhận", titleButtonTwo: "Huỷ", handleButtonOne: {
                switch tableView {
                case self.tbvCard:
                    item = ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 2 }[indexPath.row]
                default:
                    item = ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 3 }[indexPath.row]
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

class CountSecondThuHoSOMViewController: UIViewController {
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
            Provider.shared.thuhoSOMAPIService.getOrderStatus(orderId: ThuHoSOMDataManager.shared.order.id, groupCode: ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.integratedGroupCode ?? "", success: { result in
                if let data = result {
                    ThuHoSOMDataManager.shared.status = data
                    
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
