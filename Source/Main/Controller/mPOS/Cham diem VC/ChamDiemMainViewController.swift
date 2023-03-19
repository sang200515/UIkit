//
//  ChamDiemMainViewController.swift
//  fptshop
//
//  Created by Apple on 5/30/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import PopupDialog

class ChamDiemMainViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var items = [ItemApp]()
    var cellWidth: CGFloat = 0
    var coCellWidth: CGFloat = 0
    var coCellHeight: CGFloat = 0
    var collectionViewHeightConstraint = NSLayoutConstraint()
    var whiteCoCellArray = [ItemApp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "CHẤM ĐIỂM"
        
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
        
        self.initSection()
        cellWidth = self.view.frame.width
        self.setUpCollectionView()
    }
    override func viewDidAppear(_ animated: Bool) {
    
        //        super.viewWillDisappear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(pushView(notification:)), name: Notification.Name("pushView"), object: nil)
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("pushView"), object: nil)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpCollectionView() {
        //        self.subviews.forEach({ $0.removeFromSuperview() })
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
        layout.itemSize = CGSize(width: 111, height: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ItemSessionCollectionViewCell.self, forCellWithReuseIdentifier: "ItemSessionCollectionViewCell")
        self.view.addSubview(collectionView)
        collectionView.isScrollEnabled = false
    }
    
    @objc func pushView(notification:Notification) {
        let dict = notification.object as! NSDictionary
        if let id = dict["ID_VIEW"] as? String{
            if let rule = dict["RULE_VIEW"] as? String{
                var check: Bool = false
                for item in Cache.ruleMenus {
                    if (item.p_messagess == rule){
                        check = true
                        break
                    }
                }
                if(check){
                    if(id == "01"){
                        let newViewController = KhaiBaoViewController()
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }else if(id == "02"){
                        let newViewController = ChamDiemShopDetailVC()
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }else if(id == "03"){
                        let newViewController = HistoryChamDiemErrorViewController()
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }
                } else{
                    let popup = PopupDialog(title: "Thông báo", message: "Bạn không được cấp quyền sử dụng chức năng này. Vui lòng kiểm tra lại.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
            }else{
                let popup = PopupDialog(title: "Thông báo", message: "Bạn không được cấp quyền sử dụng chức năng này. Vui lòng kiểm tra lại.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "OK") {
                    
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }
        }
    }
    
    func initSection() {
        let item1 = ItemApp(id: "01", name: "Khai báo", type: "49", icon: #imageLiteral(resourceName: "khaibao"))
        let item2 = ItemApp(id: "02", name: "Chấm điểm", type: "50", icon: #imageLiteral(resourceName: "Chamdiem"))
        let item3 = ItemApp(id: "03", name: "Lịch sử", type: "51", icon: #imageLiteral(resourceName: "lichsu"))
        items.append(item1)
        items.append(item2)
        items.append(item3)
        
    }
    
    
}

extension ChamDiemMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        let item = items[indexPath.row]
        let myDict = ["ID_VIEW": item.id,"RULE_VIEW":item.type]
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("pushView"), object: myDict)
        
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

protocol ChamDiemItemCellDelegate {
    func didDeleteItem(ID:Int, Type:Int)
    //    func didDeleteItem(objDelete:DoiTuongChamDiem, Type:Int)
}

class ChamDiemItemCell: UITableViewCell {
    
    var title: UILabel!
    var icon: UIImageView!
    var itemID: Int = 0
    var itemType: Int = 0
    var delegate:ChamDiemItemCellDelegate?
    
    func setUpCell() {
        self.subviews.forEach({$0.removeFromSuperview()})
        title = UILabel(frame: CGRect(x: Common.Size(s: 20), y: 0, width: self.frame.width - Common.Size(s: 60), height: self.frame.height))
        title.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(title)
        
        icon = UIImageView(frame: CGRect(x: title.frame.origin.x + title.frame.width + Common.Size(s: 5), y: self.frame.height/2 - Common.Size(s: 11) , width: Common.Size(s: 22), height: Common.Size(s: 22)))
        icon.image = #imageLiteral(resourceName: "delete-1")
        self.addSubview(icon)
        
        let tapDelete = UITapGestureRecognizer(target: self, action: #selector(deleteItem))
        icon.isUserInteractionEnabled = true
        icon.addGestureRecognizer(tapDelete)
    }
    
    @objc func deleteItem() {
        self.delegate?.didDeleteItem(ID: itemID, Type: itemType)
    }
    
}
