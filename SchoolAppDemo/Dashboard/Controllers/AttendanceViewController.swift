//
//  AttendanceViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 07.01.2023.
//

import UIKit

class AttendanceViewController: BaseViewController {
    let testLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello from Attendance!"
        return label
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Attendance"
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.title = "Attendance"
    }
}

extension AttendanceViewController {
    override func setupViews() {
        view.addView(testLabel)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            testLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
