//
//  TotalTimeTwoMonthsScreen.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/23/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class TotalTimeTwoMonthsScreen: BaseController {
    
    let vListTotalTimeTwoMonths: ListTotalTimeTwoMonthsView = {
        let view = ListTotalTimeTwoMonthsView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func setupViews() {
        super.setupViews()
        self.title = "Giờ công"
        self.view.backgroundColor = Constants.COLORS.main_color_white
        self.navigationController?.navigationBar.barTintColor = Constants.COLORS.bold_green
        self.navigationController?.navigationBar.isTranslucent = false
        view.addSubview(vListTotalTimeTwoMonths)
        vListTotalTimeTwoMonths.myCustomAnchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        vListTotalTimeTwoMonths.listTotalTimeTwoMonthsViewDelegate = self
    }
    
    override func getData() {
        super.getData()
        getDataTotalTimeTwoMonth()
    }
    
    fileprivate func getDataTotalTimeTwoMonth() {
        if let userInside = UserDefaults.standard.getUsernameEmployee() {
            self.showLoading()
            MyInfoAPIManager.shared.getTotalTimeTwoMonths(userInside) {[weak self] (result, err) in
                guard let strongSelf = self else {return}
                if let items = result {
                    strongSelf.vListTotalTimeTwoMonths.getTotalTimeTwoMonthsData(items)
                    strongSelf.stopLoading()
                } else {
                    strongSelf.showPopUp(err ?? "", "Thông báo tổng giờ công hai tháng", buttonTitle: "Ok") {
                        strongSelf.dismiss(animated: true, completion: nil)
                    }
                }
                strongSelf.stopLoading()
            }
        }
    }
}

extension TotalTimeTwoMonthsScreen: ListTotalTimeTwoMonthsViewDelegate {
    func pushToDetailWorkTime(_ data: String) {
        let detailWorkInMonth = DetailTimeWorkInMonthScreen()
        detailWorkInMonth.getDetailInMonth(data)
        self.navigationController?.pushViewController(detailWorkInMonth, animated: true)
    }
}
