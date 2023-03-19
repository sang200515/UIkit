//
//  DetailLSMomoViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 3/11/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import PopupDialog

class DetailLSMomoViewController: UIViewController {

    var scrollView:UIScrollView!
    var viewChuTK:UIView!
    var viewNTT:UIView!
    var viewTTNT:UIView!
    var btPrint:UIButton!
    var itemDetail:ItemHistorySOM?
    var itemOrderDetail: InfoOrderSOM?
    var orderTransactionDto: OrderTransactionDto?
    var orderID: String = ""
    
    override func viewDidLoad() {
        self.title = "Chi tiết giao dịch nạp tiền Momo"
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.view.backgroundColor = .white
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            SOMAPIManager.shared.getInfoOrderSOM(id: "\(self.itemDetail?.orderID ?? "")") { result in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    switch result {
                    case .success(let infoOrderSOM):
                        self.itemOrderDetail = infoOrderSOM
                        if (infoOrderSOM.orderTransactionDtos?.count ?? 0) > 0 {
                            self.orderTransactionDto = infoOrderSOM.orderTransactionDtos?[0]
                        }
                        self.setUpView()
                    case .failure(let error):
                        self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
                        
                    }
                }
            }
        }
        
    }
    
    func setUpView() {
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
//        lbSoMPOS.text = "Số MPOS: \(self.cashInDetail!.docentry)"
//        viewChuTK.addSubview(lbSoMPOS)
//
//        let lbSoGDVnPay =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbSoMPOS.frame.origin.y + lbSoMPOS.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
//        lbSoGDVnPay.textAlignment = .left
//        lbSoGDVnPay.textColor = UIColor.black
//        lbSoGDVnPay.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lbSoGDVnPay.text = "Số GD VTPAY: \(self.cashInDetail!.trans_id_viettel)"
//        viewChuTK.addSubview(lbSoGDVnPay)
        
        let lbSoPhieu =  UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbSoPhieu.textAlignment = .left
        lbSoPhieu.textColor = UIColor.black
        lbSoPhieu.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoPhieu.text = "Số Phiếu: \(self.itemDetail?.billNo ?? "")"
        viewChuTK.addSubview(lbSoPhieu)
        
        let lbSotien =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbSoPhieu.frame.origin.y + lbSoPhieu.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbSotien.textAlignment = .left
        lbSotien.textColor = UIColor.black
        lbSotien.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbSotien.text = "Số tiền: \(Common.convertCurrencyV2(value: self.orderTransactionDto?.totalAmount ?? 0))"
        viewChuTK.addSubview(lbSotien)
        
        let lbPhiGiaoDich =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbSotien.frame.origin.y + lbSotien.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbPhiGiaoDich.textAlignment = .left
        lbPhiGiaoDich.textColor = UIColor.black
        lbPhiGiaoDich.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbPhiGiaoDich.text = "Phí Giao Dịch: \(Common.convertCurrencyV2(value: self.orderTransactionDto?.totalFee ?? 0))"
        viewChuTK.addSubview(lbPhiGiaoDich)
        
        let lbTongTien =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbPhiGiaoDich.frame.origin.y + lbPhiGiaoDich.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTongTien.textAlignment = .left
        lbTongTien.textColor = UIColor.red
        lbTongTien.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbTongTien.text = "Tổng: \(Common.convertCurrencyV2(value: self.orderTransactionDto?.totalAmountIncludingFee ?? 0))"
        viewChuTK.addSubview(lbTongTien)
        
        let lbNgayGiaoDich =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbTongTien.frame.origin.y + lbTongTien.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbNgayGiaoDich.textAlignment = .left
        lbNgayGiaoDich.textColor = UIColor.black
        lbNgayGiaoDich.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbNgayGiaoDich.text = "Ngày Giao Dịch: \(Common.convertDateISO8601(dateString: self.itemDetail?.creationTime ?? ""))"
        viewChuTK.addSubview(lbNgayGiaoDich)
        
        let lbNoiDung =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbNgayGiaoDich.frame.origin.y + lbNgayGiaoDich.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbNoiDung.textAlignment = .left
        lbNoiDung.textColor = UIColor.black
        lbNoiDung.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbNoiDung.text = "Nội Dung: \(self.orderTransactionDto?.orderTransactionDtoDescription ?? "")"
        viewChuTK.addSubview(lbNoiDung)
        
        let lbTrangThai =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbNoiDung.frame.origin.y + lbNoiDung.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTrangThai.textAlignment = .left
        lbTrangThai.textColor = UIColor.init(netHex: 0x3399CC)
        lbTrangThai.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbTrangThai.text = "Trạng thái: Hoàn tất"
        viewChuTK.addSubview(lbTrangThai)
        
        let status = CreateOrderResultViettelPay_SOM(rawValue: self.itemDetail?.orderStatus ?? 3)
        lbTrangThai.text = "Trạng thái: \(status?.message ?? "")"
        
        let lbTrangThaiHeight:CGFloat = lbTrangThai.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbTrangThai.optimalHeight + Common.Size(s: 5))
        lbTrangThai.numberOfLines = 0
        lbTrangThai.frame = CGRect(x: lbTrangThai.frame.origin.x, y: lbTrangThai.frame.origin.y, width: lbTrangThai.frame.width, height: lbTrangThaiHeight)
        
        if self.itemDetail?.orderStatus == 2 {
            lbTrangThai.textColor = UIColor(netHex: 0x73b36d)
        } else  if self.itemDetail?.orderStatus == 3 {
            lbTrangThai.textColor = .red
        } else {
            lbTrangThai.textColor = .blue
        }
        
        viewChuTK.frame.size.height = lbTrangThai.frame.origin.y + lbTrangThai.frame.size.height + Common.Size(s: 10)
        
        
        let label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewChuTK.frame.origin.y + viewChuTK.frame.size.height , width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label2.text = "THÔNG TIN CHỦ TÀI KHOẢN MOMO"
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
        lbPhone.text = "Số điện thoại: \(self.itemOrderDetail?.orderTransactionDtos?.first?.productCustomerPhoneNumber ?? "")"
        viewNTT.addSubview(lbPhone)
        
        let lbHoTen =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbPhone.frame.origin.y + lbPhone.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHoTen.textAlignment = .left
        lbHoTen.textColor = UIColor.black
        lbHoTen.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHoTen.text = "Họ tên: \(self.itemOrderDetail?.orderTransactionDtos?.first?.productCustomerName ?? "")"
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
        lbPhoneTTNT.text = "Số điện thoại: \(self.itemOrderDetail?.customerPhoneNumber ?? "")"
        viewTTNT.addSubview(lbPhoneTTNT)
        
        let lbHoTenTTNT =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbPhone.frame.origin.y + lbPhone.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHoTenTTNT.textAlignment = .left
        lbHoTenTTNT.textColor = UIColor.black
        lbHoTenTTNT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHoTenTTNT.text = "Họ tên: \(self.itemOrderDetail?.customerName ?? "")"
        viewTTNT.addSubview(lbHoTenTTNT)
        
        btPrint = UIButton()
        btPrint.frame = CGRect(x: Common.Size(s:15), y: lbHoTenTTNT.frame.size.height + lbHoTenTTNT.frame.origin.y + Common.Size(s: 10) , width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:40))
        btPrint.backgroundColor = UIColor(netHex:0x00955E)
        btPrint.setTitle("In Bill", for: .normal)
         btPrint.addTarget(self, action: #selector(actionInBill), for: .touchUpInside)
        btPrint.layer.borderWidth = 0.5
        btPrint.layer.borderColor = UIColor.white.cgColor
        btPrint.layer.cornerRadius = 3
        viewTTNT.addSubview(btPrint)
  
        if (self.itemDetail?.orderStatus == 1) || (self.itemDetail?.orderStatus == 2) || (self.itemDetail?.orderStatus == 7) {
            btPrint.isHidden = false
        } else {
            btPrint.isHidden = true
        }
        
        viewTTNT.frame.size.height = btPrint.frame.size.height + btPrint.frame.origin.y + Common.Size(s: 10)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTTNT.frame.origin.y + viewTTNT.frame.size.height + (UIApplication.shared.statusBarFrame.height) + Common.Size(s: 40))
    }
    
    @objc func backButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc  func actionInBill(){
        let title = "Thông báo"
        let popup = PopupDialog(title: title, message: "Bạn có muốn in bill ?", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            print("Completed")
        }
        let buttonOne = DefaultButton(title: "In") {
            self.fetchPrintAPI()
        }
        let buttonTwo = CancelButton(title: "Không") {

        }
        popup.addButtons([buttonOne,buttonTwo])
        self.present(popup, animated: true, completion: nil)
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
        let newViewController = LoadingViewController()
        newViewController.content = "Đang in phiếu xin chờ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        

        MPOSAPIManager.inMoMo(soPhieuThu: "\(self.itemDetail?.billNo ?? "")",
                              maGiaoDich: "\(self.itemOrderDetail?.orderTransactionDtos?.first?.transactionCode ?? "")",
                              thoiGianThu: "\(Common.convertDateISO8601(dateString: self.itemOrderDetail?.creationTime ?? ""))",
                              sdt_KH: "\(self.itemOrderDetail?.customerPhoneNumber ?? "")",
                              tenKH: "\(self.itemOrderDetail?.customerName ?? "")",
                              tongTienNap: "\(self.orderTransactionDto?.totalAmountIncludingFee ?? 0)",
                              tenVoucher: voucher,
                              hanSuDung: "",
                              nhaCungCap: providerName) { (result, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){

                    let title = "Thông báo"

                    let popup = PopupDialog(title: title, message: result, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        self.navigationController?.popViewController(animated: true)
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }else{


                    let title = "Thông báo"

                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {

                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)

                }
            }
        }
    }
    
    func fetchPrintAPI(){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            SOMAPIManager.shared.getProviderDetail(providerID: self.itemOrderDetail?.orderTransactionDtos?.first?.providerID ?? "", completion: { result in
                switch result {
                case .success(let provider):
                    self.getOrderVoucher(providerName: provider.name ?? "MoMo")
                case .failure(let error):
                    self.showPopUp(error.description, "Thông báo", buttonTitle: "OK", handleOk: {
                        self.getOrderVoucher(providerName: "MoMo")
                    })
                }
            })
        }
    }
}
