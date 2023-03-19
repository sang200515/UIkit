//
//  DetailGalaxyHistoryViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 9/20/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import PopupDialog
class DetailGalaxyHistoryViewController: UIViewController {
    
    // MARK: - Properties
    private var sum = 0
    var itemGalaxyPay:OrderHistoryGalaxyPlay?
    var orct:OrctGalaxyPay?
    private let btnCheck: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(netHex:0x00955E)
        button.setTitle("In Phiếu", for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handlePrint), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.title = "Thanh toán"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
        
        view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        
        let label = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label.text = "THÔNG TIN KHÁCH HÀNG"
        label.textColor = UIColor(netHex:0x00955E)
        label.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        view.addSubview(label)
        
        let viewInfoCustomer = UIView(frame: CGRect(x: 0, y: label.frame.size.height + label.frame.origin.y, width: view.frame.size.width, height: view.frame.size.height))
        viewInfoCustomer.backgroundColor = .white
        view.addSubview(viewInfoCustomer)
        
        let lblMPOS = Common.tileLabel(x: Common.Size(s:10), y: Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Số MPOS",isBoldStyle: true)
        viewInfoCustomer.addSubview(lblMPOS)
        
        let lblMPOSValue = Common.tileLabel(x: Common.Size(s:10), y: lblMPOS.frame.origin.y, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "\(itemGalaxyPay?.docentry ?? "")",isBoldStyle: true)
        lblMPOSValue.textAlignment = .right
        lblMPOSValue.textColor = UIColor(netHex:0x00955E)
        viewInfoCustomer.addSubview(lblMPOSValue)
        
        let lblGoiCuoc = Common.tileLabel(x: Common.Size(s:10), y: lblMPOS.frame.size.height + lblMPOS.frame.origin.y + Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "")
        viewInfoCustomer.addSubview(lblGoiCuoc)
        
        let lblGoiCuocValue = Common.tileLabel(x: Common.Size(s:10), y: lblGoiCuoc.frame.origin.y, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "\(itemGalaxyPay?.productname ?? "")")
        lblGoiCuocValue.textAlignment = .right
        viewInfoCustomer.addSubview(lblGoiCuocValue)
        
        
        let lblPrice = Common.tileLabel(x: Common.Size(s:10), y: lblGoiCuoc.frame.size.height + lblGoiCuoc.frame.origin.y + Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Gía bán")
        viewInfoCustomer.addSubview(lblPrice)
        
        let lblPriceValue = Common.tileLabel(x: Common.Size(s:10), y: lblPrice.frame.origin.y, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "\(Common.convertCurrencyDoubleV2(value: itemGalaxyPay?.Doctotal ?? 0))đ")
        lblPriceValue.textAlignment = .right
        lblPriceValue.textColor = .red
        viewInfoCustomer.addSubview(lblPriceValue)
        
        
        let lblNCC = Common.tileLabel(x: Common.Size(s:10), y: lblPrice.frame.size.height + lblPrice.frame.origin.y + Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Nhà cung cấp")
        viewInfoCustomer.addSubview(lblNCC)
        
        let lblNCCValue = Common.tileLabel(x: Common.Size(s:10), y: lblNCC.frame.origin.y, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "\(itemGalaxyPay?.NhaCC ?? "")")
        lblNCCValue.textAlignment = .right
        viewInfoCustomer.addSubview(lblNCCValue)
        
        let lblNgayGD = Common.tileLabel(x: Common.Size(s:10), y: lblNCC.frame.size.height + lblNCC.frame.origin.y + Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Ngày giao dịch")
        viewInfoCustomer.addSubview(lblNgayGD)
        
        let lblNgayGDValue = Common.tileLabel(x: Common.Size(s:10), y: lblNgayGD.frame.origin.y, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "\(itemGalaxyPay?.ngaygiaodich ?? "")")
        lblNgayGDValue.textAlignment = .right
        viewInfoCustomer.addSubview(lblNgayGDValue)
        
        let lblNV = Common.tileLabel(x: Common.Size(s:10), y: lblNgayGD.frame.size.height + lblNgayGD.frame.origin.y + Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "NV Giao dịch")
        viewInfoCustomer.addSubview(lblNV)
        
        let lblNVValue = Common.tileLabel(x: Common.Size(s:10), y: lblNV.frame.origin.y, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "\(itemGalaxyPay?.EmployeeName ?? "")")
        lblNVValue.textAlignment = .right
        viewInfoCustomer.addSubview(lblNVValue)
        
        let lblPhone = Common.tileLabel(x: Common.Size(s:10), y: lblNV.frame.size.height + lblNV.frame.origin.y + Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Số điện thoại")
        viewInfoCustomer.addSubview(lblPhone)
        
        let lblPhoneValue = Common.tileLabel(x: Common.Size(s:10), y: lblPhone.frame.origin.y, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "\(itemGalaxyPay?.Phonenumber ?? "")")
        lblPhoneValue.textAlignment = .right
        viewInfoCustomer.addSubview(lblPhoneValue)
        
        viewInfoCustomer.frame.size.height = lblPhone.frame.size.height + lblPhone.frame.origin.y + Common.Size(s:10)
        
        let labelTTTT = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewInfoCustomer.frame.size.height + viewInfoCustomer.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labelTTTT.text = "THÔNG TIN THANH TOÁN"
        labelTTTT.textColor = UIColor(netHex:0x00955E)
        labelTTTT.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        view.addSubview(labelTTTT)
        
        let viewTTTT = UIView(frame: CGRect(x: 0, y: labelTTTT.frame.size.height + labelTTTT.frame.origin.y, width: view.frame.size.width, height: view.frame.size.height))
        viewTTTT.backgroundColor = .white
        view.addSubview(viewTTTT)
        
        let lblCash = Common.tileLabel(x: Common.Size(s:10), y: Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Tiền mặt")
        viewTTTT.addSubview(lblCash)
        
        let lblCashValue = Common.tileLabel(x: Common.Size(s:10), y: lblMPOS.frame.origin.y, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "\(Common.convertCurrencyV2(value: orct?.U_MoCash ?? 0))đ")
        lblCashValue.textAlignment = .right
        lblCashValue.textColor = .red
        viewTTTT.addSubview(lblCashValue)
        
        let lblCard = Common.tileLabel(x: Common.Size(s:10), y: lblCash.frame.size.height + lblCash.frame.origin.y + Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Tiền thẻ")
        viewTTTT.addSubview(lblCard)
        
        let lblCardValue = Common.tileLabel(x: Common.Size(s:10), y: lblCard.frame.origin.y, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "\(Common.convertCurrencyV2(value: orct?.U_MoCCad ?? 0))đ")
        lblCardValue.textAlignment = .right
        viewTTTT.addSubview(lblCardValue)
        
        let lblFee = Common.tileLabel(x: Common.Size(s:10), y: lblCard.frame.size.height + lblCard.frame.origin.y + Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Phí thẻ")
         viewTTTT.addSubview(lblFee)
         
        let lblFeeValue = Common.tileLabel(x: Common.Size(s:10), y: lblFee.frame.origin.y, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "\(Common.convertCurrencyV2(value: orct?.totalcardfee ?? 0))đ")
        lblFeeValue.textAlignment = .right
        viewTTTT.addSubview(lblFeeValue)
        
        
        let lblNameCard = Common.tileLabel(x: Common.Size(s:10), y: lblFee.frame.size.height + lblFee.frame.origin.y + Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Tên thẻ")
        viewTTTT.addSubview(lblNameCard)
        
        let lblNameCardValue = Common.tileLabel(x: Common.Size(s:10), y: lblNameCard.frame.origin.y, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "\(orct?.namecard ?? "")")
        lblNameCardValue.textAlignment = .right
        viewTTTT.addSubview(lblNameCardValue)
        
        
        let lblSum = Common.tileLabel(x: Common.Size(s:10), y: lblNameCard.frame.size.height + lblNameCard.frame.origin.y + Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Tổng tiền")
        viewTTTT.addSubview(lblSum)
        
        sum = Int(itemGalaxyPay?.Doctotal ?? 0) + Int(orct?.totalcardfee ?? 0)
        let lblSumValue = Common.tileLabel(x: Common.Size(s:10), y: lblSum.frame.origin.y, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "\(Common.convertCurrencyV2(value: sum))đ")
        lblSumValue.textAlignment = .right
        lblSumValue.textColor = .red
        viewTTTT.addSubview(lblSumValue)
        
        viewTTTT.frame.size.height = lblSum.frame.size.height + lblSum.frame.origin.y + Common.Size(s:10)
        
        self.view.addSubview(btnCheck)
        btnCheck.anchor(left:view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 12,paddingRight: 12)
        btnCheck.setDimensions(width: self.view.frame.width - Common.Size(s:30), height: Common.Size(s:40))
    }
    
    // MARK: - API
    
    func fetchAPIPrintBill(){
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        
        let billParamGalaxyPay = BillParamGalaxyPay(BillCode: "\(self.itemGalaxyPay?.crm_SalesOrderCode ?? "")", TransactionCode: "\(self.itemGalaxyPay?.docentry ?? "")",
            ThoiGianThu: dateString
            , ServiceName: "Giải trí"
            , ProVideName: "Galaxy Play"
            , PayerMobiphone: "\(self.itemGalaxyPay?.Phonenumber ?? "")"
            , GoiDichVu: "\(self.itemGalaxyPay?.productname ?? "")"
            , ThoiHanGoi: ""
            , GiaGoi: "\(Common.convertCurrencyDoubleV2(value: self.itemGalaxyPay?.Doctotal ?? 0))"
            , Paymentfee: "\(Common.convertCurrencyV2(value: orct?.totalcardfee ?? 0))"
            , TotalAmouth: "\(Common.convertCurrencyDoubleV2(value: self.itemGalaxyPay?.Doctotal ?? 0))"
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
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func handlePrint(){
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
}
