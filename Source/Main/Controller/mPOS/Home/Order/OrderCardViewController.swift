//
//  OrderCardViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/24/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class OrderCardViewController: UIViewController{
    
    var tableView: UITableView  =  UITableView()
    var items: [GetCRMPaymentHistoryTheNapResult] = []
    var cellHeight:CGFloat = Common.Size(s: 70)
    var type = 1 // 1:thẻ cào, 2: topup
    var arrFilter: [GetCRMPaymentHistoryTheNapResult] = []
    var parentTabBarController: UITabBarController?
    var btnBack: UIBarButtonItem!
    var btnSearch: UIBarButtonItem!
    var searchBarContainer:SearchBarContainerView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00955E)
        self.loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.type == 1 {
            self.title = "Thẻ cào"
        } else {
            self.title = "Topup"
        }
        
        self.view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.frame = CGRect(x: 0, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btnBack = UIBarButtonItem(customView: btBackIcon)
        self.navigationItem.leftBarButtonItems = [btnBack]
        
        let btSearchIcon = UIButton.init(type: .custom)
        btSearchIcon.setImage(#imageLiteral(resourceName: "Search"), for: UIControl.State.normal)
        btSearchIcon.imageView?.contentMode = .scaleAspectFit
        btSearchIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        btSearchIcon.addTarget(self, action: #selector(actionSearchAssets), for: UIControl.Event.touchUpInside)
        btnSearch = UIBarButtonItem(customView: btSearchIcon)
        self.navigationItem.rightBarButtonItems = [btnSearch]
        
        //search bar custom
        let searchBar = UISearchBar()
        searchBarContainer = SearchBarContainerView(customSearchBar: searchBar)
        searchBarContainer.searchBar.showsCancelButton = true
        searchBarContainer.searchBar.addDoneButtonOnKeyboard()
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        if #available(iOS 13.0, *) {
            searchBarContainer.searchBar.searchTextField.backgroundColor = .white
        } else {
            // Fallback on earlier versions
        }
        searchBarContainer.searchBar.delegate = self
        
        if #available(iOS 11.0, *) {
            searchBarContainer.searchBar.placeholder = "Tìm theo tên khách hàng"
        }else{
            searchBarContainer.searchBar.searchBarStyle = .minimal
            let textFieldInsideSearchBar = searchBarContainer.searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = .white
            
            let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            glassIconView?.tintColor = .white
            textFieldInsideSearchBar?.attributedPlaceholder = NSAttributedString(string: "Tìm theo tên khách hàng",
                                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            let clearButton = textFieldInsideSearchBar?.value(forKey: "clearButton") as? UIButton
            clearButton?.setImage(clearButton?.imageView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
            clearButton?.tintColor = .white
        }
        
        let tableViewHeight:CGFloat = self.view.frame.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.height ?? 0) - (self.parentTabBarController?.tabBar.frame.size.height ?? 0)
        
        tableView.frame = CGRect(x: 0, y:0, width: self.view.frame.size.width, height: tableViewHeight - Common.Size(s: 40))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemSOCardTableViewCell.self, forCellReuseIdentifier: "itemSOCardTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        self.view.addSubview(tableView)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
    }
    
    func loadData() {
        self.items.removeAll()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.GetCRMPaymentHistory(usercode: "\(Cache.user!.UserName)", shopcode: "\(Cache.user!.ShopCode)", transType: "1") { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if(err.count <= 0){
                        if self.type == 1 { // tab thẻ cào
                            for item in results {
                                if(item.Type_LoaiDichVu == 1){
                                    self.items.append(item)
                                }
                            }
                        } else { //topup
                            for item in results {
                                if(item.Type_LoaiDichVu == 2){
                                    self.items.append(item)
                                }
                            }
                        }
                        self.arrFilter = self.items
                        if(self.items.count <= 0){
                            TableViewHelper.EmptyMessage(message: "Không có danh sách lịch sử.\n:/", viewController: self.tableView)
                        }else{
                            TableViewHelper.removeEmptyMessage(viewController: self.tableView)
                        }
                        self.tableView.reloadData()
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @objc func actionBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func actionSearchAssets() {
        self.searchBarContainer.searchBar.text = ""
        navigationItem.titleView = searchBarContainer
        self.searchBarContainer.searchBar.alpha = 0
        navigationItem.setRightBarButtonItems(nil, animated: true)
        navigationItem.setLeftBarButtonItems(nil, animated: true)
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBarContainer.searchBar.alpha = 1
        }, completion: { finished in
            self.searchBarContainer.searchBar.becomeFirstResponder()
        })
    }
    
    @objc func hideKeyBoard() {
        self.searchBarContainer.searchBar.resignFirstResponder()
    }
}

extension OrderCardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ItemSOCardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "itemSOCardTableViewCell", for: indexPath) as! ItemSOCardTableViewCell
        let key = searchBarContainer.searchBar.text ?? ""
        if !(key.isEmpty) {
            let item = arrFilter[indexPath.row]
            cell.setup(so: item)
            cell.item = item
        }else{
            if items.count > indexPath.row {
                let item = items[indexPath.row]
                cell.setup(so: item)
                cell.item = item
            }
      
        }
        cell.delegate = self
        self.cellHeight = cell.estimateCellHeight
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        self.cellHeight
    }
}

