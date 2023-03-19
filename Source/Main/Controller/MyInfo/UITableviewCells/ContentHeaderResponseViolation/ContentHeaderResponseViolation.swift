//
//  ContentHeaderResponseViolation.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/31/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol ContentHeaderResponseViolationDelegate {
    func toggleSection(header: ContentHeaderResponseViolation, section: Int)
    func selectedType(_ type: Int)
    
}

class ContentHeaderResponseViolation: UITableViewHeaderFooterView {
    private var valuesRating: [Int] = [1, 2]
    private var isSelected: Bool = false
    private var selectedIndex: Int = 3
    var delegate: ContentHeaderResponseViolationDelegate?
    var section: Int!
    var isRotate: Bool?
    
    let lbTitleView: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "PHẢN HỒI"
        return label
    }()
    
    let vImageIcon: UIImageView = {
        let imgView = UIImageView(image: UIImage(named:"ic_next_right"))
        return imgView
    }()
    
    let btnExpandable: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        return button
    }()
    
    let stackViewResponseStatus: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
        stackView.spacing = 8
        stackView.setBorder(color: Constants.COLORS.text_gray, borderWidth: 0.1, corner: 0)
        return stackView
    }()
    
    let vContainerStatusAfterChosen: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let lbContentStatusAfterChosen: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        return label
    }()
    
    let vImgIconAfterChosen: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        loadListRating(rateList: valuesRating)
        self.addSubview(btnExpandable)
        btnExpandable.fill()
        self.addSubview(vImageIcon)
        vImageIcon.myCustomAnchor(top: nil, leading: self.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: self.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 4, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 20, heightConstant: 20)
        
        self.addSubview(lbTitleView)
        lbTitleView.myCustomAnchor(top: nil, leading: vImageIcon.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: self.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 4, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 90, heightConstant: 0)
        
        self.addSubview(vContainerStatusAfterChosen)
        vContainerStatusAfterChosen.myCustomAnchor(top: nil, leading: lbTitleView.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: self.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 8, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 80, heightConstant: 0)
        
        vContainerStatusAfterChosen.addSubview(vImgIconAfterChosen)
        vImgIconAfterChosen.myCustomAnchor(top: nil, leading: vContainerStatusAfterChosen.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: vContainerStatusAfterChosen.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 20, heightConstant: 20)
        
        vContainerStatusAfterChosen.addSubview(lbContentStatusAfterChosen)
        lbContentStatusAfterChosen.myCustomAnchor(top: nil, leading: vImgIconAfterChosen.trailingAnchor, trailing: vContainerStatusAfterChosen.trailingAnchor, bottom: nil, centerX: nil, centerY: vContainerStatusAfterChosen.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 2, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.addSubview(stackViewResponseStatus)
        self.bringSubviewToFront(stackViewResponseStatus)
        stackViewResponseStatus.myCustomAnchor(top: nil, leading: vContainerStatusAfterChosen.trailingAnchor, trailing: self.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 4, trailingConstant: 8, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 180, heightConstant: 50)
        self.contentView.backgroundColor = .white
        self.btnExpandable.addTarget(self, action: #selector(selectHeaderAction(button:)), for: .touchUpInside)
        self.contentView.setBorder(color: Constants.COLORS.text_gray, borderWidth: 0.5, corner: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func selectHeaderAction(button: UIButton) {
        button.tag = section
        delegate?.toggleSection(header: self, section: button.tag)
    }
    
    func setupStatusAfterChosen(_ bool: Bool) {
        if bool == true {
            vImgIconAfterChosen.image = UIImage(named: "ic_face_not_happy")
            lbContentStatusAfterChosen.loadWith(text: "Đồng ý", textColor: Constants.COLORS.light_green, font: UIFont.regularFontOfSize(ofSize: 13), textAlignment: .left)
        } else {
            vImgIconAfterChosen.image = UIImage(named: "ic_face_please")
            lbContentStatusAfterChosen.loadWith(text: "Từ chối", textColor: Constants.COLORS.main_red_my_info, font: UIFont.regularFontOfSize(ofSize: 13), textAlignment: .left)
        }
    }
    
    func showHideViewContaintStatusAfterChosen(_ bool: Bool) {
        self.vContainerStatusAfterChosen.isHidden = bool
    }
    
    func showHideChooseStatus(_ bool: Bool) {
        stackViewResponseStatus.isHidden = bool
    }
    
    func customInit(title: String, section: Int, delegate: ContentHeaderResponseViolationDelegate) {
        self.lbTitleView.text = title
        self.section = section
        self.delegate = delegate
    }
    
    func rotateImage() {
        if isRotate ?? false {
            self.vImageIcon.image = self.vImageIcon.image?.rotate(radians: -.pi / 2)
        } else {
            self.vImageIcon.rotate(degrees: 90)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    func loadListRating(rateList: [Int]) {
        if stackViewResponseStatus.arrangedSubviews.count > 0 {
            for control in self.stackViewResponseStatus.arrangedSubviews {
                self.stackViewResponseStatus.removeArrangedSubview(control)
            }
        }
        
        if rateList.count > 0 {
            self.valuesRating = rateList
            for(index, _) in rateList.enumerated() {
                let cateView = ChooseResponseView.init(frame: .zero)
                cateView.index = index
                if index == 0 {
                    cateView.vImageResponse.image = UIImage.init(named: "ic_face_not_happy")
                    cateView.setTitleStatus("Đồng ý")
                } else if index == 1 {
                    cateView.vImageResponse.image = UIImage.init(named: "ic_face_please")
                    cateView.setTitleStatus("Từ chối")
                }
                cateView.chooseResponseViewDelegate = self
                cateView.translatesAutoresizingMaskIntoConstraints = false
                if cateView.index == selectedIndex {
                    cateView.isSelected = true
                }
                stackViewResponseStatus.addArrangedSubview(cateView)
            }
        }
    }
}

extension ContentHeaderResponseViolation: ChooseResponseViewDelegate {
    func RatingItemViewDelegate_rating(atIndex: Int) {
        DispatchQueue.main.async {
            for control in self.stackViewResponseStatus.arrangedSubviews {
                if let chooseResponseItem = control as? ChooseResponseView {
                    if chooseResponseItem.getViewIndex() == atIndex {
                        UIView.transition(with: chooseResponseItem, duration: 0.15, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
                            chooseResponseItem.isSelected = true
                        }, completion: nil)
                    } else {
                        UIView.transition(with: chooseResponseItem, duration: 0.15, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
                            chooseResponseItem.isSelected = false
                        }, completion: nil)
                    }
                }
                self.selectedIndex = atIndex
            }
        }
        delegate?.selectedType(atIndex + 1)
    }
}
