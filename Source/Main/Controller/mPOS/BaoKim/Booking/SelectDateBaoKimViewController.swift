//
//  SelectDateBaoKimViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 17/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import FSCalendar

class SelectDateBaoKimViewController: UIViewController {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbMonth: UILabel!
    @IBOutlet weak var vCalendar: FSCalendar!
    
    var selectedDate: Date = Date()
    var didSelectDate: ((Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let monthString = "Tháng \(Date().stringWith(format: "M, yyyy"))"
        lbMonth.text = monthString
        
        vCalendar.delegate = self
        vCalendar.dataSource = self
        vCalendar.today = nil
        vCalendar.select(selectedDate, scrollToDate: true)
        
        vBackground.roundCorners(.allCorners, radius: 5)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension SelectDateBaoKimViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if date < Calendar.current.startOfDay(for: Date()) {
            return false
        }
        
        return true
    }
    
    // MARK:- FSCalendarDelegate
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        didSelectDate?(date)
        dismiss(animated: true, completion: nil)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if date < Calendar.current.startOfDay(for: Date()) {
            return UIColor(white: 0.67, alpha: 2)
        }
        
        return nil
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let monthString = "Tháng \(calendar.currentPage.stringWith(format: "M, yyyy"))"
        lbMonth.text = monthString
    }
}
