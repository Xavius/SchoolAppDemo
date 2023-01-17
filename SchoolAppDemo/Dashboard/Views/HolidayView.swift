//
//  HolidayView.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 16.01.2023.
//

import UIKit

struct HolidayInfo {
    let date: Date?
    let title: String
}

class HolidayView: BaseView {
    // MARK: - Properties
    private let calendarHelper = CalendarHelper()
    private var holidaysData: [HolidayInfo] = []
    private var activeMonthData: [HolidayInfo] = []
    private lazy var calendarView: CalendarView = {
        let view = CalendarView()
        view.delegate = self
        return view
    }()
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(HolidayTableViewCell.self,
                      forCellReuseIdentifier: HolidayTableViewCell.identifier)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.allowsSelection = false
        view.showsVerticalScrollIndicator = false
        return view
    }()

    // MARK: - Public Methods
    func setup(withDate date: Date, holidaysData: [HolidayInfo]) {
        self.holidaysData = holidaysData
        let daysData = holidaysData.reduce(into: [Date: DayCellType]()) { partialResult, info in
            if let date = info.date {
                partialResult[date] = DayCellType.holiday
            }
        }
        self.calendarView.setup(with: date, and: daysData)
    }
}

// MARK: - BaseViewProtocol
extension HolidayView {
    override func setupViews() {
        super.setupViews()
        addView(calendarView)
        addView(tableView)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: topAnchor, constant: 29),
            calendarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17),
            calendarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),

            tableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 25),
            tableView.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    override func configureView() {
        super.configureView()
    }
}

// MARK: - CalendarViewDelegate
extension HolidayView: CalendarViewDelegate {
    func activeMonthChanged(month: Date?, direction: MonthChangeDirection) {
        activeMonthData.removeAll()
        activeMonthData = holidaysData.filter { element in
            return calendarHelper.isSameMonth(date1: month, date2: element.date)
        }
        var rowAnimation: UITableView.RowAnimation = .none
        switch direction {
            case .toNext:
                rowAnimation = .left
            case .toPrevious:
                rowAnimation = .right
            default: break
        }
        DispatchQueue.main.schedule {
            self.tableView.reloadSections(IndexSet(integer: 0), with: rowAnimation)
        }
    }
}

// MARK: - UITableViewDelegate
extension HolidayView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
}

// MARK: - UITableViewDataSource
extension HolidayView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeMonthData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HolidayTableViewCell.identifier,
                                                 for: indexPath) as! HolidayTableViewCell
        let info = activeMonthData[indexPath.row]
        cell.setup(withTitle: info.title, andDate: info.date)
        return cell
    }
}
