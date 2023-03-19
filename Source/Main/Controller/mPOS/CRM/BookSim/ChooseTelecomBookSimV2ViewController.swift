//
//  ChooseTelecomBookSimV2ViewController.swift
//  mPOS
//
//  Created by tan on 9/19/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import NVActivityIndicatorView
import MIBadgeButton_Swift
class ChooseTelecomBookSimV2ViewController:UIViewController {
    
    var scrollView:UIScrollView!
    var listCompany:[ProviderName] = []
    var viewCardType: [UIView] = []
    var indexTypeCard:Int = 0
    var provider:String! = ""
    
    var barSearchRight : UIBarButtonItem!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.blue
        self.title = "Chọn nhà mạng"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(ChooseTelecomBookSimV2ViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        let btSearchIcon = UIButton.init(type: .custom)
        
        btSearchIcon.setImage(#imageLiteral(resourceName: "list"), for: UIControl.State.normal)
        btSearchIcon.imageView?.contentMode = .scaleAspectFit
        btSearchIcon.addTarget(self, action: #selector(ChooseTelecomBookSimV2ViewController.showListSimByShop), for: UIControl.Event.touchUpInside)
        btSearchIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barSearchRight = UIBarButtonItem(customView: btSearchIcon)
        
        self.navigationItem.rightBarButtonItems = [barSearchRight]

        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)

        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin nhà mạng..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.FRT_SP_CRM_DSNhaMang_bookSim() { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    var listCom: [String] = []
                    self.listCompany = results
                    for item in results {
                        listCom.append("\(item.NhaMang)")
                    }
                    self.loadUI()
                }else{
                    
                    self.showDialog(message: err)
                }
            }
        }
    }
    
    
    func loadUI(){
        let width:CGFloat = UIScreen.main.bounds.size.width
        
        // step 1
        let lbTep1 = UILabel(frame: CGRect(x:Common.Size(s:10), y: 0, width: width - Common.Size(s:20), height: Common.Size(s:35)))
        lbTep1.textAlignment = .left
        lbTep1.textColor = UIColor.black
        lbTep1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        lbTep1.text = "Chọn nhà mạng"
        scrollView.addSubview(lbTep1)
        
        var xView:CGFloat = Common.Size(s:10)
        var yView:CGFloat = lbTep1.frame.origin.y + lbTep1.frame.size.height
        var count:Int = 0
        var countIndex:Int = 0
        for item in listCompany {
            //phone
            let viewTypePhone = UIView(frame: CGRect(x: xView,y: yView,width: (width - Common.Size(s:40)) / 3 , height: (width - Common.Size(s:40)) / 6))
            viewTypePhone.tag = countIndex
            scrollView.addSubview(viewTypePhone)

            viewTypePhone.backgroundColor = UIColor(netHex:0xf3f3f3)
            var iconTypePhone : UIImageView
            iconTypePhone  = UIImageView(frame:CGRect(x: (viewTypePhone.frame.size.width / 2) - (viewTypePhone.frame.size.width / 4) , y: 0, width: viewTypePhone.frame.size.width / 2, height: viewTypePhone.frame.size.width / 2));
            iconTypePhone.image = UIImage(named:"noImg")
            if(item.NhaMang == "VietnamMobile"){
                iconTypePhone.image = UIImage(named:"\("Vietnamobile")")
            }else{
                iconTypePhone.image = UIImage(named:"\(item.NhaMang)")
            }

            iconTypePhone.contentMode = .scaleAspectFit
            viewTypePhone.addSubview(iconTypePhone)
            let gesturePhone = UITapGestureRecognizer(target: self, action:  #selector (self.actionCardType (_:)))
            viewTypePhone.addGestureRecognizer(gesturePhone)
            viewCardType.append(viewTypePhone)
            xView = viewTypePhone.frame.origin.x + viewTypePhone.frame.size.width + Common.Size(s:10)
            if(count == 2){
                xView = Common.Size(s:10)
                yView = viewTypePhone.frame.origin.y + viewTypePhone.frame.size.height + Common.Size(s:10)
                count = -1
            }
            count = count + 1
            countIndex = countIndex + 1
            if (countIndex == listCompany.count){
                yView = viewTypePhone.frame.origin.y + viewTypePhone.frame.size.height
            }
        }
    }
    
    
    @objc func actionCardType(_ sender:UITapGestureRecognizer){
        
        for item in viewCardType {
            item.backgroundColor = UIColor(netHex:0xf3f3f3)
            item.layer.borderWidth = 0
            item.layer.borderColor = UIColor(netHex:0xf3f3f3).cgColor
        }
        let view: UIView = sender.view!
        viewCardType[view.tag].layer.borderWidth = 1.5
        viewCardType[view.tag].layer.borderColor = UIColor.red.cgColor
        viewCardType[view.tag].backgroundColor = UIColor.white
        indexTypeCard = view.tag
        
        print("caard \(listCompany[indexTypeCard].NhaMang)")
        self.provider = listCompany[indexTypeCard].NhaMang
        let typePhone:String = "\(listCompany[indexTypeCard].NhaMang)"
        UserDefaults.standard.set(typePhone, forKey : "typePhone")
        
        print(listCompany[indexTypeCard].NhaMang)
        let newViewController2 = ChooseGoiCuocBSV2ViewController()
        
        newViewController2.self.telecom = listCompany[indexTypeCard]
        self.navigationController?.pushViewController(newViewController2, animated: true)
        
        
    }
    
    @objc func showListSimByShop(){
        let newViewController = DanhSachSimBookV2ViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
}
