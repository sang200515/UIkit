//
//  TabDangXyLyTraCocViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 11/3/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown

private let reuseIdentifier = "DangXuLyTraCocCell"
class TraCocEcomMainViewController: UIViewController {

    // MARK: - Properties

    private let tableView = UITableView()
    private let DropDownButton = UIButton()
    private var cellHeight: CGFloat = 0
    private var searchBarContainer:SearchBarContainerView!
    private var lstCustomerItem = [CustomerTraCoc]()
    private var tabType = "1"
    private let searchBar = UISearchBar()
    let dropDownMenu = DropDown()
    var refreshControl = UIRefreshControl()
    var noDataLabel = UILabel()
    var isPhone = false
    // MARK: - Lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trả cọc Ecom"
        let btLeftIcon = Common.initBackButton()
        btLeftIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
        configureUI()
        fetchCustomersAPI(phone:"",numEcom:"")

    }
    
    @objc func setupDrop() {
        dropDownMenu.anchorView = self.view
        dropDownMenu.bottomOffset = CGPoint(x: 0, y: 10)
        dropDownMenu.dataSource = ["Tìm kiếm theo số điện thoại", "Tìm kiếm theo số SO"]
        dropDownMenu.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dropDownMenu.selectionAction = { [weak self] (index, item) in
            self?.search(shouldShow: true)
            self?.searchBar.becomeFirstResponder()
            if index == 0 {
                self?.isPhone = true
            } else {
                self?.isPhone = false
            }
        }
        dropDownMenu.show()
    }
    
    // MARK: - API
    func fetchCustomersAPI(phone: String, numEcom:String,soSO: String = ""){
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: " ") {
            ProductAPIManager.CustomerTraCocAPI(phone: phone,numEcom:numEcom, typereturnSO: soSO) { [weak self] (results, err) in
                self?.refreshControl.endRefreshing()
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        self?.lstCustomerItem.removeAll()
                        self?.lstCustomerItem = results
                        if results.count > 0 {
                            self?.tableView.backgroundView = nil
                        } else {
                            self?.tableView.backgroundView = self?.noDataLabel
                        }
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func fetchDetailCustomerAPI(item:CustomerTraCoc){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            ProductAPIManager.DetailTraCocAPI(numSO: item.docNum) { [weak self](result, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    guard let self = self else {
                        return
                    }
                    if err.count <= 0 {
                        guard let tracoc = result else {return}
                        if tracoc.headers.count > 0 && tracoc.details.count > 0 {
                            let newViewController = DetailTraCocEcomViewController(tracoc: tracoc,itemTracoc: item)
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }else{
                              self.showPopUp("Không có thông tin header khách hàng và detail sản phẩm !!! ", "Thông báo", buttonTitle: "OK")
                        }
                   
                        
                    } else {
                        self.showPopUp(err, "Thông báo", buttonTitle: "OK")
                        
                    }
                }
            }
        }
    }
    
    // MARK: - Selectors
    @objc func handleBack(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func handleSearchBar(){
        setupDrop()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.fetchCustomersAPI(phone:"",numEcom:"")
        refreshControl.endRefreshing()
    }
    
    
    // MARK: - Helpers
    func configureUI(){
        searchBar.sizeToFit()
        searchBar.delegate = self
        showSearchBarButton(shouldShow: true)
        
        

        
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DangXuLyTraCocCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Tải lại dữ liệu")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        
        noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        noDataLabel.textAlignment = .center
        noDataLabel.text = "Không có đơn hàng!"
        noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
        noDataLabel.textAlignment = NSTextAlignment.center
    }
    
        func showSearchBarButton(shouldShow :Bool){
            if shouldShow {
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchBar))
            }else{
                navigationItem.rightBarButtonItem = nil
            }
        }
        
        func search(shouldShow: Bool){
            showSearchBarButton(shouldShow: !shouldShow)
            searchBar.showsCancelButton = shouldShow
            navigationItem.titleView = shouldShow ? searchBar : nil
            
    //        if shouldShow {
    //            navigationItem.titleView = searchBar
    //        }else{
    //            navigationItem.titleView = nil
    //        }
        }
    


}
    // MARK: - UITableViewDataSource

