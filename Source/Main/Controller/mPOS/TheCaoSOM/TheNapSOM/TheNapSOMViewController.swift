//
//  TheNapSOMViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 22/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

enum TheNapSOMType {
    case Mobile
    case Game
    case Data
}

class TheNapSOMViewController: UIViewController {

    @IBOutlet weak var headerScrollView: UIScrollView!
    @IBOutlet weak var vMobile: UIView!
    @IBOutlet weak var lbMobile: UILabel!
    @IBOutlet weak var vGame: UIView!
    @IBOutlet weak var lbGame: UILabel!
    @IBOutlet weak var vData: UIView!
    @IBOutlet weak var lbData: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var clvProduct: UICollectionView!
    @IBOutlet weak var cstProductHeight: NSLayoutConstraint!
    @IBOutlet weak var clvPrice: UICollectionView!
    @IBOutlet weak var cstPriceHeight: NSLayoutConstraint!
    @IBOutlet weak var lbQuantity: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var btnConfirm: UIButton!
    
    private var type: TheNapSOMType = .Mobile
    private var mobiles: [TheNapSOMItem] = []
    private var games: [TheNapSOMItem] = []
    private var datas: [TheNapSOMItem] = []
    
    private var selectedMobileItem: TheNapSOMItem = TheNapSOMItem(JSON: [:])!
    private var selectedMobileProduct: TheNapSOMProduct = TheNapSOMProduct(JSON: [:])!
    private var selectedGameItem: TheNapSOMItem = TheNapSOMItem(JSON: [:])!
    private var selectedGameProduct: TheNapSOMProduct = TheNapSOMProduct(JSON: [:])!
    private var selectedDataItem: TheNapSOMItem = TheNapSOMItem(JSON: [:])!
    private var selectedDataProduct: TheNapSOMProduct = TheNapSOMProduct(JSON: [:])!
    private var mobileQuantity: Int = 1
    private var mobileMaxQuantity: Int = 0
    private var gameQuantity: Int = 1
    private var gameMaxQuantity: Int = 0
    private var dataQuantity: Int = 1
    private var dataMaxQuantity: Int = 0
    
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
            self.cstProductHeight.constant = self.clvProduct.contentSize.height
            self.cstPriceHeight.constant = self.clvPrice.contentSize.height
        }
    }
    
    private func setupUI() {
        title = "Thẻ Nạp"
        addBackButton()
        
        btnConfirm.roundCorners(.allCorners, radius: 5)
    }
    
    private func setupCollectionView() {
        clvProduct.registerCollectionCell(TheNapSOMProductCollectionViewCell.self)
        clvPrice.registerCollectionCell(TheNapSOMPriceCollectionViewCell.self)
    }
    
    private func loadData() {
        Provider.shared.thecaoSOMAPIService.getCategories(parentID: "ddabdaa8-c0de-4e48-88fb-0bf4b16312ac", success: { [weak self] result in
            guard let self = self, let data = result else { return }
            self.mobiles = data.items.filter { $0.extraProperties.type == "mobile" }
            self.games = data.items.filter { $0.extraProperties.type == "game" }
            self.datas = data.items.filter { $0.extraProperties.type == "data" }
            for mobile in self.mobiles {
                mobile.products = self.filterProducts(products: mobile.products)
            }
            for game in self.games {
                game.products = self.filterProducts(products: game.products)
            }
            for data in self.datas {
                data.products = self.filterProducts(products: data.products)
            }
            self.selectedMobileItem = self.mobiles.first ?? TheNapSOMItem(JSON: [:])!
            self.selectedMobileProduct = self.selectedMobileItem.products.first ?? TheNapSOMProduct(JSON: [:])!
            
            self.selectedGameItem = self.games.first ?? TheNapSOMItem(JSON: [:])!
            self.selectedGameProduct = self.selectedGameItem.products.first ?? TheNapSOMProduct(JSON: [:])!
            
            self.selectedDataItem = self.datas.first ?? TheNapSOMItem(JSON: [:])!
            self.selectedDataProduct = self.selectedDataItem.products.first ?? TheNapSOMProduct(JSON: [:])!
            
            self.mobileMaxQuantity = self.selectedMobileItem.extraProperties.size == 1 ? 1 : 10
            self.gameMaxQuantity = self.selectedGameItem.extraProperties.size == 1 ? 1 : 10
            self.dataMaxQuantity = self.selectedMobileItem.extraProperties.size == 1 ? 1 : 10
            
            DispatchQueue.main.async {
                self.updatePrice()
                self.clvProduct.reloadData()
                self.clvPrice.reloadData()
                self.viewDidLayoutSubviews()
            }
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    private func updatePrice() {
        var total: Int = 0
        switch type {
        case .Mobile:
            mobileQuantity = mobileQuantity > mobileMaxQuantity ? mobileMaxQuantity : mobileQuantity
            lbQuantity.text = "\(mobileQuantity)"
            total = mobileQuantity * selectedMobileProduct.details.sellingPrice
        case .Game:
            gameQuantity = gameQuantity > gameMaxQuantity ? gameMaxQuantity : gameQuantity
            lbQuantity.text = "\(gameQuantity)"
            total = gameQuantity * selectedGameProduct.details.sellingPrice
        case .Data:
            dataQuantity = dataQuantity > dataMaxQuantity ? dataMaxQuantity : dataQuantity
            lbQuantity.text = "\(dataQuantity)"
            total = dataQuantity * selectedDataProduct.details.sellingPrice
        }
        lbPrice.text = "\(Common.convertCurrencyV2(value: total)) VNĐ"
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
        let selectedItem = type == .Mobile ? selectedMobileItem : (type == .Data ? selectedDataItem : selectedGameItem)
        let selectedProduct = type == .Mobile ? selectedMobileProduct : (type == .Data ? selectedDataProduct : selectedGameProduct)
        dto.productID = selectedProduct.id
        dto.providerID = selectedProduct.details.providerID
        dto.providerName = ""
        dto.productName = selectedProduct.name
        dto.price = selectedProduct.details.price
        dto.sellingPrice = selectedProduct.details.sellingPrice
        dto.quantity = type == .Mobile ? mobileQuantity : (type == .Data ? dataQuantity : gameQuantity)
        dto.totalFee = type == .Mobile ? mobileQuantity * selectedProduct.details.fixedFee : (type == .Data ? (dataQuantity * selectedProduct.details.fixedFee) : (gameQuantity * selectedProduct.details.fixedFee))
        dto.totalAmount = type == .Mobile ? mobileQuantity * selectedProduct.details.sellingPrice : (type == .Data ? dataQuantity * selectedProduct.details.sellingPrice : gameQuantity * selectedProduct.details.sellingPrice)
        dto.totalAmountIncludingFee = dto.totalFee + dto.totalAmount
        dto.creationTime = Date().stringWithFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        dto.creationBy = Cache.user!.UserName
        dto.integratedGroupCode = selectedProduct.configs.first?.integratedGroupCode ?? ""
        dto.integratedProductCode = selectedProduct.configs.first?.integratedProductCode ?? ""
        dto.referenceCode = type == .Mobile ? selectedMobileProduct.legacyID : (type == .Data ? selectedDataProduct.legacyID : selectedGameProduct.legacyID)
        dto.percentFee = selectedProduct.details.percentFee
        dto.categoryID = selectedItem.id
        dto.productConfigDto.checkInventory = selectedProduct.details.checkInventory
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
    
    private func loadProviders() {
        prepareParam()
        let selectedProduct = type == .Mobile ? selectedMobileProduct : (type == .Data ? selectedDataProduct : selectedGameProduct)
        let provider = TheCaoSOMDataManager.shared.providers.items.first(where: { $0.id == TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first!.providerID }) ?? ThuHoSOMProviderItem(JSON: [:])!
        TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first!.providerName = provider.name.isEmpty ? selectedProduct.code : provider.name

        loadDefaultPayment()
    }
    
    private func loadDefaultPayment() {
        Provider.shared.thecaoSOMAPIService.getDefaultPayment(param: TheCaoSOMDataManager.shared.orderDetail, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            TheCaoSOMDataManager.shared.orderDetail = data

            let vc = TheNapSOMPaymentViewController()
            vc.type = .TheNap
            self.navigationController?.pushViewController(vc, animated: true)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    private func validateInputs() -> Bool {
        switch type {
        case .Mobile:
            guard !selectedMobileProduct.id.isEmpty else {
                showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn mệnh giá", titleButton: "OK")
                return false
            }
        case .Game:
            guard !selectedGameProduct.id.isEmpty else {
                showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn mệnh giá", titleButton: "OK")
                return false
            }
        case .Data:
            guard !selectedDataProduct.id.isEmpty else {
                showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn mệnh giá", titleButton: "OK")
                return false
            }
        }
        
        return true
    }
    
    @IBAction func plusButtonPressed(_ sender: Any) {
        switch type {
        case .Mobile:
            mobileQuantity = mobileQuantity + 1 <= mobileMaxQuantity ? mobileQuantity + 1 : mobileQuantity
        case .Game:
            gameQuantity = gameQuantity + 1 <= gameMaxQuantity ? gameQuantity + 1 : gameQuantity
        case .Data:
            dataQuantity = dataQuantity + 1 <= dataMaxQuantity ? dataQuantity + 1 : dataQuantity
        }
        
        updatePrice()
    }
    
    @IBAction func minusButtonPressed(_ sender: Any) {
        switch type {
        case .Mobile:
            mobileQuantity = mobileQuantity - 1 >= 1 ? mobileQuantity - 1 : mobileQuantity
        case .Game:
            gameQuantity = gameQuantity - 1 >= 1 ? gameQuantity - 1 : gameQuantity
        case .Data:
            dataQuantity = dataQuantity - 1 >= 1 ? dataQuantity - 1 : dataQuantity
        }
        
        updatePrice()
    }
    
    @IBAction func mobileButtonPressed(_ sender: Any) {
        vMobile.isHidden = false
        vGame.isHidden = true
        vData.isHidden = true
        
        lbMobile.textColor = .black
        lbGame.textColor = .lightGray
        lbData.textColor = .lightGray
        lbTitle.text = "CHỌN NHÀ MẠNG"
        type = .Mobile
        
        clvProduct.reloadData()
        clvPrice.reloadData()
        updatePrice()
    }
    
    @IBAction func gameButtonPressed(_ sender: Any) {
        vMobile.isHidden = true
        vGame.isHidden = false
        vData.isHidden = true
        
        lbMobile.textColor = .lightGray
        lbGame.textColor = .black
        lbData.textColor = .lightGray
        lbTitle.text = "CHỌN NHÀ CUNG CẤP"
        type = .Game
        
        clvProduct.reloadData()
        clvPrice.reloadData()
        updatePrice()
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        guard validateInputs() else { return }
        
        switch type {
        case .Mobile:
            TheCaoSOMDataManager.shared.selectedItem = selectedMobileItem
            TheCaoSOMDataManager.shared.selectedProduct.quantity = mobileQuantity
            TheCaoSOMDataManager.shared.selectedProduct.product = selectedMobileProduct
        case .Game:
            TheCaoSOMDataManager.shared.selectedItem = selectedGameItem
            TheCaoSOMDataManager.shared.selectedProduct.quantity = gameQuantity
            TheCaoSOMDataManager.shared.selectedProduct.product = selectedGameProduct
        case .Data:
            TheCaoSOMDataManager.shared.selectedItem = selectedDataItem
            TheCaoSOMDataManager.shared.selectedProduct.quantity = dataQuantity
            TheCaoSOMDataManager.shared.selectedProduct.product = selectedDataProduct
        }
        
        loadProviders()
    }
    
    @IBAction func onClickViewData(_ sender: Any) {
        vMobile.isHidden = true
        vGame.isHidden = true
        vData.isHidden = false
        
        lbMobile.textColor = .lightGray
        lbGame.textColor = .lightGray
        lbData.textColor = .black
        lbTitle.text = "CHỌN NHÀ MẠNG"
        type = .Data
        
        clvProduct.reloadData()
        clvPrice.reloadData()
        updatePrice()
    }
}

extension TheNapSOMViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case clvProduct:
            switch type {
            case .Mobile:
                return mobiles.count
            case .Game:
                return games.count
            case .Data:
                return datas.count
            }
        case clvPrice:
            switch type {
            case .Mobile:
                return selectedMobileItem.products.filter { $0.enabled }.count
            case .Game:
                return selectedGameItem.products.filter { $0.enabled }.count
            case .Data:
                return selectedDataItem.products.filter { $0.enabled }.count
            }
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case clvProduct:
            let cell = collectionView.dequeueCollectionCell(TheNapSOMProductCollectionViewCell.self, indexPath: indexPath)
            switch type {
            case .Mobile:
                cell.setupCell(item: mobiles[indexPath.row], isSelected: mobiles[indexPath.row].id == selectedMobileItem.id)
            case .Game:
                cell.setupCell(item: games[indexPath.row], isSelected: games[indexPath.row].id == selectedGameItem.id)
            case .Data:
                cell.setupCell(item: datas[indexPath.row], isSelected: datas[indexPath.row].id == selectedDataItem.id)
            }
            return cell
        case clvPrice:
            let cell = collectionView.dequeueCollectionCell(TheNapSOMPriceCollectionViewCell.self, indexPath: indexPath)
            switch type {
            case .Mobile:
                cell.setupCell(product: selectedMobileItem.products[indexPath.row], isSelected: selectedMobileItem.products[indexPath.row].id == selectedMobileProduct.id)
            case .Game:
                cell.setupCell(product: selectedGameItem.products[indexPath.row], isSelected: selectedGameItem.products[indexPath.row].id == selectedGameProduct.id)
            case .Data:
                cell.setupCell(product: selectedDataItem.products[indexPath.row], isSelected: selectedDataItem.products[indexPath.row].id == selectedDataProduct.id)
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case clvProduct:
            switch type {
            case .Mobile:
                guard selectedMobileItem.id != mobiles[indexPath.row].id else { return }
                selectedMobileItem = mobiles[indexPath.row]
                selectedMobileProduct = selectedMobileItem.products.first ?? TheNapSOMProduct(JSON: [:])!
                mobileMaxQuantity = selectedMobileItem.extraProperties.size == 1 ? 1 : 10
            case .Game:
                guard selectedGameItem.id != games[indexPath.row].id else { return }
                selectedGameItem = games[indexPath.row]
                selectedGameProduct = selectedGameItem.products.first ?? TheNapSOMProduct(JSON: [:])!
                gameMaxQuantity = selectedGameItem.extraProperties.size == 1 ? 1 : 10
            case .Data:
                guard selectedDataItem.id != datas[indexPath.row].id else { return }
                selectedDataItem = datas[indexPath.row]
                selectedDataProduct = selectedDataItem.products.first ?? TheNapSOMProduct(JSON: [:])!
                dataMaxQuantity = selectedDataItem.extraProperties.size == 1 ? 1 : 10
            }
            clvProduct.reloadData()
            clvPrice.reloadData()
            viewDidLayoutSubviews()
            updatePrice()
        case clvPrice:
            switch type {
            case .Mobile:
                guard selectedMobileProduct.id != selectedMobileItem.products[indexPath.row].id else { return }
                selectedMobileProduct = selectedMobileItem.products[indexPath.row]
            case .Game:
                guard selectedGameProduct.id != selectedGameItem.products[indexPath.row].id else { return }
                selectedGameProduct = selectedGameItem.products[indexPath.row]
            case .Data:
                guard selectedDataProduct.id != selectedDataItem.products[indexPath.row].id else { return }
                selectedDataProduct = selectedDataItem.products[indexPath.row]
            }
            clvPrice.reloadData()
            updatePrice()
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 80) / 3
        let height = width / 2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
