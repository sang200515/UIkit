//
//  EcomOrdersVC.swift
//  fptshop
//
//  Created by Ngoc Bao on 08/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown
import CallKit

var docNumEcom = 0
class EcomOrdersVC: UIViewController, CXCallObserverDelegate {
    
    @IBOutlet weak var chuaPhanCongLbl: UILabel!
    @IBOutlet weak var chuaPhanCongLine: UIView!
    
    @IBOutlet weak var daPhanCongLbl: UILabel!
    @IBOutlet weak var daPhanCongLine: UIView!
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sesarchTxt: UITextField!
    
    let dropDownMenu = DropDown()
    var listOrders: [Ecom_Order_Item] = []
    var filterListOrders: [Ecom_Order_Item] = []
    var listNV: [EcomOrderEmploy] = []
    var selectedOrder: Ecom_Order_Item?
    var isChuaphancong = true
    var refresh = UIRefreshControl()
    let co = CXCallObserver()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SM Phân công đơn hàng"
        tableView.registerTableCell(EcomOrderCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        onSelect(isChuaPhanCong: true)
        loadListOrders()
        refresh.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refresh)
        sesarchTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        configureNavigationItem()
        co.setDelegate(self, queue: DispatchQueue.main)
    }
    
    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
           if call.hasEnded {
               self.loadListOrders()
           }
           if call.hasEnded == false && call.hasConnected {
               print("Call is connected")
           }
           if call.isOutgoing {
               if docNumEcom != 0 {
                   Provider.shared.ecomOrders.writeLog(user: Cache.user!.UserName, shopCode: Cache.user!.ShopCode, ecomNum: docNumEcom) { object in
                   } failure: {error in}
               }
           }
       }
    
    func configureNavigationItem(){
        //left menu icon
        let btLeftIcon = Common.initBackButton()
        btLeftIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
    }
    @objc func handleBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        sesarchTxt.text = ""
        self.view.endEditing(true)
       refresh.endRefreshing()
       loadListOrders()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text ?? ""
        if text != "" {
            filterListOrders = listOrders.filter({"\($0.docNum)".lowercased().contains(text.lowercased()) || $0.u_LicTrad.lowercased().contains(text.lowercased())})
        } else {
            filterListOrders = listOrders
        }
        tableView.reloadData()
    }
    
    func loadListOrders() {
        docNumEcom = 0
        listOrders = []
        filterListOrders = []
        Provider.shared.ecomOrders.loadListOrders(user: Cache.user!.UserName, shopCode: Cache.user!.ShopCode, type: isChuaphancong ? "1" : "2",success: { [weak self] result in
            guard let self = self else { return }
            self.listOrders = result
            self.filterListOrders = result
            if result.count == 0 {
                TableViewHelper.EmptyMessage(message: "Không có đơn hàng ecom", viewController: self.tableView)
            }

//            let cells = self.tableView.visibleCells
//            for cell in cells {
//                let indePath = self.tableView.indexPath(for: cell)
//
//            }
            self.tableView.reloadData()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            self.tableView.reloadData()
        })
    }
    
    @objc func setupDrop() {
        dropDownMenu.setupCornerRadius(10)
        dropDownMenu.anchorView = sesarchTxt
        dropDownMenu.bottomOffset = CGPoint(x: 0, y:(dropDownMenu.anchorView?.plainView.bounds.height)! + 10)
        dropDownMenu.dataSource = self.listNV.map({ object in
            return (object.emomployeeFull)
        })
        dropDownMenu.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dropDownMenu.selectionAction = { [weak self] (index, item) in
            guard let self = self else { return }
            self.showAlertMultiOption(title: "Thông báo", message: "Bạn muốn phân công cho \(self.listNV[index].employeeCode) - \(self.listNV[index].employeeName) không?", options: "Đồng ý","Hủy", buttonAlignment: .horizontal) { indexSelect in
                if indexSelect == 0 {
                    Provider.shared.ecomOrders.phancongNV(user: Cache.user!.UserName, shopCode: Cache.user!.ShopCode, ecomNum: self.selectedOrder?.docNum ?? 0, sale: self.listNV[index].employeeCode,typeAssignment : self.isChuaphancong ? "1" : "2",success: { [weak self] result in
                        guard let self = self else { return }
                        if result?.p_status == 1 {
                            self.showPopUp("Phân công nhân viên thành công", "Thông báo", buttonTitle: "OK") {
                                self.loadListOrders()
                            }
                        } else {
                            self.showPopUp(result?.p_messages ?? "", "Thông báo", buttonTitle: "OK") {
                            }
                        }
                    }, failure: { [weak self] error in
                        guard let self = self else { return }
                        self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
                        self.tableView.reloadData()
                    })
                }
            }
        }
        self.dropDownMenu.show()
    }
    
    
    
    private func onSelect(isChuaPhanCong: Bool) {
        sesarchTxt.text = ""
        self.view.endEditing(true)
        chuaPhanCongLbl.textColor = isChuaPhanCong ? .black : .lightGray
        daPhanCongLbl.textColor = !isChuaPhanCong ? .black : .lightGray
        chuaPhanCongLine.backgroundColor = isChuaPhanCong ? UIColor(red: 66, green: 133, blue: 107) : .white
        daPhanCongLine.backgroundColor = !isChuaPhanCong ? UIColor(red: 66, green: 133, blue: 107) : .white
    }
    
    
    @IBAction func onChangeTab(_ sender: UIButton) {
        isChuaphancong = sender.tag == 0
        onSelect(isChuaPhanCong: sender.tag == 0)
        loadListOrders()
    }
    
}


extension EcomOrdersVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterListOrders.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if filterListOrders.count > 0 {
            let cell = tableView.dequeueTableCell(EcomOrderCell.self)
            cell.delegate = self
            let item = filterListOrders[indexPath.row]
            cell.bindCell(item: item, isChuaPhanCong: isChuaphancong)
            cell.phancong = {
                self.selectedOrder = item
                Provider.shared.ecomOrders.loadEmployees(user: Cache.user!.UserName, shopCode: Cache.user!.ShopCode) { [weak self] list in
                    guard let self = self else {return}
                    if list.count > 0 {
                        self.listNV = list
                        self.setupDrop()
                    } else {
                        self.showAlert("Danh sách nhân viên rỗng")
                    }
                } failure: { [weak self] error in
                    guard let self = self else { return }
                    self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
                }

            }
            cell.xacNhan = {
                let vc = ComfirmOrderEcomPopup()
                vc.model = item
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overCurrentContext
                vc.onConfirm = { [weak self] (tag, content, timeDelivery, addressDelivery, tinh, huyen, xa) in
                    Provider.shared.ecomOrders.confirmSale(ecomNum: item.docNum, status: tag, comment: content,timeDelivery: timeDelivery, addressDelivery: addressDelivery, tinh:tinh,huyen:huyen,xa:xa) { [weak self] result in
                        guard let self = self else { return }
                        self.showPopUp(result?.p_messages ?? "", "Thông báo", buttonTitle: "OK") {
                            if result?.p_status == 1 {
                                self.loadListOrders()
                            }
                        }
                    } failure: {[weak self] error in
                        guard let self = self else { return }
                        self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
                        self.tableView.reloadData()
                    }

                }
                self.present(vc, animated: true, completion: nil)
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension EcomOrdersVC : EcomOrderCellDelegate {
    func didSelect(numberSO:Int) {
        let vc = EcomOderDetailsViewController()
        vc.docNum = "\(numberSO)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showLichSu(model:Ecom_Order_Item) {
        let vc = ComfirmOrderEcomPopup()
        vc.model = model
        vc.isReview = true
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
}
