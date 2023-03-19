//
//  ChangeSimItelViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 10/5/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown
import Presentr
import AVFoundation

class ChangeSimItelViewController: UIViewController {

    var phoneNum = ""
    var arrSimType = [ReasonCodes]()
    var tfSerial: UITextField!
    var lbChooseSimType: UILabel!
    var viewSerial: UIView!
    var view2: UIView!
    var lbPhiDoiSimValue: UILabel!
    var tfOTPText: UITextField!
    let dropMenuSimType = DropDown()
    var selectedSimType: ReasonCodes?
    var itemItelFee: GetSimFeeItel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Thay sim Itel"
        self.view.backgroundColor = .white
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        self.initSimType()
        self.setUpView()
        
//        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
//            CRMAPIManager.Itel_GetChangeSimFee(PhoneNumber: "\(self.phoneNum)") { (rs, errCode, errMessage, err) in
//                WaitingNetworkResponseAlert.DismissWaitingAlert {
//                    if err.count <= 0 {
//                        if rs != nil {
//                            self.itemItelFee = rs
//                            self.lbPhiDoiSimValue.text = "\(Common.convertCurrency(value: rs?.amount ?? 0))"
//                        } else {
//                            let alert = UIAlertController(title: "Thông báo", message: "Error \(errCode): \(errMessage)", preferredStyle: UIAlertController.Style.alert)
//                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                            alert.addAction(action)
//                            self.present(alert, animated: true, completion: nil)
//                        }
//                    } else {
//                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
//                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                        alert.addAction(action)
//                        self.present(alert, animated: true, completion: nil)
//                    }
//                }
//            }
//        }
    }
    
    func setUpView() {
        let lbSdt = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s: 8), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s: 20)))
        lbSdt.font = UIFont.systemFont(ofSize: 14)
        lbSdt.text = "Số điện thoại"
        view.addSubview(lbSdt)
        
        let tfSdtText = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbSdt.frame.origin.y + lbSdt.frame.height, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s: 35)))
        tfSdtText.font = UIFont.systemFont(ofSize: 14)
        tfSdtText.text = "\(self.phoneNum)"
        tfSdtText.borderStyle = .roundedRect
        tfSdtText.isEnabled = false
        view.addSubview(tfSdtText)
        
        let lbHinhThucDoiSim = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfSdtText.frame.origin.y + tfSdtText.frame.height + Common.Size(s:5), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s: 20)))
        lbHinhThucDoiSim.font = UIFont.systemFont(ofSize: 14)
        lbHinhThucDoiSim.text = "Hình thức đổi sim"
        view.addSubview(lbHinhThucDoiSim)
        
        lbChooseSimType = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbHinhThucDoiSim.frame.origin.y + lbHinhThucDoiSim.frame.height + Common.Size(s: 5), width: self.view.frame.width - (Common.Size(s:30)), height: Common.Size(s:35)))
        lbChooseSimType.layer.cornerRadius = 3
        lbChooseSimType.layer.borderColor = UIColor.lightGray.cgColor
        lbChooseSimType.layer.borderWidth = 0.5
        lbChooseSimType.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbChooseSimType.text = "\(self.arrSimType[0].Name)"
        view.addSubview(lbChooseSimType)

        let tapShowDropMenu = UITapGestureRecognizer(target: self, action: #selector(showDropMenuSimType))
        lbChooseSimType.isUserInteractionEnabled = true
        lbChooseSimType.addGestureRecognizer(tapShowDropMenu)
        
        viewSerial = UIView(frame: CGRect(x: 0, y: lbChooseSimType.frame.origin.y + lbChooseSimType.frame.height + Common.Size(s:5), width: view.frame.size.width, height: Common.Size(s: 60)))
        viewSerial.backgroundColor = .white
        view.addSubview(viewSerial)
        
        let lbSerial = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: viewSerial.frame.size.width - Common.Size(s:30), height: Common.Size(s: 20)))
        lbSerial.font = UIFont.systemFont(ofSize: 14)
        lbSerial.text = "Serial"
        viewSerial.addSubview(lbSerial)
        
        tfSerial = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbSerial.frame.origin.y + lbSerial.frame.height, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s: 35)))
        tfSerial.font = UIFont.systemFont(ofSize: 14)
        tfSerial.borderStyle = .roundedRect
        viewSerial.addSubview(tfSerial)
        
        let scanImgView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        let scanImg = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        scanImg.image = #imageLiteral(resourceName: "barcode")
        scanImgView.addSubview(scanImg)
        tfSerial.rightViewMode = .always
        tfSerial.rightView = scanImgView
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapScanImei))
        scanImgView.isUserInteractionEnabled = true
        scanImgView.addGestureRecognizer(tap)
        
        viewSerial.isHidden = true
        viewSerial.frame = CGRect(x: viewSerial.frame.origin.x, y: viewSerial.frame.origin.y , width: viewSerial.frame.size.width, height: 0)
        
        view2 = UIView(frame: CGRect(x: 0, y: viewSerial.frame.origin.y + viewSerial.frame.height, width: view.frame.size.width, height: Common.Size(s: 60)))
        view2.backgroundColor = .white
        view.addSubview(view2)
        
        let lbOtp = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s: 20)))
        lbOtp.font = UIFont.systemFont(ofSize: 14)
        lbOtp.text = "Nhập OTP"
        view2.addSubview(lbOtp)
        
        tfOTPText = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbOtp.frame.origin.y + lbOtp.frame.height, width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s: 35)))
        tfOTPText.font = UIFont.systemFont(ofSize: 14)
        tfOTPText.borderStyle = .roundedRect
        view2.addSubview(tfOTPText)
        
        let viewTTTT = UIView(frame: CGRect(x: 0, y: tfOTPText.frame.origin.y + tfOTPText.frame.height + Common.Size(s:10), width: view.frame.size.width, height: Common.Size(s: 35)))
        viewTTTT.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 0.8)
        view2.addSubview(viewTTTT)
        
        let lbTTTT = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: viewTTTT.frame.size.width - Common.Size(s:30), height: viewTTTT.frame.height))
        lbTTTT.font = UIFont.systemFont(ofSize: 14)
        lbTTTT.text = "THÔNG TIN THANH TOÁN"
        viewTTTT.addSubview(lbTTTT)
        
        let lbPhiDoiSim = UILabel(frame: CGRect(x: Common.Size(s:15), y: viewTTTT.frame.origin.y + viewTTTT.frame.height + Common.Size(s: 5), width: (view.frame.size.width - Common.Size(s:30))/2, height: Common.Size(s: 20)))
        lbPhiDoiSim.font = UIFont.boldSystemFont(ofSize: 14)
        lbPhiDoiSim.text = "Phí đổi sim"
        lbPhiDoiSim.textColor = UIColor.lightGray
        view2.addSubview(lbPhiDoiSim)
        
        lbPhiDoiSimValue = UILabel(frame: CGRect(x: lbPhiDoiSim.frame.origin.x + lbPhiDoiSim.frame.width, y: lbPhiDoiSim.frame.origin.y, width: lbPhiDoiSim.frame.size.width, height: Common.Size(s: 20)))
        lbPhiDoiSimValue.font = UIFont.boldSystemFont(ofSize: 14)
        lbPhiDoiSimValue.text = "0đ"
        lbPhiDoiSimValue.textColor = .red
        lbPhiDoiSimValue.textAlignment = .right
        view2.addSubview(lbPhiDoiSimValue)
        
        let btnUpdate = UIButton(frame: CGRect(x: Common.Size(s:15), y: lbPhiDoiSimValue.frame.origin.y + lbPhiDoiSimValue.frame.height + Common.Size(s: 25), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s: 35)))
        btnUpdate.setTitle("Cập nhật", for: .normal)
        btnUpdate.backgroundColor = UIColor(netHex:0x00955E)
        btnUpdate.layer.cornerRadius = 5
        btnUpdate.addTarget(self, action: #selector(updateSimItel), for: .touchUpInside)
        view2.addSubview(btnUpdate)
        
        view2.frame = CGRect(x: view2.frame.origin.x, y: view2.frame.origin.y , width: view2.frame.size.width, height: btnUpdate.frame.origin.y + btnUpdate.frame.height)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }

    func initSimType() {
        let i1 = ReasonCodes(Code: "1", Name: " Chuyển sang Esim bằng OTP", is_esim: "1")
        let i2 = ReasonCodes(Code: "2", Name: " Chuyển sang sim vật lý bằng OTP", is_esim: "0")
        self.arrSimType.append(i1)
        self.arrSimType.append(i2)
    }
    
    @objc func showDropMenuSimType() {
        DropDown.setupDefaultAppearance();
        
        dropMenuSimType.dismissMode = .onTap
        dropMenuSimType.direction = .any
        
        dropMenuSimType.anchorView = lbChooseSimType;
        DropDown.startListeningToKeyboard();
        
        dropMenuSimType.dataSource = [arrSimType[0].Name, arrSimType[1].Name]
        dropMenuSimType.selectRow(0);
        
        self.dropMenuSimType.show()
        
        dropMenuSimType.selectionAction = { [weak self] (index, item) in
            self?.arrSimType.forEach{
                if($0.Name == item){
                    self?.selectedSimType = $0
                    self?.lbChooseSimType.text = "\($0.Name)"
                    
                    if $0.is_esim == "1" {
                        //hide serial
                        self?.viewSerial.isHidden = true
                        self!.viewSerial.frame = CGRect(x: self!.viewSerial.frame.origin.x, y: self!.viewSerial.frame.origin.y , width: self!.viewSerial.frame.size.width, height: 0)
                    } else {
                        //show serial
                        self?.viewSerial.isHidden = false
                        self!.viewSerial.frame = CGRect(x: self!.viewSerial.frame.origin.x, y: self!.viewSerial.frame.origin.y , width: self!.viewSerial.frame.size.width, height: Common.Size(s: 60))
                    }
                    self!.view2.frame = CGRect(x: self!.view2.frame.origin.x, y: self!.viewSerial.frame.origin.y + self!.viewSerial.frame.height, width: self!.view2.frame.size.width, height: self!.view2.frame.height)
                }
            }
        }
    }
    
    @objc func updateSimItel() {
        
        guard let otp = self.tfOTPText.text, !otp.isEmpty else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập OTP!", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        var serialNum = ""
        if self.selectedSimType?.is_esim == "0" { //sim thuong
            serialNum = self.tfSerial.text ?? ""
            if serialNum.isEmpty {
                let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập số serial!", preferredStyle: UIAlertController.Style.alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                return
            }
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                CRMAPIManager.Itel_ChangeIsim(isdn: "\(self.phoneNum)", Seri: serialNum, Otp: otp, isEsim: "0",Doctal: "\(self.itemItelFee?.amount ?? 0)", FullName: "\(self.itemItelFee?.tenkhachhang ?? "")") { (rsCode, msg) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if rsCode == "SUCCESS" {
                            
                            let alert = UIAlertController(title: "Thông báo", message: "\(msg)", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                               self.navigationController?.popToRootViewController(animated: true)
                            })
                            self.present(alert, animated: true)
                            
                            
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "\(msg)", preferredStyle: UIAlertController.Style.alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
            
        } else { // la esim
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.sp_mpos_FRT_SP_Esim_getSeri(SDT: self.phoneNum, ItemCode: "", SoMpos: "") { (arrEsimSerial, error) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if error.count <= 0 {
                            if arrEsimSerial.count > 0 {
                                if arrEsimSerial[0].p_status == 1 {
                                    WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                                        CRMAPIManager.Itel_ChangeIsim(isdn: "\(self.phoneNum)", Seri: "\(arrEsimSerial[0].seri)", Otp: otp, isEsim: "1", Doctal: "\(self.itemItelFee?.amount ?? 0)", FullName: "\(self.itemItelFee?.tenkhachhang ?? "")") { (rsCode, msg) in
                                            WaitingNetworkResponseAlert.DismissWaitingAlert {
                                                if rsCode == "SUCCESS" {
                                                    
                                                    let alert = UIAlertController(title: "Thông báo", message: "\(msg)", preferredStyle: .alert)
                                                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                                                        
                                                        self.genQRCodeItel(serial: arrEsimSerial[0].seri, phoneNum: self.phoneNum)
                                                    })
                                                    self.present(alert, animated: true)
                                                    
                                                    
                                                } else {
                                                    let alert = UIAlertController(title: "Thông báo", message: "\(msg)", preferredStyle: UIAlertController.Style.alert)
                                                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                                    alert.addAction(action)
                                                    self.present(alert, animated: true, completion: nil)
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    let alert = UIAlertController(title: "Thông báo", message: "\(arrEsimSerial[0].p_messagess)", preferredStyle: UIAlertController.Style.alert)
                                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                    alert.addAction(action)
                                    self.present(alert, animated: true, completion: nil)
                                }
                                
                            } else {
                                let alert = UIAlertController(title: "Thông báo", message: "Get Serial Error!", preferredStyle: UIAlertController.Style.alert)
                                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            }
                            
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }

                    }
                }
            }
        }
    }
    
    func genQRCodeItel(serial: String, phoneNum: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang gen qrcode Itel...") {
            CRMAPIManager.Itel_GetQrCode(serial: serial) { (qrcode, iccid, errMsg, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if errMsg.count <= 0 {
                            let newViewController = GenQRCodeEsimViewController()
                            newViewController.esimQRCode = EsimQRCode(arrQRCode: qrcode ?? "", imsi: "", serial: iccid ?? "", status: "", urlEsim: "", sdt: phoneNum)
                            self.navigationController?.pushViewController(newViewController, animated: true)
                            
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "\(errMsg)\n Số thuê bao: \(phoneNum) \n Seri: \(serial)", preferredStyle: UIAlertController.Style.alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @objc func handleTapScanImei(){
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { code in
            self.tfSerial.text = code
        }
        self.present(viewController, animated: false, completion: nil)
    }
}
