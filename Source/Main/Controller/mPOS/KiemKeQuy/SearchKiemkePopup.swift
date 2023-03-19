//
//  SearchKiemkePopup.swift
//  fptshop
//
//  Created by Ngoc Bao on 07/09/2021.
//  Copyright © 2021 Duong Hoang Minh. All rights reserved.
//

import UIKit
import DropDown

class SearchKiemkePopup: UIViewController {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var shopView: UIView!
    @IBOutlet weak var shopTxt: SearchTextField!
    @IBOutlet weak var fromDateTxt: UITextField!
    @IBOutlet weak var todateTxt: UITextField!
    @IBOutlet weak var stateTxt: UITextField!
    @IBOutlet weak var stateButton: UIButton!
    @IBOutlet weak var numberTxt: UITextField!
    private var warehouses: [ItemShop] = []
    var selectedShop: ItemShop?
    let datePicker = UIDatePicker()
    let todatePicker = UIDatePicker()
    let dropDownMenu = DropDown()
    var state = ""
    var onSearchs:((String,String,String,String,String)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.alpha = 0.5
        showDatePicker()
        fromDateTxt.text = Common.gettimeWith(format: "dd/MM/yyyy")
        todateTxt.text = Common.gettimeWith(format: "dd/MM/yyyy")
        if Cache.user?.JobTitle == "00292" || Cache.user?.JobTitle == "00358" || Cache.user?.JobTitle == "00753" || Cache.user?.JobTitle == "00375"{
            APIManager.searchShop() { (results) in
                var listCom: [String] = []
                self.warehouses = results
                results.forEach { item in
                    listCom.append("\(item.code) - \(item.name)")
                }
                self.shopTxt.filterStrings(listCom)
            }
            shopTxt.startVisible = true
            shopTxt.theme.bgColor = UIColor.white
            shopTxt.theme.fontColor = UIColor.black
            shopTxt.theme.fontColor = UIColor.black
            shopTxt.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
            shopTxt.theme.cellHeight = Common.Size(s:40)
            shopTxt.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
            self.shopTxt.itemSelectionHandler = { filteredResults, itemPosition in
                let item = filteredResults[itemPosition]
                self.shopTxt.text = item.title
                self.selectedShop = self.warehouses.filter({item.title.components(separatedBy: "-").first?.trim() == $0.code}).first
                self.view.endEditing(true)
            }
        } else {
            shopTxt.text = "\(Cache.user!.ShopName)"
            shopTxt.isUserInteractionEnabled = false
        }
    }
    
    @objc func setupDrop() {
        dropDownMenu.anchorView = stateButton
        dropDownMenu.bottomOffset = CGPoint(x: 0, y:(dropDownMenu.anchorView?.plainView.bounds.height)! + 10)
        dropDownMenu.dataSource = ["Mở", "Giải Trình", "Hoàn tất", "Hủy"]
        dropDownMenu.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dropDownMenu.selectionAction = { [weak self] (index, item) in
            self?.stateTxt.text = item
            switch index {
            case 0:
                self?.state = "O"
            case 1:
                self?.state = "W"
            case 2:
                self?.state = "F"
            case 3:
                self?.state = "C"
            default:
                break
            }
        }
        dropDownMenu.show()
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        todatePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
            todatePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        fromDateTxt.inputAccessoryView = toolbar
        fromDateTxt.inputView = datePicker
        
        //todatePicker
        let toolbar2 = UIToolbar()
        toolbar2.sizeToFit()
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedateTodatePicker));
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar2.setItems([cancel,space,done], animated: false)
        todateTxt.inputAccessoryView = toolbar2
        todateTxt.inputView = todatePicker
    }
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        fromDateTxt.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func donedateTodatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        todateTxt.text = formatter.string(from: todatePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @IBAction func onState() {
        setupDrop()
    }
    
    
    @IBAction func onClose() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearch() {
        
        let maxDay: Double = 7
        let fromdate = Common.toDate(str: fromDateTxt.text!, fromDateFormat: "dd/MM/yyyy")
        let todate = Common.toDate(str: todateTxt.text!, fromDateFormat: "dd/MM/yyyy")
        let minusValue = (todate?.timeIntervalSince1970 ?? 0) - (fromdate?.timeIntervalSince1970 ?? 0)
        if minusValue > (86400 * maxDay) { // 1 day = 86400s
            showPopUp("Chỉ được tìm kiếm từ ngày đến ngày trong giới hạn tối đa \(maxDay.removeZerosFromEnd()) ngày", "Thông báo", buttonTitle: "OK")
            return
        }
//        if state == "" {
//            showPopUp("Bạn chưa chọn trạng thái", "Thông báo", buttonTitle: "OK")
//            return
//        }
//        if numberTxt.text == "" {
//            showPopUp("Bạn chưa nhập số phiếu", "Thông báo", buttonTitle: "OK")
//            return
//        }
        if let search = onSearchs {
            search(fromDateTxt.text!,todateTxt.text!,state,numberTxt.text ?? "",selectedShop != nil ? selectedShop!.code : "")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
