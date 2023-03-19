//
//  DetailVanDonViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 8/27/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DetailVanDonViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var tabType = ""
    var itemGNNB: GNNB_GetTransport?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Chi tiết vận đơn"
        self.view.backgroundColor = .white

        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let iconLeft = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 8), width: Common.Size(s: 25), height: Common.Size(s: 25)))
        iconLeft.image = #imageLiteral(resourceName: "icons8-box-100")
        iconLeft.contentMode = .scaleToFill
        scrollView.addSubview(iconLeft)
        
        let lbMaVanDonText = UILabel(frame: CGRect(x: iconLeft.frame.origin.x + iconLeft.frame.width + Common.Size(s: 5), y: iconLeft.frame.origin.y, width: scrollView.frame.width - Common.Size(s: 100) - Common.Size(s: 40), height: Common.Size(s: 25)))
        lbMaVanDonText.text = "Mã vận đơn: \(self.itemGNNB?.billCode ?? "")"
        lbMaVanDonText.font = UIFont.boldSystemFont(ofSize: 15)
        lbMaVanDonText.textColor = UIColor(netHex: 0x27ae60)
        scrollView.addSubview(lbMaVanDonText)
        
        let lbShopNhan = UILabel(frame: CGRect(x: iconLeft.frame.origin.x + (iconLeft.frame.width/2) + Common.Size(s: 5), y: lbMaVanDonText.frame.origin.y + lbMaVanDonText.frame.height, width: Common.Size(s: 80), height: Common.Size(s: 20)))
        lbShopNhan.text = "Shop nhận: "
        lbShopNhan.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbShopNhan)
        
        let lbShopNhanText = UILabel(frame: CGRect(x: lbShopNhan.frame.origin.x + lbShopNhan.frame.width, y: lbShopNhan.frame.origin.y, width: scrollView.frame.width - Common.Size(s: 85) - (lbShopNhan.frame.origin.x + lbShopNhan.frame.width), height: Common.Size(s: 20)))
        lbShopNhanText.text = "\(self.itemGNNB?.shopName_Re ?? "")"
        lbShopNhanText.font = UIFont.systemFont(ofSize: 14)
        lbShopNhanText.textColor = UIColor.lightGray
        scrollView.addSubview(lbShopNhanText)
        
        let lbShopNhanTextHeight: CGFloat = lbShopNhanText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbShopNhanText.optimalHeight + Common.Size(s: 5))
        lbShopNhanText.numberOfLines = 0
        lbShopNhanText.frame = CGRect(x: lbShopNhanText.frame.origin.x, y: lbShopNhanText.frame.origin.y, width: lbShopNhanText.frame.width, height: lbShopNhanTextHeight)
        
        let lbShopXuat = UILabel(frame: CGRect(x: lbShopNhan.frame.origin.x, y: lbShopNhanText.frame.origin.y + lbShopNhanTextHeight, width: lbShopNhan.frame.width, height: Common.Size(s: 20)))
        lbShopXuat.text = "Shop xuất: "
        lbShopXuat.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbShopXuat)
        
        let lbShopXuatText = UILabel(frame: CGRect(x: lbShopNhanText.frame.origin.x, y: lbShopXuat.frame.origin.y, width: lbShopNhanText.frame.width, height: Common.Size(s: 20)))
        lbShopXuatText.text = "\(self.itemGNNB?.shopName_Ex ?? "")"
        lbShopXuatText.font = UIFont.systemFont(ofSize: 14)
        lbShopXuatText.textColor = UIColor.lightGray
        scrollView.addSubview(lbShopXuatText)
        
        let lbShopXuatTextHeight: CGFloat = lbShopXuatText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbShopXuatText.optimalHeight + Common.Size(s: 5))
        lbShopXuatText.numberOfLines = 0
        lbShopXuatText.frame = CGRect(x: lbShopXuatText.frame.origin.x, y: lbShopXuatText.frame.origin.y, width: lbShopXuatText.frame.width, height: lbShopXuatTextHeight)
        
        let lbNgayTao = UILabel(frame: CGRect(x: lbShopNhan.frame.origin.x, y: lbShopXuatText.frame.origin.y + lbShopXuatTextHeight, width: lbShopNhan.frame.width, height: Common.Size(s: 20)))
        lbNgayTao.text = "Ngày tạo: "
        lbNgayTao.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbNgayTao)

        let lbNgayTaoText = UILabel(frame: CGRect(x: lbShopNhanText.frame.origin.x, y: lbNgayTao.frame.origin.y, width: lbShopNhanText.frame.width, height: Common.Size(s: 20)))
