//
//  CreateStudentInfoViewController.swift
//  fptshop
//
//  Created by Apple on 7/2/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown

class CreateStudentInfoViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var tfFullName: UITextField!
    var tfCMND: UITextField!
    var tfPhone: UITextField!
    var tfBirthDay: UITextField!
    var btnSave: UIButton!
    var lbSBDValue: UILabel!
    var dropDate = DropDown()
    
    var camKetView: UIView!
    var imgCheckCamKet: UIImageView!
    var isCheck : Bool = false
    
    var arrMonHoc:[MonHocBTS] = []
    var studentInfoItem:StudentBTSInfo?
    var listDate = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
    
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
        
        setUpView()
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpView() {
        
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
        
        let lbName = UILabel(frame: CGRect(x: Common.Size(s:15), y: studentInfoView.frame.origin.y + studentInfoView.frame.height + Common.Size(s:10), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:15)))
        lbName.text = "Họ tên:"
        lbName.textColor = UIColor.black
        lbName.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(lbName)
        
        tfFullName = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbName.frame.origin.y + lbName.frame.height + Common.Size(s:5), width: lbName.frame.width, height: Common.Size(s:35)))
        tfFullName.borderStyle = .roundedRect
        tfFullName.font = UIFont.systemFont(ofSize: 13)
        tfFullName.text = self.studentInfoItem?.HoTen ?? ""
        scrollView.addSubview(tfFullName)
        
        let lbCmnd = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfFullName.frame.origin.y + tfFullName.frame.height + Common.Size(s:10), width: lbName.frame.width, height: Common.Size(s:15)))
        lbCmnd.text = "CMND:"
        lbCmnd.textColor = UIColor.black
        lbCmnd.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(lbCmnd)
        
        tfCMND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbCmnd.frame.origin.y + lbCmnd.frame.height + Common.Size(s:5), width: lbName.frame.width, height: Common.Size(s:35)))
        tfCMND.borderStyle = .roundedRect
        tfCMND.font = UIFont.systemFont(ofSize: 13)
        tfCMND.keyboardType = .numberPad
        tfCMND.text = self.studentInfoItem?.CMND ?? ""
        scrollView.addSubview(tfCMND)
        
        let lbSdt = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfCMND.frame.origin.y + tfCMND.frame.height + Common.Size(s:10), width: lbName.frame.width, height: Common.Size(s:15)))
        lbSdt.text = "Số điện thoại:"
        lbSdt.textColor = UIColor.black
        lbSdt.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(lbSdt)
        
        tfPhone = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbSdt.frame.origin.y + lbSdt.frame.height + Common.Size(s:5), width: lbName.frame.width, height: Common.Size(s:35)))
        tfPhone.borderStyle = .roundedRect
        tfPhone.font = UIFont.systemFont(ofSize: 13)
        tfPhone.keyboardType = .numberPad
        tfPhone.text = self.studentInfoItem?.SDT ?? ""
        scrollView.addSubview(tfPhone)
        
        let lbNgaySinh = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhone.frame.origin.y + tfPhone.frame.height + Common.Size(s:10), width: lbName.frame.width, height: Common.Size(s:15)))
        lbNgaySinh.text = "Ngày sinh:"
        lbNgaySinh.textColor = UIColor.black
        lbNgaySinh.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(lbNgaySinh)
        
        tfBirthDay = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbNgaySinh.frame.origin.y + lbNgaySinh.frame.height + Common.Size(s:5), width: lbName.frame.width, height: Common.Size(s:35)))
        tfBirthDay.borderStyle = .roundedRect
        tfBirthDay.font = UIFont.systemFont(ofSize: 13)
        tfBirthDay.keyboardType = .numberPad
        tfBirthDay.text = self.studentInfoItem?.NgaySinh ?? ""
        scrollView.addSubview(tfBirthDay)
        
        // Hide BirthDay
        lbNgaySinh.isHidden = true
        tfBirthDay.isHidden = true
        
        let tapShowListDate = UITapGestureRecognizer(target: self, action: #selector(showListDate))
        tfBirthDay.isUserInteractionEnabled = true
        tfBirthDay.addGestureRecognizer(tapShowListDate)
        
        //thong tin diem thi View
        let pointInfoView = UIView(frame: CGRect(x: 0, y: tfBirthDay.frame.origin.y + tfBirthDay.frame.height + Common.Size(s: 15), width: scrollView.frame.width, height: Common.Size(s:40)))
        pointInfoView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        scrollView.addSubview(pointInfoView)
        
        let lbPointInfo = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: pointInfoView.frame.width - Common.Size(s:30), height: pointInfoView.frame.height))
        lbPointInfo.text = "THÔNG TIN ĐIỂM THI"
        pointInfoView.addSubview(lbPointInfo)
        
        let lbSBD = UILabel(frame: CGRect(x: lbName.frame.origin.x, y: pointInfoView.frame.origin.y + pointInfoView.frame.height + Common.Size(s:10), width: scrollView.frame.width/3 - Common.Size(s:15), height: Common.Size(s:20)))
        lbSBD.text = "Số báo danh: "
        lbSBD.textColor = UIColor.darkGray
        lbSBD.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbSBD)
        //
        lbSBDValue = UILabel(frame: CGRect(x: lbSBD.frame.origin.x + lbSBD.frame.width, y: lbSBD.frame.origin.y, width: scrollView.frame.width - (lbSBD.frame.width + Common.Size(s: 5)) - Common.Size(s:15), height: Common.Size(s:20)))
        lbSBDValue.text = "\(self.studentInfoItem?.SoBaoDanh ?? "")"
        lbSBDValue.textColor = UIColor.black
        lbSBDValue.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbSBDValue)
        
        //point view
        let pointView = UIView(frame: CGRect(x: 0, y: lbSBDValue.frame.origin.y + lbSBDValue.frame.height, width: scrollView.frame.width, height: Common.Size(s:40)))
        scrollView.addSubview(pointView)
        
        
        //
        var xPoint: CGFloat = 0
        var yPoint: CGFloat = 0
        if (self.studentInfoItem?.DiemTungMon.count)! > 0 {
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
        
        
        let pointViewHeight:CGFloat = ((CGFloat((self.studentInfoItem?.DiemTungMon.count)!/2) + 1) * Common.Size(s:30)) + Common.Size(s:30)
        
        pointView.frame = CGRect(x: pointView.frame.origin.x, y: pointView.frame.origin.y, width: pointView.frame.width, height: pointViewHeight)
        
        //----cam ket view
        camKetView = UIView(frame: CGRect(x: Common.Size(s:15), y: pointView.frame.origin.y + pointView.frame.height, width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:35)))
        scrollView.addSubview(camKetView)
        
        let lbCamKet = UILabel(frame: CGRect(x: Common.Size(s:50), y: 0, width: camKetView.frame.width - Common.Size(s:50) - Common.Size(s:15), height: camKetView.frame.height))
        lbCamKet.text = "Shop cam kết thông tin cập nhật hoàn toàn chính xác"
        lbCamKet.font = UIFont(name:"Trebuchet MS",size:17)
        camKetView.addSubview(lbCamKet)
        
        let lbcamKetHeight = lbCamKet.optimalHeight > Common.Size(s:35) ? lbCamKet.optimalHeight : Common.Size(s:35)
        lbCamKet.numberOfLines = 0
        
        camKetView.frame = CGRect(x: camKetView.frame.origin.x, y: camKetView.frame.origin.y, width: camKetView.frame.width, height: lbcamKetHeight)
        
        imgCheckCamKet = UIImageView(frame: CGRect(x: 0, y: camKetView.frame.height/2 - Common.Size(s:15), width: Common.Size(s:30), height: Common.Size(s:30)))
        imgCheckCamKet.image = UIImage(named: "uncheck")
        camKetView.addSubview(imgCheckCamKet)
        
        let tapCheckCamKet = UITapGestureRecognizer(target: self, action: #selector(checkCamKet))
        imgCheckCamKet.isUserInteractionEnabled = true
        imgCheckCamKet.addGestureRecognizer(tapCheckCamKet)
        
        //------
        
//        btnSave = UIButton(frame: CGRect(x: Common.Size(s:15), y: pointView.frame.origin.y + pointView.frame.height, width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:40)))
        
        btnSave = UIButton(frame: CGRect(x: Common.Size(s:15), y: camKetView.frame.origin.y + camKetView.frame.height + Common.Size(s: 20), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:40)))
        btnSave.setTitle("LƯU", for: .normal)
        btnSave.backgroundColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        btnSave.addTarget(self, action: #selector(saveStudentInfo), for: .touchUpInside)
        btnSave.layer.cornerRadius = 5
        scrollView.addSubview(btnSave)
        
        scrollViewHeight = btnSave.frame.origin.y + btnSave.frame.height + Common.Size(s: 100)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    @objc func checkCamKet() {
        isCheck = !isCheck
        imgCheckCamKet.image = UIImage(named: isCheck ? "checkedBox" : "uncheck")
    }
    
    @objc func saveStudentInfo() {
        guard let hoTen = self.tfFullName.text, !hoTen.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập họ tên!")
            return
        }
        
        guard let cmnd = self.tfCMND.text, !cmnd.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập CMND!")
            return
        }
        
        guard let sdt = self.tfPhone.text, !sdt.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập số điện thoại!")
            return
        }
        
