//
//  InphieuSuccessVC.swift
//  QuickCode
//
//  Created by Sang Trương on 08/08/2022.
//

import UIKit

class InphieuSuccessVC: UIViewController {
	var itemFetch: EbayFeeModel?
	var finacialNAme: String = ""
	var finacialCode: String = ""
	var phoneNumber: String = ""
	var maHopDong: String = ""
	var orderId: String = ""
	var chuKy: String = ""
	@IBOutlet weak var tfName: UITextField!
	@IBOutlet weak var tfDonVi: UITextField!
	@IBOutlet weak var tfSoTienNhan: UITextField!
	@IBOutlet weak var tfNameEnd: UITextField!
	@IBOutlet weak var tfPhone: UITextField!
	@IBOutlet weak var tfTienMat: UITextField!
	@IBOutlet weak var btnSave: UIButton!
	override func viewDidLoad() {
		super.viewDidLoad()

		setupUI()
		// Do any additional setup after loading the view.
	}
	private func setupUI() {
		tfName.text = itemFetch?.customerName ?? ""
		tfDonVi.text = finacialCode
		tfSoTienNhan.text = Common.convertCurrencyFloat(value: Float(itemFetch?.amount ?? 0))
		tfNameEnd.text = itemFetch?.customerName ?? ""
		tfPhone.text = phoneNumber
		tfTienMat.text = Common.convertCurrencyFloat(value: Float(itemFetch?.amount ?? 0))

	}
	@IBAction func onSave(_ sender: Any) {
		showAlertEbay(
			title: "Giao dịch thành công", with: "Giao dịch đã hoàn tất,bạn có muốn in phiếu hay không?",
			titleButtonOne: "Hủy", titleButtonTwo: "In Phiếu",
			handleButtonOne: {
				print("hủy")

			},
			handleButtonTwo: {
				print("in phieu")
				let currentDate = Common.gettimeWith(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
//				self.genBienLai(
//					ten_shop: Cache.user!.ShopName, dia_chi_shop: Cache.user!.Address,
//					ngay_tao: currentDate, ma_giao_dich: self.orderId,
//					khach_hang: self.tfNameEnd.text ?? "", ma_hop_dong: self.maHopDong,
//					so_tien_nhan: self.itemFetch?.amount ?? 0,
//					so_dien_thoai: self.tfPhone.text ?? "", ma_thu_ngan: Cache.user!.UserName,
//					ten_thu_ngan: Cache.user!.EmployeeName, chu_ky_dien_tu: self.chuKy)

			})
	}
//	private func genBienLai(
//		ten_shop: String, dia_chi_shop: String, ngay_tao: String, ma_giao_dich: String, khach_hang: String,
//		ma_hop_dong: String, so_tien_nhan: Double, so_dien_thoai: String, ma_thu_ngan: String,
//		ten_thu_ngan: String, chu_ky_dien_tu: String
//	) {
//		Provider.shared.ebayService.genBienLaiEbay(
//			ten_shop: ten_shop, dia_chi_shop: dia_chi_shop, ngay_tao: ngay_tao, ma_giao_dich: ma_giao_dich,
//			khach_hang: khach_hang, ma_hop_dong: ma_hop_dong, so_tien_nhan: so_tien_nhan,
//			so_dien_thoai: so_dien_thoai, ma_thu_ngan: ma_thu_ngan, ten_thu_ngan: ten_thu_ngan,
//			chu_ky_dien_tu: chu_ky_dien_tu,
//			success: { [weak self] (result) in
//				guard let self = self, let response = result else { return }
//				if response.error != "" {  //fail
//					self.showAlertOneButton(
//						title: "Thông báo", with: response.error ?? "", titleButton: "OK")
//				} else {  //success
//                    if response.error == "" {//success
//                        self.updateBienLai(orderId: self.orderId, url: response.url ?? "")
//                    }else {//fail
//                        self.showAlertOneButton(
//                            title: "Thông báo", with: response.error ?? "", titleButton: "OK")
//                    }
//				}
//			},
//			failure: { [weak self] error in
//				guard let self = self else { return }
//				self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
//			})
//	}

    private func updateBienLai(orderId: String, url: String) {
        Provider.shared.ebayService.updateBienLai(orderId: orderId, url: url, success: { [weak self] (result) in
                guard let self = self, let response = result else { return }
            if response.code == 200 {//success
                self.showAlertOneButton(
                    title: "Thông báo", with: response.message ?? "", titleButton: "OK",handleOk: {
                        self.navigationController?.popToRootViewController(animated: true)
                    })
            }else {//fail
                self.showAlertOneButton(title: "Thông báo", with: response.message ?? "", titleButton: "OK")
            }
            },
            failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
    }
	private func showAlertEbay(
		title: String, with message: String, titleButtonOne: String, titleButtonTwo: String,
		handleButtonOne: (() -> Void)? = nil, handleButtonTwo: (() -> Void)? = nil
	) {

		let alert = UIAlertController(
			title: title, message: message, preferredStyle: UIAlertController.Style.alert)

		alert.addAction(
			UIAlertAction(
				title: titleButtonOne, style: UIAlertAction.Style.destructive,
				handler: { (_) in
					handleButtonOne?()
				}))
		alert.addAction(
			UIAlertAction(
				title: titleButtonTwo, style: UIAlertAction.Style.default,
				handler: { (_) in
					handleButtonTwo?()
				}))
		self.present(alert, animated: true, completion: nil)
	}

}
