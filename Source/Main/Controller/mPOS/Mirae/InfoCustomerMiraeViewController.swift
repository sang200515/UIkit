//
//  InfoCustomerMiraeViewController.swift
//  fptshop
//
//  Created by tan on 5/24/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
import DLRadioButton
import PopupDialog
class InfoCustomerMiraeViewController: UIViewController,UITextFieldDelegate {
    
    var tfOngBa:SkyFloatingLabelTextFieldWithIcon!
    var tfHo:SkyFloatingLabelTextFieldWithIcon!
    var tfChuDem:SkyFloatingLabelTextFieldWithIcon!
    var tfTen:SkyFloatingLabelTextFieldWithIcon!
    var tfCMND:SkyFloatingLabelTextFieldWithIcon!
    var tfNgaySinh:SkyFloatingLabelTextFieldWithIcon!
    var tfThongTinLienLac:SkyFloatingLabelTextFieldWithIcon!
    var scrollView:UIScrollView!
    var detailView:UIView!
    var radioMan:DLRadioButton!
    var radioWoman:DLRadioButton!
    var genderType:Int = -1
    var infoByCMND:LoadinfoByCMND?
    var base64MT:String?
    var base64MS:String?
    
    override func viewDidLoad() {
        self.title = PARTNERIDORDER == "FPT" ? "Tra cứu Mirae" : "THUÊ MÁY"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(InfoCustomerMiraeViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "THÔNG TIN CÁ NHÂN"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        detailView = UIView()
        detailView.frame = CGRect(x: 0, y:label1.frame.origin.y + label1.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        detailView.backgroundColor = UIColor.white
        scrollView.addSubview(detailView)
        
        
        let lbGenderText = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:25)))
        lbGenderText.textAlignment = .left
        
        lbGenderText.font = UIFont.boldSystemFont(ofSize: 16)
        lbGenderText.text = "Ông/Bà"
        detailView.addSubview(lbGenderText)
        
        radioMan = createRadioButtonGender(CGRect(x: lbGenderText.frame.origin.x,y:lbGenderText.frame.origin.y + lbGenderText.frame.size.height + Common.Size(s:10) , width: lbGenderText.frame.size.width/3, height: Common.Size(s:15)), title: "Ông", color: UIColor.black);
        detailView.addSubview(radioMan)
        
        radioWoman = createRadioButtonGender(CGRect(x: radioMan.frame.origin.x + radioMan.frame.size.width + Common.Size(s: 10) ,y:radioMan.frame.origin.y, width: radioMan.frame.size.width, height: radioMan.frame.size.height), title: "Bà", color: UIColor.black);
        detailView.addSubview(radioWoman)
        
        if (self.infoByCMND!.Gender == "M"){
            radioMan.isSelected = true
            genderType = 0
        }else if (self.infoByCMND!.Gender == "F"){
            radioWoman.isSelected = true
            genderType = 1
        }else{
            radioMan.isSelected = false
            radioWoman.isSelected = false
            genderType = -1
        }
        //tfContractCode.iconImage = UIImage(named: "MaGD")
        
