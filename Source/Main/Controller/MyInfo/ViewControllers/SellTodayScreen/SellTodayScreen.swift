//
//  SellTodayScreen.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/22/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import WebKit

class SellTodayScreen: BaseController {
    let headerString = """
    <header>
        <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=no'>
    </header>
    """
    let webView: WKWebView = {
        let webKit = WKWebView()
        return webKit
    }()
    
    let vImageBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "bg_info_today_sale")
        return imageView
    }()
    
    let lbTitleSellToday: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.main_red_my_info
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: Constants.TextSizes.size_16)
        return label
    }()
    
    let lbTargetSellToday: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.bold_green
        label.text = ""
        label.font = UIFont.boldCustomFont(ofSize: Constants.TextSizes.size_14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupViews() {
        super.setupViews()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = Constants.COLORS.bold_green
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Hôm nay bán gì?"
        self.view.addSubview(vImageBackground)
        vImageBackground.myCustomAnchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.view.addSubview(webView)
        webView.myCustomAnchor(top: vImageBackground.topAnchor, leading: nil, trailing: nil, bottom: view.bottomAnchor, centerX: view.centerXAnchor, centerY: view.centerYAnchor, width: nil, height: nil, topConstant: 200, leadingConstant: 0, trailingConstant: 0, bottomConstant: 60, centerXConstant: 0, centerYConstant: 0, widthConstant: view.frame.width / 1.2, heightConstant: 0)
        self.view.addSubview(lbTitleSellToday)
        lbTitleSellToday.myCustomAnchor(top: webView.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: -60, leadingConstant: 35, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.view.addSubview(lbTargetSellToday)
        lbTargetSellToday.myCustomAnchor(top: lbTitleSellToday.bottomAnchor, leading: lbTitleSellToday.leadingAnchor, trailing: lbTitleSellToday.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 8, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        configWeb()
    }
    
    override func getData() {
        super.getData()
        getSellToday()
    }
    
    fileprivate func getSellToday() {
        if let userInside = UserDefaults.standard.getUsernameEmployee() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                MyInfoAPIManager.shared.getSellToday(userInside) { [weak self] (result, err) in
                    guard let strongSelf = self else {return}
                    guard let sellTodayItem = result else {return}
                    let content: String = (sellTodayItem.contentText ?? "").replacingOccurrences(of: "<html><body>", with: "<html><head><link rel=\"stylesheet\" type=\"text/css\" href=\"WebViewStyle.css\"></head><body>")
                    strongSelf.webView.loadHTMLString(strongSelf.headerString + content, baseURL: nil)
                    strongSelf.lbTitleSellToday.text = sellTodayItem.categoryAlertName
                    strongSelf.lbTargetSellToday.text = sellTodayItem.title
                }
            }
        }
    }
    
    private func configWeb() {
        let webConfiguration                = WKWebViewConfiguration()
        webConfiguration.websiteDataStore   = WKWebsiteDataStore.nonPersistent()
        webView.backgroundColor             = view.backgroundColor
        webView.navigationDelegate             = self
        webView.autoresizingMask               = [.flexibleWidth, .flexibleHeight]
    }
}

extension SellTodayScreen: WKNavigationDelegate {
    
}


