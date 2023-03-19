//
//  MoMoResultViewController.swift
//  mPOS
//
//  Created by tan on 12/9/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import Toaster
class MoMoResultViewController : UIViewController{
    // MARK: - Properties
    private var viewTTGD: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var viewTTKKH: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var viewHTTT: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var viewTTTT: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var btPrint:UIButton = {
        let btInphieu = UIButton()
        btInphieu.backgroundColor = .mainGreen
        btInphieu.setTitle("In phiếu", for: .normal)
        btInphieu.addTarget(self, action: #selector(actionInBill), for: .touchUpInside)
        btInphieu.layer.borderWidth = 0.5
        btInphieu.layer.borderColor = UIColor.white.cgColor
        btInphieu.layer.cornerRadius = 3
        btInphieu.clipsToBounds = true
        return btInphieu
    }()
    private var lblSoPhieuValue:UILabel!
    private var lblNgayThuValue: UILabel!
    private var lblShopValue: UILabel!
    private var lblNVValue: UILabel!
    private var lblTrangThaiValue: UILabel!
    private var lblChuTKValue: UILabel!
    private var lblSDTCTKValue: UILabel!
    private var lblNTTValue: UILabel!
    private var lblSDTNTTValue: UILabel!
    private var lblCashValue: UILabel!
    private var lblTotalFeeValue: UILabel!
    private var lblTotalNapValue: UILabel!
    private var lblTotalTTValue: UILabel!
    var infoOrderSOM: InfoOrderSOM?
    var orderTransactionDto: OrderTransactionDto?
    var orderID: String = ""
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chi tiết giao dịch nạp tiền Momo"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        let btLeftIcon = UIButton.init(type: .custom)
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        configureUI()
    }
    @objc func backButton(){
        for vc in self.navigationController?.viewControllers ?? [] {
            if vc is MoMoMenuViewController {
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    // MARK: - API
    private func printBill(voucher: String, providerName: String) {
        let newViewController = LoadingViewController()
        newViewController.content = "Đang in phiếu xin chờ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default


        MPOSAPIManager.inMoMo(soPhieuThu: "\(self.infoOrderSOM?.billNo ?? "")",
                              maGiaoDich: "\(self.infoOrderSOM?.orderTransactionDtos?.first?.transactionCode ?? "")",
                              thoiGianThu: "\(Common.convertDateISO8601(dateString: self.infoOrderSOM?.creationTime ?? ""))",
                              sdt_KH: "\(self.infoOrderSOM?.customerPhoneNumber ?? "")",
                              tenKH: "\(self.infoOrderSOM?.customerName ?? "")",
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
                        for vc in self.navigationController?.viewControllers ?? [] {
                            if vc is MoMoMenuViewController {
                                self.navigationController?.popToViewController(vc, animated: true)
                            }
                        }
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
    
    func fetchPrintAPI(){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            SOMAPIManager.shared.getProviderDetail(providerID: self.orderTransactionDto?.providerID ?? "", completion: { result in
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
    
    // MARK: Selectors
    @objc func actionInBill(){


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
    
     // MARK: - Helpers
    func configureUI(){
        let width = view.frame.size.width - Common.Size(s:30)
        let height = Common.Size(s:14)
        let fontSize = Common.Size(s: 12)
        view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        
        let scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let labelTTGD = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labelTTGD.text = "THÔNG TIN GIAO DỊCH" //Outbound
        labelTTGD.textColor = .mainGreen
        labelTTGD.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(labelTTGD)
        
        viewTTGD.frame = CGRect(x: 0, y: labelTTGD.frame.size.height + labelTTGD.frame.origin.y , width: view.frame.size.width, height: Common.Size(s: 300))
        scrollView.addSubview(viewTTGD)
        
           
        let lblSoPhieu = Common.tileLabel(x: Common.Size(s:10), y: Common.Size(s: 10), width: width/3 + Common.Size(s: 5), height: height, title: "Số phiếu",fontSize: fontSize)
        viewTTGD.addSubview(lblSoPhieu)
        
        
        lblSoPhieuValue = Common.tileLabel(x: lblSoPhieu.frame.origin.x + lblSoPhieu.frame.width + Common.Size(s: 5), y: lblSoPhieu.frame.origin.y, width: (width * 2/3) - Common.Size(s: 10), height: height, title: "",fontSize: fontSize)
        lblSoPhieuValue.textAlignment = .right
        lblSoPhieuValue.text = self.infoOrderSOM?.billNo ?? ""
        viewTTGD.addSubview(lblSoPhieuValue)
        
        
        let lblNgayThu = Common.tileLabel(x: Common.Size(s: 10), y: lblSoPhieu.frame.size.height + lblSoPhieu.frame.origin.y + Common.Size(s: 10), width: lblSoPhieu.frame.width, height: height, title: "Ngày thu",fontSize: fontSize)
        viewTTGD.addSubview(lblNgayThu)
        
        
        
        lblNgayThuValue = Common.tileLabel(x: lblSoPhieuValue.frame.origin.x, y: lblNgayThu.frame.origin.y, width: lblSoPhieuValue.frame.width, height: height, title: "",fontSize: fontSize)
        lblNgayThuValue.textAlignment = .right
        lblNgayThuValue.text = "\(Common.convertDateISO8601(dateString: self.infoOrderSOM?.creationTime ?? ""))"
        viewTTGD.addSubview(lblNgayThuValue)
        
        let lblShop = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lblNgayThu.frame.size.height + lblNgayThu.frame.origin.y + Common.Size(s: 10), width: lblSoPhieu.frame.width, height: Common.Size(s: 14)))
        lblShop.textAlignment = .left
        lblShop.textColor = UIColor.black
        lblShop.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblShop.text = "Shop"
        viewTTGD.addSubview(lblShop)
        
        lblShopValue = UILabel(frame: CGRect(x: lblSoPhieuValue.frame.origin.x, y: lblShop.frame.origin.y , width: lblSoPhieuValue.frame.width, height: Common.Size(s:14)))
        lblShopValue.textAlignment = .right
        lblShopValue.textColor = UIColor.black
        lblShopValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblShopValue.text = self.infoOrderSOM?.warehouseAddress ?? ""
        viewTTGD.addSubview(lblShopValue)
        
        let lblShopValueHeight:CGFloat = lblShopValue.optimalHeight < Common.Size(s:14) ? Common.Size(s:14) : lblShopValue.optimalHeight
        lblShopValue.numberOfLines = 0
        lblShopValue.frame = CGRect(x: lblShopValue.frame.origin.x, y: lblShopValue.frame.origin.y, width: lblShopValue.frame.width, height: lblShopValueHeight)
        
        let lblNV = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lblShopValue.frame.height + lblShopValue.frame.origin.y + Common.Size(s: 10), width: lblSoPhieu.frame.width, height: Common.Size(s: 14)))
        lblNV.textAlignment = .left
        lblNV.textColor = UIColor.black
        lblNV.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNV.text = "NV giao dịch"
        viewTTGD.addSubview(lblNV)
        
        lblNVValue = UILabel(frame: CGRect(x: lblSoPhieuValue.frame.origin.x, y: lblNV.frame.origin.y , width: lblSoPhieuValue.frame.width , height: Common.Size(s:14)))
        lblNVValue.textAlignment = .right
        lblNVValue.textColor = UIColor.black
        lblNVValue.text = self.infoOrderSOM?.employeeName ?? ""
        lblNVValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        viewTTGD.addSubview(lblNVValue)
        
        let lblNVValueHeight:CGFloat = lblNVValue.optimalHeight < Common.Size(s:14) ? Common.Size(s:14) : lblNVValue.optimalHeight
        lblNVValue.numberOfLines = 0
        lblNVValue.frame = CGRect(x: lblNVValue.frame.origin.x, y: lblNVValue.frame.origin.y, width: lblNVValue.frame.width, height: lblNVValueHeight)
        
        let lblTrangThai = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lblNVValue.frame.size.height + lblNVValue.frame.origin.y + Common.Size(s: 10), width: lblSoPhieu.frame.width, height: Common.Size(s: 14)))
        lblTrangThai.textAlignment = .left
        lblTrangThai.textColor = UIColor.black
        lblTrangThai.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTrangThai.text = "Trạng thái"
        viewTTGD.addSubview(lblTrangThai)
        
        lblTrangThaiValue = UILabel(frame: CGRect(x: lblSoPhieuValue.frame.origin.x, y:   lblTrangThai.frame.origin.y , width: lblSoPhieuValue.frame.size.width, height: Common.Size(s:14)))
        lblTrangThaiValue.textAlignment = .right
        lblTrangThaiValue.textColor = UIColor.black
        lblTrangThaiValue.text = ""
        lblTrangThaiValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        viewTTGD.addSubview(lblTrangThaiValue)
        
        if let statusCode = CreateOrderResultViettelPay_SOM(rawValue: self.infoOrderSOM?.orderStatus ?? 3) {
            lblTrangThaiValue.text = statusCode.message
        } else {
            showPopUp("Không tìm thấy trạng thái giao dịch tương ứng code \(self.infoOrderSOM?.orderStatus ?? 0)", "Thông báo", buttonTitle: "OK")
        }
        
        let lblTrangThaiValueHeight:CGFloat = lblTrangThaiValue.optimalHeight < Common.Size(s:14) ? Common.Size(s:14) : lblTrangThaiValue.optimalHeight
        lblTrangThaiValue.numberOfLines = 0
        lblTrangThaiValue.frame = CGRect(x: lblTrangThaiValue.frame.origin.x, y: lblTrangThaiValue.frame.origin.y, width: lblTrangThaiValue.frame.width, height: lblTrangThaiValueHeight)
        
        if self.infoOrderSOM?.orderStatus == 2 {
            lblTrangThaiValue.textColor = UIColor(netHex: 0x73b36d)
        } else  if self.infoOrderSOM?.orderStatus == 3 {
            lblTrangThaiValue.textColor = .red
        } else {
            lblTrangThaiValue.textColor = .blue
        }
        
        viewTTGD.frame.size.height = lblTrangThaiValue.frame.size.height + lblTrangThaiValue.frame.origin.y + Common.Size(s: 10)
        
        let labelTTKH = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewTTGD.frame.size.height + viewTTGD.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labelTTKH.text = "THÔNG TIN KHÁCH HÀNG"
        labelTTKH.textColor = .mainGreen
        labelTTKH.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(labelTTKH)
        
        viewTTKKH.frame = CGRect(x: 0, y: labelTTKH.frame.size.height + labelTTKH.frame.origin.y , width: view.frame.size.width, height: Common.Size(s: 300))
        scrollView.addSubview(viewTTKKH)
        
        let lblChuTK = Common.tileLabel(x: Common.Size(s: 10), y: Common.Size(s: 10), width: width, height: height, title: "Chủ tài khoản")
        viewTTKKH.addSubview(lblChuTK)
        
        lblChuTKValue = Common.tileLabel(x: Common.Size(s: 10), y: Common.Size(s: 10), width: width, height: height, title: "",fontSize: fontSize)
        lblChuTKValue.textAlignment = .right
        viewTTKKH.addSubview(lblChuTKValue)
        
        let lblSDTCTK = Common.tileLabel(x: Common.Size(s: 10), y: lblChuTKValue.frame.size.height + lblChuTKValue.frame.origin.y + Common.Size(s: 10), width: width, height: height, title: "Số điện thoại")
        viewTTKKH.addSubview(lblSDTCTK)
        
        lblSDTCTKValue = Common.tileLabel(x: Common.Size(s: 10), y: lblSDTCTK.frame.origin.y, width: width, height: height, title: "",fontSize: fontSize)
        lblSDTCTKValue.textAlignment = .right
        viewTTKKH.addSubview(lblSDTCTKValue)
        
        
        let lblNTT = Common.tileLabel(x: Common.Size(s: 10), y:lblSDTCTK.frame.size.height + lblSDTCTK.frame.origin.y + Common.Size(s: 10), width: width, height: height, title: "Người thanh toán")
        viewTTKKH.addSubview(lblNTT)
        
        lblNTTValue = Common.tileLabel(x: Common.Size(s: 10), y: lblNTT.frame.origin.y, width: width, height: height, title: "",fontSize: fontSize)
        lblNTTValue.textAlignment = .right
        viewTTKKH.addSubview(lblNTTValue)
        
        let lblSDTNTT = Common.tileLabel(x: Common.Size(s: 10), y: lblNTT.frame.size.height + lblNTT.frame.origin.y + Common.Size(s: 10), width: width, height: height, title: "Số điện thoại")
        viewTTKKH.addSubview(lblSDTNTT)
        
        lblSDTNTTValue = Common.tileLabel(x: Common.Size(s: 10), y: lblSDTNTT.frame.origin.y, width: width, height: height, title: "",fontSize: fontSize)
        lblSDTNTTValue.textAlignment = .right
        viewTTKKH.addSubview(lblSDTNTTValue)
        
        viewTTKKH.frame.size.height = lblSDTNTT.frame.size.height + lblSDTNTT.frame.origin.y + Common.Size(s: 10)
        
        let labelHTTT = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewTTKKH.frame.size.height + viewTTKKH.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labelHTTT.text = "HÌNH THỨC THANH TOÁN"
        labelHTTT.textColor = .mainGreen
        labelHTTT.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(labelHTTT)
        
        viewHTTT.frame = CGRect(x: 0, y: labelHTTT.frame.size.height + labelHTTT.frame.origin.y , width: view.frame.size.width, height: Common.Size(s: 300))
        scrollView.addSubview(viewHTTT)
        
        let lblCash = Common.tileLabel(x: Common.Size(s: 10), y: Common.Size(s: 10), width: width, height: height, title: "Tiền mặt")
        viewHTTT.addSubview(lblCash)
        
        
        lblCashValue = Common.tileLabel(x: Common.Size(s: 10), y: Common.Size(s: 10), width: width, height: height, title: "",fontSize: fontSize)
        lblCashValue.textAlignment = .right
        viewHTTT.addSubview(lblCashValue)
        
        viewHTTT.frame.size.height = lblCash.frame.size.height + lblCash.frame.origin.y + Common.Size(s: 10)
        
        let labelTTTT = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewHTTT.frame.size.height + viewHTTT.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labelTTTT.text = "THÔNG TIN THANH TOÁN"
        labelTTTT.textColor = .mainGreen
        labelTTTT.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(labelTTTT)
        
        viewTTTT.frame = CGRect(x: 0, y: labelTTTT.frame.size.height + labelTTTT.frame.origin.y , width: view.frame.size.width, height: Common.Size(s: 300))
        scrollView.addSubview(viewTTTT)
        
        let lblTotalFee = Common.tileLabel(x: Common.Size(s: 10), y: Common.Size(s: 10), width: width, height: height, title: "Tổng tiền phí")
        viewTTTT.addSubview(lblTotalFee)
        
        lblTotalFeeValue = Common.tileLabel(x: Common.Size(s: 10), y: Common.Size(s: 10), width: width, height: height, title: "",fontSize: fontSize)
        lblTotalFeeValue.textAlignment = .right
        lblTotalFeeValue.textColor = .red
        viewTTTT.addSubview(lblTotalFeeValue)
        
        let lblTotalNap = Common.tileLabel(x: Common.Size(s: 10), y: lblTotalFee.frame.size.height + lblTotalFee.frame.origin.y + Common.Size(s: 10), width: width, height: height, title: "Tổng tiền nạp")
        viewTTTT.addSubview(lblTotalNap)
        
        
        lblTotalNapValue = Common.tileLabel(x: Common.Size(s: 10), y: lblTotalNap.frame.origin.y, width: width, height: height, title: "",fontSize: fontSize)
        lblTotalNapValue.textAlignment = .right
        lblTotalNapValue.textColor = .red
        lblTotalNapValue.text = ""
        viewTTTT.addSubview(lblTotalNapValue)
        
        let lblTotalTT = Common.tileLabel(x: Common.Size(s: 10), y: lblTotalNap.frame.size.height + lblTotalNap.frame.origin.y + Common.Size(s: 10), width: width, height: height, title: "Tổng tiền thanh toán")
        viewTTTT.addSubview(lblTotalTT)
        
        lblTotalTTValue = Common.tileLabel(x: Common.Size(s: 10), y: lblTotalTT.frame.origin.y, width: width, height: height, title: "",fontSize: fontSize)
        lblTotalTTValue.textAlignment = .right
        lblTotalTTValue.textColor = .red
        viewTTTT.addSubview(lblTotalTTValue)
        
        viewTTTT.frame.size.height = lblTotalTT.frame.size.height + lblTotalTT.frame.origin.y + Common.Size(s: 10)
        
        
        btPrint.frame = CGRect(x: Common.Size(s: 15), y: viewTTTT.frame.origin.y + viewTTTT.frame.height + Common.Size(s: 10), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 40))
        scrollView.addSubview(btPrint)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btPrint.frame.origin.y + btPrint.frame.size.height + (navigationController?.navigationBar.frame.size.height ?? 0) + UIApplication.shared.statusBarFrame.height + Common.Size(s:45))
        
        let orderTransactionDtos = self.infoOrderSOM?.orderTransactionDtos ?? []
        if orderTransactionDtos.count > 0 {
            self.orderTransactionDto = orderTransactionDtos[0]
            lblChuTKValue.text = orderTransactionDtos[0].receiver?.fullname ?? ""
            lblSDTCTKValue.text = orderTransactionDtos[0].receiver?.phonenumber ?? ""
            lblNTTValue.text = orderTransactionDtos[0].sender?.fullname ?? ""
            lblSDTNTTValue.text = orderTransactionDtos[0].sender?.phonenumber ?? ""
            
            lblCashValue.text = Common.convertCurrencyV2(value: orderTransactionDtos[0].totalAmount ?? 0)
            lblTotalFeeValue.text = Common.convertCurrencyV2(value: orderTransactionDtos[0].totalFee ?? 0)
            lblTotalTTValue.text = Common.convertCurrencyV2(value: orderTransactionDtos[0].totalAmountIncludingFee ?? 0)
            lblTotalNapValue.text = Common.convertCurrencyV2(value: orderTransactionDtos[0].totalAmount ?? 0)
        }
        
        if (self.infoOrderSOM?.orderStatus == 1) || (self.infoOrderSOM?.orderStatus == 2) || (self.infoOrderSOM?.orderStatus == 7) {
            btPrint.isHidden = false
        } else {
            btPrint.isHidden = true
        }
    }
    
    func showData(){
        if self.infoOrderSOM == nil {
            self.infoOrderSOM = InfoOrderSOM(orderStatus: 0, orderStatusDisplay: "", billNo: "", customerID: "", referenceSystem: "", referenceValue: "", tenant: "", warehouseCode: "", regionCode: "", ip: "", orderTransactionDtos: [], orderHistories: [], customerName: "", customerPhoneNumber: "", employeeName: "", warehouseAddress: "", payments: [], creationTime: "", creationBy: "", id: "")
        }
        lblSoPhieuValue.text = self.infoOrderSOM?.billNo ?? ""
        lblNgayThuValue.text = "\(Common.convertDateISO8601(dateString: self.infoOrderSOM?.creationTime ?? ""))"
        lblShopValue.text = self.infoOrderSOM?.warehouseAddress ?? ""
        lblNVValue.text = self.infoOrderSOM?.employeeName ?? ""
        if let statusCode = CreateOrderResultViettelPay_SOM(rawValue: self.infoOrderSOM?.orderStatus ?? 3) {
            lblTrangThaiValue.text = statusCode.message
        } else {
            showPopUp("Không tìm thấy trạng thái giao dịch tương ứng code \(self.infoOrderSOM?.orderStatus ?? 0)", "Thông báo", buttonTitle: "OK")
        }
        let orderTransactionDtos = self.infoOrderSOM?.orderTransactionDtos ?? []
        if orderTransactionDtos.count > 0 {
            lblChuTKValue.text = orderTransactionDtos[0].productCustomerName ?? ""
            lblSDTCTKValue.text = orderTransactionDtos[0].productCustomerPhoneNumber ?? ""
            lblNTTValue.text = self.infoOrderSOM?.customerName ?? ""
            lblSDTNTTValue.text = self.infoOrderSOM?.customerPhoneNumber ?? ""
            
            lblCashValue.text = Common.convertCurrencyV2(value: orderTransactionDtos[0].totalAmount ?? 0)
            lblTotalFeeValue.text = Common.convertCurrencyV2(value: orderTransactionDtos[0].totalFee ?? 0)
            lblTotalTTValue.text = Common.convertCurrencyV2(value: orderTransactionDtos[0].totalAmountIncludingFee ?? 0)
        }
    }
}
