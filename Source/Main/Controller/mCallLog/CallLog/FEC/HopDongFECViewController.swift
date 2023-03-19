//
//  HopDongFECViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 4/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import WebKit

class HopDongFECViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var callLog:CallLog?
    var tableView: UITableView!
    var listChiTietLoi = [ChiTietLoi_227]()
    var viewUnderWebView: UIView!
    var lbNoiDung: WKWebView!
    var cellHeight:CGFloat = Common.Size(s: 35)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Hợp đồng trả góp lỗi"
        self.view.backgroundColor = UIColor.white
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            mCallLogApiManager.TypeId_227_GetDetail(RequestId: "\(self.callLog?.RequestID ?? 0)") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs != nil {
                            self.listChiTietLoi = rs?.listChiTietLoi ?? []
                            self.setUpView(item: rs!)
                        } else {
                            self.setUpView(item: DetailFEC_227(HoTenKH: "", NgayTao: "", NgayXuatHoaDon: "", NhanVienLamHoSo: "", NoiDung: "", SoDonHang: "", SoHopDong: "", SoTien: "", TenSanPham: "", TenShop: "", TrangThaiCallLog: "", Id: 0, listChiTietLoi: []))
                        }
                        
                    } else {
                        
                    }
                }
            }
        }
    }
    
    func setUpView(item: DetailFEC_227) {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let lbCalllogID = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: (scrollView.frame.width - Common.Size(s: 30))/2, height: Common.Size(s: 20)))
        lbCalllogID.text = "Mã calllog: \(callLog?.RequestID ?? 0)"
        lbCalllogID.font = UIFont.boldSystemFont(ofSize: 15)
        lbCalllogID.textColor = UIColor(netHex: 0x00cc99)
        scrollView.addSubview(lbCalllogID)
        
        let lbCreateDate = UILabel(frame: CGRect(x: lbCalllogID.frame.origin.x + lbCalllogID.frame.width, y: 0, width: lbCalllogID.frame.width, height: Common.Size(s: 20)))
        lbCreateDate.text = "\(callLog?.CreateDateTime ?? "\(item.NgayTao)")"
        lbCreateDate.textAlignment = .right
        lbCreateDate.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbCreateDate)
        
        let line = UIView(frame: CGRect(x: 0, y: lbCreateDate.frame.origin.y + lbCreateDate.frame.height + Common.Size(s: 5), width: scrollView.frame.width, height: 1))
        line.backgroundColor = .lightGray
        scrollView.addSubview(line)
        
        lbNoiDung = WKWebView(frame: CGRect(x: Common.Size(s: 10), y: line.frame.origin.y + line.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 20), height: Common.Size(s: 20)))
        lbNoiDung.loadHTMLString("\(item.NoiDung)", baseURL: nil)
        lbNoiDung.navigationDelegate = self
        scrollView.addSubview(lbNoiDung)
        
        viewUnderWebView = UIView(frame: CGRect(x: 0, y: lbNoiDung.frame.origin.y + lbNoiDung.frame.height + Common.Size(s: 10), width: scrollView.frame.width, height: Common.Size(s: 20)))
        viewUnderWebView.backgroundColor = .white
        scrollView.addSubview(viewUnderWebView)
        
        let lbShopName = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: (viewUnderWebView.frame.width - Common.Size(s: 30))/3 + Common.Size(s: 5), height: Common.Size(s: 20)))
        lbShopName.text = "Tên shop:"
        lbShopName.font = UIFont.systemFont(ofSize: 14)
        viewUnderWebView.addSubview(lbShopName)
        
        let lbShopNameText = UILabel(frame: CGRect(x: lbShopName.frame.origin.x + lbShopName.frame.width, y: lbShopName.frame.origin.y, width: (viewUnderWebView.frame.width - Common.Size(s: 30)) * 2/3, height: Common.Size(s: 20)))
        lbShopNameText.text = "\(item.TenShop)"
        lbShopNameText.font = UIFont.systemFont(ofSize: 14)
        viewUnderWebView.addSubview(lbShopNameText)
        
        lbShopNameText.numberOfLines = 0
        let lbShopNameTextHeight:CGFloat = lbShopNameText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbShopNameText.optimalHeight
        lbShopNameText.frame = CGRect(x: lbShopNameText.frame.origin.x, y: lbShopNameText.frame.origin.y, width: lbShopNameText.frame.width, height: lbShopNameTextHeight)
        
        let lbNV = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbShopNameText.frame.origin.y + lbShopNameTextHeight + Common.Size(s: 5), width: lbShopName.frame.width, height: Common.Size(s: 20)))
        lbNV.text = "NV làm hồ sơ:"
        lbNV.font = UIFont.systemFont(ofSize: 14)
        viewUnderWebView.addSubview(lbNV)
        
        let lbNVText = UILabel(frame: CGRect(x: lbShopNameText.frame.origin.x, y: lbNV.frame.origin.y, width: lbShopNameText.frame.width, height: Common.Size(s: 20)))
        lbNVText.text = "\(item.NhanVienLamHoSo)"
        lbNVText.font = UIFont.systemFont(ofSize: 14)
        viewUnderWebView.addSubview(lbNVText)
        
        lbNVText.numberOfLines = 0
        let lbNVTextHeight:CGFloat = lbNVText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbNVText.optimalHeight
        lbNVText.frame = CGRect(x: lbNVText.frame.origin.x, y: lbNVText.frame.origin.y, width: lbNVText.frame.width, height: lbNVTextHeight)
        
        let lbSoHD = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNVText.frame.origin.y + lbNVTextHeight + Common.Size(s: 5), width: lbShopName.frame.width, height: Common.Size(s: 20)))
        lbSoHD.text = "Số HĐ:"
        lbSoHD.font = UIFont.systemFont(ofSize: 14)
        viewUnderWebView.addSubview(lbSoHD)
        
        let lbSoHDText = UILabel(frame: CGRect(x: lbShopNameText.frame.origin.x, y: lbSoHD.frame.origin.y, width: lbShopNameText.frame.width, height: Common.Size(s: 20)))
        lbSoHDText.text = "\(item.SoHopDong)"
        lbSoHDText.font = UIFont.systemFont(ofSize: 14)
        viewUnderWebView.addSubview(lbSoHDText)
        
        let lbSoSO = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSoHDText.frame.origin.y + lbSoHDText.frame.height + Common.Size(s: 5), width: lbShopName.frame.width, height: Common.Size(s: 20)))
        lbSoSO.text = "Số SO:"
        lbSoSO.font = UIFont.systemFont(ofSize: 14)
        viewUnderWebView.addSubview(lbSoSO)

        let lbSoSOText = UILabel(frame: CGRect(x: lbShopNameText.frame.origin.x, y: lbSoSO.frame.origin.y, width: lbShopNameText.frame.width, height: Common.Size(s: 20)))
        lbSoSOText.text = "\(item.SoDonHang)"
        lbSoSOText.font = UIFont.systemFont(ofSize: 14)
        viewUnderWebView.addSubview(lbSoSOText)

        let lbNgayXuatSO = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSoSOText.frame.origin.y + lbSoSOText.frame.height + Common.Size(s: 5), width: lbShopName.frame.width, height: Common.Size(s: 20)))
        lbNgayXuatSO.text = "Ngày xuất SO:"
        lbNgayXuatSO.font = UIFont.systemFont(ofSize: 14)
        viewUnderWebView.addSubview(lbNgayXuatSO)

        let lbNgayXuatSOText = UILabel(frame: CGRect(x: lbShopNameText.frame.origin.x, y: lbNgayXuatSO.frame.origin.y, width: lbShopNameText.frame.width, height: Common.Size(s: 20)))
        lbNgayXuatSOText.text = "\(item.NgayXuatHoaDon)"
        lbNgayXuatSOText.font = UIFont.systemFont(ofSize: 14)
        viewUnderWebView.addSubview(lbNgayXuatSOText)

        let lbKHName = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNgayXuatSOText.frame.origin.y + lbNgayXuatSOText.frame.height + Common.Size(s: 5), width: lbShopName.frame.width, height: Common.Size(s: 20)))
        lbKHName.text = "Họ tên KH:"
        lbKHName.font = UIFont.systemFont(ofSize: 14)
        viewUnderWebView.addSubview(lbKHName)

        let lbKHNameText = UILabel(frame: CGRect(x: lbShopNameText.frame.origin.x, y: lbKHName.frame.origin.y, width: lbShopNameText.frame.width, height: Common.Size(s: 20)))
        lbKHNameText.text = "\(item.HoTenKH)"
        lbKHNameText.font = UIFont.systemFont(ofSize: 14)
        viewUnderWebView.addSubview(lbKHNameText)

        lbKHNameText.numberOfLines = 0
        let lbKHNameTextHeight:CGFloat = lbKHNameText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbKHNameText.optimalHeight
        lbKHNameText.frame = CGRect(x: lbKHNameText.frame.origin.x, y: lbKHNameText.frame.origin.y, width: lbKHNameText.frame.width, height: lbKHNameTextHeight)

        let lbTenSP = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbKHNameText.frame.origin.y + lbKHNameTextHeight + Common.Size(s: 5), width: lbShopName.frame.width, height: Common.Size(s: 20)))
        lbTenSP.text = "Tên sản phẩm:"
        lbTenSP.font = UIFont.systemFont(ofSize: 14)
        viewUnderWebView.addSubview(lbTenSP)

        let lbTenSPText = UILabel(frame: CGRect(x: lbShopNameText.frame.origin.x, y: lbTenSP.frame.origin.y, width: lbShopNameText.frame.width, height: Common.Size(s: 20)))
        lbTenSPText.text = "\(item.TenSanPham)"
        lbTenSPText.font = UIFont.systemFont(ofSize: 14)
        viewUnderWebView.addSubview(lbTenSPText)

        lbTenSPText.numberOfLines = 0
        let lbTenSPTextHeight:CGFloat = lbTenSPText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbTenSPText.optimalHeight
        lbTenSPText.frame = CGRect(x: lbTenSPText.frame.origin.x, y: lbTenSPText.frame.origin.y, width: lbTenSPText.frame.width, height: lbTenSPTextHeight)

        let lbSoTien = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTenSPText.frame.origin.y + lbTenSPTextHeight + Common.Size(s: 5), width: lbShopName.frame.width, height: Common.Size(s: 20)))
        lbSoTien.text = "Số tiền SO:"
        lbSoTien.font = UIFont.systemFont(ofSize: 14)
        viewUnderWebView.addSubview(lbSoTien)

        let lbSoTienText = UILabel(frame: CGRect(x: lbShopNameText.frame.origin.x, y: lbSoTien.frame.origin.y, width: lbShopNameText.frame.width, height: Common.Size(s: 20)))
        lbSoTienText.text = "\(item.SoTien)"
        lbSoTienText.font = UIFont.systemFont(ofSize: 14)
        viewUnderWebView.addSubview(lbSoTienText)

        let lbTrangThaiCalllog = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSoTienText.frame.origin.y + lbSoTienText.frame.height + Common.Size(s: 5), width: lbShopName.frame.width, height: Common.Size(s: 20)))
        lbTrangThaiCalllog.text = "Trạng thái calllog:"
        lbTrangThaiCalllog.font = UIFont.systemFont(ofSize: 14)
        viewUnderWebView.addSubview(lbTrangThaiCalllog)

        let lbTrangThaiCalllogText = UILabel(frame: CGRect(x: lbShopNameText.frame.origin.x, y: lbTrangThaiCalllog.frame.origin.y, width: lbShopNameText.frame.width, height: Common.Size(s: 20)))
        lbTrangThaiCalllogText.text = "\(item.TrangThaiCallLog)"
        lbTrangThaiCalllogText.font = UIFont.systemFont(ofSize: 14)
        viewUnderWebView.addSubview(lbTrangThaiCalllogText)

        let boSungView = UIView(frame: CGRect(x: Common.Size(s: 15), y: lbTrangThaiCalllogText.frame.origin.y + lbTrangThaiCalllogText.frame.height + Common.Size(s: 10), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 30)))
        boSungView.backgroundColor = UIColor(netHex: 0xe0e0eb)
        viewUnderWebView.addSubview(boSungView)

        let lbBoSung = UILabel(frame: CGRect(x: Common.Size(s: 10), y: 0, width: boSungView.frame.width - Common.Size(s: 20), height:boSungView.frame.height))
        lbBoSung.text = "THÔNG TIN CẦN BỔ SUNG"
        lbBoSung.font = UIFont.boldSystemFont(ofSize: 15)
        boSungView.addSubview(lbBoSung)

        tableView = UITableView(frame: CGRect(x: Common.Size(s: 15), y: boSungView.frame.origin.y + boSungView.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: scrollView.frame.height - (boSungView.frame.origin.y + boSungView.frame.height)))
        tableView.register(HDFECCell.self, forCellReuseIdentifier: "fecCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        viewUnderWebView.addSubview(tableView)
        
        tableView.frame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.width, height: CGFloat((self.listChiTietLoi.count + 1)) * cellHeight)

        viewUnderWebView.frame = CGRect(x: viewUnderWebView.frame.origin.x, y: viewUnderWebView.frame.origin.y, width: viewUnderWebView.frame.width, height: tableView.frame.origin.y + tableView.frame.height)

        scrollViewHeight = viewUnderWebView.frame.origin.y + viewUnderWebView.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)

    }
}
extension HopDongFECViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.listChiTietLoi.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HDFECCell = tableView.dequeueReusableCell(withIdentifier: "fecCell", for: indexPath) as! HDFECCell
        
        
        if indexPath.row == 0 {
            let item = ChiTietLoi_227(ChiTietLoi: "", NgayGhiNhanLoi: "", STT: 0)
            cell.setUpCell(item: item, isTitle: true)
            
            cell.lbSTT.text = "STT"
            cell.lbSTT.textColor = .white
            cell.lbSTT.font = UIFont.boldSystemFont(ofSize: 13)
            
            cell.lbNgayLoi.text = "Ngày ghi nhận lỗi"
            cell.lbNgayLoi.textColor = .white
            cell.lbNgayLoi.font = UIFont.boldSystemFont(ofSize: 13)
            
            cell.lbBoSungInfo.text = "Thông tin bổ sung"
            cell.lbBoSungInfo.textColor = .white
            cell.lbBoSungInfo.font = UIFont.boldSystemFont(ofSize: 13)
            cell.lbBoSungInfo.textAlignment = .center
            cell.viewContent.backgroundColor = UIColor(netHex: 0x39ac39)
            
        } else {
            let item = listChiTietLoi[indexPath.row - 1]
            cell.setUpCell(item: item, isTitle: false)
            cell.viewContent.backgroundColor = .white
            self.cellHeight = cell.estimateCellHeight
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return Common.Size(s: 35)
        } else {
            return cellHeight
        }
    }
}