        tfHo = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:15), y: radioWoman.frame.origin.y + radioWoman.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)), iconType: .image);
        tfHo.placeholder = "Họ"
        tfHo.title = "Họ"
        tfHo.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfHo.keyboardType = UIKeyboardType.default
        tfHo.returnKeyType = UIReturnKeyType.done
        tfHo.clearButtonMode = UITextField.ViewMode.whileEditing
        tfHo.delegate = self
        tfHo.tintColor = UIColor(netHex:0x00955E)
        tfHo.textColor = .black
        tfHo.lineColor = .gray
        tfHo.selectedTitleColor = UIColor(netHex:0x00955E)
        tfHo.selectedLineColor = .gray
        tfHo.lineHeight = 1.0
        tfHo.selectedLineHeight = 1.0
        detailView.addSubview(tfHo)
        tfHo.text = self.infoByCMND!.FirstName
        
        tfChuDem = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:15), y: tfHo.frame.origin.y + tfHo.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)), iconType: .image);
        tfChuDem.placeholder = "Chữ Đệm"
        tfChuDem.title = "Chữ Đệm"
        tfChuDem.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfChuDem.keyboardType = UIKeyboardType.default
        tfChuDem.returnKeyType = UIReturnKeyType.done
        tfChuDem.clearButtonMode = UITextField.ViewMode.whileEditing
        tfChuDem.delegate = self
        tfChuDem.tintColor = UIColor(netHex:0x00955E)
        tfChuDem.textColor = .black
        tfChuDem.lineColor = .gray
        tfChuDem.selectedTitleColor = UIColor(netHex:0x00955E)
        tfChuDem.selectedLineColor = .gray
        tfChuDem.lineHeight = 1.0
        tfChuDem.selectedLineHeight = 1.0
        detailView.addSubview(tfChuDem)
        tfChuDem.text = self.infoByCMND!.MiddleName
        
        tfTen = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:15), y: tfChuDem.frame.origin.y + tfChuDem.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)), iconType: .image);
        tfTen.placeholder = "Tên"
        tfTen.title = "Tên"
        tfTen.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTen.keyboardType = UIKeyboardType.default
        tfTen.returnKeyType = UIReturnKeyType.done
        tfTen.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTen.delegate = self
        tfTen.tintColor = UIColor(netHex:0x00955E)
        tfTen.textColor = .black
        tfTen.lineColor = .gray
        tfTen.selectedTitleColor = UIColor(netHex:0x00955E)
        tfTen.selectedLineColor = .gray
        tfTen.lineHeight = 1.0
        tfTen.selectedLineHeight = 1.0
        detailView.addSubview(tfTen)
        tfTen.text = self.infoByCMND!.LastName
        
        tfCMND = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:15), y: tfTen.frame.origin.y + tfTen.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)), iconType: .image);
        tfCMND.placeholder = "CMND "
        tfCMND.title = "CMND"
        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMND.keyboardType = UIKeyboardType.numberPad
        tfCMND.returnKeyType = UIReturnKeyType.done
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCMND.delegate = self
        tfCMND.tintColor = UIColor(netHex:0x00955E)
        tfCMND.textColor = .black
        tfCMND.lineColor = .gray
        tfCMND.selectedTitleColor = UIColor(netHex:0x00955E)
        tfCMND.selectedLineColor = .gray
        tfCMND.lineHeight = 1.0
        tfCMND.selectedLineHeight = 1.0
        tfCMND.isUserInteractionEnabled = false
        detailView.addSubview(tfCMND)
        tfCMND.text = self.infoByCMND!.IDCard
        
        tfNgaySinh = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:15), y: tfCMND.frame.origin.y + tfCMND.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)), iconType: .image);
        tfNgaySinh.placeholder = "Nhập ngày tháng năm sinh (dd/mm/yyyy) "
        tfNgaySinh.title = "Nhập ngày tháng năm sinh (dd/mm/yyyy)"
        tfNgaySinh.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfNgaySinh.keyboardType = UIKeyboardType.numberPad
        tfNgaySinh.returnKeyType = UIReturnKeyType.done
        tfNgaySinh.clearButtonMode = UITextField.ViewMode.whileEditing
        tfNgaySinh.delegate = self
        tfNgaySinh.tintColor = UIColor(netHex:0x00955E)
        tfNgaySinh.textColor = .black
        tfNgaySinh.lineColor = .gray
        tfNgaySinh.selectedTitleColor = UIColor(netHex:0x00955E)
        tfNgaySinh.selectedLineColor = .gray
        tfNgaySinh.lineHeight = 1.0
        tfNgaySinh.selectedLineHeight = 1.0
        detailView.addSubview(tfNgaySinh)
        tfNgaySinh.text = self.infoByCMND!.NgaySinh
        tfNgaySinh.addTarget(self, action: #selector(InfoCustomerMiraeViewController.textFieldDidEndEditing), for: .editingDidEnd)
       
        
        tfThongTinLienLac = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:15), y: tfNgaySinh.frame.origin.y + tfNgaySinh.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)), iconType: .image);
        tfThongTinLienLac.placeholder = "Số điện thoại "
        tfThongTinLienLac.title = "Số điện thoại"
        tfThongTinLienLac.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfThongTinLienLac.keyboardType = UIKeyboardType.numberPad
        tfThongTinLienLac.returnKeyType = UIReturnKeyType.done
        tfThongTinLienLac.clearButtonMode = UITextField.ViewMode.whileEditing
        tfThongTinLienLac.delegate = self
        tfThongTinLienLac.tintColor = UIColor(netHex:0x00955E)
        tfThongTinLienLac.textColor = .black
        tfThongTinLienLac.lineColor = .gray
        tfThongTinLienLac.selectedTitleColor = UIColor(netHex:0x00955E)
        tfThongTinLienLac.selectedLineColor = .gray
        tfThongTinLienLac.lineHeight = 1.0
        tfThongTinLienLac.selectedLineHeight = 1.0
        detailView.addSubview(tfThongTinLienLac)
        tfThongTinLienLac.text = self.infoByCMND!.PhoneNumber
        detailView.frame.size.height = tfThongTinLienLac.frame.origin.y + tfThongTinLienLac.frame.size.height + Common.Size(s:10)
        
        let btContinue = UIButton()
        btContinue.frame = CGRect(x: Common.Size(s:15), y: detailView.frame.origin.y + detailView.frame.size.height + Common.Size(s:10), width: tfThongTinLienLac.frame.size.width, height: tfThongTinLienLac.frame.size.height * 1.1)
        btContinue.backgroundColor = UIColor(netHex:0x00955E)
        btContinue.setTitle("TIẾP TỤC", for: .normal)
        btContinue.addTarget(self, action: #selector(actionContinue), for: .touchUpInside)
        btContinue.layer.borderWidth = 0.5
        btContinue.layer.borderColor = UIColor.white.cgColor
        btContinue.layer.cornerRadius = 5.0
        
        scrollView.addSubview(btContinue)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btContinue.frame.origin.y + btContinue.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func actionContinue(){
        if(self.tfHo.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập họ !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.tfHo.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
        }
//        if(self.tfChuDem.text! == ""){
//            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập chữ đệm !", preferredStyle: .alert)
//
//            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//                self.tfChuDem.becomeFirstResponder()
//            })
//            self.present(alert, animated: true)
//            return
//        }
        if(self.tfTen.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập tên !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.tfChuDem.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
        }
        if(self.tfCMND.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập CMND !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.tfChuDem.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
        }
        if(self.tfNgaySinh.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập ngày sinh !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.tfChuDem.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
        }
        if(self.genderType == -1){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng chọn giới tính !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.tfChuDem.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
        }
        if(self.tfThongTinLienLac.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập thông tin liên lạc !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.tfChuDem.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
        }
        if (self.tfThongTinLienLac.text!.hasPrefix("01") && self.tfThongTinLienLac.text!.count == 11){
            
        }else if (self.tfThongTinLienLac.text!.hasPrefix("0") && !self.tfThongTinLienLac.text!.hasPrefix("01") && self.tfThongTinLienLac.text!.count == 10){
            
        }else{
            let alert = UIAlertController(title: "Thông báo", message: "Số điện thoại KH không hợp lệ!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.tfThongTinLienLac.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
        }
        if(self.tfNgaySinh.text!.count == 10){
            if (!checkDate(stringDate: self.tfNgaySinh.text!)){
              
                let alert = UIAlertController(title: "Thông báo", message: "Ngày sinh sai định dạng!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    self.tfChuDem.becomeFirstResponder()
                })
                self.present(alert, animated: true)
                return
            }else{
                let listDate = self.tfNgaySinh.text!.components(separatedBy: "/")
                if (listDate.count == 3){
                    let yearText = listDate[2]
                    let date = Date()
                    let calendar = Calendar.current
                    let year = calendar.component(.year, from: date)
                    
                    let yearInt = Int(yearText)
                    
                    if (year < yearInt!){
                        let alert = UIAlertController(title: "Thông báo", message: "Năm sinh không được lớn hơn năm hiện tại", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            self.tfChuDem.becomeFirstResponder()
                        })
                        self.present(alert, animated: true)
                        return
                    }
                }
            }
        }else{
            let alert = UIAlertController(title: "Thông báo", message: "Ngày sinh sai định dạng!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.tfChuDem.becomeFirstResponder()
            })
            self.present(alert, animated: true)
        }
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_FRT_SP_mirae_checkinfocustomer(IDcard:self.tfCMND.text!,Gender:"\(genderType)",FirstName:"\(self.tfHo.text!)",MiddleName:self.tfChuDem.text!,LastName: self.tfTen.text!,BirthDay:self.tfNgaySinh.text!,PhoneNumber:self.tfThongTinLienLac.text!,fptrequest_Front:"\(self.infoByCMND!.fptrequest_Front)",fptrequest_Behind:"\(self.infoByCMND!.fptrequest_Behind)",partnerID: PARTNERIDORDER) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(results[0].p_status != 0){
                        //
                        let alert = UIAlertController(title: "Thông báo", message: results[0].p_messagess, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            results[0].cmnd = self.tfCMND.text!
                            results[0].hoten = "\(self.tfHo.text!) \(self.tfChuDem.text!) \(self.tfTen.text!)"
                            results[0].sdt = self.tfThongTinLienLac.text!
                            results[0].BirthDay = self.tfNgaySinh.text!
                            results[0].LastName = self.tfTen.text!
                            results[0].FirstName = self.tfHo.text!
                            results[0].MiddleName = self.tfChuDem.text!
                            results[0].Gender = self.genderType
                            results[0].Native = self.infoByCMND!.Native
                            results[0].IssueDate = self.infoByCMND!.IssueDate
                            results[0].base64_mt = self.base64MT!
                            results[0].base64_ms = self.base64MS!
                            UserDefaults.standard.setValue(results[0].TenCTyTraGop, forKey: "TenCTyTraGop")
                            let newViewController = DetailInfoCustomerMiraeViewController()
                            newViewController.checkInfoCustomer = results[0]
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        })
                        alert.addAction(UIAlertAction(title: "Gửi lại SMS", style: .destructive) { _ in
                            let newViewController = LoadingViewController()
                              newViewController.content = "Đang kiểm tra thông tin..."
                              newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                              newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                              self.navigationController?.present(newViewController, animated: true, completion: nil)
                              let nc = NotificationCenter.default
                              
                              
                            MPOSAPIManager.mpos_FRT_SP_mirae_sendsms(cmnd:self.tfCMND.text!,phone:self.tfThongTinLienLac.text!,processId:"\(results[0].processId)",partnerId:PARTNERIDORDER) { (p_status,p_message, err) in
                                  let when = DispatchTime.now() + 0.5
                                  DispatchQueue.main.asyncAfter(deadline: when) {
                                      nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                      if(err.count <= 0){
                                        let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                                        
                                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                            
                                        })
                                        self.present(alert, animated: true)
                                        
                                        
                                        
                                          
                                      }else{
                                          let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                                          
                                          alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                              
                                          })
                                          self.present(alert, animated: true)
                                      }
                                  }
                              }
                        })
                        self.present(alert, animated: true)
                        //
                    
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: results[0].p_messagess, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                    
                    
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    @objc func checkDate(stringDate:String) -> Bool{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yyyy"
        
        if let _ = dateFormatterGet.date(from: stringDate) {
            return true
        } else {
            return false
        }
    }
    fileprivate func createRadioButtonGender(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:12));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(InfoCustomerMiraeViewController.logSelectedButtonGender), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonGender(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioMan.isSelected = false
            radioWoman.isSelected = false
            switch temp {
            case "Ông":
                genderType = 0
                Cache.genderType = 0
                radioMan.isSelected = true
                break
            case "Bà":
                genderType = 1
                Cache.genderType = 1
                radioWoman.isSelected = true
                break
            default:
                genderType = -1
                Cache.genderType = -1
                break
            }
        }
    }
