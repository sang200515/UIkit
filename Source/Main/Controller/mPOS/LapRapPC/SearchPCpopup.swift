//
//  SearchPCpopup.swift
//  fptshop
//
//  Created by Sang Truong on 10/8/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown

class SearchPCpopup: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var shopTxt: SearchTextField!
    @IBOutlet weak var stateTxt: UITextField!
    @IBOutlet weak var todateTxt: UITextField!
    @IBOutlet weak var fronDateTxt: UITextField!
    @IBOutlet weak var stateButton: UIButton!
    //get end of month
    let endOfMonth = Date().endOfMonth()
    let formatter = DateFormatter()
    
    private var warehouses: [ItemShop] = []
    var selectedShop: ItemShop?
    let datePicker = UIDatePicker()
    let todatePicker = UIDatePicker()
    let dropDownMenu = DropDown()
    var state = ""
    var onSearch:((String,String,String,String)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
       

        mainView.alpha = 0.5
        showDatePicker()
        fronDateTxt.text = Common.gettimeWith(format: "dd/MM/yyyy")
        formatter.dateFormat = "dd/MM/yyyy"
        todateTxt.text = Common.gettimeWith(format: "\(formatter.string(from: endOfMonth))")
        
        ProgressView.shared.show()
        APIManager.searchShop() { (results) in
            ProgressView.shared.hide()
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
        if Cache.user!.ShopCode == "11000" || Cache.user!.ShopCode == "" {
            self.shopTxt.itemSelectionHandler = { filteredResults, itemPosition in
                let item = filteredResults[itemPosition]
                self.shopTxt.text = item.title
                self.selectedShop = self.warehouses.filter({item.title.components(separatedBy: "-").first?.trim() == $0.code}).first
                self.view.endEditing(true)
            }
        }
        else {
            //isUserInteractionEnabled
            self.shopTxt.text = Cache.user!.ShopName
            
            shopTxt.isUserInteractionEnabled = false
            stateTxt.isUserInteractionEnabled = false
            stateTxt.text = "Tất cả tình trạng"
        }
        
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
        fronDateTxt.inputAccessoryView = toolbar
        fronDateTxt.inputView = datePicker
        
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
        fronDateTxt.text = formatter.string(from: datePicker.date)
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
    
    @objc func setupDrop() {
        dropDownMenu.anchorView = stateButton
        dropDownMenu.bottomOffset = CGPoint(x: 0, y:(dropDownMenu.anchorView?.plainView.bounds.height)! + 10)
        dropDownMenu.dataSource = ["Chờ xử lí", "Đang xử lí", "Hoàn tất", "Hủy"]
        dropDownMenu.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dropDownMenu.selectionAction = { [weak self] (index, item) in
            self?.stateTxt.text = item
            switch index {
            case 0:
                self?.state = "1"
            case 1:
                self?.state = "2"
            case 2:
                self?.state = "3"
            case 3:
                self?.state = "4"
            default:
                break
            }
        }
        
        dropDownMenu.show()
    }

    @IBAction func selectState(_ sender: Any) {
        setupDrop()
    }
    @IBAction func selectShop(_ sender: Any) {}
    
    @IBAction func onSearchAction(_ sender: Any) {
        guard let shop = shopTxt.text,!shop.isEmpty else {
            showPopUp("Bạn chưa chọn shop", "Thông báo", buttonTitle: "OK", handleOk: nil)
            return
        }
        guard let tinhtrang = stateTxt.text,!tinhtrang.isEmpty else {
            showPopUp("Bạn chưa chọn tình trạng", "Thông báo", buttonTitle: "OK", handleOk: nil)
            return
        }
        self.dismiss(animated: true)
        if let search = onSearch {
            search(shopTxt.text?.split(separator: "-").first?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" , state,fronDateTxt.text ?? "",todateTxt.text ?? "")        }
    }
    
    @IBAction func onClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
