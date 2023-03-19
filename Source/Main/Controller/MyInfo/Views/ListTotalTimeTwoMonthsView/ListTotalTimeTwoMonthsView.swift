//
//  ListTotalTimeTwoMonthsView.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/23/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol ListTotalTimeTwoMonthsViewDelegate: AnyObject {
    func pushToDetailWorkTime(_ data: String)
}

class ListTotalTimeTwoMonthsView: BaseView {
    
    private var items: [TotalTimeTwoMonthsItem] = []
    weak var listTotalTimeTwoMonthsViewDelegate: ListTotalTimeTwoMonthsViewDelegate?
    
    let tableView: SelfSizedTableView = {
        let tableView = SelfSizedTableView()
        return tableView
    }()
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = Constants.COLORS.main_color_white
        self.addSubview(tableView)
        tableView.myCustomAnchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 8, leadingConstant: 8, trailingConstant: 8, bottomConstant: 8, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTotalTimeTwoMonthsCell.self, forCellReuseIdentifier: ListTotalTimeTwoMonthsCell.identifier)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
    }
    
    func getTotalTimeTwoMonthsData(_ data: [TotalTimeTwoMonthsItem]) {
        self.items = data
        self.tableView.reloadData()
    }
    
}

extension ListTotalTimeTwoMonthsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        listTotalTimeTwoMonthsViewDelegate?.pushToDetailWorkTime(item.thang ?? "")
    }
}

extension ListTotalTimeTwoMonthsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTotalTimeTwoMonthsCell.identifier, for: indexPath) as? ListTotalTimeTwoMonthsCell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        cell.getListTotalTimeData(item.thang ?? "", standardLaborTime: item.gioCongChuan ?? "", totalApprovedTime: item.tongGioCongDuyet ?? "")
        cell.selectionStyle = .none
        return cell
    }
    
}
