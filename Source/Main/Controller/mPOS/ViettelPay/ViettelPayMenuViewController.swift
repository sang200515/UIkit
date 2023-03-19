//
//  ViettelPayMenuViewController.swift
//  fptshop
//
//  Created by tan on 6/21/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import Presentr

class ViettelPayMenuViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    var items = [ItemApp]()
    
    var collectionView: UICollectionView!
    
    var cellWidth: CGFloat = 0
    var coCellWidth: CGFloat = 0
    var coCellHeight: CGFloat = 0
    var webView:WKWebView!
    
//    let presenter: Presentr = {
//        let dynamicType = PresentationType.dynamic(center: ModalCenterPosition.center)
//        let customPresenter = Presentr(presentationType: dynamicType)
//        customPresenter.backgroundOpacity = 0.3
//        customPresenter.roundCorners = true
//        customPresenter.dismissOnSwipe = false
//        customPresenter.dismissAnimated = false
//        customPresenter.backgroundTap = .noAction
//        return customPresenter
//    }()

    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.blue
        self.title = "ViettelPay"
        self.initNavigationBar()
        self.view.backgroundColor = .white
        cellWidth = self.view.frame.size.width
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(ViettelPayMenuViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
        layout.itemSize = CGSize(width: 111, height: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: Common.Size(s:120)  ), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ItemViettelPayCollectionViewCell.self, forCellWithReuseIdentifier: "ItemViettelPayCollectionViewCell")
        self.view.addSubview(collectionView)
        
        //---DATA
//        let crmItem1 = ItemApp(id: "101", name: "Chuyển Tiền", type: "1", icon: #imageLiteral(resourceName: "ChuyenTienMenuVP"))
//        //items.append(crmItem1)
//        let crmItem2 = ItemApp(id: "102", name: "Nhận tiền", type: "2", icon: #imageLiteral(resourceName: "ViettelPay-NhanTien"))
        //items.append(crmItem2)
        let crmItem3 = ItemApp(id: "103", name: "Nạp tiền", type: "3", icon: #imageLiteral(resourceName: "ViettelPay-NapTien"))
        items.append(crmItem3)
        //---DATA
        collectionView.reloadData()
        MPOSAPIManager.mpos_FRT_SP_Mirae_noteforsale(type:"5") { (result, err) in
                 
                 if(result.count > 0){
                    let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width, initial-scale=1.0, shrink-to-fit=yes'); document.getElementsByTagName('head')[0].appendChild(meta);"
                    
                    let userScript = WKUserScript(source: jscript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
                    
                    let wkUController = WKUserContentController()
                    
                    wkUController.addUserScript(userScript)
                    
                    let wkWebConfig = WKWebViewConfiguration()
                    
                    wkWebConfig.userContentController = wkUController
                    self.webView = WKWebView(frame: CGRect(x: 0 , y: self.collectionView.frame.size.height + self.collectionView.frame.origin.y + Common.Size(s: 15) , width: self.view.frame.size.width , height: self.view.frame.size.height - (self.collectionView.frame.size.height + self.collectionView.frame.origin.y + Common.Size(s: 15))),configuration: wkWebConfig)
                     self.webView.loadHTMLString(result, baseURL: nil)
                     self.webView.backgroundColor = .white
                     self.view.addSubview(self.webView)
                 }
             }
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let coCell: ItemViettelPayCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemViettelPayCollectionViewCell", for: indexPath) as! ItemViettelPayCollectionViewCell
        
        let item = items[indexPath.item]
        coCell.setUpCollectionViewCell(item: item)
        coCell.layer.borderWidth = 0.5
        coCell.layer.borderColor = UIColor(netHex: 0xEEEEEE).cgColor
        return coCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        if(item.type == "1"){
            let vc = TransferMoneyMenuViettelPayViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if(item.type == "2"){
            let vc = ReceiveMoneyViettelPayViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if(item.type == "3"){
            let vc = RechargeMoneyMenuViettelPayViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
//        let vc = CountSecondSOMVC()
//        vc.orderId = ""
//        self.customPresentViewController(self.presenter, viewController: vc, animated: true)
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
    @objc func actionBack(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tapTranferMoney(_ sender:UITapGestureRecognizer){
        
    }
}
class ItemViettelPayCollectionViewCell: UICollectionViewCell {
    
    var icon: UIImageView!
    var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setUpCollectionViewCell(item: ItemApp) {
        contentView.backgroundColor = UIColor.white
        if(item.id != "0"){
            icon = UIImageView()
            icon = UIImageView(frame: CGRect(x: contentView.frame.width/2 - (contentView.frame.height/2 - Common.Size(s: 10))/2, y: contentView.frame.height/2 - (contentView.frame.height/2 + Common.Size(s: 20))/2, width: contentView.frame.height/2 - Common.Size(s: 10), height: contentView.frame.height/2))
            icon.image = item.icon
            icon.contentMode = .scaleAspectFit
            itemLabel = UILabel(frame: CGRect(x: 0, y: icon.frame.origin.y + icon.frame.size.height, width: self.contentView.frame.width, height: Common.Size(s: 20)))
            itemLabel.text = item.name
            itemLabel.textAlignment = .center
            itemLabel.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
            itemLabel.textColor = UIColor(netHex: 0x6C6B6B)
            contentView.addSubview(icon)
            contentView.addSubview(itemLabel)
        }
    }
    
}
