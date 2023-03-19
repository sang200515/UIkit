//
//  VietjetBookingMenuViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 04/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetBookingMenuViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var cellWidth: CGFloat = 0
    var coCellWidth: CGFloat = 0
    var coCellHeight: CGFloat = 0
    var collectionViewHeightConstraint = NSLayoutConstraint()
    var flightList: [ItemAppThuHoService] = []
    
    var btnBack: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Vé máy bay Vietjet"
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btnBack = UIBarButtonItem(customView: btBackIcon)
        self.navigationItem.leftBarButtonItems = [btnBack]
        
        initData()
        cellWidth = self.view.frame.width
        self.setUpCollectionView()
    }
    
    func initData() {
        let vietjet = ItemAppThuHoService(id: "0", name: "Bán vé", type: "0", icon: #imageLiteral(resourceName: "vietjet_logo"), item: ThuHoService(PaymentBillServiceName: "Bán vé", ListProvider: []))
        let info = ItemAppThuHoService(id: "1", name: "Thay đổi thông tin", type: "1", icon: UIImage(named: "edit_ic")!, item: ThuHoService(PaymentBillServiceName: "Thay đổi thông tin", ListProvider: []))
        let service = ItemAppThuHoService(id: "2", name: "Dịch vụ", type: "2", icon: UIImage(named: "service_ic")!, item: ThuHoService(PaymentBillServiceName: "Dịch vụ", ListProvider: []))
        let history = ItemAppThuHoService(id: "3", name: "Lịch sử Vietjet", type: "1", icon: UIImage(named: "history_ic")!, item: ThuHoService(PaymentBillServiceName: "Lịch sử Vietjet", ListProvider: []))
        flightList.append(vietjet)
        flightList.append(info)
        flightList.append(service)
        flightList.append(history)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
        layout.itemSize = CGSize(width: 111, height: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.height ?? 0)), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        
        collectionView.register(ItemSessionCollectionViewCell.self, forCellWithReuseIdentifier: "ItemSessionCollectionViewCell")
        self.view.addSubview(collectionView)
    }
}

extension VietjetBookingMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flightList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let coCell: ItemSessionCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemSessionCollectionViewCell", for: indexPath) as! ItemSessionCollectionViewCell
        let item = flightList[indexPath.row]
        coCell.setUpCollectionViewCellThuHoService(item: item)
        
        coCell.layer.borderWidth = 0.5
        coCell.layer.borderColor = UIColor(netHex: 0xEEEEEE).cgColor
        return coCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = flightList[indexPath.row]
        
        if item.name == "Bán vé" {
            let vc = BookingVietjetFlightViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if item.name == "Thay đổi thông tin" {
            let vc = CheckBookingViewController()
            VietjetDataManager.shared.isChangeFlight = true
            self.navigationController?.pushViewController(vc, animated: true)
        } else if item.name == "Dịch vụ" {
            let vc = CheckBookingViewController()
            VietjetDataManager.shared.isAddon = true
            self.navigationController?.pushViewController(vc, animated: true)
        } else if item.name == "Lịch sử Vietjet" {
            let vc = VietjetPaymentHistoryViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        coCellWidth = cellWidth/3.0
        coCellHeight = (coCellWidth * 0.7)/2 + Common.Size(s: 40)
        let size = CGSize(width: coCellWidth, height: coCellHeight)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