extension OrderCardViewController: ItemSOCardTableViewCellDelegate {
    func getCardItem(so: GetCRMPaymentHistoryTheNapResult) {
        let newViewController = DetailCardOrderViewController()
        newViewController.so = so
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}

extension OrderCardViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.titleView = nil
        }, completion: { finished in

        })
        self.navigationItem.setLeftBarButton(btnBack, animated: true)
        self.navigationItem.setRightBarButton(btnSearch, animated: true)
        search(key: "")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(key: "\(searchBar.text!)")
        self.navigationItem.setLeftBarButton(btnBack, animated: true)
        self.navigationItem.setRightBarButton(btnSearch, animated: true)

        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.titleView = nil
        }, completion: { finished in

        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(key: searchText)
    }

    func search(key:String){
        if key.isEmpty {
            arrFilter = self.items
        } else {
            arrFilter = items.filter({
                ("\($0.MPOS)".localizedCaseInsensitiveContains(key)) || ($0.customerName.localizedCaseInsensitiveContains(key)) || ("\($0.MaGD)".localizedCaseInsensitiveContains(key))
            })
        }
        tableView.reloadData()
    }
}

protocol ItemSOCardTableViewCellDelegate:AnyObject {
    func getCardItem(so:GetCRMPaymentHistoryTheNapResult)
}

class ItemSOCardTableViewCell: UITableViewCell {
    var estimateCellHeight:CGFloat = 0
    weak var delegate:ItemSOCardTableViewCellDelegate?
    var item:GetCRMPaymentHistoryTheNapResult?
    
//    Is_Cash = 1 // chưa xác nhận
    func setup(so:GetCRMPaymentHistoryTheNapResult){
        self.subviews.forEach({$0.removeFromSuperview()})
        
        let viewContent = UIView(frame: CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: self.frame.height))
        viewContent.backgroundColor = .white
        self.addSubview(viewContent)
        
