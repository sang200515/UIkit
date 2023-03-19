//
//  XacNhanNvViewController.swift
//  mPOS
//
//  Created by tan on 8/30/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class ThongTinThuHoLongChauViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    var scrollView:UIScrollView!
    var tfSoMpos:UITextField!
    var tfNhaThuoc:UITextView!
    var tfNvnopTien:UITextField!
    
    var tfTienThanhToan:UITextField!
    var tfNoiDungThanhToan:UITextView!
    var thongTinThuHo:ThongTinThuHo?
    var btInBill:UIButton!
    
    override func viewDidLoad() {
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.title = "Thu Hộ Long Châu"
        self.view.addSubview(scrollView)
        navigationController?.navigationBar.isTranslucent = false
        
        self.setupUI()
        
    }
    
    func setupUI(){
        let lbTextThongTinKH = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbTextThongTinKH.textAlignment = .left
        lbTextThongTinKH.textColor = UIColor(netHex:0x47B054)
        lbTextThongTinKH.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        lbTextThongTinKH.text = "Thông tin giao dịch"
        scrollView.addSubview(lbTextThongTinKH)
        
        tfSoMpos = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextThongTinKH.frame.origin.y + lbTextThongTinKH.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfSoMpos.placeholder = "Số mpos"
        tfSoMpos.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSoMpos.borderStyle = UITextField.BorderStyle.roundedRect
        tfSoMpos.autocorrectionType = UITextAutocorrectionType.no
        tfSoMpos.keyboardType = UIKeyboardType.numberPad
        tfSoMpos.returnKeyType = UIReturnKeyType.done
        tfSoMpos.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfSoMpos.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSoMpos.delegate = self
        scrollView.addSubview(tfSoMpos)
        tfSoMpos.text = "Số mpos: \(self.thongTinThuHo!.soMpos)"
        tfSoMpos.isUserInteractionEnabled = false
        tfSoMpos.isEnabled = false
        
        tfNhaThuoc = UITextView(frame: CGRect(x: Common.Size(s:15), y: tfSoMpos.frame.origin.y + tfSoMpos.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: tfSoMpos.frame.height * 2));
        
        
        let borderColor1 : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        tfNhaThuoc.layer.borderWidth = 0.5
        tfNhaThuoc.layer.borderColor = borderColor1.cgColor
        tfNhaThuoc.layer.cornerRadius = 5.0
        tfNhaThuoc.delegate = self
        tfNhaThuoc.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        scrollView.addSubview(tfNhaThuoc)
        tfNhaThuoc.text = "Nhà thuốc: \(self.thongTinThuHo!.nhaThuocString)"
        tfNhaThuoc.isUserInteractionEnabled = false
        
        
        tfNvnopTien = UITextField(frame: CGRect(x: Common.Size(s:15), y: tfNhaThuoc.frame.origin.y + tfNhaThuoc.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        
        tfNvnopTien.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfNvnopTien.borderStyle = UITextField.BorderStyle.roundedRect
        tfNvnopTien.autocorrectionType = UITextAutocorrectionType.no
        tfNvnopTien.keyboardType = UIKeyboardType.numberPad
        tfNvnopTien.returnKeyType = UIReturnKeyType.done
        tfNvnopTien.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfNvnopTien.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfNvnopTien.delegate = self
        scrollView.addSubview(tfNvnopTien)
        tfNvnopTien.text = "Nv nộp tiền: \(self.thongTinThuHo!.nvNopTienString)"
        tfNvnopTien.isUserInteractionEnabled = false
        tfNvnopTien.isEnabled = false
        
        let lbTextThongTinThanhToan = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfNvnopTien.frame.origin.y + tfNvnopTien.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbTextThongTinThanhToan.textAlignment = .left
        lbTextThongTinThanhToan.textColor = UIColor(netHex:0x47B054)
        lbTextThongTinThanhToan.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        lbTextThongTinThanhToan.text = "Thông tin thanh toán"
        scrollView.addSubview(lbTextThongTinThanhToan)
        
        
        tfTienThanhToan = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextThongTinThanhToan.frame.origin.y + lbTextThongTinThanhToan.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        
        tfTienThanhToan.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTienThanhToan.borderStyle = UITextField.BorderStyle.roundedRect
        tfTienThanhToan.autocorrectionType = UITextAutocorrectionType.no
        tfTienThanhToan.keyboardType = UIKeyboardType.numberPad
        tfTienThanhToan.returnKeyType = UIReturnKeyType.done
        tfTienThanhToan.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfTienThanhToan.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTienThanhToan.delegate = self
        scrollView.addSubview(tfTienThanhToan)
        tfTienThanhToan.text = "Tiền t/toán: \(self.thongTinThuHo!.sotienString)"
        tfTienThanhToan.isUserInteractionEnabled = false
        tfTienThanhToan.isEnabled = false
        
        
        tfNoiDungThanhToan = UITextView(frame: CGRect(x: tfTienThanhToan.frame.origin.x , y: tfTienThanhToan.frame.origin.y  + tfTienThanhToan.frame.size.height + Common.Size(s:10), width: tfTienThanhToan.frame.size.width, height: tfTienThanhToan.frame.size.height * 2 ))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        tfNoiDungThanhToan.layer.borderWidth = 0.5
        tfNoiDungThanhToan.layer.borderColor = borderColor.cgColor
        tfNoiDungThanhToan.layer.cornerRadius = 5.0
        tfNoiDungThanhToan.delegate = self
        tfNoiDungThanhToan.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        scrollView.addSubview(tfNoiDungThanhToan)
        tfNoiDungThanhToan.text = "Nội dung: \(self.thongTinThuHo!.noiDung)"
        tfNoiDungThanhToan.isUserInteractionEnabled = false
        
        
        btInBill = UIButton()
        btInBill.frame = CGRect(x: Common.Size(s: 40), y: tfNoiDungThanhToan.frame.origin.y + tfNoiDungThanhToan.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:80),height: Common.Size(s: 40))
        btInBill.backgroundColor = UIColor(netHex:0x47B054)
        btInBill.setTitle("In Bill", for: .normal)
        btInBill.addTarget(self, action: #selector(actionInBill), for: .touchUpInside)
        btInBill.layer.borderWidth = 0.5
        btInBill.layer.borderColor = UIColor.white.cgColor
        btInBill.layer.cornerRadius = 3
        scrollView.addSubview(btInBill)
        btInBill.clipsToBounds = true
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btInBill.frame.origin.y + btInBill.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 60))
        
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        
        let printBillThuHoLC = BillParamThuHo(DiaChiShop:(Cache.user?.Address)!
            , SoPhieuThu: self.thongTinThuHo!.sophieucrm
            , MaGiaoDich: self.thongTinThuHo!.billID
            , ThoiGianThu:dateString
            , DichVu: "Thu hộ nhà thuốc Long Châu"
            , NhaCungCap: "Nhà thuốc Long Châu"
            , MaKhachHang:self.thongTinThuHo!.nhaThuocCode
            , TenKhachHang:self.thongTinThuHo!.nhaThuocString
            , TenNguoiNopTien:self.thongTinThuHo!.nvNopTienString
            , SoDienThoaiKH: self.thongTinThuHo!.sdtNhanVien
            , DiaChiNhaThuoc: self.thongTinThuHo!.diaChiNhaThuoc
            , NoiDung:self.thongTinThuHo!.noiDung
            , TongTienThu: "\(self.thongTinThuHo!.sotien)"
            , NguoiThuPhieu:(Cache.user?.EmployeeName)!
            , NhanVien:(Cache.user?.UserName)!)
        MPOSAPIManager.pushBillThuHoLongChau(printBill: printBillThuHoLC)
        
        let alert = UIAlertController(title: "Thông báo", message: "Đã gửi lệnh in!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
        
    }
    @objc func actionInBill(){
        
        
        let title = "Thông báo"
        let popup = PopupDialog(title: title, message: "Bạn muốn in bill?", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
            print("Completed")
        }
        let buttonOne = DefaultButton(title: "In") {
            
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
            let date = Date()
            let dateString = dateFormatter.string(from: date)
            
            
            let printBillThuHoLC = BillParamThuHo(DiaChiShop:(Cache.user?.Address)!
                , SoPhieuThu: self.thongTinThuHo!.sophieucrm
                , MaGiaoDich: self.thongTinThuHo!.billID
                , ThoiGianThu:dateString
                , DichVu: "Thu hộ nhà thuốc Long Châu"
                , NhaCungCap: "Nhà thuốc Long Châu"
                , MaKhachHang:self.thongTinThuHo!.nhaThuocCode
                , TenKhachHang:self.thongTinThuHo!.nhaThuocString
                , TenNguoiNopTien:self.thongTinThuHo!.nvNopTienString
                , SoDienThoaiKH: self.thongTinThuHo!.sdtNhanVien
                , DiaChiNhaThuoc: self.thongTinThuHo!.diaChiNhaThuoc
                , NoiDung:self.thongTinThuHo!.noiDung
                , TongTienThu: "\(self.thongTinThuHo!.sotien)"
                , NguoiThuPhieu:(Cache.user?.EmployeeName)!
                , NhanVien:(Cache.user?.UserName)!)
            MPOSAPIManager.pushBillThuHoLongChau(printBill: printBillThuHoLC)
            
            let alert = UIAlertController(title: "Thông báo", message: "Đã gửi lệnh in!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
        }
        let buttonTwo = CancelButton(title: "Không"){
            
        }
        popup.addButtons([buttonOne,buttonTwo])
        self.present(popup, animated: true, completion: nil)
        
    }
}