//        guard let ngaySinh = self.tfBirthDay.text, !ngaySinh.isEmpty else {
//            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập số ngày sinh!")
//            return
//        }
        
        if cmnd.count != 9 && cmnd.count != 12 {
            self.showAlert(title: "Thông báo", message: "CMND không hợp lệ!")
            return
        }
        
        if (sdt.count != 10 && sdt.hasPrefix("0")) || (sdt == "0000000000") {
            self.showAlert(title: "Thông báo", message: "Số điện thoại không hợp lệ!")
            return
        }
        if isCheck == false {
            self.showAlert(title: "Thông báo", message: "Phải nhấn chọn ô cam kết trước khi LƯU!")
        } else {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.BackToSchool_UpdateThongTinKhachHang(ID_BackToSchool: self.studentInfoItem?.ID_BackToSchool ?? 0, SBD: self.studentInfoItem?.SoBaoDanh ?? "", HoTen: hoTen, CMND: cmnd, SDT: sdt, NgaySinh: 0, handler: { (success, errorMsg, mData, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if success == "1" {
                            let alertVC = UIAlertController(title: "Thông báo", message: errorMsg, preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                let newViewController = UploadStudentImageViewController()
                                newViewController.studentInfoItem = self.studentInfoItem
                                newViewController.numberIdentity = self.tfCMND.text
                                newViewController.isNewStudentInfo = true
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            })
                            alertVC.addAction(action)
                            self.present(alertVC, animated: true, completion: nil)
                        } else {
                            self.showAlert(title: "Thông báo", message: errorMsg)
                        }
                    }
                })
            }
        }

    }
    
    @objc func showListDate() {
        DropDown.setupDefaultAppearance();
        
        dropDate.dismissMode = .onTap
        dropDate.direction = .any
        
        dropDate.anchorView = tfBirthDay;
        DropDown.startListeningToKeyboard();
        
        //Setup datasources
        dropDate.dataSource = self.listDate;
        //        dropShopPB.selectRow(0);
        self.dropDate.show()
        
        dropDate.selectionAction = { [weak self] (index, item) in
            
            self?.listDate.forEach{
                if($0 == item){
                    self?.tfBirthDay.text = " \(item)"
                }
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
