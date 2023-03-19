//
//  ProcessView.swift
//  mPOS
//
//  Created by sumi on 11/17/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit

class ProcessView: UIView {
    var iconProcess : UIImageView!
    let myimgArr = ["64-1","64-2","64-3","64-4","64-5","64-6","64-7","64-8"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        iconProcess  = UIImageView(frame:CGRect(x: ((UIScreen.main.bounds.size.width) - 50 ) / 2 , y: ((UIScreen.main.bounds.size.height) - 50 ) / 2, width: 50, height: 50));
        iconProcess.image = UIImage(named:"64-1")
        iconProcess.contentMode = .scaleAspectFit
        iconProcess.animationImages = [UIImage(named: "64-1")!,UIImage(named: "64-2")!,UIImage(named: "64-3")!,UIImage(named: "64-4")!,UIImage(named: "64-5")!,UIImage(named: "64-6")!,UIImage(named: "64-7")!,UIImage(named: "64-8")!]
        addSubview(iconProcess)
        iconProcess.startAnimating()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
}
