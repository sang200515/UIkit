//
//  DetailLaptopBirthdayViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 11/13/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DetailLaptopBirthdayViewController: UIViewController {
    
    var itemDetail:LapTopBirthdayHistory?

    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.title = "CHI TIẾT LỊCH SỬ"
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let viewCustomerInfo = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewCustomerInfo.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        scrollView.addSubview(viewCustomerInfo)
        
        let lbCustomerInfo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewCustomerInfo.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbCustomerInfo.text = "THÔNG TIN KHÁCH HÀNG"
        lbCustomerInfo.font = UIFont.boldSystemFont(ofSize: 15)
        lbCustomerInfo.textColor = UIColor(netHex: 0x109e59)
        viewCustomerInfo.addSubview(lbCustomerInfo)
        
        let lbKHName = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewCustomerInfo.frame.origin.y + viewCustomerInfo.frame.height + Common.Size(s: 5), width: (scrollView.frame.width - Common.Size(s: 30))/2, height: Common.Size(s: 20)))
        lbKHName.text = "Tên khách hàng:"
        lbKHName.font = UIFont.systemFont(ofSize: 14)
        lbKHName.textColor = .lightGray
        scrollView.addSubview(lbKHName)

        let lbKHNameText = UILabel(frame: CGRect(x: lbKHName.frame.origin.x + lbKHName.frame.width, y: lbKHName.frame.origin.y, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbKHNameText.text = "\(itemDetail?.fullname ?? "")"
        lbKHNameText.font = UIFont.systemFont(ofSize: 14)
        lbKHNameText.textAlignment = .right
        scrollView.addSubview(lbKHNameText)
        
        let lbKHNameTextHeight: CGFloat = lbKHNameText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbKHNameText.optimalHeight + Common.Size(s: 5))
        lbKHNameText.numberOfLines = 0
        lbKHNameText.frame = CGRect(x: lbKHNameText.frame.origin.x, y: lbKHNameText.frame.origin.y, width: lbKHNameText.frame.width, height: lbKHNameTextHeight)
        
        let lbSdt = UILabel(frame: CGRect(x: lbKHName.frame.origin.x, y: lbKHNameText.frame.origin.y + lbKHNameTextHeight, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbSdt.text = "SĐT:"
        lbSdt.font = UIFont.systemFont(ofSize: 14)
        lbSdt.textColor = .lightGray
        scrollView.addSubview(lbSdt)
        
        let lbSdtText = UILabel(frame: CGRect(x: lbSdt.frame.origin.x + lbSdt.frame.width, y: lbSdt.frame.origin.y, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbSdtText.text = "\(itemDetail?.phonenumber ?? "")"
        lbSdtText.font = UIFont.systemFont(ofSize: 14)
        lbSdtText.textAlignment = .right
        scrollView.addSubview(lbSdtText)
        
        let lbNgaySinh = UILabel(frame: CGRect(x: lbKHName.frame.origin.x, y: lbSdtText.frame.origin.y + lbSdtText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbNgaySinh.text = "Ngày sinh:"
        lbNgaySinh.font = UIFont.systemFont(ofSize: 14)
        lbNgaySinh.textColor = .lightGray
        scrollView.addSubview(lbNgaySinh)
        
        let lbNgaySinhText = UILabel(frame: CGRect(x: lbNgaySinh.frame.origin.x + lbNgaySinh.frame.width, y: lbNgaySinh.frame.origin.y, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbNgaySinhText.font = UIFont.systemFont(ofSize: 14)
        lbNgaySinhText.textAlignment = .right
        scrollView.addSubview(lbNgaySinhText)
        
        let birthday = itemDetail?.birthday ?? ""
        if !(birthday.isEmpty) {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            let date2 = formatter.date(from: birthday)

            let newFormatter = DateFormatter()
            newFormatter.locale = Locale(identifier: "vi_VN");
            newFormatter.timeZone = TimeZone(identifier: "UTC");
            newFormatter.dateFormat = "dd/MM/yyyy"
            let str = newFormatter.string(from: date2 ?? Date())
            lbNgaySinhText.text = str
        } else {
            lbNgaySinhText.text = birthday
        }
        
        let lbSoCMND = UILabel(frame: CGRect(x: lbKHName.frame.origin.x, y: lbNgaySinhText.frame.origin.y + lbNgaySinhText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbSoCMND.text = "Số CMND/Căn cước:"
        lbSoCMND.font = UIFont.systemFont(ofSize: 14)
        lbSoCMND.textColor = .lightGray
        scrollView.addSubview(lbSoCMND)
        
        let lbSoCMNDText = UILabel(frame: CGRect(x: lbSoCMND.frame.origin.x + lbSoCMND.frame.width, y: lbSoCMND.frame.origin.y, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbSoCMNDText.text = "\(itemDetail?.idcard ?? "")"
        lbSoCMNDText.font = UIFont.systemFont(ofSize: 14)
        lbSoCMNDText.textAlignment = .right
        lbSoCMNDText.textColor = UIColor(netHex: 0x2c9949)
        scrollView.addSubview(lbSoCMNDText)
        
        let lbNV = UILabel(frame: CGRect(x: lbKHName.frame.origin.x, y: lbSoCMNDText.frame.origin.y + lbSoCMNDText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbNV.text = "Nhân viên cập nhật:"
        lbNV.font = UIFont.systemFont(ofSize: 14)
        lbNV.textColor = .lightGray
        scrollView.addSubview(lbNV)
        
        let lbNVText = UILabel(frame: CGRect(x: lbNV.frame.origin.x + lbNV.frame.width, y: lbNV.frame.origin.y, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbNVText.text = "\(itemDetail?.createby ?? "")"
        lbNVText.font = UIFont.systemFont(ofSize: 14)
        lbNVText.textAlignment = .right
        scrollView.addSubview(lbNVText)
        
        let lbNVTextHeight: CGFloat = lbNVText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNVText.optimalHeight + Common.Size(s: 5))
        lbNVText.numberOfLines = 0
        lbNVText.frame = CGRect(x: lbNVText.frame.origin.x, y: lbNVText.frame.origin.y, width: lbNVText.frame.width, height: lbNVTextHeight)
        
        let lbNgayCapNhat = UILabel(frame: CGRect(x: lbKHName.frame.origin.x, y: lbNVText.frame.origin.y + lbNVTextHeight, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbNgayCapNhat.text = "Ngày cập nhật:"
        lbNgayCapNhat.font = UIFont.systemFont(ofSize: 14)
        lbNgayCapNhat.textColor = .lightGray
        scrollView.addSubview(lbNgayCapNhat)
        
        let lbNgayCapNhatText = UILabel(frame: CGRect(x: lbNgayCapNhat.frame.origin.x + lbNgayCapNhat.frame.width, y: lbNgayCapNhat.frame.origin.y, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbNgayCapNhatText.text = "\(itemDetail?.createtime ?? "")"
        lbNgayCapNhatText.font = UIFont.systemFont(ofSize: 14)
        lbNgayCapNhatText.textAlignment = .right
        scrollView.addSubview(lbNgayCapNhatText)
        
        let lbStatus = UILabel(frame: CGRect(x: lbKHName.frame.origin.x, y: lbNgayCapNhatText.frame.origin.y + lbNgayCapNhatText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbStatus.text = "Tình trạng:"
        lbStatus.font = UIFont.systemFont(ofSize: 14)
        lbStatus.textColor = .lightGray
        scrollView.addSubview(lbStatus)
        
        let lbStatusText = UILabel(frame: CGRect(x: lbStatus.frame.origin.x + lbStatus.frame.width, y: lbStatus.frame.origin.y, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbStatusText.text = "\(itemDetail?.status ?? "")"
        lbStatusText.font = UIFont.systemFont(ofSize: 14)
        lbStatusText.textAlignment = .right
        lbStatusText.textColor = .red
        scrollView.addSubview(lbStatusText)
        
        let viewChooseCMND = UIView(frame: CGRect(x: 0, y: lbStatusText.frame.origin.y + lbStatusText.frame.height + Common.Size(s: 10), width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewChooseCMND.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        scrollView.addSubview(viewChooseCMND)
        
        let lbChooseCMND = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewChooseCMND.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbChooseCMND.text = "CHỌN LOẠI GIẤY TỜ"
        lbChooseCMND.font = UIFont.boldSystemFont(ofSize: 15)
        lbChooseCMND.textColor = UIColor(netHex: 0x109e59)
        viewChooseCMND.addSubview(lbChooseCMND)
        
        let imgCMND = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: viewChooseCMND.frame.origin.y + viewChooseCMND.frame.height + Common.Size(s: 10), width: Common.Size(s: 16), height: Common.Size(s: 16)))
        imgCMND.contentMode = .scaleAspectFit
        imgCMND.image = #imageLiteral(resourceName: "Check-1")
        scrollView.addSubview(imgCMND)
        
        let lbTypeCMND = UILabel(frame: CGRect(x: imgCMND.frame.origin.x + imgCMND.frame.width + Common.Size(s: 5), y: imgCMND.frame.origin.y - Common.Size(s: 2), width: (scrollView.frame.width - Common.Size(s: 30))/2 - Common.Size(s: 25), height: Common.Size(s: 20)))
        lbTypeCMND.text = "CMND"
        lbTypeCMND.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbTypeCMND)
        
        let imgCanCuoc = UIImageView(frame: CGRect(x: lbTypeCMND.frame.origin.x + lbTypeCMND.frame.width, y: imgCMND.frame.origin.y, width: Common.Size(s: 16), height: Common.Size(s: 16)))
        imgCanCuoc.contentMode = .scaleAspectFit
        imgCanCuoc.image = #imageLiteral(resourceName: "Check-1")
        scrollView.addSubview(imgCanCuoc)
        
        let lbTypeCanCuoc = UILabel(frame: CGRect(x: imgCanCuoc.frame.origin.x + imgCanCuoc.frame.width + Common.Size(s: 5), y: lbTypeCMND.frame.origin.y, width: lbTypeCMND.frame.width, height: Common.Size(s: 20)))
        lbTypeCanCuoc.text = "Căn cước"
        lbTypeCanCuoc.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbTypeCanCuoc)
        
        if self.itemDetail?.typecard == 1 {
            imgCMND.image = #imageLiteral(resourceName: "Checked")
        } else if self.itemDetail?.typecard == 2 {
            imgCanCuoc.image = #imageLiteral(resourceName: "Checked")
        }
        
        let viewCustomerImage = UIView(frame: CGRect(x: 0, y: lbTypeCanCuoc.frame.origin.y + lbTypeCanCuoc.frame.size.height + Common.Size(s:10), width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewCustomerImage.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        scrollView.addSubview(viewCustomerImage)
        
        let lbCustomerImage = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewCustomerImage.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbCustomerImage.text = "HÌNH ẢNH CẬP NHẬT"
        lbCustomerImage.font = UIFont.boldSystemFont(ofSize: 15)
        lbCustomerImage.textColor = UIColor(netHex: 0x109e59)
        viewCustomerImage.addSubview(lbCustomerImage)
        
        let imgPhotoCMNDMatTruoc = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: viewCustomerImage.frame.origin.y + viewCustomerImage.frame.size.height + Common.Size(s:8), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 150)))
        imgPhotoCMNDMatTruoc.image = #imageLiteral(resourceName: "UploadImage")
        imgPhotoCMNDMatTruoc.contentMode = .scaleAspectFit
        imgPhotoCMNDMatTruoc.layer.borderWidth = 1
        imgPhotoCMNDMatTruoc.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).cgColor
        scrollView.addSubview(imgPhotoCMNDMatTruoc)
        
        let imgPhotoCMNDMatSau = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: imgPhotoCMNDMatTruoc.frame.origin.y + imgPhotoCMNDMatTruoc.frame.size.height + Common.Size(s:8), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 150)))
        imgPhotoCMNDMatSau.image = #imageLiteral(resourceName: "UploadImage")
        imgPhotoCMNDMatSau.contentMode = .scaleAspectFit
        imgPhotoCMNDMatSau.layer.borderWidth = 1
        imgPhotoCMNDMatSau.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).cgColor
        scrollView.addSubview(imgPhotoCMNDMatSau)
        
        scrollViewHeight = imgPhotoCMNDMatSau.frame.origin.y + imgPhotoCMNDMatSau.frame.height + ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height) + Common.Size(s:30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        
        //show img cmnd mat trước
        guard let urlImgCMNDMatTruoc = URL(string: "\(itemDetail?.url_mattruoc ?? "")") else {
            imgPhotoCMNDMatTruoc.image = #imageLiteral(resourceName: "UploadImage")
            return
        }
        
        //show img cmnd mat sau
        guard let urlImgCMNDMatSau = URL(string: "\(itemDetail?.url_matsau ?? "")") else {
            imgPhotoCMNDMatSau.image = #imageLiteral(resourceName: "UploadImage")
            return
        }
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                imgPhotoCMNDMatTruoc.image = self.setImageContent(urlImage: urlImgCMNDMatTruoc)
                imgPhotoCMNDMatSau.image = self.setImageContent(urlImage: urlImgCMNDMatSau)
            }
        }
    }
    
    func setImageContent(urlImage: URL) -> UIImage {
        if let data = try? Data(contentsOf: urlImage) {
            if let image = UIImage(data: data) {
                return image
            } else {
                return #imageLiteral(resourceName: "UploadImage")
            }
        } else {
            return #imageLiteral(resourceName: "UploadImage")
        }
    }
}
