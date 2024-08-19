//
//  Date+Extension.swift
//  SwiftuiCalendar
//
//  Created by Eric on 18/08/2024.
//

import Foundation

extension Date {
    static var capitalizedFirstLetterOfWeekdays: [String] {
        let calendar = Calendar.current
        let weekdays = calendar.shortWeekdaySymbols

        return weekdays.map { weekday in
//            guard let firstLetter = weekday.first else { return "" }
//            return String(firstLetter).capitalized
            let firstThreeLetters = weekday.prefix(3)
            return String(firstThreeLetters).uppercased()
        }
    }

    static var fullMonthNames: [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current

        return (1...12).compactMap { month in
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
            let date = Calendar.current.date(from: DateComponents(year: 2000, month: month, day: 1))
            return date.map { dateFormatter.string(from: $0) }
        }
    }

    var currentMonth: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"

        return dateFormatter.string(from: date)
    }

//    var nextMonth: String {
//        let date = Date()
//        let nextMonthDate = Calendar.current.date(byAdding: .month, value: 1, to: date)!
//        let dateFormatter = DateFormatter()
//
//        dateFormatter.dateFormat = "MMMM yyyy"
//        return dateFormatter.string(from: nextMonthDate)
//    }

//    var previousMonth: String {
//        let date = Date()
//        let nextMonthDate = Calendar.current.date(byAdding: .month, value: -1, to: date)!
//        let dateFormatter = DateFormatter()
//
//        dateFormatter.dateFormat = "MMMM yyyy"
//        return dateFormatter.string(from: nextMonthDate)
//    }

    var nextMonth: Date {
        let date = Date()
        return Calendar.current.date(byAdding: .month, value: 1, to: date)!
    }

    var previousMonth: Date {
        let date = Date()
        return Calendar.current.date(byAdding: .month, value: -1, to: date)!
    }

    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }

    var endOfMonth: Date {
        let lastDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }

    var startOfPreviousMonth: Date {
        let dayInPreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInPreviousMonth.startOfMonth
    }

    var numberOfDaysInMonth: Int {
        Calendar.current.component(.day, from: endOfMonth)
    }

    var sundayBeforeStart: Date {
        let startOfMonthWeekDay = Calendar.current.component(.weekday, from: startOfMonth)
        let numberFromPreviousMonth = startOfMonthWeekDay - 1
        return Calendar.current.date(byAdding: .day, value: -numberFromPreviousMonth, to: startOfMonth)!
    }

    var calendarDisplayDays: [Date] {
        var days: [Date] = []
        // Current month days
        for dayOffset in 0..<numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfMonth)
            days.append(newDay!)
        }
        // Previous month days
        for dayOffset in 0..<startOfPreviousMonth.numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfPreviousMonth)
            days.append(newDay!)
        }

        return days.filter { $0 >= sundayBeforeStart && $0 <= endOfMonth }.sorted(by: <)
    }

    var monthInt: Int {
        Calendar.current.component(.month, from: self)
    }

    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}
