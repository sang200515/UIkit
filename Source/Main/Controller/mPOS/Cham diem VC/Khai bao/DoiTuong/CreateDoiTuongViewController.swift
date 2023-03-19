//
//  DetailKhaiBaoDoiTuongViewController.swift
//  fptshop
//
//  Created by Apple on 5/30/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class CreateDoiTuongViewController: UIViewController {
    
    var tfDoiTuongName: UITextField!
    var tfMucDiemValue: UITextField!
    var btnConfirm: UIButton!
    var isScorPercent = false
    var imgCheckPercent: UIImageView!
    var doiTuongChamDiem: DoiTuongChamDiem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "KHAI BÁO ĐỐI TƯỢNG CHẤM ĐIỂM"
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:30), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:30), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        self.setUpView()
    }
    
    func setUpView() {
        let lbTenDoiTuong = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 15), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbTenDoiTuong.text = "Tên đối tượng:"
        lbTenDoiTuong.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lbTenDoiTuong)
        
        tfDoiTuongName = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lbTenDoiTuong.frame.origin.y + lbTenDoiTuong.frame.height + Common.Size(s: 5), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfDoiTuongName.placeholder = "Nhập tên đối tượng"
        tfDoiTuongName.font = UIFont.systemFont(ofSize: 14)
        tfDoiTuongName.borderStyle = .roundedRect
        tfDoiTuongName.clearButtonMode = UITextField.ViewMode.whileEditing
        self.view.addSubview(tfDoiTuongName)
        
        let lbMucDiem = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfDoiTuongName.frame.origin.y + tfDoiTuongName.frame.height + Common.Size(s: 10), width: lbTenDoiTuong.frame.width, height: Common.Size(s: 20)))
        lbMucDiem.text = "Mức điểm:"
        lbMucDiem.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lbMucDiem)
        
        tfMucDiemValue = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lbMucDiem.frame.origin.y + lbMucDiem.frame.height + Common.Size(s: 5), width: tfDoiTuongName.frame.width, height: tfDoiTuongName.frame.height))
        tfMucDiemValue.placeholder = "Nhập mức điểm"
        tfMucDiemValue.font = UIFont.systemFont(ofSize: 14)
        tfMucDiemValue.borderStyle = .roundedRect
        tfMucDiemValue.keyboardType = .numberPad
        tfMucDiemValue.clearButtonMode = UITextField.ViewMode.whileEditing
        self.view.addSubview(tfMucDiemValue)
        
        //--
        imgCheckPercent = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: tfMucDiemValue.frame.origin.y + tfMucDiemValue.frame.height + Common.Size(s: 15), width: Common.Size(s: 15), height: Common.Size(s: 15)))
        if self.isScorPercent == false {
            imgCheckPercent.image = #imageLiteral(resourceName: "check-2-1")
        } else {
            imgCheckPercent.image = #imageLiteral(resourceName: "check-1-1")
        }
        self.view.addSubview(imgCheckPercent)
        
        let tapChangeCheckPercent = UITapGestureRecognizer(target: self, action: #selector(changeCheckPercent))
        imgCheckPercent.isUserInteractionEnabled = true
        imgCheckPercent.addGestureRecognizer(tapChangeCheckPercent)
        
        let lbPercent = UILabel(frame: CGRect(x: imgCheckPercent.frame.origin.x + imgCheckPercent.frame.width + Common.Size(s: 10), y: imgCheckPercent.frame.origin.y, width: lbTenDoiTuong.frame.width, height: Common.Size(s: 20)))
        lbPercent.text = "Tính theo %"
        lbPercent.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lbPercent)
        
        btnConfirm = UIButton(frame: CGRect(x: Common.Size(s: 15), y: self.view.frame.height - (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height) - Common.Size(s: 65), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        btnConfirm.setTitle("XÁC NHẬN", for: .normal)
        btnConfirm.titleLabel?.textColor = UIColor.white
        btnConfirm.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btnConfirm.layer.cornerRadius = 5
        btnConfirm.backgroundColor = UIColor(red: 34/255, green: 134/255, blue: 70/255, alpha: 1)
        self.view.addSubview(btnConfirm)
        btnConfirm.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        
        if self.doiTuongChamDiem != nil {
            tfDoiTuongName.text = doiTuongChamDiem?.ObjectName ?? ""
            tfMucDiemValue.text = "\(doiTuongChamDiem?.ScoreLevel ?? 0)"
            if doiTuongChamDiem?.Percent == true {
                imgCheckPercent.image = #imageLiteral(resourceName: "check-1-1")
            } else {
                imgCheckPercent.image = #imageLiteral(resourceName: "check-2-1")
            }
        }
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func confirm(){
        guard let objectName = self.tfDoiTuongName.text, !objectName.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập tên đối tượng!")
            return
        }
        
        guard let mucDiem = self.tfMucDiemValue.text, !mucDiem.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập mức điểm!")
            return
        }
        
        let isPercent = self.isScorPercent == true ? 1 : 0
        
        if self.doiTuongChamDiem == nil {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.Score_CreateObject(ObjectName: objectName, ScoreLevel: Int(mucDiem) ?? 0, Percent: isPercent, handler: { (results, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if results.count > 0 {
                            if results[0].Result == 1 {
                                let alertVC = UIAlertController(title: "Thông báo", message: "\(results[0].Message)", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                    //                                    for vc in self.navigationController?.viewControllers ?? [] {
                                    //                                        if vc is KhaiBaoViewController {
                                    //                                            self.navigationController?.popToViewController(vc, animated: true)
                                    //                                        }
                                    //                                    }
                                    self.navigationController?.popViewController(animated: true)
                                })
                                alertVC.addAction(action)
                                self.present(alertVC, animated: true, completion: nil)
                            } else {
                                self.showAlert(title: "Thông báo", message: "\(results[0].Message)")
                            }
                        } else{
                            self.showAlert(title: "Thông báo", message: "\(err)")
                        }
                    }
                })
            }
        } else { //update
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.Score_UpdateObject(ObjectName: objectName, ScoreLevel: Int(mucDiem) ?? 0, Percent: isPercent, ObjectId: self.doiTuongChamDiem?.ObjectID ?? 0, handler: { (results, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if results.count > 0 {
                            if results[0].Result == 1 {
                                let alertVC = UIAlertController(title: "Thông báo", message: "\(results[0].Message)", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                    //                                    for vc in self.navigationController?.viewControllers ?? [] {
                                    //                                        if vc is KhaiBaoViewController {
                                    //                                            self.navigationController?.popToViewController(vc, animated: true)
                                    //                                        }
                                    //                                    }
                                    self.navigationController?.popViewController(animated: true)
                                })
                                alertVC.addAction(action)
                                self.present(alertVC, animated: true, completion: nil)
                            } else {
                                self.showAlert(title: "Thông báo", message: "\(results[0].Message)")
                            }
                        } else {
                            self.showAlert(title: "Thông báo", message: "\(err)")
                        }
                    }
                })
            }
        }
        
    }
    
    @objc func changeCheckPercent(){
        isScorPercent = !isScorPercent
        
        if self.isScorPercent == false {
            imgCheckPercent.image = #imageLiteral(resourceName: "check-2-1")
        } else {
            imgCheckPercent.image = #imageLiteral(resourceName: "check-1-1")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}
