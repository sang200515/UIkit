//
//  UpdateHinhAnhTableViewCell.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 19/05/2022.
//

import UIKit

protocol UpdateHinhAnhTableViewCellDelegate:AnyObject {
    func didSelected(fileID:Int)
}

class UpdateHinhAnhTableViewCell : UITableViewCell, UploadImageViewDelegate {
    
    var model:UpdateHinhAnhMiraeEntity.EditableField? {
        didSet {
            self.bindingData()
        }
    }
  
    weak var delegate:UpdateHinhAnhTableViewCellDelegate?
    
    let titleLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "CHÂN DUNG KHÁCH HÀNG (*)"
        return label
    }()
    
    let hinhCanUpImageView:UploadImageView = {
        let imageView = UploadImageView()
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.titleLabel)
        self.addSubview(self.hinhCanUpImageView)
        self.hinhCanUpImageView.delegate = self
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        self.hinhCanUpImageView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(150)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindingData(){
        self.titleLabel.text = ""
        self.hinhCanUpImageView.imageSet = UIImage(named: "UploadPhotoICON")
        
        var fileID:String = ""
        if self.model?.fieldID == 1 {
            fileID = "CMND/CCCD Mặt trước"
        }else
        if self.model?.fieldID == 2 {
            fileID = "CMND/CCCD Mặt sau"
        }else
        if self.model?.fieldID == 3 {
            fileID = "Chân dung khách hàng"
        }else
        if self.model?.fieldID == 4 {
            fileID = "Giấy phép lái Mặt trước"
        }else
        if self.model?.fieldID == 5 {
            fileID = "Giấy phép lái Mặt sau"
        }else {
            fileID = "Sổ hộ khẩu"
        }
        self.titleLabel.text = fileID
        if let image = self.model?.image {
            self.hinhCanUpImageView.imageSet = image
        }

    }
    
    func selectedTapped(tag: Int) {
        self.delegate?.didSelected(fileID: self.model?.fieldID ?? 0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}
