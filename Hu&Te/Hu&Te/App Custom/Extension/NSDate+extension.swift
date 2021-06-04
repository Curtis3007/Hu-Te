//
//  NSDate+extension.swift
//  Hu&Te
//
//  Created by BigSur on 03/06/2021.
//

import Foundation


extension Date {
    
    func postDetailPresenter() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        let day = formatter.string(from: self)
        let daySuffix = self.daySuffix()
        formatter.dateFormat = "MMMM"
        let month = formatter.string(from: self)
        return "\(day)\(daySuffix) \(month)"
    }
    
    func daySuffix() -> String {
        let calendar = Calendar.current
        let dayOfMonth = (calendar as NSCalendar).component(.day, from: self)
        switch dayOfMonth {
        case 1: fallthrough
        case 21: fallthrough
        case 31: return "st"
        case 2: fallthrough
        case 22: return "nd"
        case 3: fallthrough
        case 23: return "rd"
        default: return "th"
        }
    }
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        return formatter.string(from: self)
    }
    
    func toStringDayMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: self)
    }

    func toLocalTime() -> Date {
        let timezone: TimeZone = TimeZone.autoupdatingCurrent
        let seconds: TimeInterval = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func dateISO8601() -> String {
        let dateFormatter = DateFormatter()
        //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "UTC+08:00")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter.string(from: self)
    }
    
    func dateStringISO8601() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter.string(from: self)
    }
    
    func getNextHour(value: Int) -> Date {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .minute, value: value * 60, to: self)
        return date ?? Date()
    }
    
    func toStringDayMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy"
        return formatter.string(from: self)
    }
    
    func toDayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM"
        return formatter.string(from: self)
    }
    
    func toDayStringBlueSky() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd, MMM YYYY"
        return formatter.string(from: self)
    }
    
    func toDayStringYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM YYYY"
        return formatter.string(from: self)
    }
    
    func toDayPostedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: self)
    }
    
    
    func toStringDate(format: String) -> String {
           let formatter = DateFormatter()
           formatter.dateFormat = format
           return formatter.string(from: self)
    }
    
    func toTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mma"
        //let result = formatter.string(from: self)
//        if result.contains(":00") {
//            formatter.dateFormat = "ha"
//        }
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }
    
    func dateToString() -> String {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd"
           return formatter.string(from: self)
    }
    
    func toNewDateISO8601() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC+08:00")
        formatter.dateFormat = "dd MMM yyy, h:mm a"
        return formatter.string(from: self)
    }
    
//    func toBlueSkyTime() -> String {
//        let formatter = DateFormatter()
//        //formatter.timeZone = TimeZone(identifier: "UTC+08:00")
//        formatter.dateFormat = "h:mm ddd, MMM yyy"
//        return formatter.string(from: self)
//    }
    
    func toFormatDaySuffix() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        let day = formatter.string(from: self)
        var suffix = ""
        switch day {
        case "1","21","31": suffix = "st"
        case "2","22": suffix = "nd"
        case "3","23": suffix = "rd"
        default: suffix = "th"
        }
        formatter.dateFormat = "EEE, d'\(suffix)' MMMM yyyy"
        return formatter.string(from: self)
    }
   
    func toPeriodString(comma: Bool = true) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC+08:00")
        if comma {
            formatter.dateFormat = "dd MMM, yyyy"
        } else {
            formatter.dateFormat = "dd MMM yyyy"
        }
        return formatter.string(from: self)
    }
    
}
extension Date {

    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }

    func isInSameYear(as date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
    func isInSameMonth(as date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
    func isInSameWeek(as date: Date) -> Bool { isEqual(to: date, toGranularity: .weekOfYear) }

    func isInSameDay(as date: Date) -> Bool { Calendar.current.isDate(self, inSameDayAs: date) }

    var isInThisYear:  Bool { isInSameYear(as: Date()) }
    var isInThisMonth: Bool { isInSameMonth(as: Date()) }
    var isInThisWeek:  Bool { isInSameWeek(as: Date()) }

    var isInYesterday: Bool { Calendar.current.isDateInYesterday(self) }
    var isInToday:     Bool { Calendar.current.isDateInToday(self) }
    var isInTomorrow:  Bool { Calendar.current.isDateInTomorrow(self) }

    //var isInTheFuture: Bool { self > Date() }
    //var isInThePast:   Bool { self < Date() }
    
    func isSameDate(_ comparisonDate: Date) -> Bool {
        let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
        return order == .orderedSame
    }
    
    func isBeforeDate(_ comparisonDate: Date) -> Bool {
        let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
        
        return order == .orderedAscending
    }
    
    func isAfterDate(_ comparisonDate: Date) -> Bool {
        let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
        return order == .orderedDescending
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date? {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)
    }
}

extension Calendar {
    func getFirstDayOfWeek() -> Date {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar.date(from: calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: Date()))!
    }
}
