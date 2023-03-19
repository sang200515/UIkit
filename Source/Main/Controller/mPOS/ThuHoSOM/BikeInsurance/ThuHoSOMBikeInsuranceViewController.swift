//
//  ThuHoSOMBikeInsuranceViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 23/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown

class ThuHoSOMBikeInsuranceViewController: UIViewController {

    @IBOutlet weak var tfProvider: UITextField!
    @IBOutlet weak var tfObject: UITextField!
    @IBOutlet weak var tfDuration: UITextField!
    @IBOutlet weak var tfStartDate: UITextField!
    @IBOutlet weak var tfEndDate: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var tfPersonPrice: UITextField!
    @IBOutlet weak var tfTotal: UITextField!
    @IBOutlet weak var imgPersonInsurance: UIImageView!
    @IBOutlet weak var btnPerson: UIButton!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfIntroductor: UITextField!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var tfOwnerName: UITextField!
    @IBOutlet weak var tfOwnerPhone: UITextField!
    @IBOutlet weak var tfOwnerPlate: UITextField!
    @IBOutlet weak var tfSearchPlate: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var tfOwnerAddress: UITextField!
    @IBOutlet weak var tfOwnerIdentityType: UITextField!
    @IBOutlet weak var lbIdentity: UILabel!
    @IBOutlet weak var tfIdentity: UITextField!
    @IBOutlet weak var btnConfirm: UIButton!
    
    private let providerDropDown = DropDown()
    private let objectDropDown = DropDown()
    private let durationDropDown = DropDown()
    private let ownerIdentityTypeDropDown = DropDown()
    private let employeeDropDown = DropDown()
    private let ownerIdentityType = [(name: "Chứng minh nhân dân", id: "0"), (name: "Căn cước công dân", id: "1"), (name: "Hộ chiếu", id: "3")]
    private var startDatePicker = UIDatePicker()
    private var startDateToolbar = UIToolbar()
    private var isPersonInsurance: Bool = true
    private var provider: ThuHoSOMProviderItem = ThuHoSOMProviderItem(JSON: [:])!
    private var providers: [ThuHoSOMBikeInsuranceProvider] = []
    private var objects: [ThuHoSOMBikeInsuranceObj] = []
    private var times: [ThuHoSOMBikeInsuranceTime] = []
    private var selectedProduct: ThuHoSOMBikeInsuranceProductByCode = ThuHoSOMBikeInsuranceProductByCode(JSON: [:])!
    private var voucher: TheNapSOMVoucher = TheNapSOMVoucher(JSON: [:])!
    private var employess: [ThuHoSOMBikeInsuranceEmployee] = []
    private var selectedEmployee: ThuHoSOMBikeInsuranceEmployee = ThuHoSOMBikeInsuranceEmployee(JSON: [:])!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    private func setupUI() {
        title = "Thu Hộ Bảo Hiểm Khác"
        addBackButton()
        
        btnCheck.roundCorners(.allCorners, radius: 5)
        btnConfirm.roundCorners(.allCorners, radius: 5)
        btnSearch.roundCorners(.allCorners, radius: 5)
        tfProvider.withImage(direction: .right, image: UIImage(named: "ArrowDown-1")!)
        tfObject.withImage(direction: .right, image: UIImage(named: "ArrowDown-1")!)
        tfDuration.withImage(direction: .right, image: UIImage(named: "ArrowDown-1")!)
        tfOwnerIdentityType.withImage(direction: .right, image: UIImage(named: "ArrowDown-1")!)
        
        setupDatePicker()
        configureDropDowns()
    }
    
    private func setupDatePicker() {
        tfStartDate.withImage(direction: .right, image: UIImage(named: "calendarIC")!)
        tfEndDate.withImage(direction: .right, image: UIImage(named: "calendarIC")!)

        let startDateDoneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(handleStartDate))

        startDateToolbar.setItems([startDateDoneButton], animated: false)
        startDateToolbar.isUserInteractionEnabled = true
        
