//
//  SelectTextField.swift
//  BaoCaoHinhAnhTrungBay
//
//  Created by Trần Văn Dũng on 09/07/2021.
//

import UIKit
import SnapKit

protocol SelectTextFieldDelegate:class {
    func selectTextField(index:Int)
}

class SelectTextField: UITextField {
    
    let viewSelected:UIView = {
        let view = UIView()
        return view
    }()
    
    let dropDownImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "down-arrow")
        return imageView
    }()
    
    weak var selectTextFieldDelegate:SelectTextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderStyle = .roundedRect
        self.font = .systemFont(ofSize: 15)
        
        self.addSubview(self.dropDownImageView)
        self.dropDownImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.height.width.equalTo(15)
        }
        
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.selectTextField))
        self.viewSelected.addGestureRecognizer(gesture)
        self.addSubview(self.viewSelected)
        self.viewSelected.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectTextField(sender : UITapGestureRecognizer) {
        self.selectTextFieldDelegate?.selectTextField(index: self.tag)
    }
}
