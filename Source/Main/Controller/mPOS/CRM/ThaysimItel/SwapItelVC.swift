//
//  SwapItelVC.swift
//  fptshop
//
//  Created by Ngoc Bao on 05/10/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown

class SwapItelVC: UIViewController {
    
    //MARK: IBOUTLET
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var addressTxt: UITextField!
    @IBOutlet weak var birthTxt: TextFieldCustom!
    @IBOutlet weak var cmndTxt: UITextField!
    @IBOutlet weak var noiCapTxt: SearchTextField!
    @IBOutlet weak var ngaycapTxt: TextFieldCustom!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var typeChanegeSimTxt: TextFieldCustom!
    @IBOutlet weak var serialTxt: TextFieldCustom!
    @IBOutlet weak var femaleImg: UIImageView!
    @IBOutlet weak var maleImg: UIImageView!
    @IBOutlet weak var stackSerial: UIStackView!
    @IBOutlet weak var lbPhiDoiSimValue: UILabel!
    
    let dropDownMenu = DropDown()
    var changesimType = "0" // 0: vật lý, 1: esim
    var isMale = -1  // 0 : nam,1: nữ , -1 : nothing
    var phoneNum: String = ""
    var itemItelFee: GetSimFeeItel?
    var otp = ""
    var listProvices:[Province] = []
    var selectProvice:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTxt.isUserInteractionEnabled = false
        typeChanegeSimTxt.delegateButton = self
        serialTxt.delegateButton = self
        birthTxt.delegateButton = self
        ngaycapTxt.delegateButton = self
        initDefaultType()
        phoneTxt.text = phoneNum
        self.lbPhiDoiSimValue.text = "\(Common.convertCurrency(value: itemItelFee?.amount ?? 0))"
        MPOSAPIManager.GetProvinces(NhaMang: "Itelecom") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
               // nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.listProvices = results
                    var list:[String] = []
                    for item in results {
                        list.append(item.Text)
                    }
                    self.noiCapTxt.filterStrings(list)
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
        noiCapTxt.placeholder = "Vui lòng chọn Thành Phố"
        noiCapTxt.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        noiCapTxt.borderStyle = UITextField.BorderStyle.roundedRect
        noiCapTxt.autocorrectionType = UITextAutocorrectionType.no
        noiCapTxt.keyboardType = UIKeyboardType.default
        noiCapTxt.returnKeyType = UIReturnKeyType.done
        noiCapTxt.clearButtonMode = UITextField.ViewMode.whileEditing
        noiCapTxt.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        // Start visible - Default: false
        noiCapTxt.startVisible = true
        noiCapTxt.theme.bgColor = UIColor.white
        noiCapTxt.theme.fontColor = UIColor.black
        noiCapTxt.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        noiCapTxt.theme.cellHeight = Common.Size(s:40)
        noiCapTxt.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        noiCapTxt.leftViewMode = UITextField.ViewMode.always
        noiCapTxt.itemSelectionHandler = { filteredResults, itemPosition in
            //Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.noiCapTxt.text = item.title

            let obj =  self.listProvices.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectProvice = "\(obj)"
            }
        }
        if itemItelFee != nil {
            self.nameTxt.text = itemItelFee?.tenkhachhang
            self.birthTxt.text = Common.convertDateToStringWith(dateString: itemItelFee?.birthdate ?? "", formatIn: "yyyy-MM-dd HH:mm:ss.SSS", formatOut: "dd/MM/yyyy")
            self.cmndTxt.text = itemItelFee?.cmnd
            self.noiCapTxt.text = itemItelFee?.noicap
            self.selectProvice = itemItelFee?.noicap ?? ""
            self.ngaycapTxt.text = Common.convertDateToStringWith(dateString: itemItelFee?.ngaycap ?? "", formatIn: "yyyy-MM-dd HH:mm:ss.SSS", formatOut: "dd/MM/yyyy")
        }
    }
    
    
    
    @IBAction func ongender(button: UIButton) {
        isMale = button.tag
        setImage(img: femaleImg, isSelect: button.tag == 1)
        setImage(img: maleImg, isSelect: button.tag == 0)
    }
    
    @IBAction func onUpdate() {
        if validate() {
            getOtp()
        }
    }
    
    func validate() -> Bool {
        guard let name = nameTxt.text,!name.isEmpty else {
            self.showPopUp("Bạn chưa nhập tên", "Thông báo", buttonTitle: "Đồng ý")
            return false
        }
        
//        guard let address = addressTxt.text,!address.isEmpty else {
//            self.showPopUp("Bạn chưa nhập địa chỉ", "Thông báo", buttonTitle: "Đồng ý")
//            return false
//        }
        
        guard let birth = birthTxt.text,!birth.isEmpty else {
            self.showPopUp("Bạn chưa chọn ngày sinh", "Thông báo", buttonTitle: "Đồng ý")
            return false
        }
        
        if isMale == -1{
            self.showPopUp("Bạn chưa chọn giới tính", "Thông báo", buttonTitle: "Đồng ý")
            return false
        }
        
        guard let cmnd = cmndTxt.text,!cmnd.isEmpty else {
            self.showPopUp("Bạn chưa nhập cmnd", "Thông báo", buttonTitle: "Đồng ý")
            return false
        }
        
        if selectProvice == "" {
            self.showPopUp("Bạn chưa chọn nơi cấp", "Thông báo", buttonTitle: "Đồng ý")
            return false
        }
        
        guard let ngaycap = ngaycapTxt.text,!ngaycap.isEmpty else {
            self.showPopUp("Bạn chưa chọn ngày cấp", "Thông báo", buttonTitle: "Đồng ý")
            return false
        }
        
        guard let sdt = phoneTxt.text,!sdt.isEmpty else {
            self.showPopUp("Số điện thoại không được để rỗng", "Thông báo", buttonTitle: "Đồng ý")
            return false
        }
        
        if changesimType == "0" {
            guard let serial = serialTxt.text,!serial.isEmpty else {
                self.showPopUp("Serial không được để rỗng", "Thông báo", buttonTitle: "Đồng ý")
                return false
            }
        }
        return true
    }
    
    func initDefaultType() {
        // init defaut
        typeChanegeSimTxt.text = "Chuyển sang vật lý"
        changesimType = "0"
        stackSerial.isHidden = changesimType == "1"
    }
    
    func setImage(img: UIImageView, isSelect: Bool) {
        img.image = isSelect ? UIImage(named: "mdi_check_circle_gr_2") : UIImage(named: "mdi_check_circle_gr")
    }
    func getOtp() {
        Provider.shared.thaySimItelAPIService.getOtp(phone: phoneTxt.text ?? "", fullName: nameTxt.text ?? "", birthDay: birthTxt.text ?? "", cmnd: cmndTxt.text ?? "" , dateCmnd: ngaycapTxt.text ?? "", success: { [weak self] result in
            guard let self = self, let response = result else { return }
            if response.ErrorCode == "DS01" { //success
                self.otp = response.Otp
                self.updateSimItel()
            } else {
                self.showAlertOneButton(title: "Thông báo", with: response.ErrorMessage, titleButton: "OK")
            }
            
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    @objc func updateSimItel() {
        
        let fee = itemItelFee?.amount ?? 0
        var serial = serialTxt.text ?? ""
        serial = changesimType == "0" ? serial : ""
        
        
        if changesimType == "0" {
            Provider.shared.thaySimItelAPIService.chnageSimhong(Msisdn: phoneNum, Seri: serial, Esim: changesimType, Doctal: "\(fee)", FullName: nameTxt.text ?? "", Otp: self.otp, success: { [weak self] result in
                guard let self = self, let response = result else { return }
                self.showPopUp(response.ErrorMessage, "Thông báo", buttonTitle: "Đồng ý") {
                    if response.ErrorCode == "SUCCESS" { //success back lai
                        for vc in self.navigationController?.viewControllers ?? [] {
                            if vc is ChonNhaMangThaySimViewController {
                                self.navigationController?.popToViewController(vc, animated: true)
                            }
                        }
                    }
                }
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        } else {
            ProgressView.shared.show()
            MPOSAPIManager.sp_mpos_FRT_SP_Esim_getSeri(SDT: self.phoneNum, ItemCode: "", SoMpos: "") { (arrEsimSerial, error) in
                ProgressView.shared.hide()
                if error.count <= 0 {
                    if arrEsimSerial.count > 0 {
                        if arrEsimSerial[0].p_status == 1 {
                            
                            Provider.shared.thaySimItelAPIService.chnageSimhong(Msisdn: self.phoneNum, Seri: "\(arrEsimSerial[0].seri)", Esim: self.changesimType, Doctal: "\(fee)", FullName: self.nameTxt.text ?? "", Otp: self.otp, success: { [weak self] result in
                                guard let self = self, let response = result else { return }
                                self.showPopUp(response.ErrorMessage, "Thông báo", buttonTitle: "Đồng ý") {
                                    if response.ErrorCode == "SUCCESS" {
                                        self.genQRCodeItel(serial: arrEsimSerial[0].seri, phoneNum: self.phoneNum)
                                    }
                                }
                            }, failure: { [weak self] error in
                                guard let self = self else { return }
                                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
                            })
                            
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
}
extension SwapItelVC: TextFieldCustomDelegate {
    
    func onClickButton(tag: Int) {
        dropDownMenu.anchorView = typeChanegeSimTxt
        dropDownMenu.bottomOffset = CGPoint(x: 0, y:(dropDownMenu.anchorView?.plainView.bounds.height)! + 10)
        dropDownMenu.dataSource = ["Chuyển sang vật lý", "Chuyển sang esim"]
        dropDownMenu.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dropDownMenu.selectionAction = { [weak self] (index, item) in
            self?.changesimType = "\(index)"
            self?.typeChanegeSimTxt.text = item
            self?.stackSerial.isHidden = index == 1
            let isEsim = index == 0 ? "0" : "1"
            ProgressView.shared.show()
            CRMAPIManager.Itel_GetChangeSimFee(PhoneNumber: self?.phoneNum ?? "",isEsim:
                                                isEsim) { (rs, errCode, errMessage, err) in
                    ProgressView.shared.hide()
                        if err.count <= 0 {
                            if rs != nil {
                                self?.itemItelFee = rs
                                self?.lbPhiDoiSimValue.text = "\(Common.convertCurrency(value: self?.itemItelFee?.amount ?? 0))"
                            } else {
                                let alert = UIAlertController(title: "Thông báo", message: "Error \(errCode): \(errMessage)", preferredStyle: UIAlertController.Style.alert)
                                let action = UIAlertAction(title: "OK", style: .default) { _ in
                                    self?.navigationController?.popViewController(animated: true)
                                }
                                alert.addAction(action)
                                self?.present(alert, animated: true, completion: nil)
                            }
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                            let action = UIAlertAction(title: "OK", style: .default) { _ in
                                self?.navigationController?.popViewController(animated: true)
                            }
                            alert.addAction(action)
                            self?.present(alert, animated: true, completion: nil)
                        }

                }
        }
        dropDownMenu.show()
    }
    
    func onRightTxt(tag: Int) {
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { text in
            self.serialTxt.text = text
        }
        self.present(viewController, animated: true, completion: nil)
    }
    
    func doneDatePicker(tag:Int,value: String) {
        self.view.endEditing(true)
        print(value)
    }
    
    func cancelDatePicker(tag:Int) {
        self.view.endEditing(true)
    }
    
}

