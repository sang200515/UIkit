//
//  CalendarViewController.swift
//  fptshop
//
//  Created by Apple on 1/23/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol CalendarViewController1Delegate: AnyObject {
    func getDate1(dateString: String)
}

class CalendarViewController1: UIViewController {
    
    var datePicker: UIDatePicker!
    var btnGetDate: UIButton!
    weak var delegate: CalendarViewController1Delegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame.size = CGSize(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.4)
        self.view.layer.cornerRadius = 8
//        self.view.backgroundColor = UIColor(red: 142/255, green: 221/255, blue: 104/255 , alpha: 1)
        self.view.backgroundColor = UIColor.white
        
        datePicker = UIDatePicker(frame: CGRect(x: 20, y: 30, width: self.view.frame.width - 40, height: self.view.frame.width * 0.4))
        self.view.addSubview(datePicker)
        datePicker.datePickerMode = .date
        datePicker.locale = Locale.init(identifier: "vie")
        
        btnGetDate = UIButton(frame: CGRect(x: (self.view.frame.width/2) - 70, y: datePicker.frame.origin.y + datePicker.frame.height + 20, width: 140, height: 40))
        btnGetDate.backgroundColor = UIColor(red: 44/255, green: 171/255, blue: 110/255, alpha: 1)
        btnGetDate.setTitle("CHỌN", for: .normal)
        btnGetDate.titleLabel!.font = UIFont.boldSystemFont(ofSize: 15)
        btnGetDate.layer.cornerRadius = 8
        self.view.addSubview(btnGetDate)
        btnGetDate.addTarget(self, action: #selector(getDate), for: .touchUpInside)
        
    }
    
    @objc func getDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        print("selectedDate",selectedDate)
        self.dismiss(animated: true) {
            self.delegate?.getDate1(dateString: selectedDate)
        }
    }
    
    

}