        let lbMposNum = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 5), width: (viewContent.frame.width - Common.Size(s: 30))/2, height: Common.Size(s: 20)))
        lbMposNum.text = "MPOS: \(so.MPOS)"
        lbMposNum.font = UIFont.boldSystemFont(ofSize: 15)
        lbMposNum.textColor = UIColor(netHex: 0x109e59)
        viewContent.addSubview(lbMposNum)

        let lbCreateDate = UILabel(frame: CGRect(x: lbMposNum.frame.origin.x + lbMposNum.frame.width, y: Common.Size(s: 5), width: lbMposNum.frame.width, height: Common.Size(s: 20)))
        lbCreateDate.font = UIFont.systemFont(ofSize: 13)
        lbCreateDate.textAlignment = .right
        viewContent.addSubview(lbCreateDate)
        
        if !(so.CreatedDateTime.isEmpty) {
            let dateStrOld = so.CreatedDateTime
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            let date2 = formatter.date(from: dateStrOld)

            let newFormatter = DateFormatter()
            newFormatter.locale = Locale(identifier: "vi_VN");
            newFormatter.timeZone = TimeZone(identifier: "UTC");
            newFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            let str = newFormatter.string(from: date2 ?? Date())
            lbCreateDate.text = str
        } else {
            lbCreateDate.text = so.CreatedDateTime
        }

        let line = UIView(frame: CGRect(x: Common.Size(s: 15), y: lbCreateDate.frame.origin.y + lbCreateDate.frame.height + Common.Size(s: 3), width: viewContent.frame.width - Common.Size(s: 30), height: Common.Size(s: 1)))
        line.backgroundColor = .lightGray
        viewContent.addSubview(line)
        
        let lbMaGD = UILabel(frame: CGRect(x: Common.Size(s: 15), y: line.frame.origin.y + line.frame.height + Common.Size(s: 5), width: (line.frame.width)/3, height: Common.Size(s: 20)))
        lbMaGD.text = "Mã giao dịch:"
        lbMaGD.font = UIFont.systemFont(ofSize: 14)
        lbMaGD.textColor = .lightGray
        viewContent.addSubview(lbMaGD)

        let lbMaGDText = UILabel(frame: CGRect(x: lbMaGD.frame.origin.x + lbMaGD.frame.width, y: lbMaGD.frame.origin.y, width: (line.frame.width - Common.Size(s: 30)) * 2/3, height: Common.Size(s: 20)))
        lbMaGDText.text = "\(so.MaGD)"
        lbMaGDText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbMaGDText)
        
        let lbNV = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbMaGDText.frame.origin.y + lbMaGDText.frame.height, width: lbMaGD.frame.width, height: Common.Size(s: 20)))
        lbNV.text = "Nhân viên tạo:"
        lbNV.font = UIFont.systemFont(ofSize: 14)
        lbNV.textColor = .lightGray
        viewContent.addSubview(lbNV)
        
        let lbNVText = UILabel(frame: CGRect(x: lbNV.frame.origin.x + lbNV.frame.width, y: lbNV.frame.origin.y, width: lbMaGDText.frame.width, height: Common.Size(s: 20)))
        lbNVText.text = "\(so.NVGD)"
        lbNVText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbNVText)
        
        let lbNVTextHeight:CGFloat = lbNVText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNVText.optimalHeight + Common.Size(s: 5))
        lbNVText.numberOfLines = 0
        lbNVText.frame = CGRect(x: lbNVText.frame.origin.x, y: lbNVText.frame.origin.y, width: lbNVText.frame.width, height: lbNVTextHeight)
        
        let lbNhaMang = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNVText.frame.origin.y + lbNVTextHeight, width: lbMaGD.frame.width, height: Common.Size(s: 20)))
        lbNhaMang.text = "Nhà mạng:"
        lbNhaMang.font = UIFont.systemFont(ofSize: 14)
        lbNhaMang.textColor = .lightGray
        viewContent.addSubview(lbNhaMang)
        
        let lbNhaMangText = UILabel(frame: CGRect(x: lbNhaMang.frame.origin.x + lbNhaMang.frame.width, y: lbNhaMang.frame.origin.y, width: lbMaGDText.frame.width, height: Common.Size(s: 20)))
        lbNhaMangText.text = "\(so.NhaMang)"
        lbNhaMangText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbNhaMangText)
        
        let lbNhaMangTextHeight:CGFloat = lbNhaMangText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNhaMangText.optimalHeight + Common.Size(s: 5))
        lbNhaMangText.numberOfLines = 0
        lbNhaMangText.frame = CGRect(x: lbNhaMangText.frame.origin.x, y: lbNhaMangText.frame.origin.y, width: lbNhaMangText.frame.width, height: lbNhaMangTextHeight)
        
        let lbSoLuong = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNhaMangText.frame.origin.y + lbNhaMangTextHeight, width: lbMaGD.frame.width, height: Common.Size(s: 20)))
        lbSoLuong.text = "Số lượng:"
        lbSoLuong.font = UIFont.systemFont(ofSize: 14)
        lbSoLuong.textColor = .lightGray
        viewContent.addSubview(lbSoLuong)
        
        let lbSoLuongText = UILabel(frame: CGRect(x: lbSoLuong.frame.origin.x + lbSoLuong.frame.width, y: lbSoLuong.frame.origin.y, width: lbMaGDText.frame.width, height: Common.Size(s: 20)))
        lbSoLuongText.text = "\(Common.convertCurrencyInteger(value: so.SLThe))"
        lbSoLuongText.font = UIFont.systemFont(ofSize: 14)
        lbSoLuongText.textColor = UIColor(netHex: 0x109e59)
        viewContent.addSubview(lbSoLuongText)
        
        if so.Type_LoaiDichVu == 1 {//the cao
            lbSoLuong.isHidden = false
            lbSoLuongText.isHidden = false
            lbSoLuong.frame = CGRect(x: lbSoLuong.frame.origin.x, y: lbSoLuong.frame.origin.y, width: lbSoLuong.frame.width, height: Common.Size(s: 20))
            lbSoLuongText.frame = CGRect(x: lbSoLuongText.frame.origin.x, y: lbSoLuongText.frame.origin.y, width: lbSoLuongText.frame.width, height: Common.Size(s: 20))
        } else {//topup
            lbSoLuong.isHidden = false
            lbSoLuongText.isHidden = false
            lbSoLuong.frame = CGRect(x: lbSoLuong.frame.origin.x, y: lbSoLuong.frame.origin.y, width: lbSoLuong.frame.width, height: 0)
            lbSoLuongText.frame = CGRect(x: lbSoLuongText.frame.origin.x, y: lbSoLuongText.frame.origin.y, width: lbSoLuongText.frame.width, height: 0)
        }
        
        let lbMenhGia = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSoLuongText.frame.origin.y + lbSoLuongText.frame.height, width: lbMaGD.frame.width, height: Common.Size(s: 20)))
        lbMenhGia.text = "Mệnh giá:"
        lbMenhGia.font = UIFont.systemFont(ofSize: 14)
        lbMenhGia.textColor = .lightGray
        viewContent.addSubview(lbMenhGia)
        
        let lbMenhGiaText = UILabel(frame: CGRect(x: lbMenhGia.frame.origin.x + lbMenhGia.frame.width, y: lbMenhGia.frame.origin.y, width: lbMaGDText.frame.width, height: Common.Size(s: 20)))
        lbMenhGiaText.text = "\(Common.convertCurrency(value: so.MenhGia))"
        lbMenhGiaText.font = UIFont.systemFont(ofSize: 14)
        lbMenhGiaText.textColor = UIColor(netHex: 0x109e59)
        viewContent.addSubview(lbMenhGiaText)
        
        let lbTrangThai = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbMenhGiaText.frame.origin.y + lbMenhGiaText.frame.height, width: lbMaGD.frame.width, height: Common.Size(s: 20)))
        lbTrangThai.text = "Trạng thái:"
        lbTrangThai.font = UIFont.systemFont(ofSize: 14)
        lbTrangThai.textColor = .lightGray
        viewContent.addSubview(lbTrangThai)
        
        let lbTrangThaiText = UILabel(frame: CGRect(x: lbTrangThai.frame.origin.x + lbTrangThai.frame.width, y: lbTrangThai.frame.origin.y, width: lbMaGDText.frame.width, height: Common.Size(s: 20)))
        lbTrangThaiText.text = "\(so.TinhTrang_ThuTien)"
        lbTrangThaiText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbTrangThaiText)
        
        if so.Is_Cash == 1 { //chua xac nhan
            lbTrangThaiText.textColor = UIColor(netHex: 0xcc0c2f)
        } else {
            lbTrangThaiText.textColor = UIColor(netHex: 0x109e59)
        }
        
        let lbTongTien = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTrangThaiText.frame.origin.y + lbTrangThaiText.frame.height, width: lbMaGD.frame.width, height: Common.Size(s: 20)))
        lbTongTien.text = "Tổng tiền:"
        lbTongTien.font = UIFont.systemFont(ofSize: 14)
        lbTongTien.textColor = .lightGray
        viewContent.addSubview(lbTongTien)
        
        let lbTongTienText = UILabel(frame: CGRect(x: lbTongTien.frame.origin.x + lbTongTien.frame.width, y: lbTongTien.frame.origin.y, width: lbMaGDText.frame.width, height: Common.Size(s: 20)))
        lbTongTienText.text = "\(Common.convertCurrency(value: so.TongTienDaThu)) VNĐ"
        lbTongTienText.font = UIFont.boldSystemFont(ofSize: 15)
        lbTongTienText.textColor = UIColor(netHex: 0xcc0c2f)
        viewContent.addSubview(lbTongTienText)
        
        let line2 = UIView(frame: CGRect(x: 0, y: lbTongTienText.frame.origin.y + lbTongTienText.frame.height + Common.Size(s: 10), width: viewContent.frame.width + Common.Size(s: 15), height: Common.Size(s: 3)))
        line2.backgroundColor = UIColor(netHex: 0xcfd1d0)
        viewContent.addSubview(line2)
        
        viewContent.frame = CGRect(x: viewContent.frame.origin.x, y: viewContent.frame.origin.y , width: viewContent.frame.width, height: line2.frame.origin.y + line2.frame.height)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pushCardDetail))
        viewContent.isUserInteractionEnabled = true
        viewContent.addGestureRecognizer(tapGesture)

        estimateCellHeight = viewContent.frame.origin.y + viewContent.frame.height
    }
    
    @objc func pushCardDetail() {
        self.delegate?.getCardItem(so: item ?? GetCRMPaymentHistoryTheNapResult(Bill_Code: "", MPOS: 0, TinhTrang_ThuTien: "", LoaiGiaoDich: "", SDT_KH: "", TongTienDaThu: 0, Tong_TienMat: 0, Tong_The: 0, Tong_VC: 0, GiaTri_VC: "", NhaMang: "", MenhGia: 0, LoaiDichVu: "", NCC: "", Is_Cash: 0, customerCode: "", customerName: "", ExpiredCard: "", NumberCode: "", SerialCard: "", CreatedDateTime: "", TongTienKhongPhi: 0, TongTienPhi: 0, U_Voucher: "", KyThanhToan: "", PhiCaThe: 0, mVoucher: [], MaGD: "", NgayHetHan: "", NVGD: "", Type_LoaiDichVu: 0, SLThe: 0, NameCard: "", Is_HDCty: 0))
    }
}


