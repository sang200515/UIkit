//
//  HistoryChamDiemErrorViewController.swift
//  fptshop
//
//  Created by Apple on 6/11/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HistoryChamDiemErrorViewController: UIViewController {
    
    var tableView: UITableView!
    var cellHeight:CGFloat = Common.Size(s: 50)
    
    var listScoreError:[ScoreError] = []
    let searchController = UISearchController(searchResultsController: nil)
    var filterScoreError = [ScoreError]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "LỊCH SỬ LỖI"
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isTranslucent = false
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        //
        self.setUpTableView()
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Nhập mã lỗi..."
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .red
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
                textfield.textColor = UIColor(netHex:0x00579c)
                textfield.tintColor = UIColor(netHex:0x00579c)
                if let backgroundview = textfield.subviews.first {
                    // Background color
                    backgroundview.backgroundColor = UIColor.white
                    // Rounded corner
                    backgroundview.layer.cornerRadius = 5;
                    backgroundview.clipsToBounds = true;
                }
                if let navigationbar = self.navigationController?.navigationBar {
                    navigationbar.barTintColor = UIColor(patternImage: Common.imageLayerForGradientBackground(searchBar: (self.searchController.searchBar)))
                }
            }
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func filterContentForSearchText(_ searchText: String, scrop: String = "All") {
        filterScoreError = listScoreError.filter({( item : ScoreError) -> Bool in
            return "\(item.HeaderID)".contains(searchText)
        })
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
        
        self.listScoreError.removeAll()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.Score_GetListScore(handler: { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if results.count > 0 {
                        for item in results {
                            self.listScoreError.append(item)
                        }
                        if self.tableView != nil {
                            self.tableView.reloadData()
                        }
                        
                    } else {
                        debugPrint("khong lay duoc listScoreError ")
                    }
                }
            })
        }
    }
    
    func setUpTableView(){
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
        self.view.addSubview(tableView)
        tableView.register(HistoryScoreErrorCell.self, forCellReuseIdentifier: "historyScoreErrorCell")
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
}

extension HistoryChamDiemErrorViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filterScoreError.count
        }
        return listScoreError.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HistoryScoreErrorCell = tableView.dequeueReusableCell(withIdentifier: "historyScoreErrorCell", for: indexPath) as! HistoryScoreErrorCell
        
        let itemScore:ScoreError
        if isFiltering() {
            itemScore = filterScoreError[indexPath.row]
        } else {
            itemScore = listScoreError[indexPath.row]
        }
        cell.setUpCell(item:itemScore)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Common.Size(s: 170)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemScore = listScoreError[indexPath.row]
        let newViewController = DetailHistoryChamDiemErrorViewController()
        newViewController.scoreErrorItem = itemScore
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let itemScoreDetail = listScoreError[indexPath.row]
        if itemScoreDetail.StatusCode == 1 {
            if editingStyle == .delete {
                listScoreError.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    }
}


class HistoryScoreErrorCell: UITableViewCell {
    var lbTitle: UILabel!
    var lbDate: UILabel!
    var lbShopText: UILabel!
    var lbNVKiemTraText: UILabel!
    var lbTinhTrangText: UILabel!
    var lbTrangThaiText: UILabel!
    
    var estimateCellHeight: CGFloat = 0
    
    func setUpCell(item:ScoreError){
        self.subviews.forEach({$0.removeFromSuperview()})
        //Header
        lbTitle = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: self.frame.width/2 - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbTitle.text = "Mã kiểm tra: \(item.HeaderID)"
        lbTitle.textColor = UIColor(red: 36/255, green: 143/255, blue: 52/255, alpha: 1)
        lbTitle.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbTitle)
        
        let lbTitleHeight = lbTitle.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbTitle.optimalHeight
        lbTitle.numberOfLines = 0
        
        lbTitle.frame = CGRect(x: lbTitle.frame.origin.x, y: lbTitle.frame.origin.y, width: lbTitle.frame.width, height: lbTitleHeight)
        //date
        lbDate = UILabel(frame: CGRect(x: lbTitle.frame.width + Common.Size(s: 15), y: lbTitle.frame.origin.y, width: self.frame.width/2 - Common.Size(s: 15), height: lbTitle.frame.height))
        lbDate.text = "\(item.CreateDate)"
        lbDate.textColor = UIColor.black
        lbDate.font = UIFont.systemFont(ofSize: 13)
        lbDate.textAlignment = .right
        self.addSubview(lbDate)
        
        let line = UIView(frame: CGRect(x: Common.Size(s: 15), y: lbTitle.frame.origin.y + lbTitleHeight + Common.Size(s: 3), width: self.frame.width - Common.Size(s: 30), height: 1))
        line.backgroundColor = UIColor.black
        self.addSubview(line)
        
