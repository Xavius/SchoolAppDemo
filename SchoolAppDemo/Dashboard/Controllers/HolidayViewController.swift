//
//  HolidayViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 12.01.2023.
//

import UIKit

class HolidayViewController: BaseViewController {
    let testLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello from Holiday!"
        return label
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Holiday"
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.title = "Holiday"
    }
}

extension HolidayViewController {
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
