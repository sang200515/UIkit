//
//  CheckInViewController.swift
//  CheckIn
//
//  Created by Apple on 1/18/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Presentr
import PopupDialog

class CheckInViewController: UIViewController {
    
    let lightTextCorlor = UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1)
    var pgInfo: PGInfo?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Check in"
       
        
        let backView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:30), height: Common.Size(s:50))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: backView)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        backView.addSubview(btBackIcon)
        self.view.backgroundColor = UIColor.white
        //

        
        
//        let viewUpdate = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
//        btnUpdatePg = UIButton.init(type: .custom)
//        btnUpdatePg.setImage(#imageLiteral(resourceName: "update-1"), for: UIControl.State.normal)
//        btnUpdatePg.imageView?.contentMode = .scaleAspectFit
//        btnUpdatePg.addTarget(self, action: #selector(updatePGInfo), for: .touchUpInside)
//        btnUpdatePg.frame = CGRect(x: 0, y: 0, width: Common.Size(s: 20), height: Common.Size(s: 40))
//        btnUpdatePg.center = viewUpdate.center
//        viewUpdate.addSubview(btnUpdatePg)
        //---
        
        let viewRightNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        let btnHistory = UIButton.init(type: .custom)
        btnHistory.setImage(#imageLiteral(resourceName: "LSCC"), for: UIControl.State.normal)
        btnHistory.imageView?.contentMode = .scaleAspectFit
        btnHistory.addTarget(self, action: #selector(showListHistory), for: .touchUpInside)
        btnHistory.frame = CGRect(x: 0, y: 0, width: Common.Size(s: 20), height: Common.Size(s: 40))
        btnHistory.center = viewRightNav.center
        viewRightNav.addSubview(btnHistory)
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: viewRightNav)]
        
        setUpView(pgInfo: pgInfo!)
//        NotificationCenter.default.addObserver(self, selector: #selector(setChamCongBtn), name: Notification.Name("check-in-success"), object: nil)
    }
    
