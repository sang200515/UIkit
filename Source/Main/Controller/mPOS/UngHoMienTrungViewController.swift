//
//  UngHoMienTrungViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 10/22/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class UngHoMienTrungViewController: UIViewController {

    var imgRadio1: UIImageView!
    var imgRadio2: UIImageView!
    var imgRadio3: UIImageView!
    var view3: UIView!
    var tfSoTienUngHo: UITextField!
    var btnConfirm: UIButton!
    var scrollView: UIScrollView!
    var listKhaoSat = [ItemKhaoSatMienTrung]()
    
    var typeChoose: Int = 1
    var barClose : UIBarButtonItem!
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("showVerifyVersion"), object: nil)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.title = "Ủng hộ bão lũ Miền Trung thân thương"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 76/255, green: 162/255, blue: 113/255, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = true
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "Close"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(actionClose), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]
        
        if self.listKhaoSat.count >= 3 {
            self.setUpView()
        }
        
    }
    
    @objc func actionClose(){
        navigationController?.popViewController(animated: false)
        self.dismiss(animated: false, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name.init("didCloseSurvey"), object: nil)
    }
    
    func setUpView() {
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let stt1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 15), width: Common.Size(s: 10), height: Common.Size(s: 40)))
        stt1.text = "1"
        stt1.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(stt1)
        
        imgRadio1 = UIImageView(frame: CGRect(x: stt1.frame.origin.x + stt1.frame.width + Common.Size(s: 5), y: Common.Size(s: 25), width: Common.Size(s: 18), height: Common.Size(s: 18)))
        imgRadio1.image = #imageLiteral(resourceName: "Checked")
        imgRadio1.tag = 1
        scrollView.addSubview(imgRadio1)
        
        let tapChooseOption1 = UITapGestureRecognizer(target: self, action: #selector(chooseOption(_:)))
        imgRadio1.isUserInteractionEnabled = true
        imgRadio1.addGestureRecognizer(tapChooseOption1)
        
        let lbOption1 = UILabel(frame: CGRect(x: imgRadio1.frame.origin.x + imgRadio1.frame.width + Common.Size(s: 8), y: Common.Size(s: 15), width: (self.view.frame.width - Common.Size(s: 30)) - (imgRadio1.frame.origin.x + imgRadio1.frame.width + Common.Size(s: 5)), height: Common.Size(s: 40)))
        lbOption1.text = "\(self.listKhaoSat[0].descriptionStr)"
        lbOption1.font = UIFont.boldSystemFont(ofSize: 14)
        lbOption1.numberOfLines = 2
        scrollView.addSubview(lbOption1)
        
        let stt2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbOption1.frame.origin.y + lbOption1.frame.height + Common.Size(s: 5), width: Common.Size(s: 15), height: Common.Size(s: 40)))
        stt2.text = "2"
        stt2.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(stt2)
        
        imgRadio2 = UIImageView(frame: CGRect(x: imgRadio1.frame.origin.x, y: stt2.frame.origin.y + (stt2.frame.height/2 - Common.Size(s: 10)), width: imgRadio1.frame.width, height: Common.Size(s: 18)))
        imgRadio2.image = #imageLiteral(resourceName: "Check-1")
        imgRadio2.tag = 2
        scrollView.addSubview(imgRadio2)
        
        let tapChooseOption2 = UITapGestureRecognizer(target: self, action: #selector(chooseOption(_:)))
        imgRadio2.isUserInteractionEnabled = true
        imgRadio2.addGestureRecognizer(tapChooseOption2)
        
        let lbOption2 = UILabel(frame: CGRect(x: lbOption1.frame.origin.x, y: stt2.frame.origin.y, width: lbOption1.frame.width, height: Common.Size(s: 40)))
        lbOption2.text = "\(self.listKhaoSat[1].descriptionStr)"
        lbOption2.font = UIFont.boldSystemFont(ofSize: 14)
        lbOption2.numberOfLines = 2
        scrollView.addSubview(lbOption2)
        
        tfSoTienUngHo = UITextField(frame: CGRect(x: lbOption2.frame.origin.x, y: lbOption2.frame.origin.y + lbOption2.frame.height + Common.Size(s: 5), width: lbOption2.frame.width, height: Common.Size(s: 30)))
        tfSoTienUngHo.placeholder = "Nhập số tiền"
        tfSoTienUngHo.borderStyle = .roundedRect
        tfSoTienUngHo.font = UIFont.boldSystemFont(ofSize: 13)
        tfSoTienUngHo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tfSoTienUngHo.keyboardType = .numberPad
        tfSoTienUngHo.returnKeyType = UIReturnKeyType.done
        tfSoTienUngHo.clearButtonMode = UITextField.ViewMode.whileEditing
        scrollView.addSubview(tfSoTienUngHo)
        
        let stt3 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfSoTienUngHo.frame.origin.y + tfSoTienUngHo.frame.height + Common.Size(s: 8), width: Common.Size(s: 15), height: Common.Size(s: 40)))
        stt3.text = "3"
        stt3.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(stt3)
        
        imgRadio3 = UIImageView(frame: CGRect(x: imgRadio2.frame.origin.x, y: stt3.frame.origin.y + (stt3.frame.height/2 - Common.Size(s: 10)), width: imgRadio1.frame.width, height: Common.Size(s: 18)))
        imgRadio3.image = #imageLiteral(resourceName: "Check-1")
        imgRadio3.tag = 3
        scrollView.addSubview(imgRadio3)
        
        let tapChooseOption3 = UITapGestureRecognizer(target: self, action: #selector(chooseOption(_:)))
        imgRadio3.isUserInteractionEnabled = true
        imgRadio3.addGestureRecognizer(tapChooseOption3)
        
        let lbOption3 = UILabel(frame: CGRect(x: lbOption2.frame.origin.x, y: stt3.frame.origin.y, width: lbOption2.frame.width, height: Common.Size(s: 40)))
        lbOption3.text = "\(self.listKhaoSat[2].descriptionStr)"
        lbOption3.font = UIFont.boldSystemFont(ofSize: 14)
        lbOption3.numberOfLines = 2
        scrollView.addSubview(lbOption3)
        
        btnConfirm = UIButton(frame: CGRect(x: Common.Size(s: 15), y: lbOption3.frame.origin.y + lbOption3.frame.height + Common.Size(s: 25), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        btnConfirm.setTitle("Gửi kết quả", for: .normal)
        btnConfirm.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btnConfirm.backgroundColor = UIColor(red: 76/255, green: 162/255, blue: 113/255, alpha: 1)
        btnConfirm.layer.cornerRadius = 5
        btnConfirm.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        scrollView.addSubview(btnConfirm)
        
        let scrollViewHeight = btnConfirm.frame.origin.y + btnConfirm.frame.height + ((self.navigationController?.navigationBar.frame.size.height) ?? 0 + UIApplication.shared.statusBarFrame.height) + Common.Size(s:30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    @objc func confirm() {
        var listKhaoSatConfirm = [ItemKhaoSatResult]()
        if self.typeChoose == 1 {
            
            listKhaoSatConfirm.removeAll()
            listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[0].value)", itemDescription: "true"))
            listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[1].value)", itemDescription: "false"))
            listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[2].value)", itemDescription: "false"))
            
            if listKhaoSat[1].children.count > 0 {
                listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[1].children[0].value)", itemDescription: ""))
            }
            
        } else if self.typeChoose == 2 { //option 2 - nhap so tien
            guard let soTienStr = self.tfSoTienUngHo.text, (!soTienStr.isEmpty) && (soTienStr != "0") else {
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập số tiền bạn muốn ủng hộ!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                return
            }
            let price = soTienStr.replace(",", withString: "")
            
            listKhaoSatConfirm.removeAll()
            listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[0].value)", itemDescription: "false"))
            listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[1].value)", itemDescription: "true"))
            listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[2].value)", itemDescription: "false"))
            
            if listKhaoSat[1].children.count > 0 {
                listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[1].children[0].value)", itemDescription: "\(price)"))
            }
        } else {
            listKhaoSatConfirm.removeAll()
            listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[0].value)", itemDescription: "false"))
            listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[1].value)", itemDescription: "false"))
            listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[2].value)", itemDescription: "true"))
            
            if listKhaoSat[1].children.count > 0 {
                listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[1].children[0].value)", itemDescription: ""))
            }
        }
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            CRMAPIManager.Survey_SaveData(arrKhaoSat: listKhaoSatConfirm) { (rsCode, msg, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rsCode == 200 {
                            let alert = UIAlertController(title: "Thông báo", message: "\(msg ?? "Cảm ơn bạn đã ủng hộ!")", preferredStyle: UIAlertController.Style.alert)
                            let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                self.actionClose()
                            }
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)

                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "\(msg ?? "Lưu thất bại!")", preferredStyle: UIAlertController.Style.alert)
                            let action = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
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
    
    @objc func chooseOption(_ sender: UIGestureRecognizer) {
        let view = sender.view ?? UIView()
        let tag = view.tag
        
        debugPrint("img_tag: \(tag)")
        self.typeChoose = tag
        
        switch tag {
        case 1:
            imgRadio1.image = #imageLiteral(resourceName: "Checked")
            imgRadio2.image = #imageLiteral(resourceName: "Check-1")
            imgRadio3.image = #imageLiteral(resourceName: "Check-1")
            
            self.tfSoTienUngHo.text = ""
            break
            
        case 2:
            imgRadio1.image = #imageLiteral(resourceName: "Check-1")
            imgRadio2.image = #imageLiteral(resourceName: "Checked")
            imgRadio3.image = #imageLiteral(resourceName: "Check-1")
            break
            
        case 3:
            imgRadio1.image = #imageLiteral(resourceName: "Check-1")
            imgRadio2.image = #imageLiteral(resourceName: "Check-1")
            imgRadio3.image = #imageLiteral(resourceName: "Checked")
            self.tfSoTienUngHo.text = ""
            break
        default:
            break
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        
        if textField.text != "" {
            self.typeChoose = 2
            imgRadio1.image = #imageLiteral(resourceName: "Check-1")
            imgRadio2.image = #imageLiteral(resourceName: "Checked")
            imgRadio3.image = #imageLiteral(resourceName: "Check-1")
        }
        var moneyString:String = textField.text ?? ""
        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s),\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
        }else{
            textField.text = ""
        }
    }
    
}
