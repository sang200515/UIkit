//
//  BaoMatMayViewController.swift
//  mPOS
//
//  Created by tan on 8/10/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit

//import EPSignature
import PopupDialog

class BaoMatMayViewController: UIViewController,UITextFieldDelegate,EPSignatureDelegate {
    var window: UIWindow?
    var scrollView:UIScrollView!
    var tfCreateAddress:SearchTextField!
    //
    var viewInfoCMNDTruoc:UIView!
    var viewImageCMNDTruoc:UIView!
    var imgViewCMNDTruoc: UIImageView!
    var viewCMNDTruoc:UIView!
    //
    //--
    var viewInfoCMNDSau:UIView!
    var viewImageCMNDSau:UIView!
    var imgViewCMNDSau: UIImageView!
    var viewCMNDSau:UIView!
    //--
    var imgViewSignature: UIImageView!
    var viewImageSign:UIView!
    var viewSign:UIView!
    
    var lbTextCMNDTruoc:UILabel!
    var viewCMNDTruocButton:UIImageView!
    var lbCMNDTruocButton:UILabel!
    
    var lblTitleChuKy:UILabel!
    var btHoanTat:UIButton!
    var posImageUpload:Int = -1
    
    var cmnd:String!
    var info:InfoLockDevide?
    
    var urlMTCMND:String = ""
    var urlMSCMND:String = ""
    var urlPhieuCamKet:String = ""
    
    override func viewDidLoad() {
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Báo mất máy"
        
        
        self.loadInfoLockDevide()
        
        
        
        
        
    }
    
