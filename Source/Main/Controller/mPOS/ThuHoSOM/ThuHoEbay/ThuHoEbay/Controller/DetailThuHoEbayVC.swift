//
//  EbayService.swift
//  fptshop
//
//  Created by Sang Trương on 08/08/2022.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Toaster
import UIKit

class DetailThuHoEbayVC: UIViewController, ImageFrameCustomDelegate {
	static var statusCode: Int = 0
	var selectedDonVi: String = ""
	var itemFetch: EbayFeeModel?
	var finacialNAme: String = ""
	var finacialCode: String = ""
	var maHopDong: String = ""
	var chukydientu: String = ""
	var listUrl: [String] = ["1", "2", "3", "4", "5"]
	var soCMND: String = ""
	var OrderStatus: String = ""
	var orderId: String = ""
	var isSuccess: Bool = false
	var countRecall: Int = 0
	let item = ThuHoSOMDataManager.shared.selectedCatagory
	private var stringBase64Sign: String = ""
	private var isSign: Bool = false
    let currentDate = Common.gettimeWith(format: "yyyy-MM-dd")

	@IBOutlet weak var idCardFront: ImageFrameCustom!
	@IBOutlet weak var idCardBack: ImageFrameCustom!
	@IBOutlet weak var tfIdCardIssueBy: UITextField!
	@IBOutlet weak var chanDungView: ImageFrameCustom!
	@IBOutlet weak var tfDonViTaiChinh: UITextField!
	@IBOutlet weak var tfAmount: UITextField!
	@IBOutlet weak var tfName: UITextField!
	@IBOutlet weak var tfIdCardIssueDate: UITextField!
	@IBOutlet weak var tfNameEnd: UITextField!
	@IBOutlet weak var tfPhoneEnd: UITextField!
	@IBOutlet weak var tfOTPEnd: UITextField!
	@IBOutlet weak var viewSign: UIView!
	@IBOutlet weak var imageSigned: UIImageView!
	@IBOutlet weak var viewSignButton: UIView!
	@IBOutlet weak var viewSignTitle: UILabel!
	@IBOutlet weak var viewSignIcon: UIImageView!
	override func viewDidLoad() {
		super.viewDidLoad()
		idCardFront.delegate = self
		idCardFront.controller = self
		idCardBack.delegate = self
		idCardBack.controller = self
		chanDungView.delegate = self
		chanDungView.controller = self
		//        tfOTPEnd.text = "747450"
		fetchUI(item: itemFetch!)
		setupViewSign()
	}
	private func setupViewSign() {
		self.imageSigned.isUserInteractionEnabled = true
		let tapShowSignature = UITapGestureRecognizer(target: self, action: #selector(tapShowSign))
		imageSigned.addGestureRecognizer(tapShowSignature)
	}
	@objc func tapShowSign(sender: UITapGestureRecognizer) {
		let signatureVC = EPSignatureViewController(
			signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
		signatureVC.subtitleText = "Không ký qua vạch này!"
		signatureVC.title = "Chữ ký"

		self.navigationController?.pushViewController(signatureVC, animated: true)
	}

	//MARK: - API
	private func genBienLai(
        ten_shop: String, dia_chi_shop: String, ngay_tao: String, ma_giao_dich: String, khach_hang: String,
        ma_hop_dong: String, so_tien_nhan: Double, so_dien_thoai: String, ma_thu_ngan: String,
        ten_thu_ngan: String, chu_ky_dien_tu: String,don_vi_tai_chinh:String
    ) {
        ProgressView.shared.show()
        Provider.shared.ebayService.genBienLaiEbay(
            ten_shop: ten_shop, dia_chi_shop: dia_chi_shop, ngay_tao: ngay_tao, ma_giao_dich: ma_giao_dich,
            khach_hang: khach_hang, ma_hop_dong: ma_hop_dong, so_tien_nhan: so_tien_nhan,
            so_dien_thoai: so_dien_thoai, ma_thu_ngan: ma_thu_ngan, ten_thu_ngan: ten_thu_ngan,
            chu_ky_dien_tu: chu_ky_dien_tu,don_vi_tai_chinh: finacialNAme,
			success: { [weak self] (result) in
				guard let self = self, let response = result else { return }
				ProgressView.shared.hide()
				if response.error != "" {  //fail
					self.showAlertOneButton(
						title: "Thông báo", with: response.error ?? "", titleButton: "OK")
				} else {  //success
					Toast.init(text: "Gen biên lai thành công").show()
					self.updateBienLai(orderId: self.orderId, url: response.url ?? "")
				}
			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
			})
	}
	private func updateBienLai(orderId: String, url: String) {
		ProgressView.shared.show()
		Provider.shared.ebayService.updateBienLai(
			orderId: orderId, url: url,
			success: { [weak self] (result) in
				guard let self = self, let response = result else { return }
				ProgressView.shared.hide()
				if response.code == 200 {  //success
					Toast.init(text: response.message ?? "").show()
				} else {
					self.showAlertOneButton(
						title: "Thông báo", with: response.message ?? "", titleButton: "OK")
				}
			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
			})
	}
	private func uploadImageEbay(ma_hop_dong: String, type: Int, base64: String) {
//		self.loading(isShow: true)
		Provider.shared.ebayService.uploadImageEbayNoLoading(
			ma_hop_dong: ma_hop_dong, type: type, base64: base64,
			success: { [weak self] (result) in
				guard let self = self, let response = result else { return }
//				self.loading(isShow: false)
				if response.error != "" {  //fail
					self.showAlertOneButton(
						title: "Thông báo", with: response.error ?? "", titleButton: "OK")
				} else {
					switch type {
					case 1:
						self.listUrl[0] = result?.url ?? ""
					case 2:
						self.listUrl[1] = result?.url ?? ""
					case 3:
						self.listUrl[2] = result?.url ?? ""
					case 4:
						self.listUrl[3] = result?.url ?? ""
					case 5:
						self.listUrl[4] = result?.url ?? ""
					default:
						return self.showAlertOneButton(
							title: "Thông báo", with: "không thể map url(hard code)",
							titleButton: "OK")
					}

				}
			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
			})
	}

	private func checkTranSactionNew() {
		ProgressView.shared.show()
		DispatchQueue.main.asyncAfter(
			deadline: .now() + 5,
			execute: { [weak self] in
				Provider.shared.ebayService.checkGiaoDichNew(
					OrderId: self?.orderId ?? "",
					success: { (result) in
						guard let self = self, let response = result else { return }
						ProgressView.shared.hide()
                        self.countRecall += 1
                        self.showAlertStatus(
                            orderID: self.orderId, status: response.orderStatus ?? 0)

					},
					failure: { [weak self] error in
						guard let self = self else { return }
						self.showAlertOneButton(
							title: "Thông báo", with: error.description, titleButton: "OK")
					})
			})

	}


	private func saveOrderEpay() {
//        let currentDate = Common.gettimeWith(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        if item.products.count == 0 {
            self.showAlertOneButton(title: "Thông báo", with: "Không tìm thấy chi tiết sản phẩn", titleButton: "KM")
            return
        }
		let currentDate = Common.gettimeWith(format: "yyyy-MM-dd")
		let orderStatus: Int = 1
		let orderStatusDisplay: String = ""
		let billNo: String = ""
		let customerId: String = ""
		let customerName: String = tfNameEnd.text ?? ""
		let customerPhoneNumber: String = tfPhoneEnd.text ?? ""
		let warehouseCode: String = Cache.user!.ShopCode
		let regionCode: String = ""
		let creationBy: String = Cache.user!.UserName
		let creationTime: String = currentDate
		let referenceSystem: String = "MPOS"
		let referenceValue: String = ""

		let orderTransactionDtos: [[String: Any]] = [
			[
				"productId": "\(item.products[0].id )",  //"6f5ee98c-3838-4b2f-aadc-0caff130d6fa"
				"providerId": "\(item.products[0].providerIds[0])",  //"d01606ac-0bd8-4d76-984d-5611bdb419ce",
				"providerName": "\(item.products[0].name)",  // "Epay",
				"productName": "\(item.products[0].name)",  //
				"price": Double(tfAmount.text ?? "0") ?? 0,
				"quantity": 1,
				"totalAmount": itemFetch?.amount ?? "0",
				"totalFee": 0,
				"totalAmountIncludingFee": itemFetch?.amount ?? "0",
				"creationTime": currentDate,
				"creationBy": Cache.user!.UserName,
				"integratedGroupCode": "\(item.products[0].id )",  //
				"integratedGroupName": "",  //
				"integratedProductCode": "\(item.products[0].configs[0].integratedGroupCode )",  //
				"integratedProductName": "",  //
				"isOfflineTransaction": false,
				"referenceCode": "",
				"minFee": 0,
				"maxFee": 0,
				"percentFee": 0,
				"constantFee": 0,
				"paymentFeeType": 0,
				"paymentRule": 0,
				"productCustomerCode": maHopDong,  //"6345553285",
				"productCustomerName": tfNameEnd.text ?? "",  //"NGUYEN VAN A",
				"productCustomerPhoneNumber": tfPhoneEnd.text ?? "",  //"",
				"productCustomerAddress": "",  //"",
				"productCustomerEmailAddress": "",
				"description": "",
				"vehicleNumber": "",
				"invoices": [],
				"categoryId": "\(item.products[0].categoryIds[0] )",  //"a6123000-0cb9-4f6e-a36f-7efa3d5a69cb",
				"isExportInvoice": false,
				"id": "",
				"extraProperties": [
					"referenceIntegrationInfo": [
						"requestId": "",
						"responseId": "",
					],
					"warehouseName": Cache.user!.Address,
					"finance": finacialCode,
					"customerIdentityNumber": itemFetch?.customerIdNo ?? "",  //"630450224371",
					"customerIdentityDate": itemFetch?.customerIdDate ?? "",  //"1/1/1",
					"customerIdentityPlace": itemFetch?.customerIdPlace ?? "",  //"",
					"otp": tfOTPEnd.text ?? "",

					"idCardFrontPhoto": listUrl[2],
					"idCardBackPhoto": listUrl[3],
					"idCardPortraitPhoto": listUrl[1],
					"signaturePhoto": listUrl[4],
				],
				"sender": [:],
				"receiver": [:],
				"productConfigDto": [
					"checkInventory": false
				],
			]
		]
		let payments: [[String: Any]] = [
			[
				"paymentType": "1",
				"paymentValue": itemFetch?.amount ?? "0",
				"paymentExtraFee": 0,
				"paymentPercentFee": 0,
			]
		]
		let id: String = ""
		let ip: String = ""
		ProgressView.shared.show()
		Provider.shared.ebayService.saveOrder(
			orderStatus: orderStatus, orderStatusDisplay: orderStatusDisplay, billNo: billNo,
			customerId: customerId, customerName: customerName, customerPhoneNumber: customerPhoneNumber,
			warehouseCode: warehouseCode, regionCode: regionCode, creationBy: creationBy,
			creationTime: creationTime, referenceSystem: referenceSystem, referenceValue: referenceValue,
			orderTransactionDtos: orderTransactionDtos, payments: payments, id: id, ip: ip,
			success: { [weak self] (result) in
				guard let self = self, let response = result else { return }
				ProgressView.shared.hide()
				switch DetailThuHoEbayVC.statusCode {
				case 200:
                        //FIXME: đổi lại lấy id từ api khác
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            self.orderId = result?.id ?? ""
                            self.loadSaveOrder(id: self.orderId) 
                        })

				case 99:
					self.showAlertOneButton(
						title: "Đang thực hiện", with: "Giao dịch bị timeout", titleButton: "OK"
					)
					return
				case 101:
					self.showAlertOneButton(
						title: "Thông báo", with: "Lỗi trong quá trình xử lý bên Epay",
						titleButton: "OK")
					return
				case 102:
					self.showAlertOneButton(
						title: "Thông báo", with: "RequestId bị trùng", titleButton: "OK")
					return
				case 103:
					self.showAlertOneButton(
						title: "Thông báo", with: "Chữ ký không chính xác", titleButton: "OK")
					return
				case 110:
					self.showAlertOneButton(
						title: "Thông báo", with: "PartnerCode không chính xác",
						titleButton: "OK")
					return
				case 111:
					self.showAlertOneButton(
						title: "Thông báo", with: "PartnerCode đã bị xóa khỏi hệ thống",
						titleButton: "OK")
					return
				case 112:
					self.showAlertOneButton(
						title: "Thông báo", with: "PartnerCode chưa được kích hoạt",
						titleButton: "OK")
					return
				case 113:
					self.showAlertOneButton(
						title: "Thông báo", with: "Mã Operation là bắt buộc", titleButton: "OK")
					return
				case 114:
					self.showAlertOneButton(
						title: "Thông báo", with: "Mã Operation không chính xác",
						titleButton: "OK")
					return
				case 115:
					self.showAlertOneButton(
						title: "Thông báo", with: "Mã đơn vị tài chính không chính xác",
						titleButton: "OK")
					return
				case 116:
					self.showAlertOneButton(
						title: "Thông báo", with: "Địa chỉ gửi lên không được quá dài",
						titleButton: "OK")
					return
				case 117:
					self.showAlertOneButton(
						title: "Thất bại", with: "Mã hợp đồng là bắt buộc    ",
						titleButton: "OK")
					return
				case 118:
					self.showAlertOneButton(
						title: "Thất bại",
						with: "Mã hợp đồng bắt buộc có độ dài từ 10->22 ký tự",
						titleButton: "OK")
					return
				case 119:
					self.showAlertOneButton(
						title: "Thất bại", with: "Không tìm thấy mã hợp đồng", titleButton: "OK"
					)
					return
				case 120:
					self.showAlertOneButton(
						title: "Thất bại", with: "Số hợp đồng này đã xác nhận chi tiền rồi",
						titleButton: "OK")
					return
				case 121:
					self.showAlertOneButton(
						title: "Thất bại",
						with: "Chứng minh nhân dân gửi lên không khớp với hợp đồng",
						titleButton: "OK")
					return
				case 122:
					self.showAlertOneButton(
						title: "Thất bại", with: "Lỗi xử lý giữa Epay và đơn vị tài chính",
						titleButton: "OK")
					return
				case 123:
					self.showAlertOneButton(
						title: "Thất bại", with: "Lỗi kết nối tới đơn vị tài chính    ",
						titleButton: "OK")
					return
				case 124:
					self.showAlertOneButton(
						title: "Thất bại", with: "Lỗi xử lý từ đơn vị tài chính    ",
						titleButton: "OK")
					return
				case 125:
					self.showAlertOneButton(
						title: "Thất bại", with: "Mã giao dịch bên đối tác gửi lên là bắt buộc",
						titleButton: "OK")
					return
				case 126:
					self.showAlertOneButton(
						title: "Thất bại",
						with: "Mã giao dịch bên đối tác gửi lên đã chi trước đó",
						titleButton: "OK")
					return
				case 127:
					self.showAlertOneButton(
						title: "Thất bại", with: "Hệ thống không tìm thấy giao dịch",
						titleButton: "OK")
					return
				case 128:
					self.showAlertOneButton(
						title: "Thất bại",
						with: "Mã giao dịch bên đối tác gửi lên không chính xác",
						titleButton: "OK")
					return
				case 129:
					self.showAlertOneButton(
						title: "Thất bại", with: "Số tiền chi là bắt buộc", titleButton: "OK")
					return
				case 130:
					self.showAlertOneButton(
						title: "Thất bại", with: "Số tiền chi không chính xác",
						titleButton: "OK")
					return
				case 131:
					self.showAlertOneButton(
						title: "Thất bại", with: "Mã bảo mật không chính xác", titleButton: "OK"
					)
					return
				case 132:
					self.showAlertOneButton(
						title: "Thất bại", with: "Mã OTP không chính xác", titleButton: "OK")
					return
				case 133:
					self.showAlertOneButton(
						title: "Thất bại",
						with:
							"FE_CREDIT_Mã OTP chỉ được gửi cách nhau sau 5 phút (Tra cứu hợp đồng chi ->gửi OTP luôn nên sau 5 phút mới được tra cứu lại)",
						titleButton: "OK")
					return
				case 134:
					self.showAlertOneButton(
						title: "Thất bại",
						with:
							"Mã OTP  đã được gửi quá 3 lần trong ngày (đối với DVTC F88 là 5 lần)",
						titleButton: "OK")
					return
				case 135:
					self.showAlertOneButton(
						title: "Đang thực hiện hủy",
						with: "Giao dịch đã được gửi yêu cầu hủy trước đó", titleButton: "OK")
					return
				case 136:
					self.showAlertOneButton(
						title: "Đang thực hiện hủy",
						with: "Giao dịch đang chờ ĐVTC xác nhận hủy", titleButton: "OK")
					return
				case 137:
					self.showAlertOneButton(
						title: "Đã hủy", with: "Giao dịch đã được chấp nhận hủy",
						titleButton: "OK")
					return
				case 138:
					self.showAlertOneButton(
						title: "Thành công (hủy không thành công)",
						with: "Giao dịch hủy bị từ chối từ ĐVTC", titleButton: "OK")
					return
				case 139:
					self.showAlertOneButton(
						title: "Thất bại",
						with: "Số hợp đồng này trước đó đã xác nhận chi và đang bị pending",
						titleButton: "OK")
					return
				default:
					self.showAlertOneButton(
						title: "Thất bại", with: response.error?.message ?? "",
						titleButton: "OK")
					return

				}

			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
			})
	}
    private func loadSaveOrder(id:String) {
        ZaloPayServiceImpl.detailOrder(id: id) { detailOrder in
            let currentDate = Common.gettimeWith(format: "yyyy-MM-dd")
            let creationTime: String = currentDate
            if detailOrder?.orderTransactionDtos[0].transactionCode != nil {
                self.genBienLai(
                    ten_shop: "\(Cache.user!.ShopName)", dia_chi_shop: Cache.user!.Address,
                    ngay_tao: creationTime,
                    ma_giao_dich: detailOrder?.orderTransactionDtos[0].transactionCode ?? "",
                    khach_hang: self.itemFetch?.customerName ?? "",
                    ma_hop_dong: self.maHopDong, so_tien_nhan: self.itemFetch?.amount ?? 0,
                    so_dien_thoai: self.tfPhoneEnd.text ?? "",
                    ma_thu_ngan: Cache.user!.UserName,
                    ten_thu_ngan: "\(Cache.user!.EmployeeName)", chu_ky_dien_tu: self.listUrl[4], don_vi_tai_chinh: self.finacialNAme)
                self.checkTranSactionNew()
            }else {
                Toast.init(text: "Mã giao dịch trả rỗng").show()
            }

        }
    }
	//MARK: - Helpers
	private func fetchUI(item: EbayFeeModel) {
		print(item)
		tfDonViTaiChinh.text = selectedDonVi
		tfIdCardIssueBy.text = item.customerIdPlace
        tfIdCardIssueDate.text = Common.convertDateToStringWith(dateString: item.customerIdDate ?? "", formatIn: "yyyy-MM-dd'T'HH:mm:ss", formatOut: "dd/MM/yyyy")



		tfAmount.text = Common.convertCurrencyFloat(value: Float(item.amount ?? 0))
		tfName.text = item.customerName
		tfNameEnd.text = item.customerName
		//		tfPhoneEnd.text = "0967921853"

		tfDonViTaiChinh.text = finacialNAme

	}

	private func validateInputs() -> Bool {
		if idCardFront.resultLeftImg.image == nil {
			self.showAlert("Bạn vui lòng chụp ảnh CMND mặt trước")
			return false
		}

		if idCardBack.resultLeftImg.image == nil {
			self.showAlert("Bạn vui lòng chụp ảnh CMND mặt sau")
			return false
		}
		if chanDungView.resultLeftImg.image == nil {
			self.showAlert("Bạn vui lòng chụp ảnh chân dung")
			return false
		}

		if tfPhoneEnd.text == "" {
			self.showAlert("Bạn vui lòng nhập số điện thoại")
			return false
		}
		if tfPhoneEnd.text?.first != "0" {
			self.showAlert("Bạn vui lòng nhập số điện thoại đúng định dạng bắt đầu bằng số 0")
			return false
		}
		if tfPhoneEnd.text?.count != 10 {
			self.showAlert("Bạn vui lòng nhập số điện thoại đúng định dạng 10 số")
			return false
		}
		if tfOTPEnd.text == "" {
			self.showAlert("Bạn vui lòng nhập mã OTP")
			return false
		}
		if isSign == false {
			self.showPopUp("Chưa có chữ ký khách hàng", "Thông báo", buttonTitle: "OK")
			return false
		}
		return true
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
	//MARK: - Selector

	@IBAction func onSave(_ sender: Any) {
		guard validateInputs() else { return }

		self.showAlertEbay(
			title: "Thông báo",
			with:
				"Bạn có muốn chi số tiền \(Common.convertCurrencyFloat(value:Float(itemFetch?.amount ?? 0)))đ vào hợp đồng \(self.maHopDong) hay không?",
			titleButtonOne: "Không", titleButtonTwo: "có",
			handleButtonOne: {

			},
			handleButtonTwo: {
				self.saveOrderEpay()
			})

	}

	private func showAlertStatus(orderID: String, status: Int) {

		switch status {
		case 0:
			OrderStatus = "Không hỗ trợ"
		case 1:
			OrderStatus = "Đã tạo giao dịch"
		case 2:
			OrderStatus = "Giao dịch thành công"
		case 3:
			OrderStatus = "Giao dịch thất bại"
		case 4:
			OrderStatus = "Đã hủy"
		case 5:
			OrderStatus = "Đã đẩy sang POS"
		case 6:
			OrderStatus = "Yêu cầu hủy"
		case 7:
			OrderStatus = "Đang thực hiện"
		case 8:
			OrderStatus = "Hủy thất bại (Giao dịch thành công)"
		case 9:
			OrderStatus = "Đang thực hiện hủy"
		case 10:
			OrderStatus = "Đã hủy 1 phần"
		case 11:
			OrderStatus = "Cần bổ sung thông tin"
		default:
			print("oke")

		}
		if status != 1 {
			if status == 2 || status == 3 {
				self.showAlertOneButton(
					title: "Thông báo", with: OrderStatus, titleButton: "OK",
					handleOk: {
						let vc = InPhieuEbayVC()
						vc.itemFetch = self.itemFetch
						vc.phoneNumber = self.tfPhoneEnd.text ?? ""
						vc.finacialNAme = self.finacialNAme
						vc.finacialCode = self.finacialCode
						vc.maHopDong = self.maHopDong
						vc.orderId = self.orderId
						vc.chuKy = self.listUrl[4]
						vc.status = self.OrderStatus
						vc.statusCode = status
						self.navigationController?.pushViewController(vc, animated: true)
					})
			} else {
				self.showAlertOneButton(title: "Thông báo", with: OrderStatus, titleButton: "OK")
			}
		} else {
			if countRecall < 6 {
				self.checkTranSactionNew()
			} else {
				//đã check đủ 6 lần
				OrderStatus = "Giao dịch thất bại"
				countRecall = 0
				self.showAlertOneButton(
					title: "Thông báo", with: "kiểm tra trạng thái giao dịch thất bại",
					titleButton: "OK")
			}
		}

	}

	func didPickImage(_ view: ImageFrameCustom, image: UIImage, isLeft: Bool) {
		if let imageData: NSData = image.jpegData(compressionQuality: 0.1) as NSData? {
			let base64Str = imageData.base64EncodedString(options: .endLineWithLineFeed)
			DispatchQueue.main.async {
				if view == self.idCardFront {
					self.uploadImageEbay(
						ma_hop_dong: self.maHopDong, type: 3, base64: base64Str)
				} else if view == self.idCardBack {
					self.uploadImageEbay(
						ma_hop_dong: self.maHopDong, type: 4, base64: base64Str)
				} else if view == self.chanDungView {
					self.uploadImageEbay(
						ma_hop_dong: self.maHopDong, type: 2, base64: base64Str)
				}
			}

		}

	}
	private func loading(isShow: Bool) {
		let nc = NotificationCenter.default
		if isShow {
			let newViewController = LoadingViewController()
			newViewController.content = "Đang kiểm tra thông tin..."
			newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
			newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
			self.navigationController?.present(newViewController, animated: true, completion: nil)
		} else {
			nc.post(name: Notification.Name("dismissLoading"), object: nil)
		}
	}

}
//MARK: - View sign
extension DetailThuHoEbayVC: EPSignatureDelegate {
	private func cropImage(image: UIImage, toRect rect: CGRect) -> UIImage {
		let imageRef: CGImage = image.cgImage!.cropping(to: rect)!
		let croppedImage: UIImage = UIImage(cgImage: imageRef)
		return croppedImage
	}
	func epSignature(_: EPSignatureViewController, didCancel error: NSError) {

		_ = self.navigationController?.popViewController(animated: true)
		self.dismiss(animated: true, completion: nil)
	}

