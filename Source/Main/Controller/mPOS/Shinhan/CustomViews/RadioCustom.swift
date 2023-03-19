//
//  RadioCustom.swift
//  IOSStoryborad
//
//  Created by Ngoc Bao on 03/12/2021.
//

import UIKit
protocol RadioCustomDelegate {
    func onClickRadio(radioView: UIView, tag: Int)
}

@IBDesignable
class RadioCustom: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imgRadio: UIImageView!
    
    var delegate: RadioCustomDelegate?
    var unselectImg = UIImage(named: "unselected_radio_ic")
    var selectedImg = UIImage(named: "selected_radio_ic")
    var isSelect = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public func commonInit(){
        let bundle = Bundle(for: RadioCustom.self)
        bundle.loadNibNamed("RadioCustom", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setSelect(isSelect: false)
    }
    
    @IBInspectable
    var tagView: Int = 0 { 
        didSet {
            if tagView != 0 {
                self.tag = tagView
            }
        }
    }
    
    @IBInspectable
    var defaultImg: UIImage? = nil {
        didSet {
            if defaultImg != nil {
                unselectImg = defaultImg
                setSelect(isSelect: false)
            }
        }
    }
    
    @IBInspectable
    var selectImg: UIImage? = nil {
        didSet {
            if selectImg != nil {
                selectedImg = selectImg
            }
        }
    }
    
    @IBInspectable
    var textLabel: String = "" { // true: select date , false: txt normal
        didSet {
            if !textLabel.isEmpty {
                titleLabel.text = textLabel
            }
        }
    }
    
    func setSelect(isSelect: Bool) {
        imgRadio.image = isSelect ? selectedImg : unselectImg
        self.isSelect = isSelect
    }
    
    @IBAction func onAction(_ sender: Any) {
        delegate?.onClickRadio(radioView: self,tag: self.tag)
    }

}
