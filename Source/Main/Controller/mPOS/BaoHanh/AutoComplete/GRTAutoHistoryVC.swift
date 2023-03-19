//
//  GRTAutoHistoryVC.swift
//  fptshop
//
//  Created by Ngoc Bao on 23/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown

class GRTAutoHistoryVC: BaseController {
    
    lazy var searchBar:UISearchBar = UISearchBar()
    
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var dropDownLabel: UILabel!
    @IBOutlet weak var fromDateTxt: UITextField!
    @IBOutlet weak var todateTxt: UITextField!
     let datePicker = UIDatePicker()
    let todatePicker = UIDatePicker()
    
    @IBOutlet weak var tableView: UITableView!
    
    let dropDownMenu = DropDown()
    
    var listSearch = [GRTHistoryItem]()
    var filterList = [GRTHistoryItem]()
    
    let cellIdentifier = "GuaranteeAutoCompleteCellTableViewCell"
    var choosingOption = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let current = formatter.string(from: currentDateTime)
        fromDateTxt.text = current
        todateTxt.text = current
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.navigationController?.navigationBar.isTranslucent = true
        self.view.backgroundColor = .white
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Nhập số phiếu"
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(setupDrop))
        self.dropDownView.addGestureRecognizer(gesture)
        
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = .white
            searchBar.searchTextField.font = UIFont.systemFont(ofSize: 13)
            searchBar.searchTextField.clearButtonMode = .whileEditing
            let placeholderLabel = searchBar.searchTextField.value(forKey: "placeholderLabel") as? UILabel
            placeholderLabel?.font = UIFont.italicSystemFont(ofSize: 13.0)
        } else {
            // Fallback on earlier versions
            let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideUISearchBar?.font = UIFont.systemFont(ofSize: 13)
            let placeholderLabel = textFieldInsideUISearchBar?.value(forKey: "placeholderLabel") as? UILabel
            placeholderLabel?.font = UIFont.italicSystemFont(ofSize: 13.0)
        }
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        self.navigationItem.titleView = searchBar
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
        self.searchBar.addDoneButtonOnKeyboard()
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:30), height: Common.Size(s:30))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:30), height: Common.Size(s:40))
        viewLeftNav.addSubview(btBackIcon)
        showDatePicker()
        getListHistory()
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
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
    
    func Search() {
        guard let fromdate = fromDateTxt.text?.toDate() else {return}
        
        guard let todate = todateTxt.text?.toDate() else {return}
        let state = choosingOption
        var filterData = [GRTHistoryItem]()
        switch state {
        case 0:
            filterData = listSearch
        case 1:
            filterData = listSearch.filter({$0.kqTest_Ten.lowercased() == "ok"})
        case 2:
            filterData = listSearch.filter({$0.kqTest_Ten.lowercased() == "notok"})
        default:
            break
        }
        let finalFilter = filterData.filter({$0.ngayTest.toDate() >= fromdate && $0.ngayTest.toDate() <= todate})
        filterList = finalFilter
        self.tableView.reloadData()
    }
    
    func toDate(str: String,fromDateFormat: String = "dd/MM/yyyy") -> Date? {
        let initalFormatter = DateFormatter()
        initalFormatter.dateFormat = fromDateFormat

        guard let initialDate = initalFormatter.date(from: str) else {
            print ("Error in dateString or in fromDateFormat")
            return nil
        }
        return initialDate
    }
    
    @objc func donedatePicker(){
       let formatter = DateFormatter()
       formatter.dateFormat = "dd/MM/yyyy"
       fromDateTxt.text = formatter.string(from: datePicker.date)
       self.view.endEditing(true)
       Search()
     }
    
    @objc func donedateTodatePicker(){
       let formatter = DateFormatter()
       formatter.dateFormat = "dd/MM/yyyy"
       todateTxt.text = formatter.string(from: todatePicker.date)
       self.view.endEditing(true)
       Search()
     }

     @objc func cancelDatePicker(){
        self.view.endEditing(true)
      }
    
    @objc func setupDrop() {
        dropDownMenu.anchorView = dropDownView
        dropDownMenu.bottomOffset = CGPoint(x: 0, y:(dropDownMenu.anchorView?.plainView.bounds.height)! + 10)
        dropDownMenu.dataSource = ["Tất cả", "OK", "Not OK"]
        dropDownMenu.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dropDownMenu.selectionAction = { [weak self] (index, item) in
            self?.choosingOption = index
            self?.dropDownLabel.text = item
            self?.Search()
        }
        dropDownMenu.show()
    }
    
    func getListHistory() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            GuaranteeAutoApiManager.shared.getListHistoryGRT(sophieuBH: 0, fromdate: "", todate: "", state: 0) { [weak self] Response, err in
                guard let self = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err != "" {
                        self.showPopup(with: err, completion: nil)
                        self.listSearch = []
                        self.filterList = []
                    } else {
                        self.listSearch = Response
                        self.filterList = Response
                        self.Search()
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}

extension GRTAutoHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GuaranteeAutoCompleteCellTableViewCell
        let item = filterList[indexPath.row]
        cell.bindCell(item: item,isSearch: false)
        return cell
    }
}

extension GRTAutoHistoryVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(key: "\(searchBar.text ?? "")")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(key: "\(searchBar.text ?? "")")
    }
    
    func search(key:String){
        if key.count > 0 {
            filterList = listSearch.filter({"\($0.maPhieuBH)".lowercased().contains(key.lowercased())})
        } else {
            filterList = listSearch
        }
        tableView.reloadData()
    }
}
