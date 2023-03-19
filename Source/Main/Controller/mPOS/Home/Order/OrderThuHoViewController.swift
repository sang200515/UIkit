//
//  OrderThuHoViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/27/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class OrderThuHoViewController: UIViewController{
    
    var tableView: UITableView  =  UITableView()
    var items: [GetCRMPaymentHistoryTheNapResult] = []
    var cellHeight:CGFloat = Common.Size(s: 70)
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
        self.title = "Thu hộ"
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
        tableView.register(ItemSOThuHoCellV2.self, forCellReuseIdentifier: "itemSOThuHoCellV2")
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        self.view.addSubview(tableView)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
    }
    
    func loadData() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.GetCRMPaymentHistory(usercode: "\(Cache.user!.UserName)", shopcode: "\(Cache.user!.ShopCode)", transType: "3") { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if(err.count <= 0){
                        self.items = results
                        self.arrFilter = results
                        
                        if(results.count <= 0){
                            TableViewHelper.EmptyMessage(message: "Không có đơn hàng.\n:/", viewController: self.tableView)
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

extension OrderThuHoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ItemSOThuHoCellV2 = tableView.dequeueReusableCell(withIdentifier: "itemSOThuHoCellV2", for: indexPath) as! ItemSOThuHoCellV2
        let key = searchBarContainer.searchBar.text ?? ""
        if !(key.isEmpty) {
            let item = arrFilter[indexPath.row]
            cell.setup(so: item)
            cell.item = item
        }else{
            let item = items[indexPath.row]
            cell.setup(so: item)
            cell.item = item
        }
        cell.delegate = self
        self.cellHeight = cell.estimateCellHeight
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.cellHeight
    }
}

extension OrderThuHoViewController: ItemSOThuHoCellV2Delegate {
    func getThuHoItem(so: GetCRMPaymentHistoryTheNapResult) {
        let newViewController = DetailSOThuHoViewController()
        newViewController.so = so
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}

extension OrderThuHoViewController: UISearchBarDelegate {
    
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

protocol ItemSOThuHoCellV2Delegate:AnyObject {
    func getThuHoItem(so:GetCRMPaymentHistoryTheNapResult)
}

class ItemSOThuHoCellV2: UITableViewCell {

    var estimateCellHeight:CGFloat = 0
    weak var delegate:ItemSOThuHoCellV2Delegate?
    var item:GetCRMPaymentHistoryTheNapResult?
    
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
        lbCreateDate.text = so.CreatedDateTime
        viewContent.addSubview(lbCreateDate)

        let line = UIView(frame: CGRect(x: Common.Size(s: 15), y: lbCreateDate.frame.origin.y + lbCreateDate.frame.height + Common.Size(s: 3), width: viewContent.frame.width - Common.Size(s: 30), height: Common.Size(s: 1)))
        line.backgroundColor = .lightGray
        viewContent.addSubview(line)
        
        let lbKHName = UILabel(frame: CGRect(x: Common.Size(s: 15), y: line.frame.origin.y + line.frame.height + Common.Size(s: 5), width: (line.frame.width)/3, height: Common.Size(s: 20)))
        lbKHName.text = "Họ tên KH:"
        lbKHName.font = UIFont.systemFont(ofSize: 14)
        lbKHName.textColor = .lightGray
        viewContent.addSubview(lbKHName)

        let lbKHNameText = UILabel(frame: CGRect(x: lbKHName.frame.origin.x + lbKHName.frame.width, y: lbKHName.frame.origin.y, width: (line.frame.width - Common.Size(s: 30)) * 2/3, height: Common.Size(s: 20)))
        lbKHNameText.text = "\(so.customerName)"
        lbKHNameText.textColor = UIColor(netHex: 0x109e59)
        lbKHNameText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbKHNameText)

        let lbKHNameTextHeight:CGFloat = lbKHNameText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbKHNameText.optimalHeight + Common.Size(s: 5))
        lbKHNameText.numberOfLines = 0
        lbKHNameText.frame = CGRect(x: lbKHNameText.frame.origin.x, y: lbKHNameText.frame.origin.y, width: lbKHNameText.frame.width, height: lbKHNameTextHeight)

        let lbSdt = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbKHNameText.frame.origin.y + lbKHNameTextHeight, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbSdt.text = "SĐT:"
        lbSdt.font = UIFont.systemFont(ofSize: 14)
        lbSdt.textColor = .lightGray
        viewContent.addSubview(lbSdt)

        let lbSdtText = UILabel(frame: CGRect(x: lbSdt.frame.origin.x + lbSdt.frame.width, y: lbSdt.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbSdtText.text = "\(so.SDT_KH)"
        lbSdtText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbSdtText)
        
        let lbSoHD = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSdtText.frame.origin.y + lbSdtText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbSoHD.text = "Số HĐ:"
        lbSoHD.font = UIFont.systemFont(ofSize: 14)
        lbSoHD.textColor = .lightGray
        viewContent.addSubview(lbSoHD)
        
        let lbSoHDText = UILabel(frame: CGRect(x: lbSoHD.frame.origin.x + lbSoHD.frame.width, y: lbSoHD.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbSoHDText.text = "\(so.customerCode)"
        lbSoHDText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbSoHDText)
        
        let lbNCC = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSoHDText.frame.origin.y + lbSoHDText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbNCC.text = "NCC:"
        lbNCC.font = UIFont.systemFont(ofSize: 14)
        lbNCC.textColor = .lightGray
        viewContent.addSubview(lbNCC)
        
        let lbNCCText = UILabel(frame: CGRect(x: lbNCC.frame.origin.x + lbNCC.frame.width, y: lbNCC.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbNCCText.text = "\(so.NCC)"
        lbNCCText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbNCCText)
        
        let lbNCCTextHeight:CGFloat = lbNCCText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNCCText.optimalHeight + Common.Size(s: 5))
        lbNCCText.numberOfLines = 0
        lbNCCText.frame = CGRect(x: lbNCCText.frame.origin.x, y: lbNCCText.frame.origin.y, width: lbNCCText.frame.width, height: lbNCCTextHeight)
        
        let lbMaGD = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNCCText.frame.origin.y + lbNCCTextHeight, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbMaGD.text = "Mã giao dịch:"
        lbMaGD.font = UIFont.systemFont(ofSize: 14)
        lbMaGD.textColor = .lightGray
        viewContent.addSubview(lbMaGD)
        
        let lbMaGDText = UILabel(frame: CGRect(x: lbMaGD.frame.origin.x + lbMaGD.frame.width, y: lbMaGD.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbMaGDText.text = "\(so.MaGD)"
        lbMaGDText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbMaGDText)
        
        let lbNVGD = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbMaGDText.frame.origin.y + lbMaGDText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbNVGD.text = "NV giao dịch:"
        lbNVGD.font = UIFont.systemFont(ofSize: 14)
        lbNVGD.textColor = .lightGray
        viewContent.addSubview(lbNVGD)
        
        let lbNVGDText = UILabel(frame: CGRect(x: lbNVGD.frame.origin.x + lbNVGD.frame.width, y: lbNVGD.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbNVGDText.text = "\(so.NVGD)"
        lbNVGDText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbNVGDText)
        
        let lbNVGDTextHeight:CGFloat = lbNVGDText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNVGDText.optimalHeight + Common.Size(s: 5))
        lbNVGDText.numberOfLines = 0
        lbNVGDText.frame = CGRect(x: lbNVGDText.frame.origin.x, y: lbNVGDText.frame.origin.y, width: lbNVGDText.frame.width, height: lbNVGDTextHeight)
        
        let lbTrangThai = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNVGDText.frame.origin.y + lbNVGDTextHeight, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbTrangThai.text = "Trạng thái:"
        lbTrangThai.font = UIFont.systemFont(ofSize: 14)
        lbTrangThai.textColor = .lightGray
        viewContent.addSubview(lbTrangThai)
        
        let lbTrangThaiText = UILabel(frame: CGRect(x: lbTrangThai.frame.origin.x + lbTrangThai.frame.width, y: lbTrangThai.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbTrangThaiText.text = "\(so.TinhTrang_ThuTien)"
        lbTrangThaiText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbTrangThaiText)
        
        if so.Is_Cash == 1 { //chua xac nhan
            lbTrangThaiText.textColor = UIColor(netHex: 0xcc0c2f)
        } else {
            lbTrangThaiText.textColor = UIColor(netHex: 0x109e59)
        }
        
        let lbTongTien = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTrangThaiText.frame.origin.y + lbTrangThaiText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbTongTien.text = "Tổng tiền:"
        lbTongTien.font = UIFont.systemFont(ofSize: 14)
        lbTongTien.textColor = .lightGray
        viewContent.addSubview(lbTongTien)
        
        let lbTongTienText = UILabel(frame: CGRect(x: lbTongTien.frame.origin.x + lbTongTien.frame.width, y: lbTongTien.frame.origin.y, width: lbMaGDText.frame.width, height: Common.Size(s: 20)))
        lbTongTienText.text = "\(Common.convertCurrency(value: so.TongTienDaThu))"
        lbTongTienText.font = UIFont.boldSystemFont(ofSize: 15)
        lbTongTienText.textColor = UIColor(netHex: 0xcc0c2f)
        viewContent.addSubview(lbTongTienText)
        
        let line2 = UIView(frame: CGRect(x: 0, y: lbTongTienText.frame.origin.y + lbTongTienText.frame.height + Common.Size(s: 10), width: viewContent.frame.width + Common.Size(s: 15), height: Common.Size(s: 3)))
        line2.backgroundColor = UIColor(netHex: 0xcfd1d0)
        viewContent.addSubview(line2)
        
        viewContent.frame = CGRect(x: viewContent.frame.origin.x, y: viewContent.frame.origin.y , width: viewContent.frame.width, height: line2.frame.origin.y + line2.frame.height)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pushThuHoDetail))
        viewContent.isUserInteractionEnabled = true
        viewContent.addGestureRecognizer(tapGesture)

        estimateCellHeight = viewContent.frame.origin.y + viewContent.frame.height
    }
    
    @objc func pushThuHoDetail() {
        self.delegate?.getThuHoItem(so: item ?? GetCRMPaymentHistoryTheNapResult(Bill_Code: "", MPOS: 0, TinhTrang_ThuTien: "", LoaiGiaoDich: "", SDT_KH: "", TongTienDaThu: 0, Tong_TienMat: 0, Tong_The: 0, Tong_VC: 0, GiaTri_VC: "", NhaMang: "", MenhGia: 0, LoaiDichVu: "", NCC: "", Is_Cash: 0, customerCode: "", customerName: "", ExpiredCard: "", NumberCode: "", SerialCard: "", CreatedDateTime: "", TongTienKhongPhi: 0, TongTienPhi: 0, U_Voucher: "", KyThanhToan: "", PhiCaThe: 0, mVoucher: [], MaGD: "", NgayHetHan: "", NVGD: "", Type_LoaiDichVu: 0, SLThe: 0, NameCard: "", Is_HDCty: 0))
    }
}

//THU HỘ OUTSIDE
class ItemSOThuHoTableViewCell: UITableViewCell {
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
    
    func setupThuHoOutsideCell(so:ThuHoOutside){
        name.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        name.text = "Số mPOS: \(so.SoMPos)"
        
        address.frame = CGRect(x:name.frame.origin.x ,y: name.frame.origin.y + name.frame.size.height +  Common.Size(s:5),width: name.frame.size.width ,height: Common.Size(s:13))
        address.text = "NCC: \(so.ProviderName)"
        
        dateCreate.frame = CGRect(x:address.frame.origin.x ,y: address.frame.origin.y + address.frame.size.height +  Common.Size(s:5) ,width: address.frame.size.width ,height: Common.Size(s:13))
        dateCreate.text = "Ngày tạo: \(so.Ngay)"
        let line1 = UIView(frame: CGRect(x: dateCreate.frame.origin.x, y:dateCreate.frame.origin.y + dateCreate.frame.size.height + Common.Size(s:5), width: 1, height: Common.Size(s:16)))
        line1.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line1)
        
        let line2 = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width*2/3 + Common.Size(s:10), y:line1.frame.origin.y, width: 1, height: Common.Size(s:16)))
        line2.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line2)
        
        numMPOS.frame = CGRect(x:line1.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: UIScreen.main.bounds.size.width*2/3 - Common.Size(s: 5),height:line1.frame.size.height)
        numMPOS.text = "Mã GD: \(so.NumberContract)"
        
        numPOS.frame = CGRect(x:line2.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: name.frame.size.width/3,height:line1.frame.size.height)
        numPOS.text = "Tổng: \(Common.convertCurrency(value: so.DocTotal))"
    }
}
