//
//  HeaderInfo.swift
//  fptshop
//
//  Created by Ngoc Bao on 06/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
protocol HeaderInfoDelegate {
    func onClickHeader(headerView: UIView)
}

@IBDesignable
class HeaderInfo: UIView {
    
    @IBOutlet weak var titleHeader: UILabel!
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var arrowImg: UIImageView!
    
    var delegate: HeaderInfoDelegate?
    var expand_more = UIImage(named: "expand_more")
    var expand_less = UIImage(named: "expand_less")
    var isExpand = true
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public func commonInit(){
        let bundle = Bundle(for: HeaderInfo.self)
        bundle.loadNibNamed("HeaderInfo", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onClickHeader))
        contentView.addGestureRecognizer(gesture)
        onExpand()
    }
    
    @objc func onClickHeader() {
        self.isExpand = !self.isExpand
        onExpand()
        delegate?.onClickHeader(headerView: self)
    }
    
    func onExpand() {
        arrowImg.image = self.isExpand ? expand_more : expand_less
    }
    
    @IBInspectable
    var title: String = "" {
        didSet {
            if !title.isEmpty {
                titleHeader.text = title
            }
        }
    }
    
    @IBInspectable
    var tagView: Int = 0 {
        didSet {
            if tagView != 0 {
                self.tag = tagView
            }
        }
    }
}
