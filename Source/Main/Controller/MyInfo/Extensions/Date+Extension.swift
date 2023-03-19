//
//  Date+Extension.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/27/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

extension Date {
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: self)
    }
    
    func datesRange(from: Date, to: Date) -> [Date] {
        
        if from > to { return [Date]() }
        
        var tempDate = from
        var array = [tempDate]
        
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        
        return array
    }
    
    func getNext7Day() -> Date? {
        return Calendar.current.date(byAdding: .day, value: 7, to: self)
    }
    
    func getDayAfter(date : Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: date, to: self) ?? Date.today()
    }
    
    func getNext30Days(from date: Date = Date.today()) -> [Date] {
        var dt : [Date] = []
        for i in 1...30 {
            if let d = Calendar.current.date(byAdding: .day, value: i, to: date) {
                dt.append(d)
            }
        }
        return dt
    }
    
    func getDateFormString(str : String, strFormat : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strFormat //Your date format
        //        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        //according to date format your date string
        guard let date = dateFormatter.date(from: str) else {
            return Date.today()
        }
        return date
    }
    
    static func today() -> Date {
        return Date()
    }
    mutating func addDays(n: Int) {
        let cal = Calendar.current
        self = cal.date(byAdding: .day, value: n, to: self)!
    }
    
    func getAllDays() -> [String] {
        var days = [Date]()
        var datesConvert: [String] = []

        let calendar = Calendar.current
        
        let range = calendar.range(of: .day, in: .month, for: self)!
        
        var day = firstDayOfTheMonth()
        
        for _ in 1...range.count {
            days.append(day)
            day.addDays(n: 1)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            //            dateFormatter.dateStyle = .short
            let strDate = dateFormatter.string(from: day)
            datesConvert.append(strDate)
        }
        
        return datesConvert
    }
    
    func firstDayOfTheMonth() -> Date {
        return Calendar.current.date(from:
            Calendar.current.dateComponents([.year,.month], from: self))!
    }
}
