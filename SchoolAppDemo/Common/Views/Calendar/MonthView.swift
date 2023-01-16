//
//  MonthView.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 13.01.2023.
//

import UIKit

struct DayInfo {
    let date: Date?
    let isCurrentMonth: Bool
}

struct AttendanceData {
    let isAbsent: Bool
    let isHoliday: Bool
}

class MonthView: BaseView {
    // MARK: - Properties
    private let calendarHelper = CalendarHelper()
    private var attendanceData: [Date: AttendanceData] = [:]
    private var totalDays: [DayInfo] = []
    private var initialDate: Date? {
        didSet {
            if let date = initialDate {
                totalDays.removeAll()
                let daysInMonth = calendarHelper.daysInMonth(date: date)
                let firstDayOfMonth = calendarHelper.firstOfMonth(date: date)
                let startingSpaces = calendarHelper.weekDay(date: firstDayOfMonth)
                let prevMonth = calendarHelper.prevMonth(from: date) ?? date
                let daysInPrevMonth = calendarHelper.daysInMonth(date: prevMonth)
                let nextMonth = calendarHelper.nextMonth(from: date) ?? date
                var count = 1
                while (count <= 42) {
                    var day: Date?
                    var isCurrentMonth = true
                    if count <= startingSpaces {
                        day = calendarHelper.dayInMonth(month: prevMonth,
                                                        day: daysInPrevMonth - startingSpaces + count)
                        isCurrentMonth = false
                    } else if count - startingSpaces > daysInMonth {
                        day = calendarHelper.dayInMonth(month: nextMonth,
                                                        day: count - startingSpaces - daysInMonth)
                        isCurrentMonth = false
                    } else {
                        day = calendarHelper.dayInMonth(month: firstDayOfMonth,
                                                        day: count - startingSpaces)
                    }
                    totalDays.append(DayInfo(date: day, isCurrentMonth: isCurrentMonth))

                    count += 1
                }
                daysTable.reloadData()
            }
        }
    }
    private lazy var tableHeader: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        for i in 1...7 {
            let weekDay = shortWeekDay(by: i)
            let label = UILabel()
            label.text = weekDay
            label.font = .sourceSansPro(with: .regular, and: 12)
            label.textColor = .saTitleGrey2
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
        }
        return stackView
    }()
    private let daysTable: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()

    // MARK: - Public Methods
    func setup(from date: Date?) {
        self.initialDate = date
    }

    func initialSetup(from date: Date?, with attendanceData: [Date: AttendanceData]) {
        self.initialDate = date
        self.attendanceData = attendanceData
    }

    // MARK: - Private Methods
    private func shortWeekDay(by index: Int) -> String {
        let weekDayIndex = (calendarHelper.calendar.firstWeekday - 1) + (index - 1)
        return calendarHelper.calendar.shortStandaloneWeekdaySymbols[weekDayIndex % 7]
    }
}

// MARK: - BaseViewProtocol
extension MonthView {
    override func setupViews() {
        super.setupViews()
        addView(tableHeader)
        addView(daysTable)
        daysTable.register(DayViewCell.self, forCellWithReuseIdentifier: DayViewCell.identifier)
        daysTable.delegate = self
        daysTable.dataSource = self
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            tableHeader.topAnchor.constraint(equalTo: topAnchor),
            tableHeader.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableHeader.trailingAnchor.constraint(equalTo: trailingAnchor),

            daysTable.topAnchor.constraint(equalTo: tableHeader.bottomAnchor, constant: 12),
            daysTable.leadingAnchor.constraint(equalTo: leadingAnchor),
            daysTable.trailingAnchor.constraint(equalTo: trailingAnchor),
            daysTable.heightAnchor.constraint(equalTo: daysTable.widthAnchor, multiplier: 6/7),

            bottomAnchor.constraint(equalTo: daysTable.bottomAnchor)
        ])
    }

    override func configureView() {
        super.configureView()
        daysTable.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension MonthView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalDays.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayViewCell.identifier,
                                                      for: indexPath) as! DayViewCell
        let dayInfo = totalDays[indexPath.item]
        var cellType: DayViewCellType = .normal
        if calendarHelper.isWeekend(date: dayInfo.date) {
            cellType = .weekend
        } else if dayInfo.isCurrentMonth {
            if let date = dayInfo.date {
                let dayData = attendanceData.first { (key: Date, _: AttendanceData) in
                    return calendarHelper.isSameDate(date1: date, date2: key)
                }?.value
                if let dayData = dayData {
                    if dayData.isHoliday {
                        cellType = .holiday
                    } else if dayData.isAbsent {
                        cellType = .absence
                    }
                }
            }
        }

        cell.setup(with: dayInfo.date,
                   isCurrentMonth: dayInfo.isCurrentMonth,
                   cellType: cellType)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MonthView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
