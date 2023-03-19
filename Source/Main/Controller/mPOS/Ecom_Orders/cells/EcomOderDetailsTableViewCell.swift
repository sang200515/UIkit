//
//  EcomOderDetailsTableViewCell.swift
//  CustomAlert
//
//  Created by Trần Văn Dũng on 03/03/2022.
//

import UIKit

class EcomOderDetailsTableViewCell: UITableViewCell {
    
    var model:EcomOrderDetails?{
        didSet {
            self.bindingData()
        }
    }
    
    let sttLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    let contentLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    let viewContent:UIView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.bindingData()
        self.layoutView()
    }
    
    private func layoutView(){
        self.addSubview(self.sttLabel)
        self.addSubview(self.contentLabel)
        self.addSubview(self.viewContent)
        self.sttLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(100)
        }
        self.contentLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.sttLabel.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.trailing.equalToSuperview().offset(-10)
        }
        self.viewContent.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(self.sttLabel.snp.trailing)
        }

        self.addBottomBorder(with: UIColor.mainGreen, andWidth: 1)
        self.addLeftBorder(with: UIColor.mainGreen, andWidth: 1)
        self.addRightBorder(with: UIColor.mainGreen, andWidth: 1)
        self.viewContent.addLeftBorder(with: UIColor.mainGreen, andWidth: 1)
        
    }
    
    private func bindingData(){
        guard let model = self.model else { return }
        self.sttLabel.text = model.stt
        let nameAndImei = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.darkGray]
        let price = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .semibold), NSAttributedString.Key.foregroundColor : UIColor.red]
        let nameAndImeiString = NSMutableAttributedString(string:"\(model.uItmName)\nIMEI : \(model.uImei)", attributes:nameAndImei)
        let doubleNum:Double = Double("\(model.uItemPri)") ?? 0
        let priceString = NSMutableAttributedString(string:"\nGiá : \(Common.convertCurrencyDouble(value: doubleNum)) đ", attributes:price)
        nameAndImeiString.append(priceString)
        self.contentLabel.attributedText = nameAndImeiString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
