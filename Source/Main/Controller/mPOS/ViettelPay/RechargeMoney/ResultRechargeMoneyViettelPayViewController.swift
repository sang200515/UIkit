//
//  ResultRechargeMoneyViettelPayViewController.swift
//  fptshop
//
//  Created by tan on 6/25/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class ResultRechargeMoneyViettelPayViewController: UIViewController {
    
    var scrollView:UIScrollView!
    var viewChuTK:UIView!
    var viewNTT:UIView!
    var viewTTNT:UIView!
    var btPrint:UIButton!
    var orderID = ""
    var itemViettelPaySOMOrder: ViettelPayOrder?
    var statusOrderMessage = ""
    
    override func viewDidLoad() {
        self.title = "Chi tiết giao dịch nạp tiền"
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            CRMAPIManager.ViettelPay_SOM_GetOrderInfo(orderId: "\(self.orderID)") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs != nil {
                            self.itemViettelPaySOMOrder = rs
                            self.setUpView(item: rs!)
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "Error: Không có data!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                self.itemViettelPaySOMOrder =  ViettelPayOrder(orderStatus: 0, orderStatusDisplay: "", billNo: "", customerId: "", referenceSystem: "", referenceValue: "", tenant: "", warehouseCode: "", regionCode: "", ip: "", creationTime: "", creationBy: "", id: "", customerName: "", customerPhoneNumber: "", employeeName: "", warehouseAddress: "", orderTransactionDtos: [], orderHistories: [], payments: [])
                                
                                self.setUpView(item: self.itemViettelPaySOMOrder!)
                            }
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
    
    func setUpView(item: ViettelPayOrder) {
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "THÔNG TIN GIAO DỊCH"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        viewChuTK = UIView()
        viewChuTK.frame = CGRect(x: 0, y:label1.frame.origin.y + label1.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewChuTK.backgroundColor = UIColor.white
        scrollView.addSubview(viewChuTK)
        
//        let lbSoMPOS =  UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10) , width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
//        lbSoMPOS.textAlignment = .left
//        lbSoMPOS.textColor = UIColor.black
//        lbSoMPOS.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lbSoMPOS.text = "Số MPOS: \(item.billNo)"
//        viewChuTK.addSubview(lbSoMPOS)
//
//        let lbSoGDVnPay =  UILabel(frame: CGRect(x: Common.Size(s:15), y:lbSoMPOS.frame.origin.y + lbSoMPOS.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
//        lbSoGDVnPay.textAlignment = .left
//        lbSoGDVnPay.textColor = UIColor.black
//        lbSoGDVnPay.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lbSoGDVnPay.text = "Số GD VTPAY: \(self.cashInDetail?.trans_id_viettel ?? "")"
//        viewChuTK.addSubview(lbSoGDVnPay)
        
        let lbSoPhieu =  UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbSoPhieu.textAlignment = .left
        lbSoPhieu.textColor = UIColor.black
        lbSoPhieu.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoPhieu.text = "Số Phiếu: \(item.billNo)"
        viewChuTK.addSubview(lbSoPhieu)
        
        let lbSoTien =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbSoPhieu.frame.origin.y + lbSoPhieu.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbSoTien.textAlignment = .left
        lbSoTien.textColor = UIColor.black
        lbSoTien.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbSoTien.text = "Số tiền: 0"
        viewChuTK.addSubview(lbSoTien)
        
        let lbPhiGiaoDich =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbSoTien.frame.origin.y + lbSoTien.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbPhiGiaoDich.textAlignment = .left
        lbPhiGiaoDich.textColor = UIColor.black
        lbPhiGiaoDich.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbPhiGiaoDich.text = "Phí Giao Dịch: 0"
        viewChuTK.addSubview(lbPhiGiaoDich)
        
        let lbTongTienTT =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbPhiGiaoDich.frame.origin.y + lbPhiGiaoDich.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTongTienTT.textAlignment = .left
        lbTongTienTT.textColor = UIColor.black
        lbTongTienTT.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbTongTienTT.text = "Tổng tiền: 0"
        viewChuTK.addSubview(lbTongTienTT)
        
        let lbNgayGiaoDich =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbTongTienTT.frame.origin.y + lbTongTienTT.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbNgayGiaoDich.textAlignment = .left
        lbNgayGiaoDich.textColor = UIColor.black
        lbNgayGiaoDich.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        
        lbNgayGiaoDich.text = "Ngày Giao Dịch: \(Common.convertDateISO8601(dateString: item.creationTime))"
        viewChuTK.addSubview(lbNgayGiaoDich)
        
        let lbNoiDung =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbNgayGiaoDich.frame.origin.y + lbNgayGiaoDich.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbNoiDung.textAlignment = .left
        lbNoiDung.textColor = UIColor.black
        lbNoiDung.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbNoiDung.text = "Nội Dung: "
        viewChuTK.addSubview(lbNoiDung)
        
        let lbTrangThai =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbNoiDung.frame.origin.y + lbNoiDung.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTrangThai.textAlignment = .left
        lbTrangThai.textColor = UIColor.init(netHex: 0x3399CC)
        lbTrangThai.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbTrangThai.text = "Trạng thái: "
        viewChuTK.addSubview(lbTrangThai)
        
        let statusCode = CreateOrderResultViettelPay_SOM(rawValue: item.orderStatus)
        lbTrangThai.text = "Trạng thái: \(statusCode?.message ?? "")"
        
        let lbTrangThaiHeight:CGFloat = lbTrangThai.optimalHeight < Common.Size(s:14) ? Common.Size(s:14) : lbTrangThai.optimalHeight
        lbTrangThai.numberOfLines = 0
        lbTrangThai.frame = CGRect(x: lbTrangThai.frame.origin.x, y: lbTrangThai.frame.origin.y, width: lbTrangThai.frame.width, height: lbTrangThaiHeight)
        
        if item.orderStatus == 2 {
            lbTrangThai.textColor = UIColor(netHex: 0x4fa845)
        } else  if item.orderStatus == 3 {
            lbTrangThai.textColor = .red
        } else {
            lbTrangThai.textColor = .blue
        }
        
        viewChuTK.frame.size.height = lbTrangThai.frame.origin.y + lbTrangThai.frame.size.height + Common.Size(s: 10)
        
        
        let label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewChuTK.frame.origin.y + viewChuTK.frame.size.height , width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label2.text = "THÔNG TIN CHỦ TÀI KHOẢN VIETTEL PAY"
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label2)
        
        viewNTT = UIView()
        viewNTT.frame = CGRect(x: 0, y:label2.frame.origin.y + label2.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewNTT.backgroundColor = UIColor.white
        scrollView.addSubview(viewNTT)
        
        let lbPhone =  UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbPhone.textAlignment = .left
        lbPhone.textColor = UIColor.black
        lbPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPhone.text = "Số điện thoại: "
        viewNTT.addSubview(lbPhone)
        
        let lbHoTen =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbPhone.frame.origin.y + lbPhone.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHoTen.textAlignment = .left
        lbHoTen.textColor = UIColor.black
        lbHoTen.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHoTen.text = "Họ tên: "
        viewNTT.addSubview(lbHoTen)
        viewNTT.frame.size.height = lbHoTen.frame.size.height + lbHoTen.frame.origin.y + Common.Size(s: 10)
        
        let label3 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewNTT.frame.origin.y + viewNTT.frame.size.height , width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label3.text = "THÔNG TIN NGƯỜI THANH TOÁN"
        label3.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label3)
        
        viewTTNT = UIView()
        viewTTNT.frame = CGRect(x: 0, y:label3.frame.origin.y + label3.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewTTNT.backgroundColor = UIColor.white
        scrollView.addSubview(viewTTNT)
        
        let lbPhoneTTNT =  UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbPhoneTTNT.textAlignment = .left
        lbPhoneTTNT.textColor = UIColor.black
        lbPhoneTTNT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPhoneTTNT.text = "Số điện thoại: "
        viewTTNT.addSubview(lbPhoneTTNT)
        
        let lbHoTenTTNT =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbPhone.frame.origin.y + lbPhone.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHoTenTTNT.textAlignment = .left
        lbHoTenTTNT.textColor = UIColor.black
        lbHoTenTTNT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHoTenTTNT.text = "Họ tên: "
        viewTTNT.addSubview(lbHoTenTTNT)
        
        btPrint = UIButton()
        btPrint.frame = CGRect(x: Common.Size(s:15), y: lbHoTenTTNT.frame.size.height + lbHoTenTTNT.frame.origin.y + Common.Size(s: 10) , width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 40))
        btPrint.backgroundColor = UIColor(netHex:0x00955E)
        btPrint.setTitle("In Bill", for: .normal)
        btPrint.addTarget(self, action: #selector(actionInBill), for: .touchUpInside)
        btPrint.layer.borderWidth = 0.5
        btPrint.layer.borderColor = UIColor.white.cgColor
        btPrint.layer.cornerRadius = 3
        viewTTNT.addSubview(btPrint)
        
        viewTTNT.frame.size.height = btPrint.frame.size.height + btPrint.frame.origin.y + Common.Size(s: 10)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTTNT.frame.origin.y + viewTTNT.frame.size.height + (UIApplication.shared.statusBarFrame.height) + Common.Size(s: 40))
        
        if item.orderTransactionDtos.count > 0 {
            lbSoTien.text = "Số tiền: \(Common.convertCurrencyDouble(value: item.orderTransactionDtos[0].totalAmount))"
            lbPhiGiaoDich.text = "Phí Giao Dịch: \(Common.convertCurrencyDouble(value: item.orderTransactionDtos[0].totalFee))"
            lbTongTienTT.text = "Tổng tiền: \(Common.convertCurrencyDouble(value: item.orderTransactionDtos[0].totalAmountIncludingFee))"
            lbNoiDung.text = "Nội Dung: \(item.orderTransactionDtos[0].mDescription)"
            
            //chủ TK:
            lbPhone.text = "Số điện thoại: \(item.orderTransactionDtos[0].productCustomerPhoneNumber)"
            lbHoTen.text = "Họ tên: \(item.orderTransactionDtos[0].productCustomerName)"
            
            //Người thanh toan
            lbPhoneTTNT.text = "Số điện thoại: \(item.customerPhoneNumber)"
            lbHoTenTTNT.text = "Họ tên: \(item.customerName)"
        }
        
        if (item.orderStatus == 1) || (item.orderStatus == 2) || (item.orderStatus == 7) {
            btPrint.isHidden = false
        } else {
            btPrint.isHidden = true
        }
    }
    
    @objc func backButton(){
        _ = self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("viettelPayView"), object: nil)
    }
    
    private func getOrderVoucher(providerName: String) {
        var voucherString = ""
        SOMAPIManager.shared.getOrderVoucher(orderID: self.orderID, providerName: providerName, completion: { result in
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                switch result {
                case .success(let voucher):
                    voucherString = voucher.message?.replace("|-|", withString: ";") ?? ""
                    DispatchQueue.main.async {
                        self.printBill(voucher: voucherString, providerName: providerName)
                    }
                case .failure(let error):
                    self.showPopUp(error.description, "Thông báo", buttonTitle: "OK", handleOk: {
                        DispatchQueue.main.async {
                            self.printBill(voucher: voucherString, providerName: providerName)
                        }
                    })
                }
            }
        })
    }
    
    private func printBill(voucher: String, providerName: String) {
        let title = "Thông báo"
        let popup = PopupDialog(title: title, message: "Bạn muốn in bill?", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
            print("Completed")
        }
        let buttonOne = DefaultButton(title: "In") {
            
            var orderTransactionDtos: ViettelPayOrder_OrderTransactionDtos?
            if (self.itemViettelPaySOMOrder?.orderTransactionDtos.count ?? 0) > 0 {
                orderTransactionDtos = self.itemViettelPaySOMOrder?.orderTransactionDtos[0]
            }
            
            
            let printBillThuHoLC = BillParamViettelPay(BillCode:"\(self.itemViettelPaySOMOrder?.billNo ?? "")"
                                                       , TransactionCode:"\(self.itemViettelPaySOMOrder?.orderTransactionDtos.first?.transactionCode ?? "")"
                                                       , ServiceName:""
                                                       , ProVideName: providerName
                                                       , Customernamne:"\(self.itemViettelPaySOMOrder?.customerName ?? "")"
                                                       , Customerpayoo:"VTT"
                                                       , PayerMobiphone: self.itemViettelPaySOMOrder?.customerPhoneNumber ?? ""
                                                       , Address:""
                                                       , BillID:""
                                                       , Month:""
                                                       , TotalAmouth: orderTransactionDtos?.totalAmount.removeZerosFromEnd() ?? "0"
                                                       , Paymentfee:  orderTransactionDtos?.totalFee.removeZerosFromEnd() ?? "0"
                                                       , Employname:"\(Cache.user?.UserName ?? "") - \(Cache.user?.EmployeeName ?? "")"
                                                       , Createby:"\(Cache.user?.UserName ?? "")"
                                                       , MaVoucher: voucher
                                                       , HanSuDung:""
                                                       , ShopAddress:"\(Cache.user?.Address ?? "")"
                                                       , ThoiGianXuat: "\(Common.convertDateISO8601(dateString: self.itemViettelPaySOMOrder?.creationTime ?? ""))"
                                                       , PhiCaThe:"0"
                                                       , dichVu: "Nạp tiền tài khoản Viettel Pay")
            MPOSAPIManager.pushBillThuHoViettelPay(printBill: printBillThuHoLC)
            
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
    
    @objc func actionInBill(){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            SOMAPIManager.shared.getProviderDetail(providerID: self.itemViettelPaySOMOrder?.orderTransactionDtos.first?.providerId ?? "", completion: { result in
                switch result {
                case .success(let provider):
                    self.getOrderVoucher(providerName: provider.name ?? "ViettelPay")
                case .failure(let error):
                    self.showPopUp(error.description, "Thông báo", buttonTitle: "OK", handleOk: {
                        self.getOrderVoucher(providerName: "ViettelPay")
                    })
                }
            })
        }
    }
}
