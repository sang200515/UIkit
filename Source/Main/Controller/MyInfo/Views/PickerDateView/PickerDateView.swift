//
//  PickerDateView.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/27/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

protocol PickerDateViewDelegate: AnyObject {
    func getDatesPicker(_ dates: [String])
}

class PickerDateView: BaseView {
    weak var pickerDateViewDelegate: PickerDateViewDelegate?
    private var dateFromPicker = ActionSheetDatePicker()
    private var dateToPicker = ActionSheetDatePicker()
    private var addMonths: Int?
    private var selectedFromDate : Date?
    private var selectedToDate : Date?
    private var minimumDate = Date.today()
    
    let lbTtitleDatePicker: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.TextSizes.size_13)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Chi tiết giờ công: "
        return label
    }()
    
    let vImageTo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "ic_to")
        return imageView
    }()
    
    let lbFromDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 13)
        label.textColor = .black
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    let lbToDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 13)
        label.textColor = .black
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    let vContainerFromDate: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let vContainerToDate: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = .clear
        self.addSubview(lbTtitleDatePicker)
        lbTtitleDatePicker.myCustomAnchor(top: nil, leading: self.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: self.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 8, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        setupStackView()
        lbFromDate.addTapGestureRecognizer {
            self.setupPickerFromDate()
            self.getDatesSelected()
        }
        
        vImageTo.myCustomAnchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 15, heightConstant: 15)
        
        lbToDate.addTapGestureRecognizer {
            self.setupPickerToDate()
            self.getDatesSelected()
        }
        
    }
    
    func getMonth(_ month: String) {
        var dateComponents = DateComponents()
        let userCalendar = Calendar.current
        let now = Date()
        dateComponents.month = Int(month)
        dateComponents.year = Calendar.current.component(.year, from: now)
        dateComponents.timeZone = TimeZone(abbreviation: "GMT")!
        DispatchQueue.main.async {
            if let someDateTime = userCalendar.date(from: dateComponents) {
                self.selectedFromDate = someDateTime
                self.selectedToDate = someDateTime.getDayAfter(date: 30)
                if let dateToFormat = self.selectedToDate?.toString(dateFormat: Constants.Values.date_format), let fromDateFormat = self.selectedFromDate?.toString(dateFormat: Constants.Values.date_format) {
                    self.lbToDate.text             = "\(dateToFormat)▼"
                    self.lbFromDate.text           = "\(fromDateFormat)▼"
                }
            }
        }
    }
    
    fileprivate func setupPickerFromDate() {
        dateFromPicker = ActionSheetDatePicker(title: "", datePickerMode: .date, selectedDate: self.selectedFromDate, doneBlock: { (pick, date, index) in
            if let item = date as? Date {
                self.selectedFromDate = item
                self.lbFromDate.text = "\(item.toString(dateFormat: Constants.Values.date_format))▼"
                self.getDatesSelected()
            }
        }, cancel: { (picker) in
        }, origin: self.lbFromDate)
        dateFromPicker.maximumDate = selectedToDate
        dateFromPicker.show()
    }
    
    fileprivate func setupPickerToDate() {
        dateToPicker = ActionSheetDatePicker(title: "", datePickerMode: .date, selectedDate: self.selectedToDate, doneBlock: { (pick, date, index) in
            if let item = date as? Date {
                self.selectedToDate = item
                self.lbToDate.text = "\(item.toString(dateFormat: Constants.Values.date_format))▼"
                self.getDatesSelected()
            }
        }, cancel: { (picker) in
        }, origin: self.lbToDate)
        dateToPicker.minimumDate = selectedFromDate
        dateToPicker.maximumDate = Date.today()
        dateToPicker.show()
        
    }
    
    fileprivate func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [lbFromDate, vImageTo, lbToDate])
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.backgroundColor = .clear
        stackView.distribution = .fill
        
        self.addSubview(stackView)
        stackView.myCustomAnchor(top: nil, leading: lbTtitleDatePicker.trailingAnchor, trailing: self.trailingAnchor, bottom: nil, centerX: nil, centerY: self.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 20, trailingConstant: 2, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    fileprivate func getDatesSelected() {
        let datesSelected = Date().datesRange(from: selectedFromDate ?? Date(), to: selectedToDate ?? Date())
        var datesConvert: [String] = []
        for date in datesSelected {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter.dateStyle = .short
            let strDate = dateFormatter.string(from: date)
            datesConvert.append(strDate)
        }
        pickerDateViewDelegate?.getDatesPicker(datesConvert)
    }
}
