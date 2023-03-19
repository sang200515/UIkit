//
//  GalaxyPlayMainViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 9/15/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class GalaxyPlayMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Galaxy Play"
        self.view.backgroundColor = .white
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: 0, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        let viewNapGalaxy = UIView(frame: CGRect(x: Common.Size(s: 20), y: Common.Size(s: 20), width: (self.view.frame.width - Common.Size(s: 40))/2 - Common.Size(s: 20), height: Common.Size(s: 80)))
        viewNapGalaxy.backgroundColor = .white
        viewNapGalaxy.layer.cornerRadius = 8
        viewNapGalaxy.layer.borderWidth = 2
        viewNapGalaxy.layer.borderColor = UIColor(netHex:0x04AB6E).cgColor
        self.view.addSubview(viewNapGalaxy)
        
        let tapNapGalaxy = UITapGestureRecognizer(target: self, action: #selector(actionNapGalaxy))
        viewNapGalaxy.isUserInteractionEnabled = true
        viewNapGalaxy.addGestureRecognizer(tapNapGalaxy)
        
        let imgViewNapGalaxy = UIImageView(frame: CGRect(x: 0, y: Common.Size(s: 10), width: viewNapGalaxy.frame.width, height: Common.Size(s: 40)))
        imgViewNapGalaxy.image = #imageLiteral(resourceName: "GalaxyPay-Nap")
        imgViewNapGalaxy.contentMode = .scaleAspectFit
        viewNapGalaxy.addSubview(imgViewNapGalaxy)
        
        let lbNapGalaxy = UILabel(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 55), width: viewNapGalaxy.frame.width - Common.Size(s: 10), height: Common.Size(s: 20)))
        lbNapGalaxy.text = "Nạp Galaxy Play"
        lbNapGalaxy.textAlignment = .center
        lbNapGalaxy.textColor = UIColor(netHex:0x04AB6E)
        lbNapGalaxy.font = UIFont.systemFont(ofSize: 15)
        viewNapGalaxy.addSubview(lbNapGalaxy)
        
        //view lich su
        let viewLichSuNap = UIView(frame: CGRect(x: viewNapGalaxy.frame.origin.x + viewNapGalaxy.frame.width + Common.Size(s: 40), y: viewNapGalaxy.frame.origin.y, width: viewNapGalaxy.frame.width, height: viewNapGalaxy.frame.height))
        viewLichSuNap.backgroundColor = .white
        viewLichSuNap.layer.cornerRadius = 8
        viewLichSuNap.layer.borderWidth = 2
        viewLichSuNap.layer.borderColor = UIColor(netHex:0x04AB6E).cgColor
        self.view.addSubview(viewLichSuNap)
        
        let tapShowNapGalaxyHistory = UITapGestureRecognizer(target: self, action: #selector(showNapGalaxyHistory))
        viewLichSuNap.isUserInteractionEnabled = true
        viewLichSuNap.addGestureRecognizer(tapShowNapGalaxyHistory)
        
        let imgViewLSGalaxy = UIImageView(frame: CGRect(x: 0, y: Common.Size(s: 10), width: viewLichSuNap.frame.width, height: Common.Size(s: 40)))
        imgViewLSGalaxy.image = #imageLiteral(resourceName: "GalaxyPay-History")
        imgViewLSGalaxy.contentMode = .scaleAspectFit
        viewLichSuNap.addSubview(imgViewLSGalaxy)
        
        let lbLSGalaxy = UILabel(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 55), width: viewLichSuNap.frame.width - Common.Size(s: 10), height: Common.Size(s: 20)))
        lbLSGalaxy.text = "Lịch sử nạp"
        lbLSGalaxy.textAlignment = .center
        lbLSGalaxy.textColor = UIColor(netHex:0x04AB6E)
        lbLSGalaxy.font = UIFont.systemFont(ofSize: 15)
        viewLichSuNap.addSubview(lbLSGalaxy)
    }
    
    @objc func actionBack() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func actionNapGalaxy() {
        let vc = NapGalaxyViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showNapGalaxyHistory() {
        let vc = GalaxyHistoryListViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
