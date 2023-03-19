//
//  PopUpHuongDanCheckKhuyenMaiView.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 10/06/2022.
//

import UIKit

class PopUpHuongDanCheckKhuyenMaiView : UIView {
    
    let parentView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Hướng dẫn check KM Online đơn hàng Mirae"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    let contentLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Bước 1: Đặt đơn hàng Ecom và đẩy về shop" + "\n"
        + "Bước 2: Mở đơn hàng, bấm lưu và chọn khuyến mãi trên POS sau đó bấm [Extra], chọn \"Đẩy SO để đăng kí trả góp Mirae\"" + "" + "\n"
        + "Bước 3: Đọc thông báo và Chọn [Đồng ý] tại thông báo hiện lên" + "\n"
        + "Bước 4: Sau khi hoàn tất đẩy, đơn hàng sẽ tự động tắt và hiện thông báo Đã chuyển sang đơn hàng MPOS, hãy lên MPOS để đăng ký trả góp Mirae" + "" + "\n"
        + "Bước 5: Trên màn hình kiểm tra đặt cọc - Nhập số đơn hàng Ecom vào ô đơn hàng đặt cọc để kéo đơn hàng về MPOS và tạo đơn hàng Mirae" + "\n"
        + "Nếu chưa đăng ký trả góp trên MPOS, khi mở lại đơn hàng vẫn sẽ bị chặn."
        return label
    }()
    
    lazy var closeButton:UIButton = {
        let button = UIButton()
        button.setTitle("Đồng ý", for: .normal)
        button.setTitleColor(.mainGreen, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.parentView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.closeButton)
        self.addSubview(self.contentLabel)
        
        self.contentLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.contentLabel.snp.top).offset(-10)
            make.trailing.leading.equalTo(self.contentLabel)
        }
        self.closeButton.snp.makeConstraints { make in
            make.top.equalTo(self.contentLabel.snp.bottom).offset(10)
            make.trailing.equalTo(self.contentLabel)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        self.parentView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.top).offset(-20)
            make.bottom.equalTo(self.closeButton.snp.bottom).offset(20)
            make.leading.equalTo(self.contentLabel).offset(-10)
            make.trailing.equalTo(self.contentLabel).offset(10)
        }
        self.insertSubview(self.parentView, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
