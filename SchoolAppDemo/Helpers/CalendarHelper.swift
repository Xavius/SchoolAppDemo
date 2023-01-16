//
//  CalendarHelper.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 16.01.2023.
//

import Foundation

class CalendarHelper {
    let calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2
        return calendar
    }()

    func nextMonth(from date: Date?) -> Date? {
        guard let date = date else { return nil }
        return calendar.date(byAdding: .month, value: 1, to: date)
    }

    func prevMonth(from date: Date?) -> Date? {
        guard let date = date else { return nil }
        return calendar.date(byAdding: .month, value: -1, to: date)
    }

    func monthString(date: Date?) -> String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date).capitalized
    }

    func yearString(date: Date?) -> String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: date)
    }

    func daysInMonth(date: Date?) -> Int {
        guard let date = date else { return 0 }
        let range = calendar.range(of: .day, in: .month, for: date)
        return range?.count ?? 0
    }

    func dayOfMonth(date: Date?) -> Int {
        guard let date = date else { return 0 }
        let components = calendar.dateComponents([.day], from: date)
        return components.day ?? 0
    }

    func dayInMonth(month: Date?, day: Int) -> Date? {
        let firstDay = firstOfMonth(date: month)
        guard let firstDay = firstDay else { return nil }
        var components = calendar.dateComponents([.month, .year], from: firstDay)
        components.day = day
        return calendar.date(from: components)
    }

    func firstOfMonth(date: Date?) -> Date? {
        guard let date = date else { return nil }
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)
    }

    func weekDay(date: Date?) -> Int {
        guard let date = date else { return 0 }
        let components = calendar.dateComponents([.day, .month, .year, .weekday], from: date)
        var weekDay = (((components.weekday ?? 1) - 1) - (calendar.firstWeekday - 1))
        if weekDay < 0 {
            weekDay += 7
        }
        return weekDay
    }

    func isWeekend(date: Date?) -> Bool {
        guard let date = date else { return false }
        return calendar.isDateInWeekend(date)
    }

    func isSameDate(date1: Date?, date2: Date?) -> Bool {
        guard let date1 = date1, let date2 = date2 else { return false }
        let components1 = calendar.dateComponents([.day, .month, .year], from: date1)
        let components2 = calendar.dateComponents([.day, .month, .year], from: date2)
        return (components1.year == components2.year &&
                components1.month == components2.month &&
                components1.day == components2.day)
    }

    func makeDate(year: Int, month: Int, day: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents)!
    }
}
