//
//  LichSuTraGopMiraeTableViewCell.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 21/04/2022.
//

import UIKit

class LichSuTraGopMiraeTableViewCell : UITableViewCell {
    
    var model:LichSuTraGopMiraeEntity.DataLichSuTraGopMiraeModel?{
        didSet {
            self.bindingData()
        }
    }
    
    let maHoSoLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "APP12345"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .mainGreen
        return label
    }()
    
    let timeLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "20/03/1991"
        return label
    }()
    
    let hoTenLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Tên KH :"
        return label
    }()
    
    let hoTenResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let cmndLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "CMND/CCCD :"
        return label
    }()
    
    let cmndResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let soMPOSLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "SO MPOS :"
        return label
    }()
    
    let soMPOSResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let lyDoTuChoiLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Lý do từ chối :"
        return label
    }()
    
    let lyDoTuChoiResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let statusHoSoLabel:BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .mainGreen
        return label
    }()
    
    let viewBoder:UIView = UIView()
    
    let lineTopView:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    let lineBottomView:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addView()
        self.autoLayout()
        self.bindingData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView(){
        self.addSubview(self.maHoSoLabel)
        self.addSubview(self.timeLabel)
        self.addSubview(self.lineTopView)
        self.addSubview(self.hoTenLabel)
        self.addSubview(self.hoTenResultLabel)
        self.addSubview(self.cmndLabel)
        self.addSubview(self.cmndResultLabel)
        self.addSubview(self.soMPOSLabel)
        self.addSubview(self.soMPOSResultLabel)
        self.addSubview(self.lyDoTuChoiLabel)
        self.addSubview(self.lyDoTuChoiResultLabel)
        self.addSubview(self.lineBottomView)
        self.addSubview(self.statusHoSoLabel)
        self.addSubview(self.viewBoder)
    }
    
    private func autoLayout(){
        self.maHoSoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(10)
            make.height.greaterThanOrEqualTo(20)
        }
        self.timeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(self.maHoSoLabel)
        }
        self.lineTopView.snp.makeConstraints { make in
            make.top.equalTo(self.maHoSoLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        self.hoTenLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.maHoSoLabel)
            make.width.equalTo(105)
            make.top.equalTo(self.lineTopView.snp.bottom).offset(10)
        }
        self.hoTenResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.hoTenLabel)
            make.leading.equalTo(self.hoTenLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(20)
        }
        self.cmndLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.hoTenLabel)
            make.width.equalTo(105)
            make.top.equalTo(self.hoTenResultLabel.snp.bottom).offset(10)
        }
        self.cmndResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.cmndLabel)
            make.leading.equalTo(self.cmndLabel.snp.trailing)
            make.trailing.equalTo(self.hoTenResultLabel)
            make.height.greaterThanOrEqualTo(20)
        }
        self.soMPOSLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.hoTenLabel)
            make.width.equalTo(105)
            make.top.equalTo(self.cmndResultLabel.snp.bottom).offset(10)
        }
        self.soMPOSResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.soMPOSLabel)
            make.leading.equalTo(self.soMPOSLabel.snp.trailing)
            make.width.lessThanOrEqualTo(100)
            make.height.greaterThanOrEqualTo(20)
        }
        self.lyDoTuChoiLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(self.soMPOSResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.hoTenLabel)
            make.width.equalTo(105)
        }
        self.lyDoTuChoiResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.lyDoTuChoiLabel)
            make.leading.equalTo(self.lyDoTuChoiLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(20)
        }
        self.lineBottomView.snp.makeConstraints { make in
            make.top.equalTo(self.lyDoTuChoiResultLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.lineTopView)
            make.height.equalTo(0.5)
        }
        self.statusHoSoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.lineBottomView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-15)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(20)
        }
        self.viewBoder.snp.makeConstraints { make in
            make.top.equalTo(self.maHoSoLabel).offset(-10)
            make.leading.equalTo(self.maHoSoLabel).offset(-10)
            make.bottom.equalTo(self.statusHoSoLabel).offset(10)
            make.trailing.equalTo(self.timeLabel).offset(10)
        }
    }
    
    private func bindingData(){
        self.maHoSoLabel.text = self.model?.applicationID ?? ""
        self.hoTenResultLabel.text = self.model?.fullName ?? ""
        self.cmndResultLabel.text = self.model?.idCard ?? ""
        self.soMPOSResultLabel.text = "\(self.model?.soMPOS ?? 0)"
        self.lyDoTuChoiResultLabel.text = self.model?.cancelReason ?? ""
        self.timeLabel.text = self.model?.createDate ?? ""
        self.statusHoSoLabel.text = self.model?.status ?? ""
        self.statusHoSoLabel.textColor = UIColor(hexString: "\(self.model?.statusColor ?? "#15B847")")
        self.viewBoder.layer.cornerRadius = 5
        self.viewBoder.layer.borderColor = UIColor.lightGray.cgColor
        self.viewBoder.layer.borderWidth = 0.5
    }
    
}
