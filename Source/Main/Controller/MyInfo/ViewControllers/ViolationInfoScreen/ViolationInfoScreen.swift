//
//  ViolationInfoScreen.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/28/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ViolationInfoScreen: BaseController {
    
    private var violationItems: [ViolationItem] = []
    private var violationItemFiltered: [ViolationItem] = []
    let searchViolation = UISearchBar()
    private var isSearched: Bool = false
    let vMainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let tableView: SelfSizedTableView = {
        let tableView = SelfSizedTableView()
        return tableView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ViolationInfoScreen.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = Constants.COLORS.light_green
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListViolationCell.self, forCellReuseIdentifier: ListViolationCell.identifier)
        tableView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    
    override func setupViews() {
        super.setupViews()
        self.title = "Phạt"
        self.navigationController?.navigationBar.barTintColor = Constants.COLORS.bold_green
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        self.view.addSubview(vMainContainer)
        vMainContainer.fill()
        
        vMainContainer.addSubview(tableView)
        tableView.fill()
        tableView.addSubview(refreshControl)
    }
    
    override func getData() {
        super.getData()
        getDataViolation()
    }
    
    @objc private func handleExpand(button: UIButton) {
        let section = button.tag
        
        // we'll try to close the section first by deleting the rows
        var indexPaths = [IndexPath]()
        if !isSearched {
            for row in violationItems[section].items!.indices {
                let indexPath = IndexPath(row: row, section: section)
                indexPaths.append(indexPath)
            }
        } else {
            for row in violationItemFiltered[section].items!.indices {
                let indexPath = IndexPath(row: row, section: section)
                indexPaths.append(indexPath)
            }
        }
        
        if !isSearched {
            let isExpanded = violationItems[section].isExpanded
            violationItems[section].isExpanded = !isExpanded
            
            if isExpanded {
                tableView.beginUpdates()
                tableView.deleteRows(at: indexPaths, with: .fade)
                tableView.reloadSections(IndexSet(integer: section), with: .fade)
                tableView.endUpdates()
            } else {
                tableView.beginUpdates()
                tableView.insertRows(at: indexPaths, with: .fade)
                tableView.reloadSections(IndexSet(integer: section), with: .fade)
                tableView.endUpdates()
            }
        } else {
            let isExpanded = violationItemFiltered[section].isExpanded
            violationItemFiltered[section].isExpanded = !isExpanded
            
            if isExpanded {
                tableView.beginUpdates()
                tableView.deleteRows(at: indexPaths, with: .fade)
                tableView.reloadSections(IndexSet(integer: section), with: .fade)
                tableView.endUpdates()
            } else {
                tableView.beginUpdates()
                tableView.insertRows(at: indexPaths, with: .fade)
                tableView.reloadSections(IndexSet(integer: section), with: .fade)
                tableView.endUpdates()
            }
        }
        
        
    }
    
    @objc fileprivate func showSearchBar() {
        let textfieldInsideSearchBar = searchViolation.value(forKey: "searchField") as? UITextField
        textfieldInsideSearchBar?.textColor = .black
        searchViolation.showsCancelButton = true
        searchViolation.tintColor = Constants.COLORS.light_green
        searchViolation.placeholder = "Kiếm mã phiếu/Ghi nhận/Trạng thái"
        searchViolation.delegate = self
        searchViolation.isHidden = false
        searchViolation.alpha = 0
        navigationItem.titleView = searchViolation
        
        UIView.animate(withDuration: 0.5, animations: {
            self.searchViolation.alpha = 1
        }, completion: { finished in
            self.searchViolation.becomeFirstResponder()
        })
    }
    
    private func hideSearchBar() {
        searchViolation.alpha = 0
        self.navigationItem.titleView = nil
        self.navigationItem.title = "Phạt"
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        getDataViolation()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    fileprivate func getDataViolation() {
        if let userCode = UserDefaults.standard.getUsernameEmployee() {
            self.showLoading()
            MyInfoAPIManager.shared.getViolationItem(userCode) {[weak self] (result, err) in
                guard let strongSelf = self else {return}
                if let items = result {
                    if !items.isEmpty {
                        strongSelf.violationItems = items
                        strongSelf.tableView.reloadData()
                        strongSelf.stopLoading()
                    } else {
                        strongSelf.showPopUp("Tài khoản này chưa có dữ liệu, vui lòng thử lại sau", "Thông báo phiếu phạt", buttonTitle: "Đồng ý") {
                            strongSelf.navigationController?.popViewController(animated: true)
                        }
                    }
                } else {
                    strongSelf.showPopUp(err ?? "", "Thông báo phiếu phạt", buttonTitle: "Ok") {
                        strongSelf.navigationController?.popViewController(animated: true)
                    }
                    strongSelf.stopLoading()
                }
            }
        }
    }
}

