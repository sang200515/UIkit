//
//  AlertCustomerCoreVC.swift
//  Created by Sang Trương
//
//  Created by Sang Trương on 29/09/2022.
//

import UIKit

class PopUpDanhGiaVC: UIViewController {
    var didSave:((String) -> Void)?
    var didResend:(() -> Void)?
    var didClosed:(() -> Void)?
	var modelNoti:ContentNotificationDanhGiaModel?
	var id:Int = 30
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var mainView: UIView!

	@IBOutlet weak var titleLabel:UILabel!
	@IBOutlet weak var ngay1Label:UILabel!
	@IBOutlet weak var ngayLabel:UILabel!
	@IBOutlet weak var nguoiDanhGiaLabel:UILabel!
	@IBOutlet weak var shopLabel:UILabel!
	@IBOutlet weak var emailLabel:UILabel!
	@IBOutlet weak var hoTenLabel:UILabel!
	@IBOutlet weak var phongBanLabel:UILabel!
	@IBOutlet weak var hangMucLabel:UILabel!
	@IBOutlet weak var capDoLabel:UILabel!
	@IBOutlet weak var lyDoLabel:UILabel!

        //    @IBOutlet weak var blurView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
		self.getDetailNotification(id:id)
    }

    private func setupUI(){
        blurView.alpha = 0.5
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeAction))
        blurView.isUserInteractionEnabled = true
        blurView.addGestureRecognizer(gesture)

	}
	private func getDetailNotification(id:Int) {
		Provider.shared.eveluateAPIService.loadContentNotification(id: id, success: { [weak self] result in
			guard let self = self else { return }
			if let respone = result {
				self.modelNoti = respone
				self.titleLabel.text = respone.title ?? ""
				self.ngayLabel.text = respone.ngay ?? ""
				self.ngay1Label.text = respone.ngay ?? ""
				self.nguoiDanhGiaLabel.text = respone.nguoiDanhGia ?? ""
				self.shopLabel.text = respone.shopPhongBanNguoiDanhGia ?? ""
				self.emailLabel.text = respone.email ?? ""
				self.hoTenLabel.text = respone.hoVaTenNhanVien ?? ""
				self.phongBanLabel.text = respone.shopPhongBanNhanVien ?? ""
				self.hangMucLabel.text = respone.hangMucGiaTri ?? ""
				self.capDoLabel.text = respone.capDoDichVu ?? ""
				self.lyDoLabel.text = respone.lyDo ?? ""
			}
		},failure: { [weak self] error in
			guard let self = self else { return }
			self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
		})
	}

    @objc func closeAction() {
		self.dismiss(animated: true)
    }

    @IBAction func didClickByPass(_ sender: Any) {
		self.dismiss(animated: true)
    }
}
