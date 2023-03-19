//
//  PopUpWarningUploadImageViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 12/18/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
import WebKit
import Foundation
import PopupDialog
import UIKit
protocol PopUpWarningUploadImageViewControllerDelegate: NSObjectProtocol {
    func returnUpload()
}
class PopUpWarningUploadImageViewController: UIViewController {
    
    
    var delegate:PopUpWarningUploadImageViewControllerDelegate?
    var warning:String?
      var barClose : UIBarButtonItem!
    var webView:WKWebView!
    var historyMirae:HistoryOrderByID?
    var base64URL:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Thông Báo"
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00955E)
        
        
        
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "Close"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(PopUpWarningUploadImageViewController.backButton), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]
        
        let newBackButton = UIBarButtonItem(title: "OK->", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.actionSkip(sender:)))
               self.navigationItem.rightBarButtonItem = newBackButton
        
        
        self.webView = WKWebView(frame: CGRect(x: 0 , y: Common.Size(s: 5) , width: self.view.frame.size.width , height: self.view.frame.size.height))
        self.webView.loadHTMLString(Common.shared.headerString + warning!, baseURL: nil)

        self.view.addSubview(self.webView)
        
        
        
        
    }
    @objc func backButton(){
        //        navigationController?.popViewController(animated: false)
        //        dismiss(animated: false, completion: nil)
        
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func actionSkip(sender: UIBarButtonItem){

        let newViewController = LoadingViewController()
            newViewController.content = "Đang lưu thông tin ..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            MPOSAPIManager.mpos_FRT_SP_Mirae_Insert_image_contract(base64Xmlimage:base64URL!,Docentry: "\(self.historyMirae!.Docentry)",processId:"\(self.historyMirae!.processId_Mirae)",IsUpdate:"2") { (results, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    //nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        if(results[0].p_status == 0){
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            let alert = UIAlertController(title: "Thông báo", message: results[0].p_messagess, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                
                            })
                            self.present(alert, animated: true)
                            return
                        }
                        
                        MPOSAPIManager.mpos_ConfirmUploadComplete(activityId:self.historyMirae!.activityId_Mirae) { (message, err) in
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                if(err.count <= 0){
                                    
                                    let title = "THÔNG BÁO"
                                    let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        print("Completed")
                                    }
                                    let buttonOne = CancelButton(title: "OK") {
                                        
                                        
                                        self.navigationController?.popViewController(animated: false)
                                        self.dismiss(animated: false, completion: nil)
                                        self.delegate?.returnUpload()
                                        
                                        
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                    
                                    
                                    
                                }else{
                                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                                    
                                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                        
                                    })
                                    self.present(alert, animated: true)
                                }
                            }
                        }
                        
                        
                        //
//                        MPOSAPIManager.mpos_FRT_Mirae_CreateCalllog_DuyetHinhAnh(DocEntry: "\(self.historyMirae!.Docentry)",processId:"\(self.historyMirae!.processId_Mirae)") { (p_status,message,err) in
//                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
//                            let when = DispatchTime.now() + 0.5
//                            DispatchQueue.main.asyncAfter(deadline: when) {
//                                if(err.count <= 0){
//                                    if (p_status == 1) {
//                                        let title = "THÔNG BÁO"
//                                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
//                                            print("Completed")
//                                        }
//                                        let buttonOne = CancelButton(title: "OK") {
//
//
//                                            self.navigationController?.popViewController(animated: false)
//                                            self.dismiss(animated: false, completion: nil)
//                                            self.delegate?.returnUpload()
//
//
//                                        }
//                                        popup.addButtons([buttonOne])
//                                        self.present(popup, animated: true, completion: nil)
//                                    }
//                                    if (p_status == 0) {
//                                        let title = "THÔNG BÁO"
//                                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
//                                            print("Completed")
//                                        }
//                                        let buttonOne = CancelButton(title: "OK") {
//
//
//
//                                        }
//                                        popup.addButtons([buttonOne])
//                                        self.present(popup, animated: true, completion: nil)
//                                    }
//
//
//                                }else{
//                                    let title = "THÔNG BÁO"
//                                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
//                                        print("Completed")
//                                    }
//                                    let buttonOne = CancelButton(title: "OK") {
//
//                                    }
//                                    popup.addButtons([buttonOne])
//                                    self.present(popup, animated: true, completion: nil)
//                                }
//                            }
//
//                        }
                        //
                        
                        
                        
                        
                    }else{
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                }
            }
        
    }
}