        startDateToolbar.barStyle = UIBarStyle.default
        startDateToolbar.isTranslucent = true
        startDateToolbar.sizeToFit()
        
        startDatePicker.datePickerMode = .date
        startDatePicker.date = Date()
        startDatePicker.minimumDate = Date()
        
        if #available(iOS 13.4, *) {
            startDatePicker.preferredDatePickerStyle = .wheels
        }
        
        tfStartDate.inputView = startDatePicker
        tfStartDate.inputAccessoryView = startDateToolbar
        tfStartDate.text = startDatePicker.date.toString(dateFormat: "dd/MM/yyyy")
    }
    
    @objc private func handleStartDate() {
        self.view.endEditing(false)
        tfStartDate.text = startDatePicker.date.toString(dateFormat: "dd/MM/yyyy")
        
        if let duration = tfDuration.text, !duration.isEmpty {
            var endDate = self.startDatePicker.date
            endDate.addDays(n: self.times.first(where: { $0.title == duration })!.effectiveTime)
            self.tfEndDate.text = endDate.toString(dateFormat: "dd/MM/yyyy")
        }
    }
    
    private func configureDropDowns() {
        DropDown.startListeningToKeyboard()
        
        providerDropDown.direction = .bottom
        providerDropDown.bottomOffset = CGPoint(x: 0, y: tfProvider.bounds.height)
        providerDropDown.anchorView = tfProvider
        
        providerDropDown.selectionAction = { [weak self] index, item in
            guard let self = self else { return }
            self.view.endEditing(true)
            self.tfProvider.text = item
            self.getProduct()
        }
        
        objectDropDown.direction = .bottom
        objectDropDown.bottomOffset = CGPoint(x: 0, y: tfObject.bounds.height)
        objectDropDown.anchorView = tfObject
        
        objectDropDown.selectionAction = { [weak self] index, item in
            guard let self = self else { return }
            self.view.endEditing(true)
            self.tfObject.text = item
            self.getProduct()
        }
        
        durationDropDown.direction = .bottom
        durationDropDown.bottomOffset = CGPoint(x: 0, y: tfDuration.bounds.height)
        durationDropDown.anchorView = tfDuration
        
        durationDropDown.selectionAction = { [weak self] index, item in
            guard let self = self else { return }
            self.view.endEditing(true)
            self.tfDuration.text = item
            var endDate = self.startDatePicker.date
            endDate.addDays(n: self.times[index].effectiveTime)
            self.tfEndDate.text = endDate.toString(dateFormat: "dd/MM/yyyy")
            self.getProduct()
        }
        
        tfOwnerIdentityType.text = ownerIdentityType.first!.name
        ownerIdentityTypeDropDown.dataSource = ownerIdentityType.map { $0.name }
        ownerIdentityTypeDropDown.direction = .bottom
        ownerIdentityTypeDropDown.bottomOffset = CGPoint(x: 0, y: tfOwnerIdentityType.bounds.height)
        ownerIdentityTypeDropDown.anchorView = tfOwnerIdentityType
        
        ownerIdentityTypeDropDown.selectionAction = { [weak self] index, item in
            guard let self = self else { return }
            self.view.endEditing(true)
            self.tfOwnerIdentityType.text = item
            self.lbIdentity.text = item
            self.tfIdentity.text = ""
        }
        
        employeeDropDown.direction = .bottom
        employeeDropDown.bottomOffset = CGPoint(x: 0, y: tfIntroductor.bounds.height)
        employeeDropDown.anchorView = tfIntroductor
        
        employeeDropDown.selectionAction = { [weak self] index, item in
            guard let self = self else { return }
            self.view.endEditing(true)
            self.selectedEmployee = self.employess[index]
            self.tfIntroductor.text = item
        }
    }
    
    private func loadData() {
        provider = ThuHoSOMDataManager.shared.providers.items.first(where: { $0.name == "Vinasure-v2" }) ?? ThuHoSOMProviderItem(JSON: [:])!
        
        ProgressView.shared.show()
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Provider.shared.thuhoSOMAPIService.getBikeInsuranceProvider(providerId: self.provider.id, customerId: "bao-hiem-xe", groupCode: "", productCode: "", pin: "", success: { [weak self] result in
            guard let self = self, let data = result else { return }
            self.providers = data.additionalDataProvider.data.filter { $0.productID == "1007" }
            dispatchGroup.leave()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        Provider.shared.thuhoSOMAPIService.getBikeInsuranceProvider(providerId: self.provider.id, customerId: "bao-hiem-xe", groupCode: "", productCode: "1007", pin: "", success: { [weak self] result in
            guard let self = self, let data = result else { return }
            self.objects = data.additionalDataProduct.data.insuranceObj
            self.times = data.additionalDataProduct.data.product.time
            dispatchGroup.leave()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        Provider.shared.thuhoSOMAPIService.getEmployees(success: { [weak self] result in
            guard let self = self  else { return }
            self.employess = result
            dispatchGroup.leave()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: .main) {
            ProgressView.shared.hide()
            self.tfProvider.text = self.providers.first?.productName
            self.providerDropDown.dataSource = self.providers.map { $0.productName }
            self.objectDropDown.dataSource = self.objects.map { $0.insuranceObjName }
            self.durationDropDown.dataSource = self.times.map { $0.title }
            self.employeeDropDown.dataSource = self.employess.map { $0.employeeCode + "-" + $0.employeeName }
        }
    }
    
    private func getProduct() {
        guard let provider = tfProvider.text, !provider.isEmpty else { return }
        guard let object = tfObject.text, !object.isEmpty else { return }
        guard let duration = tfDuration.text, !duration.isEmpty else { return }
        
        let selectedProvider = providers.first(where: { $0.productName == provider })!
        let selectedObject = objects.first(where: { $0.insuranceObjName == object })!
        let selectedDuration = times.first(where: { $0.title == duration })!
        let code = selectedProvider.productID + "_" + "\(selectedObject.insuranceObjID)" + "_" + selectedDuration.productItemID
        Provider.shared.thuhoSOMAPIService.getBikeInsuranceProduct(code: code, success:  { [weak self] result in
            guard let self = self, let data = result else { return }
//            let check = UIImage(named: "check-1")!
//            self.isPersonInsurance = true
//            self.imgPersonInsurance.image = check
            
            self.selectedProduct = data
            self.loadPrice()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    private func loadPrice() {
        guard let object = tfObject.text, !object.isEmpty else { return }
        guard let duration = tfDuration.text, !duration.isEmpty else { return }
        guard let product = selectedProduct.items.first, !product.id.isEmpty else { return }
        
        let selectedObject = objects.first(where: { $0.insuranceObjName == object })!
        let selectedDuration = times.first(where: { $0.title == duration })!
        let personFee = selectedObject.seatFee * selectedDuration.rate2Price
        
        tfPrice.text = "\(Common.convertCurrencyV2(value: product.price - personFee))"
        tfPersonPrice.text = "\(Common.convertCurrencyV2(value: isPersonInsurance ? personFee : 0))"
        tfTotal.text = "\(Common.convertCurrencyV2(value: isPersonInsurance ? product.price : product.price - personFee))"
    }
    
    private func validateInputs() -> Bool {
        guard let object = tfObject.text, !object.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn dung tích", titleButton: "OK")
            return false
        }
        
        guard let duration = tfDuration.text, !duration.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn thời hạn", titleButton: "OK")
            return false
        }
        
        guard let name = tfName.text, !name.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập tên khách hàng thanh toán", titleButton: "OK")
            return false
        }
        
        guard let phone = tfPhone.text, !phone.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập SĐT khách hàng thanh toán", titleButton: "OK")
            return false
        }
        if phone.count != 10 {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập SĐT khách hàng thanh toán đủ 10 chữ số", titleButton: "OK")
            return false
        }
        
        guard let plate = tfOwnerPlate.text, !plate.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập biển số xe của chủ xe", titleButton: "OK")
            return false
        }
        
        guard let ownerName = tfOwnerName.text, !ownerName.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập tên của chủ xe", titleButton: "OK")
            return false
        }
        
        guard let ownerPhone = tfOwnerPhone.text, !plate.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập SĐT của chủ xe", titleButton: "OK")
            return false
        }
        if ownerPhone.count != 10 {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập SĐT của chủ xe đủ 10 chữ số", titleButton: "OK")
            return false
        }
        
        guard let address = tfOwnerAddress.text, !address.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập địa chỉ nhận CN của chủ xe", titleButton: "OK")
            return false
        }
        
        guard let identity = tfIdentity.text, !identity.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập \(ownerIdentityType.first(where: { $0.name == tfOwnerIdentityType.text& })!.name) của chủ xe", titleButton: "OK")
            return false
        }
        if ownerIdentityType.first(where: { $0.name == tfOwnerIdentityType.text& })!.id == "0" {
            if identity.count != 9 {
                showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập Chứng minh nhân dân của chủ xe đủ 9 chữ số", titleButton: "OK")
                return false
            }
        } else if ownerIdentityType.first(where: { $0.name == tfOwnerIdentityType.text& })!.id == "1" {
            if identity.count != 12 {
                showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập Căn cước công dân của chủ xe đủ 12 chữ số", titleButton: "OK")
                return false
            }
        } else {
            if identity.count != 8 {
                showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập Hộ chiếu của chủ xe đủ 8 ký tự", titleButton: "OK")
                return false
            }
        }
        
        return true
    }
    
    private func prepareParam() {
        guard let object = tfObject.text, !object.isEmpty else { return }
        guard let duration = tfDuration.text, !duration.isEmpty else { return }
        guard let product = selectedProduct.items.first, !product.id.isEmpty else { return }
        
        let selectedObject = objects.first(where: { $0.insuranceObjName == object })!
        let selectedDuration = times.first(where: { $0.title == duration })!
        let personFee = selectedObject.seatFee * selectedDuration.rate2Price
        
        ThuHoSOMDataManager.shared.orderParam = ThuHoSOMOrderParam(JSON: [:])!
        ThuHoSOMDataManager.shared.orderParam.orderStatus = 1
        ThuHoSOMDataManager.shared.orderParam.customerName = tfName.text&
        ThuHoSOMDataManager.shared.orderParam.customerPhoneNumber = tfPhone.text&
        ThuHoSOMDataManager.shared.orderParam.warehouseCode = Cache.user!.ShopCode
        ThuHoSOMDataManager.shared.orderParam.creationBy = Cache.user!.UserName
        ThuHoSOMDataManager.shared.orderParam.creationTime = Date().stringWithFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        ThuHoSOMDataManager.shared.orderParam.referenceSystem = "MPOS"

        let dto = ThuHoSOMOrderTransactionDtoParam(JSON: [:])!
        dto.productId = product.id
        dto.providerId = product.defaultProviderID
        dto.providerName = provider.name
        dto.productName = product.name
        dto.price = product.price - personFee
        dto.quantity = 1
        dto.totalAmount = isPersonInsurance ? product.price : product.price - personFee
        dto.totalAmountIncludingFee = isPersonInsurance ? product.price : product.price - personFee
        dto.creationTime = Date().stringWithFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        dto.creationBy = Cache.user!.UserName
        dto.integratedGroupCode = product.configs.first?.integratedGroupCode ?? ""
        dto.integratedProductCode = product.configs.first?.integratedProductCode ?? ""
        dto.constantFee = isPersonInsurance ? personFee : 0
        dto.productCustomerCode = tfOwnerPlate.text&
        dto.productCustomerName = tfOwnerName.text&
        dto.productCustomerPhoneNumber = tfOwnerPhone.text&
        dto.productCustomerAddress = tfOwnerAddress.text&

        let extraProperties = ThuHoSOMExtraPropertiesParam(JSON: [:])!
        extraProperties.warehouseName = Cache.user!.ShopName
        extraProperties.customerIdentityType = ownerIdentityType.first(where: { $0.name == tfOwnerIdentityType.text& })!.id
        extraProperties.customerIdentityNumber = tfIdentity.text&
        extraProperties.orderProductID = "1007"
        extraProperties.detailProductItemID = selectedDuration.productItemID
        extraProperties.detailTotalAmount = isPersonInsurance ? product.price : product.price - personFee
        extraProperties.vehicleInsuranceObjID = selectedObject.insuranceObjID
        extraProperties.vehiclePrice = selectedObject.price
        extraProperties.vehicleSeatFee = isPersonInsurance ? selectedObject.seatFee : 0
        extraProperties.vehicleSuminsure = isPersonInsurance ? selectedObject.suminsure : 0
        extraProperties.effectiveDate = startDatePicker.date.stringWithFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        let endDate = tfEndDate.text&.toDate()
        extraProperties.expiredDate = endDate.stringWithFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        extraProperties.introducer = tfIntroductor.text&
        dto.extraProperties = extraProperties
        
        var invoices: [ThuHoSOMOrderInvoiceDetail] = []
        let invoice = ThuHoSOMOrderInvoiceDetail(JSON: [:])!
        invoice.id = product.name
        invoice.rawPeriod = tfStartDate.text& + "-" + tfEndDate.text&
        invoice.paymentAmount = product.price - personFee
        invoice.paymentFee = isPersonInsurance ? personFee : 0
        invoice.isPrepaid = true
        invoice.isCheck = true
        invoices.append(invoice)
        dto.invoices = invoices
        
        ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos.append(dto)
        
        var payments: [ThuHoSOMPaymentDetailParam] = []
        var paymentValue = isPersonInsurance ? product.price : product.price - personFee
        paymentValue = paymentValue - voucher.voucherAmount
        let payment = ThuHoSOMPaymentDetailParam(JSON: [:])!
        payment.paymentType = "1"
        payment.paymentValue = paymentValue
        payments.append(payment)
        
        if !voucher.voucherCode.isEmpty {
            let paymentVoucher = ThuHoSOMPaymentDetailParam(JSON: [:])!
            paymentVoucher.paymentType = "4"
            paymentVoucher.paymentValue = voucher.voucherAmount
            paymentVoucher.paymentCode = voucher.voucherCode
            paymentVoucher.paymentCodeDescription = voucher.voucherName
            paymentVoucher.paymentAccountNumber = voucher.voucherAccount
            payments.append(paymentVoucher)
        }
        ThuHoSOMDataManager.shared.orderParam.payments = payments
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
    
    @IBAction func personInsuranceButtonPressed(_ sender: Any) {
        let check = UIImage(named: "check-1")!
        let uncheck = UIImage(named: "check-2")!
        isPersonInsurance = !isPersonInsurance
        
        imgPersonInsurance.image = isPersonInsurance ? check : uncheck
        loadPrice()
    }
    
    @IBAction func checkButtonPressed(_ sender: Any) {
        guard let object = tfObject.text, !object.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn dung tích", titleButton: "OK")
            return
        }
        guard let duration = tfDuration.text, !duration.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn thời hạn", titleButton: "OK")
            return
        }
        guard let product = selectedProduct.items.first, !product.id.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn thông tin sản phẩm", titleButton: "OK")
            return
        }
        guard let name = tfName.text, !name.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập tên khách hàng thanh toán", titleButton: "OK")
            return
        }
        guard let phone = tfPhone.text, !phone.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập SĐT khách hàng thanh toán", titleButton: "OK")
            return
        }
        if phone.count != 10 {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập SĐT khách hàng thanh toán đủ 10 chữ số", titleButton: "OK")
            return
        }
        
        let selectedObject = objects.first(where: { $0.insuranceObjName == object })!
        let selectedDuration = times.first(where: { $0.title == duration })!
        let personFee = selectedObject.seatFee * selectedDuration.rate2Price
        
        Provider.shared.thuhoSOMAPIService.getBikeInsuranceVoucher(productId: product.id, providerId: product.defaultProviderID, price: isPersonInsurance ? product.price : product.price - personFee, phone: phone, itemCode: product.legacyID, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            self.tfProvider.isEnabled = false
            self.tfObject.isEnabled = false
            self.tfDuration.isEnabled = false
            self.tfStartDate.isEnabled = false
            self.btnPerson.isEnabled = false
            self.tfName.isEnabled = false
            self.tfPhone.isEnabled = false
            self.btnCheck.isEnabled = false
            self.voucher = data
            
            self.showAlertOneButton(title: "Thông báo", with: "Khách hàng đủ điều kiện giảm giá 50%", titleButton: "OK")
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        guard validateInputs() else { return }
        prepareParam()
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
            
            let vc = ThuHoSOMBikeInsurancePaymentViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        guard let plate = tfSearchPlate.text, !plate.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập biển số xe", titleButton: "OK")
            return
        }
        
        Provider.shared.thuhoSOMAPIService.getBikeInsuranceProvider(providerId: self.provider.id, customerId: plate, groupCode: "", productCode: "", pin: "", success: { [weak self] result in
            guard let self = self, let data = result else { return }
            let message = "Họ tên: \(data.customerName)" + "\n" +
                          "Biển số xe: \(data.contractNo.trim())" + "\n" +
                          "Ngày bắt đầu: \(data.additionalDataProduct.data.startDate&.toNewStrDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss", newFormat: "dd/MM/yyyy"))" + "\n" +
                          "Ngày kết thúc: \(data.additionalDataProduct.data.endDate&.toNewStrDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss", newFormat: "dd/MM/yyyy"))"
            self.showAlertOneButton(title: "Thông tin bảo hiểm", with: message, titleButton: "OK")
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
}

extension ThuHoSOMBikeInsuranceViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfProvider {
            providerDropDown.show()
            return false
        } else if textField == tfObject {
            objectDropDown.show()
            return false
        } else if textField == tfDuration {
            durationDropDown.show()
            return false
        } else if textField == tfOwnerIdentityType {
            ownerIdentityTypeDropDown.show()
            return false
        } else if textField == tfIdentity {
            if ownerIdentityType.first(where: { $0.name == tfOwnerIdentityType.text& })!.id == "3" {
                tfIdentity.keyboardType = .default
            } else {
                tfIdentity.keyboardType = .numberPad
            }
            
            return true
        } else if textField == tfIntroductor {
            employeeDropDown.show()
            return false
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfPhone || textField == tfOwnerPhone {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            
            return range.location < 10 && allowedCharacters.isSuperset(of: characterSet)
        } else if textField == tfIdentity {
            let numberCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            
            if ownerIdentityType.first(where: { $0.name == tfOwnerIdentityType.text& })!.id == "0" {
                return range.location < 9 && numberCharacters.isSuperset(of: characterSet)
            } else if ownerIdentityType.first(where: { $0.name == tfOwnerIdentityType.text& })!.id == "1" {
                return range.location < 12 && numberCharacters.isSuperset(of: characterSet)
            } else {
                let letterCharacters = CharacterSet.letters
                return (range.location < 1 && letterCharacters.isSuperset(of: characterSet)) || (range.location >= 1 && range.location < 8 && numberCharacters.isSuperset(of: characterSet))
            }
        } else if textField == tfOwnerPlate || textField == tfSearchPlate {
            let numberCharacters = CharacterSet.decimalDigits
            let letterCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            
            if numberCharacters.isSuperset(of: characterSet) || letterCharacters.isSuperset(of: characterSet) {
                if range.location < 11 {
                    textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
                }
            }
            
            return false
        }
        
        return true
    }
}