//        lbNgayTaoText.text = "\(self.convertDate(dateString: itemGNNB?.createDateTime ?? ""))"
        lbNgayTaoText.text = "\(itemGNNB?.createDateTime ?? "")"
        lbNgayTaoText.font = UIFont.systemFont(ofSize: 14)
        lbNgayTaoText.textColor = UIColor.lightGray
        scrollView.addSubview(lbNgayTaoText)
        
        let lbNgayGiao = UILabel(frame: CGRect(x: lbShopNhan.frame.origin.x, y: lbNgayTaoText.frame.origin.y + lbNgayTaoText.frame.height, width: lbShopNhan.frame.width, height: Common.Size(s: 20)))
        lbNgayGiao.text = "Ngày giao: "
        lbNgayGiao.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(lbNgayGiao)
        
        let lbNgayGiaoText = UILabel(frame: CGRect(x: lbShopNhanText.frame.origin.x, y: lbNgayGiao.frame.origin.y, width: lbShopNhanText.frame.width, height: Common.Size(s: 20)))
//        lbNgayGiaoText.text = "\(self.convertDate(dateString: itemGNNB?.shipDateTime ?? ""))"
        lbNgayGiaoText.text = "\(itemGNNB?.shipDateTime ?? "")"
        lbNgayGiaoText.font = UIFont.systemFont(ofSize: 14)
        lbNgayGiaoText.textColor = UIColor.lightGray
        scrollView.addSubview(lbNgayGiaoText)
        
        let lbGiaoHang = UILabel(frame: CGRect(x: lbShopNhan.frame.origin.x, y: lbNgayGiaoText.frame.origin.y + lbNgayGiaoText.frame.height, width: lbShopNhan.frame.width, height: Common.Size(s: 20)))
        lbGiaoHang.text = "Giao hàng: "
        lbGiaoHang.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbGiaoHang)

        let lbGiaoHangText = UILabel(frame: CGRect(x: lbShopNhanText.frame.origin.x, y: lbGiaoHang.frame.origin.y, width: lbShopNhanText.frame.width, height: Common.Size(s: 20)))
        lbGiaoHangText.text = "\(self.itemGNNB?.transporterName ?? "")"
        lbGiaoHangText.font = UIFont.systemFont(ofSize: 14)
        lbGiaoHangText.textColor = UIColor.lightGray
        scrollView.addSubview(lbGiaoHangText)

        let lbGiaoHangTextHeight: CGFloat = lbGiaoHangText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbGiaoHangText.optimalHeight + Common.Size(s: 5))
        lbGiaoHangText.numberOfLines = 0
        lbGiaoHangText.frame = CGRect(x: lbGiaoHangText.frame.origin.x, y: lbGiaoHangText.frame.origin.y, width: lbGiaoHangText.frame.width, height: lbGiaoHangTextHeight)
        
        let lbNguoiVC = UILabel(frame: CGRect(x: lbShopNhan.frame.origin.x, y: lbGiaoHangText.frame.origin.y + lbGiaoHangTextHeight, width: lbShopNhan.frame.width + Common.Size(s: 30), height: Common.Size(s: 20)))
        lbNguoiVC.text = "Người vận chuyển: "
        lbNguoiVC.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbNguoiVC)
        
        let lbNguoiVanChuyenText = UILabel(frame: CGRect(x: lbNguoiVC.frame.origin.x + lbNguoiVC.frame.width, y: lbNguoiVC.frame.origin.y, width: scrollView.frame.width - lbNguoiVC.frame.origin.x - lbNguoiVC.frame.width - Common.Size(s: 10), height: Common.Size(s: 20)))
        lbNguoiVanChuyenText.text = "\(self.itemGNNB?.shiperName ?? "")"
        lbNguoiVanChuyenText.font = UIFont.systemFont(ofSize: 14)
        lbNguoiVanChuyenText.textColor = UIColor.lightGray
        scrollView.addSubview(lbNguoiVanChuyenText)
        
