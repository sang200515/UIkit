//
//  UngHoMienTrungVC.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 05/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class UngHoMienTrungVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    
    var listKhaoSat = [ItemKhaoSatMienTrung]()
    var anotherPrice = "0"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SupportCell", bundle: nil), forCellReuseIdentifier: "SupportCell")
        tableView.register(UINib(nibName: "SupportTitleCell", bundle: nil), forCellReuseIdentifier: "SupportTitleCell")
        navigationController?.navigationBar.barTintColor = Constants.COLORS.bold_green
        self.title = "Ủng hộ Quỹ FPT vì cộng đồng 2022"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reloadTableView()
    }
    
    @IBAction func onconfirm() {
        if isValidateOK() {
            confirm()
        }
    }
    
    @objc func confirm() {
        let selectedItem = listKhaoSat.filter{$0.isSelected}
        var listKhaoSatConfirm = [ItemKhaoSatResult]()
        if selectedItem.first?.value == "14" {
            
            listKhaoSatConfirm.removeAll()
            listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[1].value)", itemDescription: "true"))
            listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[2].value)", itemDescription: "false"))
            listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[3].value)", itemDescription: "false"))
            
            if listKhaoSat[2].children.count > 0 {
                listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[2].children[0].value)", itemDescription: ""))
            }
            
        } else if selectedItem.first?.value == "15" { //option 2 - nhap so tien
            
            listKhaoSatConfirm.removeAll()
            listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[1].value)", itemDescription: "false"))
            listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[2].value)", itemDescription: "true"))
            listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[3].value)", itemDescription: "false"))
            
            if listKhaoSat[2].children.count > 0 {
                listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[2].children[0].value)", itemDescription: "\(anotherPrice)"))
            }
        } else {
            listKhaoSatConfirm.removeAll()
            listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[1].value)", itemDescription: "false"))
            listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[2].value)", itemDescription: "false"))
            listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[3].value)", itemDescription: "true"))
            
            if listKhaoSat[2].children.count > 0 {
                listKhaoSatConfirm.append(ItemKhaoSatResult(itemValue: "\(listKhaoSat[2].children[0].value)", itemDescription: ""))
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
    
    @objc func actionClose(){
        navigationController?.popViewController(animated: false)
//        self.dismiss(animated: false, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name.init("didCloseSurvey"), object: nil)
    }
    
    func showPopupErr(text: String) {
        let alert = UIAlertController(title: "Thông báo", message: text, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func isValidateOK() -> Bool{
        let selectedItem = listKhaoSat.filter{$0.isSelected}
        if selectedItem.count == 0 {
            showPopupErr(text: "Vui lòng chọn một lựa chọn trên!")
            return false
        }
        
        if selectedItem.first?.value == "15" && (anotherPrice == "0" || anotherPrice == "") {
            showPopupErr(text: "Vui lòng nhập số tiền")
            return false
        } else if Int(anotherPrice) ?? 0 < 100000 && selectedItem.first?.value == "15" {
            showPopupErr(text: "Số tiền tối thiểu là 100.000 đồng")
            return false
        }
        return true
    }
    
    private func reloadTableView() {
        tableView.reloadData()
        tableViewHeight.constant = CGFloat(139 * (listKhaoSat.count))
        
        UIView.animate(withDuration: 0, animations: {
        }) { (complete) in
            var promoHeightOfTableView: CGFloat = 0.0
            // Get visible cells and sum up their heights
            let promoCells = self.tableView.visibleCells
            for cell in promoCells {
                promoHeightOfTableView += cell.frame.height
            }
            
            // Edit heightOfTableViewConstraint's constant to update height of table view
            self.tableViewHeight.constant = promoHeightOfTableView
        }
    }

}

extension UngHoMienTrungVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listKhaoSat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = listKhaoSat[indexPath.row]
        if item.typeControl == "title" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SupportTitleCell", for: indexPath) as! SupportTitleCell
            cell.titleLabel.text = item.descriptionStr
            if item.value == "10007" {
                cell.titleLabel.textColor = .red
            } else if item.value == "17" {
                cell.titleLabel.textColor = .blue
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SupportCell", for: indexPath) as! SupportCell
            cell.bindCell(item: item)
            cell.onUPdateMoney = { [weak self] money in
                self?.anotherPrice = money
            }
            
            cell.onselectedTxt = {
                for (index, _) in self.listKhaoSat.enumerated() {
                    if index != indexPath.row {
                        self.listKhaoSat[index].isSelected = false
                    }
                }
                
                if let acell: SupportCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? SupportCell {
                    acell.checkBoxLabel.image = UIImage(named: "support_uncheck")
                }
//                checkBoxLabel.image = item.isSelected ? UIImage(named: "support_checked") : UIImage(named: "support_uncheck")
                if let acell: SupportCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? SupportCell {
                    acell.checkBoxLabel.image = UIImage(named: "support_uncheck")
                }
                
                if let acell: SupportCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? SupportCell {
                    acell.moneyText.isEnabled = true
                    acell.checkBoxLabel.image = UIImage(named: "support_checked")
                }
                
                self.listKhaoSat[indexPath.row].isSelected = true
                for (index, _) in self.listKhaoSat.enumerated() {
                    if index != indexPath.row {
                        self.listKhaoSat[index].isSelected = false
                    }
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if listKhaoSat[indexPath.row].typeControl != "radiobutton" {return}
        listKhaoSat[indexPath.row].isSelected = true
        if listKhaoSat[indexPath.row].value != "15" {
            anotherPrice = "0"
        }
        for (index, _) in listKhaoSat.enumerated() {
            if index != indexPath.row {
                listKhaoSat[index].isSelected = false
            }
        }
        reloadTableView()
    }
}
