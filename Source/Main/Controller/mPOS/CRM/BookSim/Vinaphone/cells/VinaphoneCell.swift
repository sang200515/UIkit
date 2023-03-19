//
//  VinaphoneCell.swift
//  fptshop
//
//  Created by Sang Trương on 04/01/2023.
//  Copyright © 2023 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
protocol ItemUserVinaphoneTableViewCellDelegate: AnyObject {
	func actionSelectUserVinaphone(item: ActiveSimVinaDataModel)
}
class ItemUserVinaphoneTableViewCell: UITableViewCell {
	var estimateCellHeight:CGFloat = 0
	var itemMSaleVinaphone:ActiveSimVinaDataModel?
	weak var delegate:ItemUserVinaphoneTableViewCellDelegate?
	var totalSum: Double = 0

	func setupCell(tabType: String, item: ActiveSimVinaDataModel){
		self.subviews.forEach({$0.removeFromSuperview()})

		let viewContent = UIView(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: self.contentView.frame.width - Common.Size(s: 10), height: self.frame.height))
		viewContent.backgroundColor = UIColor(netHex: 0xF8F4F5)
		viewContent.layer.cornerRadius = 5
		self.addSubview(viewContent)

		if tabType == "1" {
			let tapAction = UITapGestureRecognizer(target: self, action: #selector(actionCell))
			viewContent.isUserInteractionEnabled = true
			viewContent.addGestureRecognizer(tapAction)
		}

		let lbMposNum = UILabel(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s: 5), width: (viewContent.frame.width - Common.Size(s: 20))/2, height: Common.Size(s: 20)))
		lbMposNum.text = "MPOS: \(item.so_mpos)"
		lbMposNum.font = UIFont.boldSystemFont(ofSize: 15)
		lbMposNum.textColor = UIColor(netHex: 0x109e59)
		viewContent.addSubview(lbMposNum)

		let lbCreateDate = UILabel(frame: CGRect(x: lbMposNum.frame.origin.x + lbMposNum.frame.width, y: Common.Size(s: 5), width: lbMposNum.frame.width, height: Common.Size(s: 20)))
		lbCreateDate.font = UIFont.systemFont(ofSize: 13)
		lbCreateDate.textAlignment = .right
		lbCreateDate.text = "\(item.activedate)"
		viewContent.addSubview(lbCreateDate)

		let line = UIView(frame: CGRect(x: Common.Size(s: 10), y: lbCreateDate.frame.origin.y + lbCreateDate.frame.height + Common.Size(s: 3), width: viewContent.frame.width - Common.Size(s: 20), height: Common.Size(s: 1)))
		line.backgroundColor = .lightGray
		viewContent.addSubview(line)

		let lbKHName = UILabel(frame: CGRect(x: Common.Size(s: 10), y: line.frame.origin.y + line.frame.height + Common.Size(s: 5), width: (line.frame.width)/3 + Common.Size(s: 15), height: Common.Size(s: 20)))
		lbKHName.text = "Tên khách hàng:"
		lbKHName.font = UIFont.systemFont(ofSize: 14)
		lbKHName.textColor = .lightGray
		viewContent.addSubview(lbKHName)
		let lbKHNameText = UILabel(frame: CGRect(x: lbKHName.frame.origin.x + lbKHName.frame.width, y: lbKHName.frame.origin.y, width: (line.frame.width * 2/3) - Common.Size(s: 15), height: Common.Size(s: 20)))
		lbKHNameText.text = "\(item.fullName)"
		lbKHNameText.font = UIFont.systemFont(ofSize: 14)
		lbKHNameText.textAlignment = .right
		viewContent.addSubview(lbKHNameText)

		let lbKHNameTextHeight:CGFloat = lbKHNameText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbKHNameText.optimalHeight + Common.Size(s: 5))
		lbKHNameText.numberOfLines = 0
		lbKHNameText.frame = CGRect(x: lbKHNameText.frame.origin.x, y: lbKHNameText.frame.origin.y, width: lbKHNameText.frame.width, height: lbKHNameTextHeight)

		let lbSdt = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbKHNameText.frame.origin.y + lbKHNameTextHeight, width: lbKHName.frame.width, height: Common.Size(s: 20)))
		lbSdt.text = "SĐT khách hàng:"
		lbSdt.font = UIFont.systemFont(ofSize: 14)
		lbSdt.textColor = .lightGray
		viewContent.addSubview(lbSdt)

		let lbSdtText = UILabel(frame: CGRect(x: lbSdt.frame.origin.x + lbSdt.frame.width, y: lbSdt.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
		lbSdtText.text = "\(item.phonenumber)"
		lbSdtText.font = UIFont.systemFont(ofSize: 14)
		lbSdtText.textAlignment = .right
		viewContent.addSubview(lbSdtText)

		let lbSerial = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbSdtText.frame.origin.y + lbSdtText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
		lbSerial.text = "Serial:"
		lbSerial.font = UIFont.systemFont(ofSize: 14)
		lbSerial.textColor = .lightGray
		viewContent.addSubview(lbSerial)

		let lbSerialText = UILabel(frame: CGRect(x: lbSerial.frame.origin.x + lbSerial.frame.width, y: lbSerial.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
		lbSerialText.text = "\(item.serial)"
		lbSerialText.font = UIFont.systemFont(ofSize: 14)
		lbSerialText.textAlignment = .right
		viewContent.addSubview(lbSerialText)

		let lbCMND = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbSerialText.frame.origin.y + lbSerialText.frame.height, width: lbKHName.frame.width + Common.Size(s: 10), height: Common.Size(s: 20)))
		lbCMND.text = "Số CMND/Căn cước:"
		lbCMND.font = UIFont.systemFont(ofSize: 14)
		lbCMND.textColor = .lightGray
		viewContent.addSubview(lbCMND)

		let lbCMNDText = UILabel(frame: CGRect(x: lbCMND.frame.origin.x + lbCMND.frame.width, y: lbCMND.frame.origin.y, width: lbKHNameText.frame.width - Common.Size(s: 10), height: Common.Size(s: 20)))
		lbCMNDText.text = "\(item.cMND)"
		lbCMNDText.font = UIFont.systemFont(ofSize: 14)
		lbCMNDText.textAlignment = .right
		viewContent.addSubview(lbCMNDText)

		let lbNgayDauNoi = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbCMNDText.frame.origin.y + lbCMNDText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
		lbNgayDauNoi.text = "Ngày đấu nối:"
		lbNgayDauNoi.font = UIFont.systemFont(ofSize: 14)
		lbNgayDauNoi.textColor = .lightGray
		viewContent.addSubview(lbNgayDauNoi)

		let lbNgayDauNoiText = UILabel(frame: CGRect(x: lbNgayDauNoi.frame.origin.x + lbNgayDauNoi.frame.width, y: lbNgayDauNoi.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
		lbNgayDauNoiText.text = "\(item.confirm_date)"
		lbNgayDauNoiText.font = UIFont.systemFont(ofSize: 14)
		lbNgayDauNoiText.textAlignment = .right
		viewContent.addSubview(lbNgayDauNoiText)

//		if tabType == "1" { // chua xac nhan
//			lbNgayDauNoi.isHidden = false
//			lbNgayDauNoiText.isHidden = false
//
//			lbNgayDauNoi.frame = CGRect(x: lbNgayDauNoi.frame.origin.x, y: lbNgayDauNoi.frame.origin.y, width: lbNgayDauNoi.frame.width, height: 0)
//			lbNgayDauNoiText.frame = CGRect(x: lbNgayDauNoiText.frame.origin.x, y: lbNgayDauNoiText.frame.origin.y, width: lbNgayDauNoiText.frame.width, height: 0)
//		} else {
//			lbNgayDauNoi.isHidden = false
//			lbNgayDauNoiText.isHidden = false
//
//			lbNgayDauNoi.frame = CGRect(x: lbNgayDauNoi.frame.origin.x, y: lbNgayDauNoi.frame.origin.y, width: lbNgayDauNoi.frame.width, height: Common.Size(s: 20))
//			lbNgayDauNoiText.frame = CGRect(x: lbNgayDauNoiText.frame.origin.x, y: lbNgayDauNoiText.frame.origin.y, width: lbNgayDauNoiText.frame.width, height: Common.Size(s: 20))
//		}

		let lbNVDauNoi = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbNgayDauNoiText.frame.origin.y + lbNgayDauNoiText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
		lbNVDauNoi.text = "NV đấu nối:"
		lbNVDauNoi.font = UIFont.systemFont(ofSize: 14)
		lbNVDauNoi.textColor = .lightGray
		viewContent.addSubview(lbNVDauNoi)

		let lbNVDauNoiText = UILabel(frame: CGRect(x: lbNVDauNoi.frame.origin.x + lbNVDauNoi.frame.width, y: lbNVDauNoi.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
		lbNVDauNoiText.text = "\(item.userName)"
		lbNVDauNoiText.font = UIFont.systemFont(ofSize: 14)
		lbNVDauNoiText.textAlignment = .right
		viewContent.addSubview(lbNVDauNoiText)

		let lbNVDauNoiTextHeight:CGFloat = lbNVDauNoiText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNVDauNoiText.optimalHeight + Common.Size(s: 5))
		lbNVDauNoiText.numberOfLines = 0
		lbNVDauNoiText.frame = CGRect(x: lbNVDauNoiText.frame.origin.x, y: lbNVDauNoiText.frame.origin.y, width: lbNVDauNoiText.frame.width, height: lbNVDauNoiTextHeight)

		let lbTrangThai = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbNVDauNoiText.frame.origin.y + lbNVDauNoiTextHeight, width: lbKHName.frame.width, height: Common.Size(s: 20)))
		lbTrangThai.text = "Trạng thái:"
		lbTrangThai.font = UIFont.systemFont(ofSize: 14)
		lbTrangThai.textColor = .lightGray
		viewContent.addSubview(lbTrangThai)

		let lbTrangThaiText = UILabel(frame: CGRect(x: lbTrangThai.frame.origin.x + lbTrangThai.frame.width, y: lbTrangThai.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
		lbTrangThaiText.text = "\(item.status)"
		lbTrangThaiText.font = UIFont.systemFont(ofSize: 14)
		lbTrangThaiText.textAlignment = .right
		lbTrangThaiText.textColor = UIColor(netHex:0x00955E)
		viewContent.addSubview(lbTrangThaiText)

		let lbTenGoiCuocMpos = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbTrangThaiText.frame.origin.y + lbTrangThaiText.frame.height, width: lbKHName.frame.width + Common.Size(s: 30), height: Common.Size(s: 20)))
		lbTenGoiCuocMpos.text = "Tên gói cước Mpos:"
		lbTenGoiCuocMpos.font = UIFont.systemFont(ofSize: 14)
		lbTenGoiCuocMpos.textColor = .lightGray
		viewContent.addSubview(lbTenGoiCuocMpos)

		let lbTenGoiCuocMposText = UILabel(frame: CGRect(x: lbTenGoiCuocMpos.frame.origin.x + lbTenGoiCuocMpos.frame.width, y: lbTenGoiCuocMpos.frame.origin.y, width: lbKHNameText.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
		lbTenGoiCuocMposText.font = UIFont.systemFont(ofSize: 14)
		lbTenGoiCuocMposText.textAlignment = .right
		viewContent.addSubview(lbTenGoiCuocMposText)

			//		if tabType == "1" {
			//			lbTenGoiCuocMpos.text = "Gói cước Sale chọn Mpos:"
			//			lbTenGoiCuocMposText.text = "\(item.package_name_sale)"
			//		} else {
			//			lbTenGoiCuocMpos.text = "Tên gói cước Mpos:"
			//			lbTenGoiCuocMposText.text = "\(item.packageName)"
			//		}
		lbTenGoiCuocMpos.text = "Tên gói cước Mpos:"
		lbTenGoiCuocMposText.text = "\(item.packageName)"


		let lbTenGoiCuocMposTextHeight:CGFloat = lbTenGoiCuocMposText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbTenGoiCuocMposText.optimalHeight + Common.Size(s: 5))
		lbTenGoiCuocMposText.numberOfLines = 0
		lbTenGoiCuocMposText.frame = CGRect(x: lbTenGoiCuocMposText.frame.origin.x, y: lbTenGoiCuocMposText.frame.origin.y, width: lbTenGoiCuocMposText.frame.width, height: lbTenGoiCuocMposTextHeight)

			//		let lbTenGoiCuocMsale = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbTenGoiCuocMposText.frame.origin.y + lbTenGoiCuocMposTextHeight, width: lbKHName.frame.width, height: Common.Size(s: 20)))
			//		lbTenGoiCuocMsale.text = "Tên gói cước Msale:"
			//		lbTenGoiCuocMsale.font = UIFont.systemFont(ofSize: 14)
			//		lbTenGoiCuocMsale.textColor = .lightGray
			//		viewContent.addSubview(lbTenGoiCuocMsale)

			//		let lbTenGoiCuocMsaleText = UILabel(frame: CGRect(x: lbTenGoiCuocMsale.frame.origin.x + lbTenGoiCuocMsale.frame.width, y: lbTenGoiCuocMsale.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
			//		lbTenGoiCuocMsaleText.text = "\(item.package_name_provider)"
			//		lbTenGoiCuocMsaleText.font = UIFont.systemFont(ofSize: 14)
			//		lbTenGoiCuocMsaleText.textAlignment = .right
			//		viewContent.addSubview(lbTenGoiCuocMsaleText)
			//
			//		let lbTenGoiCuocMsaleTextHeight:CGFloat = lbTenGoiCuocMsaleText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbTenGoiCuocMsaleText.optimalHeight + Common.Size(s: 5))
			//		lbTenGoiCuocMsaleText.numberOfLines = 0
			//		lbTenGoiCuocMsaleText.frame = CGRect(x: lbTenGoiCuocMsaleText.frame.origin.x, y: lbTenGoiCuocMsaleText.frame.origin.y, width: lbTenGoiCuocMsaleText.frame.width, height: lbTenGoiCuocMsaleTextHeight)

		let lbNhaMang = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbTenGoiCuocMpos.frame.origin.y + lbTenGoiCuocMposTextHeight, width: lbKHName.frame.width, height: Common.Size(s: 20)))
		lbNhaMang.text = "Nhà mạng:"
		lbNhaMang.font = UIFont.systemFont(ofSize: 14)
		lbNhaMang.textColor = .lightGray
		viewContent.addSubview(lbNhaMang)

		let lbNhaMangText = UILabel(frame: CGRect(x: lbNhaMang.frame.origin.x + lbNhaMang.frame.width, y: lbNhaMang.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
		lbNhaMangText.text = "\(item.provider)"
		lbNhaMangText.font = UIFont.systemFont(ofSize: 14)
		lbNhaMangText.textAlignment = .right
		lbNhaMangText.textColor = .black
		viewContent.addSubview(lbNhaMangText)
			//        ====
		let lbLoaiSim = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbNhaMangText.frame.origin.y + lbNhaMangText.frame.size.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
		lbLoaiSim.text = "Loại sim:"
		lbLoaiSim.font = UIFont.systemFont(ofSize: 14)
		lbLoaiSim.textColor = .lightGray
		viewContent.addSubview(lbLoaiSim)

		let lbLoaiSimText = UILabel(frame: CGRect(x: lbLoaiSim.frame.origin.x + lbLoaiSim.frame.width, y: lbLoaiSim.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
		lbLoaiSimText.text = "\(item.packageType)"
		lbLoaiSimText.font = UIFont.systemFont(ofSize: 14)
		lbLoaiSimText.textAlignment = .right
		lbLoaiSimText.textColor = .black
		viewContent.addSubview(lbLoaiSimText)

		let lbGiagoi = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbLoaiSimText.frame.origin.y + lbLoaiSimText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
		lbGiagoi.text = "Giá gói cước:"
		lbGiagoi.font = UIFont.systemFont(ofSize: 14)
		lbGiagoi.textColor = .lightGray
		viewContent.addSubview(lbGiagoi)

		let lbGiagoiText = UILabel(frame: CGRect(x: lbGiagoi.frame.origin.x + lbGiagoi.frame.width, y: lbGiagoi.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
		lbGiagoiText.text = "\(Common.convertCurrencyDouble(value: item.package_price))VNĐ"
		lbGiagoiText.font = UIFont.systemFont(ofSize: 14)
		lbGiagoiText.textAlignment = .right
		lbGiagoiText.textColor = .red
		viewContent.addSubview(lbGiagoiText)

		let lbGiaSoThueBao = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbGiagoiText.frame.origin.y + lbGiagoiText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
		lbGiaSoThueBao.text = "Giá số thuê bao:"
		lbGiaSoThueBao.font = UIFont.systemFont(ofSize: 14)
		lbGiaSoThueBao.textColor = .lightGray
		viewContent.addSubview(lbGiaSoThueBao)

		let lbGiaSoThueBaoText = UILabel(frame: CGRect(x: lbGiaSoThueBao.frame.origin.x + lbGiaSoThueBao.frame.width, y: lbGiaSoThueBao.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
		lbGiaSoThueBaoText.text = "\(Common.convertCurrencyDouble(value: item.sub_number_price))VNĐ"
		lbGiaSoThueBaoText.font = UIFont.systemFont(ofSize: 14)
		lbGiaSoThueBaoText.textAlignment = .right
		lbGiaSoThueBaoText.textColor = .red
		viewContent.addSubview(lbGiaSoThueBaoText)

		let lbTongThanhToan = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbGiaSoThueBaoText.frame.origin.y + lbGiaSoThueBaoText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
		lbTongThanhToan.text = "Tổng thanh toán:"
		lbTongThanhToan.font = UIFont.systemFont(ofSize: 14)
		lbTongThanhToan.textColor = .lightGray
		viewContent.addSubview(lbTongThanhToan)

		let lbTongThanhToanText = UILabel(frame: CGRect(x: lbTongThanhToan.frame.origin.x + lbTongThanhToan.frame.width, y: lbTongThanhToan.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
		lbTongThanhToanText.text = "0đ"
		lbTongThanhToanText.font = UIFont.systemFont(ofSize: 14)
		lbTongThanhToanText.textAlignment = .right
		lbTongThanhToanText.textColor = .red
		viewContent.addSubview(lbTongThanhToanText)

			//		totalSum = item.package_price + item.sub_number_price
		lbTongThanhToanText.text = "\(Common.convertCurrencyDouble(value: item.totalPrice))VNĐ"

		let line2 = UIView(frame: CGRect(x: 0, y: lbTongThanhToanText.frame.origin.y + lbTongThanhToanText.frame.height + Common.Size(s: 5), width: viewContent.frame.width, height: Common.Size(s: 5)))
		line2.backgroundColor = .white
		viewContent.addSubview(line2)

		viewContent.frame = CGRect(x: viewContent.frame.origin.x, y: viewContent.frame.origin.y , width: viewContent.frame.width, height: line2.frame.origin.y + line2.frame.height)

		estimateCellHeight = viewContent.frame.origin.y + viewContent.frame.height
	}

	@objc func actionCell() {
		self.delegate?.actionSelectUserVinaphone(item: self.itemMSaleVinaphone!)
	}
}
