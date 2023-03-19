//
//  EbayService.swift
//  fptshop
//
//  Created by Sang Trương on 08/08/2022.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class InPhieuEbayVC: UIViewController {
	var itemFetch: EbayFeeModel?
	var finacialNAme: String = ""
	var finacialCode: String = ""
	var phoneNumber: String = ""
	var maHopDong: String = ""
	var orderId: String = ""
	var chuKy: String = ""
	var status: String = ""
	var statusCode: Int = 0
    var isFromSignFromHistory:Bool = false
	@IBOutlet weak var tfName: UITextField!
	@IBOutlet weak var tfDonVi: UITextField!
	@IBOutlet weak var tfSoTienNhan: UITextField!
	@IBOutlet weak var tfNameEnd: UITextField!
	@IBOutlet weak var tfPhone: UITextField!
	@IBOutlet weak var tfTienMat: UITextField!
	@IBOutlet weak var btnSave: UIButton!
	@IBOutlet weak var tfStatus: UILabel!
	override func viewDidLoad() {
		super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
		setupUI()
		// Do any additional setup after loading the view.
	}
	private func setupUI() {
        if isFromSignFromHistory {

            tfName.text = "\(ThuHoSOMDataManager.shared.orderDetail.customerName)"
            tfDonVi.text = finacialCode

            tfSoTienNhan.text = "\(Common.convertCurrencyFloat(value: Float(Double(ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos[0].totalAmount))))"
            tfNameEnd.text = "\(ThuHoSOMDataManager.shared.orderDetail.customerName)"
            tfPhone.text = "\(ThuHoSOMDataManager.shared.orderDetail.customerPhoneNumber)"
            tfTienMat.text = "\(Common.convertCurrencyFloat(value: Float(Double(ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos[0].totalAmount))))"
            let statusCode = ThuHoSOMDataManager.shared.orderDetail.orderStatus
            if statusCode == 2 {
                tfStatus.textColor = #colorLiteral(red: 0.01877964661, green: 0.6705997586, blue: 0.4313761592, alpha: 1)
                tfStatus.text = "  Giao dịch thành công"
            } else if statusCode == 3 {
                tfStatus.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                tfStatus.text = "  Giao dịch thất bại"
            }else {
                tfStatus.text = "  Không xác định được trạng thái"
            }
        }else {
            tfName.text = itemFetch?.customerName ?? ""
            tfDonVi.text = finacialCode
            tfSoTienNhan.text = Common.convertCurrencyFloat(value: Float(itemFetch?.amount ?? 0))
            tfNameEnd.text = itemFetch?.customerName ?? ""
            tfPhone.text = phoneNumber
            tfTienMat.text = Common.convertCurrencyFloat(value: Float(itemFetch?.amount ?? 0))
            if statusCode == 2 {
                tfStatus.textColor = #colorLiteral(red: 0.01877964661, green: 0.6705997586, blue: 0.4313761592, alpha: 1)
                tfStatus.text = "  Giao dịch thành công"
            } else if statusCode == 3 {
                tfStatus.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                tfStatus.text = "  Giao dịch thất bại"
            }else {
                tfStatus.text = "  Không xác định được trạng thái"
            }
        }

	}

	@IBAction func onSave(_ sender: Any) {
		self.navigationController?.popToRootViewController(animated: true)
		//		let vc = InphieuSuccessVC()
		//        vc.itemFetch = self.itemFetch
		//        vc.phoneNumber = self.tfPhone.text ?? ""
		//        vc.finacialNAme = self.finacialNAme
		//        vc.finacialCode = self.finacialCode
		//        vc.maHopDong = self.maHopDong
		//        vc.orderId = self.orderId
		//        vc.chuKy = self.chuKy
		//		self.navigationController?.pushViewController(vc, animated: true)
	}
}
