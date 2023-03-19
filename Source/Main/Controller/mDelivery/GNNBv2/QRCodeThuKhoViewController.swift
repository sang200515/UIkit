//
//  QRCodeThuKhoViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 8/27/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Toaster

class QRCodeThuKhoViewController: UIViewController {

    var scannerView: QRScannerView!
    var tableView: UITableView!
    var cellHeight: CGFloat = 0
    var arrQrCode = [String]()
    let isNhaVanChuyen = false
    var lbTotalScanNum: UILabel!

    var listVanDonChoGiao = [GNNB_GetTransport]()
    var listScan = [GNNB_GetTransport]()
    var tabType = "1"
    var totalScanNumber = 0
    
    var itemCurrentScan = GNNB_GetTransport(billCode: "", shopCode_Ex: "", shopName_Ex: "", shopCode_Re: "", shopName_Re: "", binTotal: 0, createDateTime: "", shipDateTime: "", receiveDateTime: "", transporterName: "", transporterCode: "", shiperCode: "", shiperName: "", receiverCode: "", receiverName: "", billStatusCode: "", billStatusName: "", username: "", BillType: "", SenderName: "", STT: 0)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !scannerView.isRunning {
            scannerView.startScanning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !scannerView.isRunning {
            scannerView.stopScanning()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.title = "Quét QRcode"
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        let viewCofirmQrcode = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s: 25), height: Common.Size(s: 25))))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: viewCofirmQrcode)
        let btCofirmQrcodeIcon = UIButton.init(type: .custom)
        btCofirmQrcodeIcon.setImage(#imageLiteral(resourceName: "IconCheckGNNB-100"), for: UIControl.State.normal)
        btCofirmQrcodeIcon.imageView?.contentMode = .scaleToFill
        btCofirmQrcodeIcon.addTarget(self, action: #selector(confirmListQRcode), for: UIControl.Event.touchUpInside)
        btCofirmQrcodeIcon.frame = CGRect(x: 0, y: 0, width: Common.Size(s: 25), height: Common.Size(s: 25))
        viewCofirmQrcode.addSubview(btCofirmQrcodeIcon)
        
        scannerView = QRScannerView(frame: CGRect(x: 0, y: -10, width: self.view.frame.width, height: self.view.frame.height/2))
        scannerView.delegate = self
        self.view.addSubview(scannerView)
        
        let viewTotalScan = UIView(frame: CGRect(x: 0, y: scannerView.frame.origin.y + scannerView.frame.height, width: self.view.frame.width, height: Common.Size(s: 25)))
        viewTotalScan.backgroundColor = UIColor(netHex: 0x27ae60)
        self.view.addSubview(viewTotalScan)
        
        let lbDidScan = UILabel(frame: CGRect(x: Common.Size(s: 8), y: 0, width: (viewTotalScan.frame.width - Common.Size(s: 16))/2, height: Common.Size(s: 25)))
        lbDidScan.text = "ĐÃ QUÉT"
        lbDidScan.font = UIFont.systemFont(ofSize: 15)
        lbDidScan.textColor = .white
        viewTotalScan.addSubview(lbDidScan)
        
        lbTotalScanNum = UILabel(frame: CGRect(x: lbDidScan.frame.origin.x + lbDidScan.frame.width, y: 0, width: lbDidScan.frame.width, height: Common.Size(s: 25)))
        lbTotalScanNum.text = "Tổng số kiện: 0"
        lbTotalScanNum.font = UIFont.systemFont(ofSize: 14)
        lbTotalScanNum.textAlignment = .right
        viewTotalScan.addSubview(lbTotalScanNum)
        
        let tableViewHeight:CGFloat = self.view.frame.height - (self.self.navigationController?.navigationBar.frame.height ?? 0) - UIApplication.shared.statusBarFrame.height

        tableView = UITableView(frame: CGRect(x: 0, y: viewTotalScan.frame.origin.y + viewTotalScan.frame.height + Common.Size(s: 5), width: self.view.frame.width, height: tableViewHeight - self.view.frame.height/2 - Common.Size(s: 5) - viewTotalScan.frame.height))
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ScanQRCodeGNNBCell.self, forCellReuseIdentifier: "scanQRCodeGNNBCell")
        tableView.tableFooterView = UIView()
    }
    
    @objc func actionBack() {
        
        if listScan.count > 0 {
            self.unBookListVanDon()
            
        } else if listScan.count == 0 {
            self.navigationController?.popViewController(animated: true)
            let dictionaryTabType = ["tabType": self.tabType] as [String : String]
            NotificationCenter.default.post(name: NSNotification.Name.init("didScanQRCodeGNNB"), object: nil, userInfo: dictionaryTabType)
        }
    }
    
    func showAlertScanQrcode(title: String, msg: String) {
        let alert = UIAlertController(title: "\(title)", message: "\(msg)", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: .default) { (_) in
            self.scannerView.startScanning()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func unBookListVanDon() {
        //gen arrBillCode
        var arrCodeBin = [CodeBin]()
        for item in self.listScan {
            var arrBinCodeString = [String]()
            for bin in item.arrKienHang {
                arrBinCodeString.append(bin.kienHangCode)
            }
            arrCodeBin.append(CodeBin(billCode: "\(item.billCode)", arrBinCode: "\(arrBinCodeString.joined(separator: ","))"))
        }
        
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang unbook vận đơn...") {
            APIManager.gnnbv2_UnBookListBill(arrCode_Bin: arrCodeBin) { (rs, msg, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs == "200" {
                            self.listScan.removeAll()
                            self.tableView.reloadData()
                            
                            Toast.init(text: "Unbook thành công!").show()
                            self.navigationController?.popViewController(animated: true)
                            
                            let dictionaryTabType = ["tabType": self.tabType] as [String : String]
                            NotificationCenter.default.post(name: NSNotification.Name.init("didScanQRCodeGNNB"), object: nil, userInfo: dictionaryTabType)
                        } else {
                            self.showAlertScanQrcode(title: "Thông báo", msg: "\(msg ?? "Unbook all vận đơn thất bại!")")
                        }
                    } else {
                        self.showAlertScanQrcode(title: "Thông báo", msg: "\(err)")
                    }
                }
            }
        }
    }
    
    @objc func confirmListQRcode() {
        scannerView.captureSession?.stopRunning()
        
        if listScan.count <= 0 {
            self.showAlertScanQrcode(title: "Thông báo", msg: "Bạn chưa quét vận đơn nào!")
            return
        }
        
        var arrVDFail = [String]()
        for item in self.listScan {
            if item.arrKienHang.count < item.binTotal {
                arrVDFail.append("\(item.billCode)")
            }
        }
        
        if arrVDFail.count > 0 {
            let strBillCode = arrVDFail.joined(separator: ", ")
            self.showAlertScanQrcode(title: "Thông báo", msg: "Đang còn kiện hàng của vận đơn \(strBillCode) cần được quét. Bạn vui lòng quét tiếp trước khi xác nhận!")
            return
        }
        
        //gen arrBillCode
        var arrCodeBin = [CodeBin]()
        for item in self.listScan {
            var arrBinCodeString = [String]()
            for bin in item.arrKienHang {
                arrBinCodeString.append(bin.kienHangCode)
            }
            arrCodeBin.append(CodeBin(billCode: "\(item.billCode)", arrBinCode: "\(arrBinCodeString.joined(separator: ","))"))
        }
        
        if (self.listScan[0].BillType == "1") { //1: GNNB
            let vc = ConfirmQRCodeGNNBViewController()
            vc.tabType = self.tabType
            vc.shippperName = ""
            vc.arrCode_Bin = arrCodeBin
            vc.billType = self.listScan[0].BillType
            vc.transporterName = self.listScan[0].transporterName
            vc.tongSoKienDaQuet = self.lbTotalScanNum.text ?? "Tổng số kiện: 0"
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if self.listScan[0].BillType == "2" { //Nha Van Chuyen
            self.showInputDialog(title: "Xác nhận vận đơn", subtitle: "Vui lòng nhập tên người vận chuyển(không bắt buộc).", actionTitle1: "Huỷ", actionTitle2: "Xác nhận", inputPlaceholder: "Tên người vận chuyển", inputKeyboardType: .default, actionHandler1: { (actionCacel) in
                self.scannerView.captureSession?.startRunning()
                
            }) { (nvcName) in
                debugPrint("tên người VC: \(nvcName ?? "")")
                self.verifyQRCode(keyUserPass: "abc", arrCode_Bin: arrCodeBin, shipperName: "\(nvcName ?? "")", billType: "\(self.listScan[0].BillType)")
            }
        }
    }
    
    func verifyQRCode(keyUserPass: String, arrCode_Bin: [CodeBin], shipperName: String, billType: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            APIManager.gnnbv2_ScanQRCodeVerify(keyUserPass: "\(keyUserPass)", arrCode_Bin: arrCode_Bin, shiperName: "\(shipperName)", billType: billType) { (rs, err)  in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs != nil {
                            if rs?.result == "200" {
                                let alert = UIAlertController(title: "Thông báo", message: "\(rs?.message ?? "Xác nhận thành công!")", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                    self.navigationController?.popViewController(animated: true)
                                    
                                    let dictionaryTabType = ["tabType": self.tabType] as [String : String]
                                    NotificationCenter.default.post(name: NSNotification.Name.init("didScanQRCodeGNNB"), object: nil, userInfo: dictionaryTabType)
                                }
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                                
                            } else {
                                self.showAlertScanQrcode(title: "Thông báo", msg: "\(rs?.message ?? "Xác nhận thất bại!")")
                            }
                            
                        } else {
                            self.showAlertScanQrcode(title: "Thông báo", msg: "\(rs?.message ?? "API Error")")
                        }
                    } else {
                        self.showAlertScanQrcode(title: "Thông báo", msg: "\(rs?.message ?? "\(err)")")
                    }
                }
            }
        }
    }
    
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle1:String?,
                         actionTitle2:String?,
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         actionHandler1: ((_ text: String?) -> Void)? = nil,
                         actionHandler2: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = .default
        }
        
        alert.addAction(UIAlertAction(title: actionTitle1, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler1?(nil)
                return
            }
            actionHandler1?(textField.text)
        }))
        
        alert.addAction(UIAlertAction(title: actionTitle2, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler2?(nil)
                return
            }
            actionHandler2?(textField.text)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension QRCodeThuKhoViewController: QRScannerViewDelegate {
    func qrScanningDidFail() {
        let alert = UIAlertController(title: "Error", message: "Scanning Failed. Please try again!", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func qrScanningSucceededWithCode(_ str: String?) {
        debugPrint("qrcode: \(str ?? "")")
        self.scanV2(qrCodeScan: str ?? "")
    }
    
    func qrScanningDidStop() {
        debugPrint("stop scan")
    }
    
    
    func scanV2(qrCodeScan: String) {
        scannerView.captureSession?.stopRunning()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            APIManager.gnnbv2_ScanQRCode(BinCode: "\(qrCodeScan)") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs != nil {
                            if rs?.result == "200" {
                                if self.listVanDonChoGiao.count > 0 {
                                    //kiem tra van don có tồn tại trong listVandon khong
                                    if !(self.listVanDonChoGiao.contains(where: {$0.billCode == rs?.billCode})) {
                                        self.showAlertScanQrcode(title: "Thông báo", msg: "Kiện hàng không có trong danh sách vận đơn. Vui lòng kiểm tra lại!")
                                        return
                                    }
                                                            
                                    let itemScan = self.listVanDonChoGiao.first(where: {$0.billCode == rs?.billCode})
                                    self.updateLayoutScanV3(itemScan: itemScan!, qrCode: rs?.binCode ?? "")
                                } else {
                                    self.showAlertScanQrcode(title: "Thông báo", msg: "Không có vận đơn!")
                                    return
                                }
                            } else {
                                self.showAlertScanQrcode(title: "Thông báo", msg: "\(rs?.message ?? "Scan qrcode thất bại!")")
                                return
                            }

                        } else {
                            self.showAlertScanQrcode(title: "Thông báo", msg: "API Error!")
                            return
                        }
                    } else {
                        self.showAlertScanQrcode(title: "Thông báo", msg: "\(err)")
                        return
                    }
                }
            }
        }
    }
    
    func sumTotalScan() -> Int {
        var sum = 0
        if self.listScan.count > 0 {
            for itemVD in self.listScan {
                sum = sum + itemVD.arrKienHang.count
            }
        }
        return sum
    }
    
    func updateLayoutScanV3(itemScan: GNNB_GetTransport, qrCode: String) {
        
        self.itemCurrentScan = itemScan
        if self.listScan.count == 0 { //quét vd đầu tiên
            if (self.listVanDonChoGiao.count > 0) {
                self.itemCurrentScan.STT = 1
                self.listScan.append(self.itemCurrentScan)
            }
            
            let itemKien = GNNB_KienHang(kienHangCode: "\(qrCode)", status: true)
            self.itemCurrentScan.arrKienHang.append(itemKien)
            self.tableView.reloadData()
            self.lbTotalScanNum.text = "Tổng số kiện: \(self.sumTotalScan())"
            self.scannerView.startScanning()
            
        } else if self.listScan.count > 0 {
            if itemScan.BillType != self.listScan[0].BillType {
                var msg = ""
                if self.listScan[0].BillType == "1" { //GNNB
                    msg = "Bạn đang quét vận đơn của Giao nhận nội bộ, bạn không được phép quét vận đơn của nhà vận chuyển."
                } else if self.listScan[0].BillType == "2" { //Nhà vận chuyển
                    msg = "Bạn đang quét vận đơn của Nhà vận chuyển, bạn không được phép quét vận đơn của Giao nhận nội bộ."
                }
                self.showAlertScanQrcode(title: "Thông báo", msg: "\(msg)")
                return
            }
            
            if !(self.listScan.contains(where: {$0.billCode == itemScan.billCode})) {//van don moi
                
                if itemScan.binTotal == 1 {
                    self.listScan.append(self.itemCurrentScan)
                } else if itemScan.binTotal > 1 {
                    self.listScan.insert(self.itemCurrentScan, at: 0)
                }
                let itemKien = GNNB_KienHang(kienHangCode: "\(qrCode)", status: true)
                self.itemCurrentScan.arrKienHang.append(itemKien)
                self.tableView.reloadData()
                self.lbTotalScanNum.text = "Tổng số kiện: \(self.sumTotalScan())"
                self.scannerView.startScanning()
                
                
            } else { //van don nay da duoc quet roi
                
                if self.itemCurrentScan.arrKienHang.count == itemScan.binTotal {
                    self.showAlertScanQrcode(title: "Thông báo", msg: "Bạn đã quét đủ kiện hàng của vận đơn \(self.itemCurrentScan.billCode)")
                    return
                    
                } else if self.itemCurrentScan.arrKienHang.count < itemScan.binTotal {
                    
                    if self.itemCurrentScan.arrKienHang.contains(where: {$0.kienHangCode == qrCode}) {
                        self.showAlertScanQrcode(title: "Thông báo", msg: "Kiện hàng đã được quét mã. Vui lòng kiểm tra lại!")
                        return
                    } else {
                        let itemKien = GNNB_KienHang(kienHangCode: "\(qrCode)", status: true)
                        self.itemCurrentScan.arrKienHang.append(itemKien)
                        
                        
                        if self.itemCurrentScan.arrKienHang.count == itemScan.binTotal {
                            //chuyển xuống cuối cùng
                            self.listScan = self.listScan.filter({$0.billCode != self.itemCurrentScan.billCode})
                            self.listScan.append(self.itemCurrentScan)
                        }
                        
                        self.tableView.reloadData()
                        self.lbTotalScanNum.text = "Tổng số kiện: \(self.sumTotalScan())"
                        self.scannerView.startScanning()
                    }
                }
            }
            // update stt
            for i in 0..<self.listScan.count {
                let item = self.listScan[i]
                item.STT = self.listScan.count - i
            }
        }
        
    }
}

