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
    private var activeMonthData: [DayCellType: Int] = [:]
    private let supportedCellTypes: [DayCellType] = [.absence, .holiday]
    private var attendanceData: [Date: DayCellType] = [:]
    private lazy var calendarView: CalendarView = {
        let view = CalendarView()
        view.delegate = self
        return view
    }()
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(AttendanceTableViewCell.self,
                      forCellReuseIdentifier: AttendanceTableViewCell.identifier)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.allowsSelection = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    // MARK: - Public Methods
    func setup(withDate date: Date, attendanceData: [Date: DayCellType]) {
        self.attendanceData = attendanceData
        self.calendarView.setup(with: date, and: attendanceData)
    }
}

// MARK: - BaseViewProtocol
extension AttendanceView {
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

// MARK: - UITableViewDelegate
extension AttendanceView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
}

// MARK: - UITableViewDataSource
extension AttendanceView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(supportedCellTypes.count, activeMonthData.count)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AttendanceTableViewCell.identifier,
                                                 for: indexPath) as! AttendanceTableViewCell
        let cellType = supportedCellTypes[indexPath.row]
        var cellTitle = "Unknown"
        let count = activeMonthData[cellType] ?? 0
        switch cellType {
            case .absence:
                cellTitle = "Absent"
            case .holiday:
                cellTitle = "Festival & Holidays"
            default:
                break
        }
        cell.setup(withTitle: cellTitle, value: count, andType: cellType)
        return cell
    }
}

// MARK: - CalendarViewDelegate
extension AttendanceView: CalendarViewDelegate {
    func activeMonthChanged(month: Date?, direction: MonthChangeDirection) {
        activeMonthData.removeAll()
        activeMonthData = attendanceData.filter { element in
            return calendarHelper.isSameMonth(date1: month, date2: element.key)
        }.map { (_, data) in
            return data
        }.reduce(into: [:], { partialResult, data in
            if [DayCellType.absence, DayCellType.holiday].contains(data) {
                partialResult[data, default: 0] += 1
            }
        })
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