//    func textFieldDidBeginEditing(_ textField: SkyFloatingLabelTextField) {
//        // When you start editing check if there is nothing, in that case add the entire mask
//        if(textField == tfNgaySinh){
//            if let text = textField.text, text == "" || text == "DD/MM/YYYY" {
//                textField.text = "DD/MM/YYYY"
//                textField.textColor = .lightGray
//                textField.setCursor(position: text.count)
//            }
//        }
//
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == tfNgaySinh){
            guard var number = textField.text else {
                return true
            }
            // If user try to delete, remove the char manually
            if string == "" {
                number.remove(at: number.index(number.startIndex, offsetBy: range.location))
            }
            // Remove all mask characters
            number = number.replacingOccurrences(of: "/", with: "")
            number = number.replacingOccurrences(of: "D", with: "")
            number = number.replacingOccurrences(of: "M", with: "")
            number = number.replacingOccurrences(of: "Y", with: "")
            
            // Set the position of the cursor
            var cursorPosition = number.count+1
            if string == "" {
                //if it's delete, just take the position given by the delegate
                cursorPosition = range.location
            } else {
                // If not, take into account the slash
                if cursorPosition > 2 && cursorPosition < 5 {
                    cursorPosition += 1
                } else if cursorPosition > 4 {
                    cursorPosition += 2
                }
            }
            // Stop editing if we have rich the max numbers
            if number.count == 8 { return false }
            // Readd all mask char
            number += string
            while number.count < 8 {
                if number.count < 2 {
                    number += "D"
                } else if number.count < 4 {
                    number += "M"
                } else {
                    number += "Y"
                }
            }
            number.insert("/", at: number.index(number.startIndex, offsetBy: 4))
            number.insert("/", at: number.index(number.startIndex, offsetBy: 2))
            
            // Some styling
            let enteredTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
            let maskTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
            
            let partOne = NSMutableAttributedString(string: String(number.prefix(cursorPosition)), attributes: enteredTextAttribute)
            let partTwo = NSMutableAttributedString(string: String(number.suffix(number.count-cursorPosition)), attributes: maskTextAttribute)
            
            let combination = NSMutableAttributedString()
            
            combination.append(partOne)
            combination.append(partTwo)
            
            textField.attributedText = combination
            textField.setCursor(position: cursorPosition)
            return false
            
         
        }
           return true
 
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == tfNgaySinh){
            if let text = textField.text, text != "" && text != "DD/MM/YYYY" {
                // Do something with your value
            } else {
                textField.text = ""
            }
        }
     
    }
}
extension UITextField {
    func setCursor(position: Int) {
        let position = self.position(from: beginningOfDocument, offset: position)!
        selectedTextRange = textRange(from: position, to: position)
    }
}