//        let attributed1 = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black]
//        let attributed2 = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]
//        let attributedString1 = NSMutableAttributedString(string:"Người vận chuyển: ", attributes:attributed1)
//        let attributedString2 = NSMutableAttributedString(string:"chưa có ", attributes:attributed2)
//        attributedString1.append(attributedString2)
//        lbNguoiVanChuyenText.attributedText = attributedString1
        
        let lbNguoiVanChuyenTextHeight: CGFloat = lbNguoiVanChuyenText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNguoiVanChuyenText.optimalHeight + Common.Size(s: 5))
        lbNguoiVanChuyenText.numberOfLines = 0
        lbNguoiVanChuyenText.frame = CGRect(x: lbNguoiVanChuyenText.frame.origin.x, y: lbNguoiVanChuyenText.frame.origin.y, width: lbNguoiVanChuyenText.frame.width, height: lbNguoiVanChuyenTextHeight)
        
        //VIEW KIEN HANG
        let viewKienHang = UIView(frame: CGRect(x: scrollView.frame.width - Common.Size(s: 80), y: Common.Size(s: 20), width: Common.Size(s: 70), height: lbNgayTaoText.frame.origin.y + lbNgayTaoText.frame.height))
        viewKienHang.backgroundColor = UIColor(netHex: 0xF8F4F5)
        viewKienHang.layer.cornerRadius = 10
        scrollView.addSubview(viewKienHang)
        
        let lbKienHangText = UILabel(frame: CGRect(x: 0, y: 0, width: viewKienHang.frame.width, height: viewKienHang.frame.height))
        lbKienHangText.text = "\(itemGNNB?.binTotal ?? 0)\nkiện"
        lbKienHangText.numberOfLines = 2
        lbKienHangText.textAlignment = .center
        lbKienHangText.textColor = UIColor(netHex: 0x6fcf97)
        lbKienHangText.font = UIFont.boldSystemFont(ofSize: 15)
        viewKienHang.addSubview(lbKienHangText)
        
        //status
        let viewStatus = UIView(frame: CGRect(x: scrollView.frame.width - Common.Size(s: 80), y: Common.Size(s: 5), width: Common.Size(s: 70), height: Common.Size(s: 30)))
        viewStatus.backgroundColor = UIColor(netHex: 0x6fcf97)
        viewStatus.layer.cornerRadius = 15
        scrollView.addSubview(viewStatus)
        
        let lbStatus = UILabel(frame: CGRect(x: 0, y: 0, width: viewStatus.frame.width, height: viewStatus.frame.height))
        lbStatus.text = "Đã nhận"
        lbStatus.textAlignment = .center
        lbStatus.font = UIFont.systemFont(ofSize: 14)
        lbStatus.textColor = UIColor.white
        viewStatus.addSubview(lbStatus)
        
        let line = UIView(frame: CGRect(x: iconLeft.frame.origin.x + iconLeft.frame.width/2 - Common.Size(s: 2), y: iconLeft.frame.origin.y + iconLeft.frame.height + Common.Size(s: 2), width: Common.Size(s: 1), height: lbNguoiVanChuyenText.frame.origin.y + lbNguoiVanChuyenText.frame.height - (iconLeft.frame.origin.y + iconLeft.frame.height)))
        line.backgroundColor = UIColor.lightGray
        scrollView.addSubview(line)
        
        //lich su
        //chờ giao
        let iconChoGiao = UIImageView(frame: CGRect(x: Common.Size(s: 16), y: line.frame.origin.y + line.frame.height + Common.Size(s: 2), width: Common.Size(s: 20), height: Common.Size(s: 20)))
        iconChoGiao.image = #imageLiteral(resourceName: "mdi_check_circle_or")
        iconChoGiao.contentMode = .scaleToFill
        scrollView.addSubview(iconChoGiao)
        
        let lbChoGiao = UILabel(frame: CGRect(x: lbMaVanDonText.frame.origin.x, y: iconChoGiao.frame.origin.y, width: lbMaVanDonText.frame.width, height: Common.Size(s: 20)))
        lbChoGiao.text = "Chờ giao"
        lbChoGiao.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbChoGiao)
        
        let lbChoGiaoDate = UILabel(frame: CGRect(x: lbChoGiao.frame.origin.x, y: lbChoGiao.frame.origin.y + lbChoGiao.frame.height, width: lbChoGiao.frame.width, height: Common.Size(s: 20)))
        lbChoGiaoDate.text = ""
        lbChoGiaoDate.font = UIFont.italicSystemFont(ofSize: 12)
        lbChoGiaoDate.textColor = UIColor.lightGray
        scrollView.addSubview(lbChoGiaoDate)
        
        // đã giao
        let iconDaGiao = UIImageView(frame: CGRect(x: Common.Size(s: 16), y: lbChoGiaoDate.frame.origin.y + lbChoGiaoDate.frame.height + Common.Size(s: 5), width: Common.Size(s: 20), height: Common.Size(s: 20)))
        iconDaGiao.image = #imageLiteral(resourceName: "mdi_check_circle_bl")
        iconDaGiao.contentMode = .scaleToFill
        scrollView.addSubview(iconDaGiao)
        
        let lbDaGiao = UILabel(frame: CGRect(x: lbMaVanDonText.frame.origin.x, y: iconDaGiao.frame.origin.y, width: lbMaVanDonText.frame.width, height: Common.Size(s: 20)))
        lbDaGiao.text = "Đã giao"
        lbDaGiao.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbDaGiao)
        
        let lbDaGiaoDate = UILabel(frame: CGRect(x: lbDaGiao.frame.origin.x, y: lbDaGiao.frame.origin.y + lbDaGiao.frame.height, width: lbDaGiao.frame.width, height: Common.Size(s: 20)))
        lbDaGiaoDate.text = ""
        lbDaGiaoDate.font = UIFont.italicSystemFont(ofSize: 12)
        lbDaGiaoDate.textColor = UIColor.lightGray
        scrollView.addSubview(lbDaGiaoDate)
        
        let line1 = UIView(frame: CGRect(x: line.frame.origin.x, y: iconChoGiao.frame.origin.y + iconChoGiao.frame.height + Common.Size(s: 1), width: Common.Size(s: 1), height: iconDaGiao.frame.origin.y - iconChoGiao.frame.origin.y - iconChoGiao.frame.height - Common.Size(s: 3)))
        line1.backgroundColor = UIColor.lightGray
        scrollView.addSubview(line1)
        
        //đã nhận
        let iconDaNhan = UIImageView(frame: CGRect(x: Common.Size(s: 16), y: lbDaGiaoDate.frame.origin.y + lbDaGiaoDate.frame.height + Common.Size(s: 5), width: Common.Size(s: 20), height: Common.Size(s: 20)))
        iconDaNhan.image = #imageLiteral(resourceName: "CheckMark")
        iconDaNhan.contentMode = .scaleToFill
        scrollView.addSubview(iconDaNhan)
        
        let lbDaNhan = UILabel(frame: CGRect(x: lbMaVanDonText.frame.origin.x, y: iconDaNhan.frame.origin.y, width: lbMaVanDonText.frame.width, height: Common.Size(s: 20)))
        lbDaNhan.text = "Đã nhận"
        lbDaNhan.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbDaNhan)
        
        let lbDaNhanDate = UILabel(frame: CGRect(x: lbDaNhan.frame.origin.x, y: lbDaNhan.frame.origin.y + lbDaNhan.frame.height, width: lbDaNhan.frame.width, height: Common.Size(s: 20)))
        lbDaNhanDate.text = ""
        lbDaNhanDate.font = UIFont.italicSystemFont(ofSize: 12)
        lbDaNhanDate.textColor = UIColor.lightGray
        scrollView.addSubview(lbDaNhanDate)
        
        let line2 = UIView(frame: CGRect(x: line.frame.origin.x, y: iconDaGiao.frame.origin.y + iconDaGiao.frame.height + Common.Size(s: 1), width: Common.Size(s: 1), height: iconDaNhan.frame.origin.y - iconDaGiao.frame.origin.y - iconDaGiao.frame.height - Common.Size(s: 3)))
        line2.backgroundColor = UIColor.lightGray
        scrollView.addSubview(line2)
        
        let line3 = UIView(frame: CGRect(x: line.frame.origin.x, y: iconDaNhan.frame.origin.y + iconDaNhan.frame.height + Common.Size(s: 1), width: Common.Size(s: 1), height:Common.Size(s: 40)))
        line3.backgroundColor = UIColor.lightGray
        scrollView.addSubview(line3)
        
        scrollViewHeight = line3.frame.origin.y + line3.frame.height + ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height) + Common.Size(s:30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        switch self.tabType {
        case "1":
            viewStatus.backgroundColor = UIColor(netHex: 0xd5c1b6)
            lbStatus.text = "Chờ giao"
            lbKienHangText.textColor = UIColor(netHex: 0xd5c1b6)
            iconChoGiao.image = #imageLiteral(resourceName: "mdi_check_circle_or")
            lbChoGiaoDate.text = "\(itemGNNB?.createDateTime ?? "")"
            
            iconDaGiao.image = #imageLiteral(resourceName: "mdi_check_circle_bl_2")
            lbDaGiaoDate.text = ""
            
            iconDaNhan.image = #imageLiteral(resourceName: "mdi_check_circle_gr")
            lbDaNhanDate.text = ""
            break
        case "2":
            viewStatus.backgroundColor = UIColor(netHex: 0x56ccf2)
            lbStatus.text = "Đã giao"
            lbKienHangText.textColor = UIColor(netHex: 0x56ccf2)
            
            iconChoGiao.image = #imageLiteral(resourceName: "mdi_check_circle_or")
            lbChoGiaoDate.text = "\(itemGNNB?.createDateTime ?? "")"
            
            iconDaGiao.image = #imageLiteral(resourceName: "mdi_check_circle_bl")
            lbDaGiaoDate.text = "\(itemGNNB?.shipDateTime ?? "")"
            
            iconDaNhan.image = #imageLiteral(resourceName: "mdi_check_circle_gr")
            lbDaNhanDate.text = ""
            break
        case "3":
            viewStatus.backgroundColor = UIColor(netHex: 0x6fcf97)
            lbStatus.text = "Đã nhận"
            lbKienHangText.textColor = UIColor(netHex: 0x6fcf97)
            
            iconChoGiao.image = #imageLiteral(resourceName: "mdi_check_circle_or")
            lbChoGiaoDate.text = "\(itemGNNB?.createDateTime ?? "")"
            
            iconDaGiao.image = #imageLiteral(resourceName: "mdi_check_circle_bl")
            lbDaGiaoDate.text = "\(itemGNNB?.shipDateTime ?? "")"
            
            iconDaNhan.image = #imageLiteral(resourceName: "CheckMark")
            lbDaNhanDate.text = "\(itemGNNB?.receiveDateTime ?? "")"
            break
        default:
            viewStatus.backgroundColor = UIColor(netHex: 0xd5c1b6)
            lbKienHangText.textColor = UIColor(netHex: 0xd5c1b6)
            
            iconChoGiao.image = #imageLiteral(resourceName: "mdi_check_circle_or_2")
            lbChoGiaoDate.text = ""
            
            iconDaGiao.image = #imageLiteral(resourceName: "mdi_check_circle_bl_2")
            lbDaGiaoDate.text = ""
            
            iconDaNhan.image = #imageLiteral(resourceName: "mdi_check_circle_gr")
            lbDaNhanDate.text = ""
            break
        }
    }

    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func convertDate(dateString: String) -> String {
        if !(dateString.isEmpty) {
            let dateStrOld = dateString
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            let date2 = formatter.date(from: dateStrOld)

            let newFormatter = DateFormatter()
            newFormatter.locale = Locale(identifier: "vi_VN");
            newFormatter.timeZone = TimeZone(identifier: "UTC");
            newFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            let str = newFormatter.string(from: date2 ?? Date())
            return str
        } else {
            return dateString
        }
    }
}
