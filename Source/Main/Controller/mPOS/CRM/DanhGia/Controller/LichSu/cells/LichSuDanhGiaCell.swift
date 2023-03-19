//
//  LaprapPCCell.swift
//  fptshop
//
//  Created by Sang Truong on 10/7/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class LichSuDanhGiaCell: UITableViewCell {
	@IBOutlet weak var mainView: UIView!

    @IBOutlet weak var loadDanhGiaLabel: UILabel!
    @IBOutlet weak var danhGiaUserLabel: UILabel!
    @IBOutlet weak var phongbanLabel: UILabel!
    @IBOutlet weak var chucDanhLabel: UILabel!
	@IBOutlet weak var ngayDanhGiaLabel: UILabel!
	@IBOutlet weak var sangKienTitleLabel: UILabel!
	@IBOutlet weak var danhGiaStackView: UIStackView!
	@IBOutlet weak var widthSangKienTitleLabel: NSLayoutConstraint!

	override func awakeFromNib() {
        super.awakeFromNib()
		contentView.backgroundColor = .clear
		mainView.dropShadowV2()

    }
	func bindCellChuyenCan(item:SearchHistoryEveluateModel) {
		self.danhGiaStackView.isHidden = false
		self.widthSangKienTitleLabel.constant = 140
		self.sangKienTitleLabel.text = "Đánh giá user"
		self.loadDanhGiaLabel.text = item.loaiDanhGia ?? ""
		self.danhGiaUserLabel.text = item.danhGiaUser ?? ""
		self.phongbanLabel.text = item.phongBan ?? ""
		self.chucDanhLabel.text = item.chucDanh ?? ""
		self.ngayDanhGiaLabel.text = item.ngayDanhGia ?? ""
	}
	func bindCellSangKien(item:SearchHistoryEveluateModel) {
		self.widthSangKienTitleLabel.constant = 200
		self.danhGiaStackView.isHidden = true
		self.sangKienTitleLabel.text = "User ra sáng kiến"
		self.danhGiaUserLabel.text = item.danhGiaUser ?? ""
		self.phongbanLabel.text = item.phongBan ?? ""
		self.chucDanhLabel.text = item.chucDanh ?? ""
		self.ngayDanhGiaLabel.text = item.ngayDanhGia ?? ""
	}

    
}

