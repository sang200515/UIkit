//
//  BanTienSOMViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

enum BanTienSOMType {
    case Transfer
    case Telecom
    case Data
}

class BanTienSOMViewController: UIViewController {

    @IBOutlet weak var vTransfer: UIView!
    @IBOutlet weak var lbTransfer: UILabel!
    @IBOutlet weak var vTelecom: UIView!
    @IBOutlet weak var lbTelecom: UILabel!
    @IBOutlet weak var vData: UIView!
    @IBOutlet weak var lbData: UILabel!
    
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var vPrice: UIView!
    @IBOutlet weak var lbProvider: UILabel!
    @IBOutlet weak var clvPrice: UICollectionView!
    @IBOutlet weak var cstPrice: NSLayoutConstraint!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var btnConfirm: UIButton!
    
    @IBOutlet weak var vProvider: UIView!
    @IBOutlet weak var clvProvider: UICollectionView!
    @IBOutlet weak var cstProvider: NSLayoutConstraint!
    @IBOutlet weak var vTelecomPrice: UIView!
    @IBOutlet weak var clvTelecomPrice: UICollectionView!
    @IBOutlet weak var cstTelecomPrice: NSLayoutConstraint!
    @IBOutlet weak var lbTelecomDescription: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    
    private var type: BanTienSOMType = .Transfer
    private var transfers: [TheNapSOMItem] = []
    private var telecoms: [TheNapSOMItem] = []
    private var datas: [TheNapSOMItem] = []
    
