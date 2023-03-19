//
//  NewsDetailViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 3/27/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import WebKit
import Toaster
import Kingfisher

class NewsDetailViewController: UIViewController {
    
    var listInclude = [Include_Tintuc]()
    var itemNews: Sumary_TinTuc?
    var listFile = [Include_Tintuc]()
    var newsID = ""
    var scrollView: UIScrollView!
    var webViewContent: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tabBarController?.tabBar.isHidden = true
        self.title = "Bản tin"
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        self.listFile.removeAll()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.Tintuc_detail_baiviet(id: "\(self.newsID)") { (rsDataSumary, rsInclude, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rsInclude.count > 0 {
                            self.listInclude = rsInclude
                            for inc in rsInclude {
                                if inc.type == "file--file" {
                                    self.listFile.append(inc)
                                }
                            }
                        }
                        if rsDataSumary.count > 0 {
                            for item in rsDataSumary {
                                if item.id == self.newsID {
                                    self.itemNews = item
                                }
                            }
                            self.setUpView()
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "Không có data chi tiết tin tức!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setUpView() {
        let bodyTextOriginal = "\(itemNews?.body_processed ?? "")"
        var bodyTextWithImgMedia = bodyTextOriginal.replacingOccurrences(of: "/sites", with: "\(NewsViewController.domainNews)/sites")
        if self.listInclude.count > 0 {
//            if listFile.count > 1 {
//                if (!listFile[1].img_url.isEmpty) && (Common.isUrlImage(urlString: "\(listFile[1].img_url)") == true) {
//                    bodyTextWithImgMedia = "<img src=\"\(NewsViewController.domainNews)\(listFile[1].img_url)\" />" + bodyTextWithImgMedia
//                }
//            }
            for inc in self.listInclude {
                if !(inc.img_url.isEmpty){
                    if (inc.img_url.contains(find: ".docx")) || (inc.img_url.contains(find: ".xlsx")) {
                        bodyTextWithImgMedia = bodyTextWithImgMedia + "<div><a href=\"\(NewsViewController.domainNews)\(inc.img_url)\">\(inc.include_url_name)</a></div>"
                    }
                }
            }
        }
        
        let styleContent = "<html><head><style>img{width:100%;height:auto;max-width:100%;};</style></head>"
        + "<body style='margin:0; padding:5;'>" + "\(bodyTextWithImgMedia)" + "</body></html>"
        
        debugPrint("styleContent: \(styleContent)")
        
        let imgBanner = UIImageView(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 15), width: self.view.frame.width - Common.Size(s: 10), height: (self.view.frame.width - Common.Size(s: 10)) * 160 / 720))
        if listFile.count > 1 {
            if (!listFile[1].img_url.isEmpty) && (Common.isUrlImage(urlString: "\(listFile[1].img_url)") == true) {
                if let url = URL(string: "\(NewsViewController.domainNews)\(listFile[1].img_url)") {
                    imgBanner.kf.setImage(with: url)
                }
            }
        }
        self.view.addSubview(imgBanner)
        
        let lbTitle = UILabel(frame: CGRect(x: Common.Size(s: 5), y: imgBanner.frame.origin.y + imgBanner.frame.size.height + Common.Size(s: 5), width: self.view.frame.width - Common.Size(s: 10), height: Common.Size(s: 25)))
        lbTitle.font = UIFont.boldSystemFont(ofSize: 20)
        lbTitle.text = "\(itemNews?.title ?? "Bản tin")"
        lbTitle.textColor = UIColor.red
        self.view.addSubview(lbTitle)
        
        let lbTitleHeight:CGFloat = lbTitle.optimalHeight < Common.Size(s: 25) ? Common.Size(s: 25) : lbTitle.optimalHeight
        lbTitle.numberOfLines = 0
        lbTitle.frame = CGRect(x: lbTitle.frame.origin.x, y: lbTitle.frame.origin.y, width: lbTitle.frame.width, height: lbTitleHeight)
        
        let lbCreateDate = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbTitle.frame.origin.y + lbTitleHeight + Common.Size(s: 5), width: self.view.frame.width - Common.Size(s: 20), height: Common.Size(s: 20)))
        lbCreateDate.font = UIFont.systemFont(ofSize: 13)
        lbCreateDate.textAlignment = .right
        self.view.addSubview(lbCreateDate)
        if (itemNews?.created != "") {
            let dateStrOld = itemNews?.created ?? ""
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            let date2 = formatter.date(from: dateStrOld)
            
            let newFormatter = DateFormatter()
            newFormatter.locale = Locale(identifier: "vi_VN");
            newFormatter.timeZone = TimeZone(identifier: "UTC+7");
            newFormatter.dateFormat = "HH:mm dd/MM/yyyy"
            let str = newFormatter.string(from: date2 ?? Date())
            lbCreateDate.text = str
        } else {
            lbCreateDate.text = itemNews?.created ?? ""
        }
        webViewContent = WKWebView(frame: CGRect(x: 0, y: lbCreateDate.frame.origin.y + lbCreateDate.frame.height + Common.Size(s: 5), width: self.view.frame.width, height: self.view.frame.height - (lbCreateDate.frame.origin.y + lbCreateDate.frame.height + Common.Size(s: 30))))
        webViewContent.loadHTMLString("\(styleContent)", baseURL: nil)
        webViewContent.scrollView.showsVerticalScrollIndicator = false
        webViewContent.scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(webViewContent)
    }
    
    
}

