//
//  CalendarView.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 16.01.2023.
//

import UIKit

class CalendarView: BaseView {
    // MARK: - Properties
    private let calendarHelper = CalendarHelper()
    private var activeMonthDate: Date? {
        didSet {
            if let date = activeMonthDate {
                monthYearLabel.text = "\(calendarHelper.monthString(date: date).uppercased()) \(calendarHelper.yearString(date: date))"
                monthView.setup(from: date)
            }
        }
    }
    private let prevMonthButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.backward")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .saTitleGrey2
        return button
    }()
    private let nextMonthButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.forward")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .saTitleGrey2
        return button
    }()
    private let monthYearLabel: UILabel = {
        let label = UILabel()
        label.font = .sourceSansPro(with: .semiBold, and: 15)
        label.textColor = .saTitleGrey2
        return label
    }()
    private let monthView: MonthView = {
        let view = MonthView()
        return view
    }()

    // MARK: - Public Methods
    func setup(with date: Date?, and attendanceData: [Date: AttendanceData]) {
        self.monthView.initialSetup(from: date, with: attendanceData)
        self.activeMonthDate = date
    }
}

// MARK: - BaseViewProtocol
extension CalendarView: UICollectionViewDelegateFlowLayout {
    override func setupViews() {
        super.setupViews()
        addView(prevMonthButton)
        addView(monthYearLabel)
        addView(nextMonthButton)
        addView(monthView)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            monthYearLabel.topAnchor.constraint(equalTo: topAnchor),
            monthYearLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            prevMonthButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            prevMonthButton.centerYAnchor.constraint(equalTo: monthYearLabel.centerYAnchor),

            nextMonthButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nextMonthButton.centerYAnchor.constraint(equalTo: monthYearLabel.centerYAnchor),

            monthView.topAnchor.constraint(equalTo: monthYearLabel.bottomAnchor, constant: 32),
            monthView.leadingAnchor.constraint(equalTo: leadingAnchor),
            monthView.trailingAnchor.constraint(equalTo: trailingAnchor),

            bottomAnchor.constraint(equalTo: monthView.bottomAnchor)
        ])
    }

    override func configureView() {
        super.configureView()
        prevMonthButton.addTarget(self, action: #selector(switchPrevMonth), for: .touchUpInside)
        nextMonthButton.addTarget(self, action: #selector(switchNextMonth), for: .touchUpInside)
    }
}

// MARK: - Button Events
@objc extension CalendarView {
    func switchPrevMonth() {
        activeMonthDate = calendarHelper.prevMonth(from: activeMonthDate)
    }

    func switchNextMonth() {
        activeMonthDate = calendarHelper.nextMonth(from: activeMonthDate)
    }
}
