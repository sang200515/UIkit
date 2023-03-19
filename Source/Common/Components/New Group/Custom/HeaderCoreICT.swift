//
//  HeaderCoreICT.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 17/10/2022.
//

import UIKit

class HeaderCoreICT : UIView {

    var titleString:String? {
        didSet {
            self.titleHeader.text = self.titleString ?? ""
        }
    }
    
    let titleHeader:UILabel = {
        let label = UILabel()
        label.text = "Header"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor(hexString: "#015524")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.titleHeader)
        self.titleHeader.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
