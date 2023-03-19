//
//  MenuGrabViewController.swift
//  fptshop
//
//  Created by tan on 5/10/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import WebKit
class MenuGrabViewController: UIViewController {
    
    var scrollView:UIScrollView!
    var window: UIWindow?
    var webView:WKWebView!

    override func viewDidLoad() {
        
        //        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        //        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        //        scrollView.backgroundColor = UIColor.white
        //        scrollView.showsVerticalScrollIndicator = false
        //        scrollView.showsHorizontalScrollIndicator = false
        //        self.view.addSubview(scrollView)
        //        self.title = "Nạp/Rút tiền MoMo"
        
        
        self.view.backgroundColor = UIColor.blue
        self.title = "GRAB"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(MenuGrabViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
   
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_FRT_SP_Mirae_noteforsale(type:"5") { (result, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                
                
                if(result.count > 0){
                    let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width, initial-scale=1.0, shrink-to-fit=yes'); document.getElementsByTagName('head')[0].appendChild(meta);"
                    
                    let userScript = WKUserScript(source: jscript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
                    
                    let wkUController = WKUserContentController()
                    
                    wkUController.addUserScript(userScript)
                    
                    let wkWebConfig = WKWebViewConfiguration()
                    
                    wkWebConfig.userContentController = wkUController
                    
                    self.webView = WKWebView(frame: CGRect(x: 0 , y: Common.Size(s: 5) , width: self.view.frame.size.width , height: Common.Size(s: 120) ),configuration: wkWebConfig)
                    self.webView.loadHTMLString(result, baseURL: nil)
                    self.webView.backgroundColor = .white
                    self.view.addSubview(self.webView)
                    self.initView()
                }else{
                    self.webView = WKWebView(frame: CGRect(x: 0 , y: Common.Size(s: 5) , width: self.view.frame.size.width , height: 0))
                    self.initView()
                }
                
            }
            
        }
        
    }
    func initView(){
        
           
           var iconTypeMoMoNapTien : UIImageView
        iconTypeMoMoNapTien  =  UIImageView(frame:CGRect(x: Common.Size(s: 110)   , y: webView.frame.size.height + webView.frame.origin.y + Common.Size(s: 10), width: Common.Size(s: 100) , height: Common.Size(s: 100)));
           iconTypeMoMoNapTien.image = #imageLiteral(resourceName: "RutTienMoMo")
           iconTypeMoMoNapTien.contentMode = .scaleAspectFit
           scrollView.addSubview(iconTypeMoMoNapTien)
           let gestureNapTienMoMo = UITapGestureRecognizer(target: self, action:  #selector (self.actionNapTien (_:)))
           iconTypeMoMoNapTien.isUserInteractionEnabled = true
           iconTypeMoMoNapTien.addGestureRecognizer(gestureNapTienMoMo)
           

           
           var iconTypeMoMoLichSu : UIImageView
           iconTypeMoMoLichSu  =  UIImageView(frame:CGRect(x: Common.Size(s: 110)   , y: iconTypeMoMoNapTien.frame.origin.y + iconTypeMoMoNapTien.frame.size.height + Common.Size(s: 50), width: Common.Size(s: 100) , height: Common.Size(s: 100)));
           iconTypeMoMoLichSu.image = #imageLiteral(resourceName: "LichSuMoMo")
           iconTypeMoMoLichSu.contentMode = .scaleAspectFit
           scrollView.addSubview(iconTypeMoMoLichSu)
           let gestureLichSuMoMo = UITapGestureRecognizer(target: self, action:  #selector (self.actionLichSu (_:)))
           iconTypeMoMoLichSu.isUserInteractionEnabled = true
           iconTypeMoMoLichSu.addGestureRecognizer(gestureLichSuMoMo)
    }
    @objc func actionNapTien(_ sender:UITapGestureRecognizer){
        let newViewController = NapTienGrabViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
  
    
    @objc func actionLichSu(_ sender:UITapGestureRecognizer){
        let newViewController = LichSuGiaoDichGrabViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    @objc func backButton(){
        
        //        let mainViewController = MainViewController()
        //        //        let mainView = UINavigationController(rootViewController: mainViewController)
        //        UIApplication.shared.keyWindow?.rootViewController = mainViewController
        
        self.navigationController?.popViewController(animated: true)
        
    }
}