extension QRCodeThuKhoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listScan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ScanQRCodeGNNBCell = tableView.dequeueReusableCell(withIdentifier: "scanQRCodeGNNBCell", for: indexPath) as! ScanQRCodeGNNBCell
        let itemSucessVD = listScan[indexPath.row]
        cell.listScan = listScan
        cell.setUpCell(item: itemSucessVD)
        self.cellHeight = cell.estimateCellHeight
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        self.scannerView.captureSession?.stopRunning()
        let itemVD = listScan[indexPath.row]
        if editingStyle == .delete {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                APIManager.gnnbv2_UnBookBill(billCode: self.listScan[indexPath.row].billCode) { (rs, msg, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if err.count <= 0 {
                            if rs == "200" {
                                let alert = UIAlertController(title: "Thông báo", message: "\(msg ?? "Xoá vận đơn thành công!")", preferredStyle: UIAlertController.Style.alert)
                                let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                    
                                    itemVD.arrKienHang.removeAll()
                                    self.listScan = self.listScan.filter({$0.billCode != itemVD.billCode})
                                    
                                    if self.listScan.count > 0 {
                                        self.itemCurrentScan = self.listScan.first!
                                    }
                                    // update stt
                                    for i in 0..<self.listScan.count {
                                        let item = self.listScan[i]
                                        item.STT = self.listScan.count - i
                                    }
                                    tableView.reloadData()
                                    self.lbTotalScanNum.text = "Tổng số kiện: \(self.sumTotalScan())"
                                                                        
                                    WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "reload...") {
                                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                                            self.scannerView.startScanning()
                                        }
                                    }
                                }
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                                return
                                
                            } else {
                                self.showAlertScanQrcode(title: "Thông báo", msg: "\(msg ?? "Xoá vận đơn thất bại!")")
                                return
                            }
                        } else {
                            self.showAlertScanQrcode(title: "Thông báo", msg: "\(err)")
                            return
                        }
                    }
                }
            }
        }
    }
}


