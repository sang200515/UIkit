//
//  PopUpMiraeLPMSViewController.swift
//  fptshop
//
//  Created by Trần Văn Dũng on 13/05/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol PopUpMiraeLPMSViewControllerDelegate:AnyObject {
    func thueMay()
    func traGop()
}

class PopUpMiraeLPMSViewController : BaseViewController {
    
    weak var delegate:PopUpMiraeLPMSViewControllerDelegate?
    
    private let parentView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        return view
    }()
    
    let titleLabel:BaseLabel = {
        let label = BaseLabel()
        label.addBottomBorder(with: .lightGray, andWidth: 0.5)
        label.textColor = .mainGreen
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "VUI LÒNG CHỌN"
        label.textAlignment = .center
        return label
    }()
    
    let traGopButton:BaseButton = {
        let button = BaseButton()
        button.addTarget(self, action: #selector(traGopTapped), for: .touchUpInside)
        button.setTitle("TRẢ GÓP MIRAE", for: .normal)
        return button
    }()
    
    let thueMayButton:BaseButton = {
        let button = BaseButton()
        button.backgroundColor = Common.TraGopMirae.Color.blue
        button.addTarget(self, action: #selector(thueMayTapped), for: .touchUpInside)
        button.setTitle("THUÊ MÁY COMP", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        self.view.addSubview(self.parentView)
        self.parentView.addSubview(self.titleLabel)
        self.parentView.addSubview(self.traGopButton)
        self.parentView.addSubview(self.thueMayButton)
        
        self.parentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 20)
            make.height.equalTo(130)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
        }
        self.traGopButton.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(self.view.snp.centerX).offset(-5)
            make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
        }
        self.thueMayButton.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalTo(self.view.snp.centerX).offset(5)
            make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
        }
    }
    
    @objc private func traGopTapped(){
        PARTNERID = "FPT"
        self.dismiss(animated: true) {
            self.delegate?.traGop()
        }
    }
    
    @objc private func thueMayTapped(){
        PARTNERID = "FPTC"
        self.dismiss(animated: true) {
            self.delegate?.thueMay()
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != self.parentView {
            self.dismiss(animated: true)
        }
    }
}