    private var selectedTransferItem: TheNapSOMItem = TheNapSOMItem(JSON: [:])!
    private var selectedTransferProduct: TheNapSOMProduct = TheNapSOMProduct(JSON: [:])!
    private var selectedDataItem: TheNapSOMItem = TheNapSOMItem(JSON: [:])!
    private var selectedDataProduct: TheNapSOMProduct = TheNapSOMProduct(JSON: [:])!
    private var selectedTelecomItem: TheNapSOMItem = TheNapSOMItem(JSON: [:])!
    private var selectedTelecomProducts: [TheNapSOMProduct] = []
    private var selectedTelecomProduct: TheNapSOMProduct = TheNapSOMProduct(JSON: [:])!
    private var validViettel: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TheCaoSOMDataManager.shared.resetParam()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.cstPrice.constant = self.clvPrice.contentSize.height
            self.cstProvider.constant = self.clvProvider.contentSize.height
            self.cstTelecomPrice.constant = self.clvTelecomPrice.contentSize.height
        }
    }
    
    private func setupUI() {
        title = "Bắn Tiền"
        addBackButton()
        
        btnConfirm.roundCorners(.allCorners, radius: 5)
        switchType()
        updatePrice()
    }
    
    private func setupCollectionView() {
        clvPrice.registerCollectionCell(TheNapSOMPriceCollectionViewCell.self)
        clvProvider.registerCollectionCell(TheNapSOMProductCollectionViewCell.self)
        clvTelecomPrice.registerCollectionCell(TheNapSOMPriceCollectionViewCell.self)
    }
    
    private func loadData() {
        switch type {
        case .Transfer:
            guard transfers.isEmpty else { return }
            Provider.shared.thecaoSOMAPIService.getCategories(parentID: "d83158d9-fd96-4090-9f4c-fe98dd59cc94", success: { [weak self] result in
                guard let self = self, let data = result else { return }
                self.transfers = data.items
                for transfer in self.transfers {
                    transfer.products = self.filterProducts(products: transfer.products)
                }
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        case .Data:
            guard datas.isEmpty else { return }
            Provider.shared.thecaoSOMAPIService.getCategories(parentID: "120c2cc2-72ae-4683-b7d7-f76e7a610f39", success: { [weak self] result in
                guard let self = self, let data = result else { return }
                self.datas = data.items
                for data in self.datas {
                    data.products = self.filterProducts(products: data.products)
                }
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        case .Telecom:
            guard telecoms.isEmpty else { return }
            Provider.shared.thecaoSOMAPIService.getCategories(parentID: "9de91c80-4b2a-43da-bf33-cf054ef36a2d", success: { [weak self] result in
                guard let self = self, let data = result else { return }
                self.telecoms = data.items
                for telecom in self.telecoms {
                    telecom.products = self.filterProducts(products: telecom.products)
                }
                
                self.selectedTelecomItem = self.telecoms.first ?? TheNapSOMItem(JSON: [:])!
                
                DispatchQueue.main.async {
                    self.updatePrice()
                    self.clvProvider.reloadData()
                    self.viewDidLayoutSubviews()
                }
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        }
        
    }
    
    private func updatePrice() {
        switch type {
        case .Transfer:
            lbProvider.text = selectedTransferItem.name.isEmpty ? "CHỌN MỆNH GIÁ" : "CHỌN MỆNH GIÁ - \(selectedTransferItem.name.uppercased())"
            lbPrice.text = "\(Common.convertCurrencyV2(value:selectedTransferProduct.details.sellingPrice)) VNĐ"
        case .Telecom:
            lbTelecomDescription.text = selectedTelecomProduct.description
            
            lbPrice.text = "\(Common.convertCurrencyV2(value: selectedTelecomProduct.details.sellingPrice)) VNĐ"
        case .Data:
            lbProvider.text = selectedDataItem.name.isEmpty ? "CHỌN MỆNH GIÁ" : "CHỌN MỆNH GIÁ - \(selectedDataItem.name.uppercased())"
            lbPrice.text = "\(Common.convertCurrencyV2(value:selectedDataProduct.details.sellingPrice)) VNĐ"
        }
    }
    
    private func switchType() {
        switch type {
        case .Transfer:
            searchButton.isHidden = true
            vPrice.isHidden = false
            vProvider.isHidden = true
            vTelecomPrice.isHidden = true
            
            tfPhone.text = ""
            selectedTelecomProduct = TheNapSOMProduct(JSON: [:])!
            selectedTelecomProducts = []
            selectedDataProduct = TheNapSOMProduct(JSON: [:])!
            selectedDataItem = TheNapSOMItem(JSON: [:])!
            
            DispatchQueue.main.async {
                self.updatePrice()
                self.clvTelecomPrice.reloadData()
                self.viewDidLayoutSubviews()
            }
        case .Data:
            searchButton.isHidden = true
            vPrice.isHidden = false
            vProvider.isHidden = true
            vTelecomPrice.isHidden = true
            
            tfPhone.text = ""
            selectedTelecomProduct = TheNapSOMProduct(JSON: [:])!
            selectedTelecomProducts = []
            selectedTransferItem = TheNapSOMItem(JSON: [:])!
            selectedTransferProduct = TheNapSOMProduct(JSON: [:])!
            
            DispatchQueue.main.async {
                self.updatePrice()
                self.clvTelecomPrice.reloadData()
                self.viewDidLayoutSubviews()
            }
            
        case .Telecom:
            searchButton.isHidden = false
            vPrice.isHidden = true
            vProvider.isHidden = false
            vTelecomPrice.isHidden = false
            
            tfPhone.text = ""
            selectedTransferItem = TheNapSOMItem(JSON: [:])!
            selectedTransferProduct = TheNapSOMProduct(JSON: [:])!
            selectedDataProduct = TheNapSOMProduct(JSON: [:])!
            selectedDataItem = TheNapSOMItem(JSON: [:])!
            
            DispatchQueue.main.async {
                self.updatePrice()
                self.clvPrice.reloadData()
                self.viewDidLayoutSubviews()
            }
        }
        
        validViettel = true
        loadData()
    }
    
    private func filterProducts(products: [TheNapSOMProduct]) -> [TheNapSOMProduct] {
        var temProducts = products
        let promotionProducts = temProducts.filter { $0.details.checkInventory }
        for promotion in promotionProducts {
            temProducts.removeAll(where: { $0.price == promotion.price })
            temProducts.append(promotion)
        }
        
        return temProducts.sorted(by: { $0.price < $1.price })
    }
    
    private func prepareParam() {
        let param: TheNapSOMOrderDetail = TheNapSOMOrderDetail(JSON: [:])!
        param.orderStatus = 1
        param.warehouseCode = Cache.user!.ShopCode
        param.warehouseAddress = Cache.user!.Address
        param.creationBy = Cache.user!.UserName
        param.creationTime = Date().stringWithFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        param.referenceSystem = "MPOS"
        
        var dtos: [TheNapSOMOrderTransactionDto] = []
        let dto: TheNapSOMOrderTransactionDto = TheNapSOMOrderTransactionDto(JSON: [:])!
        let selectedItem = type == .Transfer ? selectedTransferItem : (type == .Data ? selectedDataItem : selectedTelecomItem)
        let selectedProduct = type == .Transfer ? selectedTransferProduct : (type == .Data ? selectedDataProduct : selectedTelecomProduct)
        
        var customerID = tfPhone.text!
        if (type == .Transfer || type == .Data) && selectedTransferItem.name == "Viettel" {
            if let index = customerID.firstIndex(of: "0") {
                customerID.replaceSubrange(index...index, with: ["8", "4"])
            }
        }
        
        dto.productCustomerCode = customerID
        dto.productCustomerPhoneNumber = customerID
        dto.productID = selectedProduct.id
        dto.providerID = selectedProduct.details.providerID
        dto.providerName = ""
        dto.productName = selectedProduct.name
        dto.price = selectedProduct.details.price
        dto.sellingPrice = selectedProduct.details.sellingPrice
        dto.quantity = 1
        dto.totalFee = selectedProduct.details.fixedFee
        dto.totalAmount = selectedProduct.details.sellingPrice
        dto.totalAmountIncludingFee = dto.totalFee + dto.totalAmount
        dto.creationTime = Date().stringWithFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        dto.creationBy = Cache.user!.UserName
        dto.integratedGroupCode = selectedProduct.configs.first?.integratedGroupCode ?? ""
        dto.integratedProductCode = selectedProduct.configs.first?.integratedProductCode ?? ""
        dto.referenceCode = selectedProduct.legacyID
        dto.percentFee = selectedProduct.details.percentFee
        dto.categoryID = selectedItem.id
        dto.productConfigDto.checkInventory = selectedProduct.details.checkInventory
        if type == .Telecom {
            dto.extraProperties.type = selectedProduct.type
        }
        dtos.append(dto)
        param.orderTransactionDtos = dtos
        
        var payments: [TheNapSOMPayment] = []
        let payment: TheNapSOMPayment = TheNapSOMPayment(JSON: [:])!
        payment.paymentType = "1"
        payment.paymentValue = dto.totalAmountIncludingFee
        payment.paymentExtraFee = dto.totalFee
        payment.paymentPercentFee = selectedProduct.details.percentFee
        payments.append(payment)
        param.payments = payments
        
        TheCaoSOMDataManager.shared.orderDetail = param
    }
    
    private func checkViettel() {
        var customerID = tfPhone.text!
        if let index = customerID.firstIndex(of: "0") {
            customerID.replaceSubrange(index...index, with: ["8", "4"])
        }
        Provider.shared.thecaoSOMAPIService.checkViettelCustomer(providerID: selectedTransferProduct.defaultProviderID, customerID: customerID, integratedGroupCode: selectedTransferProduct.configs.first?.integratedGroupCode ?? "", integratedProductCode: selectedTransferProduct.configs.first?.integratedProductCode ?? "", success: { [weak self] result in
            guard let self = self else { return }
            self.validViettel = result
            if !self.validViettel {
                self.showAlertOneButton(title: "Thông báo", with: "Thuê bao trả sau không được topup. Vui lòng vào màn hình thu hộ tạo giao dịch", titleButton: "OK")
            }
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            self.validViettel = false
        })
    }
    
    private func getViettelOffers(message: String = "") {
        Provider.shared.thecaoSOMAPIService.getViettelOffers(providerID: selectedTelecomItem.products.first?.defaultProviderID ?? "", customerID: tfPhone.text!, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            self.selectedTelecomProducts = []
            for product in self.selectedTelecomItem.products {
                let filter = data.extraProperties.data.filter({$0.type.lowercased() == "3g" || $0.type.lowercased() == "4g" })
                let listVASData = filter.flatMap { $0.products }
                if let vas = listVASData.first(where: {$0.code == product.configs.first?.integratedProductCode }) {
                    product.type = vas.type
                    self.selectedTelecomProducts.append(product)
                }
            }
            
            self.selectedTelecomProduct = self.selectedTelecomProducts.first ?? TheNapSOMProduct(JSON: [:])!
            if self.selectedTelecomProducts.count < 1 {
                self.showAlertOneButton(title: "Thông báo", with: "Thuê bao không phát sinh gói cước viễn thông. Vui lòng liên hệ nhà mạng", titleButton: "OK")
            } else {
                if message != "" {
                    self.showAlertOneButton(title: "Thông báo", with: message, titleButton: "OK")
                }
            }
            DispatchQueue.main.async {
                self.updatePrice()
                self.clvTelecomPrice.reloadData()
                self.viewDidLayoutSubviews()
            }
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    private func getVinaOffers(message: String = "") {
        Provider.shared.thecaoSOMAPIService.getVinaOffers(providerID: selectedTelecomItem.products.first?.defaultProviderID ?? "", customerID: tfPhone.text!, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            self.selectedTelecomProducts = []
            for product in self.selectedTelecomItem.products {
                let filter = data.extraProperties.data.filter({ $0.type.lowercased() == "vas" })
                let listVASData = filter.flatMap { $0.products }
                if let vas = listVASData.first(where: { $0.code == product.configs.first?.integratedProductCode }) {
                    product.type = vas.type
                    self.selectedTelecomProducts.append(product)
                }
            }
            
            self.selectedTelecomProduct = self.selectedTelecomProducts.first ?? TheNapSOMProduct(JSON: [:])!
            if self.selectedTelecomProducts.count < 1 {
                self.showAlertOneButton(title: "Thông báo", with: "Thuê bao không phát sinh gói cước viễn thông. Vui lòng liên hệ nhà mạng", titleButton: "OK")
            } else {
                if message != "" {
                    self.showAlertOneButton(title: "Thông báo", with: message, titleButton: "OK")
                }
            }
            DispatchQueue.main.async {
                self.updatePrice()
                self.clvTelecomPrice.reloadData()
                self.viewDidLayoutSubviews()
            }
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    private func loadProviders() {
        prepareParam()
        let selectedProduct = type == .Transfer ? selectedTransferProduct : (type == .Data  ? selectedDataProduct : selectedTelecomProduct)
        let provider = TheCaoSOMDataManager.shared.providers.items.first(where: { $0.id == TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first!.providerID }) ?? ThuHoSOMProviderItem(JSON: [:])!
        TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first!.providerName = provider.name.isEmpty ? selectedProduct.code : provider.name
        
        self.loadDefaultPayment()
    }
    
    private func loadDefaultPayment() {
        Provider.shared.thecaoSOMAPIService.getDefaultPayment(param: TheCaoSOMDataManager.shared.orderDetail, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            TheCaoSOMDataManager.shared.orderDetail = data
            
            let vc = TheNapSOMPaymentViewController()
            vc.type = .BanTien
            vc.isVAS = (self.type == .Transfer || self.type == .Data) ? false : true
            self.navigationController?.pushViewController(vc, animated: true)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    private func validateInputs() -> Bool {
        guard let phone = tfPhone.text, !phone.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập SĐT khách hàng", titleButton: "OK")
            return false
        }
        
        if phone.count != 10 {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin SĐT 10 chữ số", titleButton: "OK")
            return false
        }
        
        guard validViettel else {
            showAlertOneButton(title: "Thông báo", with: "Thuê bao trả sau không được topup. Vui lòng vào màn hình thu hộ tạo giao dịch", titleButton: "OK")
            return false
        }
        
        switch type {
        case .Transfer:
            guard !selectedTransferProduct.id.isEmpty else {
                showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn mệnh giá", titleButton: "OK")
                return false
            }
        case .Data:
            guard !selectedDataProduct.id.isEmpty else {
                showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn mệnh giá", titleButton: "OK")
                return false
            }
        case .Telecom:
            guard !selectedTelecomProduct.id.isEmpty else {
                showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn gói", titleButton: "OK")
                return false
            }
        }
        
        return true
    }
    
    func reMoveData() {
        self.selectedTelecomProduct = TheNapSOMProduct(JSON: [:])!
        self.selectedTelecomProducts = []
        self.clvTelecomPrice.reloadData()
        self.updatePrice()
    }
    
    @IBAction func tranferButtonPressed(_ sender: Any) {
        vTransfer.isHidden = false
        vTelecom.isHidden = true
        vData.isHidden = true
        
        lbTransfer.textColor = .black
        lbTelecom.textColor = .lightGray
        lbData.textColor = .lightGray
        
        type = .Transfer
        switchType()
    }
    
    @IBAction func telecomButtonPressed(_ sender: Any) {
        vTransfer.isHidden = true
        vTelecom.isHidden = false
        vData.isHidden = true
        
        lbTransfer.textColor = .lightGray
        lbTelecom.textColor = .black
        lbData.textColor = .lightGray
        
        type = .Telecom
        switchType()
    }
    
    @IBAction func dataButotnPressed(_ sender: Any) {
        vTransfer.isHidden = true
        vTelecom.isHidden = true
        vData.isHidden = false
        
        lbTransfer.textColor = .lightGray
        lbTelecom.textColor = .lightGray
        lbData.textColor = .black
        
        type = .Data
        switchType()
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        guard validateInputs() else { return }
        
        switch type {
        case .Transfer:
            TheCaoSOMDataManager.shared.selectedItem = selectedTransferItem
            TheCaoSOMDataManager.shared.selectedProduct.product = selectedTransferProduct
        case .Telecom:
            TheCaoSOMDataManager.shared.selectedItem = selectedTelecomItem
            TheCaoSOMDataManager.shared.selectedProduct.product = selectedTelecomProduct
        case .Data:
            TheCaoSOMDataManager.shared.selectedItem = selectedDataItem
            TheCaoSOMDataManager.shared.selectedProduct.product = selectedDataProduct
        }
        
        loadProviders()
    }
    
    @IBAction func onclickSearch() {
        self.view.endEditing(true)
        guard let phone = tfPhone.text,!phone.isEmpty else {
            self.showAlert("Bạn chưa nhập sđt", andTitle: "OK")
            return
        }
        if selectedTelecomItem.name == "Mobifone Vas" {
            Provider.shared.thecaoSOMAPIService.checkStatus(phone: phone, provider: selectedTelecomItem.products.first?.defaultProviderID ?? "", success: { [weak self] result in
                guard let self = self, let data = result else { return }
                if data.integrationInfo.returnedCode == "200" {
                    self.getViettelOffers(message: data.integrationInfo.returnedMessage)
                } else {
                    self.reMoveData()
                    self.showAlertOneButton(title: "Thông báo", with: data.integrationInfo.returnedMessage, titleButton: "OK")
                }
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.reMoveData()
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        }
    }
}

extension BanTienSOMViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case clvPrice:
            if type == .Transfer {
               return selectedTransferItem.products.filter { $0.enabled }.count
            } else {
                return selectedDataItem.products.filter { $0.enabled }.count
            }
        case clvProvider:
            return telecoms.count
        case clvTelecomPrice:
            return selectedTelecomProducts.filter { $0.enabled }.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case clvPrice:
            let cell = collectionView.dequeueCollectionCell(TheNapSOMPriceCollectionViewCell.self, indexPath: indexPath)
            if type == .Transfer {
                cell.setupCell(product: selectedTransferItem.products[indexPath.row], isSelected: selectedTransferItem.products[indexPath.row].id == selectedTransferProduct.id)
            } else {
                cell.setupCell(product: selectedDataItem.products[indexPath.row], isSelected: selectedDataItem.products[indexPath.row].id == selectedDataProduct.id)
            }
            return cell
        case clvProvider:
            let cell = collectionView.dequeueCollectionCell(TheNapSOMProductCollectionViewCell.self, indexPath: indexPath)
            cell.setupCell(item: telecoms[indexPath.row], isSelected: telecoms[indexPath.row].id == selectedTelecomItem.id)
            return cell
        case clvTelecomPrice:
            let cell = collectionView.dequeueCollectionCell(TheNapSOMPriceCollectionViewCell.self, indexPath: indexPath)
            cell.setupCell(product: selectedTelecomProducts[indexPath.row], isSelected: selectedTelecomProducts[indexPath.row].id == selectedTelecomProduct.id)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case clvPrice:
            if type == .Transfer {
                guard selectedTransferProduct.id != selectedTransferItem.products[indexPath.row].id else { return }
                selectedTransferProduct = selectedTransferItem.products[indexPath.row]
            } else {
                guard selectedDataProduct.id != selectedDataItem.products[indexPath.row].id else { return }
                selectedDataProduct = selectedDataItem.products[indexPath.row]
            }
            clvPrice.reloadData()
            updatePrice()
        case clvProvider:
            tfPhone.text = ""
            self.reMoveData()
            guard selectedTelecomItem.id != telecoms[indexPath.row].id else { return }
            selectedTelecomItem = telecoms[indexPath.row]
            if selectedTelecomItem.name == "Mobifone Vas" {
                searchButton.isHidden = false
            } else {
                searchButton.isHidden = true
            }
            selectedTelecomProduct = TheNapSOMProduct(JSON: [:])!
            clvProvider.reloadData()
            clvTelecomPrice.reloadData()
            viewDidLayoutSubviews()
            updatePrice()
        case clvTelecomPrice:
            guard selectedTelecomProduct.id != selectedTelecomProducts[indexPath.row].id else { return }
            selectedTelecomProduct = selectedTelecomProducts[indexPath.row]
            clvTelecomPrice.reloadData()
            updatePrice()
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = (UIScreen.main.bounds.width - 80) / 3
        let height = width / 2
        if collectionView == clvTelecomPrice {
            width = (UIScreen.main.bounds.width - 60) / 2
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension BanTienSOMViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfPhone {
            if selectedTelecomItem.name == "Mobifone Vas" {
                self.reMoveData()
            }
            
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            let shouldChange = range.location < 10 && allowedCharacters.isSuperset(of: characterSet)
            
            if shouldChange {
                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                if text.count == 3 {
                    validViettel = true
                    switch type {
                    case .Transfer:
                        for transfer in transfers {
                            if transfer.extraProperties.telPrefix.contains(text) {
                                selectedTransferItem = transfer
                                selectedTransferProduct = selectedTransferItem.products.first ?? TheNapSOMProduct(JSON: [:])!
                                
                                DispatchQueue.main.async {
                                    self.updatePrice()
                                    self.clvPrice.reloadData()
                                    self.viewDidLayoutSubviews()
                                }
                                return shouldChange
                            }
                        }
                    case .Data:
                        for eData in datas {
                            if eData.extraProperties.telPrefix.contains(text) {
                                selectedDataItem = eData
                                selectedDataProduct = selectedDataItem.products.first ?? TheNapSOMProduct(JSON: [:])!
                                
                                DispatchQueue.main.async {
                                    self.updatePrice()
                                    self.clvPrice.reloadData()
                                    self.viewDidLayoutSubviews()
                                }
                                return shouldChange
                            }
                        }
                    case .Telecom:
                        return shouldChange
                    }
                } else if text.count < 3 {
                    validViettel = true
                    switch type {
                    case .Transfer:
                        selectedTransferItem = TheNapSOMItem(JSON: [:])!
                        selectedTransferProduct = TheNapSOMProduct(JSON: [:])!
                        
                        DispatchQueue.main.async {
                            self.updatePrice()
                            self.clvPrice.reloadData()
                            self.viewDidLayoutSubviews()
                        }
                        return shouldChange
                    case .Data:
                        selectedDataItem = TheNapSOMItem(JSON: [:])!
                        selectedDataProduct = TheNapSOMProduct(JSON: [:])!
                        
                        DispatchQueue.main.async {
                            self.updatePrice()
                            self.clvPrice.reloadData()
                            self.viewDidLayoutSubviews()
                        }
                        return shouldChange
                    case .Telecom:
                        return shouldChange
                    }
                } else if text.count == 10 {
                    validViettel = true
                    switch type {
                    case .Transfer:
                        if selectedTransferItem.name == "Viettel" {
                            textField.text = text
                            checkViettel()
                            return false
                        }
                    case .Data:
                        if selectedDataItem.name == "Viettel" {
                            textField.text = text
                            checkViettel()
                            return false
                        }
                    case .Telecom:
                        if selectedTelecomItem.name == "Gói cước Viettel" {
                            textField.text = text
                            getViettelOffers()
                            return false
                        } else if selectedTelecomItem.name == "Vinaphone" {
                            textField.text = text
                            getVinaOffers()
                            return false
                        }
                    }
                }
            }
            
            return shouldChange
        }
        
        return true
    }
}