extension ViolationInfoScreen: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearched = true
        let searchNumber =  NumberFormatter().number(from: searchText)?.intValue
        
        let contentBlocks = violationItems.compactMap{$0.items}.flatMap{$0}.filter{$0.trangThai?.range(of: searchText, options: .caseInsensitive) != nil || $0.ghiNhan?.range(of: searchText, options: .caseInsensitive) != nil || $0.soPhieu == searchNumber}
        
        if searchText.isEmpty {
            violationItemFiltered = violationItems
        } else {
            var itemsViolationSearching = violationItems
            for i in 0..<itemsViolationSearching.count {
                for indexItemsDetail in 0..<itemsViolationSearching[i].items!.count {
                    for indexFilterdItems in 0..<contentBlocks.count {
                        if itemsViolationSearching[i].group == 1 {
                            if itemsViolationSearching[i].items?[indexItemsDetail].soPhieu == contentBlocks[indexFilterdItems].soPhieu || itemsViolationSearching[i].items?[indexItemsDetail].ghiNhan == contentBlocks[indexFilterdItems].ghiNhan || itemsViolationSearching[i].items?[indexItemsDetail].trangThai == contentBlocks[indexFilterdItems].trangThai {
                                itemsViolationSearching[i].items?.removeAll()
                                itemsViolationSearching[i].items = contentBlocks
                                violationItemFiltered.removeAll()
                                violationItemFiltered = itemsViolationSearching
                                violationItemFiltered[i].isExpanded = true
                            }
                        } else if itemsViolationSearching[i].group == 2 {
                            if itemsViolationSearching[i].items?[indexItemsDetail].soPhieu == contentBlocks[indexFilterdItems].soPhieu || itemsViolationSearching[i].items?[indexItemsDetail].ghiNhan == contentBlocks[indexFilterdItems].ghiNhan || itemsViolationSearching[i].items?[indexItemsDetail].trangThai == contentBlocks[indexFilterdItems].trangThai {
                                itemsViolationSearching[i].items?.removeAll()
                                itemsViolationSearching[i].items = contentBlocks
                                violationItemFiltered.removeAll()
                                violationItemFiltered = itemsViolationSearching
                                violationItemFiltered[i].isExpanded = true
                            }
                        }
                    }
                }
            }
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearched = false
        hideSearchBar()
        tableView.reloadData()
    }
}

extension ViolationInfoScreen: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isSearched {
            return violationItems.count
            
        } else {
            return violationItemFiltered.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var item: ViolationItem?
        if !isSearched {
            item = violationItems[section]
        } else {
            item = violationItemFiltered[section]
        }
        
        let vMainContainer: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
        
        let vImage: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "ic_unchecked_circle")
            return imageView
        }()
        
        let lbTitleSection: UILabel = {
            let label = UILabel()
            label.textColor = Constants.COLORS.bold_green
            label.font = UIFont.mediumCustomFont(ofSize: 14)
            label.textAlignment = .left
            return label
        }()
        
        let lbSumValueUnitViolation: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.textColor = Constants.COLORS.main_red_my_info
            label.font = UIFont.mediumCustomFont(ofSize: 13)
            return label
        }()
        
        let btnExpandable = UIButton(type: .system)
        btnExpandable.backgroundColor = .clear
        btnExpandable.addTarget(self, action: #selector(handleExpand(button:)), for: .touchUpInside)
        
        vMainContainer.addSubview(vImage)
        vImage.myCustomAnchor(top: nil, leading: vMainContainer.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: vMainContainer.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 8, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 30, heightConstant: 30)
        
        vMainContainer.addSubview(lbTitleSection)
        lbTitleSection.myCustomAnchor(top: nil, leading: vImage.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: vMainContainer.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 8, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vMainContainer.addSubview(lbSumValueUnitViolation)
        lbSumValueUnitViolation.myCustomAnchor(top: nil, leading: lbTitleSection.trailingAnchor, trailing: vMainContainer.trailingAnchor, bottom: nil, centerX: nil, centerY: vMainContainer.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 100, trailingConstant: 8, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        lbTitleSection.text = item?.groupName
        lbSumValueUnitViolation.text = item?.soTienPhat
        vImage.image = item!.isExpanded ? UIImage(named: "ic_checked_circle") : UIImage(named: "ic_uncheck_circle")
        
        vMainContainer.addSubview(btnExpandable)
        btnExpandable.fill()
        btnExpandable.tag = section
        
        return vMainContainer
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isSearched {
            if !violationItems[section].isExpanded {
                return 0
            } else {
                return violationItems[section].items!.count

            }
        } else {
            if !violationItemFiltered[section].isExpanded {
                return 0
            } else {
                return violationItemFiltered[section].items!.count

            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListViolationCell.identifier, for: indexPath) as? ListViolationCell else { return UITableViewCell()}
        if !isSearched {
            if let item = violationItems[indexPath.section].items?[indexPath.row] {
                cell.getDataViolationItem(item)
            }
        } else {
            if let item = violationItemFiltered[indexPath.section].items?[indexPath.row] {
                cell.getDataViolationItem(item)
            }
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
}

extension ViolationInfoScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isSearched {
            if let item = violationItems[indexPath.section].items?[indexPath.row] {
                let detailViolationScreen = TestListDetailViolationScreen()
                detailViolationScreen.getNumberViolation(item.soPhieu)
                self.navigationController?.pushViewController(detailViolationScreen, animated: true)
            }
        } else {
            if let item = violationItemFiltered[indexPath.section].items?[indexPath.row] {
                let detailViolationScreen = TestListDetailViolationScreen()
                detailViolationScreen.getNumberViolation(item.soPhieu)
                self.navigationController?.pushViewController(detailViolationScreen, animated: true)
            }
        }
    }
}
