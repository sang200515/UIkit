//
//  AlertConnectionController.swift
//  fptshop
//
//  Created by KhanhNguyen on 17/12/2020.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class AlertConnectionController: UIViewController {
    
    let lbTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldCustomFont(ofSize: Common.Size(s: 16))
        label.text = "Ái chà, không tìm thấy tín hiệu internet."
        label.lineBreakMode = .byClipping
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let lbDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: Common.Size(s: 14))
        label.text = "Thôi rồi, bạn đã bị mất kết nối với thới giới hiện đại. Kiểm tra và thử lại nha?"
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    
    let vContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(white: 1, alpha: 0.8)
        view.addSubview(vContainer)
        vContainer.fill()
        
        vContainer.addSubview(lbTitle)
        lbTitle.centerY(inView: vContainer)
        lbTitle.myAnchorWithUIEdgeInsets(top: nil, leading: vContainer.leadingAnchor, bottom: nil, trailing: vContainer.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50), size: CGSize(width: 0, height: 60))
        
        vContainer.addSubview(lbDescription)
        lbDescription.myAnchorWithUIEdgeInsets(top: lbTitle.bottomAnchor, leading: vContainer.leadingAnchor, bottom: nil, trailing: vContainer.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16), size: CGSize(width: 0, height: 50))
        //        view.addSubview(lbDescription)
    }
}
