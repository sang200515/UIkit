//
//  DetailOrderVC.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 31/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Presentr

class DetailOrderVC: BaseController {
    
    //MARK: IBOULET
    //Contract info
    @IBOutlet weak var numberContractLabel: UILabel!
    @IBOutlet weak var appIDLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var deliverTypeLabel: UILabel!
    
    //User info
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idNumberLabel: UILabel!
    
    //Order info & discount info
    @IBOutlet weak var orderInfoTableView: UITableView!
    @IBOutlet weak var infoTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var promotionTableView: UITableView!
    @IBOutlet weak var promotionTableViewHeight: NSLayoutConstraint!
    
    //Payment info
    @IBOutlet weak var installmentPackLabel: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var timePayInterestLabel: UILabel!
    @IBOutlet weak var coverFeeLabel: UILabel!
    @IBOutlet weak var toMoneyLabel: UILabel!
    @IBOutlet weak var moneyPayBeforeLabel: UILabel!
    @IBOutlet weak var moneyRentLabel: UILabel!
    @IBOutlet weak var disCountLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var laisuatLabel: UILabel!
    @IBOutlet weak var khoanVayLabel: UILabel!
    
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var confirmImeiButton: UIButton!
    @IBOutlet weak var cancelOrderButton: UIButton!
    @IBOutlet weak var confirmOrderButton: UIButton!
    
    var handingItem: OrderNewItem?
    var detailOrder: InstallmentOrderData?
    var docEntryHistory = ""
    var imeiSelected = ""
    
