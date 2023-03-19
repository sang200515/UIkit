//
//  SelectVietjetFlightDateViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 22/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class SelectVietjetFlightDateViewController: UIViewController {

    @IBOutlet weak var vFromDate: UIView!
    @IBOutlet weak var lbFromDate: UILabel!
    @IBOutlet weak var vToDate: UIView!
    @IBOutlet weak var lbToDate: UILabel!
    @IBOutlet weak var vTableBackground: UIView!
    @IBOutlet weak var tbvCalendar: UITableView!
    @IBOutlet weak var btnContinue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        title = "Chọn ngày"
        addBackButton()
        
        vFromDate.roundCorners(.allCorners, radius: 10)
        vToDate.roundCorners(.allCorners, radius: 10)
        vTableBackground.roundCorners(.allCorners, radius: 10)
        btnContinue.roundCorners(.allCorners, radius: 5)
        
        VietjetDataManager.shared.firstDate = VietjetDataManager.shared.selectedFirstDate
        VietjetDataManager.shared.lastDate = VietjetDataManager.shared.selectedLastDate
        if VietjetDataManager.shared.isOneWay {
            VietjetDataManager.shared.datesRange = [VietjetDataManager.shared.firstDate!]
        } else {
            VietjetDataManager.shared.datesRange = VietjetDataManager.shared.lastDate != nil ? datesRange(from: VietjetDataManager.shared.firstDate!, to: VietjetDataManager.shared.lastDate!) : [VietjetDataManager.shared.firstDate!]
        }
        
        lbFromDate.text = VietjetDataManager.shared.firstDate?.stringWith(format: "dd/MM/yyyy")
        lbToDate.text = VietjetDataManager.shared.lastDate?.stringWith(format: "dd/MM/yyyy")
        
        vToDate.isHidden = VietjetDataManager.shared.isOneWay
    }
    
    private func setupTableView() {
        tbvCalendar.registerTableCell(VietjetCalendarTableViewCell.self)
        tbvCalendar.estimatedRowHeight = 100
        tbvCalendar.rowHeight = UITableView.automaticDimension
        
        let date = Date()
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: date)
        let selectedMonth = calendar.component(.month, from: VietjetDataManager.shared.selectedFirstDate)
        tbvCalendar.scrollToRow(at: IndexPath(row: selectedMonth - currentMonth, section: 0), at: .middle, animated: false)
    }
    
    private func datesRange(from: Date, to: Date) -> [Date] {
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
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        if !VietjetDataManager.shared.isOneWay && VietjetDataManager.shared.lastDate == nil {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn đầy đủ thông tin ngày đi/về", titleButton: "OK")
            return
        }
        
        VietjetDataManager.shared.selectedFirstDate = VietjetDataManager.shared.firstDate ?? Date()
        VietjetDataManager.shared.selectedLastDate = VietjetDataManager.shared.lastDate
        
        navigationController?.popViewController(animated: true)
    }
}

extension SelectVietjetFlightDateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(VietjetCalendarTableViewCell.self)
        cell.setupCell(index: indexPath.row)
        cell.calendarDidChange = {
            DispatchQueue.main.async {
                self.tbvCalendar.reloadData()
                self.lbFromDate.text = VietjetDataManager.shared.firstDate?.stringWith(format: "dd/MM/yyyy")
                self.lbToDate.text = VietjetDataManager.shared.lastDate?.stringWith(format: "dd/MM/yyyy")
            }
        }
        return cell
    }
}
