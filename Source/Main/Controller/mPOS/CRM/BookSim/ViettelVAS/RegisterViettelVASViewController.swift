//
//  RegisterViettelVASViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 3/16/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class RegisterViettelVASViewController: UIViewController {
    
    var lbCheckSdt: UILabel!
    var tfSdt: UITextField!
    var listProductViettelVAS_MainInfo = [ViettelVAS_Product]()
    var listGoiCuoc = [ViettelVASGoiCuoc_products]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Đăng ký"
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.view.backgroundColor = .white
        
        let btLeftIcon = Common.initBackButton()
        btLeftIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
        
        let lbSdt = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 8), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbSdt.text = "Số điện thoại"
        lbSdt.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lbSdt)
        
        tfSdt = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lbSdt.frame.origin.y + lbSdt.frame.height + Common.Size(s: 5), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfSdt.placeholder = "Nhập sđt"
        tfSdt.font = UIFont.systemFont(ofSize: 15)
        tfSdt.borderStyle = .roundedRect
        tfSdt.keyboardType = .numberPad
        self.view.addSubview(tfSdt)
        
        lbCheckSdt = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfSdt.frame.origin.y + tfSdt.frame.height + Common.Size(s: 3), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 30)))
        lbCheckSdt.text = ""
        lbCheckSdt.font = UIFont.italicSystemFont(ofSize: 12)
        lbCheckSdt.textColor = .red
        lbCheckSdt.numberOfLines = 2
        self.view.addSubview(lbCheckSdt)
        
        let btnCheck = UIButton(frame: CGRect(x: Common.Size(s: 15), y: lbCheckSdt.frame.origin.y + lbCheckSdt.frame.height + Common.Size(s: 5), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        btnCheck.setTitle("TRA CỨU", for: .normal)
        btnCheck.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btnCheck.setTitleColor(UIColor.white, for: .normal)
        btnCheck.backgroundColor = UIColor(netHex: 0x59B581)
        btnCheck.layer.cornerRadius = 8
        btnCheck.addTarget(self, action: #selector(checkPhone), for: .touchUpInside)
        self.view.addSubview(btnCheck)
    }
    
    @objc func handleBack(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func checkPhone() {
        self.listGoiCuoc.removeAll()
        let sdt = tfSdt.text ?? ""
        if (sdt.count == 10) && (sdt.hasPrefix("0")) && (sdt.isNumber() == true) {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                CRMAPIManager.ViettelVAS_GetListGoiCuoc(providerId: self.listProductViettelVAS_MainInfo[0].defaultProviderId, sdt: sdt) { (rs, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if err.count <= 0 {
                            if rs != nil {
                                let vc = ChonGoiCuocViettelVASViewController()
                                vc.sdtRegister = sdt
                                vc.providerId = self.listProductViettelVAS_MainInfo[0].defaultProviderId
                                
                                let dataGoi = rs?.extraProperties ?? []
                                if dataGoi.count > 0 {
                                    self.collectGoiCuoc(rsAll: self.listProductViettelVAS_MainInfo, rsGoiCuoc2: dataGoi[0].products)
                                    vc.listGoiCuocCollect = self.listGoiCuoc
                                    vc.listProductViettelVAS_MainInfo = self.listProductViettelVAS_MainInfo
                                    vc.typeGoiCuoc = dataGoi[0].type
                                }
                                self.navigationController?.pushViewController(vc, animated: true)
                            } else {
                                let alert = UIAlertController(title: "Thông báo", message: "Lấy danh sách gói cước Viettal VAS thất bại!", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            }
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        } else {
            if sdt.isEmpty {
                self.lbCheckSdt.text = "Số điện thoại không được rỗng!"
                return
            } else {
                self.lbCheckSdt.text = "Số điện thoại khách hàng không hợp lệ, mời bạn nhập lại số điện thoại!"
                return
            }
        }
    }
    
    func collectGoiCuoc(rsAll:[ViettelVAS_Product], rsGoiCuoc2: [ViettelVASGoiCuoc_products]) {
        for itemA in rsGoiCuoc2 {
            for itemB in rsAll {
                if itemB.configs.count > 0 {
                    if (itemA.mCode == itemB.configs[0].integratedProductCode) && (itemA.price == itemB.price){
                        itemA.subName = itemB.name
                        self.listGoiCuoc.append(itemA)
                    }
                }
            }
        }
    }

}