    let presenter: Presentr = {
        let dynamicType = PresentationType.dynamic(center: ModalCenterPosition.center)
        let customPresenter = Presentr(presentationType: dynamicType)
        customPresenter.backgroundOpacity = 0.3
        customPresenter.roundCorners = true
        customPresenter.dismissOnSwipe = false
        customPresenter.dismissAnimated = false
        customPresenter.transitionType = .crossDissolve
        return customPresenter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        promotionTableView.dataSource = self
        promotionTableView.delegate = self
        promotionTableView.register(UINib(nibName: "PromotionInfoCell", bundle: nil), forCellReuseIdentifier: "PromotionInfoCell")
        orderInfoTableView.dataSource = self
        orderInfoTableView.delegate = self
        orderInfoTableView.register(UINib(nibName: "OrderInfoCellTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderInfoCellTableViewCell")
        getDetail()
    }
    
    func getDetail() {
        if docEntryHistory != "" {
            getOrderHistory()
        } else {
            getOrderDetail()
        }
    }
    
    func getOrderHistory() {
        var params: [String: Any] = [:]
        params["employeeCode"] = Cache.user?.UserName ?? ""
        params["shopCode"] = Cache.user?.ShopCode ?? ""
        params["docEntry"] = docEntryHistory
        params["isDetail"] = true
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "") {
            InstallmentApiManager.shared.getInstallmentHistory(params: params) {[weak self] (_, detailHistory, error) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if error != "" {
                        self?.showPopup(with: error, completion: {
                            self?.actionBack()
                        })
                    } else {
                        if let detail = detailHistory {
                            if detail.isSuccess {
                                self?.detailOrder = detail.data.first
                                self?.bindata()
                                if let info = detail.data.first?.otherInfos {
                                    self?.bindBottomButton(with: info)
                                }
                            } else {
                                self?.showPopup(with: detail.message , completion: {
                                    self?.actionBack()
                                })
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getOrderDetail() {
        var params: [String: Any] = [:]
        params["employeeCode"] = Cache.user?.UserName
        params["shopCode"] = Cache.user?.ShopCode
        params["soNumber"] = handingItem?.PosSoNum
        params["shipType"] = handingItem?.ShipType
        params["contractNumber"] = handingItem?.ContractNumber
        params["schemeCode"] = handingItem?.SchemeCode
        params["schemeName"] = handingItem?.SchemeName
        params["applicationId"] = handingItem?.ApplicationId
        params["ecomNum"] = handingItem?.EcomNum

        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "") {
            InstallmentApiManager.shared.getInstallmentDetail(params: params) {[weak self] (detail, error) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if error != "" {
                        self?.showPopup(with: error, completion: {
                            self?.actionBack()
                        })
                    } else {
                        if detail?.isSuccess ?? false {
                            self?.detailOrder = detail?.data
                            self?.bindata()
                            if let info = detail?.data.otherInfos {
                                self?.bindBottomButton(with: info)
                            }
                        } else {
                            self?.showPopup(with: detail?.message ?? "", completion: {
                                self?.actionBack()
                            })
                        }
                    }
                }
            }
        }
    }
    
    func bindata() {
        //contract info
        self.title = "Chi tiết đơn hàng \(detailOrder?.otherInfos.PosSoNum ?? "")"
        self.numberContractLabel.text = detailOrder?.header.contractNumber
        self.appIDLabel.text = detailOrder?.header.ApplicationId
        self.createdDateLabel.text = detailOrder?.header.createdDate.toNewStrDate()
        self.deliverTypeLabel.text = detailOrder?.header.shipType == "2" ? "Giao tại shop" : "Giao tại nhà"
        
        //customer info
        self.phoneLabel.text = detailOrder?.customer.phoneNumber
        self.addressLabel.text = detailOrder?.customer.address
        self.nameLabel.text = detailOrder?.customer.fullName
        self.idNumberLabel.text = detailOrder?.customer.cMND
        
        reloadTableView()
        //payment info
        
        installmentPackLabel.text = detailOrder?.payment.schemeName
        timePayInterestLabel.text = "\(detailOrder?.payment.tenure ?? 0) tháng"
        moneyPayBeforeLabel.text = "\(Common.convertCurrencyDouble(value: Double(detailOrder?.payment.downPayment ?? 0))) đ"
        disCountLabel.text = "\(Common.convertCurrencyDouble(value: Double(detailOrder?.payment.discount.removeSubNum() ?? 0))) đ"
        totalMoneyLabel.text = "\(Common.convertCurrencyDouble(value: Double(detailOrder?.payment.total.removeSubNum() ?? 0))) đ"
        laisuatLabel.text = "\(detailOrder?.payment.InterestRate ?? 0) %/tháng"
        khoanVayLabel.text = "\(Common.convertCurrencyDouble(value: Double(detailOrder?.payment.LoanAmount.removeSubNum() ?? 0))) đ"
        //contract info
    }
    private func setupNav() {
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(DetailOrderVC.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
    }
    
    private func reloadTableView() {
        promotionTableView.reloadData()
        orderInfoTableView.reloadData()
        infoTableViewHeight.constant = 100.0
        promotionTableViewHeight.constant = CGFloat((detailOrder?.promotions.count ?? 0) * 150)
        
        UIView.animate(withDuration: 0, animations: {
        }) { (complete) in
            var promoHeightOfTableView: CGFloat = 0.0
            // Get visible cells and sum up their heights
            let promoCells = self.promotionTableView.visibleCells
            for cell in promoCells {
                promoHeightOfTableView += cell.frame.height
            }
            // Edit heightOfTableViewConstraint's constant to update height of table view
            self.promotionTableViewHeight.constant = promoHeightOfTableView
            
            var orderHeightOfTableView: CGFloat = 0.0
            // Get visible cells and sum up their heights
            let orderCells = self.orderInfoTableView.visibleCells
            for cell in orderCells {
                orderHeightOfTableView += cell.frame.height
            }
            
            self.infoTableViewHeight.constant = orderHeightOfTableView
        }
        
    }
    
    func bindBottomButton(with info: InstallmentOtherInfos) {
        guard let order = detailOrder else {
            print("detail is nil")
            return
        }
        self.confirmImeiButton.isHidden = order.Buttons.UpdateImeiBtn ? false : true
        self.takePhotoButton.isHidden = order.Buttons.CheckEkycBtn ? false : true
        self.cancelOrderButton.isHidden = order.Buttons.CancelBtn ? false : true
    }
    
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: IBATION
    @IBAction func conirmImeiAction(_ sender: Any) {
        if detailOrder?.product.imei == "" {
            let popup = PopupVC()
            popup.onOKAction = {
                print("OK selected")
            }
            popup.dataPopup.content = "Bạn vui lòng chọn IMEI trước khi nhấn xác nhận"
            popup.modalPresentationStyle = .overCurrentContext
            popup.modalTransitionStyle = .crossDissolve
            self.present(popup, animated: true, completion: nil)
            return
        }
         var params = [String: Any]()
         params["employeeCode"] = Cache.user?.UserName
         params["shopCode"] = Cache.user?.ShopCode
        params["imei"] = detailOrder?.product.imei
        params["applicationId"] = detailOrder?.otherInfos.applicationId
         params["docEntry"] = detailOrder?.otherInfos.docEntry
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "") {
            InstallmentApiManager.shared.updateImei(params: params) {[weak self] (updateRes, error) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if error != "" {
                        self?.showPopup(with: error, completion: nil)
                    } else {
                        if updateRes?.isSuccess ?? false {
                            self?.showPopup(with: updateRes?.message ?? "", completion: {
                               self?.getDetail()
                            })
                        } else {
                            self?.showPopup(with: updateRes?.message ?? "", completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func takePhotosAction(_ sender: Any) {
        let vc = TakeCustomerPhotoVC()
        vc.detailOrder = detailOrder
        vc.onUpdateSuccess = {
            self.getDetail()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func confirmOrderAction(_ sender: Any) {
        var params: [String: Any] = [:]
        params["employeeCode"] = Cache.user!.UserName
        params["shopCode"] = Cache.user!.ShopCode
        params["nationalId"] = self.detailOrder?.customer.cMND
        params["statusCode"] = "DELI"
        params["applicationId"] = self.detailOrder?.otherInfos.applicationId
        params["docEntry"] = self.detailOrder?.otherInfos.docEntry
        InstallmentApiManager.shared.updateConstractStatus(params: params) { [weak self] (reponse, error) in
            if error != "" {
                self?.showPopup(with: error, completion: nil)
            } else {
                if let res = reponse {
                    if res.isSuccess {
                        self?.showPopup(with: res.message, completion: {
                            self?.actionBack()
                            NotificationCenter.default.post(name: NSNotification.Name("ReloadListInstallMent"), object: nil)
                        })
                    } else {
                        self?.showPopup(with: res.message, completion: nil)
                    }
                }
            }
        }
    }
    
    
    @IBAction func cancelOrder(_ sender: Any) {
        if detailOrder?.otherInfos.DocStatus == "H" {
            self.showPopup(with: "Bạn không thể hủy đơn hàng vì đơn hàng đã bị hủy", completion: nil)
            return
        } else if detailOrder?.otherInfos.DocStatus == "F" {
            self.showPopup(with: "Bạn không thể hủy đơn hàng vì đơn hàng đã Hoàn tất", completion: nil)
            return
        } else {
            let popup = PopupCancelOrder()
            popup.modalPresentationStyle = .overCurrentContext
            popup.modalTransitionStyle = .crossDissolve
            
            popup.oncancel = { [weak self] (reason, statusCode) in
                guard let self = self else {return}
                if reason.trim() == "" {
                    self.showPopup(with: "Lý do không được để trống, vui lòng thử lại!", completion: nil)
                    return
                }
                var params: [String: Any] = [:]
                
                params["employeeCode"] = Cache.user!.UserName
                params["shopCode"] = Cache.user!.ShopCode
                params["nationalId"] = self.detailOrder?.customer.cMND
                params["statusCode"] = statusCode
                params["applicationId"] = self.detailOrder?.otherInfos.applicationId
                params["cancelReason"] = reason
                params["docEntry"] = self.detailOrder?.otherInfos.docEntry
                WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Hủy đơn hàng") {
                    InstallmentApiManager.shared.updateConstractStatus(params: params) { [weak self] (reponse, error) in
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            if error != "" {
                                self?.showPopup(with: error, completion: nil)
                            } else {
                                if let res = reponse {
                                    if res.isSuccess {
                                        self?.showPopup(with: res.message, completion: {
                                            self?.actionBack()
                                            NotificationCenter.default.post(name: NSNotification.Name("ReloadListInstallMent"), object: nil)
                                        })
                                    } else {
                                        self?.showPopup(with: res.message, completion: nil)
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
            
            
            popup.ondisMiss = {
                print("không huỷ nữa")
            }
            self.present(popup, animated: true, completion: nil)
        }
        
    }
    
}


extension DetailOrderVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == promotionTableView ? detailOrder?.promotions.count ?? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == promotionTableView {
            let cell = promotionTableView.dequeueReusableCell(withIdentifier: "PromotionInfoCell", for: indexPath) as! PromotionInfoCell
            if let item = detailOrder?.promotions[indexPath.row] {
                cell.bindCell(item: item, index: indexPath)
            }
            return cell
        } else {
            let cell = orderInfoTableView.dequeueReusableCell(withIdentifier: "OrderInfoCellTableViewCell", for: indexPath) as! OrderInfoCellTableViewCell
            if let item = detailOrder {
                cell.bindCell(item: item)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == orderInfoTableView && detailOrder!.Buttons.UpdateImeiBtn {
            let popup = SelectImeiPopup()
            popup.onUpdate = {[weak self] imei in
                self?.detailOrder?.product.imei = imei
                self?.reloadTableView()
            }
            popup.detailOrder = detailOrder
            popup.view.backgroundColor = .clear
            popup.productCode = detailOrder?.product.code ?? ""
            popup.modalPresentationStyle = .overCurrentContext
            popup.modalTransitionStyle = .crossDissolve
            self.present(popup, animated: true, completion: nil)
        }
    }
}


extension Double {
    func  removeSubNum() -> Double {
        return Double(String(format: "%.0f", self)) ?? 0
    }
}

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    var cleanAfterDot: Float {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.numberStyle = .decimal
        
        let strValue = formatter.string(from: self as NSNumber) ?? "0"
        return Float(strValue.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: ".", with: "")) ?? 0
    }
}
