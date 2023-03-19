//
//  Top10BanTinViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 3/26/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class Top10BanTinViewController: UIViewController {

    var tableView: UITableView!
    var itemLoaiTin: LoaiTinItem?
    var listFileInclude = [Include_Tintuc]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "\(itemLoaiTin?.nameLoaiTin ?? "Bản Tin")"
        self.view.backgroundColor = .white
        self.tabBarController?.tabBar.isHidden = true
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        initTableView()
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name.init("reload-top3-news"), object: nil)
    }
    
    func initTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - (UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.height)))
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
}

extension Top10BanTinViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if itemLoaiTin != nil {
            if itemLoaiTin!.listSummary.count < 10 {
                return itemLoaiTin!.listSummary.count
            } else {
               return 10
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        let itemSumary = itemLoaiTin?.listSummary[indexPath.row]
        cell.setUpCell(item: itemSumary ?? Sumary_TinTuc(id: "", title: "", created: "", field_description: "", body_processed: "", imgChuDe: "", imgBanner: ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemSumary = itemLoaiTin?.listSummary[indexPath.row] ?? Sumary_TinTuc(id: "", title: "", created: "", field_description: "", body_processed: "", imgChuDe: "", imgBanner: "")
        let vc = NewsDetailViewController()
        vc.newsID = itemSumary.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Common.Size(s: 100)
    }
}
