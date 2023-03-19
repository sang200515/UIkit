//
//  FtelPaymentViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 07/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Toaster

class FtelPaymentViewController: UIViewController {

    @IBOutlet weak var lbCash: UILabel!
    @IBOutlet weak var tbCard: UITableView!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var btnFinish: UIButton!
    
    var orderDetail: FtelReciptDetail = FtelReciptDetail(JSON: [:])!
    private var cards: [FtelPayment] = []
    private var removeCardParam: FtelAddCardParam = FtelAddCardParam(JSON: [:])!
    var thuHoFtelVC: ThuHoFtelv2ViewController!
    private var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
    }
    
    private func setupViews() {
        title = "Hình thức thanh toán"
        addBackButton()

        btnFinish.makeCorner(corner: 5)
        btnFinish.layer.borderWidth = 0.5
        btnFinish.layer.borderColor = UIColor.white.cgColor
        
        cards = orderDetail.payments.filter { $0.paymentType != 1 }
        let cash = orderDetail.payments.first(where: { $0.paymentType == 1 })?.paymentValue ?? 0
        lbCash.text = "\(Common.convertCurrencyFloat(value: Float(cash)))"
        
        total = cash
        for card in cards {
            total += card.paymentValue * (100 + card.paymentPercentFee) / 100
        }
        lbTotal.text = "\(Common.convertCurrencyFloat(value: Float(total)))"
    }
    
    func refreshViews() {
        setupViews()
        tbCard.reloadData()
    }

    private func setupTableView() {
        tbCard.registerTableCell(CardTableViewCell.self)

        tbCard.estimatedRowHeight = 100
        tbCard.rowHeight = UITableView.automaticDimension
    }
    
    private func prepareParam(index: Int) {
        removeCardParam.customerId = orderDetail.id
        removeCardParam.creationTime = Date().stringWith(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        removeCardParam.referenceSystem = "MPOS"
        removeCardParam.payments = orderDetail.payments
        removeCardParam.payments.removeAll(where: { $0.paymentCode == cards[index].paymentCode &&
                                                    $0.paymentValue == cards[index].paymentValue &&
                                                    $0.bankTypeDescription == cards[index].bankTypeDescription &&
                                                    $0.cardTypeDescription == cards[index].cardTypeDescription
        })
    }
    
    private func removeCard(index: Int, completion: @escaping (Bool) -> ()) {
        prepareParam(index: index)
        
        Provider.shared.thuHoFtelAPIService.ftelCardAction(param: removeCardParam, isAdd: false, success: { [weak self] data in
            guard let self = self, let detail = data else { return }
            self.orderDetail = detail
            self.refreshViews()
            completion(true)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
            completion(false)
        })
    }

    @IBAction func addCardButtonPressed(_ sender: Any) {
        let vc = FtelAddCardViewController()
        vc.addCardParam.customerId = orderDetail.id
        vc.addCardParam.payments = orderDetail.payments
        vc.ftelPaymentVC = self
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func finishButtonPressed(_ sender: Any) {
        Provider.shared.thuHoFtelAPIService.payFtelOrder(providerId: orderDetail.orderTransactionDtos[0].providerId, orderId: orderDetail.id, orderTransactionId: orderDetail.orderTransactionDtos[0].id, ftelTransactionId: orderDetail.referenceValue, total: total, paymentRequestId: orderDetail.orderTransactionDtos[0].transactionCode, ftelOrderNumber: orderDetail.orderTransactionDtos[0].invoices[0].id, ftelContractNumber: orderDetail.orderTransactionDtos[0].productCustomerCode, success: { [weak self] data in
            guard let self = self, let response = data else { return }
            if response.code == "200" {
                Toast.init(text:"Thanh toán thành công").show()
                self.thuHoFtelVC.loadData()
                self.thuHoFtelVC.loadPaymentDetail(orderId: self.orderDetail.id)
                self.navigationController?.popViewController(animated: true)
            } else {
                self.showPopUp(response.extraProperties.data.statusDescription, "Thông báo", buttonTitle: "OK")
            }
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
        })
    }
}

extension FtelPaymentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(CardTableViewCell.self)
        cell.setupCell(card: cards[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Xoá") { (action, sourceView, completionHandler) in
            let popup = FTELPopupViewController()
            popup.modalPresentationStyle = .overCurrentContext
            self.present(popup, animated: true, completion: nil)
            popup.setupUI(titleButtonOK: "XÁC NHẬN", isHiddenButtonOk: false, title: "Thông báo", message: "Bạn có chắc đang muốn huỷ giao dịch này.", attributedMessage: nil, isAttributedMessage: false)

            popup.actionOK = {
                self.removeCard(index: indexPath.row, completion: { result in
                    DispatchQueue.main.async {
                        completionHandler(result)
                    }
                })
            }

            popup.actionCancel = {
                DispatchQueue.main.async {
                    completionHandler(false)
                }
            }
        }

        delete.backgroundColor = .red
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = true
        return swipeActionConfig
    }
}
