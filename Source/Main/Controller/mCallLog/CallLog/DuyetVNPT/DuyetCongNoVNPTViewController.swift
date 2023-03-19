//
//  DuyetCongNoVNPTViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 12/13/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DLRadioButton

class DuyetCongNoVNPTViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var callLog:CallLog?
    var radioDuyet:DLRadioButton!
    var radioKhongDuyet:DLRadioButton!
    var btnFinish: UIButton!
    var tvLyDoKhongDuyetText: UITextView!
//    var p_RequestId = "5799261"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "\(self.callLog?.RequestID ?? 0) - Duyệt công nợ KH VNPT"
        self.view.backgroundColor = UIColor.white
        
        let backView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:30), height: Common.Size(s:50))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: backView)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        backView.addSubview(btBackIcon)
        
//        CL: "\(self.callog?.RequestID ?? 0)"
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            let rs = mCallLogApiManager.DuyetCongNoVNPTReq__GetDetail_ByReqId(p_RequestId: "\(self.callLog?.RequestID ?? 0)").Data ?? []
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if rs.count > 0 {
                    self.setUpView(item: rs[0])
                } else {
                    self.showAlert(title: "Thông báo", message: "LOAD API ERR")
                }
            }
        }
    }
    
    func setUpView(item:DuyetCongNoVNPT) {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let lbCustomerName = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: scrollView.frame.width - Common.Size(s: 30) , height: Common.Size(s: 20)))
        lbCustomerName.text = "Tên khách hàng: \(item.HoTenKH ?? "")"
        lbCustomerName.setLabel(str1: "Tên khách hàng: ", str2: "\(item.HoTenKH ?? "")")
        scrollView.addSubview(lbCustomerName)
        
        let lbCustomerNameHeight: CGFloat = lbCustomerName.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbCustomerName.optimalHeight
        lbCustomerName.numberOfLines = 0
        lbCustomerName.frame = CGRect(x: lbCustomerName.frame.origin.x, y: lbCustomerName.frame.origin.y, width: lbCustomerName.frame.width, height: lbCustomerNameHeight)
        
        let lbCMND = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x, y: lbCustomerName.frame.origin.y + lbCustomerNameHeight + Common.Size(s: 3), width: lbCustomerName.frame.width, height: Common.Size(s: 20)))
        lbCMND.text = "CMND: \(item.CMND ?? "")"
        lbCMND.setLabel(str1: "CMND: ", str2: "\(item.CMND ?? "")")
        scrollView.addSubview(lbCMND)
        
        let lbChiNhanh = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x, y: lbCMND.frame.origin.y + lbCMND.frame.height + Common.Size(s: 3), width: lbCustomerName.frame.width, height: Common.Size(s: 20)))
        lbChiNhanh.text = "GĐ Chi Nhánh: \(item.TenGDCN ?? "")"
        lbChiNhanh.setLabel(str1: "GĐ Chi Nhánh: ", str2: "\(item.TenGDCN ?? "")")
        scrollView.addSubview(lbChiNhanh)
        
        let lbChiNhanhHeight: CGFloat = lbChiNhanh.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbChiNhanh.optimalHeight
        lbChiNhanh.numberOfLines = 0
        lbChiNhanh.frame = CGRect(x: lbChiNhanh.frame.origin.x, y: lbChiNhanh.frame.origin.y, width: lbChiNhanh.frame.width, height: lbChiNhanhHeight)
        
        let lbSDTNhanOTP = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x, y: lbChiNhanh.frame.origin.y + lbChiNhanhHeight + Common.Size(s: 3), width: lbCustomerName.frame.width, height: Common.Size(s: 20)))
        lbSDTNhanOTP.text = "SĐT nhận OTP: \(item.SDT ?? "")"
        lbSDTNhanOTP.setLabel(str1: "SĐT nhận OTP: ", str2: "\(item.SDT ?? "")")
        scrollView.addSubview(lbSDTNhanOTP)
        
        let lbMPOS = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x, y: lbSDTNhanOTP.frame.origin.y + lbSDTNhanOTP.frame.height + Common.Size(s: 3), width: lbCustomerName.frame.width, height: Common.Size(s: 20)))
        lbMPOS.text = "Số MPOS: \(item.SoMPOS ?? "")"
        lbMPOS.setLabel(str1: "Số MPOS: ", str2: "\(item.SoMPOS ?? "")")
        scrollView.addSubview(lbMPOS)
        
        let lbShopName = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x, y: lbMPOS.frame.origin.y + lbMPOS.frame.height + Common.Size(s: 3), width: lbCustomerName.frame.width, height: Common.Size(s: 20)))
        lbShopName.text = "Shop bán hàng: \(item.Shop ?? "")"
        lbShopName.setLabel(str1: "Shop bán hàng: ", str2: "\(item.Shop ?? "")")
        scrollView.addSubview(lbShopName)
        
        let lbShopNameHeight: CGFloat = lbShopName.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbShopName.optimalHeight
        lbShopName.numberOfLines = 0
        lbShopName.frame = CGRect(x: lbShopName.frame.origin.x, y: lbShopName.frame.origin.y, width: lbShopName.frame.width, height: lbShopNameHeight)
        
        let lbNVBanHangName = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x, y: lbShopName.frame.origin.y + lbShopNameHeight + Common.Size(s: 3), width: lbCustomerName.frame.width, height: Common.Size(s: 20)))
        lbNVBanHangName.text = "Nhân viên bán hàng: \(item.NhanVienBanHang ?? "")"
        lbNVBanHangName.setLabel(str1: "Nhân viên bán hàng: ", str2: "\(item.NhanVienBanHang ?? "")")
        scrollView.addSubview(lbNVBanHangName)
        
        let lbNVBanHangNameHeight: CGFloat = lbNVBanHangName.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbNVBanHangName.optimalHeight
        lbNVBanHangName.numberOfLines = 0
        lbNVBanHangName.frame = CGRect(x: lbNVBanHangName.frame.origin.x, y: lbNVBanHangName.frame.origin.y, width: lbNVBanHangName.frame.width, height: lbNVBanHangNameHeight)
        
        let lbNgayTaoCalllog = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x, y: lbNVBanHangName.frame.origin.y + lbNVBanHangNameHeight + Common.Size(s: 3), width: lbCustomerName.frame.width, height: Common.Size(s: 20)))
        lbNgayTaoCalllog.text = "Ngày tạo calllog: \(item.NgayTao ?? "")"
        lbNgayTaoCalllog.setLabel(str1: "Ngày tạo calllog: ", str2: "\(item.NgayTao ?? "")")
        scrollView.addSubview(lbNgayTaoCalllog)
        
        let lbTongTien = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x, y: lbNgayTaoCalllog.frame.origin.y + lbNgayTaoCalllog.frame.height + Common.Size(s: 3), width: lbCustomerName.frame.width, height: Common.Size(s: 20)))
        lbTongTien.text = "Tổng tiền đơn hàng(VAT): \(item.TongTienDonHang ?? "")"
        lbTongTien.setLabel(str1: "Tổng tiền đơn hàng(VAT): ", str2: "\(item.TongTienDonHang ?? "")đ")
        scrollView.addSubview(lbTongTien)
        
        let lbImgDonDatHang = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x, y: lbTongTien.frame.origin.y + lbTongTien.frame.height + Common.Size(s: 15), width: lbCustomerName.frame.width, height: Common.Size(s: 20)))
        lbImgDonDatHang.text = "Hình đơn đặt hàng:"
        lbImgDonDatHang.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbImgDonDatHang)
        
        //don dat hang
        let viewImgDonDatHang = UIView(frame: CGRect(x: Common.Size(s: 15), y: lbImgDonDatHang.frame.origin.y + lbImgDonDatHang.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s:200)))
        viewImgDonDatHang.layer.borderColor = UIColor.lightGray.cgColor
        viewImgDonDatHang.layer.borderWidth = 1
        scrollView.addSubview(viewImgDonDatHang)
        
        let imgDonDatHang = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImgDonDatHang.frame.width, height: viewImgDonDatHang.frame.height))
        imgDonDatHang.image = #imageLiteral(resourceName: "UploadImage")
        imgDonDatHang.contentMode = .scaleAspectFit
        viewImgDonDatHang.addSubview(imgDonDatHang)
        self.encodeURLImg(urlString: "\(item.HinhDonDatHang ?? "")", imgView: imgDonDatHang)
        
        //cmnd mat truoc
        let lbImgCMNDMatTruoc = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x, y: viewImgDonDatHang.frame.origin.y + viewImgDonDatHang.frame.height + Common.Size(s: 15), width: lbCustomerName.frame.width, height: Common.Size(s: 20)))
        lbImgCMNDMatTruoc.text = "Hình CMND mặt trước:"
        lbImgCMNDMatTruoc.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbImgCMNDMatTruoc)
        
        let viewImgCMNDMatTruoc = UIView(frame: CGRect(x: Common.Size(s: 15), y: lbImgCMNDMatTruoc.frame.origin.y + lbImgCMNDMatTruoc.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s:200)))
        viewImgCMNDMatTruoc.layer.borderColor = UIColor.lightGray.cgColor
        viewImgCMNDMatTruoc.layer.borderWidth = 1
        scrollView.addSubview(viewImgCMNDMatTruoc)
        
        let imgCMNDMatTruoc = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImgCMNDMatTruoc.frame.width, height: viewImgCMNDMatTruoc.frame.height))
        imgCMNDMatTruoc.image = #imageLiteral(resourceName: "UploadImage")
        imgCMNDMatTruoc.contentMode = .scaleAspectFit
        viewImgCMNDMatTruoc.addSubview(imgCMNDMatTruoc)
        self.encodeURLImg(urlString: "\(item.HinhCMNDMatTruoc ?? "")", imgView: imgCMNDMatTruoc)
        
        //cmnd mat sau
        let lbImgCMNDMatSau = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x, y: viewImgCMNDMatTruoc.frame.origin.y + viewImgCMNDMatTruoc.frame.height + Common.Size(s: 15), width: lbCustomerName.frame.width, height: Common.Size(s: 20)))
        lbImgCMNDMatSau.text = "Hình CMND mặt sau:"
        lbImgCMNDMatSau.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbImgCMNDMatSau)
        
        let viewImgCMNDMatSau = UIView(frame: CGRect(x: Common.Size(s: 15), y: lbImgCMNDMatSau.frame.origin.y + lbImgCMNDMatSau.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s:200)))
        viewImgCMNDMatSau.layer.borderColor = UIColor.lightGray.cgColor
        viewImgCMNDMatSau.layer.borderWidth = 1
        scrollView.addSubview(viewImgCMNDMatSau)
        
        let imgCMNDMatSau = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImgCMNDMatSau.frame.width, height: viewImgCMNDMatSau.frame.height))
        imgCMNDMatSau.image = #imageLiteral(resourceName: "UploadImage")
        imgCMNDMatSau.contentMode = .scaleAspectFit
        viewImgCMNDMatSau.addSubview(imgCMNDMatSau)
        self.encodeURLImg(urlString: "\(item.HinhCMNDMatSau ?? "")", imgView: imgCMNDMatSau)
        
        //anh khach hang
        let lbImgCustomer = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x, y: viewImgCMNDMatSau.frame.origin.y + viewImgCMNDMatSau.frame.height + Common.Size(s: 15), width: lbCustomerName.frame.width, height: Common.Size(s: 20)))
        lbImgCustomer.text = "Hình ảnh khách hàng:"
        lbImgCustomer.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbImgCustomer)
        
        let viewImgCustomer = UIView(frame: CGRect(x: Common.Size(s: 15), y: lbImgCustomer.frame.origin.y + lbImgCustomer.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s:200)))
        viewImgCustomer.layer.borderColor = UIColor.lightGray.cgColor
        viewImgCustomer.layer.borderWidth = 1
        scrollView.addSubview(viewImgCustomer)
        
        let imgCustomer = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImgCustomer.frame.width, height: viewImgCustomer.frame.height))
        imgCustomer.image = #imageLiteral(resourceName: "UploadImage")
        imgCustomer.contentMode = .scaleAspectFit
        viewImgCustomer.addSubview(imgCustomer)
        self.encodeURLImg(urlString: "\(item.HinhSanPham ?? "")", imgView: imgCustomer)
        
        radioDuyet = createRadioButtonGender(CGRect(x: Common.Size(s: 20), y: viewImgCustomer.frame.origin.y + viewImgCustomer.frame.height + Common.Size(s: 25), width: (scrollView.frame.size.width - Common.Size(s: 40))/2, height: Common.Size(s: 15)), title: "Duyệt", color: UIColor(red: 30/255, green: 149/255, blue: 82/255, alpha: 1));
        radioDuyet.isSelected = true
        scrollView.addSubview(radioDuyet)
        
        radioKhongDuyet = createRadioButtonGender(CGRect(x: radioDuyet.frame.origin.x + radioDuyet.frame.size.width ,y: radioDuyet.frame.origin.y, width: radioDuyet.frame.size.width, height: radioDuyet.frame.size.height), title: "Không duyệt", color: UIColor(red: 30/255, green: 149/255, blue: 82/255, alpha: 1));
        radioKhongDuyet.isSelected = false
        scrollView.addSubview(radioKhongDuyet)
        
        let lbLyDoKhongDuyet = UILabel(frame: CGRect(x: Common.Size(s: 15), y: radioKhongDuyet.frame.origin.y + radioKhongDuyet.frame.height + Common.Size(s: 15), width: lbCustomerName.frame.width, height: Common.Size(s: 20)))
        lbLyDoKhongDuyet.text = "Lý do không duyệt:"
        lbLyDoKhongDuyet.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbLyDoKhongDuyet)
        
        tvLyDoKhongDuyetText = UITextView(frame: CGRect(x: Common.Size(s: 15), y: lbLyDoKhongDuyet.frame.origin.y + lbLyDoKhongDuyet.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 120)))
        tvLyDoKhongDuyetText.layer.borderColor = UIColor.lightGray.cgColor
        tvLyDoKhongDuyetText.layer.borderWidth = 1
        tvLyDoKhongDuyetText.layer.cornerRadius = 5
        scrollView.addSubview(tvLyDoKhongDuyetText)
        
        btnFinish = UIButton(frame: CGRect(x: Common.Size(s: 30), y: tvLyDoKhongDuyetText.frame.origin.y + tvLyDoKhongDuyetText.frame.height + Common.Size(s: 20), width: scrollView.frame.width - Common.Size(s: 60), height: Common.Size(s: 45)))
        btnFinish.setTitle("HOÀN TẤT", for: .normal)
        btnFinish.layer.cornerRadius = 5
        btnFinish.backgroundColor = UIColor(red: 72/255, green: 160/255, blue: 109/255, alpha: 1)
        scrollView.addSubview(btnFinish)
        btnFinish.addTarget(self, action: #selector(xuLyDuyetCongNoVNPT), for: .touchUpInside)
        
        scrollViewHeight = btnFinish.frame.origin.y + btnFinish.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    @objc func xuLyDuyetCongNoVNPT() {
        var isDuyet = "0"
        
        if radioDuyet.isSelected {
            isDuyet = "1"
        } else if radioKhongDuyet.isSelected {
            isDuyet = "0"
            guard let lyDoText = tvLyDoKhongDuyetText.text, !lyDoText.isEmpty else {
                self.showAlert(title: "Thông báo", message: "Bạn phải nhập lý do không duyệt!")
                return
            }
        } else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa chọn hình thức duyệt!")
        }
//       CL: "\(self.callog?.RequestID ?? 0)"
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            let rs = mCallLogApiManager.DuyetCongNoVNPTReq__XuLy(p_RequestId: "\(self.callLog?.RequestID ?? 0)", p_Duyet: "\(isDuyet)", p_LyDo: self.tvLyDoKhongDuyetText.text).Data ?? []
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if rs.count > 0 {
                    if rs[0].Result == 1 { //hoan tat thanh cong
                        let alertVC = UIAlertController(title: "Thông báo", message: "\(rs[0].Msg ?? "Hoàn tất Calllog!")", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default) { (_) in
                            self.navigationController?.popViewController(animated: true)
                        }
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    } else {
                        self.showAlert(title: "Thông báo", message: "\(rs[0].Msg ?? "Duyệt calllog thất bại!")")
                    }
                } else {
                    self.showAlert(title: "Thông báo", message: "LOAD API ERR")
                }
            }
        }
    }
    
    func encodeURLImg(urlString: String, imgView: UIImageView) {
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        if let escapedString = "\(urlString)".addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print("escapedString: \(escapedString)")
            if let url = URL(string: "\(escapedString)") {
                imgView.kf.setImage(with: url,
                placeholder: nil,
                options: [.transition(.fade(1))],
                progressBlock: nil,
                completionHandler: nil)
            } else {
                imgView.image = #imageLiteral(resourceName: "UploadImage")
            }
        } else {
            imgView.image = #imageLiteral(resourceName: "UploadImage")
        }
    }
    
    fileprivate func createRadioButtonGender(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: 13);
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(logSelectedButtonGender), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    @objc fileprivate func logSelectedButtonGender(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioDuyet.isSelected = false
            radioKhongDuyet.isSelected = false
            switch temp {
            case "Duyệt":
                radioDuyet.isSelected = true
                break
            case "Không duyệt":
                radioKhongDuyet.isSelected = true
                break
            default:
                break
            }
        }
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
}

extension UILabel {
    func setLabel(str1: String, str2: String) {
        let attributed1 = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributed2 = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributedString1 = NSMutableAttributedString(string:str1, attributes:attributed1)
        let attributedString2 = NSMutableAttributedString(string:str2, attributes:attributed2)
        attributedString1.append(attributedString2)
        self.attributedText = attributedString1
    }
}
