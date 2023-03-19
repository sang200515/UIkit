//
//  ShinhanInstallmentList.swift
//  fptshop
//
//  Created by Ngoc Bao on 17/02/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ShinhanInstallmentList: UIViewController {

    var listData: [ShinhanTragopData] = []
    var didselect: ((ShinhanTragopData)-> Void)?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }


}

extension ShinhanInstallmentList: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = listData[indexPath.row].schemeName
        cell.detailTextLabel?.text = listData[indexPath.row].schemeDetails
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = listData[indexPath.row]
        if let select = didselect {
            select(item)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
