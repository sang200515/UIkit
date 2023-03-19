//
//  WaitForDeliveryCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 10/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class WaitForDeliveryCell: UITableViewCell {
    
    @IBOutlet weak var thoiGianGiaoLabel: UILabel!
    @IBOutlet weak var maVanDonLabel: UILabel!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var orderNumLabel: UILabel!
    @IBOutlet weak var ecomNumLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cusNameLabel: UILabel!
    @IBOutlet weak var cusAddressLabel: UILabel!
    @IBOutlet weak var orderTypebel: UILabel!
    @IBOutlet weak var emPloyDeliveryLbl: UILabel!
    @IBOutlet weak var deliveyPersonLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var smLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var timeExpectLabel: UILabel!
    @IBOutlet weak var bottomStattusLbl: UILabel!
    @IBOutlet weak var heightAddress: NSLayoutConstraint!
    @IBOutlet weak var heightNote: NSLayoutConstraint!
    @IBOutlet weak var orderIcon: UIImageView!
    @IBOutlet weak var shiperInfoStack: UIStackView!
    @IBOutlet weak var shipperNameLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var timePickingLbl: UILabel!
    @IBOutlet weak var timeTitleLabel: UILabel!
    @IBOutlet weak var statusOrderBtn: UIButton!
    @IBOutlet weak var shopGiaohoLbl: UILabel!
    @IBOutlet weak var shopXuatLbl: UILabel!
    @IBOutlet weak var giaohoStack: UIStackView!
    
    var onOpenLink:(()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func openLink() {
        if let open = onOpenLink {
            open()
        }
    }
    
    func bindCell(item:GetSOByUserResult,timeExpct: String) {
        giaohoStack.isHidden = item.MaShopNhoGiaoHang.isEmpty
        shopXuatLbl.text = item.p_ShopXuat
        shopGiaohoLbl.text = item.p_ShopGiaoHo
        var icon = "ic_fpt_new"
        
        if item.Partner_code.lowercased() == "grab" {
            icon = "ic_gab_new"
        }
        if item.Partner_code.lowercased() == "ahamove" {
            icon = "ic_ahamove"
        }
        
        orderIcon.image = UIImage(named: icon)
        deliveyPersonLabel.text = item.p_NguoiGiao
        statusLabel.text = item.p_TrangThaiGiaoHang
        
        smLabel.text = item.SM_ChiuTrachNhiem
        orderNumLabel.text = "ĐH :\(item.DocEntry)"
        ecomNumLabel.text = "Ecom :\(item.U_NumEcom)"
        
        timeLabel.text = item.CreateDateTime.toNewStrDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss", newFormat: "dd/MM/yyyy HH:mm")
        if(item.p_TrangThaiDonHang != "") {
            self.viewStatus.isHidden = false
            bottomStattusLbl.isHidden = false
            bottomStattusLbl.text = item.p_TrangThaiDonHang
        } else {
            bottomStattusLbl.isHidden = true
            self.viewStatus.isHidden = true
        }

//        if item.p_TrangThaiDonHang.lowercased() == "chưa xác nhận thủ kho" {
//            bottomStattusLbl.backgroundColor = UIColor(netHex:0x00b16f)
//        } else {
//            bottomStattusLbl.backgroundColor = UIColor(red: 201, green: 1, blue: 27)
//        }
        self.viewStatus.backgroundColor = UIColor.mainGreen
        let noteHeight = item.U_Desc.height(withConstrainedWidth: noteLabel.frame.width, font: noteLabel.font)
        heightNote.constant = noteHeight + 10
        noteLabel.text = item.U_Desc
        cusNameLabel.text = item.U_CrdName
        statusOrderBtn.setTitleColor(UIColor(netHex:0x007ADF), for: .normal)
        statusOrderBtn.underline()
        statusOrderBtn.isHidden = item.p_ThongTinNCC_URLTracking == "" 
        if item.p_ThongTinNCC_TaiXe_Ten != "" && item.Partner_code.lowercased() == "grab" || item.p_ThongTinNCC_TaiXe_Ten != "" && item.Partner_code.lowercased() == "ahamove" {
            shiperInfoStack.isHidden = false
            shipperNameLbl.text = "Tài xế: \(item.p_ThongTinNCC_TaiXe_Ten)"
            phoneLbl.text = "SĐT: \(item.p_ThongTinNCC_TaiXe_SDT)"
            if item.p_ThongTinNCC_TaiXe_ThoiGianDenShop != "" {
                timePickingLbl.text = item.p_ThongTinNCC_TaiXe_ThoiGianDenShop
            } else {
                timePickingLbl.text = "----"
            }
        } else {
            shiperInfoStack.isHidden = true
        }
        let address = item.p_ThongTinNguoiNhan_Address
        var height = address.height(withConstrainedWidth: cusAddressLabel.frame.width, font: cusNameLabel.font) + 10
        if height < 67 && item.p_ThongTinNCC_TaiXe_Ten != "" {
            height = 70
        }
        heightAddress.constant = height
        cusAddressLabel.text = address
        orderTypebel.text = item.p_LoaiDonHang
        emPloyDeliveryLbl.text = item.EmpName
        timeExpectLabel.text = timeExpct
        timeExpectLabel.textColor = UIColor(netHex:0x00b16f)
        if(timeExpectLabel.text!.range(of:"Trễ") != nil) {
            timeExpectLabel.textColor = UIColor.red
        }
        self.viewStatus.layer.cornerRadius = self.viewStatus.frame.height / 2
        self.maVanDonLabel.text = item.p_ThongTinNCC_Delivery_Id == "" ? "---" : item.p_ThongTinNCC_Delivery_Id
    }
    
    func bindCellDagiao(item:GetSOByUserResult) {
        giaohoStack.isHidden = item.MaShopNhoGiaoHang.isEmpty
        shopXuatLbl.text = item.p_ShopXuat
        shopGiaohoLbl.text = item.p_ShopGiaoHo
        timeExpectLabel.text = ""
        var icon = "ic_fpt_new"
        
        if item.Partner_code.lowercased() == "grab" {
            icon = "ic_gab_new"
        }
        if item.Partner_code.lowercased() == "ahamove" {
            icon = "ic_ahamove"
        }
        
        orderIcon.image = UIImage(named: icon)

        deliveyPersonLabel.text = item.p_NguoiGiao
        statusLabel.text = item.p_TrangThaiGiaoHang
//        bottomStattusLbl.text = "Đơn hàng bị từ chối"
        smLabel.text = item.SM_ChiuTrachNhiem
        let noteHeight = item.U_Desc.height(withConstrainedWidth: noteLabel.frame.width, font: noteLabel.font)
        heightNote.constant = noteHeight + 10
        noteLabel.text = item.U_Desc
        if (item.OrderStatus == "3" && item.ReturnReason != ""){
//            bottomStattusLbl.text = "Đơn hàng bị từ chối"
            timeExpectLabel.text = "Chưa trả hàng"
            timeExpectLabel.textColor = UIColor.red
            let noteHeight = item.ReturnReason.height(withConstrainedWidth: noteLabel.frame.width, font: noteLabel.font)
            heightNote.constant = noteHeight + 10
            noteLabel.text = "\(item.ReturnReason)"
        }
        if item.OrderStatus == "5" || item.OrderStatus == "6" {
//            bottomStattusLbl.text = "Giao thành công"
//            bottomStattusLbl.backgroundColor = UIColor(netHex:0x00b16f)
            if(item.OrderStatus == "5")
            {
                //cellMainDaNhan?.txtValueGhiChu.text = "Chưa xác nhận thu tiền"
                timeExpectLabel.text = "Chưa xác nhận thu tiền"
                timeExpectLabel.textColor = UIColor.red
            }
            if(item.OrderStatus == "6")
            {
                timeExpectLabel.text = "Đã xác nhận thu tiền"
            }
        }
        orderNumLabel.text = "ĐH :\(item.DocEntry)"
        ecomNumLabel.text = "Ecom :\(item.U_NumEcom)"

        timeLabel.text = item.CreateDateTime.toNewStrDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss", newFormat: "dd/MM/yyyy HH:mm")
        cusNameLabel.text = item.U_CrdName
        statusOrderBtn.setTitleColor(UIColor(netHex:0x007ADF), for: .normal)
        statusOrderBtn.underline()
        statusOrderBtn.isHidden = item.p_ThongTinNCC_URLTracking == ""
        if item.p_ThongTinNCC_TaiXe_Ten != "" && item.Partner_code.lowercased() == "grab" || item.p_ThongTinNCC_TaiXe_Ten != "" && item.Partner_code.lowercased() == "ahamove" {
            shiperInfoStack.isHidden = false
            shipperNameLbl.text = "Tài xế: \(item.p_ThongTinNCC_TaiXe_Ten)"
            phoneLbl.text = "SĐT: \(item.p_ThongTinNCC_TaiXe_SDT)"
            if item.p_ThongTinNCC_TaiXe_ThoiGianDenShop != "" {
                timePickingLbl.text = item.p_ThongTinNCC_TaiXe_ThoiGianDenShop
            } else {
                timePickingLbl.text = "----"
            }
        } else {
            shiperInfoStack.isHidden = true
        }
        let address = item.U_AdrDel_New != "" ? item.U_AdrDel_New : item.U_AdrDel
        var height = address.height(withConstrainedWidth: cusAddressLabel.frame.width, font: cusNameLabel.font) + 10
        if height < 67 && item.p_ThongTinNCC_TaiXe_Ten != "" {
            height = 70
        }
        heightAddress.constant = height
        cusAddressLabel.text = address
        orderTypebel.text = item.p_LoaiDonHang
        emPloyDeliveryLbl.text = item.EmpName
        if(item.p_TrangThaiDonHang != "") {
            bottomStattusLbl.text = item.p_TrangThaiDonHang
            self.viewStatus.backgroundColor = item.p_TrangThaiDonHang == "Đơn hàng bị từ chối" ? .red : UIColor(netHex:0x00b16f)
        } else {
            bottomStattusLbl.isHidden = true
            self.viewStatus.isHidden = true
        }
        self.viewStatus.layer.cornerRadius = self.viewStatus.frame.height / 2
        self.viewBottom.insertSubview(self.viewStatus, at: 0)
        self.maVanDonLabel.text = item.p_ThongTinNCC_Delivery_Id == "" ? "---" : item.p_ThongTinNCC_Delivery_Id
        self.thoiGianGiaoLabel.text = item.FinishTime == "" ? "-" : item.FinishTime.toNewStrDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS", newFormat: "dd/MM/yyyy HH:mm")
    }
    
}

extension UIButton {
    func underline(text: String = "") {
            let textbutton = text != "" ? text : self.titleLabel?.text ?? ""
            
            let attributedString = NSMutableAttributedString(string: textbutton)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: textbutton.count))
            self.setAttributedTitle(attributedString, for: .normal)

        }
}
