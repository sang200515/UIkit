//
//  DetailsLinhKienRaPC.swift
//  fptshop
//
//  Created by Sang Truong on 12/4/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DetailsLinhKienRaPC: UIViewController {
    var ListLKImei :[DetailsLinhKienByImei] = []
    var imei:String = ""
    var itemCode:String = ""
    var isCheckNilDataRespone = false
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    func bindUI(){
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "CHI TIẾT PHIẾU RÃ"
        tableView.register(UINib(nibName: "DetailsLinhKienCell", bundle: nil), forCellReuseIdentifier: "DetailsLinhKienCell")
        tableView.register(UINib(nibName: "DetailsLinhKienHeaders", bundle: nil), forCellReuseIdentifier: "DetailsLinhKienHeaders")
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            var height: CGFloat = 0
            for cell in self.tableView.cells {
                height += cell.frame.size.height
            }
            self.tableViewHeight.constant = height
        })
        print("reloading")
        CATransaction.commit()
        Provider.shared.raPCAPService.getDetailsImei(item_code_pc: itemCode, imei: imei , success: {[weak self] result in
            ProgressView.shared.hide()
            guard let self = self else {return}
            self.ListLKImei = result?.data ?? []
            if result?.message?.message_Desc == "Không có dữ liệu"  {
                self.isCheckNilDataRespone  = true
                self.showPopUp(result?.message!.message_Desc ?? "Không có dữ liệu", "Thông báo", buttonTitle: "OK", handleOk: nil)
            }
            self.tableView.reloadData()
            self.tableViewHeight.constant = CGFloat((self.ListLKImei.count * 150) + 65)
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                var height: CGFloat = 0
                for cell in self.tableView.cells {
                    height += cell.frame.size.height
                }
                self.tableViewHeight.constant = height
            })
            print("reloading")
            CATransaction.commit()
        }, failure: { [weak self] error in
            self?.showPopUp(error.localizedDescription, "Thông báo", buttonTitle: "OK", handleOk: nil)
        })
    }

}
extension DetailsLinhKienRaPC:UITableViewDataSource,UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 44
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return ListLKImei.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsLinhKienHeaders", for: indexPath) as! DetailsLinhKienHeaders

            return cell
        }
        else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsLinhKienCell", for: indexPath) as! DetailsLinhKienCell
            if isCheckNilDataRespone {
                cell.isHidden = true
            }else {
                cell.bindCell(item: ListLKImei[indexPath.row])
            }
        return cell
        }
        

    }
}
