//
//  VietjetCalendarTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 22/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import FSCalendar

class VietjetCalendarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbMonth: UILabel!
    @IBOutlet weak var vCalendar: FSCalendar!
    
    var calendarDidChange: (() -> Void)?
    private let gregorian = Calendar(identifier: .gregorian)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for d in vCalendar.selectedDates {
            self.vCalendar.deselect(d)
        }
    }
    
    func setupCell(index: Int) {
        let month = Calendar.current.date(byAdding: .month, value: index, to: Date())
        let monthString = "Tháng \(month?.stringWith(format: "M, yyyy") ?? "")"
        lbMonth.text = monthString
    
        vCalendar.register(DIYCalendarCell.self, forCellReuseIdentifier: "cell")
        vCalendar.delegate = self
        vCalendar.dataSource = self
        vCalendar.today = nil
        
        DispatchQueue.main.async {
            self.vCalendar.setCurrentPage(month!, animated: false)
            for d in VietjetDataManager.shared.datesRange ?? [] {
                self.vCalendar.select(d, scrollToDate: false)
            }
            self.configureVisibleCells()
        }
    }
    
    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        if from > to { return [Date]() }
        
        var tempDate = from
        var array = [tempDate]
        
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        
        return array
    }
    
    // MARK: - Private functions
    private func configureVisibleCells() {
        vCalendar.visibleCells().forEach { (cell) in
            let date = vCalendar.date(for: cell)
            let position = vCalendar.monthPosition(for: cell)
            configure(cell: cell, for: date!, at: position)
        }
    }
    
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        
        let diyCell = (cell as! DIYCalendarCell)
        // Configure selection layer
        if position == .current {
            
            var selectionType = SelectionType.none
            
            if vCalendar.selectedDates.contains(date) {
                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date)!
                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date)!
                if vCalendar.selectedDates.contains(date) {
                    if vCalendar.selectedDates.contains(previousDate) && vCalendar.selectedDates.contains(nextDate) {
                        selectionType = .middle
                    }
                    else if vCalendar.selectedDates.contains(previousDate) && vCalendar.selectedDates.contains(date) {
                        selectionType = .rightBorder
                    }
                    else if vCalendar.selectedDates.contains(nextDate) {
                        selectionType = .leftBorder
                    }
                    else {
                        selectionType = .single
                    }
                }
            }
            else {
                selectionType = .none
            }
            if selectionType == .none {
                diyCell.selectionLayer.isHidden = true
                return
            }
            
            diyCell.selectionLayer.isHidden = false
            diyCell.selectionType = selectionType
        } else {
            diyCell.selectionLayer.isHidden = true
        }
    }
}

extension VietjetCalendarTableViewCell: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if date < Calendar.current.startOfDay(for: Date()) {
            return false
        }
        
        return true
    }
    
    // MARK:- FSCalendarDataSource
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        configure(cell: cell, for: date, at: position)
    }
    
    // MARK:- FSCalendarDelegate
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // nothing selected:
        if VietjetDataManager.shared.firstDate == nil {
            VietjetDataManager.shared.firstDate = date
            VietjetDataManager.shared.datesRange = [VietjetDataManager.shared.firstDate!]
            
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            configureVisibleCells()
            calendarDidChange?()
            return
        }
        
        // only first date is selected:
        if VietjetDataManager.shared.firstDate != nil && VietjetDataManager.shared.lastDate == nil {
            // handle the case of if the last date is less than the first date:
            if VietjetDataManager.shared.isOneWay {
                VietjetDataManager.shared.firstDate = date
                VietjetDataManager.shared.datesRange = [VietjetDataManager.shared.firstDate!]
            } else {
                if date <= VietjetDataManager.shared.firstDate! {
                    VietjetDataManager.shared.lastDate = VietjetDataManager.shared.firstDate
                    VietjetDataManager.shared.firstDate = date
                    VietjetDataManager.shared.datesRange = datesRange(from: VietjetDataManager.shared.firstDate!, to: VietjetDataManager.shared.lastDate!)
                } else {
                    let range = datesRange(from: VietjetDataManager.shared.firstDate!, to: date)
                    VietjetDataManager.shared.lastDate = range.last
                    VietjetDataManager.shared.datesRange = range
                }
            }
            
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            for d in VietjetDataManager.shared.datesRange ?? [] {
                calendar.select(d, scrollToDate: false)
            }
            configureVisibleCells()
            calendarDidChange?()
            return
        }
        
        // both are selected:
        if VietjetDataManager.shared.firstDate != nil && VietjetDataManager.shared.lastDate != nil {
            VietjetDataManager.shared.lastDate = nil
            VietjetDataManager.shared.firstDate = date
            VietjetDataManager.shared.datesRange = [VietjetDataManager.shared.firstDate!]

            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            for d in VietjetDataManager.shared.datesRange ?? [] {
                calendar.select(d, scrollToDate: false)
            }
            configureVisibleCells()
            calendarDidChange?()
            return
        }
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if VietjetDataManager.shared.firstDate == date {
            VietjetDataManager.shared.lastDate = date
        } else {
            VietjetDataManager.shared.lastDate = nil
        }
        
        VietjetDataManager.shared.firstDate = date
        VietjetDataManager.shared.datesRange = [VietjetDataManager.shared.firstDate!]
        
        for d in calendar.selectedDates {
            calendar.deselect(d)
        }
        for d in VietjetDataManager.shared.datesRange ?? [] {
            calendar.select(d, scrollToDate: false)
        }
        configureVisibleCells()
        calendarDidChange?()
        return
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if date < Calendar.current.startOfDay(for: Date()) {
            return UIColor(white: 0.67, alpha: 2)
        }
        
        return nil
    }
}
