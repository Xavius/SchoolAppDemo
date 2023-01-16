//
//  AttendanceView.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 12.01.2023.
//

import UIKit

class AttendanceView: BaseView {
    // MARK: - Properties
    private let calendarHelper = CalendarHelper()
    private lazy var attendanceData: [Date: AttendanceData] = {
        [
            calendarHelper.makeDate(year: 2018, month: 11, day: 8): AttendanceData(isAbsent: true,
                                                                                   isHoliday: false),
            calendarHelper.makeDate(year: 2018, month: 11, day: 20): AttendanceData(isAbsent: false,
                                                                                   isHoliday: true),
            calendarHelper.makeDate(year: 2018, month: 11, day: 23): AttendanceData(isAbsent: true,
                                                                                   isHoliday: false)
        ]
    }()
    private let calendarView: CalendarView = {
        let view = CalendarView()
        return view
    }()
}

// MARK: - BaseViewProtocol
extension AttendanceView {
    override func setupViews() {
        super.setupViews()
        addView(calendarView)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: topAnchor, constant: 29),
            calendarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17),
            calendarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }

    override func configureView() {
        super.configureView()
        calendarView.setup(with: calendarHelper.makeDate(year: 2018, month: 11, day: 1),
                           and: attendanceData)
    }
}