class ScanQRCodeGNNBCell: UITableViewCell {
    var estimateCellHeight:CGFloat = 0
    var iconLeft: UIImageView!
    var lbCountVanDon: UILabel!
    var listScan = [GNNB_GetTransport]()
    var sumVDSucess = 0
    
    func setUpCell(item: GNNB_GetTransport) {
        self.subviews.forEach({$0.removeFromSuperview()})
        self.backgroundColor = UIColor.white
        
        let viewContent = UIView(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 8), width: self.frame.width - Common.Size(s: 30), height: self.frame.height))
        viewContent.backgroundColor = UIColor(netHex:0xF8F4F5)
        viewContent.layer.cornerRadius = 5
        self.addSubview(viewContent)
        
        iconLeft = UIImageView(frame: CGRect(x: Common.Size(s: 8), y: Common.Size(s: 5), width: Common.Size(s: 20), height: Common.Size(s: 20)))
        iconLeft.image = #imageLiteral(resourceName: "Check-1")
        iconLeft.contentMode = .scaleToFill
        viewContent.addSubview(iconLeft)
        
        let lbMaVanDonText = UILabel(frame: CGRect(x: iconLeft.frame.origin.x + iconLeft.frame.width + Common.Size(s: 5), y: iconLeft.frame.origin.y, width: viewContent.frame.width - Common.Size(s: 70) - Common.Size(s: 16), height: Common.Size(s: 20)))
        lbMaVanDonText.text = "\(item.STT). \(item.billCode)"
        lbMaVanDonText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbMaVanDonText)
        
        let lbMaVanDonTextHeight: CGFloat = lbMaVanDonText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbMaVanDonText.optimalHeight + Common.Size(s: 5))
        lbMaVanDonText.numberOfLines = 0
        lbMaVanDonText.frame = CGRect(x: lbMaVanDonText.frame.origin.x, y: lbMaVanDonText.frame.origin.y, width: lbMaVanDonText.frame.width, height: lbMaVanDonTextHeight)
        
        let lbShopNhanText = UILabel(frame: CGRect(x: lbMaVanDonText.frame.origin.x, y: lbMaVanDonText.frame.origin.y + lbMaVanDonTextHeight, width: lbMaVanDonText.frame.width, height: Common.Size(s: 20)))
        lbShopNhanText.text = "Shop nhận: \(item.shopName_Re)"
        lbShopNhanText.font = UIFont.italicSystemFont(ofSize: 12)
        viewContent.addSubview(lbShopNhanText)
        
        let lbShopNhanTextHeight: CGFloat = lbShopNhanText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbShopNhanText.optimalHeight + Common.Size(s: 5))
        lbShopNhanText.numberOfLines = 0
        lbShopNhanText.frame = CGRect(x: lbShopNhanText.frame.origin.x, y: lbShopNhanText.frame.origin.y, width: lbShopNhanText.frame.width, height: lbShopNhanTextHeight)
        
        let lbShopXuatText = UILabel(frame: CGRect(x: lbMaVanDonText.frame.origin.x, y: lbShopNhanText.frame.origin.y + lbShopNhanTextHeight, width: lbMaVanDonText.frame.width, height: Common.Size(s: 20)))
        lbShopXuatText.text = "Shop xuất: \(item.shopName_Ex)"
        lbShopXuatText.font = UIFont.italicSystemFont(ofSize: 12)
        viewContent.addSubview(lbShopXuatText)
        
        let lbShopXuatTextHeight: CGFloat = lbShopXuatText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbShopXuatText.optimalHeight + Common.Size(s: 5))
        lbShopXuatText.numberOfLines = 0
        lbShopXuatText.frame = CGRect(x: lbShopXuatText.frame.origin.x, y: lbShopXuatText.frame.origin.y, width: lbShopXuatText.frame.width, height: lbShopXuatTextHeight)
        
        viewContent.frame = CGRect(x: viewContent.frame.origin.x, y: viewContent.frame.origin.y, width: viewContent.frame.width, height: lbShopXuatText.frame.origin.y + lbShopXuatTextHeight + Common.Size(s: 10))
        
        lbCountVanDon = UILabel(frame: CGRect(x: lbShopNhanText.frame.origin.x + lbShopNhanText.frame.width, y: 0, width: viewContent.frame.width - (lbShopNhanText.frame.origin.x + lbShopNhanText.frame.width) - Common.Size(s: 10), height: viewContent.frame.height))
        lbCountVanDon.text = "0"
        lbCountVanDon.textAlignment = .center
        lbCountVanDon.textColor = .black
        lbCountVanDon.font = UIFont.boldSystemFont(ofSize: 13)
        viewContent.addSubview(lbCountVanDon)
        
        let line = UIView(frame: CGRect(x: 0, y: viewContent.frame.origin.y + viewContent.frame.height, width: self.frame.width, height: Common.Size(s: 8)))
        line.backgroundColor = UIColor.white
        self.addSubview(line)
        
        estimateCellHeight = line.frame.origin.y + line.frame.height
        
        
        if item.arrKienHang.count == item.binTotal {
            iconLeft.image = #imageLiteral(resourceName: "check-booksim")
            lbCountVanDon.text = "\(item.arrKienHang.count)/\(item.binTotal)"
            lbCountVanDon.textColor = UIColor(netHex: 0x27ae60)
        } else {
            iconLeft.image = #imageLiteral(resourceName: "Check-1")
            lbCountVanDon.text = "\(item.arrKienHang.count)/\(item.binTotal)"
            lbCountVanDon.textColor = UIColor.red
        }
    }
}

struct CodeBin {
    var billCode: String
    var arrBinCode: String
}
