//
//  ThuHoSOMInvoiceViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 01/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ThuHoSOMInvoiceViewController: UIViewController {

    @IBOutlet weak var tbvInvoice: UITableView!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnSelectAll: UIButton!
    
    var selectedIndex: Int = 0
    var didChangeInvoice: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        title = "Kỳ Thanh Toán"
        addBackButton()
        
        btnConfirm.roundCorners(.allCorners, radius: 5)
        btnSelectAll.roundCorners(.allCorners, radius: 5)
    }
    
    private func loadDefaultPayment() {
        Provider.shared.thuhoSOMAPIService.getDefaultPayment(param: ThuHoSOMDataManager.shared.orderParam, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            var dtos: [ThuHoSOMOrderTransactionDtoParam] = []
            let dto = ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos.first!
            dto.totalAmount = data.orderTransactionDtos.first?.totalAmount
            dto.totalFee = data.orderTransactionDtos.first?.totalFee
            dto.totalAmountIncludingFee = data.orderTransactionDtos.first?.totalAmountIncludingFee ?? 0
            dto.invoices = data.orderTransactionDtos.first!.invoices
            dtos.append(dto)
            
            ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos = dtos
            ThuHoSOMDataManager.shared.orderDetail = data
            
            DispatchQueue.main.async {
                self.tbvInvoice.reloadData()
                self.didChangeInvoice?()
            }
        }, failure: { [weak self] error in
            guard let self = self else { return }
            ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos.first!.invoices[self.selectedIndex].isCheck = !ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos.first!.invoices[self.selectedIndex].isCheck
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    private func setupTableView() {
        tbvInvoice.registerTableCell(ThuHoSOMInvoiceTableViewCell.self)
        tbvInvoice.estimatedRowHeight = 100
        tbvInvoice.rowHeight = UITableView.automaticDimension
    }
}

extension ThuHoSOMInvoiceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos.first!.invoices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(ThuHoSOMInvoiceTableViewCell.self)
        let invoice = ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos.first!.invoices[indexPath.row]
        cell.setupCell(invoice: invoice, index: indexPath.row + 1)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !(ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos.first!.invoices[indexPath.row].isDisable ?? true) {
            selectedIndex = indexPath.row
            ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos.first!.invoices[indexPath.row].isCheck = !ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos.first!.invoices[indexPath.row].isCheck
            loadDefaultPayment()
        }
    }
}
