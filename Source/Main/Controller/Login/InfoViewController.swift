//
//  InfoViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 3/15/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class InfoViewController: UIViewController {
    var scrollView: UIScrollView!
    
    var lblSLTraGop: UILabel!
    var lblDTPK: UILabel!
    var lblSLSim: UILabel!
    var SLTraGop, DSPK, SLSim:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let logo = UIImage(named: "logo-header")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "close-1"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(InfoViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 40, height: 40)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        
        let headerView = UIView(frame: CGRect(x: 0, y: ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height), width: width, height: Common.Size(s: 40)))
        self.view.addSubview(headerView)
        
        let live = UILabel(frame: CGRect(x: 0, y: Common.Size(s: 10), width: Common.Size(s: 40), height: Common.Size(s: 20)))
        live.backgroundColor = .red
        live.text = "LIVE"
        live.textColor = .white
        live.textAlignment = .center
        live.layer.cornerRadius = 2
        live.clipsToBounds = true
        headerView.addSubview(live)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        let someDateTime = formatter.string(from: Date())
        
        let liveTime = UILabel(frame: CGRect(x: live.frame.origin.x + live.frame.size.width + Common.Size(s: 5), y: 0, width: Common.Size(s: 100), height: Common.Size(s: 40)))
        liveTime.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        liveTime.text = someDateTime
        headerView.addSubview(liveTime)
        
        headerView.frame.size.width = liveTime.frame.origin.x + liveTime.frame.size.width
        
        headerView.frame.origin.x = width/2 - headerView.frame.size.width/2
        
        let img1 = UIImageView(image:UIImage(named: "info-1"))
        img1.frame = CGRect(x: Common.Size(s: 5), y: headerView.frame.size.height + headerView.frame.origin.y + Common.Size(s: 2), width: width - Common.Size(s: 10), height: (height - Common.Size(s: 48))/3)
        self.view.addSubview(img1)
        
        
        ///TRa gop
        lblSLTraGop = UILabel(frame: CGRect(x: Common.Size(s: 5), y: img1.frame.height - Common.Size(s: 55), width: img1.frame.width - Common.Size(s: 10), height: Common.Size(s: 40)))
        lblSLTraGop.textAlignment = .center
        //        lblSLTraGop.setUpTextValue(string1: "TRẢ GÓP: ", string2: self.SLTraGop ?? "", font1: UIFont(name: "DINCondensed-Bold", size: Common.Size(s: 22))!, font2: UIFont(name: "DINCondensed-Bold", size: Common.Size(s: 30))!, textColor1: UIColor.white, textColor2: UIColor.yellow)
        lblSLTraGop.setUpTextValue(string1: "SL TRẢ GÓP: ", string2: self.SLTraGop ?? "", font1: UIFont(name: "DINCondensed-Bold", size: Common.Size(s: 20))!, font2: UIFont(name: "DINCondensed-Bold", size: Common.Size(s: 25))!, textColor1: UIColor.white, textColor2: UIColor.yellow)
        //        lblSLTraGop.text = self.SLTraGop ?? ""
        img1.addSubview(lblSLTraGop)
        
        
        let img2 = UIImageView(image:UIImage(named: "info-2"))
        img2.frame = CGRect(x: Common.Size(s: 5), y: img1.frame.size.height + img1.frame.origin.y + Common.Size(s: 2), width: img1.frame.size.width, height: img1.frame.size.height)
        self.view.addSubview(img2)
        
        
        ///DTPK
        lblDTPK = UILabel(frame: CGRect(x: Common.Size(s: 5), y: img1.frame.height - Common.Size(s: 55), width: img2.frame.width - Common.Size(s: 10), height: Common.Size(s: 40)))
        lblDTPK.textAlignment = .center
        lblDTPK.setUpTextValue(string1: "DOANH THU PK: ", string2: self.DSPK ?? "", font1: UIFont(name: "DINCondensed-Bold", size: Common.Size(s: 20))!, font2: UIFont(name: "DINCondensed-Bold", size: Common.Size(s: 23))!, textColor1: UIColor.white, textColor2: UIColor.yellow)
        //        lblDTPK.text = self.DSPK ?? ""
        img2.addSubview(lblDTPK)
        
        
        let img3 = UIImageView(image:UIImage(named: "info-3"))
        img3.frame = CGRect(x: Common.Size(s: 5), y: img2.frame.size.height + img2.frame.origin.y + Common.Size(s: 2), width: img1.frame.size.width, height: img1.frame.size.height)
        self.view.addSubview(img3)
        
        ///SL Sim
        lblSLSim = UILabel(frame: CGRect(x: Common.Size(s: 5), y: img1.frame.height - Common.Size(s: 55), width: img3.frame.width - Common.Size(s: 10), height: Common.Size(s: 40)))
        lblSLSim.textAlignment = .center
        lblSLSim.setUpTextValue(string1: "SL SIM: ", string2: self.SLSim ?? "", font1: UIFont(name: "DINCondensed-Bold", size: Common.Size(s: 20))!, font2: UIFont(name: "DINCondensed-Bold", size: Common.Size(s: 25))!, textColor1: UIColor.white, textColor2: UIColor.yellow)
        //        lblSLSim.text = self.SLSim ?? ""
        img3.addSubview(lblSLSim)
        
    }
    
    @objc func actionBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension UILabel {
    func setUpTextValue(string1: String, string2: String, font1: UIFont, font2: UIFont, textColor1: UIColor, textColor2: UIColor) {
        
        let attributedText = NSMutableAttributedString(string: string1
            , attributes: [NSAttributedString.Key.font: font1, NSAttributedString.Key.foregroundColor: textColor1])
        
        attributedText.append(NSAttributedString(string: string2, attributes: [NSAttributedString.Key.font: font2, NSAttributedString.Key.foregroundColor: textColor2]))
        
        self.attributedText = attributedText
    }
    
}
