//
//  SauChamCongVC.swift
//  fptshop
//
//  Created by Sang Trương on 02/06/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import WebKit
class SauChamCongVC: UIViewController {
    var htmlString = ""
    
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet  var webView: WKWebView!
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    private func setUpView(){

        let closeBtn = UIButton()
        self.view.addSubview(closeBtn)
        closeBtn.snp.makeConstraints({(make) in
            make.top.equalTo(contentView.snp.bottom).offset(24)
            make.centerX.equalTo(contentView)
            make.width.height.equalTo(50
            )
        })

        closeBtn.layer.cornerRadius = 25
        closeBtn.backgroundImage(for: .normal)
        closeBtn.setImage(UIImage(named: "ic_close_noti"), for: .normal)
        closeBtn.setTitleColor(.systemBlue,for: .normal)
        closeBtn.addTarget(self,
                           action: #selector(closeBtnAction),
                           for: .touchUpInside)
        webView.loadHTMLString( Common.shared.headerString + htmlString, baseURL: nil)
        webView.backgroundColor = .clear
        webView.alpha = 1
        contentView.layer.cornerRadius = 30
        webView.layer.masksToBounds = true

        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backGroundImage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.85

    }

    @objc func closeBtnAction() {
        self.dismiss(animated: true)
    }


}
