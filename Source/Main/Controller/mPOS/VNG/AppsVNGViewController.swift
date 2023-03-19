//
//  AppsVNGViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/18/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class AppsVNGViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var so:VinaGame_LoadDSDonHang?
    
    var collectionview: UICollectionView!
    var items: [ItemAppVNG] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationBar()
        self.title = "Cài đặt ứng dụng"
        self.view.backgroundColor = .white
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(AppsVNGViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        let viewFooter = UIView(frame: CGRect(x: 0, y: self.view.frame.height -  (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height) * 3, width: self.view.frame.width, height: (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height) * 2))
        self.view.addSubview(viewFooter)
        //        viewFooter.backgroundColor = .red
        
        let btPay = UIButton()
        btPay.frame = CGRect(x: Common.Size(s: 20), y: viewFooter.frame.size.height/2 - (viewFooter.frame.size.height * 2/5)/2, width: viewFooter.frame.size.width - Common.Size(s: 40), height: viewFooter.frame.size.height * 2/5)
        btPay.backgroundColor = UIColor(netHex:0x00955E)
        btPay.setTitle("HOÀN TẤT", for: .normal)
        btPay.addTarget(self, action: #selector(actionCheckKMVC), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        viewFooter.addSubview(btPay)
        
        let item1 = ItemAppVNG(id: "1", name: "Zing MP3", isSelect: false , icon: #imageLiteral(resourceName: "zingmp3"))
        let item2 = ItemAppVNG(id: "2", name: "Báo mới", isSelect: false, icon: #imageLiteral(resourceName: "baomoi"))
        let item3 = ItemAppVNG(id: "3", name: "Laban Key", isSelect: false, icon: #imageLiteral(resourceName: "labankey"))
        let item4 = ItemAppVNG(id: "4", name: "Zalo",  isSelect: false, icon: #imageLiteral(resourceName: "zalo"))
        items.append(item1)
        items.append(item2)
        items.append(item3)
        items.append(item4)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: Common.Size(s:5), left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
        
        layout.itemSize = CGSize(width: (self.view.frame.size.width - Common.Size(s:10))/2, height: (self.view.frame.size.width - Common.Size(s:10))/2)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0
        
        collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: viewFooter.frame.origin.y), collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(ItemAppVNGCell.self, forCellWithReuseIdentifier: "ItemAppVNGCell")
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = UIColor.white
        self.view.addSubview(collectionview)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "ItemAppVNGCell", for: indexPath) as! ItemAppVNGCell
        let item: ItemAppVNG = self.items[indexPath.row]
        cell.setup(item: item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item: ItemAppVNG = self.items[indexPath.row]
        self.items[indexPath.row].isSelect = !item.isSelect
        self.collectionview.reloadData()
    }
    @objc func actionCheckKMVC(sender: UIButton!){
        var isCheck: Bool = false
        var list: String = ""
        for item in self.items {
            if(item.isSelect){
                isCheck = true
                if(list == ""){
                    list = "\(item.id)"
                }else{
                    list = "\(list),\(item.id)"
                }
            }
        }
        if(isCheck){
            let popup = PopupDialog(title: "THÔNG BÁO", message: "Bạn có chắc chắn cài đặt ứng dụng của VNG không? \(list)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "Có") {
                
                let newViewController = LoadingViewController()
                newViewController.content = "Đang kiểm tra thông tin..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                MPOSAPIManager.VinaGame_InsertInstallapp(UserID: "\(Cache.user!.UserName)", MaShop: "\(Cache.user!.ShopCode)", Listapp: list, SoMPOS: "\(self.so!.SOMPOS)", SOPOS: "\(self.so!.SO_POS)", IMeI: "\(self.so!.U_Imei)", Status: "1", handler: { (result, message, error) in
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        if(error.count <= 0){
                            let popup = PopupDialog(title: "THÔNG BÁO", message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                _ = self.navigationController?.popViewController(animated: true)
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                            
                        }else{
                            let popup = PopupDialog(title: "THÔNG BÁO", message: error, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                        
                    }
                    
                })
            }
            let buttonTow = DestructiveButton(title: "Không") {
            }
            popup.addButtons([buttonTow,buttonOne])
            self.present(popup, animated: true, completion: nil)
        }else{
            let popup = PopupDialog(title: "THÔNG BÁO", message: "Bạn phải cài ít nhất 1 ứng dụng.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
        }
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
class ItemAppVNGCell: UICollectionViewCell {
    var iconImage:UIImageView!
    var name: UILabel!
    var check:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    func setup(item:ItemAppVNG){
        self.subviews.forEach { $0.removeFromSuperview() }
        iconImage = UIImageView(frame: CGRect(x: self.frame.size.width/2 - (self.frame.size.width * 2/3)/2, y:  self.frame.size.height/2 - (self.frame.size.width * 2/3)/2 , width: self.frame.size.width * 2/3, height:  self.frame.size.width * 2/3))
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
        iconImage.image = item.icon
        
        check = UIImageView(frame: CGRect(x: iconImage.frame.origin.x + iconImage.frame.size.width - Common.Size(s: 15), y:  iconImage.frame.origin.y + iconImage.frame.size.height - Common.Size(s: 15) , width: Common.Size(s: 30), height:   Common.Size(s: 30)))
        check.contentMode = .scaleAspectFit
        addSubview(check)
        check.image = UIImage(named: "CheckMark")
        
        name = UILabel(frame: CGRect(x: 0, y:  iconImage.frame.size.height + iconImage.frame.origin.y + Common.Size(s: 7), width: self.frame.size.width, height:  Common.Size(s:20)))
        name.textColor = UIColor.black
        name.numberOfLines = 1
        name.textAlignment = .center
        name.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        addSubview(name)
        name.text = "\(item.name)"
        if(item.isSelect){
            check.isHidden = false
        }else{
            check.isHidden = true
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
