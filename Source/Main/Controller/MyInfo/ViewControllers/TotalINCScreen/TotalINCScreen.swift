//
//  TotalINCScreen.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/24/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class TotalINCScreen: BaseController {
    
    let vMainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.COLORS.main_color_white
        return view
    }()
    
    let vHeader: HeaderINCView = {
        let view = HeaderINCView()
        return view
    }()
    
    let vContainerListINC: ListTotalINCView = {
        let view = ListTotalINCView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func getData() {
        super.getData()
        getTotalINC()
    }
    
    
    override func setupViews() {
        super.setupViews()
        self.title = "INC tạm tính"
        self.view.backgroundColor = Constants.COLORS.main_color_white
        self.navigationController?.navigationBar.barTintColor = Constants.COLORS.bold_green
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.addSubview(vMainContainer)
        vMainContainer.fill()
        
        self.vMainContainer.addSubview(vHeader)
        vHeader.myCustomAnchor(top: self.vMainContainer.topAnchor, leading: self.vMainContainer.leadingAnchor, trailing: self.vMainContainer.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 10, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 80)
        
        self.vMainContainer.addSubview(vContainerListINC)
        vContainerListINC.myCustomAnchor(top: vHeader.bottomAnchor, leading: vHeader.leadingAnchor, trailing: vHeader.trailingAnchor, bottom: vMainContainer.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 8, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    fileprivate func getTotalINC() {
        if let userInse = UserDefaults.standard.getUsernameEmployee() {
            self.showLoading()
            MyInfoAPIManager.shared.getTotalINC(userInse) {[weak self] (result, err) in
                guard let strongSelf = self else {return}
                if let item = result {
                    if !item.children!.isEmpty {
                        guard let valueTotalINC = item.value else {return}
                        strongSelf.vHeader.getData(valueTotalINC)
                        strongSelf.vContainerListINC.getToTalINCItem(item)
                        strongSelf.stopLoading()
                    } else {
                        strongSelf.showPopUp("Không có giữ liệu, vui lòng thử lại sau", "Thông báo INC tạm tính", buttonTitle: "Đồng ý")
                        strongSelf.stopLoading()
                    }
                    
                } else {
                    strongSelf.showPopUp(err ?? "", "Thông báo INC tạm tính", buttonTitle: "Đồng ý") {
                        strongSelf.navigationController?.popViewController(animated: true)
                    }
                    strongSelf.stopLoading()
                }
            }
        }
    }
    
}
