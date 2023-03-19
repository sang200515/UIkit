//
//  LichSuTraGopMiraeView.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 21/04/2022.
//

import UIKit
import DropDown

class LichSuTraGopMiraeView : UIView {
    
    let refreshControl = UIRefreshControl()
    var dropDown:DropDown?
    
    lazy var hoSoCanXuLyButton:ButtonUnderLine = {
        let button = ButtonUnderLine()
        button.setTitle("HS CẦN XỬ LÝ", for: .normal)
        button.addRightBorder(with: .lightGray, andWidth: 0.5)
        button.addBottomBorder(with: .mainGreen, andWidth: 2)
        button.setTitleColor(.darkGray, for: .normal)
        button.tag = 1
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        return button
    }()
    
    lazy var danhSachHoSoButton:ButtonUnderLine = {
        let button = ButtonUnderLine()
        button.tag = 2
        button.setTitle("DANH SÁCH HS", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        return button
    }()
    
    lazy var lichSuTableView:BaseTableView = {
        let tableView = BaseTableView()
        tableView.configureRefreshControl()
        tableView.separatorStyle = .none
        tableView.register(LichSuTraGopMiraeTableViewCell.self,
                           forCellReuseIdentifier: Common.TraGopMirae.identifierTableViewCell.lichSuTraGop)
        return tableView
    }()
    
    lazy var searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.layer.borderWidth = 0.5
        searchBar.layer.cornerRadius = 5
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.textField?.backgroundColor = .clear
        searchBar.placeholder = "Nhập thông tin tìm kiếm"
        searchBar.clearBackgroundColor()
        return searchBar
    }()
    
    lazy var optionTextField:SelectTextField = {
        let textField = SelectTextField()
        textField.borderStyle = .none
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.dropDownImageView.image = UIImage(named: "arrowDropICON")
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.autoLayout()
    }
    
    private func addView(){
        self.addSubview(self.hoSoCanXuLyButton)
        self.addSubview(self.danhSachHoSoButton)
        self.addSubview(self.optionTextField)
        self.addSubview(self.searchBar)
        self.addSubview(self.lichSuTableView)
    }
    
    private func autoLayout(){
        self.hoSoCanXuLyButton.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide)
            make.trailing.equalTo(self.snp.centerX)
            make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
        }
        self.danhSachHoSoButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(self.snp.centerX)
            make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
        }
        self.optionTextField.snp.makeConstraints { make in
            make.top.equalTo(self.hoSoCanXuLyButton.snp.bottom).offset(10)
            make.leading.equalTo(self.hoSoCanXuLyButton).offset(10)
            make.height.equalTo(35)
            make.trailing.equalTo(self.snp.centerX).offset(-50)
        }
        self.searchBar.snp.makeConstraints { make in
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-10)
            make.top.equalTo(self.optionTextField)
            make.bottom.equalTo(self.optionTextField)
            make.leading.equalTo(self.optionTextField.snp.trailing).offset(5)
        }
        self.lichSuTableView.snp.makeConstraints { make in
            make.top.equalTo(self.searchBar.snp.bottom).offset(10)
            make.leading.equalTo(self.optionTextField)
            make.trailing.equalTo(self.searchBar)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
