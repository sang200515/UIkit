//
//  ChonNhaMangThaySimViewController.swift
//  fptshop
//
//  Created by Apple on 4/12/19.
//  Copyright © 2019 Duong Hoang Minh. All rights reserved.
//

import UIKit
import Foundation

class ChonNhaMangThaySimViewController: UIViewController {
    
    var btnVietnammobile: UIButton!
    var btnViettel: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
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
        
        btnVietnammobile = UIButton()
        btnVietnammobile.frame = CGRect(x: Common.Size(s: 15), y: Common.Size(s: 15), width: (self.view.frame.width - Common.Size(s:30))/2 - Common.Size(s: 5),height: Common.Size(s: 40))
        btnVietnammobile.setImage(#imageLiteral(resourceName: "Vietnamobile"), for: .normal)
        btnVietnammobile.addTarget(self, action: #selector(chuyenSim4GVietnammobile), for: .touchUpInside)
        self.view.addSubview(btnVietnammobile)
        
        btnViettel = UIButton()
        btnViettel.frame = CGRect(x: btnVietnammobile.frame.origin.x + btnVietnammobile.frame.width + Common.Size(s: 10), y: btnVietnammobile.frame.origin.y, width: btnVietnammobile.frame.width,height: btnVietnammobile.frame.height)
        btnViettel.setImage(#imageLiteral(resourceName: "Viettel"), for: .normal)
        btnViettel.addTarget(self, action: #selector(thaySimViettel), for: .touchUpInside)
        self.view.addSubview(btnViettel)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showListHistory() {
        debugPrint("showListHistory")
    }
    
    @objc func chuyenSim4GVietnammobile(){
        debugPrint("chuyenSim4G - Vietnammobile")
        let newViewController = CheckInfoConvert4GViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func thaySimViettel(){
        debugPrint("thaySimViettel")
    }

}
