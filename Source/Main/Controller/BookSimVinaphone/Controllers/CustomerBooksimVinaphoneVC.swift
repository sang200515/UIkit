//
//  CustomerBooksimVinaphoneVC.swift
//  QuickCode
//
//  Created by Sang Trương on 30/12/2022.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


class CustomerBooksimVinaphoneVC: BaseRXViewController {
	var typeBookSim:String = "" // 1:luồng giỏ hàng, 2:luồng book sim , 3 luồng số đã đặt mua
	var simActive:SimActive?
	var simBookByShopV2:SimBookByShopV2?
	let itemProviderSubject = PublishRelay<SimV2>()
	var tongTien:String = ""
	var giaGoiCuoc:String = ""
	var model:SimV2?
	@IBOutlet weak var nameTextField :UITextField!
	@IBOutlet weak var idCardTextField :UITextField!
	@IBOutlet weak var phoneTextField :UITextField!
	@IBOutlet weak var searialTextField :UITextField!
	@IBOutlet weak var codeTextField :UITextField!
	@IBOutlet weak var simTypeTextField :UITextField!

	@IBOutlet weak var packagePriceLabel :UILabel!
	@IBOutlet weak var subscriptionPriceLabel :UILabel!
	@IBOutlet weak var totalLabel :UILabel!
	@IBOutlet weak var saveButton :UIButton!

	private let scanBarCodeImageView : UIImageView  = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "scan_barcode_1")
		return imageView
	}()
	private let phoneSubject = PublishRelay<String>()
	private let subcriptionSubject = BehaviorRelay<Int>(value: 0)
	private let serialSubject = BehaviorSubject<String>(value: "")
	private let viewmodel = CustomerBookSimVinaViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
		self.bindViewModel()
		self.bindFromNavigation()

	}
	override func setupUI(){
		self.title = "Thông tin khách hàng đầu nối"
		self.searialTextField.withImage(direction: .right, image: UIImage(named: "scan_barcode_1")!)
		self.searialTextField.addSubview(scanBarCodeImageView)
		scanBarCodeImageView.snp.makeConstraints({(make) in
			make.top.equalToSuperview().offset(5)
			make.right.bottom.equalToSuperview().offset(-5)
			make.width.height.equalTo(30)
		})
		let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleShowScanBarcode))
		scanBarCodeImageView.addGestureRecognizer(tap)
		scanBarCodeImageView.isUserInteractionEnabled = true
	}
	private func bindFromNavigation(){
			//model la thue bao - Cache la goi cuoc
		if let model {
			self.simTypeTextField.text = "sim thường"
			switch self.typeBookSim {
				case "1":
					let total = (model.Gia + (Cache.packageBookSim?.GiaCuoc ?? 0) )
					self.codeTextField.text = Cache.packageBookSim?.MaGoiCuoc ?? ""
					self.packagePriceLabel.text = "\(Common.convertCurrencyV2(value:Cache.packageBookSim?.GiaCuoc ?? 0))đ"
					self.subscriptionPriceLabel.text = "\(Common.convertCurrencyV2(value:model.Gia))đ"
					self.totalLabel.text = "\(Common.convertCurrencyV2(value: (total) ))đ"
					self.phoneTextField.text = Cache.packageBookSim?.PhoneNumber ?? ""
					self.phoneSubject.accept(self.model?.ProductID ?? "" )
					self.subcriptionSubject.accept(total)
				case "2","3":
					let total = (model.Gia + (Cache.packageBookSim?.GiaCuoc ?? 0) )
					self.codeTextField.text = Cache.packageBookSim?.MaGoiCuoc ?? ""
					self.packagePriceLabel.text = "\(Cache.packageBookSim?.GiaCuoc ?? 0)đ"
					self.subcriptionSubject.accept(Cache.packageBookSim?.GiaCuoc ?? 0)
					self.subscriptionPriceLabel.text = "\(Common.convertCurrencyV2(value: self.model?.Gia ?? 0))đ"
					self.totalLabel.text = "\(Common.convertCurrencyV2(value: (model.Gia + (Cache.packageBookSim?.GiaCuoc ?? 0))))đ"
					self.phoneTextField.text = self.model?.ProductID ?? ""
					self.phoneSubject.accept(self.model?.ProductID ?? "" )
					self.subcriptionSubject.accept(total)
				default :
					return
			}

		}

	}
	private func bindViewModel(){
		let imeiSubject = Driver.merge(serialSubject.asDriver(onErrorJustReturn: ""),searialTextField.rx.text.orEmpty.asDriver())
		let phoneMergeSubject = Driver.merge(self.phoneSubject.asDriver(onErrorJustReturn: ""),phoneTextField.rx.text.orEmpty.asDriver())
		let input = CustomerBookSimVinaViewModel.Input( subscriptionSubject:subcriptionSubject.asDriver(onErrorJustReturn: 0) ,
														nameSubject:nameTextField.rx.text.orEmpty.asDriver() ,
														idCardSubject: idCardTextField.rx.text.orEmpty.asDriver(),
														phoneSubject: phoneMergeSubject.asDriver(onErrorJustReturn: ""),
														searialSubject: imeiSubject.asDriver(),
														saveButtonClicked: saveButton.rx.tap.asDriver())
		let output = viewmodel.transform(input)

		output.errorMessage.drive { [weak self ] errorMsg in
			guard let self = self else { return }
			self.showAlert(errorMsg)
		}.disposed(by: bag)

		output.responseAddBookSim.drive { value in
			switch value.success {
				case true:
					self.showAlertOneButton(title: "Thông báo", with: value.mess, titleButton: "Đồng ý",handleOk:{
						let vc  = ListUserMsaleVinaphoneViewController()
						vc.isFromAnother = true
						self.navigationController?.pushViewController(vc, animated: true)
					})
				default:
					self.showAlert(value.mess)
			}


		}.disposed(by: bag)

		output.isEnableButton.drive(self.saveButton.rx.enableWithAlpha()).disposed(by: bag)

	}
	@objc private func handleShowScanBarcode(){
		let viewController = ScanCodeViewController()
		viewController.scanSuccess = { text in
			self.searialTextField.text = text
			self.serialSubject.onNext(text)
		}
		self.present(viewController, animated: false, completion: nil)
	}

}

extension Reactive where Base: UIButton {

	func enableWithAlpha(_ alpha: CGFloat = 0.8) -> Binder<Bool> {
		return Binder(base, binding: { (button, enabled) in
			button.isEnabled = enabled
			button.alpha = enabled ? 1.0 : alpha
		})
	}

}
