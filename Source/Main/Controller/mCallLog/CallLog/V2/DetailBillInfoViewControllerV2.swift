//
//  DetailBillInfoViewControllerV2.swift
//  fptshop
//
//  Created by Apple on 5/8/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown


class DetailBillInfoViewControllerV2: UIViewController {
    
    var scrollView: UIScrollView!
    var sendInfoView: UIView!
    var receiveInfoView: UIView!
    var packageInfoView: UIView!
    
    var lblSenderShopText: UILabel!
    var lblSenderAddressText: UILabel!
    var lblSenderPhoneNumber: UILabel!
    var lblSenderPhone: UILabel!
    var lblReceiverFullName: UILabel!
    var lblReceiverPhone: UILabel!
    
    var lblReceiverShop: UILabel!
    //    var tfReceiverShopText: UITextField!
    var tfReceiverShopText: SearchTextField!
    var lbNewlReceiverShop: UILabel!
    var tfNewReceiverShopText:UITextField!
    
    var dropShopPB = DropDown()
    var dropHangHoa = DropDown()
    var dropNhaVanChuyen = DropDown()
    var dropDichVu = DropDown()
    var dropHinhThucThanhToan = DropDown()
    var lblReceiverAddressText: UILabel!
    var tfReceiverPhoneNumber: UITextField!
    var tfReceiverFullName: UITextField!
    var tfPackageTypeText: UITextField!
    var tfPackageTypeName: UITextField!
    var tfPackageCount: UITextField!
    var tfPackageAmount: UITextField!
    var tfPackageWeight: UITextField!
    var tfPackageDistribute: UITextField!
    var tfPackageService: UITextField!
    var tfPackagePaymentType: UITextField!
    var tfPackageNote: UITextField!
    var tfCuocPhiMin: UITextField!
    var btnSend: UIButton!
    
    var scrollViewHeight: CGFloat = 0
    
    var listShopPBName:[String] = []
    var listPackageName:[String] = []
    var listDistributeName:[String] = []
    var listServiceName:[String] = []
    var listPaymentTypeName:[String] = []
    
    var senderObj:BillLoadDiaChiGui?
    var receiverObj:BillLoadDiaChiNhan?
    
    var selectedPB:BillLoadShopPhongBan?
    var selectedLoaiHang:BillLoadLoaiHang?
    var selectedDichVu:BillLoadDichVu?
    var selectedHTTT:BillLoadHinhThucThanhToan?
    var selectedDistribute:BillLoadNhaVanChuyen?
    
    
    var listShopPhongBan:[BillLoadShopPhongBan] = []
    var listPackage:[BillLoadLoaiHang] = []
    var listDistribute:[BillLoadNhaVanChuyen] = []
    var listService:[BillLoadDichVu] = []
    var listHTTT:[BillLoadHinhThucThanhToan] = []
    