extension TraCocEcomMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lstCustomerItem.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DangXuLyTraCocCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DangXuLyTraCocCell
        cell.setUpCell(item: lstCustomerItem[indexPath.row])
        cellHeight = cell.estimateHeight
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = lstCustomerItem[indexPath.row]
        if item.docNum != "0" {
             fetchDetailCustomerAPI(item: item)
            let saveValue = item.u_SOType == "47" ? true : false
            UserDefaults.standard.setValue(item.u_ShipTyp, forKey: "BTSShiptype")
            UserDefaults.standard.setValue(saveValue, forKey: "NeedShowBTSButton")
        }else{
            showPopUp("Đơn hàng chưa kéo về POS !!!", "Thông Báo", buttonTitle: "OK")
        }
       
  
        
    }
}

    // MARK: - TraCocEcomMainViewController
extension TraCocEcomMainViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
   
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        fetchCustomersAPI(phone: isPhone ? searchText : "", numEcom: !isPhone ? searchText : "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            print(searchText)
    }
}
    // MARK: - DangXuLyTraCocCell
class DangXuLyTraCocCell: UITableViewCell {
    var estimateHeight:CGFloat = 0
    
    func setUpCell(item:CustomerTraCoc) {
        self.subviews.forEach({$0.removeFromSuperview()})
        
        let contentView = UIView(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 5), width: self.frame.width -  Common.Size(s: 30), height: Common.Size(s: 8)))
        contentView.backgroundColor = UIColor(netHex: 0xFAFAFA)
        self.addSubview(contentView)
        
        let lbEcomNum = UILabel(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: (contentView.frame.width - Common.Size(s: 10))/2, height: Common.Size(s: 20)))
        lbEcomNum.text = "Ecom: \(item.docEntry)"
        lbEcomNum.font = UIFont.boldSystemFont(ofSize: 14)
        lbEcomNum.textColor = UIColor(netHex: 0x04AB6E)
        contentView.addSubview(lbEcomNum)
        
        let lbCreateDate = UILabel(frame: CGRect(x: lbEcomNum.frame.origin.x + lbEcomNum.frame.width, y: Common.Size(s: 5), width: lbEcomNum.frame.width, height: Common.Size(s: 20)))
        lbCreateDate.text = "\(item.u_CrDate)"
        lbCreateDate.font = UIFont.systemFont(ofSize: 13)
        lbCreateDate.textAlignment = .right
        lbCreateDate.textColor = UIColor(netHex: 0xbababa)
        contentView.addSubview(lbCreateDate)
        
        let line1 = UIView(frame: CGRect(x: Common.Size(s: 5), y: lbCreateDate.frame.origin.y + lbCreateDate.frame.height + Common.Size(s: 2), width: self.frame.width - Common.Size(s: 10), height: Common.Size(s: 0.6)))
        line1.backgroundColor = .lightGray
        contentView.addSubview(line1)
        
        let lbPosNum = UILabel(frame: CGRect(x: Common.Size(s: 5), y: line1.frame.origin.y + line1.frame.height + Common.Size(s: 2), width: contentView.frame.width/3 + Common.Size(s: 13), height: Common.Size(s: 20)))
        lbPosNum.text = "Số Pos:"
        lbPosNum.font = UIFont.systemFont(ofSize: 14)
        lbPosNum.textColor = UIColor(netHex: 0xbababa)
        contentView.addSubview(lbPosNum)
        
        let lbPosText = UILabel(frame: CGRect(x: lbPosNum.frame.origin.x + lbPosNum.frame.width, y: lbPosNum.frame.origin.y, width: (contentView.frame.width - Common.Size(s: 10)) - lbPosNum.frame.width, height: Common.Size(s: 20)))
        lbPosText.text = "\(item.docNum)"
        lbPosText.font = UIFont.systemFont(ofSize: 14)
        lbPosText.textAlignment = .right
        contentView.addSubview(lbPosText)
        
        let lbPosTextHeight: CGFloat = lbPosText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbPosText.optimalHeight + Common.Size(s: 5))
        lbPosText.numberOfLines = 0
        lbPosText.frame = CGRect(x: lbPosText.frame.origin.x, y: lbPosText.frame.origin.y, width: lbPosText.frame.width, height: lbPosTextHeight)
        
        let lbCustomerName = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lbPosText.frame.origin.y + lbPosTextHeight, width: lbPosNum.frame.width, height: Common.Size(s: 20)))
        lbCustomerName.text = "Tên KH:"
        lbCustomerName.font = UIFont.systemFont(ofSize: 14)
        lbCustomerName.textColor = UIColor(netHex: 0xbababa)
        contentView.addSubview(lbCustomerName)
        
        let lbCustomerNameText = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x + lbCustomerName.frame.width, y: lbCustomerName.frame.origin.y, width: lbPosText.frame.width, height: Common.Size(s: 20)))
        lbCustomerNameText.text = "\(item.u_UCode)"
        lbCustomerNameText.font = UIFont.systemFont(ofSize: 14)
        lbCustomerNameText.textAlignment = .right
        contentView.addSubview(lbCustomerNameText)
        
        let lbCustomerNameTextHeight: CGFloat = lbCustomerNameText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbCustomerNameText.optimalHeight + Common.Size(s: 5))
        lbCustomerNameText.numberOfLines = 0
        lbCustomerNameText.frame = CGRect(x: lbCustomerNameText.frame.origin.x, y: lbCustomerNameText.frame.origin.y, width: lbCustomerNameText.frame.width, height: lbCustomerNameTextHeight)
        
        let lbSdtKH = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lbCustomerNameText.frame.origin.y + lbCustomerNameTextHeight, width: lbPosNum.frame.width, height: Common.Size(s: 20)))
        lbSdtKH.text = "SĐT:"
        lbSdtKH.font = UIFont.systemFont(ofSize: 14)
        lbSdtKH.textColor = UIColor(netHex: 0xbababa)
        contentView.addSubview(lbSdtKH)
        
        let lbSdtKHText = UILabel(frame: CGRect(x: lbSdtKH.frame.origin.x + lbSdtKH.frame.width, y: lbSdtKH.frame.origin.y, width: lbPosText.frame.width, height: Common.Size(s: 20)))
        lbSdtKHText.text = "\(item.u_Phone)"
        lbSdtKHText.font = UIFont.systemFont(ofSize: 14)
        lbSdtKHText.textAlignment = .right
        contentView.addSubview(lbSdtKHText)
        
        let lbTrangThai = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lbSdtKHText.frame.origin.y + lbSdtKHText.frame.height, width: lbPosNum.frame.width, height: Common.Size(s: 20)))
        lbTrangThai.text = "Trạng thái:"
        lbTrangThai.font = UIFont.systemFont(ofSize: 14)
        lbTrangThai.textColor = UIColor(netHex: 0xbababa)
        contentView.addSubview(lbTrangThai)
        
        let lbTrangThaiText = UILabel(frame: CGRect(x: lbTrangThai.frame.origin.x + lbTrangThai.frame.width, y: lbTrangThai.frame.origin.y, width: lbPosText.frame.width, height: Common.Size(s: 20)))
        lbTrangThaiText.text = "Đang xử lý"
        lbTrangThaiText.font = UIFont.systemFont(ofSize: 14)
        lbTrangThaiText.textAlignment = .right
        lbTrangThaiText.textColor = UIColor(netHex: 0x04AB6E)
        contentView.addSubview(lbTrangThaiText)
        
        let lblLoaiDonHang = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lbTrangThaiText.frame.origin.y + lbTrangThaiText.frame.height, width: lbPosNum.frame.width, height: Common.Size(s: 20)))
        lblLoaiDonHang.text = "Loại đơn hàng:"
        lblLoaiDonHang.font = UIFont.systemFont(ofSize: 14)
        lblLoaiDonHang.textColor = UIColor(netHex: 0xbababa)
        contentView.addSubview(lblLoaiDonHang)
        
        let lblLoaiDonHangtext = UILabel(frame: CGRect(x: lblLoaiDonHang.frame.origin.x + lblLoaiDonHang.frame.width, y: lblLoaiDonHang.frame.origin.y, width: lbPosText.frame.width, height: Common.Size(s: 20)))
        lblLoaiDonHangtext.text = item.u_SOType == "47" ? "Đơn hàng BTS" : "Đơn hàng thường"
        lblLoaiDonHangtext.font = UIFont.systemFont(ofSize: 14)
        lblLoaiDonHangtext.textAlignment = .right
        lblLoaiDonHangtext.textColor = UIColor(netHex: 0x04AB6E)
        contentView.addSubview(lblLoaiDonHangtext)
        
        let lbTongTienDH = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lblLoaiDonHang.frame.origin.y + lblLoaiDonHang.frame.height, width: lbPosNum.frame.width, height: Common.Size(s: 20)))
        lbTongTienDH.text = "Tổng đơn hàng:"
        lbTongTienDH.font = UIFont.systemFont(ofSize: 14)
        lbTongTienDH.textColor = UIColor(netHex: 0xbababa)
        contentView.addSubview(lbTongTienDH)
        
        let lbTongTienText = UILabel(frame: CGRect(x: lbTongTienDH.frame.origin.x + lbTongTienDH.frame.width, y: lbTongTienDH.frame.origin.y, width: lbPosText.frame.width, height: Common.Size(s: 20)))
        lbTongTienText.text = "\(Common.convertCurrencyFloatV2(value: Float(item.u_TMonBi) ?? 0))đ"
        lbTongTienText.font = UIFont.systemFont(ofSize: 14)
        lbTongTienText.textAlignment = .right
        lbTongTienText.textColor = UIColor(netHex: 0xE30613)
        contentView.addSubview(lbTongTienText)
        
        let lbThanhToanOnline = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lbTongTienText.frame.origin.y + lbTongTienText.frame.height, width: lbPosNum.frame.width, height: Common.Size(s: 20)))
        lbThanhToanOnline.text = "Thanh toán online:"
        lbThanhToanOnline.font = UIFont.systemFont(ofSize: 14)
        lbThanhToanOnline.textColor = UIColor(netHex: 0xbababa)
        contentView.addSubview(lbThanhToanOnline)
        
        let lbThanhToanOnlineText = UILabel(frame: CGRect(x: lbThanhToanOnline.frame.origin.x + lbThanhToanOnline.frame.width, y: lbThanhToanOnline.frame.origin.y, width: lbPosText.frame.width, height: Common.Size(s: 20)))
        lbThanhToanOnlineText.text = "\(Common.convertCurrencyFloatV2(value: Float(item.u_PayOnline) ?? 0))đ"
        lbThanhToanOnlineText.font = UIFont.systemFont(ofSize: 14)
        lbThanhToanOnlineText.textAlignment = .right
        lbThanhToanOnlineText.textColor = UIColor(netHex: 0xE30613)
        contentView.addSubview(lbThanhToanOnlineText)
        
        let lbTongThanhToan = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lbThanhToanOnlineText.frame.origin.y + lbThanhToanOnlineText.frame.height, width: lbPosNum.frame.width, height: Common.Size(s: 20)))
        lbTongThanhToan.text = "Tổng thanh toán:"
        lbTongThanhToan.font = UIFont.systemFont(ofSize: 14)
        lbTongThanhToan.textColor = UIColor(netHex: 0xbababa)
        contentView.addSubview(lbTongThanhToan)
        
        let lbTongThanhToanText = UILabel(frame: CGRect(x: lbTongThanhToan.frame.origin.x + lbTongThanhToan.frame.width, y: lbTongThanhToan.frame.origin.y, width: lbPosText.frame.width, height: Common.Size(s: 20)))
        lbTongThanhToanText.text = "\(Common.convertCurrencyFloatV2(value: Float(item.u_Mustpay) ?? 0))đ"
        lbTongThanhToanText.font = UIFont.systemFont(ofSize: 14)
        lbTongThanhToanText.textAlignment = .right
        lbTongThanhToanText.textColor = UIColor(netHex: 0xE30613)
        contentView.addSubview(lbTongThanhToanText)
        
        contentView.frame = CGRect(x: contentView.frame.origin.x, y: contentView.frame.origin.y, width: contentView.frame.width, height: lbTongThanhToanText.frame.origin .y + lbTongThanhToanText.frame.height + Common.Size(s: 5))
        
        estimateHeight = contentView.frame.origin.y + contentView.frame.height + Common.Size(s: 10)
    }
}
