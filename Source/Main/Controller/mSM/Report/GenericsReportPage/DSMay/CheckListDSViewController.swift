//
//  CheckListDSViewController.swift
//  fptshop
//
//  Created by Ngoc Bao on 25/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class CheckListDSViewController: UIViewController {

    
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate:CheckListViewControllerDelegate?
    var lockOrient = "portrait"
    var listDSMayType: [DSMayType] = []
    @objc func canRotate() -> Void{}
    var getreportType: ((String)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.alpha = 0.5
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CheckListCell", bundle: nil), forCellReuseIdentifier: "CheckListCell")
    }
    
    @objc func getValuesChecked() {
        var strChosen = [String]()
        for i in self.listDSMayType {
            if i.isCheck {
                strChosen.append(i.textValue ?? "")
            }
        }
        if strChosen.count > 0 {
            var str = ""
            if strChosen.contains("ALL"){
                str = "ALL"
            } else {
                str = strChosen.joined(separator: ",")
            }
            debugPrint("loai: \(str)")
            self.dismiss(animated: true) {
                if let onContinue = self.getreportType {
                    onContinue(str)
                }
            }
        } else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa chọn loại cho báo cáo!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func continueActioon(_ sender: Any) {
        self.getValuesChecked()
    }
}


extension CheckListDSViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listDSMayType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListCell", for: indexPath) as! CheckListCell
        cell.bindCell(item: listDSMayType[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.listDSMayType[indexPath.row].isCheck = !self.listDSMayType[indexPath.row].isCheck
        let item = self.listDSMayType[indexPath.row]
        if item.textValue?.lowercased() == "all" {
            self.listDSMayType.forEach { yourItem in
                yourItem.isCheck = item.isCheck
            }
        }
        let filter = self.listDSMayType.filter({$0.isCheck && $0.textValue?.lowercased() != "all"})
        if filter.count == self.listDSMayType.count - 1 {
            self.listDSMayType.forEach { yourItem in
                yourItem.isCheck = true
            }
        } else {
            self.listDSMayType[0].isCheck = false
        }
        self.tableView.reloadData()
    }
}
