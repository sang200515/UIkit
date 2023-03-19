//
//  DetailTimeWorkInMonth.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/26/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DetailTimeWorkInMonthScreen: BaseController {
    
    private let date = Date()
    private let calendar = Calendar.current
    private var datesPicked: [String]?
    
    let vMainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var month: String?
    
    let vHeader: HeaderDetailTimeWorkInMonthView = {
        let view = HeaderDetailTimeWorkInMonthView()
        return view
    }()
    
    let vPickerDate: PickerDateView = {
        let view = PickerDateView()
        return view
    }()
    
    let vListDetailTimeWorkingInMonth: ListDetailTimeWorkInMonthView = {
        let view = ListDetailTimeWorkInMonthView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func getData() {
        super.getData()
        getDataDetailWorkHour()
    }
    
    override func setupViews() {
        super.setupViews()
        self.title = "Lương giờ công theo ngày"
        self.view.addSubview(vMainContainer)
        vMainContainer.myCustomAnchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vMainContainer.addSubview(vHeader)
        vHeader.myCustomAnchor(top: vMainContainer.topAnchor, leading: vMainContainer.leadingAnchor, trailing: vMainContainer.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 10, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 120)
        
        vMainContainer.addSubview(vPickerDate)
        vPickerDate.myCustomAnchor(top: vHeader.bottomAnchor, leading: vMainContainer.leadingAnchor, trailing: vMainContainer.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 16, trailingConstant: 10, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 40)
        vPickerDate.pickerDateViewDelegate = self
        
        vMainContainer.addSubview(vListDetailTimeWorkingInMonth)
        vListDetailTimeWorkingInMonth.myCustomAnchor(top: vPickerDate.bottomAnchor, leading: vPickerDate.leadingAnchor, trailing: vPickerDate.trailingAnchor, bottom: vMainContainer.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 20, leadingConstant: 0, trailingConstant: 0, bottomConstant: 16, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func getDetailInMonth(_ month: String) {
        self.month = month
        vPickerDate.getMonth(month)
    }
    
    fileprivate func getDataDetailWorkHour() {
        let yearCurrent = calendar.component(.year, from: date)
        
        if let userInside = UserDefaults.standard.getUsernameEmployee() {
            self.showLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                MyInfoAPIManager.shared.getTotalTimeWorkInMont(userInside, self.month ?? "", "\(yearCurrent)") {[weak self] (result, error) in
                    guard let strongSelf = self else {return}
                    strongSelf.stopLoading()
                    if let itemValueUnitHour = result?.donGiaGioCongs {
                        strongSelf.vHeader.getDataDetailTimeWorkInMonth(itemValueUnitHour, strongSelf.month ?? "", year: "\(yearCurrent)")
                    }
                    if let itemDetailWorkingInMonth = result?.gioCongDuyets {
                        strongSelf.vListDetailTimeWorkingInMonth.getApprovedTime(itemDetailWorkingInMonth)
                    }
                }
            }
        }
    }
}

extension DetailTimeWorkInMonthScreen: PickerDateViewDelegate {
    func getDatesPicker(_ dates: [String]) {
        self.datesPicked = dates
        self.vListDetailTimeWorkingInMonth.getDatesPicked(dates)
    }
}
