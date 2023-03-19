//
//  SplashViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import PopupDialog
import UIKit

class SplashViewController: UIViewController {
	private var revealingLoaded = false
	weak var timer: Timer?
	private var startTime: Double = 0
	private var time: Double = 0
	private var milisecondToShow: Int = 0
	private var secondToShow: Int = 0
	private var isTopTimer = false
	private let revealingSplashView = RevealingSplashView(
		iconImage: UIImage(named: "fptshop-white")!,
		iconInitialSize: CGSize(width: UIScreen.main.bounds.width * 0.75, height: 60),
		backgroundColor: #colorLiteral(
			red: 0.01877964661, green: 0.6705997586, blue: 0.4313761592, alpha: 1))
	override var shouldAutorotate: Bool {
		return revealingLoaded
	}
	deinit {
		print("plash deinit")
	}
	//    var loading:LoadingWhiteView!
	private static var _manager = Config.manager
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		initAnimation()
		startTime = Date().timeIntervalSinceReferenceDate
		timer = Timer.scheduledTimer(
			timeInterval: 0.02,
			target: self,
			selector: #selector(advanceTimer(timer:)),
			userInfo: nil,
			repeats: true)
	}
	override func viewDidLoad() {
		super.viewDidLoad()

		createGradientLayer()
		//        APIManager.login(Username: "5387", password: "123456HUYEN@@") { (result, err) in
		//            debugPrint(result)
		//        }
		//        APIManager.checkVersion(appType: "1", version: "1.0.1") { (result, err) in
		//            debugPrint(result)
		//        }

		let width = UIScreen.main.bounds.size.width
		let height = UIScreen.main.bounds.size.height
		self.view.backgroundColor = .white

		//        let logo = UIImageView(frame: CGRect(x:width/6,y: height/3 - (width * 2 / 3 / 3.77)/2 ,width:width * 2 / 3,height: width * 2 / 3 / 3.77 ))
		//        logo.image = UIImage(named: "fptshop-white")
		//        logo.contentMode = .scaleAspectFit
		//        self.view.addSubview(logo)

		//        #if DEBUG
		//        let lbCopyright = UILabel(frame: CGRect(x: 0, y: height - Common.Size(s:15) - Common.Size(s:10), width: width, height: Common.Size(s:15)))
		//        lbCopyright.textAlignment = .center
		//        lbCopyright.textColor = UIColor.gray
		//        lbCopyright.font = UIFont.systemFont(ofSize: Common.Size(s: 11))
		//        lbCopyright.text = "Version \(Common.versionApp())"
		//        lbCopyright.numberOfLines = 3
		//        self.view.addSubview(lbCopyright)
		//        #endif

		//        loading = LoadingWhiteView()
		//        loading.frame = CGRect(x: self.view.frame.size.width/2 - 45/2, y: height * 5/6, width: 45, height: 45)
		//        self.view.addSubview(loading)
		let defaults = UserDefaults.standard
		if defaults.string(forKey: "Username") != nil {
			self.checkLogin()
		} else {
			DispatchQueue.main.asyncAfter(
				deadline: .now(),
				execute: {
					self.goToLogin(is_getaway: 1)
				})
		}
	}

	func createGradientLayer() {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = self.view.bounds
		gradientLayer.colors = [UIColor(netHex: 0x21CE9F).cgColor, UIColor(netHex: 0x00955E).cgColor]
		//        gradientLayer.startPoint = CGPoint(x:0.0,y:0.0)
		//        gradientLayer.endPoint = CGPoint(x:1.0,y: 0.0)
		gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
		gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
		self.view.layer.addSublayer(gradientLayer)
	}

	private func checkLogin() {
		let defaults = UserDefaults.standard
		defaults.removeListUpdateModule()
		defaults.removeIsUpdateVersionRoot()
		defaults.removeGetUpdateDescription()
		let versionApp: String = Common.myCustomVersionApp() ?? ""
		guard let userCode = UserDefaults.standard.getUsernameEmployee() else { return }
		let params: [String: Any] = [
			"Devicetype": 2,
			"Version": versionApp,
			"Usercode": userCode,
		]

		NewCheckVersionAPIManager.shared.newCheckVersion(params) { [weak self] (resultCheckVersion, errorCheckVersion) in
			guard let strongSelf = self else { return }

			DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
				if let item = resultCheckVersion {
					guard let isGateway = item.isGateway else { return }
					Cache.is_getaway = 1  //isGateway
					if item.version != versionApp {
						// Check Update Root
						guard let description = item.descriptions else { return }
						UserDefaults.standard.setUpdateDescription(description)
						if item.isUpdateApp == 1 {
							UserDefaults.standard.setIsUpdateVersionRoot(isUpdate: true)
							strongSelf.showPopUpCustom(
								title: "Thông báo", titleButtonOk: "Cập nhật",
								titleButtonCancel: nil, message: description,
								actionButtonOk: {
									guard
										let url = URL(
											string:
												"\(Config.manager.URL_UPDATE!)"
										)
									else {
										return
									}
									if #available(iOS 10.0, *) {
										UIApplication.shared.open(
											url, options: [:],
											completionHandler: nil)
									} else {
										UIApplication.shared.openURL(url)
									}
								}, actionButtonCancel: nil, isHideButtonOk: false,
								isHideButtonCancel: true)
							return
						}

						// Check Update Module
						if item.isUpdateApp == 0 {
							UserDefaults.standard.setIsUpdateVersionRoot(isUpdate: false)
							if let listModule = item.listModule {
								let description = item.descriptions
								strongSelf.showPopUpCustom(
									title: "Thông báo", titleButtonOk: "Cập nhật",
									titleButtonCancel: "Huỷ", message: description,
									actionButtonOk: {
										guard
											let url = URL(
												string:
													"\(Config.manager.URL_UPDATE!)"
											)
										else {
											return
										}

										if #available(iOS 10.0, *) {
											UIApplication.shared.open(
												url, options: [:],
												completionHandler: nil)
										} else {
											UIApplication.shared.openURL(
												url)
										}
									},
									actionButtonCancel: {
										UserDefaults.standard.setListUpdateApp(
											list: listModule)
										if isGateway == 0 {
											strongSelf.loginAPI(
												is_gateway: 0)
										} else {
											strongSelf.loginAPI(
												is_gateway: 1)
										}
									}, isHideButtonOk: false,
									isHideButtonCancel: false)
							}
						}
					} else {
						if isGateway == 0 {
							strongSelf.loginAPI(is_gateway: 0)
						} else {
							strongSelf.loginAPI(is_gateway: 1)
						}
					}
				} else {
					strongSelf.showPopUpCustom(
						title: "Thông báo", titleButtonOk: "Đồng ý", titleButtonCancel: nil,
						message: "\(errorCheckVersion ?? "")",
						actionButtonOk: {
							DispatchQueue.main.asyncAfter(
								deadline: .now(),
								execute: {
									self?.goToLogin(is_getaway: 1)
								})
						}, actionButtonCancel: nil, isHideButtonOk: false,
						isHideButtonCancel: true)
				}
			}
		}
	}

	private func loginAPI(is_gateway: Int) {
		let defaults = UserDefaults.standard
		let gateway = defaults.integer(forKey: "is_getaway")
		if gateway != Cache.is_getaway {
			self.loadCache(is_getaway: is_gateway)
			return
		}

		if let Username = defaults.string(forKey: "Username") {
			APIManager.mpos_sp_GateWay_GetInfoLogin(
				UserName: Username,
				handler: { (result, err) in
					if result != nil {
						//CHECK RULE MENU
						APIManager.sp_mpos_FRT_SP_oneapp_CheckMenu(
							UserName: Username,
							handler: { (results, err) in
								if err.count <= 0 {
									if results.count > 0 {
										Cache.ruleMenus = results
										let defaults = UserDefaults.standard
										defaults.set(
											Username, forKey: "Username")
										defaults.synchronize()
										Cache.user = result!
										APIManager.registerDeviceToken()
										self.getListShiftChamCong(is_getaway: 1)
									} else {
										let popup = PopupDialog(
											title: "Thông báo",
											message:
												"Bạn không được cấp quyền sử dụng ứng dụng.\r\nVui lòng kiểm tra lại.",
											buttonAlignment: .horizontal,
											transitionStyle: .zoomIn,
											tapGestureDismissal: false,
											panGestureDismissal: false,
											hideStatusBar: false
										) {
											print("Completed")
										}
										let buttonOne = CancelButton(
											title: "Thử lại"
										) {
											self.checkLogin()
										}
										popup.addButtons([buttonOne])
										self.present(
											popup, animated: true,
											completion: nil)
									}
								} else {
									let popup = PopupDialog(
										title: "Thông báo", message: err,
										buttonAlignment: .horizontal,
										transitionStyle: .zoomIn,
										tapGestureDismissal: false,
										panGestureDismissal: false,
										hideStatusBar: false
									) {
										print("Completed")
									}
									let buttonOne = CancelButton(title: "Thử lại") {
										self.checkLogin()
									}
									popup.addButtons([buttonOne])
									self.present(
										popup, animated: true, completion: nil)
								}
							})
					} else {
						self.loadCache(is_getaway: is_gateway)
					}
				})
		} else {
			self.loadCache(is_getaway: is_gateway)
		}
	}

	func loadCache(is_getaway: Int) {
		let defaults = UserDefaults.standard
		defaults.set(nil, forKey: "Username")
		defaults.set(nil, forKey: "password")
		defaults.set(nil, forKey: "CRMCode")
		defaults.synchronize()
		DispatchQueue.main.asyncAfter(
			deadline: .now(),
			execute: {
				self.goToLogin(is_getaway: is_getaway)
			})
	}
	func goToLogin(is_getaway: Int) {
		let mainViewController = LoginViewController()
		UIApplication.shared.keyWindow?.rootViewController = mainViewController
	}
	func goToMain(is_getaway: Int) {
		let mainViewController = MainViewController()
		UIApplication.shared.keyWindow?.rootViewController = mainViewController
	}

	func getListShiftChamCong(is_getaway: Int) {
		CRMAPIManager.GetListShiftDateByEmployee { [weak self] (rs, err) in
			if err.count <= 0 {
				if rs.count > 0 {
					Cache.arrShiftChamCong = rs
				} else {
					Cache.arrShiftChamCong = []
					debugPrint("user khong co danh sách ca làm")
				}
			} else {
				Cache.arrShiftChamCong = []
			}
			if err == "401" {
				DispatchQueue.main.asyncAfter(
					deadline: .now(),
					execute: {
						self?.goToLogin(is_getaway: 1)
					})
			} else {
				let when: Double = Double("0.\(String(describing: self?.milisecondToShow))") ?? 0
				self?.isTopTimer = true
				DispatchQueue.main.asyncAfter(
					deadline: DispatchTime.now() + when + 1.08,
					execute: {
						self?.revealingSplashView.startAnimation(stop: true)

						DispatchQueue.main.asyncAfter(
							deadline: DispatchTime.now() + 0.01,
							execute: {
								self?.goToMain(is_getaway: is_getaway)
							})
					})

				print("done when \(when)")

			}
		}
	}
	private func initAnimation() {

		self.view.addSubview(revealingSplashView)

		revealingSplashView.duration = 2.0

		revealingSplashView.iconColor = UIColor.red
		revealingSplashView.useCustomIconColor = false

		revealingSplashView.animationType = SplashAnimationType.popAndZoomOut

		revealingSplashView.startAnimation(stop: false)
		//3s66

	}
	@objc func advanceTimer(timer: Timer) {
		time = Date().timeIntervalSinceReferenceDate - startTime
		let timeString = String(format: "%.2f", time)
		let secondToCatchAnimated: Int = Int(timeString.dropLast(3)) ?? 0
		let milisecondCatchAnimated: Int = Int(timeString.dropFirst(2)) ?? 0
		//get milisecon when action loading done
		if isTopTimer {
			timer.invalidate()
			if milisecondCatchAnimated < 33 {
				milisecondToShow = 31 - milisecondCatchAnimated
				secondToShow = secondToCatchAnimated
			} else {
				secondToShow = secondToCatchAnimated
				milisecondToShow = 131 - milisecondCatchAnimated
			}

		}

	}
	override var prefersStatusBarHidden: Bool {
		return !UIApplication.shared.isStatusBarHidden
	}

	override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
		return UIStatusBarAnimation.fade
	}
}
