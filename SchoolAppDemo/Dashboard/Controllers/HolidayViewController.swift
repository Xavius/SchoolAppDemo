//
//  HolidayViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 12.01.2023.
//

import UIKit

class HolidayViewController: BaseViewController {
    // MARK: - Properties
    private let calendarHelper = CalendarHelper()
    private lazy var holidaysData: [HolidayInfo] = {
        [
            .init(date: calendarHelper.makeDate(year: 2018, month: 11, day: 14),
                  title: "Diwali"),
            .init(date: calendarHelper.makeDate(year: 2018, month: 11, day: 15),
                  title: "Govardhan Puja"),
            .init(date: calendarHelper.makeDate(year: 2018, month: 11, day: 16),
                  title: "Bhaiya Dooj"),
        ]
    }()
    let holidayView: HolidayView = {
        let view = HolidayView()
        return view
    }()

    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Holiday"
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.title = "Holiday"
    }
}

// MARK: - BaseViewProtocol
extension HolidayViewController {
    override func setupViews() {
        view.addView(holidayView)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            holidayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 33),
            holidayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            holidayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            holidayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    override func configureView() {
        super.configureView()
        holidayView.setup(withDate: calendarHelper.makeDate(year: 2018, month: 11, day: 1),
                          holidaysData: holidaysData)
    }
}
