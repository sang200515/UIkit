//
//  QuestionsButton.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 26/10/2022.
//

import UIKit
import SnapKit

class QuestionsButton : UIView {
    
    lazy var checkBox:CheckBoxButton = {
        let button = CheckBoxButton()
        button.isChecked = false
        button.uncheckedImage = UIImage(named: "unCheckQS")!
        button.checkedImage = UIImage(named: "CheckQS")!
        return button
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.checkBox)
        self.addSubview(self.titleLabel)
        
        self.checkBox.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.width.equalTo(25)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.checkBox.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview()
        }
		let viewP:UIView = UIView()
		self.addSubview(viewP)
		viewP.snp.makeConstraints { make in
			make.top.leading.trailing.bottom.equalToSuperview()
		}
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
