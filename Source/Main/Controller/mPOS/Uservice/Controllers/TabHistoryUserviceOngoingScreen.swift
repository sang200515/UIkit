//
//  TabHistoryUserviceOngoingScreen.swift
//  fptshop
//
//  Created by KhanhNguyen on 9/17/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class TabHistoryUserviceOngoingScreen: BaseController {
    var parentNavigationController : UINavigationController?
    
    let vPickerDate: PickerDateForUserviceView = {
        let view = PickerDateForUserviceView()
        return view
    }()
    
    let tfSearch: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .left
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .white
        tf.clearButtonMode = .whileEditing
        tf.returnKeyType = .done
        return tf
    }()
    
    let tableView: SelfSizedTableView = {
        let tableView = SelfSizedTableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var keyString: String = ""
    
    private var listHistoryUserviceOngoing: [HistoryUserviceTickeData] = []
    private var listHistoryUserviceOngoingFilteredInMonth: [HistoryUserviceTickeData] = []
    private var listItemAfterFilteredByText: [HistoryUserviceTickeData] = []
    private var listItemAfterFilteredByDate: [HistoryUserviceTickeData] = []
    private var listItemAfterFilterByDateAndText: [HistoryUserviceTickeData] = []
    private var datesPicked: [String] = []
    private var numberChoose: Int = 0
    
    private var isPickedDate: Bool = false
    
    override func setupViews() {
        super.setupViews()
        numberChoose = 0
        self.view.addSubview(vPickerDate)
        vPickerDate.myCustomAnchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 22, leadingConstant: 8, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 148, heightConstant: 20)
        vPickerDate.pickerDateForUserviceViewDelegate = self
        
        tfSearch.attributedPlaceholder = NSAttributedString(string: "Tìm số ticket/Tên ticket/Người YC", attributes: [NSAttributedString.Key.foregroundColor: Constants.COLORS.text_gray, NSAttributedString.Key.font: UIFont.regularFontOfSize(ofSize: 10)])
        tfSearch.textColor = UIColor.black
        tfSearch.font = UIFont.regularFontOfSize(ofSize: 11)
        self.view.addSubview(tfSearch)
        tfSearch.myCustomAnchor(top: self.view.topAnchor, leading: self.vPickerDate.trailingAnchor, trailing: self.view.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 16, leadingConstant: 4, trailingConstant: 8, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 24)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 5, width: 1, height: 1))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.init(named: "ic_search_black")
        tfSearch.rightView = imageView
        tfSearch.rightViewMode = UITextField.ViewMode.always
        tfSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryUserviceTableViewCell.self, forCellReuseIdentifier: HistoryUserviceTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        tableView.myCustomAnchor(top: self.tfSearch.bottomAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, bottom: self.view.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 8, trailingConstant: 8, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    override func getData() {
        super.getData()
        getListHistoryUservice()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListHistoryUservice()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        numberChoose = 0
        keyString = textField.text!
        
        if isPickedDate == true && !listItemAfterFilteredByText.isEmpty {
            let item = listItemAfterFilteredByText.filter { items in
                return datesPicked.contains { date in
                    items.createdTime?.range(of: date, options: .caseInsensitive) != nil
                }
            }
            listItemAfterFilterByDateAndText = item
            isPickedDate = false
            tableView.reloadData()
        } else {
            let searchNumber =  NumberFormatter().number(from: keyString)?.intValue
            listItemAfterFilteredByText = listHistoryUserviceOngoing.filter{$0.ticketOwner?.range(of: keyString, options: .caseInsensitive) != nil || $0.service?.range(of: keyString, options: .caseInsensitive) != nil || $0.id == searchNumber}
            numberChoose = 1
            tableView.reloadData()
        }
        
        if keyString == "" {
            numberChoose = 0
            tableView.reloadData()
        }
        tableView.reloadData()
    }
    
    func getListHistoryUservice() {
        guard let user = Cache.user else {return}
        guard let token = UserDefaults.standard.getMyInfoToken() else {return}
        
        let email = user.Email
        let emailAfterPlist = email.split{$0 == "@"}.map(String.init)
        let name = emailAfterPlist[0]
        
        let parameters: [String:Any] = [
            "email": name,
            "token": token,
            "fromSystem": "mPOS",
            "statusType": "ongoing"
        ]
        
        UserviceAPIManager.shared.getListHistoryUservice(params: parameters, completion: { [weak self] (item, msg) in
            guard let strongSelf = self else {return}
            strongSelf.getAllItemsInMonths(item)
            strongSelf.listHistoryUserviceOngoing = item
        }) { (error) in
            self.showAlertOneButton(title: "Thông báo Uservice", with: error, titleButton: "Đồng ý")
        }
    }
    
    func getDatesPicked(_ dates: [String]) {
        isPickedDate = true
        datesPicked = dates
        numberChoose = 0
        listItemAfterFilteredByDate.removeAll()
        let item = listHistoryUserviceOngoing.filter { items in
            return dates.contains { date in
                items.createdTime?.range(of: date, options: .caseInsensitive) != nil
            }
        }
        listItemAfterFilteredByDate = item
        numberChoose = 2
        tableView.reloadData()
    }
    
    func getAllItemsInMonths(_ items: [HistoryUserviceTickeData]) {
        listHistoryUserviceOngoing = items
        let allDays = Date().getAllDays()
        listHistoryUserviceOngoing.removeAll()
        let itemAfterFiltered = items.filter{ items in
            return allDays.contains { (date) -> Bool in
                items.createdTime?.range(of: date, options: .caseInsensitive) != nil
            }
        }
        listHistoryUserviceOngoingFilteredInMonth = itemAfterFiltered
        tableView.reloadData()
    }
}

extension TabHistoryUserviceOngoingScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch numberChoose {
        case 0:
            return listHistoryUserviceOngoingFilteredInMonth.count
        case 1:
            return listItemAfterFilteredByText.count
        case 2:
            return listItemAfterFilteredByDate.count
        case 3:
            return listItemAfterFilterByDateAndText.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryUserviceTableViewCell.identifier, for: indexPath) as! HistoryUserviceTableViewCell
        let cell = HistoryUserviceTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: HistoryUserviceTableViewCell.identifier)
      
        switch numberChoose {
        case 0:
            let item = listHistoryUserviceOngoingFilteredInMonth[indexPath.row]
            cell.loadCell(item)
        case 1:
            let item = listItemAfterFilteredByText[indexPath.row]
            cell.loadCell(item)
        case 2:
            let item = listItemAfterFilteredByDate[indexPath.row]
            cell.loadCell(item)
        case 3:
            let item = listItemAfterFilterByDateAndText[indexPath.row]
            cell.loadCell(item)
        default:
            break
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension TabHistoryUserviceOngoingScreen: PickerDateForUserviceViewDelegate {
    func getDatesPicker(_ dates: [String]) {
        getDatesPicked(dates)
    }
}
