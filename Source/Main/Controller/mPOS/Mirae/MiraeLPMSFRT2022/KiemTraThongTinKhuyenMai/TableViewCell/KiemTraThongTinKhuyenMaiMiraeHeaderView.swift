//
//  KiemTraThongTinKhuyenMaiMiraeHeaderView.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 20/04/2022.
//

import UIKit

protocol KiemTraThongTinKhuyenMaiMiraeHeaderViewDelegate:AnyObject {
    func selectedRowHeader(row:Int)
    func expandedRowHeader(row:Int, isExpanded:Bool)
}

class KiemTraThongTinKhuyenMaiMiraeHeaderView : UIView {
    
    var model:TestModel?{
        didSet {
            self.bindingData()
        }
    }
    
    var isExpanded:Bool = false
    
    weak var delegate:KiemTraThongTinKhuyenMaiMiraeHeaderViewDelegate?
    
    lazy var selectedButton:RadioCustom = {
        let button = RadioCustom()
        button.titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        button.titleLabel.textColor = .mainGreen
        return button
    }()
    
    lazy var expandedButton:UIButton = {
        let button = UIButton()
        let image = UIImage(named: "ExpandableICON")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    var row:Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.autoLayout()
        self.configureButton()
        self.backgroundColor = .white
    }
    
    private func addView(){
        self.addSubview(self.selectedButton)
        self.addSubview(self.expandedButton)
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func autoLayout(){
        self.selectedButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
        self.expandedButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.selectedButton.snp.trailing).offset(5)
            make.height.equalTo(15)
            make.width.equalTo(100)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton(){
        self.expandedButton.addTarget(self, action: #selector(self.expandedTapped), for: .touchUpInside)
        self.selectedButton.delegate = self
    }
    
    private func bindingData() {
        self.selectedButton.titleLabel.text = self.model?.hedearTitle
        if self.model?.isSelected ?? false {
            self.selectedButton.setSelect(isSelect: true)
        }else {
            self.selectedButton.setSelect(isSelect: false)
        }
    }
    
    @objc private func expandedTapped(){
        self.delegate?.expandedRowHeader(row: row,isExpanded: self.isExpanded)
    }
    
}

extension KiemTraThongTinKhuyenMaiMiraeHeaderView : RadioCustomDelegate {
    func onClickRadio(radioView: UIView, tag: Int) {
        self.delegate?.selectedRowHeader(row: self.row)
    }
}
