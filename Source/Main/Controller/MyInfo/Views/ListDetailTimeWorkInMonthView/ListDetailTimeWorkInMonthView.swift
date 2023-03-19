//
//  ListDetailTimeWorkInMonthView.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/28/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ListDetailTimeWorkInMonthView: BaseView {
    
    private var itemsApprovedTime: [GioCongDuyet] = []
    private var itemsAfterPicked: [GioCongDuyet] = []
    private var isPicked: Bool = false
    
    let tableView: SelfSizedTableView = {
        let tableView = SelfSizedTableView()
        return tableView
    }()
    
    override func setupViews() {
        super.setupViews()
        isPicked = false
        self.backgroundColor = .clear
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ListDetailTimeWorkInMonthCell.self, forCellReuseIdentifier: ListDetailTimeWorkInMonthCell.identifier)
        self.addSubview(tableView)
        tableView.fill()
    }
    
    func getApprovedTime(_ items: [GioCongDuyet]) {
        self.itemsApprovedTime = items
        tableView.reloadData()
    }
    
    func getDatesPicked(_ dates: [String]) {
        isPicked = true
        itemsAfterPicked.removeAll()
        let item = itemsApprovedTime.filter { items in
            return dates.contains { date in
                date.self == items.ngay
            }
        }
        itemsAfterPicked = item
        //        itemsApprovedTime.removeAll()
        tableView.reloadData()
    }
}

extension ListDetailTimeWorkInMonthView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isPicked {
            return itemsApprovedTime.count
        }
        return itemsAfterPicked.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListDetailTimeWorkInMonthCell.identifier, for: indexPath) as? ListDetailTimeWorkInMonthCell else {return UITableViewCell()}
        if isPicked {
            let item = itemsAfterPicked[indexPath.row]
            cell.getDataDetailTimeWorkInMonth(item)
            
        } else {
            let item = itemsApprovedTime[indexPath.row]
            cell.getDataDetailTimeWorkInMonth(item)
        }
        cell.selectionStyle = .none
        return cell
    }
}
