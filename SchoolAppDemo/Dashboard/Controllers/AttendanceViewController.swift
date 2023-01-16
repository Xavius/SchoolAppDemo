//
//  AttendanceViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 07.01.2023.
//

import UIKit

class AttendanceViewController: BaseViewController {
    // MARK: - Properties
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
    }
}
