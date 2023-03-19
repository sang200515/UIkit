//
//  PriceOfMonthViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 6/19/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import ActionSheetPicker_3_0

protocol PriceOfMonthViewControllerDelegate: NSObjectProtocol {
    
    func addPriceSuccess(items: [RequestPaymentTimePrice])
    
}

class PriceOfMonthViewController:UIViewController,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate{
    
    var tfFromDate:UITextField!
    var tfToDate:UITextField!
    var tfPrice:UITextField!
    var items: [RequestPaymentTimePrice] = []
    var tableView: UITableView  =   UITableView()
    var valueToDate:String = ""
    var valueFromDate:String = ""
    var delegate: PriceOfMonthViewControllerDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Giá thuê hàng tháng"
        navigationController?.navigationBar.isTranslucent = false

        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(PriceOfMonthViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        let lbTextFromDate = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:15), width: (UIScreen.main.bounds.size.width - Common.Size(s:45))/2, height: Common.Size(s:14)))
        lbTextFromDate.textAlignment = .left
        lbTextFromDate.textColor = UIColor.black
        lbTextFromDate.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextFromDate.text = "Thời gian từ (*)"
        self.view.addSubview(lbTextFromDate)
        
        tfFromDate = UITextField(frame: CGRect(x: lbTextFromDate.frame.origin.x, y: lbTextFromDate.frame.origin.y + lbTextFromDate.frame.size.height + Common.Size(s:5), width: lbTextFromDate.frame.size.width, height: Common.Size(s:35)))
        tfFromDate.placeholder = "Chọn ngày"
        tfFromDate.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfFromDate.borderStyle = UITextField.BorderStyle.roundedRect
        tfFromDate.autocorrectionType = UITextAutocorrectionType.no
        tfFromDate.keyboardType = UIKeyboardType.default
        tfFromDate.returnKeyType = UIReturnKeyType.done
        tfFromDate.clearButtonMode = UITextField.ViewMode.whileEditing
        tfFromDate.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfFromDate.delegate = self
        tfFromDate.isUserInteractionEnabled = false
        self.view.addSubview(tfFromDate)
        
        let viewFromDate: UIView = UIView(frame: tfFromDate.frame)
        self.view.addSubview(viewFromDate)
        
        let viewFromDateImage: UIImageView = UIImageView(frame: CGRect(x: viewFromDate.frame.size.width - viewFromDate.frame.size.height, y: viewFromDate.frame.size.height/4, width: viewFromDate.frame.size.height, height: viewFromDate.frame.size.height/2))
        viewFromDateImage.image = UIImage(named:"Calender2")
        viewFromDateImage.contentMode = .scaleAspectFit
        viewFromDate.addSubview(viewFromDateImage)
        
        let tapFromDate = UITapGestureRecognizer(target: self, action: #selector(self.handleTapFromDate(_:)))
        viewFromDate.addGestureRecognizer(tapFromDate)
        
        //--
        let lbTextToDate = UILabel(frame: CGRect(x: lbTextFromDate.frame.size.width + lbTextFromDate.frame.origin.x + Common.Size(s:15), y: lbTextFromDate.frame.origin.y, width: lbTextFromDate.frame.size.width, height: Common.Size(s:14)))
        lbTextToDate.textAlignment = .left
        lbTextToDate.textColor = UIColor.black
        lbTextToDate.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextToDate.text = "Thời gian đến (*)"
        self.view.addSubview(lbTextToDate)
        
        tfToDate = UITextField(frame: CGRect(x: lbTextToDate.frame.origin.x, y: lbTextToDate.frame.origin.y + lbTextToDate.frame.size.height + Common.Size(s:5), width: lbTextToDate.frame.size.width, height: Common.Size(s:35)))
        tfToDate.placeholder = "Chọn ngày"
        tfToDate.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfToDate.borderStyle = UITextField.BorderStyle.roundedRect
        tfToDate.autocorrectionType = UITextAutocorrectionType.no
        tfToDate.keyboardType = UIKeyboardType.default
        tfToDate.returnKeyType = UIReturnKeyType.done
        tfToDate.clearButtonMode = UITextField.ViewMode.whileEditing
        tfToDate.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfToDate.delegate = self
        tfToDate.isUserInteractionEnabled = false
        self.view.addSubview(tfToDate)
        
        let viewToDate: UIView = UIView(frame: tfToDate.frame)
        self.view.addSubview(viewToDate)
        
        let viewToDateImage: UIImageView = UIImageView(frame: CGRect(x: viewFromDate.frame.size.width - viewFromDate.frame.size.height, y: viewFromDate.frame.size.height/4, width: viewFromDate.frame.size.height, height: viewFromDate.frame.size.height/2))
        viewToDateImage.image = UIImage(named:"Calender2")
        viewToDateImage.contentMode = .scaleAspectFit
        viewToDate.addSubview(viewToDateImage)
        
        let tapToDate = UITapGestureRecognizer(target: self, action: #selector(self.handleTapToDate(_:)))
        viewToDate.addGestureRecognizer(tapToDate)
        
        
        let lbTextPrice = UILabel(frame: CGRect(x: tfFromDate.frame.origin.x , y: tfFromDate.frame.origin.y + tfFromDate.frame.size.height +  Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPrice.textAlignment = .left
        lbTextPrice.textColor = UIColor.black
        lbTextPrice.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPrice.text = "Giá thuê (*)"
        self.view.addSubview(lbTextPrice)
        
        tfPrice = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPrice.frame.origin.y + lbTextPrice.frame.size.height + Common.Size(s:5), width: lbTextPrice.frame.size.width, height: Common.Size(s:35)))
        tfPrice.placeholder = "Nhập số tiền"
        tfPrice.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPrice.borderStyle = UITextField.BorderStyle.roundedRect
        tfPrice.autocorrectionType = UITextAutocorrectionType.no
        tfPrice.keyboardType = UIKeyboardType.numberPad
        tfPrice.returnKeyType = UIReturnKeyType.done
        tfPrice.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPrice.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPrice.delegate = self
        self.view.addSubview(tfPrice)
        tfPrice.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let btPay = UIButton()
        btPay.frame = CGRect(x: Common.Size(s:15), y: tfPrice.frame.origin.y + tfPrice.frame.size.height + Common.Size(s:20), width: tfPrice.frame.size.width, height: Common.Size(s:35))
        btPay.backgroundColor = UIColor(netHex:0x04AB6E)
        btPay.setTitle("LƯU", for: .normal)
        btPay.addTarget(self, action: #selector(actionSave), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        self.view.addSubview(btPay)
        
        let viewHeader = UIView(frame: CGRect(x: 0, y: btPay.frame.origin.y + btPay.frame.size.height + Common.Size(s:15), width: UIScreen.main.bounds.size.width, height: Common.Size(s:35)))
        viewHeader.backgroundColor = UIColor(netHex:0x04AB6E)
        self.view.addSubview(viewHeader)
        
        let lbLbFromDate = UILabel(frame: CGRect(x: 0 , y: 0, width: UIScreen.main.bounds.size.width * 3/10, height: viewHeader.frame.size.height))
        lbLbFromDate.textAlignment = .center
        lbLbFromDate.textColor = UIColor.white
        lbLbFromDate.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbLbFromDate.text = "Thời gian từ"
        viewHeader.addSubview(lbLbFromDate)
        
        let lbLbToDate = UILabel(frame: CGRect(x: lbLbFromDate.frame.size.width  + lbLbFromDate.frame.origin.x , y: 0, width: UIScreen.main.bounds.size.width * 3/10, height: viewHeader.frame.size.height))
        lbLbToDate.textAlignment = .center
        lbLbToDate.textColor = UIColor.white
        lbLbToDate.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbLbToDate.text = "Thời gian đến"
        viewHeader.addSubview(lbLbToDate)
        
        let lbLbPrice = UILabel(frame: CGRect(x: lbLbToDate.frame.size.width  + lbLbToDate.frame.origin.x , y: 0, width: UIScreen.main.bounds.size.width * 3/10, height: viewHeader.frame.size.height))
        lbLbPrice.textAlignment = .center
        lbLbPrice.textColor = UIColor.white
        lbLbPrice.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbLbPrice.text = "Giá thuê"
        viewHeader.addSubview(lbLbPrice)
        
        tableView.frame = CGRect(x: 0, y:viewHeader.frame.origin.y + viewHeader.frame.size.height, width: viewHeader.frame.size.width, height: self.view.frame.size.height - viewHeader.frame.size.height - viewHeader.frame.origin.y - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemPriceTimeTableViewCell.self, forCellReuseIdentifier: "ItemPriceTimeTableViewCell")
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemPriceTimeTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemPriceTimeTableViewCell")
        let item:RequestPaymentTimePrice = items[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        cell.icDelete.tag = indexPath.row
        cell.icDelete.isUserInteractionEnabled = true
        cell.icDelete.addGestureRecognizer(singleTap)
        return cell
    }
    @objc func tapDetected(sender:UITapGestureRecognizer) {
        items.remove(at: sender.view!.tag)
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:35);
    }
    @objc func actionSave(sender: UIButton!){
        var moneyString:String = tfPrice.text!
        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        if(moneyString == ""){
            moneyString = "0"
        }
        let moneyInt = Int(moneyString)!
        if(valueFromDate == ""){
            let errorAlert = UIAlertController(title: "Thông báo", message: "Bạn phải chọn thời gian từ", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                alert -> Void in
                
            }))
            self.present(errorAlert, animated: true, completion: nil)
        }else if(valueToDate == ""){
            let errorAlert = UIAlertController(title: "Thông báo", message: "Bạn phải chọn thời gian đến", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                alert -> Void in
                
            }))
            self.present(errorAlert, animated: true, completion: nil)
        }else if(moneyInt <= 0){
            let errorAlert = UIAlertController(title: "Thông báo", message: "Bạn phải nhập giá tiền thuê", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                alert -> Void in
                
            }))
            self.present(errorAlert, animated: true, completion: nil)
        }else{
            let item = RequestPaymentTimePrice(fromDate: valueFromDate, toDate: valueToDate, price: moneyInt)
            items.append(item)
            self.tableView.reloadData()
            
            valueFromDate = ""
            valueToDate = ""
            tfFromDate.text = ""
            tfToDate.text = ""
            tfPrice.text = ""
        }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        var moneyString:String = textField.text!
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
    
    @objc func handleTapToDate(_ sender: UITapGestureRecognizer? = nil) {
        let datePicker = ActionSheetDatePicker(title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let strDate = dateFormatter.string(from: value as! Date)
            self.tfToDate.text = "\(strDate)"
            
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//            strDate = dateFormatter.string(from: value as! Date)
            self.valueToDate = strDate
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
        datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
        datePicker?.show()
    }
    
    
    @objc func handleTapFromDate(_ sender: UITapGestureRecognizer? = nil) {
        let datePicker = ActionSheetDatePicker(title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let strDate = dateFormatter.string(from: value as! Date)
            self.tfFromDate.text = "\(strDate)"
            
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//            strDate = dateFormatter.string(from: value as! Date)
            self.valueFromDate = strDate
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
        datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
        datePicker?.show()
    }
    @objc func actionBack() {
        delegate.addPriceSuccess(items: self.items)
        self.navigationController?.popViewController(animated: true)
    }
}
class ItemPriceTimeTableViewCell: UITableViewCell {
    var address: UILabel!
    var name: UILabel!
    var numMPOS: UILabel!
    var icDelete: UIImageView!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        name = UILabel()
        name.textColor = UIColor.black
        name.numberOfLines = 1
        name.textAlignment = .center
        name.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(name)
        
        address = UILabel()
        address.textColor = UIColor.black
        address.numberOfLines = 1
        address.textAlignment = .center
        address.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(address)
        
        numMPOS = UILabel()
        numMPOS.textColor = UIColor.black
        numMPOS.numberOfLines = 1
        numMPOS.textAlignment = .center
        numMPOS.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(numMPOS)
        
        icDelete = UIImageView()
        icDelete.image = UIImage(named:"delete-gray")
        icDelete.contentMode = .scaleAspectFit
        contentView.addSubview(icDelete)
    }
    
    func setup(so:RequestPaymentTimePrice){
        
        name.frame = CGRect(x: 0,y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width * 3/10,height: Common.Size(s:15))
        name.text = "\(so.fromDate)"
        
        address.frame = CGRect(x:name.frame.origin.x + name.frame.size.width,y: name.frame.origin.y,width: UIScreen.main.bounds.size.width * 3/10,height: Common.Size(s:15))
        address.text = "\(so.toDate)"
        
        numMPOS.frame = CGRect(x: address.frame.origin.x + address.frame.size.width,y: address.frame.origin.y ,width: UIScreen.main.bounds.size.width * 3/10,height: Common.Size(s:15))
        numMPOS.text = "\(Common.convertCurrencyV2(value: so.price))"
        
        icDelete.frame = CGRect(x: numMPOS.frame.origin.x + numMPOS.frame.size.width,y: numMPOS.frame.origin.y ,width: UIScreen.main.bounds.size.width/10,height: Common.Size(s:15))
        
    }
    
}
