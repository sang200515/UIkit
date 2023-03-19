//
//  HistoryNopQuyNHViewController.swift
//  fptshop
//
//  Created by Apple on 7/10/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HistoryNopQuyNHViewController: UIViewController {
    
    var tableView: UITableView!
    var listDetailCalllogsNopQuy:[DetailsCallLogNopQuyItem] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.PaymentOfFunds_GetList(handler: { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if results.count > 0 {
                        self.listDetailCalllogsNopQuy = results
                    } else {
                        debugPrint("không có ds lich sử")
                    }
                    if self.tableView != nil {
                        self.tableView.reloadData()
                    } else {
                        self.initTableView()
                    }
                }
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Lịch sử nộp quỹ"
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)

        self.initTableView()
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.PaymentOfFunds_GetList(handler: { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if results.count > 0 {
                        self.listDetailCalllogsNopQuy = results
                    } else {
                        debugPrint("không có ds lich sử")
                    }
                    self.tableView.reloadData()
                }
            })
        }
        
    }
    
    func initTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
        self.view.addSubview(tableView)
        tableView.register(HistoryNopQuyNHCell.self, forCellReuseIdentifier: "historyNopQuyNHCell")
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension HistoryNopQuyNHViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDetailCalllogsNopQuy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HistoryNopQuyNHCell = tableView.dequeueReusableCell(withIdentifier: "historyNopQuyNHCell", for: indexPath) as! HistoryNopQuyNHCell
        let item = self.listDetailCalllogsNopQuy[indexPath.row]
        cell.setUpCell(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.listDetailCalllogsNopQuy[indexPath.row]
        let newVC = DetailNopTienViewController()
        newVC.item = item
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

class HistoryNopQuyNHCell: UITableViewCell {
    var lbTrangThaiText: UILabel!
    
    func setUpCell(item:DetailsCallLogNopQuyItem) {
        self.subviews.forEach({$0.removeFromSuperview()})
        
        let lbTitle = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: self.frame.width/2, height: Common.Size(s: 20)))
        lbTitle.text = "Số calllog: \(item.RequestId)"
        lbTitle.font = UIFont.boldSystemFont(ofSize: 15)
        lbTitle.textColor = UIColor(red: 38/255, green: 150/255, blue: 84/255, alpha: 1)
        self.addSubview(lbTitle)
        
        let lbHeaderDate = UILabel(frame: CGRect(x: lbTitle.frame.origin.x + lbTitle.frame.width + Common.Size(s: 5), y: lbTitle.frame.origin.y, width: self.frame.width - lbTitle.frame.width - Common.Size(s: 35), height: Common.Size(s: 20)))
        lbHeaderDate.text = "\(item.UpdateDate)"
        lbHeaderDate.font = UIFont.systemFont(ofSize: 14)
        lbHeaderDate.textAlignment = .right
        self.addSubview(lbHeaderDate)
        
        let line = UIView(frame: CGRect(x: Common.Size(s: 15), y: lbTitle.frame.origin.y + lbTitle.frame.height + Common.Size(s: 5), width: self.frame.width - Common.Size(s: 30), height: Common.Size(s: 1)))
        line.backgroundColor = UIColor.darkGray
        self.addSubview(line)
        
        let lbNgay = UILabel(frame: CGRect(x: Common.Size(s: 15), y: line.frame.origin.y + line.frame.height + Common.Size(s: 5), width: self.frame.width/3 - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbNgay.text = "Ngày:"
        lbNgay.font = UIFont.systemFont(ofSize: 14)
        lbNgay.textColor = UIColor.lightGray
        self.addSubview(lbNgay)
        
        let lbNgayText = UILabel(frame: CGRect(x: lbNgay.frame.origin.x + lbNgay.frame.width + Common.Size(s: 5), y: lbNgay.frame.origin.y, width: self.frame.width - lbNgay.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbNgayText.text = "\(item.Date)"
        lbNgayText.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbNgayText)
        
        let lbTienQuy = UILabel(frame: CGRect(x: lbNgay.frame.origin.x, y: lbNgayText.frame.origin.y + lbNgayText.frame.height + Common.Size(s: 5), width: lbNgay.frame.width, height: Common.Size(s: 20)))
        lbTienQuy.text = "Tiền quỹ:"
        lbTienQuy.font = UIFont.systemFont(ofSize: 14)
        lbTienQuy.textColor = UIColor.lightGray
        self.addSubview(lbTienQuy)
        
        let lbTienQuyText = UILabel(frame: CGRect(x: lbNgayText.frame.origin.x, y: lbTienQuy.frame.origin.y, width: lbNgayText.frame.width, height: Common.Size(s: 20)))
        lbTienQuyText.text = "\(item.Money)"
        lbTienQuyText.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbTienQuyText)
        
        let lbTrangThai = UILabel(frame: CGRect(x: lbNgay.frame.origin.x, y: lbTienQuyText.frame.origin.y + lbTienQuyText.frame.height + Common.Size(s: 5), width: lbNgay.frame.width, height: Common.Size(s: 20)))
        lbTrangThai.text = "Trạng thái:"
        lbTrangThai.font = UIFont.systemFont(ofSize: 14)
        lbTrangThai.textColor = UIColor.lightGray
        self.addSubview(lbTrangThai)
        
        lbTrangThaiText = UILabel(frame: CGRect(x: lbNgayText.frame.origin.x, y: lbTrangThai.frame.origin.y, width: lbNgayText.frame.width, height: Common.Size(s: 20)))
        lbTrangThaiText.text = "\(item.Status)"
        lbTrangThaiText.font = UIFont.boldSystemFont(ofSize: 14)
        lbTrangThaiText.textColor = UIColor(red: 192/255, green: 0/255, blue: 0/255, alpha: 1)
        self.addSubview(lbTrangThaiText)
    }
}
