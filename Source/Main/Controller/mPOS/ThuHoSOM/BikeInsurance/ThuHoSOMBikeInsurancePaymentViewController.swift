//
//  ThuHoSOMBikeInsurancePaymentViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 24/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Presentr

class ThuHoSOMBikeInsurancePaymentViewController: UIViewController {

    @IBOutlet weak var lbCash: UILabel!
    @IBOutlet weak var tbvCard: UITableView!
    @IBOutlet weak var cstCard: NSLayoutConstraint!
    @IBOutlet weak var tbvVoucher: UITableView!
    @IBOutlet weak var cstVoucher: NSLayoutConstraint!
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
    }
    
    private func loadPaymentDetail() {
        lbTotal.text = "\(Common.convertCurrencyV2(value: ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.totalAmountIncludingFee ?? 0)) VNĐ"
        
        let cash = ThuHoSOMDataManager.shared.orderDetail.payments.first(where: { $0.paymentType == 1 })
        lbCash.text = "\(Common.convertCurrencyV2(value: cash?.paymentValue ?? 0)) VNĐ"
        
        let card = ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 2 }
        cstCard.constant = CGFloat(card.count * 165)
        tbvCard.reloadData()
        
        let voucher = ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 4 }
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
                                                        $0.paymentCode == item.paymentCode &&
                                                        $0.paymentAccountNumber == item.paymentAccountNumber &&
                                                        $0.paymentCodeDescription == item.paymentCodeDescription })
        
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
            param.paymentAccountNumber = payment.paymentAccountNumber
            param.paymentCodeDescription = payment.paymentCodeDescription
//            param.isChargeOnCash = payment.isChargeOnCash
            
            paymentParams.append(param)
        }
        
        ThuHoSOMDataManager.shared.orderParam.payments = paymentParams
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
    
    @IBAction func addVoucherButtonPressed(_ sender: Any) {
        let vc = ThuHoSOMBikeInsuranceAddVoucherViewController()
        vc.didChangePayment = {
            DispatchQueue.main.async {
                self.loadPaymentDetail()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
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

extension ThuHoSOMBikeInsurancePaymentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tbvCard:
            return ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 2 }.count
        default:
            return ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 4 }.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case tbvCard:
            let cell = tableView.dequeueTableCell(ThuHoSOMPaymentTableViewCell.self)
            let payment = ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 2 }[indexPath.row]
            cell.setupCell(payment: payment)
            
            return cell
        default:
            let cell = tableView.dequeueTableCell(TheNapSOMVoucherTableViewCell.self)
            let payment = ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 4 }[indexPath.row]
            cell.setupCell(payment: payment)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == tbvCard {
            let delete = UIContextualAction(style: .destructive, title: "Xoá") { (action, sourceView, completionHandler) in
                var item = ThuHoSOMPaymentDetail(JSON: [:])!
                self.showAlertTwoButton(title: "Thông báo", with: "Bạn có chắc đang muốn huỷ giao dịch này.", titleButtonOne: "Xác nhận", titleButtonTwo: "Huỷ", handleButtonOne: {
                    item = ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 2 }[indexPath.row]
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
        
        return nil
    }
}
