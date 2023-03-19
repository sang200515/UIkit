//
//  GNNBV2MainViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 8/26/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import AVFoundation

class GNNBV2MainViewController: UIViewController {
    
    var tableView: UITableView!
    var cellHeight: CGFloat = 0
    var codeSegmented = CustomSegmentControl()
    var tabType = "1"
    lazy var searchBar:UISearchBar = UISearchBar()
    var viewScan:UIView!
    var viewReload:UIView!
    var arrVanDon = [GNNB_GetTransport]()
    var filterList = [GNNB_GetTransport]()
    var roleType = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.checkCameraAccess()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = .white
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Nhập thông tin tìm kiếm"
        
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = .white
            searchBar.searchTextField.font = UIFont.systemFont(ofSize: 13)
            let placeholderLabel = searchBar.searchTextField.value(forKey: "placeholderLabel") as? UILabel
            placeholderLabel?.font = UIFont.italicSystemFont(ofSize: 13.0)
        } else {
            // Fallback on earlier versions
            let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideUISearchBar?.font = UIFont.systemFont(ofSize: 13)
            let placeholderLabel = textFieldInsideUISearchBar?.value(forKey: "placeholderLabel") as? UILabel
            placeholderLabel?.font = UIFont.italicSystemFont(ofSize: 13.0)
        }
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        self.navigationItem.titleView = searchBar
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)

        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:30), height: Common.Size(s:30))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:30), height: Common.Size(s:40))
        viewLeftNav.addSubview(btBackIcon)
        
        viewScan = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s: 25), height: Common.Size(s: 25))))
        let btScanIcon = UIButton.init(type: .custom)
        btScanIcon.setImage(#imageLiteral(resourceName: "qr-code-outline"), for: UIControl.State.normal)
        btScanIcon.imageView?.contentMode = .scaleToFill
        btScanIcon.addTarget(self, action: #selector(scanGNNB), for: UIControl.Event.touchUpInside)
        btScanIcon.frame = CGRect(x: 0, y: 0, width: Common.Size(s: 25), height: Common.Size(s: 25))
        viewScan.addSubview(btScanIcon)

        viewReload = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s: 25), height: Common.Size(s: 25))))
        let btReloadIcon = UIButton.init(type: .custom)
        btReloadIcon.setImage(#imageLiteral(resourceName: "icons8-available-updates-100"), for: UIControl.State.normal)
        btReloadIcon.imageView?.contentMode = .scaleToFill
        btReloadIcon.addTarget(self, action: #selector(reloadData), for: UIControl.Event.touchUpInside)
        btReloadIcon.frame = CGRect(x: 0, y: 0, width: Common.Size(s: 25), height: Common.Size(s: 25))
        viewReload.addSubview(btReloadIcon)

        self.navigationItem.rightBarButtonItems  = [UIBarButtonItem(customView: viewReload),UIBarButtonItem(customView: viewScan)]
        
        codeSegmented.frame = CGRect(x: 0, y: Common.Size(s: 10), width: self.view.frame.width, height: Common.Size(s: 40))
        codeSegmented.setButtonTitles(buttonTitles: ["CHỜ GIAO", "ĐÃ GIAO", "ĐÃ NHẬN"])
        self.view.addSubview(codeSegmented)
        codeSegmented.backgroundColor = .white
        codeSegmented.selectorViewColor = UIColor(netHex:0x00955E)
        codeSegmented.selectorTextColor = UIColor(netHex:0x00955E)
        codeSegmented.unSelectorViewColor = UIColor.lightGray
        codeSegmented.unSelectorTextColor = UIColor.lightGray
        codeSegmented.delegate = self
        self.view.bringSubviewToFront(codeSegmented)
        
        let tableViewHeight:CGFloat = self.view.frame.height - (self.self.navigationController?.navigationBar.frame.height ?? 0) - UIApplication.shared.statusBarFrame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: codeSegmented.frame.origin.y + codeSegmented.frame.height + Common.Size(s: 5), width: self.view.frame.width, height: tableViewHeight - Common.Size(s: 60)))
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(GNNBMainCell.self, forCellReuseIdentifier: "gnnbCell")
        tableView.tableFooterView = UIView()
        
        self.searchBar.addDoneButtonOnKeyboard()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
        self.getData(tabType: "1")
        
        NotificationCenter.default.addObserver(self, selector: #selector(didScanQRCode(notification:)), name: NSNotification.Name.init("didScanQRCodeGNNB"), object: nil)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func hideKeyBoard() {
        self.searchBar.resignFirstResponder()
    }
    
    @objc func scanGNNB() {
        if (self.tabType == "1") || (self.tabType == "2") {
            if self.roleType == 1 { // Thủ kho 1
                let vc = QRPopupViewController()
                vc.modalTransitionStyle = .coverVertical
                vc.modalPresentationStyle = .overCurrentContext
                
                vc.genQRDidPressed = {
                    let vc = GNNBGenQRcodeViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                vc.scanQRDidPressed = {
                    let vc = QRCodeThuKhoViewController()
                    vc.listVanDonChoGiao = self.arrVanDon
                    vc.tabType = self.tabType
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                self.present(vc, animated: true, completion: nil)
            } else if self.roleType == 2 { //GNNB 2
                let vc = GNNBGenQRcodeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            print("Denied, request permission from settings")
            presentCameraSettings()
        case .restricted:
            print("Restricted, device owner must approve")
        case .authorized:
            print("Authorized, proceed")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    print("Permission granted, proceed")
                } else {
                    print("Permission denied")
                }
            }
        default:
            break
        }
    }
    func presentCameraSettings() {
        let alertController = UIAlertController(title: "Thông báo",
                                                message: "Bạn cần phải cấp quyền camera cho ứng dụng!",
                                                preferredStyle: .alert)
        //        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
        })
        
        present(alertController, animated: true)
    }
    
    @objc func reloadData() {
        self.getData(tabType: self.tabType)
        self.tableView.reloadData()
    }
    
    @objc func didScanQRCode(notification : NSNotification) {
        let info = notification.userInfo
        self.tabType = info?["tabType"] as! String
        
        self.getData(tabType: self.tabType)
        self.tableView.reloadData()
    }
    
    
    func getData(tabType: String) {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let dateString = formatter.string(from: today)
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            APIManager.gnnbv2_GetTransport(FormDate: "\(dateString)", ToDate: "\(dateString)", StatusBill: "\(tabType)") { (rs, roleType, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        self.arrVanDon = rs
                        self.filterList = rs
                        self.roleType = roleType

                        if(rs.count <= 0){
                            TableViewHelper.EmptyMessage(message: "Không có vận đơn.\n:/", viewController: self.tableView)
                        }else{
                            TableViewHelper.removeEmptyMessage(viewController: self.tableView)
                        }
                        self.tableView.reloadData()
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

extension GNNBV2MainViewController: UITableViewDelegate, UITableViewDataSource, GNNBMainCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = searchBar.text ?? ""
        if key.count > 0 {
            return filterList.count
        } else {
            return arrVanDon.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:GNNBMainCell = tableView.dequeueReusableCell(withIdentifier: "gnnbCell", for: indexPath) as! GNNBMainCell
        var item: GNNB_GetTransport
        let key = searchBar.text ?? ""
        if key.count > 0 {
            item = filterList[indexPath.row]
        } else {
            item = arrVanDon[indexPath.row]
        }
        cell.itemGNNB = item
        cell.setUpCell(tabType: "\(self.tabType)", item: item)
        self.cellHeight = cell.estimateCellHeight
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func showDetailVanDon(item: GNNB_GetTransport) {
        let vc = DetailVanDonViewController()
        vc.tabType = self.tabType
        vc.itemGNNB = item
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension GNNBV2MainViewController: CustomSegmentControlDelegate {
    func change(to index: Int) {
        print("segmentedControlCustom index changed to \(index)")
        switch index {
        case 0:
            self.tabType = "1"
            navigationItem.setRightBarButtonItems(nil, animated: true)
            navigationItem.setRightBarButtonItems([UIBarButtonItem(customView: viewReload),UIBarButtonItem(customView: viewScan)], animated: true)
            self.getData(tabType: "1")
            self.tableView.reloadData()
            break
        case 1:
            self.tabType = "2"
            navigationItem.setRightBarButtonItems(nil, animated: true)
            navigationItem.setRightBarButtonItems([UIBarButtonItem(customView: viewReload),UIBarButtonItem(customView: viewScan)], animated: true)
            self.getData(tabType: "2")
            self.tableView.reloadData()
            break
        case 2:
            self.tabType = "3"
            navigationItem.setRightBarButtonItems(nil, animated: true)
            navigationItem.setRightBarButtonItems([UIBarButtonItem(customView: viewReload)], animated: true)
            self.getData(tabType: "3")
            self.tableView.reloadData()
            break
        default:
            break
        }
    }
}

extension GNNBV2MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(key: "\(searchBar.text ?? "")")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(key: "\(searchBar.text ?? "")")
    }
    
    func search(key:String){
        if key.count > 0 {
            filterList = arrVanDon.filter({($0.billCode.localizedCaseInsensitiveContains(key)) || ($0.shopName_Ex.localizedCaseInsensitiveContains(key)) || ($0.shopName_Re.localizedCaseInsensitiveContains(key)) || ($0.shiperName.localizedCaseInsensitiveContains(key))})
        } else {
            filterList = arrVanDon
        }
        tableView.reloadData()
    }
}

protocol GNNBMainCellDelegate:AnyObject {
    func showDetailVanDon(item: GNNB_GetTransport)
}

class GNNBMainCell: UITableViewCell {
    var estimateCellHeight:CGFloat = 0
    weak var delegate:GNNBMainCellDelegate?
    var itemGNNB: GNNB_GetTransport?
    
    func setUpCell(tabType: String, item: GNNB_GetTransport) {
        self.subviews.forEach({$0.removeFromSuperview()})
        self.backgroundColor = UIColor(netHex:0xF8F4F5)
        
        let viewContent = UIView(frame: CGRect(x: Common.Size(s: 8), y: Common.Size(s: 8), width: self.frame.width - Common.Size(s: 16), height: self.frame.height))
        viewContent.backgroundColor = .white
        viewContent.layer.cornerRadius = 10
        self.addSubview(viewContent)
        
        let tapDetail = UITapGestureRecognizer(target: self, action: #selector(actionshowDetailVanDon))
        viewContent.isUserInteractionEnabled = true
        viewContent.addGestureRecognizer(tapDetail)
        
        let iconLeft = UIImageView(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: Common.Size(s: 25), height: Common.Size(s: 25)))
        iconLeft.image = #imageLiteral(resourceName: "icons8-box-100")
        iconLeft.contentMode = .scaleToFill
        viewContent.addSubview(iconLeft)
        
        let lbMaVanDonText = UILabel(frame: CGRect(x: iconLeft.frame.origin.x + iconLeft.frame.width + Common.Size(s: 5), y: iconLeft.frame.origin.y, width: viewContent.frame.width - Common.Size(s: 100) - Common.Size(s: 40), height: Common.Size(s: 25)))
        lbMaVanDonText.text = "Mã vận đơn: \(item.billCode)"
        lbMaVanDonText.font = UIFont.boldSystemFont(ofSize: 15)
        lbMaVanDonText.textColor = UIColor(netHex: 0x27ae60)
        viewContent.addSubview(lbMaVanDonText)
        
        let lbShopNhan = UILabel(frame: CGRect(x: iconLeft.frame.origin.x + (iconLeft.frame.width/2) + Common.Size(s: 5), y: lbMaVanDonText.frame.origin.y + lbMaVanDonText.frame.height, width: Common.Size(s: 80), height: Common.Size(s: 20)))
        lbShopNhan.text = "Shop nhận: "
        lbShopNhan.font = UIFont.systemFont(ofSize: 13)
        viewContent.addSubview(lbShopNhan)
        
        let lbShopNhanText = UILabel(frame: CGRect(x: lbShopNhan.frame.origin.x + lbShopNhan.frame.width, y: lbShopNhan.frame.origin.y, width: viewContent.frame.width - Common.Size(s: 80) - (lbShopNhan.frame.origin.x + lbShopNhan.frame.width), height: Common.Size(s: 20)))
        lbShopNhanText.text = "\(item.shopName_Re)"
        lbShopNhanText.font = UIFont.systemFont(ofSize: 13)
        lbShopNhanText.textColor = UIColor.lightGray
        viewContent.addSubview(lbShopNhanText)
        
        let lbShopNhanTextHeight: CGFloat = lbShopNhanText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbShopNhanText.optimalHeight + Common.Size(s: 5))
        lbShopNhanText.numberOfLines = 0
        lbShopNhanText.frame = CGRect(x: lbShopNhanText.frame.origin.x, y: lbShopNhanText.frame.origin.y, width: lbShopNhanText.frame.width, height: lbShopNhanTextHeight)
        
        let lbShopXuat = UILabel(frame: CGRect(x: lbShopNhan.frame.origin.x, y: lbShopNhanText.frame.origin.y + lbShopNhanTextHeight, width: lbShopNhan.frame.width, height: Common.Size(s: 20)))
        lbShopXuat.text = "Shop xuất: "
        lbShopXuat.font = UIFont.systemFont(ofSize: 13)
        viewContent.addSubview(lbShopXuat)
        
        let lbShopXuatText = UILabel(frame: CGRect(x: lbShopNhanText.frame.origin.x, y: lbShopXuat.frame.origin.y, width: lbShopNhanText.frame.width, height: Common.Size(s: 20)))
        lbShopXuatText.text = "\(item.shopName_Ex)"
        lbShopXuatText.font = UIFont.systemFont(ofSize: 13)
        lbShopXuatText.textColor = UIColor.lightGray
        viewContent.addSubview(lbShopXuatText)
        
        let lbShopXuatTextHeight: CGFloat = lbShopXuatText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbShopXuatText.optimalHeight + Common.Size(s: 5))
        lbShopXuatText.numberOfLines = 0
        lbShopXuatText.frame = CGRect(x: lbShopXuatText.frame.origin.x, y: lbShopXuatText.frame.origin.y, width: lbShopXuatText.frame.width, height: lbShopXuatTextHeight)
        
        let lbNgayTao = UILabel(frame: CGRect(x: lbShopNhan.frame.origin.x, y: lbShopXuatText.frame.origin.y + lbShopXuatTextHeight, width: lbShopNhan.frame.width, height: Common.Size(s: 20)))
        lbNgayTao.text = "Ngày tạo: "
        lbNgayTao.font = UIFont.systemFont(ofSize: 13)
        viewContent.addSubview(lbNgayTao)

        let lbNgayTaoText = UILabel(frame: CGRect(x: lbShopNhanText.frame.origin.x, y: lbNgayTao.frame.origin.y, width: lbShopNhanText.frame.width, height: Common.Size(s: 20)))
        lbNgayTaoText.text = "\(item.createDateTime)"
        lbNgayTaoText.font = UIFont.systemFont(ofSize: 13)
        lbNgayTaoText.textColor = UIColor.lightGray
        viewContent.addSubview(lbNgayTaoText)
        
        let lbNgayGiao = UILabel(frame: CGRect(x: lbShopNhan.frame.origin.x, y: lbNgayTaoText.frame.origin.y + lbNgayTaoText.frame.height, width: lbShopNhan.frame.width, height: Common.Size(s: 20)))
        lbNgayGiao.text = "Ngày giao: "
        lbNgayGiao.font = UIFont.systemFont(ofSize: 13)
        viewContent.addSubview(lbNgayGiao)
        
        let lbNgayGiaoText = UILabel(frame: CGRect(x: lbShopNhanText.frame.origin.x, y: lbNgayGiao.frame.origin.y, width: lbShopNhanText.frame.width, height: Common.Size(s: 20)))
        lbNgayGiaoText.text = "\(item.shipDateTime)"
        lbNgayGiaoText.font = UIFont.systemFont(ofSize: 13)
        lbNgayGiaoText.textColor = UIColor.lightGray
        viewContent.addSubview(lbNgayGiaoText)
        
        let lbGiaoHang = UILabel(frame: CGRect(x: lbShopNhan.frame.origin.x, y: lbNgayGiaoText.frame.origin.y + lbNgayGiaoText.frame.height, width: lbShopNhan.frame.width, height: Common.Size(s: 20)))
        lbGiaoHang.text = "Giao hàng: "
        lbGiaoHang.font = UIFont.systemFont(ofSize: 13)
        viewContent.addSubview(lbGiaoHang)

        let lbGiaoHangText = UILabel(frame: CGRect(x: lbShopNhanText.frame.origin.x, y: lbGiaoHang.frame.origin.y, width: lbShopNhanText.frame.width, height: Common.Size(s: 20)))
        lbGiaoHangText.text = "\(item.transporterName)"
        lbGiaoHangText.font = UIFont.systemFont(ofSize: 13)
        lbGiaoHangText.textColor = UIColor.lightGray
        viewContent.addSubview(lbGiaoHangText)

        let lbGiaoHangTextHeight: CGFloat = lbGiaoHangText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbGiaoHangText.optimalHeight + Common.Size(s: 5))
        lbGiaoHangText.numberOfLines = 0
        lbGiaoHangText.frame = CGRect(x: lbGiaoHangText.frame.origin.x, y: lbGiaoHangText.frame.origin.y, width: lbGiaoHangText.frame.width, height: lbGiaoHangTextHeight)
        
        let lbNguoiVC = UILabel(frame: CGRect(x: lbShopNhan.frame.origin.x, y: lbGiaoHangText.frame.origin.y + lbGiaoHangTextHeight, width: lbShopNhan.frame.width, height: Common.Size(s: 20)))
        lbNguoiVC.text = "Vận chuyển:"
        lbNguoiVC.font = UIFont.systemFont(ofSize: 13)
        viewContent.addSubview(lbNguoiVC)
        
        let lbNguoiVanChuyenText = UILabel(frame: CGRect(x: lbNguoiVC.frame.origin.x + lbNguoiVC.frame.width, y: lbNguoiVC.frame.origin.y, width: lbShopNhanText.frame.width, height: Common.Size(s: 20)))
        lbNguoiVanChuyenText.text = "\(item.shiperName)"
        lbNguoiVanChuyenText.font = UIFont.systemFont(ofSize: 13)
        lbNguoiVanChuyenText.textColor = UIColor.lightGray
        viewContent.addSubview(lbNguoiVanChuyenText)
        
        let lbNguoiVanChuyenTextHeight: CGFloat = lbNguoiVanChuyenText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNguoiVanChuyenText.optimalHeight + Common.Size(s: 5))
        lbNguoiVanChuyenText.numberOfLines = 0
        lbNguoiVanChuyenText.frame = CGRect(x: lbNguoiVanChuyenText.frame.origin.x, y: lbNguoiVanChuyenText.frame.origin.y, width: lbNguoiVanChuyenText.frame.width, height: lbNguoiVanChuyenTextHeight)
        
        let lbThuKhoName = UILabel(frame: CGRect(x: lbShopNhan.frame.origin.x, y: lbNguoiVanChuyenText.frame.origin.y + lbNguoiVanChuyenTextHeight, width: lbShopNhan.frame.width, height: Common.Size(s: 20)))
        lbThuKhoName.text = "Thủ kho:"
        lbThuKhoName.font = UIFont.systemFont(ofSize: 13)
        viewContent.addSubview(lbThuKhoName)

        let lbThuKhoNameText = UILabel(frame: CGRect(x: lbThuKhoName.frame.origin.x + lbThuKhoName.frame.width, y: lbThuKhoName.frame.origin.y, width: lbShopNhanText.frame.width, height: Common.Size(s: 20)))
        lbThuKhoNameText.font = UIFont.systemFont(ofSize: 13)
        lbThuKhoNameText.textColor = UIColor.lightGray
        viewContent.addSubview(lbThuKhoNameText)
        
        if (tabType == "1") { // ẩn ngày giao, người vận chuyển
            lbNgayGiao.isHidden = true
            lbNgayGiaoText.isHidden = true
            lbNguoiVC.isHidden = true
            lbNguoiVanChuyenText.isHidden = true
            
            lbGiaoHang.frame = CGRect(x: lbGiaoHang.frame.origin.x, y: lbNgayTaoText.frame.origin.y + lbNgayTaoText.frame.height, width: lbGiaoHang.frame.width, height: lbGiaoHang.frame.height)
            
            lbGiaoHangText.frame = CGRect(x: lbGiaoHangText.frame.origin.x, y: lbGiaoHang.frame.origin.y, width: lbGiaoHangText.frame.width, height: lbGiaoHangText.frame.height)
            
            lbNguoiVC.frame = CGRect(x: lbNguoiVC.frame.origin.x, y: lbGiaoHangText.frame.origin.y + lbGiaoHangTextHeight, width: lbNguoiVC.frame.width, height: 0)
            
            lbNguoiVanChuyenText.frame = CGRect(x: lbNguoiVanChuyenText.frame.origin.x, y: lbNguoiVC.frame.origin.y, width: lbNguoiVanChuyenText.frame.width, height: 0)
            
            lbThuKhoName.frame = CGRect(x: lbThuKhoName.frame.origin.x, y: lbNguoiVanChuyenText.frame.origin.y + lbNguoiVanChuyenText.frame.height, width: lbThuKhoName.frame.width, height: 0)
            
            lbThuKhoNameText.frame = CGRect(x: lbThuKhoNameText.frame.origin.x, y: lbThuKhoName.frame.origin.y, width: lbThuKhoNameText.frame.width, height: 0)
        } else {
            if (tabType == "2") {
                lbThuKhoName.text = "Thủ kho xuất:"
                lbThuKhoNameText.text = "\(item.SenderName)"
            } else if (tabType == "3") {
                lbThuKhoName.text = "Thủ kho nhận:"
                lbThuKhoNameText.text = "\(item.receiverName)"
            }
            
            let lbThuKhoNameTextHeight: CGFloat = lbThuKhoNameText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbThuKhoNameText.optimalHeight + Common.Size(s: 5))
            lbThuKhoNameText.numberOfLines = 0
            lbThuKhoNameText.frame = CGRect(x: lbThuKhoNameText.frame.origin.x, y: lbThuKhoNameText.frame.origin.y, width: lbThuKhoNameText.frame.width, height: lbThuKhoNameTextHeight)
            
            lbNgayGiao.isHidden = false
            lbNgayGiaoText.isHidden = false
            lbNguoiVC.isHidden = false
            lbNguoiVanChuyenText.isHidden = false
            
            lbGiaoHang.frame = CGRect(x: lbGiaoHang.frame.origin.x, y: lbNgayGiaoText.frame.origin.y + lbNgayGiaoText.frame.height, width: lbGiaoHang.frame.width, height: lbGiaoHang.frame.height)
            
            lbGiaoHangText.frame = CGRect(x: lbGiaoHangText.frame.origin.x, y: lbGiaoHang.frame.origin.y, width: lbGiaoHangText.frame.width, height: lbGiaoHangText.frame.height)
            
            lbNguoiVC.frame = CGRect(x: lbNguoiVC.frame.origin.x, y: lbGiaoHangText.frame.origin.y + lbGiaoHangTextHeight, width: lbNguoiVC.frame.width, height: Common.Size(s: 20))
            
            lbNguoiVanChuyenText.frame = CGRect(x: lbNguoiVanChuyenText.frame.origin.x, y: lbNguoiVC.frame.origin.y, width: lbNguoiVanChuyenText.frame.width, height: lbNguoiVanChuyenTextHeight)
            
            lbThuKhoName.frame = CGRect(x: lbThuKhoName.frame.origin.x, y: lbNguoiVanChuyenText.frame.origin.y + lbNguoiVanChuyenText.frame.height, width: lbThuKhoName.frame.width, height: Common.Size(s: 20))
            
            lbThuKhoNameText.frame = CGRect(x: lbThuKhoNameText.frame.origin.x, y: lbThuKhoName.frame.origin.y, width: lbThuKhoNameText.frame.width, height: lbThuKhoNameTextHeight)
        }

        let line = UIView(frame: CGRect(x: iconLeft.frame.origin.x + iconLeft.frame.width/2 - Common.Size(s: 2), y: iconLeft.frame.origin.y + iconLeft.frame.height + Common.Size(s: 2), width: Common.Size(s: 1), height: lbThuKhoNameText.frame.origin.y + lbThuKhoNameText.frame.height - (iconLeft.frame.origin.y + iconLeft.frame.height)))
        line.backgroundColor = UIColor.lightGray
        viewContent.addSubview(line)
        
        viewContent.frame = CGRect(x: viewContent.frame.origin.x, y: viewContent.frame.origin.y, width: viewContent.frame.width, height: lbThuKhoNameText.frame.origin.y + lbThuKhoNameText.frame.height + Common.Size(s: 10))
        
        //VIEW KIEN HANG
        let viewKienHang = UIView(frame: CGRect(x: viewContent.frame.width - Common.Size(s: 80), y: Common.Size(s: 20), width: Common.Size(s: 70), height: viewContent.frame.height - Common.Size(s: 30)))
        viewKienHang.backgroundColor = UIColor(netHex: 0xF8F4F5)
        viewKienHang.layer.cornerRadius = 10
        viewContent.addSubview(viewKienHang)
        
        let lbKienHangText = UILabel(frame: CGRect(x: 0, y: 0, width: viewKienHang.frame.width, height: viewKienHang.frame.height))
        lbKienHangText.text = "\(item.binTotal)\nkiện"
        lbKienHangText.numberOfLines = 2
        lbKienHangText.textAlignment = .center
        lbKienHangText.textColor = UIColor(netHex: 0xd5c1b6)
        lbKienHangText.font = UIFont.boldSystemFont(ofSize: 15)
        viewKienHang.addSubview(lbKienHangText)
        
        //status
        let viewStatus = UIView(frame: CGRect(x: viewContent.frame.width - Common.Size(s: 80), y: Common.Size(s: 5), width: Common.Size(s: 70), height: Common.Size(s: 30)))
        viewStatus.backgroundColor = UIColor(netHex: 0xd5c1b6)
        viewStatus.layer.cornerRadius = 15
        viewContent.addSubview(viewStatus)
        
        let lbStatus = UILabel(frame: CGRect(x: 0, y: 0, width: viewStatus.frame.width, height: viewStatus.frame.height))
        lbStatus.text = "Chờ giao"
        lbStatus.textAlignment = .center
        lbStatus.font = UIFont.systemFont(ofSize: 14)
        lbStatus.textColor = UIColor.white
        viewStatus.addSubview(lbStatus)
        
        let line2 = UIView(frame: CGRect(x: 0, y: viewContent.frame.origin.y + viewContent.frame.height, width: self.frame.width, height: Common.Size(s: 8)))
        line2.backgroundColor = UIColor(netHex:0xF8F4F5)
        self.addSubview(line2)
        
        estimateCellHeight = line2.frame.origin.y + line2.frame.height
        
        switch tabType {
        case "1":
            viewStatus.backgroundColor = UIColor(netHex: 0xd5c1b6)
            lbStatus.text = "Chờ giao"
            lbKienHangText.textColor = UIColor(netHex: 0xd5c1b6)
            break
        case "2":
            viewStatus.backgroundColor = UIColor(netHex: 0x56ccf2)
            lbStatus.text = "Đã giao"
            lbKienHangText.textColor = UIColor(netHex: 0x56ccf2)
            break
        case "3":
            viewStatus.backgroundColor = UIColor(netHex: 0x6fcf97)
            lbStatus.text = "Đã nhận"
            lbKienHangText.textColor = UIColor(netHex: 0x6fcf97)
            break
        default:
            viewStatus.backgroundColor = UIColor(netHex: 0xd5c1b6)
            lbKienHangText.textColor = UIColor(netHex: 0xd5c1b6)
            break
        }
    }
    
    @objc func actionshowDetailVanDon() {
        self.delegate?.showDetailVanDon(item: itemGNNB ?? GNNB_GetTransport(billCode: "", shopCode_Ex: "", shopName_Ex: "", shopCode_Re: "", shopName_Re: "", binTotal: 0, createDateTime: "", shipDateTime: "", receiveDateTime: "", transporterName: "", transporterCode: "", shiperCode: "", shiperName: "", receiverCode: "", receiverName: "", billStatusCode: "", billStatusName: "", username: "", BillType: "", SenderName: "", STT: 0))
    }
}
