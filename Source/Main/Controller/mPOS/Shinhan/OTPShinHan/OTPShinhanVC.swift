//
//  OTPShinhanVC.swift
//  QuickCode
//
//  Created by Sang Trương on 15/09/2022.
//

import SnapKit
import UIKit
import Alamofire

class OTPShinhanVC: UIViewController {
	//MARK: - Variable
	private var timer: Timer!
	private var count = 300
	private var countNumber = 0
	private var timeStart = ""
	 var mposNum: String = ""
    var isFromHistory:Bool = false
	//MARK: - Properties
	@IBOutlet weak var otpTextField: UITextField!
	@IBOutlet weak var countDownLabel: UILabel!
	@IBOutlet weak var sendOTPButton: UIButton!
	@IBOutlet weak var resendOTPButton: UIButton!
	@IBOutlet weak var saveButton: UIButton!

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()

        if !isFromHistory{
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            addBackToRoot()
        }
	}
	// MARK: - API
	private func getOTP() {

		Provider.shared.getOTPShinhanAPIService.getOTP(
			mposNumber: mposNum,
			success: { [weak self] result in
				guard let self = self else { return }
				self.sendOTPButton.isHidden = false
				if result?.status == 0 {
					self.showAlertWithTitleColor(
						colorTitle: UIColor(hexString: "#EB3223"), titleAlert: "Thất bại",
						with: result?.message ?? "", titleButton: "Thử lại")
				} else if result?.status == 1 {
					self.startTimerWith(minute: 5)
					self.showAlertWithTitleColor(
						colorTitle: UIColor(hexString: "#4DA773"), titleAlert: "Thành công",
						with: result?.message ?? "", titleButton: "Đồng ý",
						handleOk: {
							self.sendOTPButton.isHidden = true
						})

				} else if result?.status == 2 {
					self.showAlertOneButton(
						title: "Thông báo", with: "\(result?.message ?? "")",
						titleButton: "Đồng ý")
				}

			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
			})
	}
	private func resendOTP() {
		self.sendOTPButton.isHidden = true
		Provider.shared.getOTPShinhanAPIService.getOTP(
			mposNumber: mposNum,
			success: { [weak self] result in
				guard let self = self else { return }
				if result?.status == 1 {
					self.showAlertOneButton(
						title: "Thông báo", with: "\(result?.message ?? "")",
						titleButton: "Đồng ý")
				} else {
                    self.sendOTPButton.isHidden = false
					self.showAlertOneButton(
						title: "Thông báo", with: "\(result?.message ?? "")",
						titleButton: "Đồng ý")
				}
			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
			})
	}
	private func verifyOTP(OTP: String) {
		Provider.shared.getOTPShinhanAPIService.verifyOTP(
			mposNumber: mposNum, OTP: OTP,
			success: { [weak self] result in
				guard let self = self else { return }
                if result?.status != 1 {
                    self.showAlert(result?.message ?? "")
                }else {
                    self.showAlertOneButton(title: "Thông báo", with: result?.message ?? "", titleButton: "OK",handleOk:  {
                        let vc = SearchCustomerController()
                        vc.isFromShinhan = true
                        self.navigationController?.pushViewController(vc, animated: true)

                    })
                }
			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
			})
	}
	// MARK: - Selectors
	@IBAction func saveButton(_ sender: Any) {
        if otpTextField.text?.count ?? 0 == 0 {
            self.showAlert("Vui lòng nhập OTP")
        }else {
            verifyOTP(OTP: otpTextField.text!)
        }

	}
	@IBAction func sendOTP(_ sender: Any) {
		getOTP()
		//        verifyOTP()
	}
	@IBAction func resendOTP(_ sender: Any) {
		resendOTP()
	}
    
    func addBackToRoot(_ selector: Selector? = nil) {
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: selector == nil ? #selector(backButtonPressed) : selector!, for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
    }
    @objc override func backButtonPressed() {
        self.navigationController?.popToRootViewController(animated: true)
    }

	@objc func updateTimer() {
		if self.countNumber != 0 {
			self.countNumber -= 1  // decrease counter timer
		} else {
			if let timer = self.timer {
				timer.invalidate()
				self.timer = nil
			}
		}
		DispatchQueue.global(qos: .background).async {
			DispatchQueue.main.async {
				self.countDownLabel.text = "Còn lại \(self.timeFormatted(self.countNumber))"
			}
		}
		if self.countNumber == 0 {
			self.timer?.invalidate()
			self.timer = nil
			self.showAlertOneButton(
				title: "Thông báo",
				with: "Mã OTP đã hết hạn.Shop vui lòng gửi lại mã OTP khác cho khách hàng nhé.",
                titleButton: "OK",handleOk: {
                    self.sendOTPButton.isHidden = false
                })
		}
	}

	// MARK: - Helpers
	private func setupUI() {
		otpTextField.clearButtonMode = .whileEditing
		resendOTPButton.underline(title: "Gửi lại mã")
		resendOTPButton.setTitleColor(.white, for: .normal)
	}

	private func startTimerWith(minute: Int) {
		self.countNumber = minute * 60
		self.timer = Timer.scheduledTimer(
			timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil,
			repeats: true)

	}

	private func timeFormatted(_ totalSeconds: Int) -> String {
		let seconds: Int = totalSeconds % 60
		let minutes: Int = (totalSeconds / 60) % 60
		return String(format: "%02d:%02d", minutes, seconds)
	}

}
