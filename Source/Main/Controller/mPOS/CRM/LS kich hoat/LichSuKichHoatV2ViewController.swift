//
//  LichSuKichHoatV2ViewController.swift
//  mPOS
//
//  Created by tan on 10/1/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import Presentr
class LichSuKichHoatV2ViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate {
    var scrollView:UIScrollView!
    var tfChonGioDen:UITextField!
    var tfChonGioTu:UITextField!
    let datePicker = UIDatePicker()
    var btTimKiem:UIButton!
    var viewTableListSim:UITableView  =   UITableView()
    var listSim:[LichSuKichHoatV2] = []
    var tfSDT:UITextField!
    var tfSerial:UITextField!
    let presenter: Presentr = {
        let dynamicType = PresentationType.dynamic(center: ModalCenterPosition.center)
        let customPresenter = Presentr(presentationType: dynamicType)
        customPresenter.backgroundOpacity = 0.3
        customPresenter.roundCorners = true
        customPresenter.dismissOnSwipe = false
        customPresenter.dismissAnimated = false
        customPresenter.backgroundTap = .noAction
        return customPresenter
    }()

    override func viewDidLoad() {
        self.title = "Lịch sử kích hoạt"
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(LichSuKichHoatV2ViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        navigationController?.navigationBar.isTranslucent = false
        
        let lbTitleSDT =  UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:200), height: Common.Size(s:14)))
        lbTitleSDT.textAlignment = .left
        lbTitleSDT.textColor = UIColor.black
        lbTitleSDT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitleSDT.text = "Số điện thoại"
        scrollView.addSubview(lbTitleSDT)
        
        tfSDT = UITextField(frame: CGRect(x: Common.Size(s: 10), y: lbTitleSDT.frame.origin.y + lbTitleSDT.frame.size.height + Common.Size(s: 10), width: UIScreen.main.bounds.size.width - Common.Size(s: 30)  , height: Common.Size(s:40)));
        
        tfSDT.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSDT.borderStyle = UITextField.BorderStyle.roundedRect
        tfSDT.autocorrectionType = UITextAutocorrectionType.no
        tfSDT.keyboardType = UIKeyboardType.numberPad
        tfSDT.returnKeyType = UIReturnKeyType.done
        tfSDT.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfSDT.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSDT.placeholder = "Vui lòng nhập SĐT"
        scrollView.addSubview(tfSDT)
        
        let lbTitleSerial =  UILabel(frame: CGRect(x: Common.Size(s:15), y: tfSDT.frame.origin.y + tfSDT.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:200), height: Common.Size(s:14)))
        lbTitleSerial.textAlignment = .left
        lbTitleSerial.textColor = UIColor.black
        lbTitleSerial.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitleSerial.text = "Serial"
        scrollView.addSubview(lbTitleSerial)
        
        tfSerial = UITextField(frame: CGRect(x: Common.Size(s: 10), y: lbTitleSerial.frame.origin.y + lbTitleSerial.frame.size.height + Common.Size(s: 10), width: UIScreen.main.bounds.size.width - Common.Size(s: 30)  , height: Common.Size(s:40)));
        
        tfSerial.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSerial.borderStyle = UITextField.BorderStyle.roundedRect
        tfSerial.autocorrectionType = UITextAutocorrectionType.no
        tfSerial.returnKeyType = UIReturnKeyType.done
        tfSerial.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSerial.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSerial.placeholder = "Vui lòng nhập Serial"
        tfSerial.rightViewMode = .always
        let searchImageRight = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        let searchImageViewRight = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        let scan = UIImage(named: "scan_barcode")
        searchImageViewRight.image = scan
        searchImageRight.addSubview(searchImageViewRight)
        tfSerial.rightView = searchImageRight
        let gestureSearchImageRight = UITapGestureRecognizer(target: self, action:  #selector(self.actionScan))
        searchImageRight.addGestureRecognizer(gestureSearchImageRight)
        scrollView.addSubview(tfSerial)
        
        
        let lbTitleNgayTu =  UILabel(frame: CGRect(x: Common.Size(s:15), y: tfSerial.frame.origin.y + tfSerial.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:200), height: Common.Size(s:14)))
        lbTitleNgayTu.textAlignment = .left
        lbTitleNgayTu.textColor = UIColor.black
        lbTitleNgayTu.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitleNgayTu.text = "Tìm từ ngày"
        scrollView.addSubview(lbTitleNgayTu)
        
        tfChonGioTu = UITextField(frame: CGRect(x: Common.Size(s: 10), y: lbTitleNgayTu.frame.origin.y + lbTitleNgayTu.frame.size.height + Common.Size(s: 10), width: UIScreen.main.bounds.size.width - Common.Size(s: 200)  , height: Common.Size(s:40)));
        
        tfChonGioTu.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfChonGioTu.borderStyle = UITextField.BorderStyle.roundedRect
        tfChonGioTu.autocorrectionType = UITextAutocorrectionType.no
        tfChonGioTu.keyboardType = UIKeyboardType.default
        tfChonGioTu.returnKeyType = UIReturnKeyType.done
        tfChonGioTu.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfChonGioTu.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
       // let gestureChonNgayTu = UITapGestureRecognizer(target: self, action:  #selector (self.actionChonNgayTu (_:)))
        let gestureChonNgayTu = UITapGestureRecognizer(target: self, action:  #selector (self.showCalendar1 ))
        tfChonGioTu.addGestureRecognizer(gestureChonNgayTu)
        tfChonGioTu.placeholder = "Bấm vào để chọn ngày"
        scrollView.addSubview(tfChonGioTu)
        
        let lbTitleNgayDen =  UILabel(frame: CGRect(x: lbTitleNgayTu.frame.origin.x + lbTitleNgayTu.frame.size.width + Common.Size(s: 40) , y: tfSerial.frame.origin.y + tfSerial.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTitleNgayDen.textAlignment = .left
        lbTitleNgayDen.textColor = UIColor.black
        lbTitleNgayDen.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitleNgayDen.text = "Đến ngày"
        scrollView.addSubview(lbTitleNgayDen)
        
        tfChonGioDen = UITextField(frame: CGRect(x: tfChonGioTu.frame.origin.x + tfChonGioTu.frame.size.width + Common.Size(s: 40), y: lbTitleNgayTu.frame.origin.y + lbTitleNgayTu.frame.size.height + Common.Size(s: 10), width: UIScreen.main.bounds.size.width - Common.Size(s: 200)  , height: Common.Size(s:40)));
        
        tfChonGioDen.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfChonGioDen.borderStyle = UITextField.BorderStyle.roundedRect
        tfChonGioDen.autocorrectionType = UITextAutocorrectionType.no
        tfChonGioDen.keyboardType = UIKeyboardType.default
        tfChonGioDen.returnKeyType = UIReturnKeyType.done
        tfChonGioDen.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfChonGioDen.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfChonGioDen.placeholder = "Bấm vào để chọn ngày"
       // let gestureChonNgayDen = UITapGestureRecognizer(target: self, action:  #selector (self.actionChonNgayDen (_:)))
            let gestureChonNgayDen = UITapGestureRecognizer(target: self, action:  #selector (self.showCalendar2))
        tfChonGioDen.addGestureRecognizer(gestureChonNgayDen)
        scrollView.addSubview(tfChonGioDen)
        
        
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)
        tfChonGioTu.text = result
        tfChonGioDen.text = result
        
        
        // button luu
        btTimKiem = UIButton()
        btTimKiem.frame = CGRect(x: tfChonGioTu.frame.origin.x, y: tfChonGioDen.frame.origin.y + tfChonGioDen.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30),height: Common.Size(s: 40))
        btTimKiem.backgroundColor = UIColor(netHex:0x47B054)
        btTimKiem.setTitle("Tìm kiếm", for: .normal)
        btTimKiem.addTarget(self, action: #selector(actionTimKiem), for: .touchUpInside)
        btTimKiem.layer.borderWidth = 0.5
        btTimKiem.layer.borderColor = UIColor.white.cgColor
        btTimKiem.layer.cornerRadius = 3
        scrollView.addSubview(btTimKiem)
        btTimKiem.clipsToBounds = true
        
        
        let width:CGFloat = UIScreen.main.bounds.size.width
        viewTableListSim.frame = CGRect(x: 0, y: btTimKiem.frame.origin.y + btTimKiem.frame.size.height + Common.Size(s:20), width: width, height: Common.Size(s: 270) )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        viewTableListSim.dataSource = self
        viewTableListSim.delegate = self
        viewTableListSim.register(ItemSimKHByShopV2TableViewCell.self, forCellReuseIdentifier: "ItemSimKHByShopV2TableViewCell")
        viewTableListSim.tableFooterView = UIView()
        viewTableListSim.backgroundColor = UIColor.white
        
        scrollView.addSubview(viewTableListSim)
        navigationController?.navigationBar.isTranslucent = false
        

    }
    
    @objc func actionScan() {
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { text in
            self.tfSerial.text = text
        }
        
        self.present(viewController, animated: false, completion: nil)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSim.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemSimKHByShopV2TableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemSimKHByShopV2TableViewCell")
        let item:LichSuKichHoatV2 = self.listSim[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:190);
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let item:LichSuKichHoatV2 = self.listSim[indexPath.row]
        print("\(indexPath.row)")
        if(item.is_esim == 1){
            if item.Provider == "Itelecom" {
                self.genQRCodeItel(serial: "\(item.SeriSIM)", phoneNum: "\(item.Phonenumber)")
            } else {
                self.getQRcode(phoneNumber: item.Phonenumber, SOMPOS: "\(item.SOMPOS)", SeriSim: "\(item.SeriSIM)")
            }
        }
    }
    
    func getQRcode(phoneNumber:String,SOMPOS:String,SeriSim:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang Gen QRCode vui lòng chờ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.sp_mpos_FRT_SP_ESIM_getqrcode(SDT:
        phoneNumber,SOMPOS: SOMPOS,SeriSim: SeriSim) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if (err.count <= 0){
                    results[0].sdt = phoneNumber
                    let newViewController = GenQRCodeEsimViewController()
                    newViewController.esimQRCode = results[0]
                    newViewController.isHistory = true
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }else{
                    self.showDialog(message: err)
                }
            }
        }
    }
    
    func genQRCodeItel(serial: String, phoneNum: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang gen qrcode Itel...") {
            CRMAPIManager.Itel_GetQrCode(serial: serial) { (qrcode, iccid, errMsg, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if errMsg.count <= 0 {
                            let newViewController = GenQRCodeEsimViewController()
                            newViewController.esimQRCode = EsimQRCode(arrQRCode: qrcode ?? "", imsi: "", serial: iccid ?? "", status: "", urlEsim: "", sdt: phoneNum)
                            newViewController.isHistory = true
                            self.navigationController?.pushViewController(newViewController, animated: true)
                            
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "\(errMsg)\n Số thuê bao: \(phoneNum) \n Seri: \(serial)", preferredStyle: UIAlertController.Style.alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    
    @objc func actionTimKiem(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy danh sách sim..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        if !self.tfSDT.text&.isEmpty {
            MPOSAPIManager.getListLichSuKichHoat(phoneNumber: self.tfSDT.text!,FromDate:self.tfChonGioTu.text!,ToDate:self.tfChonGioDen.text!) { (results, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        self.listSim = results
                        self.viewTableListSim.reloadData()
                    }else{
                        self.showDialog(message: err)
                    }
                }
            }
        } else if !self.tfSerial.text&.isEmpty {
            MPOSAPIManager.getListLichSuKichHoatSerial(serial: self.tfSerial.text!, FromDate: self.tfChonGioTu.text!, ToDate: self.tfChonGioDen.text!, handler: { (results, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        self.listSim = results
                        self.viewTableListSim.reloadData()
                    }else{
                        self.showDialog(message: err)
                    }
                }
            })
        }
    }
    
    @objc func actionChonNgayDen(_ sender:UITapGestureRecognizer){
        showDatePickerNgayDen()
    }
    @objc func actionChonNgayTu(_ sender:UITapGestureRecognizer){
        showDatePickerNgayTu()
    }
    func showDatePickerNgayTu(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donedatePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        // add toolbar to textField
        tfChonGioTu.inputAccessoryView = toolbar
        // add datepicker to textField
        tfChonGioTu.inputView = datePicker
        
    }
    
    func showDatePickerNgayDen(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donedatePickerNgayDen))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelDatePickerNgayDen))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        // add toolbar to textField
        tfChonGioDen.inputAccessoryView = toolbar
        // add datepicker to textField
        tfChonGioDen.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        tfChonGioTu.text = formatter.string(from: datePicker.date)
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
    
    @objc func donedatePickerNgayDen(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        tfChonGioDen.text = formatter.string(from: datePicker.date)
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePickerNgayDen(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
    
    @objc func showCalendar1() {
        debugPrint("show calendar1")
        let calendarVC = CalendarViewController1()
        presenter.cornerRadius = 8
        self.customPresentViewController(presenter, viewController: calendarVC, animated: true)
        calendarVC.delegate = self
        
    }
    
    @objc func showCalendar2() {
        debugPrint("show calendar2")
        let calendarVC = CalendarViewController2()
        presenter.cornerRadius = 8
        self.customPresentViewController(presenter, viewController: calendarVC, animated: true)
        calendarVC.delegate = self
    }
    func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
    
}
class ItemSimKHByShopV2TableViewCell: UITableViewCell {
    var sothuebao: UILabel!
    
    var sompos: UILabel!
    var tenkhachhang: UILabel!
    var tongtien:UILabel!
    var Esim:UILabel!
    var seriSim:UILabel!
    var ngaykichhoat:UILabel!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        sothuebao = UILabel()
        sothuebao.textColor = UIColor.black
        sothuebao.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        sothuebao.numberOfLines = 1
        contentView.addSubview(sothuebao)
        
        seriSim = UILabel()
        seriSim.textColor = UIColor.black
        seriSim.numberOfLines = 1
        seriSim.font = seriSim.font.withSize(13)
        contentView.addSubview(seriSim)
        
        ngaykichhoat = UILabel()
        ngaykichhoat.textColor = UIColor.black
        ngaykichhoat.numberOfLines = 1
        ngaykichhoat.font = seriSim.font.withSize(13)
        contentView.addSubview(ngaykichhoat)
        
        Esim = UILabel()
        Esim.textColor = UIColor.black
        Esim.numberOfLines = 1
        Esim.font = Esim.font.withSize(13)
        contentView.addSubview(Esim)
        
        sompos = UILabel()
        sompos.textColor = UIColor.black
        sompos.numberOfLines = 1
        sompos.font = sompos.font.withSize(13)
        contentView.addSubview(sompos)
        
        tenkhachhang = UILabel()
        tenkhachhang.textColor = UIColor.black
        tenkhachhang.numberOfLines = 1
        tenkhachhang.font = tenkhachhang.font.withSize(13)
        contentView.addSubview(tenkhachhang)
        
        tongtien = UILabel()
        tongtien.textColor = UIColor.red
        tongtien.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        tongtien.numberOfLines = 1
        contentView.addSubview(tongtien)
        
        
    }
    var so1:LichSuKichHoatV2?
    func setup(so:LichSuKichHoatV2){
        so1 = so
        
        sothuebao.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
        sothuebao.text = "Số thuê bao:    \(so.Phonenumber)"
        
        seriSim.frame = CGRect(x: Common.Size(s:10),y: sothuebao.frame.origin.y + sothuebao.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
        seriSim.text = "Số Serial/ESIM:    \(so.SeriSIM)"
        
        ngaykichhoat.frame = CGRect(x: Common.Size(s:10),y: seriSim.frame.origin.y + seriSim.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
        ngaykichhoat.text = "Ngày Kích Hoạt:    \(so.NgayKichHoat)"
        
        Esim.frame = CGRect(x: Common.Size(s:10),y: ngaykichhoat.frame.origin.y + ngaykichhoat.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
        if(so.is_esim == 0){
            Esim.text = "Loại Sim:    Sim Thường"
        }else{
            Esim.text = "Loại Sim:    ESIM"
        }
      
        
        sompos.frame = CGRect(x: Common.Size(s:10),y: Esim.frame.origin.y + Esim.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
        sompos.text = "Số mpos:    \(so.SOMPOS)"
        
        tenkhachhang.frame = CGRect(x: Common.Size(s:10),y: sompos.frame.origin.y + sompos.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
        tenkhachhang.text = "Tên KH:    \(so.FullName)"
        
        tongtien.frame = CGRect(x: Common.Size(s:10),y: tenkhachhang.frame.origin.y + tenkhachhang.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
        let tongTien = Common.convertCurrencyV2(value: so.TongTien)
        tongtien.text = "Tổng tiền:    \(tongTien) VNĐ"
        
        
    }
    
    
}
extension LichSuKichHoatV2ViewController: CalendarViewController1Delegate {
    func getDate1(dateString: String) {

        self.tfChonGioTu.text = dateString
    }
}

extension LichSuKichHoatV2ViewController: CalendarViewController2Delegate {
    func getDate2(dateString: String) {
     
        self.tfChonGioDen.text = dateString
    }
}

