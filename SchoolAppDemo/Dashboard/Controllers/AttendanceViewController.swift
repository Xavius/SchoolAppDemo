//
//  AttendanceViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 07.01.2023.
//

import UIKit

class AttendanceViewController: BaseViewController {
    // MARK: - Properties
    private let calendarHelper = CalendarHelper()
    private lazy var attendanceData: [Date: DayCellType] = {
        [
            calendarHelper.makeDate(year: 2018, month: 12, day: 14): .absence,
            calendarHelper.makeDate(year: 2018, month: 12, day: 19): .holiday,
            calendarHelper.makeDate(year: 2018, month: 12, day: 6): .absence,
            calendarHelper.makeDate(year: 2018, month: 11, day: 8): .absence,
            calendarHelper.makeDate(year: 2018, month: 11, day: 20): .holiday,
            calendarHelper.makeDate(year: 2018, month: 11, day: 23): .absence,
            calendarHelper.makeDate(year: 2018, month: 10, day: 5): .absence,
            calendarHelper.makeDate(year: 2018, month: 10, day: 12): .holiday,
            calendarHelper.makeDate(year: 2018, month: 10, day: 18): .absence,
        ]
    }()
    let attendanceView: AttendanceView = {
        let view = AttendanceView()
        return view
    }()

    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Attendance"
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.title = "Attendance"
    }
}

// MARK: - BaseViewProtocol
extension AttendanceViewController {
    override func setupViews() {
        view.addView(attendanceView)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            attendanceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 33),
            attendanceView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            attendanceView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            attendanceView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    override func configureView() {
        super.configureView()
        attendanceView.setup(withDate: calendarHelper.makeDate(year: 2018, month: 11, day: 1),
                             attendanceData: attendanceData)
    }
}
