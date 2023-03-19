//
//  HistoryViettelPackageDetail.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 06/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import PopupDialog

class HistoryViettelPackageDetail: UIViewController {
    
    @IBOutlet weak var mposNumberLabel: UILabel!
    @IBOutlet weak var cusNumber: UILabel!
    @IBOutlet weak var packNameLabel: UILabel!
    @IBOutlet weak var packCostValue: UILabel!
    @IBOutlet weak var nccLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var emPloyeeLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var stateLabel2: UILabel!
    @IBOutlet weak var shopLabel: UILabel!
    @IBOutlet weak var moneyMustPayLabel: UILabel!
    @IBOutlet weak var disCountMoneyLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var cardAmountLabel: UILabel!
    @IBOutlet weak var meyAmountLabel: UILabel!
    @IBOutlet weak var moneyButton: UIButton!
    @IBOutlet weak var cardButton: UIButton!
    @IBOutlet weak var feeLabel: UILabel!
    
    var idTransaction: String = ""
    var currentOrder: ViettelPayOrder?
    var feeValue = ""
    var isBacktoPre = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Lịch sử chi tiết gói cước Viettel hiện hữu"
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(backAction), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        CRMAPIManager.ViettelPay_SOM_GetOrderInfo(orderId: "\(self.idTransaction)") { [weak self] (rs, err) in
            if err.count <= 0 {
                if rs != nil {
                    self?.currentOrder = rs
                    self?.bindDataWith(object: rs!)
                } else {
                    let alert = UIAlertController(title: "Thông báo", message: "Error: Không có data!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (_) in
                        
                    }
                    alert.addAction(action)
                    self?.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self?.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    func bindDataWith(object: ViettelPayOrder) {
        mposNumberLabel.text = object.billNo
        emPloyeeLabel.text = object.employeeName
        cusNumber.text = object.orderTransactionDtos.first?.productCustomerPhoneNumber
        packNameLabel.text =  object.orderTransactionDtos.first?.productName
        packCostValue.text =  "\(Common.convertCurrencyDoubleV2(value: object.orderTransactionDtos.first?.totalAmount ?? 0))đ"
        nccLabel.text = "Viettel"
        dateTimeLabel.text = Common.convertDateISO8601(dateString: object.creationTime)
        shopLabel.text = object.warehouseAddress
        disCountMoneyLabel.text = "0đ"
        if let statusCode = CreateOrderResultViettelPay_SOM(rawValue: object.orderStatus) {
            stateLabel.text = statusCode.message
        } else {
            stateLabel.text = "Không tìm thấy trạng thái giao dịch tương ứng code \(object.orderStatus)"
        }
        uiWith(object: object)
        
    }
    
    func uiWith(object: ViettelPayOrder) {
        let filterType1 = object.payments.filter{$0.paymentType == 1}
        let filterType2 = object.payments.filter{$0.paymentType == 2}
        if filterType1.count > 0 && filterType1.first?.paymentValue ?? 0 > 0 {  // money
            moneyButton.setImage(UIImage(named: "check-1-1"), for: .normal)
            meyAmountLabel.text = "\(Common.convertCurrencyDoubleV2(value: filterType1.first?.paymentValue ?? 0))đ"
        } else { // card
            meyAmountLabel.text = "0đ"
            moneyButton.setImage(UIImage(named: "check-2-1"), for: .normal)
        }
        
        
        if filterType2.count > 0 && filterType2.filter({$0.paymentValue > 0}).count > 0 {
            cardButton.setImage(UIImage(named: "check-1-1"), for: .normal)
            var value: Double = 0
            var fee: Double = 0
            filterType2.forEach { (object) in
                value += object.paymentValue
                fee += object.paymentExtraFee
            }
            feeLabel.text = "\(Common.convertCurrencyDoubleV2(value: fee))đ"
            self.feeValue = fee.removeZerosFromEnd()
            cardAmountLabel.text = "\(Common.convertCurrencyDoubleV2(value: value))đ"
        } else { // card
            feeLabel.text = "0đ"
            cardAmountLabel.text = "0đ"
            cardButton.setImage(UIImage(named: "check-2-1"), for: .normal)
        }
        self.packCostValue.text = "\(Common.convertCurrencyDoubleV2(value: object.orderTransactionDtos.first?.price ?? 0))đ"
        self.totalMoneyLabel.text = "\(Common.convertCurrencyDoubleV2(value: object.orderTransactionDtos.first?.price ?? 0))đ"
        moneyMustPayLabel.text = "\(Common.convertCurrencyDoubleV2(value: object.orderTransactionDtos.first?.totalAmountIncludingFee ?? 0))đ"
    }
    
    @objc func backAction() {
        if isBacktoPre {
            self.navigationController?.popViewController(animated: true)
            return
        }
        for vc in self.navigationController?.viewControllers ?? [] {
            if vc is MenuViettelVASViewController {
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    
    
    @IBAction func cardAction(_ sender: Any) {
        
    }
    
    @IBAction func moneyAction(_ sender: Any) {
        
    }
    
    @IBAction func printAction(_ sender: Any) {
        
        let title = "Thông báo"
        let popup = PopupDialog(title: title, message: "Bạn muốn in bill?", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
            print("Completed")
        }
        
        let buttonOne = DefaultButton(title: "In") {
            
            let printBillThuHoLC = BillParamViettelPay(BillCode:"\(self.currentOrder?.billNo ?? "")"
                                                       , TransactionCode:"\(self.currentOrder?.orderTransactionDtos.first?.transactionCode ?? "")"
                                                       , ServiceName:""
                                                       , ProVideName: "Viettel"
                                                       , Customernamne: "\(self.currentOrder?.customerName ?? "")"
                                                       , Customerpayoo:""
                                                       , PayerMobiphone: self.currentOrder?.customerPhoneNumber ?? ""
                                                       , Address:""
                                                       , BillID:""
                                                       , Month:""
                                                       , TotalAmouth: self.currentOrder?.orderTransactionDtos.first?.totalAmount.removeZerosFromEnd() ?? "0"
                                                       , Paymentfee: self.feeValue
                                                       , Employname: "\(Cache.user?.UserName ?? "") - \(Cache.user?.EmployeeName ?? "")"
                                                       , Createby:"\(Cache.user?.UserName ?? "")"
                                                       , MaVoucher:""
                                                       , HanSuDung:""
                                                       , ShopAddress:"\(Cache.user?.Address ?? "")"
                                                       , ThoiGianXuat: "\(Common.convertDateISO8601(dateString: self.currentOrder?.creationTime ?? ""))"
                                                       , PhiCaThe: self.feeValue
                                                       , dichVu: ""
                                                       , NhaCungCap: "Viettel"
                                                       , GoiDichVu: self.packNameLabel.text ?? ""
                                                       , GiaGoi: self.currentOrder?.orderTransactionDtos.first?.totalAmount.removeZerosFromEnd() ?? "0")
            printBillThuHoLC.desService = "Gói cước Viettel"
            MPOSAPIManager.pushBillThuHoViettelPay(printBill: printBillThuHoLC, title: "thu hộ")
            
            let alert = UIAlertController(title: "Thông báo", message: "Đã gửi lệnh in!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                self.navigationController?.popToRootViewController(animated: true)
            })
            self.present(alert, animated: true)
        }
        let buttonTwo = CancelButton(title: "Không"){
            
        }
        popup.addButtons([buttonOne,buttonTwo])
        self.present(popup, animated: true, completion: nil)
        
    }
}
