//
//  ConfirmQRCodeGNNBViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 9/3/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ConfirmQRCodeGNNBViewController: UIViewController {
    
    var scannerView: QRScannerView!
    var tableView: UITableView!
    var cellHeight: CGFloat = 0
    var arrQrCode = [ScanQRCodeVerify]()
    var tabType = ""
    var arrCode_Bin = [CodeBin]()
    var shippperName = ""
    var lbTotalScanNum: UILabel!
    var tongSoKienDaQuet = ""
    var billType = ""
    var transporterName = ""
    
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
        if self.transporterName == "Shop tự nhận" {
            self.title = "Quét QR Shop nhận"
        } else {
            if self.tabType == "1" {
                self.title = "Quét QR của GNNB giao đi"
            } else if self.tabType == "2" {
                self.title = "Quét QR của GNNB nhận về"
            } else {
                self.title = "Quét QR của GNNB"
            }
        }
        
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        scannerView = QRScannerView(frame: CGRect(x: 0, y: -10, width: self.view.frame.width, height: self.view.frame.height/2))
        scannerView.delegate = self
        self.view.addSubview(scannerView)
        
        let viewTotalScan = UIView(frame: CGRect(x: 0, y: scannerView.frame.origin.y + scannerView.frame.height, width: self.view.frame.width, height: Common.Size(s: 25)))
        viewTotalScan.backgroundColor = UIColor(netHex: 0x27ae60)
        self.view.addSubview(viewTotalScan)
        
        let lbDidScan = UILabel(frame: CGRect(x: Common.Size(s: 8), y: 0, width: (viewTotalScan.frame.width - Common.Size(s: 16))/2, height: Common.Size(s: 25)))
        if self.transporterName == "Shop tự nhận" {
            lbDidScan.text = "QUÉT QR SHOP NHẬN"
        } else {
            lbDidScan.text = "QUÉT QR GNNB"
        }
        lbDidScan.font = UIFont.systemFont(ofSize: 15)
        lbDidScan.textColor = .white
        viewTotalScan.addSubview(lbDidScan)
        
        lbTotalScanNum = UILabel(frame: CGRect(x: lbDidScan.frame.origin.x + lbDidScan.frame.width, y: 0, width: lbDidScan.frame.width, height: Common.Size(s: 25)))
        lbTotalScanNum.text = "\(self.tongSoKienDaQuet)"
        lbTotalScanNum.font = UIFont.systemFont(ofSize: 14)
        lbTotalScanNum.textAlignment = .right
        viewTotalScan.addSubview(lbTotalScanNum)
        
        let tableViewHeight:CGFloat = self.view.frame.height - (self.self.navigationController?.navigationBar.frame.height ?? 0) - UIApplication.shared.statusBarFrame.height
        
        //        tableView = UITableView(frame: CGRect(x: 0, y: viewTotalScan.frame.origin.y + viewTotalScan.frame.height + Common.Size(s: 5), width: self.view.frame.width, height: tableViewHeight - self.view.frame.height/2 - Common.Size(s: 45) - viewTotalScan.frame.height))
        tableView = UITableView(frame: CGRect(x: 0, y: viewTotalScan.frame.origin.y + viewTotalScan.frame.height + Common.Size(s: 5), width: self.view.frame.width, height: tableViewHeight - self.view.frame.height/2 - Common.Size(s: 20) - viewTotalScan.frame.height))
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ScanQRCodeGNNBGiaoDiCell.self, forCellReuseIdentifier: "scanQRCodeGNNBGiaoDiCell")
        tableView.tableFooterView = UIView()
        
        
        //        let btnConfirm = UIButton(frame: CGRect(x: self.view.frame.width/2 - Common.Size(s: 75), y: tableView.frame.origin.y + tableView.frame.height + Common.Size(s: 5), width: Common.Size(s: 150), height: Common.Size(s: 30)))
        //        btnConfirm.setTitle("Xác nhận", for: .normal)
        //        btnConfirm.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        //        btnConfirm.titleLabel?.textColor = .white
        //        btnConfirm.backgroundColor = UIColor(netHex: 0x27ae60)
        //        btnConfirm.layer.cornerRadius = Common.Size(s: 15)
        //        btnConfirm.addTarget(self, action: #selector(confirmGNNBGiaoDi), for: .touchUpInside)
        //        self.view.addSubview(btnConfirm)
    }
    
    @objc func actionBack() {
        if self.arrQrCode.count > 0 {
            self.arrQrCode = []
            for vc in self.navigationController?.viewControllers ?? [] {
                if vc is GNNBV2MainViewController {
                    self.navigationController?.popToViewController(vc, animated: true)
                    let dictionaryTabType = ["tabType": self.tabType] as [String : String]
                    NotificationCenter.default.post(name: NSNotification.Name.init("didScanQRCodeGNNB"), object: nil, userInfo: dictionaryTabType)
                }
            }
        } else {
            self.arrQrCode = []
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @objc func confirmGNNBGiaoDi() {
        if self.arrQrCode.count > 0 {
            self.arrQrCode = []
            for vc in self.navigationController?.viewControllers ?? [] {
                if vc is GNNBV2MainViewController {
                    self.navigationController?.popToViewController(vc, animated: true)
                    let dictionaryTabType = ["tabType": self.tabType] as [String : String]
                    NotificationCenter.default.post(name: NSNotification.Name.init("didScanQRCodeGNNB"), object: nil, userInfo: dictionaryTabType)
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Bạn chưa xác nhận QRCode! Vui lòng kiểm tra lại", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension ConfirmQRCodeGNNBViewController: QRScannerViewDelegate {
    func qrScanningDidFail() {
        let alert = UIAlertController(title: "Error", message: "Scanning Failed. Please try again!", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func qrScanningSucceededWithCode(_ str: String?) {
        debugPrint("qrcode: \(str ?? "")")
        
        //gọi api scan confirm của GNNB
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            APIManager.gnnbv2_ScanQRCodeVerify(keyUserPass: str ?? "abc", arrCode_Bin: self.arrCode_Bin, shiperName: "\(self.shippperName)", billType: "\(self.billType)") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        
                        if rs != nil {
                            if rs?.result == "200" {
                                let alert = UIAlertController(title: "Thông báo", message: "\(rs?.message ?? "Xác nhận thành công!")", preferredStyle: UIAlertController.Style.alert)
                                let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                    self.arrQrCode.append(rs!)
                                    self.tableView.reloadData()
                                }
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                                return
                                
                            } else {
                                let alert = UIAlertController(title: "Error", message: "\(rs?.message ?? "Xác nhận thất bại!")", preferredStyle: UIAlertController.Style.alert)
                                let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                    self.scannerView.startScanning()
                                }
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                                return
                            }
                        } else {
                            let alert = UIAlertController(title: "Error", message: "\(rs?.message ?? "API Error!")", preferredStyle: UIAlertController.Style.alert)
                            let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                self.scannerView.startScanning()
                            }
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                            return
                        }
                        
                    } else {
                        let alert = UIAlertController(title: "Error", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                        let action = UIAlertAction(title: "OK", style: .default) { (_) in
                            self.scannerView.startScanning()
                        }
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                }
            }
        }
    }
    
    func qrScanningDidStop() {
        debugPrint("stop scan")
    }
}

extension ConfirmQRCodeGNNBViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrQrCode.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ScanQRCodeGNNBGiaoDiCell = tableView.dequeueReusableCell(withIdentifier: "scanQRCodeGNNBGiaoDiCell", for: indexPath) as! ScanQRCodeGNNBGiaoDiCell
        let item = arrQrCode[indexPath.row]
        cell.setUpCell(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Common.Size(s: 40)
    }
}


class ScanQRCodeGNNBGiaoDiCell: UITableViewCell {
    var iconLeft: UIImageView!
    var lbCountVanDon: UILabel!
    
    func setUpCell(item: ScanQRCodeVerify) {
        self.subviews.forEach({$0.removeFromSuperview()})
        self.backgroundColor = UIColor.white
        
        let viewContent = UIView(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 8), width: self.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        viewContent.backgroundColor = UIColor(netHex:0xF8F4F5)
        viewContent.layer.cornerRadius = 5
        self.addSubview(viewContent)
        
        iconLeft = UIImageView(frame: CGRect(x: Common.Size(s: 8), y: Common.Size(s: 5), width: Common.Size(s: 20), height: Common.Size(s: 20)))
        iconLeft.image = #imageLiteral(resourceName: "check-booksim")
        iconLeft.contentMode = .scaleToFill
        viewContent.addSubview(iconLeft)
        
        let lbMaVanDonText = UILabel(frame: CGRect(x: iconLeft.frame.origin.x + iconLeft.frame.width + Common.Size(s: 5), y: iconLeft.frame.origin.y, width: viewContent.frame.width - iconLeft.frame.origin.x - iconLeft.frame.width - Common.Size(s: 21), height: Common.Size(s: 20)))
        lbMaVanDonText.text = "\(item.shiperCode) - \(item.shiperName)"
        lbMaVanDonText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbMaVanDonText)
        
        let line = UIView(frame: CGRect(x: 0, y: viewContent.frame.origin.y + viewContent.frame.height, width: self.frame.width, height: Common.Size(s: 5)))
        line.backgroundColor = UIColor.white
        self.addSubview(line)
    }
}
