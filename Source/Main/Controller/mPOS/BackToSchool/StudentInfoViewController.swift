//
//  StudentInfoViewController.swift
//  fptshop
//
//  Created by Apple on 6/26/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class StudentInfoViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var lbStudentName: UILabel!
    var lbCMNDText: UILabel!
    var lbPhoneText: UILabel!
    var lbBirthDay: UILabel!
    var lbStatusText: UILabel!
    var btnUpload: UIButton!
    var btnUpDateInfo: UIButton!
    
    var lbDiscountValue: UILabel!
    var lbSBDValue: UILabel!
    var studentInfoItem:StudentBTSInfo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Back To School"
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadStudentInfo()
    }
    
    
    func setUpView(item: StudentBTSInfo) {
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        //studentInfoView
        let studentInfoView = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: Common.Size(s:40)))
        studentInfoView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        scrollView.addSubview(studentInfoView)
        
        let lbStudentInfo = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: studentInfoView.frame.width - Common.Size(s:30), height: studentInfoView.frame.height))
        lbStudentInfo.text = "THÔNG TIN THÍ SINH"
        studentInfoView.addSubview(lbStudentInfo)
        
        let lbName = UILabel(frame: CGRect(x: Common.Size(s:15), y: studentInfoView.frame.origin.y + studentInfoView.frame.height + Common.Size(s:10), width: scrollView.frame.width/3 - Common.Size(s:15), height: Common.Size(s:20)))
        lbName.text = "Họ tên:"
        lbName.textColor = UIColor.darkGray
        lbName.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbName)
        
        lbStudentName = UILabel(frame: CGRect(x: lbName.frame.origin.x + lbName.frame.width + Common.Size(s: 5), y: lbName.frame.origin.y, width: scrollView.frame.width - (lbName.frame.width + Common.Size(s: 5)) - Common.Size(s:15), height: Common.Size(s:20)))
        lbStudentName.text = "\(item.HoTen )"
        lbStudentName.textColor = UIColor.black
        lbStudentName.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbStudentName)
        
        self.lbStudentName.numberOfLines = 0
        let lbStudentNameHeight = lbStudentName.optimalHeight < Common.Size(s: 15) ? Common.Size(s: 15) : lbStudentName.optimalHeight
        
        let lbCMND = UILabel(frame: CGRect(x: lbName.frame.origin.x, y: lbName.frame.origin.y + lbStudentNameHeight + Common.Size(s:5), width: lbName.frame.width, height: Common.Size(s:20)))
        lbCMND.text = "CMND:"
        lbCMND.textColor = UIColor.darkGray
        lbCMND.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbCMND)
        
        lbCMNDText = UILabel(frame: CGRect(x: lbStudentName.frame.origin.x, y: lbCMND.frame.origin.y, width: lbStudentName.frame.width, height: Common.Size(s:20)))
        lbCMNDText.text = "\(item.CMND)"
        lbCMNDText.textColor = UIColor.black
        lbCMNDText.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbCMNDText)
        
        let lbSDT = UILabel(frame: CGRect(x: lbName.frame.origin.x, y: lbCMNDText.frame.origin.y + lbCMNDText.frame.height + Common.Size(s:5), width: lbName.frame.width, height: Common.Size(s:20)))
        lbSDT.text = "SĐT:"
        lbSDT.textColor = UIColor.darkGray
        lbSDT.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbSDT)
        
        lbPhoneText = UILabel(frame: CGRect(x: lbStudentName.frame.origin.x, y: lbSDT.frame.origin.y, width: lbStudentName.frame.width, height: Common.Size(s:20)))
        lbPhoneText.text = "\(item.SDT)"
        lbPhoneText.textColor = UIColor.black
        lbPhoneText.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbPhoneText)
        
        let lbNgaySinh = UILabel(frame: CGRect(x: lbName.frame.origin.x, y: lbPhoneText.frame.origin.y + lbPhoneText.frame.height + Common.Size(s:5), width: lbName.frame.width, height: Common.Size(s:20)))
        lbNgaySinh.text = "Ngày sinh:"
        lbNgaySinh.textColor = UIColor.darkGray
        lbNgaySinh.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbNgaySinh)
        
        lbBirthDay = UILabel(frame: CGRect(x: lbStudentName.frame.origin.x, y: lbNgaySinh.frame.origin.y, width: lbStudentName.frame.width, height: Common.Size(s:20)))
        lbBirthDay.text = "\(item.NgaySinh)"
        lbBirthDay.textColor = UIColor.black
        lbBirthDay.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbBirthDay)
        
        //thong tin giam gia View
        let discountView = UIView(frame: CGRect(x: 0, y: lbBirthDay.frame.origin.y + lbBirthDay.frame.height + Common.Size(s: 15), width: scrollView.frame.width, height: Common.Size(s:40)))
        discountView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        scrollView.addSubview(discountView)
        
        let lbDiscountInfo = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: discountView.frame.width - Common.Size(s:30), height: discountView.frame.height))
        lbDiscountInfo.text = "THÔNG TIN GIẢM GIÁ"
        discountView.addSubview(lbDiscountInfo)
        
        let lbPTGiamGia = UILabel(frame: CGRect(x: lbName.frame.origin.x, y: discountView.frame.origin.y + discountView.frame.height + Common.Size(s:10), width: lbName.frame.width, height: Common.Size(s:20)))
        lbPTGiamGia.text = "% giảm giá:"
        lbPTGiamGia.textColor = UIColor.darkGray
        lbPTGiamGia.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbPTGiamGia)
        
        lbDiscountValue = UILabel(frame: CGRect(x: lbStudentName.frame.origin.x, y: lbPTGiamGia.frame.origin.y, width: lbStudentName.frame.width, height: Common.Size(s:20)))
        lbDiscountValue.text = "\(item.PhanTramGiamGia)%"
        lbDiscountValue.textColor = UIColor(red: 213/255, green: 47/255, blue: 50/255, alpha: 1)
        lbDiscountValue.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbDiscountValue)
        
        let lbTrangThai = UILabel(frame: CGRect(x: lbName.frame.origin.x, y: lbDiscountValue.frame.origin.y + lbDiscountValue.frame.height + Common.Size(s:10), width: lbName.frame.width, height: Common.Size(s:20)))
        lbTrangThai.text = "Trạng thái:"
        lbTrangThai.textColor = UIColor.darkGray
        lbTrangThai.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbTrangThai)
        
        lbStatusText = UILabel(frame: CGRect(x: lbStudentName.frame.origin.x, y: lbTrangThai.frame.origin.y, width: lbStudentName.frame.width, height: Common.Size(s:20)))
        lbStatusText.text = "\(item.TinhTrangVoucher)"
        lbStatusText.textColor = UIColor.black
        lbStatusText.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbStatusText)
        
        if item.TinhTrangVoucher == "Chưa cấp Voucher" {
            lbStatusText.textColor = UIColor(red: 158/255, green: 0/255, blue: 14/255, alpha: 1)
        } else if item.TinhTrangVoucher == "Đã cấp Voucher" {
            lbStatusText.textColor = UIColor(red: 20/255, green: 100/255, blue: 174/255, alpha: 1)
        } else if item.TinhTrangVoucher == "Đã sử dụng" {
            lbStatusText.textColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        } else {
            lbStatusText.textColor = UIColor(red: 158/255, green: 0/255, blue: 14/255, alpha: 1)
        }
        
        //thong tin diem thi View
        let pointInfoView = UIView(frame: CGRect(x: 0, y: lbStatusText.frame.origin.y + lbStatusText.frame.height + Common.Size(s: 15), width: scrollView.frame.width, height: Common.Size(s:40)))
        pointInfoView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        scrollView.addSubview(pointInfoView)
        
        let lbPointInfo = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: pointInfoView.frame.width - Common.Size(s:30), height: pointInfoView.frame.height))
        lbPointInfo.text = "THÔNG TIN ĐIỂM THI"
        pointInfoView.addSubview(lbPointInfo)
        
        let lbSBD = UILabel(frame: CGRect(x: lbName.frame.origin.x, y: pointInfoView.frame.origin.y + pointInfoView.frame.height + Common.Size(s:10), width: lbName.frame.width, height: Common.Size(s:20)))
        lbSBD.text = "Số báo danh: "
        lbSBD.textColor = UIColor.darkGray
        lbSBD.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbSBD)
        //
        lbSBDValue = UILabel(frame: CGRect(x: lbSBD.frame.origin.x + lbSBD.frame.width, y: lbSBD.frame.origin.y, width: lbStudentName.frame.width, height: Common.Size(s:20)))
        lbSBDValue.text = "\(item.SoBaoDanh)"
        lbSBDValue.textColor = UIColor.black
        lbSBDValue.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbSBDValue)
        //
        //
        //point view
        let pointView = UIView(frame: CGRect(x: 0, y: lbSBDValue.frame.origin.y + lbSBDValue.frame.height, width: scrollView.frame.width, height: Common.Size(s:40)))
        scrollView.addSubview(pointView)
        
        
        //
        var xPoint: CGFloat = 0
        var yPoint: CGFloat = 0
        if item.DiemTungMon.count > 0 {
            for i in 1...(self.studentInfoItem?.DiemTungMon.count ?? 0) {
                let item = self.studentInfoItem?.DiemTungMon[i - 1]
                
                if i % 2 != 0 {//trai
                    let n:Int = i/2
                    xPoint = Common.Size(s:15)
                    yPoint = Common.Size(s:20) * CGFloat(n + 1)
                    
                } else {
                    xPoint = pointView.frame.width/2 + Common.Size(s:7)
                    yPoint = Common.Size(s:20) * CGFloat(i/2)
                }
                
                let lbSubjectName = UILabel(frame: CGRect(x: xPoint, y: yPoint, width: pointView.frame.width/2 - Common.Size(s:15), height: Common.Size(s:20)))
                lbSubjectName.text = "\(item?.TenMH ?? ""):  \(item?.Diem ?? "")"
                lbSubjectName.textColor = UIColor.black
                lbSubjectName.font = UIFont.systemFont(ofSize: 14)
                pointView.addSubview(lbSubjectName)
            }
        }
        
        
        let pointViewHeight:CGFloat = ((CGFloat((item.DiemTungMon.count)/2) + 1) * Common.Size(s:30)) + Common.Size(s:30)
        
        pointView.frame = CGRect(x: pointView.frame.origin.x, y: pointView.frame.origin.y, width: pointView.frame.width, height: pointViewHeight)
        
        btnUpDateInfo = UIButton(frame: CGRect(x: Common.Size(s:15), y: pointView.frame.origin.y + pointView.frame.height, width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:40)))
        btnUpDateInfo.setTitle("UPDATE", for: .normal)
        btnUpDateInfo.backgroundColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        btnUpDateInfo.addTarget(self, action: #selector(update), for: .touchUpInside)
        btnUpDateInfo.layer.cornerRadius = 5
        scrollView.addSubview(btnUpDateInfo)
        
        btnUpload = UIButton(frame: CGRect(x: Common.Size(s:15), y: btnUpDateInfo.frame.origin.y + btnUpDateInfo.frame.height + Common.Size(s:10), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:40)))
        btnUpload.setTitle("UPLOAD", for: .normal)
        btnUpload.backgroundColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        btnUpload.addTarget(self, action: #selector(uploadInfo), for: .touchUpInside)
        btnUpload.layer.cornerRadius = 5
        scrollView.addSubview(btnUpload)
        
        if item.TinhTrangVoucher == "Chưa cấp Voucher" {
            btnUpDateInfo.isHidden = false
            
            btnUpload.frame = CGRect(x: btnUpload.frame.origin.x, y: btnUpDateInfo.frame.origin.y + btnUpDateInfo.frame.height + Common.Size(s:10), width: btnUpload.frame.width, height: btnUpload.frame.height)
            
            scrollViewHeight = btnUpload.frame.origin.y + btnUpload.frame.height + Common.Size(s: 100)
            scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
            
        } else {
            btnUpDateInfo.isHidden = true
            
            btnUpload.frame = CGRect(x: btnUpload.frame.origin.x, y: pointView.frame.origin.y + pointView.frame.height, width: btnUpload.frame.width, height: btnUpload.frame.height)
            
            scrollViewHeight = btnUpload.frame.origin.y + btnUpload.frame.height + Common.Size(s: 100)
            scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        }
        
        if item.Allow_UploadImg == 0 {
            btnUpload.isHidden = true
            scrollViewHeight = pointView.frame.origin.y + pointView.frame.height + Common.Size(s: 100)
            scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        } else {
            btnUpload.isHidden = false
            scrollViewHeight = btnUpload.frame.origin.y + btnUpload.frame.height + Common.Size(s: 100)
            scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        }
        
    }
    
    @objc func update() {
        let newViewController = CreateStudentInfoViewController()
        newViewController.studentInfoItem = self.studentInfoItem
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func uploadInfo() {
        let newViewController = UploadStudentImageViewController()
        newViewController.studentInfoItem = self.studentInfoItem
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func reloadStudentInfo() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.BackToSchool_LoadThongTinKHBySBD(SoBaoDanh: self.studentInfoItem?.ID_BackToSchool ?? 0 , handler: { (success, errorMsg, result, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if success == "1" {
                        if result != nil {
                            if result?.Result == 1 {
                                self.view.subviews.forEach({$0.removeFromSuperview()})
                                self.setUpView(item: result!)
                            } else {
                                self.showAlert(title: "Thông báo", message: errorMsg)
                            }
                            
                        } else {
                            debugPrint("Không lấy được data")
                        }
                    } else {
                        self.showAlert(title: "Thông báo", message: errorMsg)
                    }
                    
                }
            })
        }
    }
    
    @objc func actionBack() {
        for vc in self.navigationController?.viewControllers ?? [] {
            if vc is CheckSBDViewController {
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
}
