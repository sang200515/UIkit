//
//  DetailGalaxyPayViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 9/17/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import PopupDialog
class DetailGalaxyPayViewController: UIViewController {
    
    // MARK: - Properties
    private var sum = 0
    var resultInsertGalaxyPay: ResultInsertGalaxyPay?
    var phone:String?

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.title = "Thanh toán"
        self.navigationItem.setHidesBackButton(true, animated:true)
        print("DEBUG: View Did Load call")
        configureNavigationItem()
        configureUI()

    }
    // MARK: - API
    func fetchAPIPrintBill(){
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        
        let billParamGalaxyPay = BillParamGalaxyPay(BillCode: "\(self.resultInsertGalaxyPay?.crm_SalesOrderCode ?? "")",
                                                    TransactionCode: "\(self.resultInsertGalaxyPay?.Docentry ?? 0)",
            ThoiGianThu: dateString
            , ServiceName: "Giải trí"
            , ProVideName: "Galaxy Play"
            , PayerMobiphone: "\(self.resultInsertGalaxyPay?.Phonenumber ?? "")"
            , GoiDichVu: "\(self.resultInsertGalaxyPay?.productname ?? "")"
            , ThoiHanGoi: ""
            , GiaGoi: "\(Common.convertCurrencyV2(value: self.resultInsertGalaxyPay?.Doctotal ?? 0))"
            , Paymentfee: "\(Common.convertCurrencyV2(value: self.resultInsertGalaxyPay?.total_credit_fee ?? 0))"
            , TotalAmouth: "\(Common.convertCurrencyV2(value: self.resultInsertGalaxyPay?.Doctotal ?? 0))"
            , HanSuDung: ""
            , Employname:Cache.user?.EmployeeName ?? ""
            , Createby: Cache.user?.UserName ?? ""
            , ShopAddress: Cache.user?.Address ?? ""
            , MaVoucher: "")
        CRMAPIManager.pushBillThuHoGalaxyPay(printBill: billParamGalaxyPay)
        let alert = UIAlertController(title: "Thông báo", message: "Đã gửi lệnh in!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        })
        self.present(alert, animated: true)
    }
    
    
    // MARK: - Selectors
    @objc func handleBack(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func handlePrintBill(){
        let title = "Thông báo"
        let popup = PopupDialog(title: title, message: "Bạn muốn in bill?", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
            print("Completed")
        }
        let buttonOne = DefaultButton(title: "In") {
            
            self.fetchAPIPrintBill()
            
   
        }
        let buttonTwo = CancelButton(title: "Không"){
            
        }
        popup.addButtons([buttonOne,buttonTwo])
        self.present(popup, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func configureNavigationItem(){
        //left menu icon
        let btLeftIcon = Common.initBackButton()
        btLeftIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
    }
    
    func configureUI(){
        view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        
        let label = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label.text = "THÔNG TIN THANH TOÁN"
        label.textColor = UIColor(netHex:0x00955E)
        label.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        view.addSubview(label)
        
        let viewPayment = UIView(frame: CGRect(x: 0, y: label.frame.size.height + label.frame.origin.y, width: view.frame.size.width, height: view.frame.size.height))
        viewPayment.backgroundColor = .white
        view.addSubview(viewPayment)
        
        
        let lblMPOS = Common.tileLabel(x: Common.Size(s:10), y: Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Số MPOS")
        viewPayment.addSubview(lblMPOS)
        
        let lblMPOSValue = Common.tileLabel(x: Common.Size(s:10), y: Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "\(resultInsertGalaxyPay?.Docentry ?? 0)")
        lblMPOSValue.textAlignment = .right
        viewPayment.addSubview(lblMPOSValue)
        
        let lblNCC = Common.tileLabel(x: Common.Size(s:10), y: lblMPOS.frame.size.height + lblMPOS.frame.origin.y + Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Nhà cung cấp")
        viewPayment.addSubview(lblNCC)
        
        let lblNCCValue = Common.tileLabel(x: Common.Size(s:10), y:lblNCC.frame.origin.y, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "\(resultInsertGalaxyPay?.NhaCC ?? "")")
        lblNCCValue.textAlignment = .right
        viewPayment.addSubview(lblNCCValue)
        
        let lblPhone = Common.tileLabel(x: Common.Size(s:10), y: lblNCC.frame.size.height + lblNCC.frame.origin.y + Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Số điện thoại")
        viewPayment.addSubview(lblPhone)
        
        let lblPhoneValue = Common.tileLabel(x: Common.Size(s:10), y:lblPhone.frame.origin.y, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "\(resultInsertGalaxyPay?.Phonenumber ?? phone ?? "")")
        lblPhoneValue.textAlignment = .right
        viewPayment.addSubview(lblPhoneValue)
        
        let lblCash = Common.tileLabel(x: Common.Size(s:10), y: lblPhone.frame.size.height + lblPhone.frame.origin.y + Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Tiền mặt thanh toán")
        viewPayment.addSubview(lblCash)
        
        let lblCashValue = Common.tileLabel(x: Common.Size(s:10), y:lblCash.frame.origin.y, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: Common.convertCurrencyV2(value: resultInsertGalaxyPay?.total_cash ?? 0))
        lblCashValue.textAlignment = .right
        viewPayment.addSubview(lblCashValue)
        
        let lblCard = Common.tileLabel(x: Common.Size(s:10), y: lblCash.frame.size.height + lblCash.frame.origin.y + Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Tiền thẻ thanh toán")
        viewPayment.addSubview(lblCard)
        
        let lblCardValue = Common.tileLabel(x: Common.Size(s:10), y:lblCard.frame.origin.y, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: Common.convertCurrencyV2(value: resultInsertGalaxyPay?.total_credit ?? 0))
        lblCardValue.textAlignment = .right
        viewPayment.addSubview(lblCardValue)
        
        let viewFooter = UIView()
        self.view.addSubview(viewFooter)
        viewFooter.anchor(left:view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 12,paddingRight: 12)
        viewFooter.setDimensions(width: self.view.frame.width, height: Common.Size(s:100))
        
    
        
        let lbSoTienThanhToan = Common.tileLabel(x: 0, y: Common.Size(s: 10), width: view.frame.size.width, height: Common.Size(s: 20), title: "Tổng tiền phải thanh toán",fontSize: Common.Size(s:13))
        viewFooter.addSubview(lbSoTienThanhToan)
        
        
        sum = resultInsertGalaxyPay!.Doctotal + resultInsertGalaxyPay!.total_credit_fee
        let lbSoTienThanhToanValue = Common.tileLabel(x: 0, y: lbSoTienThanhToan.frame.origin.y,width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s: 20), title: Common.convertCurrencyV2(value: sum), fontSize:  Common.Size(s: 13), isBoldStyle: true)
        lbSoTienThanhToanValue.textColor = .red
        lbSoTienThanhToanValue.textAlignment = .right
        viewFooter.addSubview(lbSoTienThanhToanValue)
        
        let btSave = Common.buttonAction(x:0,y: lbSoTienThanhToan.frame.size.height + lbSoTienThanhToan.frame.origin.y, width: view.frame.size.width - Common.Size(s:28), height: Common.Size(s:40), title: "In Phiếu")
        btSave.addTarget(self, action: #selector(handlePrintBill), for: .touchUpInside)
        viewFooter.addSubview(btSave)
    }
    

    
    
}