        let lbShop = UILabel(frame: CGRect(x: Common.Size(s: 15), y: line.frame.origin.y + line.frame.height + Common.Size(s: 10), width: self.frame.width/3 - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbShop.text = "Shop:"
        lbShop.textColor = UIColor.lightGray
        lbShop.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lbShop)
        
        lbShopText = UILabel(frame: CGRect(x: lbShop.frame.origin.x + lbShop.frame.width + Common.Size(s: 3), y: lbShop.frame.origin.y , width: self.frame.width - Common.Size(s: 30) - lbShop.frame.width, height: Common.Size(s: 20)))
        lbShopText.text = "\(item.ShopName)"
        lbShopText.textColor = UIColor.black
        lbShopText.font = UIFont.boldSystemFont(ofSize: 13)
        self.addSubview(lbShopText)
        
        let lbShopTextHeight = lbShopText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbShopText.optimalHeight
        lbShopText.numberOfLines = 0
        lbShopText.frame = CGRect(x: lbShopText.frame.origin.x, y: lbShopText.frame.origin.y, width: lbShopText.frame.width, height: lbShopTextHeight)
        
        let lbNVKiemTra = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbShopText.frame.origin.y + lbShopTextHeight + Common.Size(s: 3), width: lbShop.frame.width, height: Common.Size(s: 20)))
        lbNVKiemTra.text = "NV kiểm tra:"
        lbNVKiemTra.textColor = UIColor.lightGray
        lbNVKiemTra.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lbNVKiemTra)
        
        lbNVKiemTraText = UILabel(frame: CGRect(x: lbNVKiemTra.frame.origin.x + lbNVKiemTra.frame.width + Common.Size(s: 3), y: lbNVKiemTra.frame.origin.y , width: lbShopText.frame.width, height: Common.Size(s: 20)))
        lbNVKiemTraText.text = "\(item.CreateBy)"
        lbNVKiemTraText.textColor = UIColor.black
        lbNVKiemTraText.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lbNVKiemTraText)
        
        let lbNVKiemTraTextHeight = lbNVKiemTraText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbNVKiemTraText.optimalHeight
        lbNVKiemTraText.numberOfLines = 0
        lbNVKiemTraText.frame = CGRect(x: lbNVKiemTraText.frame.origin.x, y: lbNVKiemTraText.frame.origin.y, width: lbNVKiemTraText.frame.width, height: lbNVKiemTraTextHeight)
        
        let lbTinhTrang = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNVKiemTraText.frame.origin.y + lbNVKiemTraTextHeight + Common.Size(s: 3), width: lbShop.frame.width, height: Common.Size(s: 20)))
        lbTinhTrang.text = "Tình trạng:"
        lbTinhTrang.textColor = UIColor.lightGray
        lbTinhTrang.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lbTinhTrang)
        
        lbTinhTrangText = UILabel(frame: CGRect(x: lbTinhTrang.frame.origin.x + lbTinhTrang.frame.width + Common.Size(s: 3), y: lbTinhTrang.frame.origin.y , width: lbShopText.frame.width, height: Common.Size(s: 20)))
        lbTinhTrangText.text = "\(item.Point)"
        lbTinhTrangText.textColor = UIColor.black
        lbTinhTrangText.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lbTinhTrangText)
        
        let lbTrangThai = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTinhTrangText.frame.origin.y + lbTinhTrangText.frame.height + Common.Size(s: 3), width: lbShop.frame.width, height: Common.Size(s: 20)))
        lbTrangThai.text = "Trạng Thái:"
        lbTrangThai.textColor = UIColor.lightGray
        lbTrangThai.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lbTrangThai)
        
        lbTrangThaiText = UILabel(frame: CGRect(x: lbTrangThai.frame.origin.x + lbTrangThai.frame.width + Common.Size(s: 3), y: lbTrangThai.frame.origin.y , width: lbShopText.frame.width, height: Common.Size(s: 20)))
        lbTrangThaiText.text = "\(item.Status)"
        lbTrangThaiText.font = UIFont.boldSystemFont(ofSize: 13)
        self.addSubview(lbTrangThaiText)
        
        if item.StatusCode == 1 {//dang thuc hien
            lbTrangThaiText.textColor = UIColor(red: 24/255, green: 118/255, blue: 209/255, alpha: 1)
        } else if item.StatusCode == 2 {//dang xu ly
            lbTrangThaiText.textColor = UIColor(red: 190/255, green: 0/255, blue: 0/255, alpha: 1)
        } else {//hoan thanh
            lbTrangThaiText.textColor = UIColor(red: 36/255, green: 143/255, blue: 52/255, alpha: 1)
        }
        
        //        estimateCellHeight = lbTrangThaiText.frame.origin.y + lbTrangThaiText.frame.height + Common.Size(s: 15)
    }
}


extension HistoryChamDiemErrorViewController: UISearchResultsUpdating, UISearchBarDelegate {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        filterContentForSearchText(searchController.searchBar.text ?? "", scrop: "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.navigationController?.navigationBar.isTranslucent = true
        return true
    }
}

