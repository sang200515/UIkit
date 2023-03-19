//
//  AddNewCheckListShopASMViewController.swift
//  fptshop
//
//  Created by Apple on 8/8/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class AddNewCheckListShopASMViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    
    var lbChooseShop: UILabel!
    var tvThongBao1: UITextView!
    var tvThongBao2: UITextView!
    var tvThongBao3: UITextView!
    var tvThongBao4: UITextView!
    var btnSendThongBao: UIButton!
    static var shopCodeStr = ""
    var shopNameString = ""
    var thongBaoView: UIView!
    
    //Setting up view to portrait when view disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        if (self.isMovingFromParent) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
        self.view.subviews.forEach({$0.removeFromSuperview()});
    }

    @objc func canRotate() -> Void{}


    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent;
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .allButUpsideDown;
    }
    override var shouldAutorotate: Bool{
        return true;
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            let orient = UIApplication.shared.statusBarOrientation

            switch orient {
            case .portrait:
                self.view.subviews.forEach({ $0.removeFromSuperview() });
                self.setUpView()
            case .landscapeLeft,.landscapeRight :
                self.view.subviews.forEach({ $0.removeFromSuperview() });
                self.setUpView()
            default:
                print("Upside down, and that is not supported");
            }

        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in})
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.subviews.forEach({ $0.removeFromSuperview() });
        self.setUpView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add New Shop ASM"
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 45)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        setUpView()
    }
    
    func setUpView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        //        let lbShop = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 15), width: (scrollView.frame.width - Common.Size(s: 15))/4, height: Common.Size(s: 25)))
        let lbShop = UILabel(frame: CGRect(x: 15, y: 15, width: (scrollView.frame.width - 15)/4, height: 25))
        lbShop.text = "Shop"
        lbShop.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbShop)
        
        //        lbChooseShop = UILabel(frame: CGRect(x: lbShop.frame.origin.x + lbShop.frame.width, y: lbShop.frame.origin.y, width: scrollView.frame.width - lbShop.frame.width - Common.Size(s: 30), height: Common.Size(s: 25)))
        lbChooseShop = UILabel(frame: CGRect(x: lbShop.frame.origin.x + lbShop.frame.width, y: lbShop.frame.origin.y, width: scrollView.frame.width - lbShop.frame.width - 30, height: 30))
