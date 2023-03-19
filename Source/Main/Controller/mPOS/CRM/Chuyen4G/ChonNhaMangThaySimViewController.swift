//
//  ChonNhaMangThaySimViewController.swift
//  fptshop
//
//  Created by Apple on 4/12/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Foundation

class ChonNhaMangThaySimViewController: UIViewController {
    
    var btnVietnammobile: UIImageView!
    var btnViettel: UIImageView!
    var btnItel: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.hidesBackButton = true
        self.title = "THAY SIM"
        //set up barButtonItem
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "LSCC.png"), style: .plain, target: self, action: #selector(showListHistory))
        
        btnVietnammobile = UIImageView(frame:CGRect(x: self.view.frame.width/8, y: self.view.frame.width/8, width: self.view.frame.width/2 - self.view.frame.width * 2/8,height:  self.view.frame.width/8))
        btnVietnammobile.image = #imageLiteral(resourceName: "VNM")
        btnVietnammobile.contentMode = .scaleAspectFit
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(chuyenSim4GVietnammobile))
        btnVietnammobile.isUserInteractionEnabled = true
        btnVietnammobile.addGestureRecognizer(singleTap)
        self.view.addSubview(btnVietnammobile)
        
//        btnViettel = UIImageView()
//        btnViettel.frame = CGRect(x: self.view.frame.width/2 + btnVietnammobile.frame.origin.x, y: btnVietnammobile.frame.origin.y, width: btnVietnammobile.frame.width,height: btnVietnammobile.frame.height)
//        btnViettel.image = #imageLiteral(resourceName: "VIETTEL")
//        let singleTap2 = UITapGestureRecognizer(target: self, action: #selector(thaySimViettel))
//        btnViettel.isUserInteractionEnabled = true
//        btnViettel.addGestureRecognizer(singleTap2)
//        self.view.addSubview(btnViettel)
        
        btnItel = UIImageView(frame: CGRect(x: self.view.frame.width/2 + btnVietnammobile.frame.origin.x, y: btnVietnammobile.frame.origin.y, width: btnVietnammobile.frame.width,height: btnVietnammobile.frame.height))
        btnItel.image = #imageLiteral(resourceName: "ic_itel")
        btnItel.contentMode = .scaleAspectFit
        let singleTap3 = UITapGestureRecognizer(target: self, action: #selector(thaySimItel))
        btnItel.isUserInteractionEnabled = true
        btnItel.addGestureRecognizer(singleTap3)
        self.view.addSubview(btnItel)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showListHistory() {
        debugPrint("showListHistory")
        let historyVC = HistoryChangeSimItelVC()
        self.navigationController?.pushViewController(historyVC, animated: true)
    }
    
    @objc func chuyenSim4GVietnammobile(){
        debugPrint("chuyenSim4G - Vietnammobile")
        let newViewController = CheckInfoConvert4GViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
//    @objc func thaySimViettel(){
//        let newViewController = CheckInfoChangeSimViewController()
//        self.navigationController?.pushViewController(newViewController, animated: true)
//    }
    
    @objc func thaySimItel(){
        let vc = InputPhoneItelChangeSimViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