    var callogTitle = ""
    var arrayCCCode = ""
    var isNewReceiverAddressUpdate = false
    var itemsSearchShop:[SearchTextFieldItem] = []
//    var requestID:Int = 0
    var isMirae = false
    var soLuongNum = 0
    var miraeBillInfo: Mirae_LoadInfo_Send_Bill?
    var listQuanHuyen:[BillLoadQuanHuyen] = []
    var listTinhTp:[BillLoadTinhThanhPho] = []
    var is_NVCToiUu:Int = 0
    var Is_Shop = false
    var ProcessID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "BILL VẬN CHUYỂN"
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationItem.hidesBackButton = true
        let backView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:30), height: Common.Size(s:50))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: backView)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        backView.addSubview(btBackIcon)
        
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.loadHangHoa()
            self.loadHinhThucThanhToan()
            self.loadDichVu()
            self.checkIsShop()
            
            mCallLogApiManager.Bill__LoadDiaChiGui(handler: { (results, error) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if results.count > 0 {
                        self.senderObj = results[0]
                    } else {
                        debugPrint("Không lấy được danh sách diaChiGui")
                    }
                    
                }
            })
            
            mCallLogApiManager.Bill__LoadShopPhongBan(handler: { (results, err) in
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if results.count > 0 {
                        for item in results {
                            self.listShopPhongBan.append(item)
                            self.listShopPBName.append(item.FullName)
                        }
                    } else {
                        debugPrint("Không lấy được listShopPBName")
                        self.showAlert(title: "Thông báo", message: "Không có danh sách phòng ban!")
                    }
                    
                    if self.isMirae {
                        self.loadTinhTp()
                        self.loadQuanHuyen()
                        self.loadTitle()
                        MPOSAPIManager.mpos_FRT_Mirae_LoadInfo_Send_Bill(handler: { (rs, err) in
                            if rs.count > 0 {
                                self.miraeBillInfo = rs[0]
                            } else {
                                debugPrint("Không lấy được Mirae_LoadInfo_Send_Bill")
                            }
                            
                            if self.scrollView != nil {
                                self.scrollView.removeFromSuperview()
                            }
                            self.setUpView()
                        })
                    } else {
                        if self.scrollView != nil {
                            self.scrollView.removeFromSuperview()
                        }
                        self.setUpView()
                    }
                }
            })
            
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateOldReceiverInfo(notification:)), name: NSNotification.Name.init("didUpdateOldReceiverInfo"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateNewReceiverInfo(notification:)), name: NSNotification.Name.init("didUpdateNewReceiverInfo"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateSenderInfo(notification:)), name: NSNotification.Name.init("didUpdateSenderInfo"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false
        if self.scrollView != nil {
            self.loadNhaVanChuyen()
        }
    }
    
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didUpdateSenderInfo(notification : NSNotification){
        
        let info = notification.userInfo
        let address = info?["address"]
        let quanHuyenName = info?["quanHuyenName"]
        let quanHuyenCode = info?["quanHuyenCode"]
        let tinhTpName = info?["tinhTpName"]
        let tinhTpCode = info?["tinhTpCode"]
        let sdt = info?["sdt"]
        
        self.lblSenderAddressText.text = "\(address ?? "")-\(quanHuyenName ?? "")-\(tinhTpName ?? "")"
        self.lblSenderPhoneNumber.text = sdt as? String
        
        if self.senderObj == nil{
            self.senderObj = BillLoadDiaChiGui(Address: address as! String, Id: 0, MaHuyen: Int(quanHuyenCode as! String)!, MaTinh: Int(tinhTpCode as! String)!, OrganizationHierachyCode: "", OrganizationHierachyCodeSend: "", OrganizationHierachyName: "", SoDienThoaiNguoiGui: sdt as! String, TenHuyen: quanHuyenName as! String, TenTinh: tinhTpName as! String)
        } else {
            self.senderObj?.TenTinh = tinhTpName as! String
            self.senderObj?.MaTinh = Int(tinhTpCode as! String)!
            self.senderObj?.TenHuyen = quanHuyenName as! String
            self.senderObj?.MaHuyen = Int(quanHuyenCode as! String)!
            self.senderObj?.Address = address as! String
            self.senderObj?.SoDienThoaiNguoiGui = sdt as! String
            
        }
        
        
        //up date Ui
        self.lblSenderAddressText.frame = CGRect(x: lblSenderAddressText.frame.origin.x, y: lblSenderAddressText.frame.origin.y, width: lblSenderAddressText.frame.width, height: lblSenderAddressText.optimalHeight)
        self.lblSenderAddressText.numberOfLines = 0
        let lblSenderAddressTextHeight = lblSenderAddressText.optimalHeight < Common.Size(s: 15) ? Common.Size(s: 15) : lblSenderAddressText.optimalHeight
        
        lblSenderPhone.frame = CGRect(x: lblSenderPhone.frame.origin.x, y: lblSenderAddressText.frame.origin.y + lblSenderAddressTextHeight + Common.Size(s: 10), width: lblSenderPhone.frame.width, height:lblSenderPhone.frame.height)
        
        lblSenderPhoneNumber.frame = CGRect(x: lblSenderPhoneNumber.frame.origin.x, y: lblSenderPhone.frame.origin.y, width: lblSenderPhoneNumber.frame.width, height: lblSenderPhoneNumber.frame.height)
        
        sendInfoView.frame = CGRect(x: sendInfoView.frame.origin.x, y: sendInfoView.frame.origin.y, width: sendInfoView.frame.width, height: lblSenderPhoneNumber.frame.origin.y + lblSenderPhoneNumber.frame.height + Common.Size(s: 10))
        
        receiveInfoView.frame = CGRect(x: receiveInfoView.frame.origin.x, y: sendInfoView.frame.origin.y + sendInfoView.frame.height, width: receiveInfoView.frame.width, height: receiveInfoView.frame.height + Common.Size(s: 10))
        
        packageInfoView.frame = CGRect(x: packageInfoView.frame.origin.x, y: receiveInfoView.frame.origin.y + receiveInfoView.frame.height, width: packageInfoView.frame.width, height: packageInfoView.frame.height)
        
        scrollViewHeight = packageInfoView.frame.origin.y + packageInfoView.frame.height + Common.Size(s: 100)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    @objc func didUpdateOldReceiverInfo(notification : NSNotification) {
        
        self.isNewReceiverAddressUpdate = false
        self.lbNewlReceiverShop.isHidden = true
        self.tfNewReceiverShopText.isHidden = true
        
        self.lblReceiverShop.isHidden = false
        self.tfReceiverShopText.isHidden = false
        
        //
        let info = notification.userInfo
        let shopName = info?["shopName"]
        let shopReceiverCode = info?["shopReceiverCode"]
        let address = info?["address"]
        let quanHuyenName = info?["quanHuyenName"]
        let quanHuyenCode = info?["quanHuyenCode"]
        let tinhTpName = info?["tinhTpName"]
        let tinhTpCode = info?["tinhTpCode"]
        let fullName = info?["hoTen"]
        let sdt = info?["sdt"]
        
        self.tfReceiverShopText.text = shopName as? String
        self.tfReceiverPhoneNumber.text = sdt as? String
        self.tfReceiverFullName.text = fullName as? String
        self.lblReceiverAddressText.text = "\(address ?? "")-\(quanHuyenName ?? "")-\(tinhTpName ?? "")"
        
        //update selectedPB
        self.selectedPB?.Code = shopReceiverCode as! String
        self.selectedPB?.FullName = shopName as! String
        self.selectedPB?.Name = shopName as! String
        
        //update info nguoi nhan
        self.receiverObj?.OrganizationHierachyName = shopName as! String
        self.receiverObj?.TenTinh = tinhTpName as! String
        self.receiverObj?.MaTinh = Int(tinhTpCode as! String)!
        self.receiverObj?.MaHuyen = Int(quanHuyenCode as! String)!
        self.receiverObj?.TenHuyen = quanHuyenName as! String
        self.receiverObj?.HoTenNguoiNhan = fullName as! String
        self.receiverObj?.SoDienThoaiNguoiNhan = sdt as! String
        self.receiverObj?.Address = address as! String
        
        self.updateUIAfterUpdateReceiverInfo()
        
    }
    
    @objc func didUpdateNewReceiverInfo(notification : NSNotification) {
        
        self.isNewReceiverAddressUpdate = true
        self.lblReceiverShop.isHidden = true
        self.tfReceiverShopText.isHidden = true
        
        self.lbNewlReceiverShop.isHidden = false
        self.tfNewReceiverShopText.isHidden = false
        
        let info = notification.userInfo
        let shopName = info?["shopName"]
        let shopReceiverCode = info?["shopReceiverCode"]
        let address = info?["address"]
        let quanHuyenName = info?["quanHuyenName"]
        let quanHuyenCode = info?["quanHuyenCode"]
        let tinhTpName = info?["tinhTpName"]
        let tinhTpCode = info?["tinhTpCode"]
        let fullName = info?["hoTen"]
        let sdt = info?["sdt"]
        
        self.tfNewReceiverShopText.text = shopName as? String
        self.tfReceiverPhoneNumber.text = sdt as? String
        self.tfReceiverFullName.text = fullName as? String
        self.lblReceiverAddressText.text = "\(address ?? "")-\(quanHuyenName ?? "")-\(tinhTpName ?? "")"
        
        ////        //update selectedPB
        self.selectedPB?.Code = shopReceiverCode as! String
        self.selectedPB?.FullName = shopName as! String
        self.selectedPB?.Name = shopName as! String
        //
        //update info nguoi nhan
        
        self.receiverObj?.OrganizationHierachyName = shopName as! String
        self.receiverObj?.TenTinh = tinhTpName as! String
        self.receiverObj?.MaTinh = Int(tinhTpCode as! String)!
        self.receiverObj?.MaHuyen = Int(quanHuyenCode as! String)!
        self.receiverObj?.TenHuyen = quanHuyenName as! String
        self.receiverObj?.HoTenNguoiNhan = fullName as! String
        self.receiverObj?.SoDienThoaiNguoiNhan = sdt as! String
        self.receiverObj?.Address = address as! String
        
        self.updateUIAfterUpdateReceiverInfo()
    }
    
    func updateUIAfterUpdateReceiverInfo() {
        
        lblReceiverAddressText.frame = CGRect(x: lblReceiverAddressText.frame.origin.x, y: lblReceiverAddressText.frame.origin.y, width: lblReceiverAddressText.frame.width, height: lblReceiverAddressText.optimalHeight)
        lblReceiverAddressText.numberOfLines = 0
        let lblReceiverAddressTextHeight = lblReceiverAddressText.optimalHeight < Common.Size(s: 15) ? Common.Size(s: 15) : lblReceiverAddressText.optimalHeight
        
        lblReceiverFullName.frame = CGRect(x: lblReceiverFullName.frame.origin.x, y: lblReceiverAddressText.frame.origin.y + lblReceiverAddressTextHeight + Common.Size(s: 10), width: lblReceiverFullName.frame.width, height: lblReceiverFullName.frame.height)
        
        tfReceiverFullName.frame = CGRect(x: tfReceiverFullName.frame.origin.x, y: lblReceiverFullName.frame.origin.y + lblReceiverFullName.frame.height + Common.Size(s: 5), width: tfReceiverFullName.frame.width, height: tfReceiverFullName.frame.height)
        
        lblReceiverPhone.frame = CGRect(x: lblReceiverPhone.frame.origin.x, y: tfReceiverFullName.frame.origin.y + tfReceiverFullName.frame.height + Common.Size(s: 10), width: lblReceiverPhone.frame.width, height: lblReceiverPhone.frame.height)
        
        
        tfReceiverPhoneNumber.frame = CGRect(x: tfReceiverPhoneNumber.frame.origin.x, y: lblReceiverPhone.frame.origin.y + lblReceiverPhone.frame.height + Common.Size(s: 5), width: tfReceiverPhoneNumber.frame.width, height: tfReceiverPhoneNumber.frame.height)
        
        
        receiveInfoView.frame = CGRect(x: receiveInfoView.frame.origin.x, y: sendInfoView.frame.origin.y + sendInfoView.frame.height, width: receiveInfoView.frame.width, height: tfReceiverPhoneNumber.frame.origin.y + tfReceiverPhoneNumber.frame.height + Common.Size(s: 10))
        
        packageInfoView.frame = CGRect(x: packageInfoView.frame.origin.x, y: receiveInfoView.frame.origin.y + receiveInfoView.frame.height, width: packageInfoView.frame.width, height: packageInfoView.frame.height)
        
        scrollViewHeight = packageInfoView.frame.origin.y + packageInfoView.frame.height + Common.Size(s: 100)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    func setUpView() {
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        //--------------------------------
        sendInfoView = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: Common.Size(s: 200)))
        sendInfoView.backgroundColor = UIColor.white
        scrollView.addSubview(sendInfoView)
        
        let senderView = UIView(frame: CGRect(x: 0, y: 0, width: sendInfoView.frame.width, height: Common.Size(s: 40)))
        senderView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        sendInfoView.addSubview(senderView)
        
        let lbSendInfo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: senderView.frame.width - Common.Size(s: 50), height: senderView.frame.height))
        lbSendInfo.text = "THÔNG TIN NGƯỜI GỬI"
        lbSendInfo.textColor = UIColor.black
        lbSendInfo.font = UIFont.systemFont(ofSize: 15)
        senderView.addSubview(lbSendInfo)
        
        let btnUpdateSenderInfo = UIButton(frame: CGRect(x: lbSendInfo.frame.origin.x + lbSendInfo.frame.width, y: Common.Size(s: 10), width: Common.Size(s: 20), height: Common.Size(s: 20)))
        btnUpdateSenderInfo.setImage(#imageLiteral(resourceName: "edit"), for: .normal)
        senderView.addSubview(btnUpdateSenderInfo)
        btnUpdateSenderInfo.addTarget(self, action: #selector(updateSenderInfo), for: .touchUpInside)
        
        let lblSenderShop = UILabel(frame: CGRect(x: Common.Size(s: 15), y: senderView.frame.origin.x + senderView.frame.height + Common.Size(s: 10), width: (sendInfoView.frame.width - Common.Size(s: 15))/3, height: Common.Size(s: 15)))
        lblSenderShop.text = "Shop/PB gửi:"
        lblSenderShop.font = UIFont.systemFont(ofSize: 13)
        lblSenderShop.textColor = UIColor.lightGray
        sendInfoView.addSubview(lblSenderShop)
        
        lblSenderShopText = UILabel(frame: CGRect(x: lblSenderShop.frame.origin.x + lblSenderShop.frame.width + Common.Size(s: 5), y: lblSenderShop.frame.origin.y, width: sendInfoView.frame.width - lblSenderShop.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lblSenderShopText.font = UIFont.systemFont(ofSize: 13)
        lblSenderShopText.text = "\(senderObj?.OrganizationHierachyName ?? "")"
        sendInfoView.addSubview(lblSenderShopText)
        
        //
        let lblSenderAddress = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblSenderShopText.frame.origin.y + lblSenderShopText.frame.height + Common.Size(s: 5), width: lblSenderShop.frame.width, height: Common.Size(s: 15)))
        lblSenderAddress.text = "Địa chỉ gửi:"
        lblSenderAddress.font = UIFont.systemFont(ofSize: 13)
        lblSenderAddress.textColor = UIColor.lightGray
        sendInfoView.addSubview(lblSenderAddress)
        
        lblSenderAddressText = UILabel(frame: CGRect(x: lblSenderShopText.frame.origin.x, y: lblSenderAddress.frame.origin.y, width: lblSenderShopText.frame.width, height: Common.Size(s: 15)))
        lblSenderAddressText.text = "\(senderObj?.Address ?? "")"
        lblSenderAddressText.font = UIFont.systemFont(ofSize: 13)
        sendInfoView.addSubview(lblSenderAddressText)
        
        lblSenderAddressText.frame = CGRect(x: lblSenderAddressText.frame.origin.x, y: lblSenderAddressText.frame.origin.y, width: lblSenderAddressText.frame.width, height: lblSenderAddressText.optimalHeight)
        lblSenderAddressText.numberOfLines = 0
        let lblSenderAddressTextHeight = lblSenderAddressText.optimalHeight < Common.Size(s: 15) ? Common.Size(s: 15) : lblSenderAddressText.optimalHeight
        
        
        lblSenderPhone = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblSenderAddressText.frame.origin.y + lblSenderAddressTextHeight + Common.Size(s: 5), width: lblSenderShop.frame.width, height: Common.Size(s: 15)))
        lblSenderPhone.text = "SĐT người gửi:"
        lblSenderPhone.font = UIFont.systemFont(ofSize: 13)
        lblSenderPhone.textColor = UIColor.lightGray
        sendInfoView.addSubview(lblSenderPhone)
        
        lblSenderPhoneNumber = UILabel(frame: CGRect(x: lblSenderShopText.frame.origin.x, y: lblSenderPhone.frame.origin.y, width: lblSenderShopText.frame.width, height: Common.Size(s: 15)))
        lblSenderPhoneNumber.text = "\(senderObj?.SoDienThoaiNguoiGui ?? "")"
        lblSenderPhoneNumber.font = UIFont.systemFont(ofSize: 13)
        sendInfoView.addSubview(lblSenderPhoneNumber)
        
        sendInfoView.frame = CGRect(x: sendInfoView.frame.origin.x, y: sendInfoView.frame.origin.y, width: sendInfoView.frame.width, height: lblSenderPhoneNumber.frame.origin.y + lblSenderPhoneNumber.frame.height + Common.Size(s: 15))
        //--------------------------
        //Receiver view
        receiveInfoView = UIView(frame: CGRect(x: 0, y: sendInfoView.frame.origin.y + sendInfoView.frame.height + Common.Size(s: 10), width: scrollView.frame.width, height: Common.Size(s: 200)))
        receiveInfoView.backgroundColor = UIColor.white
        scrollView.addSubview(receiveInfoView)
        
        let receiverView = UIView(frame: CGRect(x: 0, y: 0, width: receiveInfoView.frame.width, height: Common.Size(s: 40)))
        receiverView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        receiveInfoView.addSubview(receiverView)
        
        let lbReceiverInfo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: receiverView.frame.width - Common.Size(s: 50), height: receiverView.frame.height))
        lbReceiverInfo.text = "THÔNG TIN NGƯỜI NHẬN"
        lbReceiverInfo.textColor = UIColor.black
        lbReceiverInfo.font = UIFont.systemFont(ofSize: 15)
        receiverView.addSubview(lbReceiverInfo)
        
        let btnUpdateReceiverInfo = UIButton(frame: CGRect(x: lbReceiverInfo.frame.origin.x + lbReceiverInfo.frame.width, y: Common.Size(s: 10), width: Common.Size(s: 20), height: Common.Size(s: 20)))
        btnUpdateReceiverInfo.setImage(#imageLiteral(resourceName: "edit"), for: .normal)
        receiverView.addSubview(btnUpdateReceiverInfo)
        btnUpdateReceiverInfo.addTarget(self, action: #selector(updateReceiverInfo), for: .touchUpInside)
        ///old receiver Shop/PB
        lblReceiverShop = UILabel(frame: CGRect(x: Common.Size(s: 15), y: receiverView.frame.origin.y + receiverView.frame.height + Common.Size(s: 10), width: receiveInfoView.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lblReceiverShop.text = "Shop/PB nhận:"
        lblReceiverShop.font = UIFont.systemFont(ofSize: 13)
        lblReceiverShop.textColor = UIColor.lightGray
        receiveInfoView.addSubview(lblReceiverShop)
        
        //        tfReceiverShopText = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblReceiverShop.frame.origin.y + lblReceiverShop.frame.height + Common.Size(s: 5), width: receiveInfoView.frame.width - Common.Size(s: 30), height: Common.Size(s: 30)))
        tfReceiverShopText = SearchTextField(frame: CGRect(x: Common.Size(s: 15), y: lblReceiverShop.frame.origin.y + lblReceiverShop.frame.height + Common.Size(s: 5), width: receiveInfoView.frame.width - Common.Size(s: 30), height: Common.Size(s: 30)))
        tfReceiverShopText.borderStyle = .roundedRect
        tfReceiverShopText.font = UIFont.systemFont(ofSize: 13)
        tfReceiverShopText.text = self.receiverObj?.OrganizationHierachyName ?? ""
        receiveInfoView.addSubview(tfReceiverShopText)
        
        
        for value in self.listShopPhongBan {
            itemsSearchShop.append(SearchTextFieldItem(title: value.FullName))
        }
        
        tfReceiverShopText.filterItems(itemsSearchShop)
        tfReceiverShopText.comparisonOptions = [.caseInsensitive]
        tfReceiverShopText.maxNumberOfResults = 10
        tfReceiverShopText.clearButtonMode = UITextField.ViewMode.whileEditing
        tfReceiverShopText.theme = SearchTextFieldTheme(cellHeight: 30, bgColor: UIColor (red: 1, green: 1, blue: 1, alpha: 1), borderColor: UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0), separatorColor: UIColor.clear, font: UIFont.systemFont(ofSize: 10), fontColor: UIColor.black)
        tfReceiverShopText.startVisible = true
        tfReceiverShopText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        
        ///new receiver Shop/PB
        lbNewlReceiverShop = UILabel(frame: CGRect(x: Common.Size(s: 15), y: receiverView.frame.origin.y + receiverView.frame.height + Common.Size(s: 10), width: receiveInfoView.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbNewlReceiverShop.text = "Shop/PB nhận mới(chưa tồn tại trên ht):"
        lbNewlReceiverShop.font = UIFont.systemFont(ofSize: 13)
        lbNewlReceiverShop.textColor = UIColor.lightGray
        receiveInfoView.addSubview(lbNewlReceiverShop)
        lbNewlReceiverShop.isHidden = true
        
        tfNewReceiverShopText = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblReceiverShop.frame.origin.y + lblReceiverShop.frame.height + Common.Size(s: 5), width: receiveInfoView.frame.width - Common.Size(s: 30), height: Common.Size(s: 30)))
        tfNewReceiverShopText.borderStyle = .roundedRect
        tfNewReceiverShopText.font = UIFont.systemFont(ofSize: 13)
        tfNewReceiverShopText.text = self.receiverObj?.OrganizationHierachyName ?? ""
        receiveInfoView.addSubview(tfNewReceiverShopText)
        tfNewReceiverShopText.isHidden = true
        tfNewReceiverShopText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        //----------------------
        
        
        let arrowImgView4 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let arrowImg4 = UIImageView(frame: CGRect(x: -5, y: 0, width: 15, height: 15))
        arrowImg4.image = #imageLiteral(resourceName: "ArrowDown-1")
        arrowImgView4.addSubview(arrowImg4)
        tfReceiverShopText.rightViewMode = .always
        tfReceiverShopText.rightView = arrowImgView4
        
        ///
        let lblReceiverAddress = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfReceiverShopText.frame.origin.y + tfReceiverShopText.frame.height + Common.Size(s: 10), width: lblSenderShop.frame.width, height: Common.Size(s: 15)))
        lblReceiverAddress.text = "Địa chỉ nhận:"
        lblReceiverAddress.font = UIFont.systemFont(ofSize: 13)
        lblReceiverAddress.textColor = UIColor.lightGray
        receiveInfoView.addSubview(lblReceiverAddress)
        
        lblReceiverAddressText = UILabel(frame: CGRect(x: lblReceiverAddress.frame.origin.x + lblReceiverAddress.frame.width, y: lblReceiverAddress.frame.origin.y , width: lblSenderShopText.frame.width, height: Common.Size(s: 15)))
        lblReceiverAddressText.text = self.receiverObj?.Address ?? ""
        lblReceiverAddressText.font = UIFont.systemFont(ofSize: 13)
        receiveInfoView.addSubview(lblReceiverAddressText)
        
        lblReceiverAddressText.frame = CGRect(x: lblReceiverAddressText.frame.origin.x, y: lblReceiverAddressText.frame.origin.y, width: lblReceiverAddressText.frame.width, height: lblReceiverAddressText.optimalHeight)
        lblReceiverAddressText.numberOfLines = 0
        let lblReceiverAddressTextHeight = lblReceiverAddressText.optimalHeight < Common.Size(s: 15) ? Common.Size(s: 15) : lblReceiverAddressText.optimalHeight
        
        lblReceiverFullName = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblReceiverAddressText.frame.origin.y + lblReceiverAddressTextHeight + Common.Size(s: 10), width: lblReceiverShop.frame.width, height: Common.Size(s: 15)))
        lblReceiverFullName.text = "Họ tên người nhận:"
        lblReceiverFullName.font = UIFont.systemFont(ofSize: 13)
        lblReceiverFullName.textColor = UIColor.lightGray
        receiveInfoView.addSubview(lblReceiverFullName)
        
        tfReceiverFullName = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblReceiverFullName.frame.origin.y + lblReceiverFullName.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 30)))
        tfReceiverFullName.borderStyle = .roundedRect
        tfReceiverFullName.font = UIFont.systemFont(ofSize: 13)
        receiveInfoView.addSubview(tfReceiverFullName)
        tfReceiverFullName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        lblReceiverPhone = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfReceiverFullName.frame.origin.y + tfReceiverFullName.frame.height + Common.Size(s: 10), width: lblReceiverShop.frame.width, height: Common.Size(s: 15)))
        lblReceiverPhone.text = "SĐT người nhận:"
        lblReceiverPhone.font = UIFont.systemFont(ofSize: 13)
        lblReceiverPhone.textColor = UIColor.lightGray
        receiveInfoView.addSubview(lblReceiverPhone)
        
        tfReceiverPhoneNumber = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblReceiverPhone.frame.origin.y + lblReceiverPhone.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 30)))
        tfReceiverPhoneNumber.borderStyle = .roundedRect
        tfReceiverPhoneNumber.keyboardType = .numberPad
        tfReceiverPhoneNumber.clearButtonMode = UITextField.ViewMode.whileEditing
        tfReceiverPhoneNumber.font = UIFont.systemFont(ofSize: 13)
        receiveInfoView.addSubview(tfReceiverPhoneNumber)
        tfReceiverPhoneNumber.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        receiveInfoView.frame = CGRect(x: receiveInfoView.frame.origin.x, y: receiveInfoView.frame.origin.y, width: receiveInfoView.frame.width, height: tfReceiverPhoneNumber.frame.origin.y + tfReceiverPhoneNumber.frame.height)
        
        //thog tin hang hoa view
        packageInfoView = UIView(frame: CGRect(x: 0, y: receiveInfoView.frame.origin.y + receiveInfoView.frame.height + Common.Size(s: 10), width: scrollView.frame.width, height: Common.Size(s: 400)))
        packageInfoView.backgroundColor = UIColor.white
        scrollView.addSubview(packageInfoView)
        
        let packageHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: packageInfoView.frame.width, height: Common.Size(s: 40)))
        packageHeaderView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        packageInfoView.addSubview(packageHeaderView)
        
        let lbPackageInfo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: packageHeaderView.frame.width - Common.Size(s: 50), height: packageHeaderView.frame.height))
        lbPackageInfo.text = "THÔNG TIN HÀNG HOÁ"
        lbPackageInfo.textColor = UIColor.black
        lbPackageInfo.font = UIFont.systemFont(ofSize: 15)
        packageHeaderView.addSubview(lbPackageInfo)
        
        //loai hang
        let lblPackageType = UILabel(frame: CGRect(x: Common.Size(s: 15), y: packageHeaderView.frame.origin.y + packageHeaderView.frame.height + Common.Size(s: 10), width: lblReceiverShop.frame.width, height: Common.Size(s: 15)))
        lblPackageType.text = "Loại hàng:"
        lblPackageType.font = UIFont.systemFont(ofSize: 13)
        lblPackageType.textColor = UIColor.lightGray
        packageInfoView.addSubview(lblPackageType)
        
        tfPackageTypeText = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblPackageType.frame.origin.y + lblPackageType.frame.height + Common.Size(s: 5), width: packageInfoView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfPackageTypeText.borderStyle = .roundedRect
        tfPackageTypeText.font = UIFont.systemFont(ofSize: 13)
        tfPackageTypeText.text = self.selectedLoaiHang?.Name ?? ""
        packageInfoView.addSubview(tfPackageTypeText)
        
        let tapShowLoaiHangHoa = UITapGestureRecognizer(target: self, action: #selector(showListHangHoa))
        tfPackageTypeText.isUserInteractionEnabled = true
        tfPackageTypeText.addGestureRecognizer(tapShowLoaiHangHoa)
        
        let arrowImgView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let arrowImg = UIImageView(frame: CGRect(x: -5, y: 0, width: 15, height: 15))
        arrowImg.image = #imageLiteral(resourceName: "ArrowDown-1")
        arrowImgView.addSubview(arrowImg)
        tfPackageTypeText.rightViewMode = .always
        tfPackageTypeText.rightView = arrowImgView
        
        //ten hang hoa chuyen
        let lblPackageName = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfPackageTypeText.frame.origin.y + tfPackageTypeText.frame.height + Common.Size(s: 10), width: lblReceiverShop.frame.width, height: Common.Size(s: 15)))
        lblPackageName.text = "Tên hàng hoá chuyển:"
        lblPackageName.font = UIFont.systemFont(ofSize: 13)
        lblPackageName.textColor = UIColor.lightGray
        packageInfoView.addSubview(lblPackageName)
        
        tfPackageTypeName = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblPackageName.frame.origin.y + lblPackageName.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfPackageTypeName.borderStyle = .roundedRect
        tfPackageTypeName.font = UIFont.systemFont(ofSize: 13)
        tfPackageTypeName.placeholder = " Nhập tên hàng hoá chuyển"
        packageInfoView.addSubview(tfPackageTypeName)
        tfPackageTypeName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        //so luong
        let lblSL = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfPackageTypeName.frame.origin.y + tfPackageTypeName.frame.height + Common.Size(s: 10), width: lblReceiverShop.frame.width, height: Common.Size(s: 15)))
        lblSL.text = "Số lượng:"
        lblSL.font = UIFont.systemFont(ofSize: 13)
        lblSL.textColor = UIColor.lightGray
        packageInfoView.addSubview(lblSL)
        
        tfPackageAmount = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblSL.frame.origin.y + lblSL.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfPackageAmount.borderStyle = .roundedRect
        tfPackageAmount.font = UIFont.systemFont(ofSize: 13)
        tfPackageAmount.placeholder = " Nhập số lượng"
        tfPackageAmount.keyboardType = .numberPad
        tfPackageAmount.clearButtonMode = UITextField.ViewMode.whileEditing
        packageInfoView.addSubview(tfPackageAmount)
        tfPackageAmount.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        //so kien
        let lblSoKien = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfPackageAmount.frame.origin.y + tfPackageAmount.frame.height + Common.Size(s: 10), width: lblReceiverShop.frame.width, height: Common.Size(s: 15)))
        lblSoKien.text = "Số kiện:"
        lblSoKien.font = UIFont.systemFont(ofSize: 13)
        lblSoKien.textColor = UIColor.lightGray
        packageInfoView.addSubview(lblSoKien)
        
        tfPackageCount = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblSoKien.frame.origin.y + lblSoKien.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfPackageCount.borderStyle = .roundedRect
        tfPackageCount.font = UIFont.systemFont(ofSize: 13)
        tfPackageCount.placeholder = " Nhập số kiện"
        tfPackageCount.keyboardType = .numberPad
        tfPackageCount.clearButtonMode = UITextField.ViewMode.whileEditing
        packageInfoView.addSubview(tfPackageCount)
        tfPackageCount.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        //trong luong
        
        let lblTrongLuong = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfPackageCount.frame.origin.y + tfPackageCount.frame.height + Common.Size(s: 10), width: lblReceiverShop.frame.width, height: Common.Size(s: 15)))
        lblTrongLuong.text = "Trọng lượng(kg):"
        lblTrongLuong.font = UIFont.systemFont(ofSize: 13)
        lblTrongLuong.textColor = UIColor.lightGray
        packageInfoView.addSubview(lblTrongLuong)
        
        tfPackageWeight = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblTrongLuong.frame.origin.y + lblTrongLuong.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfPackageWeight.borderStyle = .roundedRect
        tfPackageWeight.font = UIFont.systemFont(ofSize: 13)
        tfPackageWeight.placeholder = "Nhập trọng lượng"
        tfPackageWeight.clearButtonMode = UITextField.ViewMode.whileEditing
        packageInfoView.addSubview(tfPackageWeight)
        tfPackageWeight.delegate = self
        tfPackageWeight.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        //Dich vu.
        let lblDichVu = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfPackageWeight.frame.origin.y + tfPackageWeight.frame.height + Common.Size(s: 10), width: lblReceiverShop.frame.width, height: Common.Size(s: 15)))
        lblDichVu.text = "Dịch vụ:"
        lblDichVu.font = UIFont.systemFont(ofSize: 13)
        lblDichVu.textColor = UIColor.lightGray
        packageInfoView.addSubview(lblDichVu)
        
        tfPackageService = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblDichVu.frame.origin.y + lblDichVu.frame.height + Common.Size(s: 5), width: packageInfoView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfPackageService.borderStyle = .roundedRect
        tfPackageService.font = UIFont.systemFont(ofSize: 13)
        tfPackageService.delegate = self
        packageInfoView.addSubview(tfPackageService)
        
        let tapShowService = UITapGestureRecognizer(target: self, action: #selector(showListDichVu))
        tfPackageService.isUserInteractionEnabled = true
        tfPackageService.addGestureRecognizer(tapShowService)

        let arrowImgView2 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let arrowImg2 = UIImageView(frame: CGRect(x: -5, y: 0, width: 15, height: 15))
        arrowImg2.image = #imageLiteral(resourceName: "ArrowDown-1")
        arrowImgView2.addSubview(arrowImg2)
        tfPackageService.rightViewMode = .always
        tfPackageService.rightView = arrowImgView2
        
        //nha van chuyen
        let lblNhaVanChuyen = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfPackageService.frame.origin.y + tfPackageService.frame.height + Common.Size(s: 10), width: lblReceiverShop.frame.width, height: Common.Size(s: 15)))
        lblNhaVanChuyen.text = "Nhà vận chuyển:"
        lblNhaVanChuyen.font = UIFont.systemFont(ofSize: 13)
        lblNhaVanChuyen.textColor = UIColor.lightGray
        packageInfoView.addSubview(lblNhaVanChuyen)
        
        tfPackageDistribute = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblNhaVanChuyen.frame.origin.y + lblNhaVanChuyen.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfPackageDistribute.borderStyle = .roundedRect
        tfPackageDistribute.font = UIFont.systemFont(ofSize: 13)
        packageInfoView.addSubview(tfPackageDistribute)

        if self.Is_Shop {
            tfPackageDistribute.isEnabled = false
        } else {
            tfPackageDistribute.isEnabled = true
        }

        let tapShowDistribute = UITapGestureRecognizer(target: self, action: #selector(showListNhaVanChuyen))
        tfPackageDistribute.isUserInteractionEnabled = true
        tfPackageDistribute.addGestureRecognizer(tapShowDistribute)
        
        let arrowImgView3 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let arrowImg3 = UIImageView(frame: CGRect(x: -5, y: 0, width: 15, height: 15))
        arrowImg3.image = #imageLiteral(resourceName: "ArrowDown-1")
        arrowImgView3.addSubview(arrowImg3)
        tfPackageDistribute.rightViewMode = .always
        tfPackageDistribute.rightView = arrowImgView3
        
        //Hinh thuc thanh toan
        let lblHTTT = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfPackageDistribute.frame.origin.y + tfPackageDistribute.frame.height + Common.Size(s: 10), width: lblReceiverShop.frame.width, height: Common.Size(s: 15)))
        lblHTTT.text = "Hình thức thanh toán:"
        lblHTTT.font = UIFont.systemFont(ofSize: 13)
        lblHTTT.textColor = UIColor.lightGray
        packageInfoView.addSubview(lblHTTT)
        
        tfPackagePaymentType = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblHTTT.frame.origin.y + lblHTTT.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfPackagePaymentType.borderStyle = .roundedRect
        tfPackagePaymentType.font = UIFont.systemFont(ofSize: 13)
        tfPackagePaymentType.text = selectedHTTT?.Name ?? ""
        packageInfoView.addSubview(tfPackagePaymentType)
        
        let tapShowHTTT = UITapGestureRecognizer(target: self, action: #selector(showListHinhThucThanhToan))
        tfPackagePaymentType.isUserInteractionEnabled = true
        tfPackagePaymentType.addGestureRecognizer(tapShowHTTT)
        
        let arrowImgView5 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let arrowImg5 = UIImageView(frame: CGRect(x: -5, y: 0, width: 15, height: 15))
        arrowImg5.image = #imageLiteral(resourceName: "ArrowDown-1")
        arrowImgView5.addSubview(arrowImg5)
        tfPackagePaymentType.rightViewMode = .always
        tfPackagePaymentType.rightView = arrowImgView5
        
        //cuoc phi min
        let lblCuocPhi = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfPackagePaymentType.frame.origin.y + tfPackagePaymentType.frame.height + Common.Size(s: 10), width: lblReceiverShop.frame.width, height: Common.Size(s: 15)))
        lblCuocPhi.text = "Cước phí min:"
        lblCuocPhi.font = UIFont.systemFont(ofSize: 13)
        lblCuocPhi.textColor = UIColor.lightGray
        packageInfoView.addSubview(lblCuocPhi)
        
        tfCuocPhiMin = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblCuocPhi.frame.origin.y + lblCuocPhi.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfCuocPhiMin.borderStyle = .roundedRect
        tfCuocPhiMin.font = UIFont.systemFont(ofSize: 13)
        tfCuocPhiMin.isEnabled = false
        packageInfoView.addSubview(tfCuocPhiMin)
        
        //ghi chu
        
        let lblNote = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfCuocPhiMin.frame.origin.y + tfCuocPhiMin.frame.height + Common.Size(s: 10), width: lblReceiverShop.frame.width, height: Common.Size(s: 15)))
        lblNote.text = "Ghi chú:"
        lblNote.font = UIFont.systemFont(ofSize: 13)
        lblNote.textColor = UIColor.lightGray
        packageInfoView.addSubview(lblNote)
        
        tfPackageNote = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblNote.frame.origin.y + lblNote.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfPackageNote.borderStyle = .roundedRect
        tfPackageNote.font = UIFont.systemFont(ofSize: 13)
        tfPackageNote.placeholder = "Nhập ghi chú"
        packageInfoView.addSubview(tfPackageNote)
        tfPackageNote.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        btnSend = UIButton(frame: CGRect(x: Common.Size(s: 15), y: tfPackageNote.frame.origin.y +  tfPackageNote.frame.height + Common.Size(s: 15), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        btnSend.setTitle("GỬI", for: .normal)
        btnSend.layer.cornerRadius = 5
        btnSend.backgroundColor = UIColor(red: 34/255, green: 134/255, blue: 70/255, alpha: 1)
        self.btnSend.isHidden = false
        packageInfoView.addSubview(btnSend)
        btnSend.addTarget(self, action: #selector(sendCallog), for: .touchUpInside)
        
        
        scrollView.bringSubviewToFront(tfReceiverShopText)
        packageInfoView.frame = CGRect(x: packageInfoView.frame.origin.x, y: packageInfoView.frame.origin.y, width: packageInfoView.frame.width, height: btnSend.frame.origin.y + btnSend.frame.height)
        
        scrollViewHeight = packageInfoView.frame.origin.y + packageInfoView.frame.height + Common.Size(s: 100)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        if self.isMirae {
            
            if self.receiverObj == nil {
                self.receiverObj = BillLoadDiaChiNhan(Address: self.miraeBillInfo?.DiaChi ?? "", HoTenNguoiNhan: self.miraeBillInfo?.NguoiNhan ?? "", Id: 0, MaHuyen: self.miraeBillInfo?.QuanHuyen ?? 0, MaTinh: self.miraeBillInfo?.TinhTP ?? 0, OrganizationHierachyCode: "", OrganizationHierachyCodeSend: "", OrganizationHierachyName: self.miraeBillInfo?.Shop_PB ?? "", SoDienThoaiNguoiNhan: self.miraeBillInfo?.SDT ?? "", TenHuyen: "", TenTinh: "", TypeAddress: 0)
            } else {
                //update Receiver info
                self.receiverObj?.Address = self.miraeBillInfo?.DiaChi ?? ""
                self.receiverObj?.HoTenNguoiNhan = self.miraeBillInfo?.NguoiNhan ?? ""
                self.receiverObj?.MaHuyen = self.miraeBillInfo?.QuanHuyen ?? 0
                self.receiverObj?.MaTinh = self.miraeBillInfo?.TinhTP ?? 0
                self.receiverObj?.SoDienThoaiNguoiNhan = self.miraeBillInfo?.SDT ?? ""
                self.receiverObj?.OrganizationHierachyName = self.miraeBillInfo?.Shop_PB ?? ""
            }
            
            for tinh in self.listTinhTp {
                if tinh.ID == self.miraeBillInfo?.TinhTP {
                    self.receiverObj?.TenTinh = tinh.Name
                }
            }
            for huyen in self.listQuanHuyen {
                if huyen.ID == self.miraeBillInfo?.QuanHuyen {
                    self.receiverObj?.TenHuyen = huyen.Name
                }
            }
            
            //update số lượng from mirae
            let listProcessID = self.ProcessID.components(separatedBy: ",")
            self.soLuongNum = listProcessID.count
            
            //update UI data
            
            self.tfPackageAmount.text = "\(self.soLuongNum)"
            self.tfPackageAmount.isEnabled = false
            self.tfReceiverShopText.text = self.miraeBillInfo?.Shop_PB ?? ""
            self.lblReceiverAddressText.text = self.miraeBillInfo?.DiaChi ?? ""
            self.tfReceiverFullName.text = self.miraeBillInfo?.NguoiNhan ?? ""
            self.tfReceiverPhoneNumber.text = self.miraeBillInfo?.SDT ?? ""
            self.tfPackageTypeName.text = self.miraeBillInfo?.TenHangHoa ?? ""
            self.tfPackageService.text = self.miraeBillInfo?.DichVu ?? ""
            //            self.tfPackageService.isEnabled = false
            
            for pb in self.listShopPhongBan {
                if pb.Name == self.miraeBillInfo?.Shop_PB {
                    self.selectedPB = pb
                }
            }
            
            if self.selectedPB == nil {
                self.showAlert(title: "Thông báo", message: "Bạn chưa cập nhật shop PB nhận!")
            }
            
            //update dich vu from mirae
            for item in self.listService {
                if item.Code == self.miraeBillInfo?.DichVu {
                    self.tfPackageService.text = item.Name
                    self.selectedDichVu = item
                }
            }
            
            self.loadNhaVanChuyen()
            self.updateUIAfterUpdateReceiverInfo()
            
        } else {
            self.tfPackageAmount.isEnabled = true
            //            self.tfPackageService.isEnabled = true
            if self.receiverObj == nil {
                self.tfReceiverShopText.text = listShopPBName[0]
                self.loadDiaChiNhan(maPB: listShopPhongBan[0].Code )
            } else {
                self.tfReceiverShopText.text = self.receiverObj?.OrganizationHierachyName ?? ""
                self.lblReceiverAddressText.text = self.receiverObj?.Address ?? ""
                self.tfReceiverFullName.text = self.receiverObj?.HoTenNguoiNhan ?? ""
                self.tfReceiverPhoneNumber.text = self.receiverObj?.SoDienThoaiNguoiNhan ?? ""
                
            }
            
            //load dia chi nhan after chọn shop nhan
            tfReceiverShopText.itemSelectionHandler = { items, itemPosition in
                self.tfReceiverShopText.text = items[itemPosition].title
                
                for i in self.listShopPhongBan {
                    if i.FullName == items[itemPosition].title {
                        self.loadDiaChiNhan(maPB: i.Code)
                    }
                }
            }
        }
    }
    
    @objc func sendCallog() {
        var receiverShopName = ""
        if self.tfReceiverShopText.isHidden == true {
            if self.tfNewReceiverShopText.text == "" {
                self.showAlert(title: "Thông báo", message: "Bạn chưa nhập Shop/PB nhận!")
                return
            } else {
                receiverShopName = self.tfNewReceiverShopText.text ?? ""
            }
        } else {
            if self.tfReceiverShopText.text == "" {
                self.showAlert(title: "Thông báo", message: "Bạn chưa chọn Shop/PB nhận!")
                return
            } else {
                receiverShopName = self.tfReceiverShopText.text ?? ""
            }
        }
        
        guard let receiverFullName = self.tfReceiverFullName.text?.trim(), !receiverFullName.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa họ tên người nhận!")
            return
        }
        guard let receiverPhone = self.tfReceiverPhoneNumber.text?.trim(), !receiverPhone.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập SĐT người nhận!")
            return
        }
        guard let loaiHangText = self.tfPackageTypeText.text?.trim(), !loaiHangText.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa chọn loại hàng!")
            return
        }
        guard let tenHang = self.tfPackageTypeName.text?.trim(), !tenHang.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập tên hàng chuyển!")
            return
        }
        guard let soLuong = self.tfPackageAmount.text?.trim(), !soLuong.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập số lượng!")
            return
        }
        guard let soKien = self.tfPackageCount.text?.trim(), !soKien.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập số kiện!")
            return
        }
        guard let trongLuong = self.tfPackageWeight.text?.trim(), !trongLuong.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập trọng lượng!")
            return
        }
        
        guard let dichVu = self.tfPackageService.text?.trim(), !dichVu.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa chọn dịch vụ!")
            return
        }
        guard let hinhThucThanhToan = self.tfPackagePaymentType.text?.trim(), !hinhThucThanhToan.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa chọn hình thức thanh toán!")
            return
        }
        
        if (dichVu == " Hỏa tốc") || (dichVu == "Hỏa tốc") {
            guard let note = self.tfPackageNote.text, !note.isEmpty else {
                self.showAlert(title: "Thông báo", message: "Lỗi Tạo CallLog! Vui lòng nhập \"Lý do gửi\" ở cột \"Ghi chú\" khi bạn chọn dịch vụ \"Hỏa tốc\"".htmlToString)
                return
            }
        }
        //update receiverObj
        self.receiverObj?.HoTenNguoiNhan = self.tfReceiverFullName.text ?? ""
        self.receiverObj?.SoDienThoaiNguoiNhan = self.tfReceiverPhoneNumber.text ?? ""
        
        if self.selectedDistribute?.STT == 1 {
            self.is_NVCToiUu = 1
        } else {
            self.is_NVCToiUu = 0
        }
        
        
        self.scrollView.setContentOffset(CGPoint.zero, animated: true)
        self.btnSend.isHidden = true
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.listDistribute = mCallLogApiManager.Bill__LoadNhaVanChuyen(IdTinhDi: "\(self.senderObj?.MaTinh ?? 0)", IdTinhDen: "\(self.receiverObj?.MaTinh ?? 0)", ShopDiB1: self.senderObj?.OrganizationHierachyCode ?? "", ShopDenB1: self.receiverObj?.OrganizationHierachyCode ?? "", TrongLuong: self.tfPackageWeight?.text ?? "", DichVu: self.selectedDichVu?.Name ?? "").Data ?? []
            
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if self.listDistribute.count > 0 {
                    // create bill
                    if self.selectedDichVu?.Is_ShowPopupConfirm == 1 {
                        let alertVC = UIAlertController(title: "Thông báo", message: "\(self.selectedDichVu?.Msg_ShowPopupConfirm ?? "Cước Hỏa tốc cao gấp 10 lần so với cước Chuyển phát nhanh, chọn dịch vụ Hỏa tốc sẽ đẩy CallLog tới ASM/Trưởng bộ phận duyệt!")", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "OK", style: .default) { (action) in
                            
                            let listBillCreate = mCallLogApiManager.Bill__CreateBill(
                                p_Title: self.callogTitle,
                                p_Cc: self.arrayCCCode,
                                p_Sender: "\(Cache.user?.UserName ?? "")",
                                p_MaShopPhongBanGui: "\(self.senderObj?.OrganizationHierachyCode ?? "")",
                                p_MaShopPhongBanGuiKerry: "\(self.senderObj?.OrganizationHierachyCodeSend ?? "")",
                                p_DiaChiGui: self.lblSenderAddressText.text ?? "",
                                p_MaTinhThanhGui: "\(self.senderObj?.MaTinh ?? 0)",
                                p_TenTinhThanhGui: self.senderObj?.TenTinh ?? "",
                                p_MaQuanHuyenGui: "\(self.senderObj?.MaHuyen ?? 0)",
                                p_TenQuanHuyenGui: self.senderObj?.TenHuyen ?? "",
                                p_SoDienThoaiNguoiGui: self.lblSenderPhoneNumber.text ?? "",
                                p_MaShopPhongBanNhan: self.selectedPB?.Code ?? "",
                                p_TenShopPhongBanNhan: receiverShopName,
                                p_MaShopPhongBanNhanKerry: self.receiverObj?.OrganizationHierachyCodeSend ?? "",
                                p_DiaChiNhan: self.lblReceiverAddressText.text ?? "",
                                p_MaTinhThanhNhan: "\(self.receiverObj?.MaTinh ?? 0)",
                                p_TenTinhThanhNhan: self.receiverObj?.TenTinh ?? "",
                                p_MaQuanHuyenNhan: "\(self.receiverObj?.MaHuyen ?? 0)",
                                p_TenQuanHuyenNhan: self.receiverObj?.TenHuyen ?? "",
                                p_HoTenNguoiNhan: self.tfReceiverFullName.text ?? "",
                                p_SoDienThoaiNguoiNhan: self.tfReceiverPhoneNumber.text ?? "",
                                p_MaLoaiHangHoa: "\(self.selectedLoaiHang?.Code ?? 0)",
                                p_NoiDungHangHoa: self.tfPackageTypeName.text ?? "",
                                p_SoLuong: self.tfPackageAmount.text ?? "",
                                p_SoKien: self.tfPackageCount.text ?? "",
                                p_TrongLuong: self.tfPackageWeight.text ?? "",
                                p_MaNhaVanChuyen: self.selectedDistribute?.MaNVC ?? "",
                                TenDichVuVanChuyen: "\(self.selectedDistribute?.TenDichVu ?? "")",
                                p_MaHinhThucThanhToan: "\(self.selectedHTTT?.Code ?? 0)",
                                p_GhiChu: self.tfPackageNote.text ?? "",
                                p_CuocPhiMin: "\(self.selectedDistribute?.CuocPhiMin ?? "")",
                                Is_NVCToiUu: "\(self.is_NVCToiUu)").Data ?? []
                            
                            WaitingNetworkResponseAlert.DismissWaitingAlert {
                                if listBillCreate.count > 0 {
                                    let bill = listBillCreate[0]
                                    if bill.Result == 1 {
                                        if bill.Carrier_Result == 1 {
                                            if self.isMirae {
                                                self.sendDocumentInfoFromMirae(WaybillNumber: "\(bill.BillNum ?? "")", ListProcessID: self.ProcessID, billRequestID: bill.BillReq ?? 0)
                                            } else {
                                                let alert = UIAlertController(title: "Thông báo", message: "\(bill.Msg?.htmlToString ?? "Tạo CallLog Bill Thành công!")", preferredStyle: .alert)
                                                let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                                    for vc in self.navigationController?.viewControllers ?? [] {
                                                        if vc is BillVCGeneralInfoViewController {
                                                            self.navigationController?.popToViewController(vc, animated: true)
                                                        }
                                                    }
                                                })
                                                alert.addAction(action)
                                                self.present(alert, animated: true, completion: nil)
                                            }
                                            
                                        } else {
                                            self.btnSend.isHidden = false
                                            self.showAlert(title: "Thông báo", message: "\(bill.Carrier_Msg?.htmlToString ?? "")")
                                        }
                                    } else {
                                        self.btnSend.isHidden = false
                                        self.showAlert(title: "Thông báo", message: "\(bill.Msg?.htmlToString ?? "Tạo CallLog Bill thất bại!")")
                                    }
                                } else {
                                    debugPrint("Không tạo callog được!")
                                    self.btnSend.isHidden = false
                                    self.showAlert(title: "Thông báo", message: "Tạo CallLog Bill thất bại!")
                                }
                            }
                        }
                        let actionCancel = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
                        alertVC.addAction(action)
                        alertVC.addAction(actionCancel)
                        self.present(alertVC, animated: true, completion: nil)
                    } else {
                        
                        let listBillCreate = mCallLogApiManager.Bill__CreateBill(
                            p_Title: self.callogTitle,
                            p_Cc: self.arrayCCCode,
                            p_Sender: "\(Cache.user?.UserName ?? "")",
                            p_MaShopPhongBanGui: "\(self.senderObj?.OrganizationHierachyCode ?? "")",
                            p_MaShopPhongBanGuiKerry: "\(self.senderObj?.OrganizationHierachyCodeSend ?? "")",
                            p_DiaChiGui: self.lblSenderAddressText.text ?? "",
                            p_MaTinhThanhGui: "\(self.senderObj?.MaTinh ?? 0)",
                            p_TenTinhThanhGui: self.senderObj?.TenTinh ?? "",
                            p_MaQuanHuyenGui: "\(self.senderObj?.MaHuyen ?? 0)",
                            p_TenQuanHuyenGui: self.senderObj?.TenHuyen ?? "",
                            p_SoDienThoaiNguoiGui: self.lblSenderPhoneNumber.text ?? "",
                            p_MaShopPhongBanNhan: self.selectedPB?.Code ?? "",
                            p_TenShopPhongBanNhan: receiverShopName,
                            p_MaShopPhongBanNhanKerry: self.receiverObj?.OrganizationHierachyCodeSend ?? "",
                            p_DiaChiNhan: self.lblReceiverAddressText.text ?? "",
                            p_MaTinhThanhNhan: "\(self.receiverObj?.MaTinh ?? 0)",
                            p_TenTinhThanhNhan: self.receiverObj?.TenTinh ?? "",
                            p_MaQuanHuyenNhan: "\(self.receiverObj?.MaHuyen ?? 0)",
                            p_TenQuanHuyenNhan: self.receiverObj?.TenHuyen ?? "",
                            p_HoTenNguoiNhan: self.tfReceiverFullName.text ?? "",
                            p_SoDienThoaiNguoiNhan: self.tfReceiverPhoneNumber.text ?? "",
                            p_MaLoaiHangHoa: "\(self.selectedLoaiHang?.Code ?? 0)",
                            p_NoiDungHangHoa: self.tfPackageTypeName.text ?? "",
                            p_SoLuong: self.tfPackageAmount.text ?? "",
                            p_SoKien: self.tfPackageCount.text ?? "",
                            p_TrongLuong: self.tfPackageWeight.text ?? "",
                            p_MaNhaVanChuyen: self.selectedDistribute?.MaNVC ?? "",
                            TenDichVuVanChuyen: "\(self.selectedDistribute?.TenDichVu ?? "")",
                            p_MaHinhThucThanhToan: "\(self.selectedHTTT?.Code ?? 0)",
                            p_GhiChu: self.tfPackageNote.text ?? "",
                            p_CuocPhiMin: "\(self.selectedDistribute?.CuocPhiMin ?? "")",
                            Is_NVCToiUu: "\(self.is_NVCToiUu)").Data ?? []
                        
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            if listBillCreate.count > 0 {
                                let bill = listBillCreate[0]
                                if bill.Result == 1 {
                                    if bill.Carrier_Result == 1 {
                                        if self.isMirae {
                                            self.sendDocumentInfoFromMirae(WaybillNumber: "\(bill.BillNum ?? "")", ListProcessID: self.ProcessID, billRequestID: bill.BillReq ?? 0)
                                        } else {
                                            let alert = UIAlertController(title: "Thông báo", message: "\(bill.Msg?.htmlToString ?? "Tạo CallLog Bill Thành công!")", preferredStyle: .alert)
                                            let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                                for vc in self.navigationController?.viewControllers ?? [] {
                                                    if vc is BillVCGeneralInfoViewController {
                                                        self.navigationController?.popToViewController(vc, animated: true)
                                                    }
                                                }
                                            })
                                            alert.addAction(action)
                                            self.present(alert, animated: true, completion: nil)
                                        }
                                        
                                    } else {
                                        self.btnSend.isHidden = false
                                        self.showAlert(title: "Thông báo", message: "\(bill.Carrier_Msg?.htmlToString ?? "")")
                                    }
                                } else {
                                    self.btnSend.isHidden = false
                                    self.showAlert(title: "Thông báo", message: "\(bill.Msg?.htmlToString ?? "Tạo CallLog Bill thất bại!")")
                                }
                            } else {
                                debugPrint("Không tạo callog được!")
                                self.btnSend.isHidden = false
                                self.showAlert(title: "Thông báo", message: "Tạo CallLog Bill thất bại!")
                            }
                        }
                    }
                } else {
                    self.btnSend.isHidden = false
                    self.showAlert(title: "Thông báo", message: "Không có danh sách Nhà vận chuyển!")
                }
            }
        }
    }
    
    func sendDocumentInfoFromMirae(WaybillNumber: String, ListProcessID: String, billRequestID: Int) {
        MPOSAPIManager.mpos_FRT_Mirae_Send_Documents_Info(WaybillNumber: "\(WaybillNumber)", ListProcessID: ListProcessID, handler: { (rsCode, message, err) in
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if err.count <= 0 {
                    if rsCode == 1 {
                        let alert = UIAlertController(title: "Thông báo", message: "\(message)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                            self.btnSend.isHidden = true
                            let nc = NotificationCenter.default
                            nc.post(name: Notification.Name("LoadMiraeCT"), object: nil)
                            self.navigationController?.popViewController(animated: true)
                        })
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    } else { // Gửi chứng từ Mirae thất bại
                        let alert = UIAlertController(title: "Thông báo", message: "\(message)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                            self.btnSend.isHidden = false
                            //Huỷ calllog
                            self.cancelBill(requestID: billRequestID)
                        })
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                        self.btnSend.isHidden = false
                    })
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        })

    }
    
    func cancelBill(requestID: Int) {
        let rs = mCallLogApiManager.Bill__CancelBill(RequestId: "\(requestID)").Data ?? []
        WaitingNetworkResponseAlert.DismissWaitingAlert {
            if rs.count > 0 {
                if rs[0].Result == 1 {
                    self.showAlert(title: "Thông báo", message: "\(rs[0].Msg ?? "Hủy CallLog thành công!")")
                } else {
                    self.showAlert(title: "Thông báo", message: "\(rs[0].Msg ?? "Hủy CallLog thất bại!")")
                }
            } else {
                self.showAlert(title: "Thông báo", message: "load API ERR!")
            }
        }
    }
    
    @objc func updateSenderInfo() {
        let newViewController = SenderInfoUpdateViewController()
        newViewController.senderPhone = self.lblSenderPhoneNumber.text ?? ""
        newViewController.senderObj = self.senderObj
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    @objc func updateReceiverInfo() {
        let newViewController = ReceiverUpdateViewController()
        newViewController.receiverPhone = self.tfReceiverPhoneNumber.text ?? ""
        newViewController.receiverShopName = self.tfReceiverShopText.text ?? ""
        newViewController.receiverFullName = self.tfReceiverFullName.text ?? ""
        newViewController.receiveObj = self.receiverObj
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    @objc func showListShopPB() {
        DropDown.setupDefaultAppearance();
        
        dropShopPB.dismissMode = .onTap
        dropShopPB.direction = .any
        
        dropShopPB.anchorView = tfReceiverShopText;
        DropDown.startListeningToKeyboard();
        
        //Setup datasources
        dropShopPB.dataSource = self.listShopPBName;
        //        dropShopPB.selectRow(0);
        self.dropShopPB.show()
        
        dropShopPB.selectionAction = { [weak self] (index, item) in
            
            self?.listShopPhongBan.forEach{
                if($0.FullName == item){
                    self?.selectedPB = $0
                    self?.tfReceiverShopText.text = " \(item)"
                    self?.loadDiaChiNhan(maPB: $0.Code )
                }
            }
        }
    }
    
    @objc func showListHangHoa() {
        DropDown.setupDefaultAppearance();
        
        dropHangHoa.dismissMode = .onTap
        dropHangHoa.direction = .any
        
        dropHangHoa.anchorView = tfPackageTypeText;
        DropDown.startListeningToKeyboard();
        
        //Setup datasources
        dropHangHoa.dataSource = self.listPackageName;
        dropHangHoa.selectRow(0);
        self.dropHangHoa.show()
        
        dropHangHoa.selectionAction = { [weak self] (index, item) in
            self?.listPackage.forEach{
                if($0.Name == item){
                    self?.selectedLoaiHang = $0
                    self?.tfPackageTypeText.text = " \(item)"
                }
            }
        }
    }
    
    @objc func showListNhaVanChuyen() {
        DropDown.setupDefaultAppearance();
        
        dropNhaVanChuyen.dismissMode = .onTap
        dropNhaVanChuyen.direction = .any
        
        dropNhaVanChuyen.anchorView = tfPackageDistribute;
        DropDown.startListeningToKeyboard();
        
        //Setup datasources
        dropNhaVanChuyen.dataSource = self.listDistributeName;
        dropNhaVanChuyen.selectRow(0);
        self.dropNhaVanChuyen.show()
        
        dropNhaVanChuyen.selectionAction = { [weak self] (index, item) in
            self?.listDistribute.forEach{
                if($0.TenNVC == item){
                    self?.selectedDistribute = $0
                    self?.tfPackageDistribute.text = " \(item)"
                    let cuocPhi = Int(self?.selectedDistribute?.CuocPhiMin ?? "")
                    self?.tfCuocPhiMin.text = "\(Common.convertCurrencyV2(value: cuocPhi ?? 0))"
                }
            }
        }
        
    }
    
    @objc func showListDichVu() {
        DropDown.setupDefaultAppearance();
        
        dropDichVu.dismissMode = .onTap
        dropDichVu.direction = .any
        
        dropDichVu.anchorView = tfPackageService;
        DropDown.startListeningToKeyboard();
        
        //Setup datasources
        dropDichVu.dataSource = self.listServiceName;
        //        dropDichVu.selectRow(0);
        self.dropDichVu.show()
        
        dropDichVu.selectionAction = { [weak self] (index, item) in
            self?.listService.forEach{
                if($0.Name == item){
                    self?.selectedDichVu = $0
                    self?.tfPackageService.text = " \(item)"
//                    self?.tfPackageService.resignFirstResponder()
                    self?.loadNhaVanChuyen()
                }
            }
        }
    }
    
    @objc func showListHinhThucThanhToan() {
        DropDown.setupDefaultAppearance();
        
        dropHinhThucThanhToan.dismissMode = .onTap
        dropHinhThucThanhToan.direction = .any
        
        dropHinhThucThanhToan.anchorView = tfPackagePaymentType;
        DropDown.startListeningToKeyboard();
        
        //Setup datasources
        dropHinhThucThanhToan.dataSource = self.listPaymentTypeName;
        dropHinhThucThanhToan.selectRow(0);
        self.dropHinhThucThanhToan.show()
        
        dropHinhThucThanhToan.selectionAction = { [weak self] (index, item) in
            self?.listHTTT.forEach{
                if($0.Name == item){
                    self?.selectedHTTT = $0
                    self?.tfPackagePaymentType.text = " \(item)"
                }
            }
        }
    }
    
    func loadTitle() {
        DispatchQueue.main.async {
            let listTitle = mCallLogApiManager.Bill__LoadTitle().Data ?? []
            if listTitle.count > 0 {
                self.callogTitle = listTitle[0].Title ?? ""
            }
        }
    }
    
    func checkIsShop() {
        DispatchQueue.main.async {
            let list = mCallLogApiManager.Bill__KiemTraThongTinUser().Data ?? []
            if list.count > 0 {
                if list[0].Is_Shop == 0 {
                    self.Is_Shop = false
                } else {
                    self.Is_Shop = true
                }
            } else {
                debugPrint("Không lấy được danh sách Bill__KiemTraThongTinUser")
            }
        }
    }
    
    func loadTinhTp() {
        self.listTinhTp.removeAll()
        DispatchQueue.main.async {
            mCallLogApiManager.Bill__LoadTinhThanhPho(handler: { (resultsTinh, err) in
                if resultsTinh.count > 0 {
                    for item in resultsTinh {
                        self.listTinhTp.append(item)
                    }
                } else {
                    debugPrint("Không lấy được danh sách listTinhTpName")
                }
            })
        }
    }
    
    func loadQuanHuyen() {
        self.listQuanHuyen.removeAll()
        DispatchQueue.main.async {
            mCallLogApiManager.Bill__LoadQuanHuyen(handler: { (resultsQuanHuyen, err) in
                
                if resultsQuanHuyen.count > 0 {
                    for item in resultsQuanHuyen {
                        self.listQuanHuyen.append(item)
                    }
                } else {
                    debugPrint("Không lấy được danh sách listQuanHuyen")
                }
            })
        }
    }
    
    func loadDiaChiNhan(maPB: String) {
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            mCallLogApiManager.Bill__LoadDiaChiNhan(p_MaShopPhongBan: maPB, handler: { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if results.count > 0 {
                        self.receiverObj = results[0]
                        self.lblReceiverAddressText.text = " \(self.receiverObj?.Address ?? "")"
                        self.tfReceiverPhoneNumber.text = " \(self.receiverObj?.SoDienThoaiNguoiNhan ?? "")"
                        self.tfReceiverFullName.text = " \(self.receiverObj?.HoTenNguoiNhan ?? "")"
                    } else {
                        debugPrint("Không lấy được danh sách DiaChiNhan")
                        self.lblReceiverAddressText.text = ""
                        self.tfReceiverPhoneNumber.text = ""
                        self.tfReceiverFullName.text = ""
                    }
                    self.loadNhaVanChuyen()
                    self.updateUIAfterUpdateReceiverInfo()
                }
                
            })
        }
    }
    
    func loadHangHoa() {
        self.listPackageName.removeAll()
        DispatchQueue.main.async {
            self.listPackage = mCallLogApiManager.Bill__LoadLoaiHang().Data ?? []
            if self.listPackage.count > 0 {
                for item in self.listPackage {
                    self.listPackageName.append(item.Name ?? "")
                }
                
                self.selectedLoaiHang = self.listPackage[0]
                
            } else {
                self.showAlert(title: "Thông báo", message: "Không có danh sách loại hàng!")
            }
        }
    }
    
    func loadNhaVanChuyen() {
        
        guard let dichVu = self.tfPackageService.text, !dichVu.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Chọn dịch vụ để lấy thông tin nhà vận chuyển!")
            return
        }
        
        guard let trongLuong = self.tfPackageWeight.text, !trongLuong.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Nhập trọng lượng để lấy thông tin nhà vận chuyển!")
            return
        }
        
        self.view.endEditing(true)
        
        self.listDistribute.removeAll()
        DispatchQueue.main.async {
            self.listDistribute = mCallLogApiManager.Bill__LoadNhaVanChuyen(IdTinhDi: "\(self.senderObj?.MaTinh ?? 0)", IdTinhDen: "\(self.receiverObj?.MaTinh ?? 0)", ShopDiB1: self.senderObj?.OrganizationHierachyCode ?? "", ShopDenB1: self.receiverObj?.OrganizationHierachyCode ?? "", TrongLuong: self.tfPackageWeight?.text ?? "", DichVu: self.selectedDichVu?.Name ?? "").Data ?? []
            
            self.listDistributeName.removeAll()
            if self.listDistribute.count > 0 {
                for item in self.listDistribute {
                    self.listDistributeName.append(item.TenNVC ?? "")
                }
                self.selectedDistribute = self.listDistribute[0]
                self.tfPackageDistribute.text = self.selectedDistribute?.TenNVC ?? ""
                let cuocPhi = Int(self.selectedDistribute?.CuocPhiMin ?? "")
                self.tfCuocPhiMin.text = "\(Common.convertCurrencyV2(value: cuocPhi ?? 0))"
                
            } else {
                self.showAlert(title: "Thông báo", message: "Không có danh sách Nhà vận chuyển!")
            }
        }
    }
    
    func loadDichVu() {
        self.listService.removeAll()
        self.listServiceName.removeAll()
        
        DispatchQueue.main.async {
            self.listService = mCallLogApiManager.Bill__LoadDichVu().Data ?? []
            if self.listService.count > 0 {
                for item in self.listService {
                    self.listServiceName.append(item.Name ?? "")
                }
                
                self.selectedDichVu = self.listService[0]
                if self.scrollView != nil {
                    self.loadNhaVanChuyen()
                }
                
            } else {
                self.showAlert(title: "Thông báo", message: "Không có danh sách dịch vụ!")
            }
        }
    }
    
    func loadHinhThucThanhToan() {
        self.listPaymentTypeName.removeAll()
        DispatchQueue.main.async {
            self.listHTTT = mCallLogApiManager.Bill__LoadHinhThucThanhToan().Data ?? []
            if self.listHTTT.count > 0 {
                for item in self.listHTTT {
                    self.listPaymentTypeName.append(item.Name ?? "")
                }
                
                self.selectedHTTT = self.listHTTT[0]
            } else {
                self.showAlert(title: "Thông báo", message: "Không có danh sách Hình thức thanh toán!")
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == self.tfPackageWeight {
            self.loadNhaVanChuyen()
        }
        textField.endEditing(true)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}


extension DetailBillInfoViewControllerV2: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.tfPackageWeight {

//            if self.isMirae {
//                for item in self.listService {
//                    if item.Code == self.miraeBillInfo?.DichVu ?? "" {
//                        self.tfPackageService.text = item.Name
//                        self.selectedDichVu = item
//                    }
//                }
//            } else {
//                self.tfPackageService.text = ""
//            }

            self.tfPackageService.text = ""
            
            self.tfPackageDistribute.text = ""
            self.tfCuocPhiMin.text = ""
        }
        return true
    }
}
