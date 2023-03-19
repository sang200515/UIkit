//
//  PosmImageViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 7/29/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class PosmImageViewController: UIViewController {
    var barClose : UIBarButtonItem!
    let imageViewBackground: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "baomoi"))
        // this enables autolayout for our imageView
        
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var url:String?
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00955E)
        self.title = "Xem ảnh mẫu"
        view.backgroundColor = .white
        view.addSubview(imageViewBackground)
        
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "Close"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(PosmImageViewController.actionClose), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]
        
        imageViewBackground.anchor(top: view.topAnchor, left: view.leftAnchor,bottom: view.bottomAnchor,right:view.rightAnchor)
        if(url != ""){
            let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
            if let escapedString = "\(url!)".addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                print(escapedString)
                let url = URL(string: "\(escapedString)")!

                imageViewBackground.kf.setImage(with: url,
                                                placeholder: nil,
                                                options: [.transition(.fade(1))],
                                                progressBlock: nil,
                                                completionHandler: nil)
            }
        }else{
            
        }
    }
    @objc func actionClose(){
        //        self.dismiss(animated: false, completion: nil)
        navigationController?.popViewController(animated: false)
        dismiss(animated: false, completion: nil)
    }
}