class HDFECCell: UITableViewCell {
    var lbSTT: UILabel!
    var lbNgayLoi: UILabel!
    var lbBoSungInfo: UILabel!
    var viewContent: UIView!
    var estimateCellHeight:CGFloat = 0
    
    func setUpCell(item: ChiTietLoi_227, isTitle: Bool) {
        self.subviews.forEach({$0.removeFromSuperview()})
        
        viewContent = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        self.addSubview(viewContent)
        
        lbSTT = UILabel(frame: CGRect(x: 0, y: 0, width: Common.Size(s: 40), height: viewContent.frame.height))
        lbSTT.text = "\(item.STT)"
        lbSTT.textAlignment = .center
        lbSTT.textColor = .black
        lbSTT.layer.borderColor = UIColor(netHex: 0x39ac39).cgColor
        lbSTT.layer.borderWidth = 1
        lbSTT.numberOfLines = 2
        lbSTT.font = UIFont.systemFont(ofSize: 13)
        viewContent.addSubview(lbSTT)
        
        lbNgayLoi = UILabel(frame: CGRect(x: lbSTT.frame.origin.x + lbSTT.frame.width, y: 0, width: Common.Size(s: 75), height: viewContent.frame.height))
        lbNgayLoi.text = "\(item.NgayGhiNhanLoi)"
        lbNgayLoi.textAlignment = .center
        lbNgayLoi.textColor = .black
        lbNgayLoi.layer.borderColor = UIColor(netHex: 0x39ac39).cgColor
        lbNgayLoi.layer.borderWidth = 1
        lbNgayLoi.numberOfLines = 2
        lbNgayLoi.font = UIFont.systemFont(ofSize: 13)
        viewContent.addSubview(lbNgayLoi)
        
        let viewThongTinBS = UIView(frame: CGRect(x: lbNgayLoi.frame.origin.x + lbNgayLoi.frame.width, y: 0, width: viewContent.frame.width - (lbNgayLoi.frame.origin.x + lbNgayLoi.frame.width), height: viewContent.frame.height))
        viewThongTinBS.layer.borderColor = UIColor(netHex: 0x39ac39).cgColor
        viewThongTinBS.layer.borderWidth = 1
        viewContent.addSubview(viewThongTinBS)
        
        lbBoSungInfo = UILabel(frame: CGRect(x: Common.Size(s: 5), y: 0, width: viewThongTinBS.frame.width - Common.Size(s: 10), height: viewThongTinBS.frame.height))
        lbBoSungInfo.text = "\(item.ChiTietLoi)"
        lbBoSungInfo.textAlignment = .left
        lbBoSungInfo.textColor = .black
        lbBoSungInfo.numberOfLines = 2
        lbBoSungInfo.font = UIFont.systemFont(ofSize: 13)
        viewThongTinBS.addSubview(lbBoSungInfo)
        
        if !isTitle {
            let lbBoSungInfoHeight: CGFloat = lbBoSungInfo.optimalHeight < Common.Size(s: 30) ? Common.Size(s: 30) : lbBoSungInfo.optimalHeight
            lbBoSungInfo.numberOfLines = 0
            lbBoSungInfo.frame = CGRect(x: lbBoSungInfo.frame.origin.x, y: lbBoSungInfo.frame.origin.y, width: lbBoSungInfo.frame.width, height: lbBoSungInfoHeight + Common.Size(s: 10))
            
            viewThongTinBS.frame = CGRect(x: viewThongTinBS.frame.origin.x, y: viewThongTinBS.frame.origin.y, width: viewThongTinBS.frame.width, height: lbBoSungInfo.frame.origin.y + lbBoSungInfo.frame.height)
            //STT
            lbSTT.numberOfLines = 0
            lbSTT.frame = CGRect(x: lbSTT.frame.origin.x, y: lbSTT.frame.origin.y, width: lbSTT.frame.width, height: lbBoSungInfo.frame.height)
            
            //lbNgayLoi
            lbNgayLoi.numberOfLines = 0
            lbNgayLoi.frame = CGRect(x: lbNgayLoi.frame.origin.x, y: lbNgayLoi.frame.origin.y, width: lbNgayLoi.frame.width, height: lbBoSungInfo.frame.height)
            
            //viewContent
            viewContent.frame = CGRect(x: viewContent.frame.origin.x, y: viewContent.frame.origin.y, width: viewContent.frame.width, height: viewThongTinBS.frame.height)
            estimateCellHeight = viewContent.frame.origin.y + viewContent.frame.height
        }
    }
}

extension HopDongFECViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.frame.size.height = 1
        webView.frame.size = webView.sizeThatFits(CGSize.zero)
       
       tableView.frame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.width, height: CGFloat((self.listChiTietLoi.count + 1)) * cellHeight)
       
       viewUnderWebView.frame = CGRect(x: viewUnderWebView.frame.origin.x, y: lbNoiDung.frame.origin.y + lbNoiDung.frame.height + Common.Size(s: 10), width: viewUnderWebView.frame.width, height: tableView.frame.origin.y + tableView.frame.height)

       scrollViewHeight = viewUnderWebView.frame.origin.y + viewUnderWebView.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 30)
       scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
}