//CARD OUTSIDE
class ItemSOOutsideCardTableViewCell: UITableViewCell {
    var address: UILabel!
    var name: UILabel!
    var dateCreate: UILabel!
    var numMPOS: UILabel!
    var numPOS: UILabel!
    var status: UILabel!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        name = UILabel()
        name.textColor = UIColor.black
        name.numberOfLines = 1
        name.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        contentView.addSubview(name)
        
        address = UILabel()
        address.textColor = UIColor.gray
        address.numberOfLines = 1
        address.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(address)
        
        dateCreate = UILabel()
        dateCreate.textColor = UIColor.gray
        dateCreate.numberOfLines = 1
        dateCreate.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(dateCreate)
        
        
        numMPOS = UILabel()
        numMPOS.textColor = UIColor.gray
        numMPOS.numberOfLines = 1
        numMPOS.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(numMPOS)
        
        numPOS = UILabel()
        numPOS.textColor = UIColor.gray
        numPOS.numberOfLines = 1
        numPOS.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(numPOS)
        
        status = UILabel()
        status.numberOfLines = 1
        status.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(status)
    }
    
    func setupTheCaoOutsideCell(item:TheCaoOutside){
        name.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        name.text = "Số mPOS: \(item.SOMPOS)"
        
        address.frame = CGRect(x:name.frame.origin.x ,y: name.frame.origin.y + name.frame.size.height +  Common.Size(s:5),width: name.frame.size.width ,height: Common.Size(s:13))
        address.text = "Mã GD: \(item.SoPhieu)"
        
        dateCreate.frame = CGRect(x:address.frame.origin.x ,y: address.frame.origin.y + address.frame.size.height +  Common.Size(s:5) ,width: address.frame.size.width ,height: Common.Size(s:13))
        dateCreate.text = "Ngày tạo: \(item.Ngay)"
        let line1 = UIView(frame: CGRect(x: dateCreate.frame.origin.x, y:dateCreate.frame.origin.y + dateCreate.frame.size.height + Common.Size(s:5), width: 1, height: Common.Size(s:16)))
        line1.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line1)
        
        let line2 = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width/3 + Common.Size(s:10), y:line1.frame.origin.y, width: 1, height: Common.Size(s:16)))
        line2.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line2)
        
        numMPOS.frame = CGRect(x:line1.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: name.frame.size.width/3,height:line1.frame.size.height)
        numMPOS.text = "\(item.MaNhaDichVu)"
        
        numPOS.frame = CGRect(x:line2.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: name.frame.size.width/3,height:line1.frame.size.height)
        numPOS.text = "Tổng: \(Common.convertCurrency(value: item.MenhGia))"
    }
}
