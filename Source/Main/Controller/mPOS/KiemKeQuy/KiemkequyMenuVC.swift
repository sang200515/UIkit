//
//  KiemkequyMenuVC.swift
//  fptshop
//
//  Created by Ngoc Bao on 06/09/2021.
//  Copyright © 2021 Duong Hoang Minh. All rights reserved.
//

import UIKit
import PopupDialog

class KiemkequyMenuVC: UIViewController {

    private var items = [ItemApp]()
    
    private var collectionView: UICollectionView!
    
    private var cellWidth: CGFloat = 0
    private var coCellWidth: CGFloat = 0
    private var coCellHeight: CGFloat = 0
    var rsViettelVAS_MainInfo = [ViettelVASInfo]()
    var shopItem: ItemShop = ItemShop(code: Cache.user!.ShopCode, name: Cache.user!.ShopName)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "KIỂM KÊ QUỸ"
        self.navigationItem.setHidesBackButton(true, animated:true)
        configureNavigationItem()
        configureUI()
    }
    
    
    @objc func handleBack(){
        navigationController?.popViewController(animated: true)
    }
    
    func configureNavigationItem(){
        //left menu icon
        let btLeftIcon = Common.initBackButton()
        btLeftIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
    }
    func configureUI(){
        view.backgroundColor = .white
        cellWidth = self.view.frame.size.width
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
        layout.itemSize = CGSize(width: 111, height: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ItemSessionCollectionViewCell.self, forCellWithReuseIdentifier: "ItemSessionCollectionViewCell")
        self.view.addSubview(collectionView)
        

        let crmItem1 = ItemApp(id: "1", name: "Kiểm kê quỹ", type: "91", icon: #imageLiteral(resourceName: "home_menu_kk"))
        items.append(crmItem1)
        let crmItem2 = ItemApp(id: "2", name: "Lịch sử kiểm kê", type: "92", icon: #imageLiteral(resourceName: "history_kk"))
        items.append(crmItem2)

        collectionView.reloadData()
    }
}

extension KiemkequyMenuVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let coCell: ItemSessionCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemSessionCollectionViewCell", for: indexPath) as! ItemSessionCollectionViewCell
        
        let item = items[indexPath.item]
        coCell.setUpCollectionViewCell(item: item)
        coCell.layer.borderWidth = 0.5
        coCell.layer.borderColor = UIColor(netHex: 0xEEEEEE).cgColor
        return coCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var check = false
        let item = items[indexPath.row]
        for ruleItem in Cache.ruleMenus {
            if ruleItem.p_messagess == item.type {
                check = true
                break
            }
        }
        if check {
            if(item.id == "1"){
                let vc = KiemKeMenuDetailVC()
                vc.shopItem = self.shopItem
                self.navigationController?.pushViewController(vc, animated: true)
            }else if(item.id == "2"){
                let vc = HistoryKiemkeVC()
                vc.shop = self.shopItem
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            let popup = PopupDialog(title: "Thông báo", message: "Bạn không được cấp quyền sử dụng chức năng này. Vui lòng kiểm tra lại.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {}
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        coCellWidth = cellWidth/3.0
        coCellHeight = coCellWidth * 0.7
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