//        lbChooseShop.text = "Chọn all và 1 hoặc nhiều shop"
        lbChooseShop.textAlignment = .center
        lbChooseShop.font = UIFont.systemFont(ofSize: 14)
        lbChooseShop.layer.borderColor = UIColor.lightGray.cgColor
        lbChooseShop.layer.borderWidth = 1
        scrollView.addSubview(lbChooseShop)
        
        if AddNewCheckListShopASMViewController.shopCodeStr != "" {
            lbChooseShop.text = self.shopNameString
        } else {
            lbChooseShop.text = "Chọn all và 1 hoặc nhiều shop"
        }
        
        let lbChooseShopHeight: CGFloat = lbChooseShop.optimalHeight < 30 ? 30 : lbChooseShop.optimalHeight
        lbChooseShop.numberOfLines = 0
        lbChooseShop.frame = CGRect(x: lbChooseShop.frame.origin.x, y: lbChooseShop.frame.origin.y, width: lbChooseShop.frame.width, height: lbChooseShopHeight)
        
        let tapShowListShop = UITapGestureRecognizer(target: self, action: #selector(showListShop))
        lbChooseShop.isUserInteractionEnabled = true
        lbChooseShop.addGestureRecognizer(tapShowListShop)
        
        //        thongBaoView = UIView(frame: CGRect(x: 0, y: lbChooseShop.frame.origin.y + lbChooseShopHeight + Common.Size(s: 10), width: scrollView.frame.width, height: Common.Size(s: 20)))
        thongBaoView = UIView(frame: CGRect(x: 0, y: lbChooseShop.frame.origin.y + lbChooseShopHeight + 10, width: scrollView.frame.width, height: 20))
        thongBaoView.backgroundColor = .white
        scrollView.addSubview(thongBaoView)
        
        //        let lbThongBao1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbChooseShop.frame.origin.y + lbChooseShopHeight + Common.Size(s: 10), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        //        let lbThongBao1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        let lbThongBao1 = UILabel(frame: CGRect(x: 15, y: 0, width: scrollView.frame.width - 30, height: 20))
        lbThongBao1.text = "Thông báo 1"
        lbThongBao1.font = UIFont.systemFont(ofSize: 14)
        thongBaoView.addSubview(lbThongBao1)
        
        //        tvThongBao1 = UITextView(frame: CGRect(x: Common.Size(s: 15), y: lbThongBao1.frame.origin.y + lbThongBao1.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 120)))
        tvThongBao1 = UITextView(frame: CGRect(x: 15, y: lbThongBao1.frame.origin.y + lbThongBao1.frame.height + 5, width: scrollView.frame.width - 30, height: 120))
        tvThongBao1.font = UIFont.systemFont(ofSize: 14)
        tvThongBao1.layer.borderColor = UIColor.lightGray.cgColor
        tvThongBao1.layer.borderWidth = 1
        tvThongBao1.layer.cornerRadius = 5
        //        tvThongBao1.placeholder = "Nhập thông báo 1"
        thongBaoView.addSubview(tvThongBao1)
        
        //        let lbThongBao2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tvThongBao1.frame.origin.y + tvThongBao1.frame.height + Common.Size(s: 10), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        let lbThongBao2 = UILabel(frame: CGRect(x: 15, y: tvThongBao1.frame.origin.y + tvThongBao1.frame.height + Common.Size(s: 10), width: scrollView.frame.width - 30, height: 20))
        lbThongBao2.text = "Thông báo 2"
        lbThongBao2.font = UIFont.systemFont(ofSize: 14)
        thongBaoView.addSubview(lbThongBao2)
        
        //        tvThongBao2 = UITextView(frame: CGRect(x: Common.Size(s: 15), y: lbThongBao2.frame.origin.y + lbThongBao2.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 120)))
        tvThongBao2 = UITextView(frame: CGRect(x: 15, y: lbThongBao2.frame.origin.y + lbThongBao2.frame.height + 5, width: scrollView.frame.width - 30, height: 120))
        tvThongBao2.font = UIFont.systemFont(ofSize: 14)
        tvThongBao2.layer.borderColor = UIColor.lightGray.cgColor
        tvThongBao2.layer.borderWidth = 1
        tvThongBao2.layer.cornerRadius = 5
        //        tvThongBao2.placeholder = "Nhập thông báo 2"
        thongBaoView.addSubview(tvThongBao2)
        
        //        let lbThongBao3 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tvThongBao2.frame.origin.y + tvThongBao2.frame.height + Common.Size(s: 10), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        let lbThongBao3 = UILabel(frame: CGRect(x: 15, y: tvThongBao2.frame.origin.y + tvThongBao2.frame.height + 10, width: scrollView.frame.width - 30, height: 20))
        lbThongBao3.text = "Thông báo 3"
        lbThongBao3.font = UIFont.systemFont(ofSize: 14)
        thongBaoView.addSubview(lbThongBao3)
        
        //        tvThongBao3 = UITextView(frame: CGRect(x: Common.Size(s: 15), y: lbThongBao3.frame.origin.y + lbThongBao3.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 120)))
        tvThongBao3 = UITextView(frame: CGRect(x: 15, y: lbThongBao3.frame.origin.y + lbThongBao3.frame.height + 5, width: scrollView.frame.width - 30, height: 120))
        tvThongBao3.font = UIFont.systemFont(ofSize: 14)
        tvThongBao3.layer.borderColor = UIColor.lightGray.cgColor
        tvThongBao3.layer.borderWidth = 1
        tvThongBao3.layer.cornerRadius = 5
        //        tvThongBao3.placeholder = "Nhập thông báo 3"
        thongBaoView.addSubview(tvThongBao3)
        
        //        let lbThongBao4 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tvThongBao3.frame.origin.y + tvThongBao3.frame.height + Common.Size(s: 10), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        let lbThongBao4 = UILabel(frame: CGRect(x: 15, y: tvThongBao3.frame.origin.y + tvThongBao3.frame.height + 10, width: scrollView.frame.width - 30, height: 20))
        lbThongBao4.text = "Thông báo 4"
        lbThongBao4.font = UIFont.systemFont(ofSize: 14)
        thongBaoView.addSubview(lbThongBao4)
        
        //        tvThongBao4 = UITextView(frame: CGRect(x: Common.Size(s: 15), y: lbThongBao4.frame.origin.y + lbThongBao4.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 120)))
        tvThongBao4 = UITextView(frame: CGRect(x: 15, y: lbThongBao4.frame.origin.y + lbThongBao4.frame.height + 5, width: scrollView.frame.width - 30, height: 120))
        tvThongBao4.font = UIFont.systemFont(ofSize: 14)
        tvThongBao4.layer.borderColor = UIColor.lightGray.cgColor
        tvThongBao4.layer.borderWidth = 1
        tvThongBao4.layer.cornerRadius = 5
        //        tvThongBao4.placeholder = "Nhập thông báo 4"
        thongBaoView.addSubview(tvThongBao4)
        
        thongBaoView.frame = CGRect(x: thongBaoView.frame.origin.x, y: thongBaoView.frame.origin.y, width: thongBaoView.frame.width, height: tvThongBao4.frame.origin.y + tvThongBao4.frame.height + Common.Size(s: 5))
        
        //        btnSendThongBao = UIButton(frame: CGRect(x: Common.Size(s: 15), y: thongBaoView.frame.origin.y + thongBaoView.frame.height + Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 45)))
        btnSendThongBao = UIButton(frame: CGRect(x: 15, y: thongBaoView.frame.origin.y + thongBaoView.frame.height + 15, width: scrollView.frame.width - 30, height: 45))
        btnSendThongBao.setTitle("GỬI THÔNG BÁO", for: .normal)
        btnSendThongBao.backgroundColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        btnSendThongBao.layer.cornerRadius = 5
        scrollView.addSubview(btnSendThongBao)
        btnSendThongBao.addTarget(self, action: #selector(sendThongBao), for: .touchUpInside)
        
        scrollViewHeight = btnSendThongBao.frame.origin.y + btnSendThongBao.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
            + Common.Size(s: 30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showListShop() {
        let vc = ShowShopASMViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func sendThongBao() {
        guard let shop = self.lbChooseShop.text, (!shop.isEmpty) && (shop != "Chọn all và 1 hoặc nhiều shop") else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa chọn shop!")
            return
        }
        
        if tvThongBao1.text.isEmpty && tvThongBao2.text.isEmpty && tvThongBao3.text.isEmpty && tvThongBao4.text.isEmpty {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập thông báo!")
            return
        } else {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                let rs = mSMApiManager.CheckListShop_insert(p_List_shop: AddNewCheckListShopASMViewController.shopCodeStr, p_content1: self.tvThongBao1.text ?? "", p_content2: self.tvThongBao2.text ?? "", p_content3: self.tvThongBao3.text ?? "", p_content4: self.tvThongBao4.text ?? "").Data ?? []
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if rs.count > 0 {
                        if rs[0].p_status == 1 {
                            let alertVC = UIAlertController(title: "Thông báo", message: "\(rs[0].p_messagess ?? "Lưu thành công. Vui lòng vào lịch sử kiểm tra lại!")", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                self.navigationController?.popViewController(animated: true)
                            })
                            self.dismiss(animated: true, completion: nil)
                            alertVC.addAction(action)
                            self.present(alertVC, animated: true, completion: nil)
                        
                        } else{
                            self.showAlert(title: "Thông báo", message: "\(rs[0].p_messagess ?? "Lưu thất bại!")")
                        }
                    } else {
                        debugPrint("load api err")
                    }
                }
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension AddNewCheckListShopASMViewController: ShowShopASMViewControllerDelegate {
    func getListShop(nameString: String, codeString: String) {
        if nameString.isEmpty {
            self.lbChooseShop.text = "Chọn all và 1 hoặc nhiều shop"
        } else {
            self.lbChooseShop.text = nameString
            self.shopNameString = nameString
        }
        
        AddNewCheckListShopASMViewController.shopCodeStr = codeString
        
        let lbChooseShopHeight: CGFloat = lbChooseShop.optimalHeight < 30 ? 30 : lbChooseShop.optimalHeight
        lbChooseShop.numberOfLines = 0
        lbChooseShop.frame = CGRect(x: lbChooseShop.frame.origin.x, y: lbChooseShop.frame.origin.y, width: lbChooseShop.frame.width, height: lbChooseShopHeight)
        
        thongBaoView.frame = CGRect(x: thongBaoView.frame.origin.x, y: lbChooseShop.frame.origin.y + lbChooseShopHeight + 10, width: thongBaoView.frame.width, height: thongBaoView.frame.height)
        
        btnSendThongBao.frame = CGRect(x: btnSendThongBao.frame.origin.x, y: thongBaoView.frame.origin.y + thongBaoView.frame.height + 15, width: btnSendThongBao.frame.width, height: btnSendThongBao.frame.height)
        
        scrollViewHeight = btnSendThongBao.frame.origin.y + btnSendThongBao.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
            + Common.Size(s: 30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
    }
}
