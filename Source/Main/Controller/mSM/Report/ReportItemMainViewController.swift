//
//  ReportItemMainViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 12/13/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import PopupDialog

class ReportItemMainViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var items = [ItemApp]()
    var cellWidth: CGFloat = 0
    var coCellWidth: CGFloat = 0
    var coCellHeight: CGFloat = 0
    var collectionViewHeightConstraint = NSLayoutConstraint()
    var whiteCoCellArray = [ItemApp]()
    var listPermisstionID = [PermissionHashCode]()
    var reportCase: [ReportCase] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Báo cáo"
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
        self.GetReportPermission()
        cellWidth = self.view.frame.width
        self.setUpCollectionView()
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("showTabInside"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showTabInside), name: Notification.Name("showTabInside"), object: nil)
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
        let item1 = ItemApp(id: "01", name: "BC công nghệ", type: "00", icon: #imageLiteral(resourceName: "chart-icon"))
        let item2 = ItemApp(id: "02", name: "BC mỹ phẩm", type: "00", icon: #imageLiteral(resourceName: "FBeauty-icon"))
        let item3 = ItemApp(id: "03", name: "Inside", type: "00", icon: #imageLiteral(resourceName: "Inside"))
        items.append(item1)
        items.append(item2)
        items.append(item3)
    }
    
    func GetReportPermission(){
        let reportSections = mSMApiManager.GetReportSections(userCode: "\(Cache.user?.UserName ?? "")", token: "\(Cache.user?.Token ?? "")").Data
        
        if(reportSections != nil){
            if(reportSections!.count > 0){
                let permissions = reportSections![0].Permissions
                self.listPermisstionID = permissions
            }
        }
    }
    
    @objc func showTabInside(notification:Notification) -> Void {
        let dict = notification.object as! NSDictionary
        if let INSIDE_URL = dict["INSIDE_URL"] as? String{
            print("INSIDE_URL \(INSIDE_URL)")
            Cache.INSIDE_URL = INSIDE_URL
        }
    }
}

extension ReportItemMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        
        switch item.id {
        case "01":
            let vc = ReportTableViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "02":
            let vc = MyPhamTableViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "03":
            let vc = TabInsideViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
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