//    @objc func setChamCongBtn() {
//        lblStatus.text = "Đã check in"
//        lblStatus.textColor = UIColor.red
//        btnChamCong.isHidden = true
//        btnUpdateDayOff.frame =  CGRect(x: (self.view.frame.width/2) - (btnUpdateDayOff.frame.width / 2), y: btnUpdateDayOff.frame.origin.y, width: btnUpdateDayOff.frame.width, height: Common.Size(s:40))
//    }
    

    @objc func updatePGInfo() {
        
        let newViewControler = UpdatePGInfoViewController()
        newViewControler.pgInfo = self.pgInfo
        self.navigationController?.pushViewController(newViewControler, animated: true)
    }

    func setUpView(pgInfo: PGInfo) {
        //top view
        let topview = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Common.Size(s:30)))
        topview.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        self.view.addSubview(topview)
        
        let lblEmpInfo = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: topview.frame.width - Common.Size(s:50), height: topview.frame.height))
        lblEmpInfo.text = "THÔNG TIN NHÂN VIÊN"
        lblEmpInfo.font = UIFont.systemFont(ofSize: 14)
        topview.addSubview(lblEmpInfo)
        
        let lblLoaiPG = UILabel(frame: CGRect(x: Common.Size(s:15), y: topview.frame.origin.y + topview.frame.height + Common.Size(s:15), width: self.view.frame.width/3 + Common.Size(s: 10), height: Common.Size(s:20)))
        lblLoaiPG.text = "Loại PG:"
        lblLoaiPG.font = UIFont.systemFont(ofSize: 14)
        lblLoaiPG.textColor = lightTextCorlor
        self.view.addSubview(lblLoaiPG)
        
        let lblLoaiPGText = UILabel(frame: CGRect(x: lblLoaiPG.frame.origin.x + lblLoaiPG.frame.width, y: lblLoaiPG.frame.origin.y, width: self.view.frame.width - lblLoaiPG.frame.width - Common.Size(s:15), height: Common.Size(s:20)))
        lblLoaiPGText.text = "\(pgInfo.loaiPG)"
        lblLoaiPGText.font = UIFont.systemFont(ofSize: 14)
        lblLoaiPGText.textColor = UIColor.black
        self.view.addSubview(lblLoaiPGText)
        
        let lblLoaiPGTextHeight:CGFloat = lblLoaiPGText.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : (lblLoaiPGText.optimalHeight + Common.Size(s:5))
        lblLoaiPGText.frame = CGRect(x: lblLoaiPGText.frame.origin.x, y: lblLoaiPGText.frame.origin.y, width: lblLoaiPGText.frame.width, height: lblLoaiPGTextHeight)
        lblLoaiPGText.numberOfLines = 0
        
        
        let lblDoitac = UILabel(frame: CGRect(x: Common.Size(s:15), y: lblLoaiPGText.frame.origin.y + lblLoaiPGTextHeight, width: self.view.frame.width/3 + Common.Size(s: 10), height: Common.Size(s:20)))
        lblDoitac.text = "Đối tác:"
        lblDoitac.font = UIFont.systemFont(ofSize: 14)
        lblDoitac.textColor = lightTextCorlor
        self.view.addSubview(lblDoitac)
        
        let lblParnerName = UILabel(frame: CGRect(x: lblDoitac.frame.origin.x + lblDoitac.frame.width, y: lblDoitac.frame.origin.y, width: self.view.frame.width - lblDoitac.frame.width - Common.Size(s:15), height: Common.Size(s:20)))
        lblParnerName.text = "\(pgInfo.doiTac)"
        lblParnerName.font = UIFont.systemFont(ofSize: 14)
        lblParnerName.textColor = UIColor.black
        self.view.addSubview(lblParnerName)
        
        let lblParnerNameHeight:CGFloat = lblParnerName.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : (lblParnerName.optimalHeight + Common.Size(s:5))
        lblParnerName.frame = CGRect(x: lblParnerName.frame.origin.x, y: lblParnerName.frame.origin.y, width: lblParnerName.frame.width, height: lblParnerNameHeight)
        lblParnerName.numberOfLines = 0
        
        
        let lblChucDanh = UILabel(frame: CGRect(x: Common.Size(s:15), y: lblParnerName.frame.origin.y + lblParnerNameHeight, width: lblDoitac.frame.width, height: Common.Size(s:20)))
        lblChucDanh.text = "Chức danh:"
        lblChucDanh.font = UIFont.systemFont(ofSize: 14)
        lblChucDanh.textColor = lightTextCorlor
        self.view.addSubview(lblChucDanh)
        
        let lblPGPosition = UILabel(frame: CGRect(x: lblParnerName.frame.origin.x , y: lblChucDanh.frame.origin.y, width: lblParnerName.frame.width, height: Common.Size(s:20)))
        lblPGPosition.text = "\(pgInfo.chucDanh)"
        lblPGPosition.font = UIFont.systemFont(ofSize: 14)
        lblPGPosition.textColor = UIColor.black
        self.view.addSubview(lblPGPosition)
        
        let lblPGPositionHeight:CGFloat = lblPGPosition.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : (lblPGPosition.optimalHeight + Common.Size(s:5))
        lblPGPosition.frame = CGRect(x: lblPGPosition.frame.origin.x, y: lblPGPosition.frame.origin.y, width: lblPGPosition.frame.width, height: lblPGPositionHeight)
        lblPGPosition.numberOfLines = 0
        
        let lblQLPG = UILabel(frame: CGRect(x: Common.Size(s:15), y: lblPGPosition.frame.origin.y + lblPGPositionHeight, width: lblDoitac.frame.width, height: Common.Size(s:20)))
        lblQLPG.text = "Họ tên quản lý PG:"
        lblQLPG.font = UIFont.systemFont(ofSize: 14)
        lblQLPG.textColor = lightTextCorlor
        self.view.addSubview(lblQLPG)
        
        let lblQLPGText = UILabel(frame: CGRect(x: lblParnerName.frame.origin.x, y: lblQLPG.frame.origin.y, width: lblParnerName.frame.width, height: Common.Size(s:20)))
        lblQLPGText.text = "\(pgInfo.tenQL)"
        lblQLPGText.font = UIFont.systemFont(ofSize: 14)
        lblQLPGText.textColor = UIColor.black
        self.view.addSubview(lblQLPGText)
        
        let lblQLPGTextHeight:CGFloat = lblQLPGText.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : (lblQLPGText.optimalHeight + Common.Size(s: 5))
        lblQLPGText.frame = CGRect(x: lblQLPGText.frame.origin.x, y: lblQLPGText.frame.origin.y, width: lblQLPGText.frame.width, height: lblQLPGTextHeight)
        lblQLPGText.numberOfLines = 0
        
        if (pgInfo.loaiPG.lowercased().contains(find: "trả góp")) {
            lblQLPG.isHidden = false
            lblQLPGText.isHidden = false
            
            lblQLPG.frame = CGRect(x: lblQLPG.frame.origin.x, y: lblQLPG.frame.origin.y, width: lblQLPG.frame.width, height: Common.Size(s:20))
            lblQLPGText.frame = CGRect(x: lblQLPGText.frame.origin.x, y: lblQLPGText.frame.origin.y, width: lblQLPGText.frame.width, height: lblQLPGTextHeight)
        } else {
            lblQLPG.isHidden = true
            lblQLPGText.isHidden = true
            
            lblQLPG.frame = CGRect(x: lblQLPG.frame.origin.x, y: lblQLPG.frame.origin.y, width: lblQLPG.frame.width, height: 0)
            lblQLPGText.frame = CGRect(x: lblQLPGText.frame.origin.x, y: lblQLPGText.frame.origin.y, width: lblQLPGText.frame.width, height: 0)
        }
        
        //ma pg
        let lblMaPG = UILabel(frame: CGRect(x: Common.Size(s:15), y: lblQLPGText.frame.origin.y + lblQLPGText.frame.height, width: lblDoitac.frame.width, height: Common.Size(s:20)))
        lblMaPG.text = "Mã PG:"
        lblMaPG.font = UIFont.systemFont(ofSize: 14)
        lblMaPG.textColor = lightTextCorlor
        self.view.addSubview(lblMaPG)
        
        let lblPGCode = UILabel(frame: CGRect(x: lblParnerName.frame.origin.x, y: lblMaPG.frame.origin.y, width: lblParnerName.frame.width, height: Common.Size(s:20)))
        lblPGCode.text = "\(pgInfo.pgCode)"
        lblPGCode.font = UIFont.systemFont(ofSize: 14)
        lblPGCode.textColor = UIColor.black
        self.view.addSubview(lblPGCode)
        
        let lblPGCodeHeight:CGFloat = lblPGCode.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : (lblPGCode.optimalHeight + Common.Size(s:5))
        lblPGCode.frame = CGRect(x: lblPGCode.frame.origin.x, y: lblPGCode.frame.origin.y, width: lblPGCode.frame.width, height: lblPGCodeHeight)
        lblPGCode.numberOfLines = 0
        
        let lblName = UILabel(frame: CGRect(x: Common.Size(s:15), y: lblPGCode.frame.origin.y + lblPGCodeHeight, width: lblDoitac.frame.width, height: Common.Size(s:20)))
        lblName.text = "Họ tên:"
        lblName.font = UIFont.systemFont(ofSize: 14)
        lblName.textColor = lightTextCorlor
        self.view.addSubview(lblName)
        
        let lblFullName = UILabel(frame: CGRect(x: lblName.frame.origin.x + lblName.frame.width, y: lblName.frame.origin.y, width: self.view.frame.width - lblName.frame.width - Common.Size(s:15), height: Common.Size(s:20)))
        lblFullName.text = "\(pgInfo.fullName)"
        lblFullName.font = UIFont.systemFont(ofSize: 14)
        lblFullName.textColor = UIColor.black
        self.view.addSubview(lblFullName)
        
        let lblFullNameHeight:CGFloat = lblFullName.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : (lblFullName.optimalHeight + Common.Size(s:5))
        lblFullName.frame = CGRect(x: lblFullName.frame.origin.x, y: lblFullName.frame.origin.y, width: lblFullName.frame.width, height: lblFullNameHeight)
        lblFullName.numberOfLines = 0
        
        //
        let lblCmnd = UILabel(frame: CGRect(x: Common.Size(s:15), y: lblFullName.frame.origin.y + lblFullNameHeight, width: lblDoitac.frame.width, height: Common.Size(s:20)))
        lblCmnd.text = "CMND:"
        lblCmnd.font = UIFont.systemFont(ofSize: 14)
        lblCmnd.textColor = lightTextCorlor
        self.view.addSubview(lblCmnd)
        
        let lblCmndNumber = UILabel(frame: CGRect(x: lblCmnd.frame.origin.x + lblCmnd.frame.width, y: lblCmnd.frame.origin.y, width: self.view.frame.width - lblCmnd.frame.width - Common.Size(s:15), height: Common.Size(s:20)))
        lblCmndNumber.text = "\(pgInfo.personalID)"
        lblCmndNumber.font = UIFont.systemFont(ofSize: 14)
        lblCmndNumber.textColor = UIColor.black
        self.view.addSubview(lblCmndNumber)
        
        let lblGioiTinh = UILabel(frame: CGRect(x: Common.Size(s:15), y: lblCmndNumber.frame.origin.y + lblCmndNumber.frame.height, width: lblDoitac.frame.width, height: Common.Size(s:20)))
        lblGioiTinh.text = "Giới tính:"
        lblGioiTinh.font = UIFont.systemFont(ofSize: 14)
        lblGioiTinh.textColor = lightTextCorlor
        self.view.addSubview(lblGioiTinh)
        
        let lblGioiTinhText = UILabel(frame: CGRect(x: lblGioiTinh.frame.origin.x + lblGioiTinh.frame.width, y: lblGioiTinh.frame.origin.y, width: self.view.frame.width - lblGioiTinh.frame.width - Common.Size(s:15), height: Common.Size(s:20)))
        lblGioiTinhText.text = "\(pgInfo.gioiTinh)"
        lblGioiTinhText.font = UIFont.systemFont(ofSize: 14)
        lblGioiTinhText.textColor = UIColor.black
        self.view.addSubview(lblGioiTinhText)
        
        //
        let lblSdt = UILabel(frame: CGRect(x: Common.Size(s:15), y: lblGioiTinhText.frame.origin.y + lblGioiTinhText.frame.height, width: lblDoitac.frame.width, height: Common.Size(s:20)))
        lblSdt.text = "Số điện thoại:"
        lblSdt.font = UIFont.systemFont(ofSize: 14)
        lblSdt.textColor = lightTextCorlor
        self.view.addSubview(lblSdt)
        
        let lblPhoneNumber = UILabel(frame: CGRect(x: lblSdt.frame.origin.x + lblSdt.frame.width, y: lblSdt.frame.origin.y, width: self.view.frame.width - lblSdt.frame.width - Common.Size(s:15), height: Common.Size(s:20)))
        lblPhoneNumber.text = "\(pgInfo.soDT)"
        lblPhoneNumber.font = UIFont.systemFont(ofSize: 14)
        lblPhoneNumber.textColor = UIColor.black
        self.view.addSubview(lblPhoneNumber)
        
        let lblEmail = UILabel(frame: CGRect(x: Common.Size(s:15), y: lblPhoneNumber.frame.origin.y + lblPhoneNumber.frame.height, width: lblDoitac.frame.width, height: Common.Size(s:20)))
        lblEmail.text = "Email:"
        lblEmail.font = UIFont.systemFont(ofSize: 14)
        lblEmail.textColor = lightTextCorlor
        self.view.addSubview(lblEmail)
        
        let lblEmailValue = UILabel(frame: CGRect(x: lblEmail.frame.origin.x + lblEmail.frame.width, y: lblEmail.frame.origin.y, width: self.view.frame.width - lblEmail.frame.width - Common.Size(s:15), height: Common.Size(s:20)))
        lblEmailValue.text = "\(pgInfo.email)"
        lblEmailValue.font = UIFont.systemFont(ofSize: 14)
        lblEmailValue.textColor = UIColor.black
        self.view.addSubview(lblEmailValue)
        
        let lblEmailValueHeight:CGFloat = lblEmailValue.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : (lblEmailValue.optimalHeight + Common.Size(s:5))
        lblEmailValue.frame = CGRect(x: lblEmailValue.frame.origin.x, y: lblEmailValue.frame.origin.y, width: lblEmailValue.frame.width, height: lblEmailValueHeight)
        lblEmailValue.numberOfLines = 0
        
        let lblNamSinh = UILabel(frame: CGRect(x: Common.Size(s:15), y: lblEmailValue.frame.origin.y + lblEmailValueHeight, width: lblDoitac.frame.width, height: Common.Size(s:20)))
        lblNamSinh.text = "Năm sinh:"
        lblNamSinh.font = UIFont.systemFont(ofSize: 14)
        lblNamSinh.textColor = lightTextCorlor
        self.view.addSubview(lblNamSinh)
        
        let lblBirthYear = UILabel(frame: CGRect(x: lblNamSinh.frame.origin.x + lblNamSinh.frame.width, y: lblNamSinh.frame.origin.y, width: self.view.frame.width - lblNamSinh.frame.width - Common.Size(s:15), height: Common.Size(s:20)))
        lblBirthYear.text = "\(pgInfo.ngaysinh)"
        lblBirthYear.font = UIFont.systemFont(ofSize: 14)
        lblBirthYear.textColor = UIColor.black
        self.view.addSubview(lblBirthYear)
        
        if !(pgInfo.ngaysinh.isEmpty) {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            let date2 = formatter.date(from: pgInfo.ngaysinh)
            
            let newFormatter = DateFormatter()
            newFormatter.locale = Locale(identifier: "vi_VN");
            newFormatter.timeZone = TimeZone(identifier: "UTC");
            newFormatter.dateFormat = "yyyy"
            let str = newFormatter.string(from: date2 ?? Date())
            lblBirthYear.text = str
        } else {
            lblBirthYear.text = pgInfo.ngaysinh
        }
        
        let lblShop = UILabel(frame: CGRect(x: Common.Size(s:15), y: lblBirthYear.frame.origin.y + lblBirthYear.frame.height, width: lblDoitac.frame.width, height: Common.Size(s:20)))
        lblShop.text = "Shop:"
        lblShop.font = UIFont.systemFont(ofSize: 14)
        lblShop.textColor = lightTextCorlor
        self.view.addSubview(lblShop)
        
        let lblShopText = UILabel(frame: CGRect(x: lblShop.frame.origin.x + lblShop.frame.width, y: lblShop.frame.origin.y, width: self.view.frame.width - lblShop.frame.width - Common.Size(s:15), height: Common.Size(s:20)))
        lblShopText.text = "\(pgInfo.shop)"
        lblShopText.font = UIFont.systemFont(ofSize: 14)
        lblShopText.textColor = UIColor.black
        self.view.addSubview(lblShopText)
        
        let lblShopTextHeight:CGFloat = lblShopText.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : (lblShopText.optimalHeight + Common.Size(s:5))
        lblShopText.numberOfLines = 0
        lblShopText.frame = CGRect(x: lblShopText.frame.origin.x, y: lblShopText.frame.origin.y, width: lblShopText.frame.width, height: lblShopTextHeight)
        
        if (pgInfo.loaiPG.lowercased().contains(find: "trả góp")) {
            lblShop.isHidden = true
            lblShopText.isHidden = true
            lblShop.frame = CGRect(x: lblShop.frame.origin.x, y: lblShop.frame.origin.y, width: lblShop.frame.width, height: 0)
            lblShopText.frame = CGRect(x: lblShopText.frame.origin.x, y: lblShopText.frame.origin.y, width: lblShopText.frame.width, height: 0)
        } else {
            lblShop.isHidden = false
            lblShopText.isHidden = false
            lblShop.frame = CGRect(x: lblShop.frame.origin.x, y: lblShop.frame.origin.y, width: lblShop.frame.width, height: Common.Size(s:20))
            lblShopText.frame = CGRect(x: lblShopText.frame.origin.x, y: lblShopText.frame.origin.y, width: lblShopText.frame.width, height: lblShopTextHeight)
        }
        
        let lblTrangThai = UILabel(frame: CGRect(x: Common.Size(s:15), y: lblShopText.frame.origin.y + lblShopText.frame.height, width: lblDoitac.frame.width, height: Common.Size(s:20)))
        lblTrangThai.text = "Trạng thái:"
        lblTrangThai.font = UIFont.systemFont(ofSize: 14)
        lblTrangThai.textColor = lightTextCorlor
        self.view.addSubview(lblTrangThai)
        
        let lblStatus = UILabel(frame: CGRect(x: lblTrangThai.frame.origin.x + lblTrangThai.frame.width, y: lblTrangThai.frame.origin.y, width: self.view.frame.width - lblTrangThai.frame.width - Common.Size(s:15), height: Common.Size(s:20)))
        lblStatus.text = "\(pgInfo.trangThai)"
        lblStatus.font = UIFont.boldSystemFont(ofSize: 14)
        lblStatus.textColor = UIColor.black
        self.view.addSubview(lblStatus)
        
        let lblStatusHeight:CGFloat = lblStatus.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : (lblStatus.optimalHeight + Common.Size(s:5))
        lblStatus.frame = CGRect(x: lblStatus.frame.origin.x, y: lblStatus.frame.origin.y, width: lblStatus.frame.width, height: lblStatusHeight)
        lblStatus.numberOfLines = 0
        
        if pgInfo.trangThai == "Chưa check in" {
            lblStatus.textColor = UIColor.red
        } else {
            lblStatus.textColor = UIColor(red: 44/255, green: 171/255, blue: 110/255, alpha: 1)
        }

