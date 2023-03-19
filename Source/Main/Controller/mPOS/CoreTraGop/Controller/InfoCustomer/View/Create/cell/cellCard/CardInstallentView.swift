//
//  CardInstallentView.swift
//  QuickCode
//
//  Created by Sang Trương on 14/07/2022.
//

import UIKit
protocol CardInstallentViewDelegate {
    func onClickCardBtn(cardView: UIView)
}

@IBDesignable
class CardInstallentView: UIView {

    @IBOutlet weak var titleHeader: UILabel!

    @IBOutlet weak var imgCard: UIImageView!

    @IBOutlet weak var arrowImg: UIImageView!

    var delegate: CardInstallentViewDelegate?
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
        let bundle = Bundle(for: CardInstallentView.self)
        bundle.loadNibNamed("CardInstallentView", owner: self, options: nil)
//        addSubview(contentView)
//        contentView.frame = bounds
//        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onClickHeader))
        arrowImg.addGestureRecognizer(gesture)
        onExpand()
    }

    @objc func onClickHeader() {
        self.isExpand = !self.isExpand
        onExpand()
        delegate?.onClickCardBtn(cardView: self)
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

