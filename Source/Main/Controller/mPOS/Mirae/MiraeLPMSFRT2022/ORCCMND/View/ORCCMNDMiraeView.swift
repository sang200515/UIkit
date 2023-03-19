//
//  ORCCMNDMiraeView.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 09/05/2022.
//

import UIKit

class ORCCMNDMiraeView : UIView {
    
    let cmndMatTruocLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "CMND/CCCD Mặt trước (*)"
        return label
    }()
    
    let luuYLabel:BaseLabel = {
        let label = BaseLabel()
        label.textColor = .red
        label.backgroundColor = .white
        label.text = "Lưu ý"
        return label
    }()
    
    let viewLuuY:UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        return view
    }()
    
    let luuYContentLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Trước khi lên hồ sơ bạn vui lòng hướng dẫn khách hàng thao tác soạn tin nhắn chia sẻ điểm như sau:\n • Vinaphone: “DK MAFC” gửi 9115\n • Mobiphone: “DK MAFC” gửi 90004\n • Viettel:\n    • 2 số cuối từ 00-40: “DK MAFC” gửi 5998\n    • 2 số cuối từ 41-99: không cần gửi tin nhắn"
        return label
    }()
    
    let cmndMatSauLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "CMND/CCCD Mặt sau (*)"
        return label
    }()
    
    let cmndMatTruocImageView:UploadImageView = {
        let imageView = UploadImageView()
        imageView.tag = 0
        return imageView
    }()
    
    let cmndMatSauImageView:UploadImageView = {
        let imageView = UploadImageView()
        imageView.tag = 1
        return imageView
    }()
    
    lazy var nextButton:BaseButton = {
        let button = BaseButton()
        button.title = "TIẾP TỤC"
        return button
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentSize = self.frame.size
        sv.showsHorizontalScrollIndicator = false
        sv.contentInsetAdjustmentBehavior = .never
        sv.keyboardDismissMode = .interactive
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView(){
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.cmndMatTruocLabel)
        self.scrollView.addSubview(self.cmndMatSauLabel)
        self.scrollView.addSubview(self.cmndMatTruocImageView)
        self.scrollView.addSubview(self.cmndMatSauImageView)
        self.scrollView.addSubview(self.nextButton)
        self.scrollView.addSubview(self.luuYContentLabel)
        self.scrollView.addSubview(self.viewLuuY)
        self.scrollView.addSubview(self.luuYLabel)
    }
    
    private func autoLayout(){
        self.scrollView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.top.equalTo(self.safeAreaLayoutGuide)
        }
        self.cmndMatTruocLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-10)
        }
        self.cmndMatTruocImageView.snp.makeConstraints { make in
            make.top.equalTo(self.cmndMatTruocLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.cmndMatTruocLabel)
            make.height.greaterThanOrEqualTo(150)
        }
        self.cmndMatSauLabel.snp.makeConstraints { make in
            make.top.equalTo(self.cmndMatTruocImageView.snp.bottom).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-10)
        }
        self.cmndMatSauImageView.snp.makeConstraints { make in
            make.top.equalTo(self.cmndMatSauLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.cmndMatTruocLabel)
            make.height.greaterThanOrEqualTo(150)
        }
        self.nextButton.snp.makeConstraints { make in
            make.top.equalTo(self.cmndMatSauImageView.snp.bottom).offset(20)
            make.centerX.equalTo(self.cmndMatSauImageView)
            make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.luuYContentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nextButton.snp.bottom).offset(35)
            make.leading.equalTo(self.cmndMatTruocLabel).offset(10)
            make.trailing.equalTo(self.cmndMatTruocLabel).offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        self.viewLuuY.snp.makeConstraints { make in
            make.top.equalTo(self.luuYContentLabel).offset(-15)
            make.leading.equalTo(self.luuYContentLabel).offset(-10)
            make.bottom.trailing.equalTo(self.luuYContentLabel).offset(10)
        }
        self.luuYLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.viewLuuY.snp.top)
            make.leading.equalTo(self.luuYContentLabel).offset(10)
        }
    }
    
}
