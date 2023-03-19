//
//  DetailViettelTraSauInfoViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 8/12/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DetailViettelTraSauInfoViewController: UIViewController {

    var scrollView:UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var thuHoService: ThuHoService?
    var thuHoProvider: ThuHoProvider?
    
    var itemThe:CardTypeFromPOSResult?
    var itemViettelTSPayTeleCharge: GetPayTeleChargeViettelTS?
    var isThe = false
    var isTienMat = true
    var phiCatheAmount:Double = 0
    var phiThuHo:Double = 0
    
    var imgTienMat:UIImageView!
    var imgThe:UIImageView!
    var tfTienMatValue:UITextField!
    var tfTheValue:UITextField!
    var tfTenKHText:UITextField!
    var tfSdtThanhToan:UITextField!
    var lbPhiCaTheText:UILabel!
    var lbSoTienThanhToanText:UILabel!
    var viewTienMat:UIView!
    var viewThe:UIView!
    var viewUnderHTTT:UIView!
    var viewSdtLienHe:UIView!
    var lbTheCheck:UILabel!
    var btnNext:UIButton!
    var isDKUyQuyen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Chi tiết thông tin cước"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: scrollView.frame.size.height)
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        let viewTTGD = UIScrollView(frame: CGRect(x: 0, y:0, width: scrollView.frame.size.width, height:  Common.Size(s: 40)))
        viewTTGD.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView.addSubview(viewTTGD)
        
        let lbTTGD = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbTTGD.text = "THÔNG TIN GIAO DỊCH"
        lbTTGD.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 15))
        lbTTGD.textColor = UIColor(netHex: 0x109e59)
        viewTTGD.addSubview(lbTTGD)
        
        let lbMaDV = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewTTGD.frame.origin.y + viewTTGD.frame.height + Common.Size(s: 5), width: (scrollView.frame.width - Common.Size(s: 30))/3 + Common.Size(s: 10), height: Common.Size(s: 20)))
        lbMaDV.text = "Mã dịch vụ:"
        lbMaDV.textColor = UIColor.lightGray
        lbMaDV.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbMaDV)
        
        let lbMaDVText = UILabel(frame: CGRect(x: lbMaDV.frame.size.width + lbMaDV.frame.origin.x + Common.Size(s: 5), y: lbMaDV.frame.origin.y, width: (scrollView.frame.width - Common.Size(s: 30)) * 2/3 - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbMaDVText.text = "\(self.itemViettelTSPayTeleCharge?.service_code ?? "")"
        lbMaDVText.textColor = UIColor.black
        lbMaDVText.textAlignment = .right
        lbMaDVText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbMaDVText)
        
        let lbNCC = UILabel(frame: CGRect(x: lbMaDV.frame.origin.x, y: lbMaDVText.frame.origin.y + lbMaDVText.frame.height, width: lbMaDV.frame.size.width, height: Common.Size(s: 20)))
        lbNCC.text = "Nhà cung cấp:"
        lbNCC.textColor = UIColor.lightGray
        lbNCC.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbNCC)
        
        let lbNCCText = UILabel(frame: CGRect(x: lbMaDVText.frame.origin.x, y: lbNCC.frame.origin.y, width: lbMaDVText.frame.width, height: Common.Size(s: 20)))
        lbNCCText.text = "\(self.thuHoProvider?.PaymentBillProviderName ?? "")"
        lbNCCText.textColor = UIColor.black
        lbNCCText.textAlignment = .right
        lbNCCText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbNCCText)
        
        let lbNCCTextHeight:CGFloat = lbNCCText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNCCText.optimalHeight + Common.Size(s: 5))
        lbNCCText.numberOfLines = 0
        lbNCCText.frame = CGRect(x: lbNCCText.frame.origin.x, y: lbNCCText.frame.origin.y, width: lbNCCText.frame.width, height: lbNCCTextHeight)
        
        let lbLoaiDV = UILabel(frame: CGRect(x: lbMaDV.frame.origin.x, y: lbNCCText.frame.origin.y + lbNCCTextHeight, width: lbMaDV.frame.size.width, height: Common.Size(s: 20)))
        lbLoaiDV.text = "Loại dịch vụ:"
        lbLoaiDV.textColor = UIColor.lightGray
        lbLoaiDV.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbLoaiDV)
        
        let lbLoaiDVText = UILabel(frame: CGRect(x: lbMaDVText.frame.origin.x, y: lbLoaiDV.frame.origin.y, width: lbMaDVText.frame.width, height: Common.Size(s: 20)))
        lbLoaiDVText.text = "\(self.thuHoService?.PaymentBillServiceName ?? "")"
        lbLoaiDVText.textColor = UIColor.black
        lbLoaiDVText.textAlignment = .right
        lbLoaiDVText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbLoaiDVText)
        
        let lbLoaiDVTextHeight:CGFloat = lbLoaiDVText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbLoaiDVText.optimalHeight + Common.Size(s: 5))
        lbLoaiDVText.numberOfLines = 0
        lbLoaiDVText.frame = CGRect(x: lbLoaiDVText.frame.origin.x, y: lbLoaiDVText.frame.origin.y, width: lbLoaiDVText.frame.width, height: lbLoaiDVTextHeight)
        
        let lbTienCuoc = UILabel(frame: CGRect(x: lbMaDV.frame.origin.x, y: lbLoaiDVText.frame.origin.y + lbLoaiDVTextHeight, width: lbMaDV.frame.size.width, height: Common.Size(s: 20)))
        lbTienCuoc.text = "Tiền cước:"
        lbTienCuoc.textColor = UIColor.lightGray
        lbTienCuoc.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbTienCuoc)
        
        let lbTienCuocText = UILabel(frame: CGRect(x: lbMaDVText.frame.origin.x, y: lbTienCuoc.frame.origin.y, width: lbMaDVText.frame.width, height: Common.Size(s: 20)))
        lbTienCuocText.text = "\(self.convertTypeMoneyString(number: self.itemViettelTSPayTeleCharge?.amount ?? "0"))đ"
        lbTienCuocText.textColor = UIColor.red
        lbTienCuocText.textAlignment = .right
        lbTienCuocText.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbTienCuocText)
        
        let viewHTTT = UIScrollView(frame: CGRect(x: 0, y: lbTienCuocText.frame.origin.y + lbTienCuocText.frame.height + Common.Size(s: 8), width: scrollView.frame.size.width, height: Common.Size(s: 40)))
        viewHTTT.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView.addSubview(viewHTTT)
        
        let lbHTTT = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbHTTT.text = "HÌNH THỨC THANH TOÁN"
        lbHTTT.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 15))
        lbHTTT.textColor = UIColor(netHex: 0x109e59)
        viewHTTT.addSubview(lbHTTT)
        
        imgTienMat = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: viewHTTT.frame.origin.y + viewHTTT.frame.height + Common.Size(s: 8), width: Common.Size(s: 20), height: Common.Size(s: 20)))
        imgTienMat.image = #imageLiteral(resourceName: "check-1")
        imgTienMat.contentMode = .scaleAspectFit
        imgTienMat.tag = 1
        scrollView.addSubview(imgTienMat)
        
        let tapTienMat = UITapGestureRecognizer(target: self, action: #selector(chooseTypePayment(sender:)))
        imgTienMat.isUserInteractionEnabled = true
        imgTienMat.addGestureRecognizer(tapTienMat)
        
        let lbTienMatCheck = UILabel(frame: CGRect(x: imgTienMat.frame.origin.x + imgTienMat.frame.width + Common.Size(s: 5), y: imgTienMat.frame.origin.y, width: (scrollView.frame.size.width/2) - Common.Size(s: 35), height: Common.Size(s: 20)))
        lbTienMatCheck.text = "Tiền mặt"
        lbTienMatCheck.textColor = UIColor.black
        lbTienMatCheck.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbTienMatCheck)
        
        imgThe = UIImageView(frame: CGRect(x: lbTienMatCheck.frame.origin.x + lbTienMatCheck.frame.width, y: lbTienMatCheck.frame.origin.y, width: Common.Size(s: 20), height: Common.Size(s: 20)))
        imgThe.image = #imageLiteral(resourceName: "check-2")
        imgThe.contentMode = .scaleAspectFit
        imgThe.tag = 2
        scrollView.addSubview(imgThe)
        
        let tapThe = UITapGestureRecognizer(target: self, action: #selector(chooseTypePayment(sender:)))
        imgThe.isUserInteractionEnabled = true
        imgThe.addGestureRecognizer(tapThe)
        
        lbTheCheck = UILabel(frame: CGRect(x: imgThe.frame.origin.x + imgThe.frame.width + Common.Size(s: 5), y: imgThe.frame.origin.y, width: (scrollView.frame.size.width/2) - Common.Size(s: 35), height: Common.Size(s: 20)))
        lbTheCheck.text = "Thẻ"
        lbTheCheck.textColor = UIColor.black
        lbTheCheck.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbTheCheck)
        
        viewTienMat = UIView(frame: CGRect(x: Common.Size(s: 15), y: lbTheCheck.frame.origin.y + lbTheCheck.frame.height + Common.Size(s: 8), width: scrollView.frame.size.width, height: Common.Size(s: 35)))
        viewTienMat.backgroundColor = .white
        scrollView.addSubview(viewTienMat)
        
        let lbTienMatText = UILabel(frame: CGRect(x: 0, y: 0, width: (scrollView.frame.size.width - Common.Size(s: 30))/3 + Common.Size(s: 10), height: Common.Size(s: 35)))
        lbTienMatText.text = "Tiền mặt"
        lbTienMatText.textColor = UIColor.black
        lbTienMatText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTienMat.addSubview(lbTienMatText)
        
        tfTienMatValue = UITextField(frame: CGRect(x: lbTienMatText.frame.origin.x + lbTienMatText.frame.width, y: lbTienMatText.frame.origin.y, width: (scrollView.frame.size.width - Common.Size(s: 30)) * 2/3 - Common.Size(s: 10), height: Common.Size(s: 35)))
        tfTienMatValue.text = self.convertTypeMoneyString(number: self.itemViettelTSPayTeleCharge?.amount ?? "0")
        tfTienMatValue.textColor = UIColor(netHex: 0x109e59)
        tfTienMatValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        tfTienMatValue.textAlignment = .center
        tfTienMatValue.borderStyle = .roundedRect
        tfTienMatValue.autocorrectionType = UITextAutocorrectionType.no
        tfTienMatValue.keyboardType = UIKeyboardType.numberPad
        tfTienMatValue.returnKeyType = UIReturnKeyType.done
        tfTienMatValue.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfTienMatValue.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        viewTienMat.addSubview(tfTienMatValue)
        
        viewThe = UIView(frame: CGRect(x: 0, y: viewTienMat.frame.origin.y + viewTienMat.frame.height + Common.Size(s: 5), width: scrollView.frame.size.width, height: Common.Size(s: 35)))
        viewThe.backgroundColor = .white
        scrollView.addSubview(viewThe)
        
        let lbTheText = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: lbTienMatText.frame.size.width, height: Common.Size(s: 35)))
        lbTheText.text = "Thẻ"
        lbTheText.textColor = UIColor.black
        lbTheText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewThe.addSubview(lbTheText)
        
        tfTheValue = UITextField(frame: CGRect(x: lbTheText.frame.origin.x + lbTheText.frame.width, y: lbTheText.frame.origin.y, width: tfTienMatValue.frame.size.width, height: Common.Size(s: 35)))
        tfTheValue.text = "0"
        tfTheValue.textColor = UIColor(netHex: 0x109e59)
        tfTheValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        tfTheValue.textAlignment = .center
        tfTheValue.borderStyle = .roundedRect
        tfTheValue.autocorrectionType = UITextAutocorrectionType.no
        tfTheValue.keyboardType = UIKeyboardType.numberPad
        tfTheValue.returnKeyType = UIReturnKeyType.done
        tfTheValue.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfTheValue.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        viewThe.addSubview(tfTheValue)
        
        viewUnderHTTT = UIView(frame: CGRect(x: 0, y: viewThe.frame.origin.y + viewThe.frame.height + Common.Size(s: 5), width: scrollView.frame.size.width, height: Common.Size(s: 35)))
        viewUnderHTTT.backgroundColor = .white
        scrollView.addSubview(viewUnderHTTT)
        
        let lbTenKH = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: lbTienMatText.frame.size.width, height: Common.Size(s: 35)))
        lbTenKH.text = "Tên khách hàng"
        lbTenKH.textColor = UIColor.black
        lbTenKH.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewUnderHTTT.addSubview(lbTenKH)
        
        tfTenKHText = UITextField(frame: CGRect(x: lbTenKH.frame.origin.x + lbTenKH.frame.width, y: lbTenKH.frame.origin.y, width: tfTienMatValue.frame.size.width, height: Common.Size(s: 35)))
        tfTenKHText.textColor = UIColor.black
        tfTenKHText.placeholder = "Nhập tên khách hàng"
        tfTenKHText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        tfTenKHText.borderStyle = .roundedRect
        tfTenKHText.autocorrectionType = UITextAutocorrectionType.no
        tfTenKHText.returnKeyType = UIReturnKeyType.done
        tfTheValue.clearButtonMode = UITextField.ViewMode.whileEditing;
        viewUnderHTTT.addSubview(tfTenKHText)
        
        viewSdtLienHe = UIView(frame: CGRect(x: 0, y: tfTenKHText.frame.origin.y + tfTenKHText.frame.height + Common.Size(s: 5), width: scrollView.frame.size.width, height: Common.Size(s: 35)))
        viewSdtLienHe.backgroundColor = .white
        viewUnderHTTT.addSubview(viewSdtLienHe)
        
        let lbSdtThanhToan = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: lbTienMatText.frame.size.width, height: Common.Size(s: 35)))
        lbSdtThanhToan.text = "Sđt liên hệ"
        lbSdtThanhToan.textColor = UIColor.black
        lbSdtThanhToan.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewSdtLienHe.addSubview(lbSdtThanhToan)

        tfSdtThanhToan = UITextField(frame: CGRect(x: lbSdtThanhToan.frame.origin.x + lbSdtThanhToan.frame.width, y: lbSdtThanhToan.frame.origin.y, width: tfTienMatValue.frame.size.width, height: Common.Size(s: 35)))
        tfSdtThanhToan.textColor = UIColor.black
        tfSdtThanhToan.placeholder = "Nhập sdt liên hệ"
        tfSdtThanhToan.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        tfSdtThanhToan.borderStyle = .roundedRect
        tfSdtThanhToan.autocorrectionType = UITextAutocorrectionType.no
        tfSdtThanhToan.returnKeyType = UIReturnKeyType.done
        tfSdtThanhToan.keyboardType = .numberPad
        tfSdtThanhToan.clearButtonMode = UITextField.ViewMode.whileEditing;
        viewSdtLienHe.addSubview(tfSdtThanhToan)
        
        let viewTTThanhToan = UIScrollView(frame: CGRect(x: 0, y: viewSdtLienHe.frame.origin.y + viewSdtLienHe.frame.height + Common.Size(s: 8), width: scrollView.frame.size.width, height: Common.Size(s: 40)))
        viewTTThanhToan.backgroundColor = UIColor(netHex: 0xEEEEEE)
        viewUnderHTTT.addSubview(viewTTThanhToan)
        
        if self.isDKUyQuyen {
            viewSdtLienHe.isHidden = false
            viewTTThanhToan.frame = CGRect(x: viewTTThanhToan.frame.origin.x, y: viewSdtLienHe.frame.origin.y + viewSdtLienHe.frame.height + Common.Size(s: 8), width: viewTTThanhToan.frame.size.width, height: viewTTThanhToan.frame.height)
        } else {
            viewSdtLienHe.isHidden = true
            viewTTThanhToan.frame = CGRect(x: viewTTThanhToan.frame.origin.x, y: tfTenKHText.frame.origin.y + tfTenKHText.frame.height + Common.Size(s: 5), width: viewTTThanhToan.frame.size.width, height: viewTTThanhToan.frame.height)
        }
        
        let lbTTThanhToan = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbTTThanhToan.text = "THÔNG TIN THANH TOÁN"
        lbTTThanhToan.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 15))
        lbTTThanhToan.textColor = UIColor(netHex: 0x109e59)
        viewTTThanhToan.addSubview(lbTTThanhToan)
        
        let lbPhiThuHo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewTTThanhToan.frame.origin.y + viewTTThanhToan.frame.size.height + Common.Size(s: 5), width: (scrollView.frame.width - Common.Size(s: 30))/2, height: Common.Size(s: 20)))
        lbPhiThuHo.text = "Phí thu hộ"
        lbPhiThuHo.textColor = UIColor.lightGray
        lbPhiThuHo.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewUnderHTTT.addSubview(lbPhiThuHo)
        
        let lbPhiThuHoText = UILabel(frame: CGRect(x: lbPhiThuHo.frame.size.width + lbPhiThuHo.frame.origin.x, y: lbPhiThuHo.frame.origin.y, width: lbPhiThuHo.frame.width, height: Common.Size(s: 20)))
        lbPhiThuHoText.text = "0đ"
        lbPhiThuHoText.textAlignment = .right
        lbPhiThuHoText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewUnderHTTT.addSubview(lbPhiThuHoText)
        
        let lbPhiCaThe = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbPhiThuHoText.frame.origin.y + lbPhiThuHoText.frame.size.height + Common.Size(s: 5), width: lbPhiThuHo.frame.size.width, height: Common.Size(s: 20)))
        lbPhiCaThe.text = "Phí cà thẻ/ví"
        lbPhiCaThe.textColor = UIColor.lightGray
        lbPhiCaThe.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewUnderHTTT.addSubview(lbPhiCaThe)
        
        lbPhiCaTheText = UILabel(frame: CGRect(x: lbPhiCaThe.frame.size.width + lbPhiCaThe.frame.origin.x, y: lbPhiCaThe.frame.origin.y, width: lbPhiThuHoText.frame.size.width, height: Common.Size(s: 20)))
        lbPhiCaTheText.text = "0đ"
        lbPhiCaTheText.textAlignment = .right
        lbPhiCaTheText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewUnderHTTT.addSubview(lbPhiCaTheText)
        
        let lbSoTienThanhToan = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbPhiCaTheText.frame.origin.y + lbPhiCaTheText.frame.size.height + Common.Size(s: 5), width: lbPhiThuHo.frame.size.width, height: Common.Size(s: 20)))
        lbSoTienThanhToan.text = "Số tiền thanh toán"
        lbSoTienThanhToan.textColor = UIColor.lightGray
        lbSoTienThanhToan.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewUnderHTTT.addSubview(lbSoTienThanhToan)
        
        lbSoTienThanhToanText = UILabel(frame: CGRect(x: lbSoTienThanhToan.frame.size.width + lbSoTienThanhToan.frame.origin.x, y: lbSoTienThanhToan.frame.origin.y, width: lbPhiThuHoText.frame.size.width, height: Common.Size(s: 20)))
        lbSoTienThanhToanText.text = "\(self.convertTypeMoneyString(number: self.itemViettelTSPayTeleCharge?.amount ?? "0"))đ"
        lbSoTienThanhToanText.textColor = UIColor(netHex: 0xcc0c2f)
        lbSoTienThanhToanText.textAlignment = .right
        lbSoTienThanhToanText.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        viewUnderHTTT.addSubview(lbSoTienThanhToanText)
        
        btnNext = UIButton(frame: CGRect(x: Common.Size(s: 15), y: lbSoTienThanhToanText.frame.origin.y + lbSoTienThanhToanText.frame.height + Common.Size(s: 15), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        btnNext.backgroundColor = UIColor(netHex: 0x109e59)
        btnNext.setTitle("THANH TOÁN", for: .normal)
        btnNext.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btnNext.layer.cornerRadius = 5
        btnNext.addTarget(self, action: #selector(actionPay), for: .touchUpInside)
        viewUnderHTTT.addSubview(btnNext)
        
        viewUnderHTTT.frame = CGRect(x: viewUnderHTTT.frame.origin.x, y: viewUnderHTTT.frame.origin.y, width: viewUnderHTTT.frame.size.width, height: btnNext.frame.origin.y + btnNext.frame.height)
        
        scrollViewHeight = viewUnderHTTT.frame.origin.y + viewUnderHTTT.frame.height + Common.Size(s: 30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        self.updateUIWhenCheckHTThanhToan()
        
    }
    
    func updateUIWhenCheckHTThanhToan() {
        //----------tien mat
        if isTienMat { // tick tien mat
            self.imgTienMat.image = #imageLiteral(resourceName: "check-1")
            viewTienMat.isHidden = false
            viewTienMat.frame = CGRect(x: viewTienMat.frame.origin.x, y: lbTheCheck.frame.origin.y + lbTheCheck.frame.height + Common.Size(s: 8), width: viewTienMat.frame.size.width, height: Common.Size(s: 35))
            
            viewThe.frame = CGRect(x: viewThe.frame.origin.x, y: viewTienMat.frame.origin.y
            + viewTienMat.frame.height + Common.Size(s: 5), width: viewThe.frame.size.width, height: Common.Size(s: 35))
            
        } else {
            self.imgTienMat.image = #imageLiteral(resourceName: "check-2")
            viewTienMat.isHidden = true
            
            viewTienMat.frame = CGRect(x: viewTienMat.frame.origin.x, y: lbTheCheck.frame.origin.y + lbTheCheck.frame.height, width: viewTienMat.frame.size.width, height: 0)
            viewThe.frame = CGRect(x: viewThe.frame.origin.x, y: viewTienMat.frame.origin.y
            + viewTienMat.frame.height, width: viewThe.frame.size.width, height: Common.Size(s: 35))
        }
        
        //------------the
        if isThe { // tick thẻ
            viewThe.isHidden = false
            viewThe.frame = CGRect(x: viewThe.frame.origin.x, y: viewTienMat.frame.origin.y
            + viewTienMat.frame.height + Common.Size(s: 5), width: viewThe.frame.size.width, height: Common.Size(s: 35))
        } else {
            viewThe.isHidden = true
            viewThe.frame = CGRect(x: viewThe.frame.origin.x, y: viewTienMat.frame.origin.y
            + viewTienMat.frame.height, width: viewThe.frame.size.width, height: 0)
        }
        
        viewUnderHTTT.frame = CGRect(x: viewUnderHTTT.frame.origin.x, y: viewThe.frame.origin.y
            + viewThe.frame.height + Common.Size(s: 5), width: viewUnderHTTT.frame.size.width, height: viewUnderHTTT.frame.height)
        scrollViewHeight = viewUnderHTTT.frame.origin.y + viewUnderHTTT.frame.height + Common.Size(s: 30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func chooseTypePayment(sender:UITapGestureRecognizer) {
        let view = sender.view!
        if view.tag == 1 { // tiền mặt
            self.isTienMat = !self.isTienMat
            self.updateUIWhenCheckHTThanhToan()
        }
        
        if view.tag == 2 { // thẻ
            if self.isThe {
                self.isThe = false
                self.imgThe.image = #imageLiteral(resourceName: "check-2")
                self.itemThe = nil
                self.updateTotalPrice(cardPercentFee: 0)
                self.updateUIWhenCheckHTThanhToan()
            } else {
                let vc = ListCardViewController()
                vc.delegate = self
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        self.updateInputMoney()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let total = NumberFormatter().number(from: self.itemViettelTSPayTeleCharge?.amount ?? "0")?.intValue ?? 0
        
        if textField == self.tfTienMatValue { //nhập tiền mặt
            let tienTienMatStr = self.tfTienMatValue.text ?? "0"
            self.tfTienMatValue.text = self.convertTypeMoneyString(number: "\(self.tfTienMatValue.text ?? "0")")
            //tinh tien the
            var numTM = NumberFormatter().number(from: tienTienMatStr.replacingOccurrences(of: ",", with: "", options: .literal, range: nil))?.intValue ?? 0
            var tienThe = total - numTM
            if tienThe <= 0 {
                tienThe = 0
            }
            self.tfTheValue.text = self.convertTypeMoneyString(number: "\(tienThe)")
            
            if numTM > total {
                numTM = total
            } else if numTM <= 0 {
                numTM = 0
            }
            self.tfTienMatValue.text = self.convertTypeMoneyString(number: "\(numTM)")
            
        } else { //nhập thẻ
            let tienTheStr = self.tfTheValue.text ?? "0"
            self.tfTheValue.text = self.convertTypeMoneyString(number: "\(self.tfTheValue.text ?? "0")")
            //tinh tien mat
            var numThe = NumberFormatter().number(from: tienTheStr.replacingOccurrences(of: ",", with: "", options: .literal, range: nil))?.intValue ?? 0
            var tienMat = total - numThe
            if tienMat <= 0 {
                tienMat = 0
            }
            self.tfTienMatValue.text = self.convertTypeMoneyString(number: "\(tienMat)")
            
            if numThe > total {
                numThe = total
            } else if numThe <= 0 {
                numThe = 0
            }
            self.tfTheValue.text = self.convertTypeMoneyString(number: "\(numThe)")
        }
    }
    
    func convertTypeMoneyString(number: String) -> String {
        var moneyString = number
        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s),\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            return str
        }else{
            return ""
        }
    }
    
    @objc func actionPay() {
        guard let tenKH = self.tfTenKHText.text, !tenKH.isEmpty else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập tên khách hàng!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if self.isDKUyQuyen {
            guard let sdt = tfSdtThanhToan.text, !sdt.isEmpty else {
                let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập sđt liên hệ!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            guard sdt.count == 10, (sdt.isNumber() == true) else {
                let alert = UIAlertController(title: "Thông báo", message: "Số điện thoại liên hệ không hợp lệ!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
        if (!isThe) && (!isTienMat) {
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập số tiền thanh toán cho thẻ/tiền mặt!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let totalCash = self.tfTienMatValue.text?.replace(",", withString: "")
        let totalCredict = self.tfTheValue.text?.replace(",", withString: "")
        
        //        <line>
        //        <item Totalcash=\"0\" Totalcardcredit=\"10000\" Numcard=\"\" IDBankCard=\"1\" Numvoucher=\"\" TotalVoucher=\"0\" Namevoucher=\"\" cardfee=\"1.0\" namecard=\"VISA\" totalcardfee=\"200\" \/>
        //
        //        <item Totalcash=\"10000\" Totalcardcredit=\"0\" Numcard=\"\" IDBankCard=\"\" Numvoucher=\"\" TotalVoucher=\"0\" Namevoucher=\"\" \/>
        //        <\/line>
        let xmlCredict = "<item Totalcash=\"0\" Totalcardcredit=\"\(totalCredict ?? "0")\" Numcard=\"\" IDBankCard=\"\(self.itemThe?.Value ?? 0)\" Numvoucher=\"\" TotalVoucher=\"0\" Namevoucher=\"\" cardfee=\"\(self.itemThe?.PercentFee ?? 0)\" namecard=\"\(self.itemThe?.Text ?? "")\" totalcardfee=\"\(Int(self.phiCatheAmount))\" />"
        
        let xmlCash = "<item Totalcash=\"\(totalCash ?? "0")\" Totalcardcredit=\"0\" Numcard=\"\" IDBankCard=\"\" Numvoucher=\"\" TotalVoucher=\"0\" Namevoucher=\"\" />"
        let xmlString = "<line>" + xmlCredict + xmlCash + "</line>"
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            MPOSAPIManager.ViettelPay_PayTeleCharge(OrderId: "\(self.itemViettelTSPayTeleCharge?.payment_order_id ?? "")", OriginalTransId: "\(self.itemViettelTSPayTeleCharge?.trans_id ?? "")", ServiceCode: "\(self.itemViettelTSPayTeleCharge?.service_code ?? "100000")", BillingCode: "\(self.itemViettelTSPayTeleCharge?.billing_code ?? "")", FullName: tenKH, Amount: "\(self.itemViettelTSPayTeleCharge?.amount ?? "")", XmlStringPay: xmlString) { (rs, wee) in
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if rs != nil {
                        if rs?.error_code == "00" {
                            let vc = PaymentViettelTraSauViewController()
                            vc.itemViettelTSPayTeleCharge = rs
                            self.itemViettelTSPayTeleCharge = rs
                            vc.tenKH = tenKH
                            vc.sdtLienHe = self.tfSdtThanhToan.text ?? ""
                            vc.isDKUyQuyen = self.isDKUyQuyen
                            vc.phiCathe = self.phiCatheAmount
                            vc.thuHoService = self.thuHoService
                            vc.thuHoProvider = self.thuHoProvider
                            vc.itemTheThanhToan = self.itemThe
                            vc.totalCash = self.tfTienMatValue.text ?? "0"
                            vc.totalCredict = self.tfTheValue.text ?? "0"
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "Error \(rs?.error_code ?? ""): \(rs?.error_msg ?? "Thanh toán thất bại!")", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "API Error!", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func updateTotalPrice(cardPercentFee: Double) {
        let moneyCuocViettel = NumberFormatter().number(from: self.itemViettelTSPayTeleCharge?.amount ?? "0")?.doubleValue ?? 0
        self.phiCatheAmount = (Double(moneyCuocViettel) * cardPercentFee) / 100
        let total = moneyCuocViettel + phiCatheAmount + self.phiThuHo
        
        self.lbPhiCaTheText.text = "\(Common.convertCurrencyDouble(value: phiCatheAmount))đ"
        self.lbSoTienThanhToanText.text = "\(Common.convertCurrencyDouble(value: total))đ"
    }
    
    func updateInputMoney() {
        if isTienMat {
            if isThe {
                self.tfTienMatValue.text = self.convertTypeMoneyString(number: "\(self.itemViettelTSPayTeleCharge?.amount ?? "0")")
                self.tfTheValue.text = "0"
            } else {
                self.tfTienMatValue.text = self.convertTypeMoneyString(number: "\(self.itemViettelTSPayTeleCharge?.amount ?? "0")")
                self.tfTheValue.text = "0"
            }
        } else {
            if isThe {
                self.tfTheValue.text = self.convertTypeMoneyString(number: "\(self.itemViettelTSPayTeleCharge?.amount ?? "0")")
                self.tfTienMatValue.text = "0"
            } else {
                self.tfTheValue.text = "0"
                self.tfTienMatValue.text = "0"
            }
        }
    }
}

extension DetailViettelTraSauInfoViewController: ListCardViewControllerDelegate {
    func returnCard(item: CardTypeFromPOSResult, ind: Int) {
        self.itemThe = item
        self.updateTotalPrice(cardPercentFee: item.PercentFee)
        self.isThe = true
        self.imgThe.image = #imageLiteral(resourceName: "check-1")
        
        self.updateInputMoney()
        self.updateUIWhenCheckHTThanhToan()
    }
    
    func returnClose() {
        self.isThe = false
        self.imgThe.image = #imageLiteral(resourceName: "check-2")
    }
}