	func epSignature(_: EPSignatureViewController, didSign signatureImage: UIImage, boundingRect: CGRect) {
		_ = self.navigationController?.popViewController(animated: true)
		self.dismiss(animated: true, completion: nil)
		imageSigned.contentMode = .scaleAspectFit
		imageSigned.image = cropImage(image: signatureImage, toRect: boundingRect)
		viewSignIcon.isHidden = true
		viewSignTitle.isHidden = true
		isSign = true
		let imageSign: UIImage = self.resizeImage(image: imageSigned.image!, newHeight: 170)!
		let imageDataSign: NSData = (imageSign.jpegData(compressionQuality: 0.75) as NSData?)!
		self.stringBase64Sign = imageDataSign.base64EncodedString(options: .endLineWithLineFeed)
		self.uploadImageEbay(
			ma_hop_dong: self.maHopDong, type: 5, base64: stringBase64Sign)

	}

	func reSignatureSignn() {

		let tapShowSignature = UITapGestureRecognizer(target: self, action: #selector(tapShowSign))
		imageSigned.isUserInteractionEnabled = true
		imageSigned.addGestureRecognizer(tapShowSignature)
	}
	private func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage? {

		let scale = newHeight / image.size.height
		let newWidth = image.size.width * scale
		UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
		image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return newImage
	}

}