//        //
//        btnChamCong = UIButton(frame: CGRect(x: btnUpdateDayOff.frame.width + Common.Size(s:30), y: btnUpdateDayOff.frame.origin.y , width: btnUpdateDayOff.frame.width, height: btnUpdateDayOff.frame.height))
//        btnChamCong.backgroundColor = UIColor(red: 14/255, green: 74/255, blue: 152/255, alpha: 1)
//        btnChamCong.setTitle("CHECK IN", for: .normal)
//        btnChamCong.layer.cornerRadius = 8
//        btnChamCong.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//        self.view.addSubview(btnChamCong)
//        btnChamCong.addTarget(self, action: #selector(chamCong), for: .touchUpInside)
        
        
        let btnGenPassword = UIButton(frame: CGRect(x: Common.Size(s: 15), y: lblStatus.frame.origin.y + lblStatusHeight + Common.Size(s:20), width: (self.view.frame.width - Common.Size(s: 30))/2 - Common.Size(s: 5), height: Common.Size(s:40)))
        btnGenPassword.backgroundColor = UIColor(red: 44/255, green: 171/255, blue: 110/255, alpha: 1)
        btnGenPassword.setTitle("Lấy mật khẩu", for: .normal)
        btnGenPassword.layer.cornerRadius = 8
        btnGenPassword.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        self.view.addSubview(btnGenPassword)
        btnGenPassword.addTarget(self, action: #selector(getNewPassword), for: .touchUpInside)
        
        let btnUpdateDayOff = UIButton(frame: CGRect(x: btnGenPassword.frame.origin.x + btnGenPassword.frame.width + Common.Size(s:5), y: btnGenPassword.frame.origin.y, width: btnGenPassword.frame.width, height: Common.Size(s:40)))
        btnUpdateDayOff.backgroundColor = UIColor(red: 39/255, green: 100/255, blue: 171/255, alpha: 1)
        btnUpdateDayOff.setTitle("Cập nhật nghỉ việc", for: .normal)
        btnUpdateDayOff.layer.cornerRadius = 8
        btnUpdateDayOff.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.view.addSubview(btnUpdateDayOff)
        btnUpdateDayOff.addTarget(self, action: #selector(updatePGOff), for: .touchUpInside)
    }
    
    @objc func getNewPassword() {
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang lấy mật khẩu mới...") {
            CRMAPIManager.PG_sendpasswordpg(personalid: self.pgInfo?.personalID ?? "") { (pass, msg, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        let alert = UIAlertController(title: "Thông báo", message: "\(msg)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)\nLấy mật khẩu thất bại, bạn vui lòng thao tác lại hoặc liên hệ SUPPORT để được hỗ trợ.", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @objc func actionBack() {
        for controller in self.navigationController?.viewControllers ?? [] {
            if controller is CMNDViewController {
                self.navigationController?.popToViewController(controller, animated: true)
            }
        }
    }
    
    @objc func showListHistory() {
        let historyVC = HistoryCheckInViewController()
        historyVC.isPGDetail = true
        historyVC.pgInfo = self.pgInfo ?? PGInfo(loaiPG: "", doiTac: "", chucDanh: "", pgCode: "", fullName: "", tenQL: "", personalID: "", gioiTinh: "", soDT: "", email: "", ngaysinh: "", shop: "", trangThai: "")
        self.navigationController?.pushViewController(historyVC, animated: true)
    }
    
    @objc func updatePGOff() {
        let alert = UIAlertController(title: "Thông báo", message: "Bạn chắc chắn cập nhật nghỉ việc cho PG này không?", preferredStyle: .alert)
        
        let actionCancel = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
        let action = UIAlertAction(title: "Cập nhật", style: .default) { (_) in
            WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang cập nhật...") {
                CRMAPIManager.PG_pgoffnhanvien(personalid: "\(self.pgInfo?.personalID ?? "")") { (status, msg, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if err.count <= 0 {
                            if status == "true" {
                                let alert = UIAlertController(title: "Thông báo", message: "\(msg ?? "Cập nhật nghỉ việc thành công!")", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                    self.navigationController?.popViewController(animated: true)
                                }
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            } else {
                                let alert = UIAlertController(title: "Thông báo", message: "\(msg ?? "Cập nhật nghỉ việc thất bại!")", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
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
        alert.addAction(actionCancel)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
//    @objc func showUpdateDayOffPopUp() {
//        let popup = PopupDialog(title: "Thông báo", message: "Bạn chắc chắn cập nhật nghỉ việc cho PG này không ?", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
//            print("Completed")
//        }
//        let buttonOne = CancelButton(title: "Huỷ", action: nil)
//
//        let buttonTwo = DefaultButton(title: "Cập nhật") {
//            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
//                MPOSAPIManager.updateOffEmployee(userCode: self.pgInfo?.pgCode ?? "", updateBy: "\(Cache.user?.UserName ?? "")" ) { (simpleResponse, error) in
//                    WaitingNetworkResponseAlert.DismissWaitingAlert {
//                        if simpleResponse?.Code == "001" {
//                            if simpleResponse != nil {
//
//                                let alertVC = UIAlertController(title: "Thông báo", message: "Cập nhật thành công!", preferredStyle: .alert)
//                                let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
//                                    self.actionBack()
//                                }
//                                alertVC.addAction(action)
//                                self.present(alertVC, animated: true, completion: nil)
//                            } else {
//                                self.showAlert(title: "Thông báo", message: "Cập nhật thất bại!")
//                            }
//                        } else {
//                            let ms = simpleResponse?.Detail
//                            self.showAlert(title: "Thông báo", message: "\(ms ?? "Cập nhật thất bại!")")
//                        }
//                    }
//
//                }
//            }
//
//        }
//        popup.addButtons([buttonOne, buttonTwo])
//        self.present(popup, animated: true, completion: nil)
//    }
    
    
    
//    @objc func chamCong() {
//        self.confirmPassword(userCodePG: pgInfo!.pgCode)
//    }
//
//    func showInputDialog(title:String? = nil,
//                         subtitle:String? = nil,
//                         actionTitle:String? = "Add",
//                         inputPlaceholder:String? = nil,
//                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
//                         actionHandler: ((_ text: String?) -> Void)? = nil) {
//
//        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
//        alert.addTextField { (textField:UITextField) in
//            textField.placeholder = inputPlaceholder
//            textField.keyboardType = inputKeyboardType
//            textField.isSecureTextEntry = true
//        }
//        alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
//            guard let textField =  alert.textFields?.first else {
//                actionHandler?(nil)
//                return
//            }
//            actionHandler?(textField.text)
//        }))
//
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    func confirmPassword(userCodePG: String){
//        self.showInputDialog(title: "NHẬP MẬT KHẨU", subtitle: "", actionTitle: "Xác nhận", inputPlaceholder: "mật khẩu", inputKeyboardType: .default) { (password) in
//            guard let pw = password, !pw.isEmpty else {
//                let alertVC = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập mật khẩu", preferredStyle: .alert)
//                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                alertVC.addAction(action)
//                self.present(alertVC, animated: true, completion: nil)
//                return
//            }
//            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
//                MPOSAPIManager.checkIn(smCreate: "\(Cache.user!.UserName)", userCodePG: userCodePG , password: pw) { (simpleResponse, error) in
//
//                    let message = simpleResponse?.mdata
//                    WaitingNetworkResponseAlert.DismissWaitingAlert {
//                        if simpleResponse?.Code == "001" {
//                            if simpleResponse != nil {
//                                NotificationCenter.default.post(name: Notification.Name("check-in-success"), object: nil)
//                                self.showAlert(title: "Check in thành công!", message: "")
//                            }
//
//                        } else if simpleResponse?.Code == "002" {
//                            let alertVC = UIAlertController(title: "Thông báo", message: "\(message ?? "Sai mật khẩu!")", preferredStyle: .alert)
//                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                            alertVC.addAction(action)
//                            self.present(alertVC, animated: true, completion: nil)
//                        } else if simpleResponse?.Code == "003" {
//                            self.showAlert(title: "Thông báo", message: "\(message ?? "Nhân viên đã Check In rồi!")")
//                        } else if simpleResponse?.Code == "004" {
//                            self.showAlert(title: "Thông báo", message: "Check in thất bại!")
//                        }
//                    }
//
//                }
//            }
//
//        }
//    }
//
//    func showAlert(title: String, message: String) {
//        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
//            self.dismiss(animated: true, completion: nil)
//        }
//        //        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//        alertVC.addAction(action)
//        self.present(alertVC, animated: true, completion: nil)
//    }
    
}
