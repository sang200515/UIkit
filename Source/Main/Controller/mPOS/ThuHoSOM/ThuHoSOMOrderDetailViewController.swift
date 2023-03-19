//
//  ThuHoSOMOrderDetailViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 01/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ThuHoSOMOrderDetailViewController: UIViewController {

    @IBOutlet weak var lbCustomerName: UILabel!
    @IBOutlet weak var tfCustomerName: UITextField!
    @IBOutlet weak var tfCustomerPhone: UITextField!
    @IBOutlet weak var lbCode: UILabel!
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var lbProduct: UILabel!
    @IBOutlet weak var lbInvoices: UILabel!
    @IBOutlet weak var lbCost: UILabel!
    @IBOutlet weak var lbFee: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var vEditTotal: UIStackView!
    @IBOutlet weak var tfTotal: UITextField!
    
    private var isAllowEdit: Bool = false
    private var cost: Int = 0
    private var fee: Int = 0
    private var total: Int = 0
	var isAIA:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadProviders()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnConfirm.roundCorners(.allCorners, radius: 5)
    }

    private func setupUI() {
        title = "Thu Hộ"
        addBackButton()
        
        btnConfirm.isEnabled = false
        lbCustomerName.text = ThuHoSOMDataManager.shared.selectedCustomer.customerName
        tfCustomerName.text = ThuHoSOMDataManager.shared.selectedCustomer.customerName
        tfCustomerPhone.text = ThuHoSOMDataManager.shared.selectedCustomer.customerPhoneNumber
        lbCode.text = ThuHoSOMDataManager.shared.selectedCustomer.contractNo
        lbCategory.text = ThuHoSOMDataManager.shared.selectedCatagory.name
        lbProduct.text = ThuHoSOMDataManager.shared.selectedProduct.name
        
        isAllowEdit = ThuHoSOMDataManager.shared.selectedCustomer.paymentRule == 5 || ThuHoSOMDataManager.shared.selectedProduct.name == "Grab"
        vEditTotal.isHidden = !isAllowEdit
    }
    
    private func loadData() {
        let checkedInvoices = ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos.first!.invoices.filter { $0.isCheck }
        self.lbInvoices.text = "\(checkedInvoices.count) Kỳ"
        
        cost = 0
        fee = 0
        for invoice in checkedInvoices {
            cost += invoice.paymentAmount
            fee += invoice.paymentFee
        }
        total = cost + fee
        self.lbCost.text = "\(Common.convertCurrencyV2(value: cost)) VNĐ"
        self.lbFee.text = "\(Common.convertCurrencyV2(value: fee)) VNĐ"
        self.lbTotal.text = "\(Common.convertCurrencyV2(value: total)) VNĐ"
        self.tfTotal.text = "\(Common.convertCurrencyV2(value: total))"
    }
    
    private func loadProviders() {
        prepareParam()
        let provider = ThuHoSOMDataManager.shared.providers.items.first(where: { $0.id == ThuHoSOMDataManager.shared.selectedCustomer.providerId }) ?? ThuHoSOMProviderItem(JSON: [:])!
        ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos.first!.providerName = provider.name.isEmpty ? ThuHoSOMDataManager.shared.selectedCustomer.providerName : provider.name
        
        loadDefaultPayment()
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
            
            self.updatePaymentParam(payments: data.payments)
            self.loadData()
            self.btnConfirm.isEnabled = true
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.btnConfirm.isEnabled = false
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    private func validateInputs() -> Bool {
        guard let name = tfCustomerName.text, !name.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập tên người thanh toán", titleButton: "OK")
            return false
        }
        
        guard let phone = tfCustomerPhone.text, !phone.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập SĐT khách hàng", titleButton: "OK")
            return false
        }
        
        if phone.count != 10 {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin SĐT 10 chữ số", titleButton: "OK")
            return false
        }
        
        let checkedInvoices = ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos.first!.invoices.filter { $0.isCheck }
        if checkedInvoices.count < 1 {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn kỳ thanh toán", titleButton: "OK")
            return false
        }
        
        if isAllowEdit {
            guard let totalText = tfTotal.text, !totalText.isEmpty else {
                showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập số tiền thanh toán", titleButton: "OK")
                return false
            }
            
            let range = checkedInvoices.first!.paymentRange.split(separator: "-")
            let min = ThuHoSOMDataManager.shared.selectedProduct.name == "Grab" ? 100000 : Int(String(range.first&)) ?? 0
            let max = ThuHoSOMDataManager.shared.selectedProduct.name == "Grab" ? 10000000 : Int(String(range.last&)) ?? 0
            
            if min < max && (total < min || total > max) {
                showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập số tiền thanh toán trong khoảng \(min) - \(max)", titleButton: "OK")
                return false
            }
        }
        
        return true
    }
    
    private func prepareParam() {
        ThuHoSOMDataManager.shared.orderParam = ThuHoSOMOrderParam(JSON: [:])!
        ThuHoSOMDataManager.shared.orderParam.orderStatus = 1
        ThuHoSOMDataManager.shared.orderParam.customerName = tfCustomerName.text&
        ThuHoSOMDataManager.shared.orderParam.customerPhoneNumber = tfCustomerPhone.text&
        ThuHoSOMDataManager.shared.orderParam.warehouseCode = Cache.user!.ShopCode
        ThuHoSOMDataManager.shared.orderParam.creationBy = Cache.user!.UserName
        ThuHoSOMDataManager.shared.orderParam.creationTime = Date().stringWithFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        ThuHoSOMDataManager.shared.orderParam.referenceSystem = "MPOS"
        
        let dto = ThuHoSOMOrderTransactionDtoParam(JSON: [:])!
        dto.productId = ThuHoSOMDataManager.shared.selectedProduct.id
        dto.providerId = ThuHoSOMDataManager.shared.selectedCustomer.providerId
        dto.providerName = ThuHoSOMDataManager.shared.selectedCustomer.providerName
        dto.productName = ThuHoSOMDataManager.shared.selectedProduct.name
        dto.quantity = 1
        
        dto.totalAmount = ThuHoSOMDataManager.shared.selectedCustomer.totalAmount
        dto.totalFee = ThuHoSOMDataManager.shared.selectedCustomer.totalFee
        dto.totalAmountIncludingFee = (ThuHoSOMDataManager.shared.selectedCustomer.totalAmount ?? 0) + (ThuHoSOMDataManager.shared.selectedCustomer.totalFee ?? 0)
        dto.creationTime = Date().stringWithFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        dto.creationBy = Cache.user!.UserName
        dto.integratedGroupCode = ThuHoSOMDataManager.shared.selectedProduct.configs.first?.integratedGroupCode ?? ""
        dto.integratedProductCode = ThuHoSOMDataManager.shared.selectedProduct.configs.first?.integratedProductCode ?? ""
        dto.isOfflineTransaction = ThuHoSOMDataManager.shared.selectedCustomer.isOfflineTransaction
        dto.referenceCode = ThuHoSOMDataManager.shared.selectedCustomer.referenceCode
        dto.minFee = ThuHoSOMDataManager.shared.selectedCustomer.minFee
        dto.maxFee = ThuHoSOMDataManager.shared.selectedCustomer.maxFee
        dto.percentFee = ThuHoSOMDataManager.shared.selectedCustomer.percentFee
        dto.constantFee = ThuHoSOMDataManager.shared.selectedCustomer.constantFee
        dto.paymentFeeType = ThuHoSOMDataManager.shared.selectedCustomer.paymentFeeType
        dto.paymentRule = ThuHoSOMDataManager.shared.selectedCustomer.paymentRule
        dto.productCustomerCode = ThuHoSOMDataManager.shared.selectedCustomer.contractNo
        dto.productCustomerName = ThuHoSOMDataManager.shared.selectedCustomer.customerName
        dto.productCustomerPhoneNumber = ThuHoSOMDataManager.shared.selectedCustomer.customerPhoneNumber
        dto.productCustomerAddress = ThuHoSOMDataManager.shared.selectedCustomer.address
        dto.orderTransactionDtoDescription = ThuHoSOMDataManager.shared.selectedCustomer.customerDescription
        
        var invoices: [ThuHoSOMOrderInvoiceDetail] = []
        for invoice in ThuHoSOMDataManager.shared.selectedCustomer.invoices {
            let temp = ThuHoSOMOrderInvoiceDetail(JSON: [:])!
            temp.id = invoice.id
            temp.rawPeriod = invoice.period
            temp.paymentAmount = invoice.amount
            temp.paymentFee = invoice.fee
            temp.paymentRange = invoice.paymentRange
            temp.isPrepaid = invoice.isPrepaid
            temp.type = invoice.type
            
            invoices.append(temp)
        }
        dto.invoices = invoices
        
        dto.categoryId = ThuHoSOMDataManager.shared.selectedCatagory.id
        dto.extraProperties.warehouseName = Cache.user!.ShopName
        ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos.append(dto)
        
        let payment = ThuHoSOMPaymentDetailParam(JSON: [:])!
        payment.paymentType = "1"
        ThuHoSOMDataManager.shared.orderParam.payments.append(payment)
    }
    
    private func prepareConfirmParam() {
        ThuHoSOMDataManager.shared.orderParam.customerName = tfCustomerName.text&
        ThuHoSOMDataManager.shared.orderParam.customerPhoneNumber = tfCustomerPhone.text&
        
        if isAllowEdit {
            ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos.first!.sellingPrice = total
        }
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
    
    @IBAction func invoiceButtonPressed(_ sender: Any) {
        let vc = ThuHoSOMInvoiceViewController()
        vc.didChangeInvoice = {
            self.loadData()
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        guard validateInputs() else { return }
		if isAIA {
			var text = (tfTotal.text ?? "")
			text = text.replace(".", withString: "").replace(",", withString: "")
			total = Int(text) ?? 0
			if total > 100000000{
				self.showAlert("Vui lòng nhập số tiền thanh toán trong khoảng 12.000 - 100.000.000")
				return
			}
		}
        prepareConfirmParam()
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
            self.updatePaymentParam(payments: data.payments)
            
            let vc = ThuHoSOMPaymentViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
}

extension ThuHoSOMOrderDetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfCustomerPhone {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            
            return range.location < 10 && allowedCharacters.isSuperset(of: characterSet)
        } else if textField == tfTotal {
            var text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            text = text.replace(".", withString: "").replace(",", withString: "")
            total = Int(text) ?? 0
            textField.text = "\(Common.convertCurrencyV2(value: total))"
            lbTotal.text = "\(Common.convertCurrencyV2(value: total)) VNĐ"
            
            return false
        }
        
        return true
    }
}
