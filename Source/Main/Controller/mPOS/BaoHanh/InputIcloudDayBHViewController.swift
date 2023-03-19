//
//  InputIcloudDayBHViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 12/16/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import SkyFloatingLabelTextField
protocol InputIcloudDayBHViewControllerDelegate: NSObjectProtocol {
    func returnDate(input:String,index:Int)
}
class InputIcloudDayBHViewController: UIViewController,UITextFieldDelegate{
    
    var scrollView:UIScrollView!
    var tfInput:SkyFloatingLabelTextFieldWithIcon!
    var delegate:InputIcloudDayBHViewControllerDelegate?
    var indexID:Int?
    var barClose : UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
            navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00955E)
        self.title = "Ngày hẹn cấp lại Icloud"
        //self.navigationController?.navigationBar.isTranslucent = true
        
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "Close"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(InputIcloudDayBHViewController.backButton), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        let lbText1 = UILabel(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:20), height: Common.Size(s:30)))
        lbText1.textAlignment = .left
        lbText1.textColor = UIColor.black
        lbText1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbText1.text = "1. Nếu máy mất nguồn: shop lên website thoát Icloud https://www.icloud.com"
        lbText1.numberOfLines = 0
        scrollView.addSubview(lbText1)
        
        let lbText2 = UILabel(frame: CGRect(x: Common.Size(s:10), y: lbText1.frame.size.height + lbText1.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:20), height: Common.Size(s:75)))
        lbText2.textAlignment = .left
        lbText2.textColor = UIColor.black
        lbText2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbText2.numberOfLines = 0
        lbText2.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        lbText2.minimumScaleFactor = 0.8
        lbText2.text = "2. Nếu khách quên mật khẩu ICloud, shop hướng dẫn khách gọi lên tổng đài Apple nhờ hỗ trợ theo số 18001127 và gửi mail thông tin cho Apple cùng ngày tạo phiếu và cập nhật ngày Apple hẹn cấp lại Icloud dưới đây."
        scrollView.addSubview(lbText2)
        
        tfInput = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:15), y: lbText2.frame.origin.y + lbText2.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:20) , height: Common.Size(s:55)), iconType: .image);
        tfInput.placeholder = "Ngày Apple hẹn cấp lại Icloud"
        tfInput.title = "Ngày Apple hẹn cấp lại Icloud"
        tfInput.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfInput.keyboardType = UIKeyboardType.numberPad
        tfInput.returnKeyType = UIReturnKeyType.done
        tfInput.clearButtonMode = UITextField.ViewMode.whileEditing
        tfInput.delegate = self
        tfInput.tintColor = UIColor(netHex:0x00955E)
        tfInput.textColor = .black
        tfInput.lineColor = .gray
        tfInput.selectedTitleColor = UIColor(netHex:0x00955E)
        tfInput.selectedLineColor = .gray
        tfInput.lineHeight = 1.0
        tfInput.selectedLineHeight = 1.0
        scrollView.addSubview(tfInput)
     
        tfInput.addTarget(self, action: #selector(InputIcloudDayBHViewController.textFieldDidEndEditing), for: .editingDidEnd)
        
        let btContinue = UIButton()
        btContinue.frame = CGRect(x: Common.Size(s:15), y: tfInput.frame.origin.y + tfInput.frame.size.height + Common.Size(s:10), width: tfInput.frame.size.width, height: Common.Size(s:40) )
        btContinue.backgroundColor = UIColor(netHex:0x00955E)
        btContinue.setTitle("Cập nhật", for: .normal)
        btContinue.addTarget(self, action: #selector(actionContinue), for: .touchUpInside)
        btContinue.layer.borderWidth = 0.5
        btContinue.layer.borderColor = UIColor.white.cgColor
        btContinue.layer.cornerRadius = 5.0
        
        scrollView.addSubview(btContinue)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btContinue.frame.origin.y + btContinue.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        
        
    }
    @objc func actionContinue(){
        if(self.tfInput.text == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Chưa nhập ngày hẹn Icloud !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        if (!checkDate(stringDate: self.tfInput.text!)){
            
            let alert = UIAlertController(title: "Thông báo", message: "Sai đinh dạng ngày tháng vui lòng kiểm tra lại !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.tfInput.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
        }else{
            let listDate = self.tfInput.text!.components(separatedBy: "/")
            if (listDate.count == 3){
                let yearText = listDate[2]
                let monthText = listDate[1]
                let dayText = listDate[0]
                let date = Date()
                let calendar = Calendar.current
                let year = calendar.component(.year, from: date)
                let month = calendar.component(.month, from: date)
                let day = calendar.component(.day, from: date)
                
                let yearInt = Int(yearText)
                let monthInt = Int(monthText)
                let dayInt = Int(dayText)
                
                if (year > yearInt!){
                    let alert = UIAlertController(title: "Thông báo", message: "Năm ngày hẹn không được nhỏ hơn năm hiện tại", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        self.tfInput.text = ""
                        self.tfInput.becomeFirstResponder()
                    })
                    self.present(alert, animated: true)
                    return
                }
                if(month > monthInt! && year == yearInt!){
                    let alert = UIAlertController(title: "Thông báo", message: "Tháng hẹn không được nhỏ hơn tháng hiện tại", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        self.tfInput.text = ""
                        self.tfInput.becomeFirstResponder()
                    })
                    self.present(alert, animated: true)
                    return
                }
                if(month == monthInt!){
                    if(day > dayInt!){
                        let alert = UIAlertController(title: "Thông báo", message: "Ngày hẹn không được nhỏ hơn ngày hiện tại", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            self.tfInput.text = ""
                            self.tfInput.becomeFirstResponder()
                        })
                        self.present(alert, animated: true)
                        return
                    }
                }
                
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.navigationController?.popViewController(animated: false)
            self.dismiss(animated: false, completion: nil)
        }
        
        delegate?.returnDate(input:self.tfInput.text!,index:self.indexID!)
    
    }
    
    @objc func backButton(){
        
        delegate?.returnDate(input: "",index:self.indexID!)
        self.navigationController?.popViewController(animated: false)
        self.dismiss(animated: false, completion: nil)
        
        
        
    }
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if(textField == tfInput){
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
           if(textField == tfInput){
               if let text = textField.text, text != "" && text != "DD/MM/YYYY" {
                   // Do something with your value
               } else {
                   textField.text = ""
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
}
