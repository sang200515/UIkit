//
//  ViewImageViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class ViewImageViewController: UIViewController {
    var scrollView:UIScrollView!
    var urlCMND:String = "http://calllogoutsidebeta.fptshop.com.vn/Uploads/FileAttachs/OpenCard/Basic/Url_ChanDung_Basic.jpg"
    var urlForm:String = "http://calllogoutsidebeta.fptshop.com.vn/Uploads/FileAttachs/OpenCard/Basic/Url_ChanDung_KyMoThe_Basic.jpg"
    var urlSign:String = "http://calllogoutsidebeta.fptshop.com.vn/Uploads/FileAttachs/OpenCard/Basic/Url_LanTay_Basic.jpg"
    var pos:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Ảnh mẫu"
        
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
        img.contentMode = .scaleAspectFit
        scrollView.addSubview(img)
        
        if(pos == 1){
            let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
            if let escapedString = urlCMND.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                let url = URL(string: "\(escapedString)")!
                img.kf.setImage(with: url,
                                placeholder: nil,
                                options: nil,
                                progressBlock: nil,
                                completionHandler: {
                                    result in
                                    
                })
            }
        }else if(pos == 2){
            let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
            if let escapedString = urlForm.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                let url = URL(string: "\(escapedString)")!
                img.kf.setImage(with: url,
                                placeholder: nil,
                                options: nil,
                                progressBlock: nil,
                                completionHandler: {
                                    result in
                                    
                })
            }
        }else if(pos == 3){
            let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
            if let escapedString = urlSign.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                let url = URL(string: "\(escapedString)")!
                img.kf.setImage(with: url,
                                placeholder: nil,
                                options: nil,
                                progressBlock: nil,
                                completionHandler: {
                                    result in
                                    
                })
            }
        }
        
        
    }
}

