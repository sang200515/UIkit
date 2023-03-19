//
//  NopQuyNHMainViewController.swift
//  fptshop
//
//  Created by Apple on 7/10/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import PopupDialog

class NopQuyNHMainViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var items = [ItemApp]()
    var cellWidth: CGFloat = 0
    var coCellWidth: CGFloat = 0
    var coCellHeight: CGFloat = 0
    var collectionViewHeightConstraint = NSLayoutConstraint()
    var whiteCoCellArray = [ItemApp]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Nộp quỹ ngân hàng"
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
    
    func initSection() {
        let item1 = ItemApp(id: "01", name: "Nạp tiền", type: "56", icon: #imageLiteral(resourceName: "noptien"))
        let item2 = ItemApp(id: "02", name: "Lịch sử", type: "57", icon: #imageLiteral(resourceName: "lichsu"))
        items.append(item1)
        items.append(item2)
        
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
                        let newViewController = UpdateInfoNopTienViewController()
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }else if(id == "02"){
                        let newViewController = HistoryNopQuyNHViewController()
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
}

extension NopQuyNHMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        
//                switch indexPath.item {
//                case 0:
//                    let newViewController = UpdateInfoNopTienViewController()
//                    self.navigationController?.pushViewController(newViewController, animated: true)
//                    break
//                case 1:
//                    let newViewController = HistoryNopQuyNHViewController()
//                    self.navigationController?.pushViewController(newViewController, animated: true)
//                    break
//                default:
//                    break
//                }
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