    func loadUI(){
        let lbTextThongTinKH = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbTextThongTinKH.textAlignment = .left
        lbTextThongTinKH.textColor = UIColor(netHex:0x47B054)
        lbTextThongTinKH.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbTextThongTinKH.text = "Thông tin khách hàng"
        scrollView.addSubview(lbTextThongTinKH)
        
        
        //input ho khach hang
        let lblNhapHo =  UILabel(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: lbTextThongTinKH.frame.origin.y + lbTextThongTinKH.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblNhapHo.textAlignment = .left
        lblNhapHo.textColor = UIColor.black
        lblNhapHo.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNhapHo.text = "Tên khách hàng"
        scrollView.addSubview(lblNhapHo)
        
        let tfHoKhachHang = UITextField(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: lblNhapHo.frame.origin.y + lblNhapHo.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfHoKhachHang.placeholder = "Tên khách hàng"
        tfHoKhachHang.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfHoKhachHang.borderStyle = UITextField.BorderStyle.roundedRect
        tfHoKhachHang.autocorrectionType = UITextAutocorrectionType.no
        tfHoKhachHang.keyboardType = UIKeyboardType.default
        tfHoKhachHang.returnKeyType = UIReturnKeyType.done
        tfHoKhachHang.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfHoKhachHang.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfHoKhachHang.delegate = self
        //tfUserName.addTarget(self, action: #selector(textFieldDidChangeName(_:)), for: .editingChanged)
        tfHoKhachHang.text = self.info?.TenKH
        tfHoKhachHang.isUserInteractionEnabled = false
        tfHoKhachHang.isEnabled = false
        
        
        scrollView.addSubview(tfHoKhachHang)
        
        // input ngay sinh
        let lblBirthday =  UILabel(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: tfHoKhachHang.frame.origin.y + tfHoKhachHang.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblBirthday.textAlignment = .left
        lblBirthday.textColor = UIColor.black
        lblBirthday.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBirthday.text = "Ngày sinh khách hàng"
        scrollView.addSubview(lblBirthday)
        
        
        
        let tfUserBirthday = UITextField(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: lblBirthday.frame.origin.y + lblBirthday.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfUserBirthday.placeholder = "Ngày sinh"
        
        tfUserBirthday.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfUserBirthday.borderStyle = UITextField.BorderStyle.roundedRect
        tfUserBirthday.autocorrectionType = UITextAutocorrectionType.no
        tfUserBirthday.keyboardType = UIKeyboardType.numbersAndPunctuation
        tfUserBirthday.returnKeyType = UIReturnKeyType.done
        tfUserBirthday.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfUserBirthday.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfUserBirthday.delegate = self
        scrollView.addSubview(tfUserBirthday)
        //tfUserBirthday.addTarget(self, action: #selector(textFieldDidChangeBirthday(_:)), for: .editingChanged)
        tfUserBirthday.text = self.info?.NgaySinh
        tfUserBirthday.isUserInteractionEnabled = false
        tfUserBirthday.isEnabled = false
        
        //input so cmnd
        let lblCMND =  UILabel(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: tfUserBirthday.frame.origin.y + tfUserBirthday.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblCMND.textAlignment = .left
        lblCMND.textColor = UIColor.black
        lblCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblCMND.text = "CMND"
        scrollView.addSubview(lblCMND)
        
        
        let tfCMND = UITextField(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: lblCMND.frame.origin.y + lblCMND.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfCMND.placeholder = "Số CMND"
        
        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMND.autocorrectionType = UITextAutocorrectionType.no
        
        tfCMND.keyboardType = UIKeyboardType.numberPad
        tfCMND.returnKeyType = UIReturnKeyType.done
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMND.delegate = self
        scrollView.addSubview(tfCMND)
        //tfUserBirthday.addTarget(self, action: #selector(textFieldDidChangeBirthday(_:)), for: .editingChanged)
        tfCMND.text = self.cmnd
        tfCMND.isUserInteractionEnabled = false
        tfCMND.isEnabled = false
        
        //input Noi Cap cmnd
        let lblNoiCap =  UILabel(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: tfCMND.frame.origin.y + tfCMND.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblNoiCap.textAlignment = .left
        lblNoiCap.textColor = UIColor.black
        lblNoiCap.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNoiCap.text = "Nơi Cấp "
        scrollView.addSubview(lblNoiCap)
        
        tfCreateAddress = SearchTextField(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: lblNoiCap.frame.origin.y + lblNoiCap.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        
        tfCreateAddress.placeholder = "Chọn nơi cấp CMND"
        tfCreateAddress.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCreateAddress.borderStyle = UITextField.BorderStyle.roundedRect
        tfCreateAddress.autocorrectionType = UITextAutocorrectionType.no
        tfCreateAddress.keyboardType = UIKeyboardType.default
        tfCreateAddress.returnKeyType = UIReturnKeyType.done
        tfCreateAddress.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfCreateAddress.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCreateAddress.delegate = self
        scrollView.addSubview(tfCreateAddress)
        tfCreateAddress.text = self.info?.NoiCapCMND
        tfCreateAddress.isUserInteractionEnabled = false
        tfCreateAddress.isEnabled = false
        
        tfCreateAddress.startVisible = true
        tfCreateAddress.theme.bgColor = UIColor.white
        tfCreateAddress.theme.fontColor = UIColor.black
        tfCreateAddress.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCreateAddress.theme.cellHeight = Common.Size(s:40)
        tfCreateAddress.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        
        tfCreateAddress.leftViewMode = UITextField.ViewMode.always
        let imageNoiCapCMND = UIImageView(frame: CGRect(x: tfCreateAddress.frame.size.height/4, y: tfCreateAddress.frame.size.height/4, width: tfCreateAddress.frame.size.height/2, height: tfCreateAddress.frame.size.height/2))
        imageNoiCapCMND.image = UIImage(named: "Home-50-1")
        imageNoiCapCMND.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewNoiCapCMND = UIView()
        leftViewNoiCapCMND.addSubview(imageNoiCapCMND)
        leftViewNoiCapCMND.frame = CGRect(x: 0, y: 0, width: tfCreateAddress.frame.size.height, height: tfCreateAddress.frame.size.height)
        tfCreateAddress.leftView = leftViewNoiCapCMND
        
        
        
        
        let lbTitleXacNhanThongTin = UILabel(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: tfCreateAddress.frame.origin.y + tfCreateAddress.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbTitleXacNhanThongTin.textAlignment = .left
        lbTitleXacNhanThongTin.textColor = UIColor(netHex:0x47B054)
        lbTitleXacNhanThongTin.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbTitleXacNhanThongTin.text = "Xác nhận thông tin"
        scrollView.addSubview(lbTitleXacNhanThongTin)
        
        //input so dien thoai ssd
        let lblSDTSSD =  UILabel(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: lbTitleXacNhanThongTin.frame.origin.y + lbTitleXacNhanThongTin.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblSDTSSD.textAlignment = .left
        lblSDTSSD.textColor = UIColor.black
        lblSDTSSD.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSDTSSD.text = "Số điện thoại SSD"
        scrollView.addSubview(lblSDTSSD)
        
        
        let tfSDTSSD = UITextField(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: lblSDTSSD.frame.origin.y + lblSDTSSD.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfSDTSSD.placeholder = "SĐT"
        
        tfSDTSSD.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSDTSSD.borderStyle = UITextField.BorderStyle.roundedRect
        tfSDTSSD.autocorrectionType = UITextAutocorrectionType.no
        
        tfSDTSSD.keyboardType = UIKeyboardType.numberPad
        tfSDTSSD.returnKeyType = UIReturnKeyType.done
        tfSDTSSD.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfSDTSSD.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSDTSSD.delegate = self
        scrollView.addSubview(tfSDTSSD)
        //tfUserBirthday.addTarget(self, action: #selector(textFieldDidChangeBirthday(_:)), for: .editingChanged)
        tfSDTSSD.text = self.info?.SDTSSD
        tfSDTSSD.isUserInteractionEnabled = false
        tfSDTSSD.isEnabled = false
        
        //input ngay kich hoat
        let lblNgayKichHoat =  UILabel(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: tfSDTSSD.frame.origin.y + tfSDTSSD.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblNgayKichHoat.textAlignment = .left
        lblNgayKichHoat.textColor = UIColor.black
        lblNgayKichHoat.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNgayKichHoat.text = "Ngày kích hoạt"
        scrollView.addSubview(lblNgayKichHoat)
        
        
        let tfNgayKichHoat = UITextField(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: lblNgayKichHoat.frame.origin.y + lblNgayKichHoat.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfNgayKichHoat.placeholder = "Ngày kích hoạt"
        
        tfNgayKichHoat.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfNgayKichHoat.borderStyle = UITextField.BorderStyle.roundedRect
        tfNgayKichHoat.autocorrectionType = UITextAutocorrectionType.no
        
        tfNgayKichHoat.keyboardType = UIKeyboardType.numberPad
        tfNgayKichHoat.returnKeyType = UIReturnKeyType.done
        tfNgayKichHoat.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfNgayKichHoat.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfNgayKichHoat.delegate = self
        scrollView.addSubview(tfNgayKichHoat)
        //tfUserBirthday.addTarget(self, action: #selector(textFieldDidChangeBirthday(_:)), for: .editingChanged)
        tfNgayKichHoat.text = self.info?.NgayKichHoat
        tfNgayKichHoat.isUserInteractionEnabled = false
        tfNgayKichHoat.isEnabled = false
        
        
        //input imei may
        let lblImei =  UILabel(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: tfNgayKichHoat.frame.origin.y + tfNgayKichHoat.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblImei.textAlignment = .left
        lblImei.textColor = UIColor.black
        lblImei.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblImei.text = "Imei"
        scrollView.addSubview(lblImei)
        
        
        let tfImei = UITextField(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: lblImei.frame.origin.y + lblImei.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfImei.placeholder = "Nhập SĐT"
        
        tfImei.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfImei.borderStyle = UITextField.BorderStyle.roundedRect
        tfImei.autocorrectionType = UITextAutocorrectionType.no
        
        tfImei.keyboardType = UIKeyboardType.numberPad
        tfImei.returnKeyType = UIReturnKeyType.done
        tfImei.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfImei.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfImei.delegate = self
        scrollView.addSubview(tfImei)
        //tfUserBirthday.addTarget(self, action: #selector(textFieldDidChangeBirthday(_:)), for: .editingChanged)
        tfImei.text = self.info?.ImeiMay
        tfImei.isUserInteractionEnabled = false
        tfImei.isEnabled = false
        
        
        //input ten may
        let lblTenMay =  UILabel(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: tfImei.frame.origin.y + tfImei.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTenMay.textAlignment = .left
        lblTenMay.textColor = UIColor.black
        lblTenMay.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTenMay.text = "Tên máy"
        scrollView.addSubview(lblTenMay)
        
        
        let tfTenMay = UITextField(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: lblTenMay.frame.origin.y + lblTenMay.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfTenMay.placeholder = "Tên máy"
        
        tfTenMay.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTenMay.borderStyle = UITextField.BorderStyle.roundedRect
        tfTenMay.autocorrectionType = UITextAutocorrectionType.no
        
        tfTenMay.keyboardType = UIKeyboardType.numberPad
        tfTenMay.returnKeyType = UIReturnKeyType.done
        tfTenMay.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfTenMay.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTenMay.delegate = self
        scrollView.addSubview(tfTenMay)
        //tfUserBirthday.addTarget(self, action: #selector(textFieldDidChangeBirthday(_:)), for: .editingChanged)
        tfTenMay.text = self.info?.TenSP
        tfTenMay.isUserInteractionEnabled = false
        tfTenMay.isEnabled = false
        
        
        //input goi cuoc
        let lblGoiCuoc =  UILabel(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: tfTenMay.frame.origin.y + tfTenMay.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblGoiCuoc.textAlignment = .left
        lblGoiCuoc.textColor = UIColor.black
        lblGoiCuoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblGoiCuoc.text = "Gói cước"
        scrollView.addSubview(lblGoiCuoc)
        
        
        
        let tfGoiCuoc = UITextField(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: lblGoiCuoc.frame.origin.y + lblGoiCuoc.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfGoiCuoc.placeholder = "Nhập tên máy"
        
        tfGoiCuoc.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfGoiCuoc.borderStyle = UITextField.BorderStyle.roundedRect
        tfGoiCuoc.autocorrectionType = UITextAutocorrectionType.no
        
        tfGoiCuoc.keyboardType = UIKeyboardType.numberPad
        tfGoiCuoc.returnKeyType = UIReturnKeyType.done
        tfGoiCuoc.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfGoiCuoc.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfGoiCuoc.delegate = self
        scrollView.addSubview(tfGoiCuoc)
        //tfUserBirthday.addTarget(self, action: #selector(textFieldDidChangeBirthday(_:)), for: .editingChanged)
        tfGoiCuoc.text = self.info?.GoiCuoc
        tfGoiCuoc.isUserInteractionEnabled = false
        tfGoiCuoc.isEnabled = false
        
        
        let lblTitleUploadHinh = UILabel(frame: CGRect(x: lbTextThongTinKH.frame.origin.x, y: tfGoiCuoc.frame.origin.y + tfGoiCuoc.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
        lblTitleUploadHinh.textAlignment = .left
        lblTitleUploadHinh.textColor = UIColor(netHex:0x47B054)
        lblTitleUploadHinh.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lblTitleUploadHinh.text = "Hình ảnh CMND"
        scrollView.addSubview(lblTitleUploadHinh)
        
        
        // up hinh cmnd mat truoc
        
        viewInfoCMNDTruoc = UIView(frame: CGRect(x:0,y:lblTitleUploadHinh.frame.origin.y + lblTitleUploadHinh.frame.size.height + Common.Size(s:20),width:scrollView.frame.size.width, height: 100))
        viewInfoCMNDTruoc.clipsToBounds = true
        scrollView.addSubview(viewInfoCMNDTruoc)
        
        lbTextCMNDTruoc = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMNDTruoc.textAlignment = .left
        lbTextCMNDTruoc.textColor = UIColor.black
        lbTextCMNDTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMNDTruoc.text = "Mặt trước CMND (*)"
        viewInfoCMNDTruoc.addSubview(lbTextCMNDTruoc)
        
        viewImageCMNDTruoc = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextCMNDTruoc.frame.origin.y + lbTextCMNDTruoc.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageCMNDTruoc.layer.borderWidth = 0.5
        viewImageCMNDTruoc.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageCMNDTruoc.layer.cornerRadius = 3.0
        viewInfoCMNDTruoc.addSubview(viewImageCMNDTruoc)
        
        viewCMNDTruocButton = UIImageView(frame: CGRect(x: viewImageCMNDTruoc.frame.size.width/2 - (viewImageCMNDTruoc.frame.size.height * 2/3)/2, y: 0, width: viewImageCMNDTruoc.frame.size.height * 2/3, height: viewImageCMNDTruoc.frame.size.height * 2/3))
        viewCMNDTruocButton.image = #imageLiteral(resourceName: "AddImage51")
        viewCMNDTruocButton.contentMode = .scaleAspectFit
        viewImageCMNDTruoc.addSubview(viewCMNDTruocButton)
        
        
        lbCMNDTruocButton = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageCMNDTruoc.frame.size.height/3))
        lbCMNDTruocButton.textAlignment = .center
        lbCMNDTruocButton.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDTruocButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDTruocButton.text = "Thêm hình ảnh"
        viewImageCMNDTruoc.addSubview(lbCMNDTruocButton)
        
        viewInfoCMNDTruoc.frame.size.height = viewImageCMNDTruoc.frame.size.height + viewImageCMNDTruoc.frame.origin.y
        
        
        let tapShowCMNDTruoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDTruoc))
        //viewImageCMNDTruoc.isUserInteractionEnabled = false
        viewImageCMNDTruoc.addGestureRecognizer(tapShowCMNDTruoc)
        
        
        // up hinh cmnd mat sau
        viewInfoCMNDSau = UIView(frame: CGRect(x:0,y:viewInfoCMNDTruoc.frame.size.height + viewInfoCMNDTruoc.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoCMNDSau.clipsToBounds = true
        scrollView.addSubview(viewInfoCMNDSau)
        
        let lbTextCMNDSau = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMNDSau.textAlignment = .left
        lbTextCMNDSau.textColor = UIColor.black
        lbTextCMNDSau.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMNDSau.text = "Mặt sau CMND (*)"
        viewInfoCMNDSau.addSubview(lbTextCMNDSau)
        
        viewImageCMNDSau = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextCMNDSau.frame.origin.y + lbTextCMNDSau.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageCMNDSau.layer.borderWidth = 0.5
        viewImageCMNDSau.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageCMNDSau.layer.cornerRadius = 3.0
        viewInfoCMNDSau.addSubview(viewImageCMNDSau)
        
        let viewCMNDSauButton = UIImageView(frame: CGRect(x: viewImageCMNDSau.frame.size.width/2 - (viewImageCMNDSau.frame.size.height * 2/3)/2, y: 0, width: viewImageCMNDSau.frame.size.height * 2/3, height: viewImageCMNDSau.frame.size.height * 2/3))
        viewCMNDSauButton.image = #imageLiteral(resourceName: "AddImage51")
        viewCMNDSauButton.contentMode = .scaleAspectFit
        viewImageCMNDSau.addSubview(viewCMNDSauButton)
        
        let lbCMNDSauButton = UILabel(frame: CGRect(x: 0, y: viewCMNDSauButton.frame.size.height + viewCMNDSauButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageCMNDSau.frame.size.height/3))
        lbCMNDSauButton.textAlignment = .center
        lbCMNDSauButton.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDSauButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDSauButton.text = "Thêm hình ảnh"
        viewImageCMNDSau.addSubview(lbCMNDSauButton)
        
        viewInfoCMNDSau.frame.size.height = viewImageCMNDSau.frame.size.height + viewImageCMNDSau.frame.origin.y
        
        
        
        
        let tapShowCMNDSau = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDSau))
        //viewImageCMNDSau.isUserInteractionEnabled = false
        viewImageCMNDSau.addGestureRecognizer(tapShowCMNDSau)
        
        
        
        
        
        //sign
        viewSign = UIView(frame: CGRect(x:0, y: viewInfoCMNDSau.frame.origin.y + viewInfoCMNDSau.frame.size.height + Common.Size(s:10), width:scrollView.frame.size.width, height: 100))
        viewSign.clipsToBounds = true
        
        scrollView.addSubview(viewSign)
        
        let lbTextSign = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSign.textAlignment = .left
        lbTextSign.textColor = UIColor(netHex:0x47B054)
        lbTextSign.font = UIFont.systemFont(ofSize: Common.Size(s:18))
        lbTextSign.text = "Chữ ký"
        lbTextSign.sizeToFit()
        viewSign.addSubview(lbTextSign)
        
        viewImageSign = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSign.frame.origin.y + lbTextSign.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSign.layer.borderWidth = 0.5
        viewImageSign.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSign.layer.cornerRadius = 3.0
        viewSign.addSubview(viewImageSign)
        
        let viewSignButton = UIImageView(frame: CGRect(x: viewImageSign.frame.size.width/2 - (viewImageSign.frame.size.height * 2/3)/2, y: 0, width: viewImageSign.frame.size.height * 2/3, height: viewImageSign.frame.size.height * 2/3))
        viewSignButton.image = UIImage(named:"Sign Up-50")
        viewSignButton.contentMode = .scaleAspectFit
        viewImageSign.addSubview(viewSignButton)
        
        let lbSignButton = UILabel(frame: CGRect(x: 0, y: viewSignButton.frame.size.height + viewSignButton.frame.origin.y, width: viewImageSign.frame.size.width, height: viewImageSign.frame.size.height/3))
        lbSignButton.textAlignment = .center
        lbSignButton.textColor = UIColor(netHex:0xc2c2c2)
        lbSignButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSignButton.text = "Thêm chữ ký"
        viewImageSign.addSubview(lbSignButton)
        
        viewSign.frame.size.height = viewImageSign.frame.origin.y + viewImageSign.frame.size.height
        
        let tapShowSign = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSign))
        //viewSign.isUserInteractionEnabled = false
        viewSign.addGestureRecognizer(tapShowSign)
        
        
        // button luu
        btHoanTat = UIButton()
        btHoanTat.frame = CGRect(x: lbTextThongTinKH.frame.origin.x, y: viewSign.frame.origin.y + viewSign.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30),height: Common.Size(s:40))
        btHoanTat.backgroundColor = UIColor(netHex:0x47B054)
        btHoanTat.setTitle("Hoàn tất", for: .normal)
        btHoanTat.addTarget(self, action: #selector(uploadImage), for: .touchUpInside)
        btHoanTat.layer.borderWidth = 0.5
        btHoanTat.layer.borderColor = UIColor.white.cgColor
        btHoanTat.layer.cornerRadius = 3
        scrollView.addSubview(btHoanTat)
        btHoanTat.clipsToBounds = true
        
        //
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btHoanTat.frame.origin.y + btHoanTat.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 60))
    }
    
    
    @objc func tapShowCMNDTruoc(sender:UITapGestureRecognizer) {
        self.posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowCMNDSau(sender:UITapGestureRecognizer) {
        self.posImageUpload = 2
        self.thisIsTheFunctionWeAreCalling()
    }
    
    func imageCMNDTruoc(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDTruoc.frame.size.width / sca
        viewImageCMNDTruoc.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDTruoc  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDTruoc.frame.size.width, height: heightImage))
        imgViewCMNDTruoc.contentMode = .scaleAspectFit
        imgViewCMNDTruoc.image = image
        viewImageCMNDTruoc.addSubview(imgViewCMNDTruoc)
        viewImageCMNDTruoc.frame.size.height = imgViewCMNDTruoc.frame.size.height + imgViewCMNDTruoc.frame.origin.y
        viewInfoCMNDTruoc.frame.size.height = viewImageCMNDTruoc.frame.size.height + viewImageCMNDTruoc.frame.origin.y
        viewInfoCMNDSau.frame.origin.y = viewInfoCMNDTruoc.frame.size.height + viewInfoCMNDTruoc.frame.origin.y + Common.Size(s:10)
        
        
        
        viewSign.frame.origin.y = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y
            + Common.Size(s:10)
        
        
        btHoanTat.frame.origin.y = viewSign.frame.size.height + viewSign.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btHoanTat.frame.origin.y + btHoanTat.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    func imageCMNDSau(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDSau.frame.size.width / sca
        viewImageCMNDSau.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDSau  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDSau.frame.size.width, height: heightImage))
        imgViewCMNDSau.contentMode = .scaleAspectFit
        imgViewCMNDSau.image = image
        viewImageCMNDSau.addSubview(imgViewCMNDSau)
        viewImageCMNDSau.frame.size.height = imgViewCMNDSau.frame.size.height + imgViewCMNDSau.frame.origin.y
        viewInfoCMNDSau.frame.size.height = viewImageCMNDSau.frame.size.height + viewImageCMNDSau.frame.origin.y
        
        
        viewSign.frame.origin.y = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y
            + Common.Size(s:10)
        
        
        btHoanTat.frame.origin.y = viewSign.frame.size.height + viewSign.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btHoanTat.frame.origin.y + btHoanTat.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func loadInfoLockDevide(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang nạp thông tin khách hàng..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.loadInfoLockDevice(CMND:self.cmnd) { (results,IsLogin,p_Status, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(IsLogin == "1"){
                    let title = "Thông báo"
                 
                    
                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    
                    let buttonOne = CancelButton(title: "OK") {
                        
                        let defaults = UserDefaults.standard
                        defaults.removeObject(forKey: "UserName")
                        defaults.removeObject(forKey: "Password")
                        defaults.removeObject(forKey: "mDate")
                        defaults.removeObject(forKey: "mCardNumber")
                        defaults.removeObject(forKey: "typePhone")
                        defaults.removeObject(forKey: "mPrice")
                        defaults.removeObject(forKey: "mPriceCardDisplay")
                        defaults.removeObject(forKey: "CRMCodeLogin")
                        defaults.synchronize()
                      //  MPOSAPIManager.removeDeviceToken()
                        // Initialize the window
                        self.window = UIWindow.init(frame: UIScreen.main.bounds)
                        
                        // Set Background Color of window
                        self.window?.backgroundColor = UIColor.white
                        
                        // Allocate memory for an instance of the 'MainViewController' class
                        let mainViewController = LoginViewController()
                        
                        // Set the root view controller of the app's window
                        self.window!.rootViewController = mainViewController
                        
                        // Make the window visible
                        self.window!.makeKeyAndVisible()
                        
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                    return
                }
                if(p_Status == "0"){
                    let title = "Thông báo"
                  
                    
                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                        
                        
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    return
                    
                }
                if(err.count <= 0){
                    if(results.count > 0){
                        self.info = results[0]

                        self.loadUI()
                    }else{
                        
                        let title = "Thông báo"
                   
                        
                        let popup = PopupDialog(title: title, message: "Không tìm thấy thông tin khách hàng", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        
                        
                        let buttonOne = CancelButton(title: "OK") {
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                    
                    
                    
                    
                    
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func callUploadApi(base64:String, type:String){
        let newViewController = LoadingViewController()
        if(type == "1"){
            newViewController.content = "Đang upload CMND mặt trước..."
        }
        if(type == "2"){
            newViewController.content = "Đang upload CMND mặt sau..."
        }
        if(type == "3"){
            newViewController.content = "Đang upload chữ ký khách hàng..."
        }
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        
        MPOSAPIManager.uploadImageLockDevice(CMND: self.cmnd!,base64:base64,type:type) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if (err.count <= 0 ){
                    if(results.Success == true){
                        if(type == "1"){
                            if(results.Url == ""){
                              
                                let popup = PopupDialog(title: "Thông báo", message: "result.url nul", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                    
                                    
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                                return
                            }
                            self.urlMTCMND = results.Url
                            self.uploadImage()
                        }
                        if(type == "2"){
                            if(results.Url == ""){
                           
                                
                                
                                let popup = PopupDialog(title: "Thông báo", message: "result.url nul", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                
                                let buttonOne = CancelButton(title: "OK") {
                                    
                                    
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                                return
                            }
                            self.urlMSCMND = results.Url
                            self.uploadImage()
                        }
                        if(type == "3"){
                            if(results.Url == ""){
                               
                                
                                let popup = PopupDialog(title: "Thông báo", message: "result.url nul", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                
                                
                                let buttonOne = CancelButton(title: "OK") {
                                    
                                    
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                                return
                            }
                            self.urlPhieuCamKet = results.Url
                            self.uploadImage()
                        }
                    }else{
                        
                     
                        
                        
                        let popup = PopupDialog(title: "Thông báo", message: results.Message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        
                        let buttonOne = CancelButton(title: "OK") {
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                        
                    }
                    
                    
                    
                }else{
                  
                    
                    let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
    
    
    @objc func uploadImage(){
        if(self.imgViewCMNDTruoc == nil){
           
             self.showDialog(message: "Chưa có hình mặt trước CMND")
            return
        }
        if(self.imgViewCMNDSau == nil){
        
             self.showDialog(message: "Chưa có hình mặt sau CMND")
            return
        }
        if(self.imgViewSignature == nil){
            
            self.showDialog(message: "Chưa có chữ ký khách hàng")
            return
        }
        if(self.urlMTCMND == ""){
            if let imageDataCMNDTruoc:NSData = imgViewCMNDTruoc.image!.jpegData(compressionQuality: Common.resizeImageValue) as NSData?{
                
                let strBase64CMNDMatTruoc = imageDataCMNDTruoc.base64EncodedString(options: .endLineWithLineFeed)
                self.callUploadApi(base64: strBase64CMNDMatTruoc, type: "1")
            }
        }
        if(self.urlMSCMND == "" && self.urlMTCMND != ""){
            if let imageDataCMNDSau:NSData = imgViewCMNDSau.image!.jpegData(compressionQuality: Common.resizeImageValue) as NSData?{
                let strBase64CMNDMatSau = imageDataCMNDSau.base64EncodedString(options: .endLineWithLineFeed)
                
                self.callUploadApi(base64: strBase64CMNDMatSau, type: "2")
            }
        }
        if(self.urlPhieuCamKet == "" && self.urlMSCMND != ""){
            
            let imageSign:UIImage = self.resizeImage(image: imgViewSignature.image!,newHeight: 500)!
            if let imageDataChuKy:NSData = imageSign.pngData() as NSData?{
                let srtBase64ChuKy = imageDataChuKy.base64EncodedString(options: .endLineWithLineFeed)
                
                self.callUploadApi(base64: srtBase64ChuKy, type: "3")
                
            }
        }
        if(self.urlMTCMND != "" && self.urlMSCMND != "" && self.urlPhieuCamKet != ""){
            self.hoatTat()
        }
        
        
    }
    
    func hoatTat(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang khoá máy khách hàng..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.hoantatLockDevice(Device: (self.info?.ImeiMay)!, url_cmnd_matTruoc: self.urlMTCMND , url_cmnd_matsau: self.urlMSCMND , url_PhieuCamKet:self.urlPhieuCamKet) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if (results.Success == true){
                    
                
                    
                    
                    let popup = PopupDialog(title: "Thông báo", message: results.Message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    
                    
                    let buttonOne = CancelButton(title: "OK") {
                        
                        let newViewController2 = SearchSubsidyViewController()
                        
                        self.navigationController?.pushViewController(newViewController2, animated: true)
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                    
                }else{
                    if(results.Message != ""){
                    
                        
                        
                        let popup = PopupDialog(title: "Thông báo", message: results.Message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        
                        
                        let buttonOne = CancelButton(title: "OK") {
                            
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                        
                    }else{
                        
                      
                        
                        let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
    }
    
    
    @objc func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
}

extension BaoMatMayViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
        let camera = DSCameraHandler(delegate_: self)
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let takePhoto = UIAlertAction(title: "Chụp ảnh", style: .default) { (alert : UIAlertAction!) in
            camera.getCameraOn(self, canEdit: false)
        }
        let sharePhoto = UIAlertAction(title: "Chọn ảnh có sẵn", style: .default) { (alert : UIAlertAction!) in
            camera.getPhotoLibraryOn(self, canEdit: false)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(sharePhoto)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
   
    
    //
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        // image is our desired image
        if (self.posImageUpload == 1){
            self.imageCMNDTruoc(image: image)
        }else if (self.posImageUpload == 2){
            self.imageCMNDSau(image: image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    //
    
    
    
    // chu ky lib
    @objc func tapShowSign(sender:UITapGestureRecognizer) {
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
//        let nav = UINavigationController(rootViewController: signatureVC)
//        present(nav, animated: true, completion: nil)
         self.navigationController?.pushViewController(signatureVC, animated: true)
    }
    func epSignature(_: EPSignatureViewController, didCancel error : NSError) {
        print("User canceled")
        _ = self.navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
    }
    
    func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect) {
        print(signatureImage)
        print(boundingRect)
        
        let width = viewImageSign.frame.size.width - Common.Size(s:10)
        
        let sca:CGFloat = boundingRect.size.width / boundingRect.size.height
        let heightImage:CGFloat = width / sca
        
        viewImageSign.subviews.forEach { $0.removeFromSuperview() }
        imgViewSignature  = UIImageView(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:5), width: width, height: heightImage))
        //        imgViewSignature.backgroundColor = .red
        imgViewSignature.contentMode = .scaleAspectFit
        viewImageSign.addSubview(imgViewSignature)
        imgViewSignature.image = cropImage(image: signatureImage, toRect: boundingRect)
        
        viewImageSign.frame.size.height = imgViewSignature.frame.size.height + imgViewSignature.frame.origin.y + Common.Size(s:5)
        viewSign.frame.size.height = viewImageSign.frame.origin.y + viewImageSign.frame.size.height
        
        
        
        btHoanTat.frame.origin.y = viewSign.frame.size.height + viewSign.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btHoanTat.frame.origin.y + btHoanTat.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        _ = self.navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
    }
    
    
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
    
    
    func checkDate(stringDate:String) -> Bool{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yyyy"
        
        if let _ = dateFormatterGet.date(from: stringDate) {
            return true
        } else {
            return false
        }
    }
    
    
//    override func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SimUpdateInformationViewControlller.dismissKeyboard))
//        view.addGestureRecognizer(tap)
//
//    }
    
    override func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage? {
        
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    func resizeImageWidth(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    
    
    
    
}

