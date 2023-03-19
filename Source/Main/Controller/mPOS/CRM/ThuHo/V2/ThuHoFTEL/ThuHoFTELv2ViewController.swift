//
//  ThuHoFtelv2ViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 06/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ThuHoFtelv2ViewController: UIViewController {

    var searchField: UITextField!
    var fromDatePicker = UIDatePicker()
    var fromDateToolbar = UIToolbar()
    var toDatePicker = UIDatePicker()
    var toDateToolbar = UIToolbar()
    
    var pageMenu: CAPSPageMenu?
    var indexMenu: Int = 0
    var controller1: UnconfimredFtelViewController!
    var controller2: ConfimredFtelViewController!
    private var unconfimredOrders: [FtelReceipt] = []
    private var confirmedOrders: [FtelReceipt] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadData()
    }

    private func setupViews() {
        let width = UIScreen.main.bounds.size.width

        // back button
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(ThuHoFtelv2ViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)

        // search bar
        searchField = UITextField(frame: CGRect(x: 30, y: 20, width: width, height: 35))
        searchField.delegate = self
        searchField.placeholder = "Tìm kiếm theo SĐT/Số phiếu"
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 5

        searchField.leftViewMode = .always
        let searchImageViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let searchImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        let search = UIImage(named: "search", in: Bundle(for: YNSearch.self), compatibleWith: nil)
        searchImageView.image = search
        searchImageViewWrapper.addSubview(searchImageView)
        searchField.leftView = searchImageViewWrapper
        self.navigationItem.titleView = searchField
        
        fromDateToolbar.barStyle = UIBarStyle.default
        fromDateToolbar.isTranslucent = true
        fromDateToolbar.sizeToFit()

        let fromDateDoneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(handleFromDate))

        fromDateToolbar.setItems([fromDateDoneButton], animated: false)
        fromDateToolbar.isUserInteractionEnabled = true
        
        toDateToolbar.barStyle = UIBarStyle.default
        toDateToolbar.isTranslucent = true
        toDateToolbar.sizeToFit()

        let toDateDoneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(handleToDate))

        toDateToolbar.setItems([toDateDoneButton], animated: false)
        toDateToolbar.isUserInteractionEnabled = true
        
        
        let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        fromDatePicker.datePickerMode = .date
        fromDatePicker.date = previousMonth ?? Date()
        fromDatePicker.maximumDate = Date()
        toDatePicker.datePickerMode = .date
        toDatePicker.date = Date()
        toDatePicker.minimumDate = previousMonth
        
        if #available(iOS 13.4, *) {
            fromDatePicker.preferredDatePickerStyle = .wheels
            toDatePicker.preferredDatePickerStyle = .wheels
        }
        
        setUpTabViews()
    }

    private func setUpTabViews() {
        var controllerArray: [UIViewController] = []
        controller1 = UnconfimredFtelViewController()
        controller1.title = "CHƯA XÁC NHẬN"
        controller1.parentNavigationController = self
        controllerArray.append(controller1)

        controller2 = ConfimredFtelViewController()
        controller2.parentNavigationController = self
        controller2.title = "ĐÃ XÁC NHẬN"
        controllerArray.append(controller2)

        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .scrollMenuBackgroundColor(UIColor.white),
            .viewBackgroundColor(UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)),
            .bottomMenuHairlineColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 0.1)),
            .selectionIndicatorColor(UIColor(netHex:0x00955E)),
            .menuMargin(Common.Size(s: 10)),
            .menuHeight(Common.Size(s: 40)),
            .selectedMenuItemLabelColor(UIColor(netHex:0x00955E)),
            .unselectedMenuItemLabelColor(UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)),
            .menuItemFont(UIFont.boldSystemFont(ofSize: Common.Size(s: 14))),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorRoundEdges(true),
            .selectionIndicatorHeight(2.0),
            .menuItemSeparatorPercentageHeight(0.0)
        ]

        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        pageMenu?.delegate = self
        pageMenu?.view.subviews
            .map { $0 as? UIScrollView }
            .forEach { $0?.isScrollEnabled = false }
        self.view.addSubview(pageMenu!.view)
    }

    func loadData() {
        let fromDate = fromDatePicker.date.toString(dateFormat: "dd/MM/yyyy")
        let toDate = toDatePicker.date.toString(dateFormat: "dd/MM/yyyy")
        Provider.shared.thuHoFtelAPIService.getListFtelOrder(fromDate: fromDate, toDate: toDate, success: { [weak self] data in
            guard let self = self else { return }
            self.confirmedOrders = data.filter { $0.orderStatus != 11 }
            self.unconfimredOrders = data.filter { $0.orderStatus == 11 }
            
            self.controller1.list = self.unconfimredOrders
            self.controller2.list = self.confirmedOrders
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
        })
    }
    
    func loadPaymentDetail(orderId: String) {
        Provider.shared.thuHoFtelAPIService.getFtelOrderDetail(orderId: orderId, success: { [weak self] data in
            guard let self = self, let detail = data else { return }
            let vc = FtelOrderDetailViewController()
            vc.isHistory = false
            vc.orderDetail = detail
            self.navigationController?.pushViewController(vc, animated: true)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
        })
    }

    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleFromDate() {
        self.view.endEditing(false)
        if controller1.tfFromDate != nil { controller1.tfFromDate.text = fromDatePicker.date.toString(dateFormat: "dd/MM/yyyy") }
        if controller2.tfFromDate != nil { controller2.tfFromDate.text = fromDatePicker.date.toString(dateFormat: "dd/MM/yyyy") }
        fromDatePicker.maximumDate = toDatePicker.date
        toDatePicker.minimumDate = fromDatePicker.date
        
        loadData()
    }
    
    @objc private func handleToDate() {
        self.view.endEditing(false)
        if controller1.tfToDate != nil { controller1.tfToDate.text = toDatePicker.date.toString(dateFormat: "dd/MM/yyyy") }
        if controller2.tfToDate != nil { controller2.tfToDate.text = toDatePicker.date.toString(dateFormat: "dd/MM/yyyy") }
        fromDatePicker.maximumDate = toDatePicker.date
        toDatePicker.minimumDate = fromDatePicker.date
        
        loadData()
    }
}

extension ThuHoFtelv2ViewController: CAPSPageMenuDelegate {
    func willMoveToPage(_ controller: UIViewController, index: Int) {
        searchField.text = ""
        controller1.searchText = ""
        controller2.searchText = ""
        indexMenu = index
    }
}

extension ThuHoFtelv2ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            switch indexMenu {
            case 0:
                controller1.searchText = updatedText
            case 1:
                controller2.searchText = updatedText
            default:
                break
            }
        }
        
        return true
    }
}
