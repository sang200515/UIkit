//
//  UnconfimredFtelViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 06/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class UnconfimredFtelViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tfFromDate: UITextField!
    @IBOutlet weak var tfToDate: UITextField!
    
    var parentNavigationController: ThuHoFtelv2ViewController!
    var searchText: String = "" {
        didSet {
            filterListData()
        }
    }
    var list: [FtelReceipt] = [] {
        didSet {
            filterListData()
        }
    }
    var filtedList: [FtelReceipt] = [] {
        didSet {
            guard let tableView = tableView else { return }
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUpTableView()
    }
    
    private func setupViews() {
        let calendarImageViewWrapper1 = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let calendarImageView1 = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        let calendar1 = UIImage(named: "calendarIC")
        calendarImageView1.image = calendar1
        calendarImageViewWrapper1.addSubview(calendarImageView1)
        
        tfFromDate.layer.cornerRadius = 5
        tfFromDate.rightViewMode = .always
        tfFromDate.rightView = calendarImageViewWrapper1
        
        let calendarImageViewWrapper2 = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let calendarImageView2 = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        let calendar2 = UIImage(named: "calendarIC")
        calendarImageView2.image = calendar2
        calendarImageViewWrapper2.addSubview(calendarImageView2)
        
        tfToDate.layer.cornerRadius = 5
        tfToDate.rightViewMode = .always
        tfToDate.rightView = calendarImageViewWrapper2
        
        tfFromDate.inputView = parentNavigationController.fromDatePicker
        tfFromDate.inputAccessoryView = parentNavigationController.fromDateToolbar
        tfFromDate.text = parentNavigationController.fromDatePicker.date.toString(dateFormat: "dd/MM/yyyy")
        tfToDate.inputView = parentNavigationController.toDatePicker
        tfToDate.inputAccessoryView = parentNavigationController.toDateToolbar
        tfToDate.text = parentNavigationController.toDatePicker.date.toString(dateFormat: "dd/MM/yyyy")
    }

    private func setUpTableView() {
        tableView.registerTableCell(ReceiptTableViewCell.self)

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func filterListData() {
        filtedList = searchText.isEmpty ? list : list.filter { $0.customerPhoneNumber.contains(searchText) || $0.billNo.contains(searchText) }
    }
}

extension UnconfimredFtelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtedList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(ReceiptTableViewCell.self)

        let item = filtedList[indexPath.row]
        cell.setUpCell(item: item)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Huỷ") { (action, sourceView, completionHandler) in
            let popup = FTELPopupViewController()
            popup.modalPresentationStyle = .overCurrentContext
            self.parentNavigationController?.present(popup, animated: true, completion: nil)
            popup.setupUI(titleButtonOK: "XÁC NHẬN", isHiddenButtonOk: false, title: "Thông báo", message: "Bạn có chắc đang muốn huỷ giao dịch này.", attributedMessage: nil, isAttributedMessage: false)

            popup.actionOK = {
                print("OK")
                completionHandler(true)
            }

            popup.actionCancel = {
                print("Cancel")
                completionHandler(false)
            }
        }

        delete.backgroundColor = .red
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = true
        return swipeActionConfig
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = filtedList[indexPath.row]
        Provider.shared.thuHoFtelAPIService.getFtelOrderDetail(orderId: item.orderId, success: { [weak self] data in
            guard let self = self, let detail = data else { return }
            let vc = FtelPaymentViewController()
            vc.thuHoFtelVC = self.parentNavigationController
            vc.orderDetail = detail
            self.parentNavigationController.navigationController?.pushViewController(vc, animated: true)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
        })
    }
}
