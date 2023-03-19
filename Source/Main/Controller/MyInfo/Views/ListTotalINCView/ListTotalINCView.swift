//
//  ListTotalINCView.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/25/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ListTotalINCView: BaseView {
    
    private var totalINCItems: TotalINCItem?
    
    let tableView: SelfSizedTableView = {
        let tableView = SelfSizedTableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func setupViews() {
        super.setupViews()
        self.addSubview(tableView)
        tableView.fill()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTotalINCCell.self, forCellReuseIdentifier: ListTotalINCCell.identifier)
        tableView.tableFooterView = UIView()
    }
    
    @objc private func handleExpandClose(button: UIButton) {
        printLog(function: #function, json: "Trying to expand and close section...")
        var indexPaths = [IndexPath]()
        let section = button.tag
        guard let items = totalINCItems?.children else {return}
        for row in items[section].children!.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = items[section].isExpanded
        totalINCItems?.children?[section].isExpanded = !isExpanded
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
            tableView.reloadSections(IndexSet(integer: section), with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
            tableView.reloadSections(IndexSet(integer: section), with: .fade)
        }
    }
    
    func getToTalINCItem(_ data: TotalINCItem) {
        self.totalINCItems = data
        self.tableView.reloadData()
    }
}

extension ListTotalINCView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return totalINCItems?.children?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let itemHeaderSection = totalINCItems?.children?[section]
        let lbTitleSection: UILabel = {
            let label = UILabel()
            label.text = ""
            label.textColor = Constants.COLORS.bold_green
            label.font = UIFont.mediumCustomFont(ofSize: Constants.TextSizes.size_14)
            return label
        }()
        
        let lbValueHeaderSection: UILabel =  {
            let label = UILabel()
            label.text = ""
            label.textColor = Constants.COLORS.main_orange_my_info
            label.font = UIFont.mediumCustomFont(ofSize: Constants.TextSizes.size_14)
            return label
        }()
        
        let vImage: UIImageView = {
           let imageView = UIImageView()
            imageView.image = UIImage.init(named: "ic_next_right")
            return imageView
        }()
        
        let btnExpandable = UIButton(type: .system)
        btnExpandable.backgroundColor = .clear
        btnExpandable.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        btnExpandable.tag = section
        
        let view = UIView()
        view.backgroundColor = .clear
        view.setBorder(color: .gray, borderWidth: 0.5, corner: 0)
        
        lbTitleSection.text = itemHeaderSection?.title
        lbValueHeaderSection.text = itemHeaderSection?.value
        if let isExpanded = itemHeaderSection?.isExpanded {
            vImage.rotate(degrees: isExpanded ? 90 : 0)
        }
        
        view.addSubview(vImage)
        vImage.myCustomAnchor(top: nil, leading: view.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: view.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 6, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 15, heightConstant: 15)
        
        if (itemHeaderSection?.children!.isEmpty)! {
            vImage.isHidden = true
        } else {
            vImage.isHidden = false
        }
        
        view.addSubview(lbTitleSection)
        lbTitleSection.myCustomAnchor(top: nil, leading: vImage.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: view.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 4, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(lbValueHeaderSection)
        lbValueHeaderSection.myCustomAnchor(top: nil, leading: lbTitleSection.trailingAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: lbTitleSection.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 20, trailingConstant: 6, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(btnExpandable)
        btnExpandable.fill()
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = totalINCItems?.children {
            if !items[section].isExpanded {
                return 0
            } else {
                return items[section].children?.count ?? 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTotalINCCell.identifier, for: indexPath) as? ListTotalINCCell else {
            return UITableViewCell()
        }
        if let child = totalINCItems?.children?[indexPath.section].children?[indexPath.row] {
            cell.getDetailINCItem(child)
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension ListTotalINCView: UITableViewDelegate {
    
}
