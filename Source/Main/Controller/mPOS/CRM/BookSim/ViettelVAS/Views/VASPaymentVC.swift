//
//  VASPaymentVC.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 08/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Presentr
import PopupDialog

class VASPaymentVC: BaseController {

    @IBOutlet weak var monneyLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var moneyHavetoPay: UILabel!
    
    var itemGoiCuocChoose: ViettelVASGoiCuoc_products?
    var sdt = ""
    var otp = ""
    var listProductViettelVAS_MainInfo = [ViettelVAS_Product]()
    var integrationInfo: ViettelVASGoiCuoc_IntegrationInfo?
    var orderDetail: ViettelPayOrder?
    
    var totalAmount: Int = 0
    var totalIncludeFee: Int = 0
    var currentPayment: [ViettelPayOrder_Payment] = []
    var orderId = ""
    
    let presenter: Presentr = {
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
        
        let btLeftIcon = UIButton.init(type: .custom)
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(backAction), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        self.title = "Hình thức thanh toán"
        NotificationCenter.default.addObserver(self, selector: #selector(didfinishCheckStatusMomoSOM(notification:)), name: NSNotification.Name("finishCheckStatusMOMO_SOM"), object: nil)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CardInfoCell", bundle: nil), forCellReuseIdentifier: "CardInfoCell")
        bindUI()
        reloadTableView()
        totalAmount = Int(itemGoiCuocChoose?.price ?? 0)
        totalIncludeFee = totalAmount
        
        let price = Double(itemGoiCuocChoose?.price.removeZerosFromEnd() ?? "0")
        let defaultPayment = ViettelPayOrder_Payment(paymentType: 1, paymentCode: "", paymentCodeDescription: "", paymentAccountNumber: "", paymentValue: price ?? 0, bankType: "", bankTypeDescription: "", cardType: "", cardTypeDescription: "", isCardOnline: false, paymentExtraFee: 0, paymentPercentFee: 0, isChargeOnCash: false)
        currentPayment.append(defaultPayment)
        
    }
    
    private func bindUI() {
        monneyLabel.text = "\(Common.convertCurrencyDouble(value: itemGoiCuocChoose?.price ?? 0))đ"
        moneyHavetoPay.text = "\(Common.convertCurrencyDouble(value: itemGoiCuocChoose?.price ?? 0))đ"
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didfinishCheckStatusMomoSOM(notification: Notification) {
        let info = notification.userInfo
        let orderStatusID = info?["orderStatusID"] as? CreateOrderResultViettelPay_SOM
        
        self.fetchInfoOrderSomAPI(orderID: "\(self.orderId)", orderStastusID: orderStatusID ?? .FAILED)
    }
    
    func fetchInfoOrderSomAPI(orderID: String, orderStastusID: CreateOrderResultViettelPay_SOM){
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            SOMAPIManager.shared.getInfoOrderSOM(id: "\(orderID)") { result in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    switch result {
                    case .success( _):
                        if orderStastusID == .FAILED {
                            let alert = UIAlertController(title: "Thông báo", message: "Giao dịch thất bại!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                let vc = HistoryViettelPackageDetail()
                                vc.idTransaction = self.orderId
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        } else {
                            let vc = HistoryViettelPackageDetail()
                            vc.idTransaction = self.orderId
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    case .failure(let error):
                        self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
                    }
                }
            }
        }
    }
    
    private func reloadTableView() {
        tableView.reloadData()
        let list = currentPayment.filter{$0.paymentType == 2}
        tableViewHeight.constant = CGFloat(139 * (list.count))
        
        UIView.animate(withDuration: 0, animations: {
        }) { (complete) in
            var promoHeightOfTableView: CGFloat = 0.0
            // Get visible cells and sum up their heights
            let promoCells = self.tableView.visibleCells
            for cell in promoCells {
                promoHeightOfTableView += cell.frame.height
            }
            
            // Edit heightOfTableViewConstraint's constant to update height of table view
            self.tableViewHeight.constant = promoHeightOfTableView
        }
    }
    
    func updateData() {
        let payemntMoney = currentPayment.filter{$0.paymentType == 1}.first
        self.monneyLabel.text = "\(Common.convertCurrencyDouble(value: payemntMoney?.paymentValue ?? 0))đ"
        let paymentCards = currentPayment.filter{$0.paymentType == 2}
        var money: Double = 0
        paymentCards.forEach({ (item) in
            money += item.paymentValue
        })
        money += payemntMoney?.paymentValue ?? 0
        moneyHavetoPay.text = "\(Common.convertCurrencyDouble(value: money))đ"
        self.totalIncludeFee = Int(money)
        reloadTableView()
    }
    
    func addRemoveCard(isAdd: Bool, listPayMent: [ViettelPayOrder_Payment]) {
        let itemProductMain = self.listProductViettelVAS_MainInfo.first(where: {($0.configs[0].integratedProductCode == self.itemGoiCuocChoose?.mCode ?? "") && ($0.price == self.itemGoiCuocChoose?.price ?? 0)})
        self.showLoading()
        VASViettelApiManager.shared.addNewCard(isAdd: isAdd,payment: listPayMent, itemGoiCuocMain: itemProductMain!, integrationInfo: self.integrationInfo!,totalIncludeFee: self.totalIncludeFee, sdt: self.sdt, categoryId: itemProductMain?.categoryIds.first ?? "") { isSuccess,vasOrder,err in
            self.stopLoading()
            if isSuccess {
                self.orderDetail = vasOrder
                self.currentPayment = vasOrder?.payments ?? []
                self.updateData()
            } else {
                self.showPopup(with: err, titleButton: "Đồng ý", isshowClose: false) {}
            }
        }
    }
    
    func showPopup(with Title: String, titleButton: String, isshowClose: Bool, completion: @escaping (() -> Void)) {
        let popup = PopupVC()
        popup.onOKAction = {
            completion()
        }
        popup.dataPopup.content = Title
        popup.dataPopup.titleButton = titleButton
        popup.dataPopup.isShowClose = isshowClose
        popup.modalPresentationStyle = .overCurrentContext
        popup.modalTransitionStyle = .crossDissolve
        self.present(popup, animated: true, completion: nil)
    }
    
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {

        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
            textField.isSecureTextEntry = false
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func actionPayment() {
        
        self.showInputDialog(title: "Xác nhận", subtitle: "Nhập mã OTP gửi về máy khách hàng", actionTitle: "Xác nhận", inputPlaceholder: "Nhập OTP", inputKeyboardType: .numberPad) { (otpString) in
            debugPrint("otp: \(otpString ?? "x")")
            guard let opt = otpString, !opt.isEmpty else {
                let alertVC = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập OTP xác nhận!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertVC.addAction(action)
                self.present(alertVC, animated: true, completion: nil)
                return
            }
            self.otp = "\(otpString ?? "")"
            
            let popup = PopupDialog(title: "Thông báo", message: "Bạn có muốn thanh toán \(Common.convertCurrencyV2(value: self.totalIncludeFee)) VNĐ vào số điện thoại \(self.sdt) không?", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            
            let buttonOne = CancelButton(title: "Huỷ bỏ") {
                
            }
            let buttonTwo = DefaultButton(title: "Đồng ý thanh toán"){
                self.payment(integrationInfo: self.integrationInfo ?? ViettelVASGoiCuoc_IntegrationInfo(requestId: "", responseId: "", returnedCode: "", returnedMessage: ""), listPayemnt: self.currentPayment)
            }
            popup.addButtons([buttonOne,buttonTwo])
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    func payment(integrationInfo: ViettelVASGoiCuoc_IntegrationInfo, listPayemnt: [ViettelPayOrder_Payment]) {
        let itemProductMain = self.listProductViettelVAS_MainInfo.first(where: {($0.configs[0].integratedProductCode == self.itemGoiCuocChoose?.mCode ?? "") && ($0.price == self.itemGoiCuocChoose?.price ?? 0)})
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "vi_VN")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let strDate = dateFormatter.string(from: Date())
        debugPrint("strDate: \(strDate)Z")
        
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang thanh toán ...") {
            CRMAPIManager.ViettelVAS_CreateOrder(providerId: "\(itemProductMain?.details.providerID ?? "")", sdt: self.sdt, creationTime: "\(strDate)Z", itemGoiCuocMain: itemProductMain!, itemGoiCuocSelect: self.itemGoiCuocChoose!, payments: listPayemnt, totalFee: "",totalAmountIcludeFee: self.totalIncludeFee, categoryId: "\(itemProductMain?.categoryIds[0] ?? "")", integrationInfo: integrationInfo, otpString: self.otp) { (rsID, customerID, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if !rsID.isEmpty {
                            self.orderId = rsID
                            let vc = CountSecond_MomoSOMViewController()
                            vc.orderId = rsID
                            self.customPresentViewController(self.presenter, viewController: vc, animated: true)
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "Thanh toán thất bại!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }

    @IBAction func addCardAction(_ sender: Any) {
        let vc = AddCardViewController()
        vc.onAdd = { [weak self] vas in
            guard let self = self else {return}
            print("your vas: \(vas)")
            var listPayments = [ViettelPayOrder_Payment]()
            listPayments = self.currentPayment
            listPayments.append(vas)
            self.addRemoveCard(isAdd: true, listPayMent: listPayments)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func paymentAction(_ sender: Any) {
        actionPayment()
    }
}


extension VASPaymentVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentPayment.filter{$0.paymentType == 2}.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardInfoCell", for: indexPath) as! CardInfoCell
        let filterList = currentPayment.filter{$0.paymentType == 2}
        let item = filterList[indexPath.row]
        cell.bindCells(with: item)
        return cell
    }
    
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
      let delete = deleteProperty(at: indexPath)
      return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteProperty(at indexpath: IndexPath) -> UIContextualAction {
      let action = UIContextualAction(style: .destructive, title: "Xóa") { (action, view, completon) in
        action.backgroundColor = .red //cell background color
        let defaultPayment = self.currentPayment.filter{$0.paymentType == 1}
        var payments = self.currentPayment.filter{$0.paymentType == 2}
        payments.remove(at: indexpath.row)
        if defaultPayment.count > 0 {
            payments.insert(defaultPayment.first!, at: 0)
        }
        self.showPopup(with: "Bạn có chắc muốn huỷ giao dịch này", titleButton: "Xác nhận", isshowClose: true) {
            self.addRemoveCard(isAdd: false, listPayMent: payments)
        }
        completon(true)
      }
      return action
    }
}
