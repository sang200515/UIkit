//
//  MenuUpdateSimViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 9/14/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class MenuUpdateSimViewController: UIViewController {
    
    var btnVietnammobile: UIImageView!
    var btnItel: UIImageView!
    
    

      override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.hidesBackButton = true
        self.title = "Cập nhật thuê bao"
        //set up barButtonItem
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)

        btnVietnammobile = UIImageView(frame:CGRect(x: self.view.frame.width/8, y: self.view.frame.width/8, width: self.view.frame.width/2 - self.view.frame.width * 2/8,height:  self.view.frame.width/8))
        btnVietnammobile.image = #imageLiteral(resourceName: "VNM")
        btnVietnammobile.contentMode = .scaleAspectFit
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleUpdateVNM))
        btnVietnammobile.isUserInteractionEnabled = true
        btnVietnammobile.addGestureRecognizer(singleTap)
        self.view.addSubview(btnVietnammobile)
        
        btnItel = UIImageView()
        btnItel.frame = CGRect(x: self.view.frame.width/2 + btnVietnammobile.frame.origin.x, y: btnVietnammobile.frame.origin.y, width: btnVietnammobile.frame.width,height: btnVietnammobile.frame.height)
        btnItel.image = #imageLiteral(resourceName: "Itel")
        btnItel.contentMode = .scaleAspectFit
        let singleTap2 = UITapGestureRecognizer(target: self, action: #selector(handleUpdateItel))
        btnItel.isUserInteractionEnabled = true
        btnItel.addGestureRecognizer(singleTap2)
        self.view.addSubview(btnItel)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func handleUpdateVNM(){
        let controller = InputOTPUpdateTBViewController()
        controller.typeSim = "VNM"
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleUpdateItel(){
        let controller = InputOTPUpdateTBViewController()
        controller.typeSim = "Itel"
        navigationController?.pushViewController(controller, animated: true)
    }
    
  
  
}
