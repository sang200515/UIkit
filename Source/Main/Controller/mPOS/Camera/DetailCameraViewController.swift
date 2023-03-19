//
//  DetailCameraViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 5/14/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class DetailCameraViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    var tableView: UITableView  =   UITableView()
    var items: [CameraDetail] = []
    var cameraShop:CameraShop!
    var collectionView: UICollectionView!
    
    var cellWidth: CGFloat = 0
    var coCellWidth: CGFloat = 0
    var coCellHeight: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationBar()
        self.title = "\(cameraShop.WarehouseName)"
        self.view.backgroundColor = .white
        cellWidth = self.view.frame.size.width
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(DetailCameraViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        //---
        let viewRightNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: viewRightNav)
        let btPlaybackIcon = UIButton.init(type: .custom)
        btPlaybackIcon.setImage(#imageLiteral(resourceName: "ic_camera"), for: UIControl.State.normal)
        btPlaybackIcon.imageView?.contentMode = .scaleAspectFit
        btPlaybackIcon.addTarget(self, action: #selector(DetailCameraViewController.actionPlayback), for: UIControl.Event.touchUpInside)
        btPlaybackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewRightNav.addSubview(btPlaybackIcon)
        //---
        
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
        
        collectionView.register(ItemCameraCollectionViewCell.self, forCellWithReuseIdentifier: "ItemCameraCollectionViewCell")
        self.view.addSubview(collectionView)
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang tải danh sách camera..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.sp_mpos_FRT_SP_Camera_getLinkDetail_online(MaShop: "\(cameraShop.WarehouseCode)", handler: { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                self.items = results
                self.collectionView.reloadData()
            }
        })
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let coCell: ItemCameraCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCameraCollectionViewCell", for: indexPath) as! ItemCameraCollectionViewCell
        
        let item = items[indexPath.item]
        coCell.setUpCollectionViewCell(item: item)
        coCell.layer.borderWidth = 0.5
        coCell.layer.borderColor = UIColor(netHex: 0xEEEEEE).cgColor
        return coCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let vc = LiveCameraViewControllerV2()
        vc.cameraDetail = item
        self.navigationController?.pushViewController(vc, animated: true)
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
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func actionPlayback() {
        let vc = PlaybackCameraViewController()
        vc.ShopCode = "\(cameraShop.WarehouseCode)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
class ItemCameraCollectionViewCell: UICollectionViewCell {
    
    var icon: UIImageView!
    var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setUpCollectionViewCell(item: CameraDetail) {
        contentView.subviews.forEach({ $0.removeFromSuperview() })
        contentView.backgroundColor = UIColor.white
        icon = UIImageView()
        icon = UIImageView(frame: CGRect(x: contentView.frame.width/2 - (contentView.frame.height/2 - Common.Size(s: 10))/2, y: contentView.frame.height/2 - (contentView.frame.height/2 + Common.Size(s: 20))/2, width: contentView.frame.height/2 - Common.Size(s: 10), height: contentView.frame.height/2))
        icon.image = UIImage(named: "ItemCamera")
        icon.contentMode = .scaleAspectFit
        itemLabel = UILabel(frame: CGRect(x: 0, y: icon.frame.origin.y + icon.frame.size.height, width: self.contentView.frame.width, height: Common.Size(s: 20)))
        itemLabel.text = item.TenCamera
        itemLabel.textAlignment = .center
        itemLabel.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        itemLabel.textColor = UIColor(netHex: 0x6C6B6B)
        contentView.addSubview(icon)
        contentView.addSubview(itemLabel)
    }
    
}
